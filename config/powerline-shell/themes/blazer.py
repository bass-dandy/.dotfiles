from powerline_shell.themes.default import DefaultColor


class Color(DefaultColor):
    USERNAME_FG = 17  # dark purple
    USERNAME_BG = 104 # light purple

    HOME_SPECIAL_DISPLAY = False
    PATH_BG = 237 # dark grey
    CWD_FG = 146  # light purple

    READONLY_BG = 237 # dark grey
    READONLY_FG = 138 # red(ish)

    REPO_CLEAN_BG = 151 # green
    REPO_CLEAN_FG = 17  # dark purple
    REPO_DIRTY_BG = 138 # red(ish)
    REPO_DIRTY_FG = 17  # dark purple

    SVN_CHANGES_BG = REPO_DIRTY_BG
    SVN_CHANGES_FG = REPO_DIRTY_FG
