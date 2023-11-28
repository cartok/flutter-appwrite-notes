# notes_tasks

## Screens

### Login

A login screen with user Registration and Third-party login (Github and Google).

### Notes

The starting page, if not configured differently (unimplemented feature). The user can create notes using a floating action button on the bottom right, which opens a modal. The page shows priority groups (e.g. High, Mid, Low) where tasks can be draged in. If a new task was created it appears at the bottom if no priority was set in the modal already. Not sure if it should be a feature maybe it could be smarter to let the user just write text and then scroll it into view to allow clicking on it which then opens a UI like a bottom sheet or modal to edit text and settings. The user could then drag the note into a group.

### Tasks

**Wird evtl. zu viel für die kurze Zeit.**

## Design

### Resources

- [Material Design Docs](https://m3.material.io/)
- [Material Design Kit](https://www.figma.com/community/file/1035203688168086460/material-3-design-kit)
- [Dynamic Color](https://pub.dev/packages/dynamic_color)
- [The Figma Design](https://www.figma.com/file/5F3Sk3EhUo50gunUQXfow6)

### Screen resolutions

#### Mobile

I ignored 320px width even tho [worship.agency](https://worship.agency/mobile-screen-sizes-for-2023-based-on-data-from-2022) listed it cause it seems to be no longer the case when looking at the past 3 month data of [gs.counter.com](https://gs.statcounter.com/screen-resolution-stats/mobile/worldwide/#monthly-202308-202310-bar). The lowest detected width is 360 and the lowest detected height is 640. The hightest width is 414 and the highest height is 962. The most prominent resolution is 360x800 (11%). To cover most devices, I whould design for 360x640, check on 414x962 and optimize for 360x800. For now I just start with the 360x640 preset of the Material Design Kit.
