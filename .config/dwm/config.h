/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  		= 1;        /* border pixel of windows */
static const unsigned int snap      		= 32;       /* snap pixel */
static const int showbar            		= 1;        /* 0 means no bar */
static const int topbar             		= 1;        /* 0 means bottom bar */
static const unsigned int systraypinning 	= 1;	/* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing 	= 2;	/* systray spacing */
static const int systraypinningfailfirst 	= 1;	/* 1: if pinning fails, display systray on the first monitor, 0: display systray on the last monitor*/
static const int showsystray 				= 1;		/* 0 means no systray */

static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

static const char *fonts[] = {
	"monospace:size=12",
	"Terminus:size=12",
	"FontAwesome:size=12",
	"RobotoMono Nerd Font Mono:size=12"
};
static const char dmenufont[]       = "RobotoMono Nerd Font Mono:size=10";
static const char normbordercolor[] = "#282c34"; // Цвет рамки неактивного окна
static const char normbgcolor[]     = "#1c1f25"; // Цвет не выделенного фона панели
static const char normfgcolor[]     = "#bbbbbb"; // Цвет не выделенного текста
static const char selbordercolor[]  = "#06989a"; // Цвет рамки активного окна
static const char selbgcolor[]      = "#282c34"; // Цвет выделенного фона
static const char selfgcolor[]      = "#eeeeee"; // цвет выделенного текста

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance    title       tags mask     isfloating   monitor */
	{ "Gnome-terminal", NULL,       NULL,       1 << 9,       0,           0 },
	{ "Nautilus", 		NULL,       NULL,       1 << 9,       0,           0 },
	{ "Gimp",           NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",        NULL,       NULL,       1 << 8,       0,           -1 },
	{ "Telegram",       NULL,       NULL,       1 << 8,       0,           0 },
	{ "Chromium",       NULL,       NULL,       1 << 9,       0,           1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",      tile },    /* first entry is default */
	{ "",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALT Mod1Mask
#define SHIFT ShiftMask
#define CTRL ControlMask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "gnome-terminal", "--hide-menubar", NULL };
static const char *chromiumcmd[]  = { "chromium", NULL };
static const char *nautiluscmd[]  = { "nautilus", NULL };

// Change sound
static const char *upVolume5pre[]      = { "amixer", "set", "Master", "5%+", NULL };
static const char *downVolume5pre[]    = { "amixer", "set", "Master", "5%-", NULL };
static const char *toggleVolume[]      = { "amixer", "set", "Master", "toggle", NULL }; // for debian
// static const char *toggleVolume[]  = { "amixer", "-D", "pulse", "set", "Master", "1+", "toggle", NULL }; // for ubuntu
// // static const char *upVolume[]      = { "amixer", "-D", "pulse", "sset", "Master", "5%+", NULL }; // for ubuntu
// // static const char *downVolume[]    = { "amixer", "-D", "pulse", "sset", "Master", "5%-", NULL }; // for ubuntu
// // static const char *toggleVolume[]  = { "amixer", "-D", "pulse", "sset", "Master", "toggle", NULL }; // for ubuntu

/* mbp-mappings */
#define XF86AudioMute			0x1008ff12
#define XF86AudioLowerVolume	0x1008ff11
#define XF86AudioRaiseVolume	0x1008ff13
#define XF86TouchpadToggle		0x1008ffa9

static Key keys[] = {
	/* modifier                     key        				function        argument */
	{ MODKEY,                       XK_d,      				spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, 				spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_w,      				spawn,          {.v = chromiumcmd } },
	{ MODKEY,                       XK_e,      				spawn,          {.v = nautiluscmd } },
	{ MODKEY,                       XK_b,      				togglebar,      {0} },
	{ MODKEY,                       XK_j,      				focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      				focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      				incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_p,      				incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      				setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      				setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, 				zoom,           {0} },
	{ MODKEY,                       XK_Tab,    				view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      				killclient,     {0} },
	{ MODKEY,                       XK_t,      				setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      				setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      				setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  				setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  				togglefloating, {0} },
	{ MODKEY,                       XK_0,      				view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      				tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  				focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, 				focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  				tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, 				tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_F12,	   				spawn,	       	{.v = upVolume5pre } },
    { MODKEY,                   	XK_F11,	   				spawn,	       	{.v = downVolume5pre } },
    { MODKEY,                   	XK_F10,	   				spawn,	       	{.v = toggleVolume } },
	{ 0,                       		XF86AudioRaiseVolume,	spawn,	       	{.v = upVolume5pre } },
	{ 0,                       		XF86AudioLowerVolume,	spawn,	       	{.v = downVolume5pre } },
	{ 0,                       		XF86AudioMute,			spawn,	       	{.v = toggleVolume } },
    TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      				quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

