#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <string.h>
#include <slang.h>

static void (*real_newtDrawBox)(int, int, int, int, int) = NULL;
static void (*real_SLsmg_draw_object)(int, int, SLwchar_Type) = NULL;
static void (*real_SLsmg_write_char)(SLwchar_Type) = NULL;
static void (*real_SLsmg_write_string)(SLFUTURE_CONST char *) = NULL;
static void (*real_SLsmg_fill_region)(int, int, unsigned int, unsigned int, SLwchar_Type) = NULL;
static void (*real_SLsmg_set_color)(SLsmg_Color_Type) = NULL;

static SLsmg_Color_Type current_color = 0;
static int corner_style = 1;   // 1 = sharp blocky (┌ ┐ └ ┘) by default, 0 = rounded, 2 = double
static char btn_open = '[';
static char btn_close = ']';
static int remove_shadow = 1;
static int initialized = 0;

static const char *DARK_PALETTE =
    "root=white,black;"
    "border=lightgray,black;"
    "window=white,black;"
    "shadow=black,black;"
    "title=brightcyan,black;"
    "button=white,black;"
    "actbutton=black,brightcyan;"
    "compactbutton=white,black;"
    "checkbox=white,black;"
    "actcheckbox=black,brightcyan;"
    "entry=brightwhite,gray;"
    "label=white,black;"
    "listbox=white,black;"
    "actlistbox=white,black;"
    "sellistbox=white,gray;"
    "actsellistbox=black,brightcyan;"
    "textbox=white,black;"
    "acttextbox=black,brightcyan;"
    "helpline=lightgray,black;"
    "roottext=lightgray,black;"
    "emptyscale=gray,black;"
    "fullscale=brightcyan,black;"
    "disentry=gray,black";

static void init_settings(void) {
    if (initialized) return;
    initialized = 1;

    // Apply high-contrast dark palette if NEWT_COLORS is not set
    if (!getenv("NEWT_COLORS")) {
        setenv("NEWT_COLORS", DARK_PALETTE, 1);
    }

    // Corner style: sharp (default, blocky), rounded, double
    const char *env_corners = getenv("NMTUI_CORNERS");
    if (env_corners) {
        if (strcmp(env_corners, "rounded") == 0) {
            corner_style = 0;
        } else if (strcmp(env_corners, "double") == 0) {
            corner_style = 2;
        } else {
            corner_style = 1; // default sharp
        }
    } else {
        corner_style = 1; // default sharp blocky
    }

    // Button style: bracket (default, blocky), round, clean, angle
    const char *env_btn = getenv("NMTUI_BUTTON");
    if (env_btn) {
        if (strcmp(env_btn, "round") == 0) {
            btn_open = '(';
            btn_close = ')';
        } else if (strcmp(env_btn, "clean") == 0) {
            btn_open = ' ';
            btn_close = ' ';
        } else if (strcmp(env_btn, "angle") == 0) {
            btn_open = '<';
            btn_close = '>';
        } else {
            btn_open = '[';
            btn_close = ']';
        }
    } else {
        btn_open = '[';
        btn_close = ']';
    }

    // Shadow toggle: default 0 (removed)
    const char *env_shadow = getenv("NMTUI_SHADOW");
    if (env_shadow && strcmp(env_shadow, "1") == 0) {
        remove_shadow = 0;
    } else {
        remove_shadow = 1;
    }
}

__attribute__((constructor))
static void ctor(void) {
    init_settings();
}

void newtDrawBox(int left, int top, int width, int height, int shadow) {
    init_settings();
    if (!real_newtDrawBox) real_newtDrawBox = dlsym(RTLD_NEXT, "newtDrawBox");
    if (real_newtDrawBox) {
        real_newtDrawBox(left, top, width, height, remove_shadow ? 0 : shadow);
    }
}

void SLsmg_set_color(SLsmg_Color_Type color) {
    current_color = color;
    if (!real_SLsmg_set_color) real_SLsmg_set_color = dlsym(RTLD_NEXT, "SLsmg_set_color");
    if (real_SLsmg_set_color) real_SLsmg_set_color(color);
}

void SLsmg_fill_region(int r, int c, unsigned int nrows, unsigned int ncols, SLwchar_Type ch) {
    init_settings();
    // 5 is NEWT_COLORSET_SHADOW
    if (remove_shadow && current_color == 5) {
        return; // Suppress shadow blocks
    }
    if (!real_SLsmg_fill_region) real_SLsmg_fill_region = dlsym(RTLD_NEXT, "SLsmg_fill_region");
    if (real_SLsmg_fill_region) real_SLsmg_fill_region(r, c, nrows, ncols, ch);
}

void SLsmg_draw_object(int r, int c, SLwchar_Type obj) {
    init_settings();
    if (remove_shadow && current_color == 5) return;

    if (!real_SLsmg_draw_object) real_SLsmg_draw_object = dlsym(RTLD_NEXT, "SLsmg_draw_object");
    if (!real_SLsmg_write_string) real_SLsmg_write_string = dlsym(RTLD_NEXT, "SLsmg_write_string");

    if (corner_style == 0) { // Rounded
        switch (obj) {
            case 'l': // ULCORN
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("╭");
                return;
            case 'k': // URCORN
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("╮");
                return;
            case 'm': // LLCORN
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("╰");
                return;
            case 'j': // LRCORN
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("╯");
                return;
        }
    } else if (corner_style == 2) { // Double border
        switch (obj) {
            case 'l':
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("╔");
                return;
            case 'k':
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("╗");
                return;
            case 'm':
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("╚");
                return;
            case 'j':
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("╝");
                return;
            case 'q': // HLINE
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("═");
                return;
            case 'x': // VLINE
                SLsmg_gotorc(r, c);
                real_SLsmg_write_string("║");
                return;
        }
    }

    real_SLsmg_draw_object(r, c, obj);
}

void SLsmg_write_char(SLwchar_Type ch) {
    init_settings();
    if (remove_shadow && current_color == 5) return;
    if (!real_SLsmg_write_char) real_SLsmg_write_char = dlsym(RTLD_NEXT, "SLsmg_write_char");

    if (ch == '<') {
        real_SLsmg_write_char((SLwchar_Type)btn_open);
    } else if (ch == '>') {
        real_SLsmg_write_char((SLwchar_Type)btn_close);
    } else {
        real_SLsmg_write_char(ch);
    }
}

void SLsmg_write_string(SLFUTURE_CONST char *str) {
    init_settings();
    if (remove_shadow && current_color == 5) return;
    if (!real_SLsmg_write_string) real_SLsmg_write_string = dlsym(RTLD_NEXT, "SLsmg_write_string");
    if (!str) return;

    if (btn_open != '<' && (strchr(str, '<') || strchr(str, '>'))) {
        char buf[512];
        size_t len = strlen(str);
        if (len < sizeof(buf)) {
            for (size_t i = 0; i < len; i++) {
                if (str[i] == '<') buf[i] = btn_open;
                else if (str[i] == '>') buf[i] = btn_close;
                else buf[i] = str[i];
            }
            buf[len] = '\0';
            real_SLsmg_write_string(buf);
            return;
        }
    }

    real_SLsmg_write_string(str);
}
