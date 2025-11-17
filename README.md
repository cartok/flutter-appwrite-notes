# notes_tasks

## Screens

### Login

A login screen with user Registration and Third-party login (Github and Google).

### Notes

The starting page, if not configured differently (unimplemented feature). The user can create notes using a floating action button on the bottom right, which opens a modal. The page shows priority groups (e.g. High, Mid, Low) where tasks can be draged in. If a new task was created it appears at the bottom if no priority was set in the modal already. Not sure if it should be a feature maybe it could be smarter to let the user just write text and then scroll it into view to allow clicking on it which then opens a UI like a bottom sheet or modal to edit text and settings. The user could then drag the note into a group.

## Design

### Resources

- [Material Design Docs](https://m3.material.io/)
- [Material Design Kit](https://www.figma.com/community/file/1035203688168086460/material-3-design-kit)
- [Dynamic Color](https://pub.dev/packages/dynamic_color)
- [The Figma Design](https://www.figma.com/file/5F3Sk3EhUo50gunUQXfow6)

### Screen resolutions

#### Mobile

I ignored 320px width even tho [worship.agency](https://worship.agency/mobile-screen-sizes-for-2023-based-on-data-from-2022) listed it cause it seems to be no longer the case when looking at the past 3 month data of [gs.counter.com](https://gs.statcounter.com/screen-resolution-stats/mobile/worldwide/#monthly-202308-202310-bar). The lowest detected width is 360 and the lowest detected height is 640. The hightest width is 414 and the highest height is 962. The most prominent resolution is 360x800 (11%). To cover most devices, I whould design for 360x640, check on 414x962 and optimize for 360x800. For now I just start with the 360x640 preset of the Material Design Kit.

#### Problems

- Did not yet find a good solution to make the infinite list safely load content if the page size is so small, that the initial screen is not filled. As only scroll events trigger requests, the data would stop loading. So I would need to ensure that the max. size of 25 items always fills the screen but that is not good. Also I would have to listen on resize, especially for the browser. `LayoutBuilder` can be used to rebuild wrapped widgets on resize. The utils function `getWidgetBoundingBox` was a try to get the absoulte bottom position of a widget, to be able to find out if the list is scrollable. I am not really sure about this all, Lists in general. There is no simple indicator that it is scrollable and by default they always stretch to the screen size. They can be shrinked tho by setting `shrinkWrap: true`. I am yet not sure about this as it seemed to have no effect, but I also had problems wrapping the list into a `Row`. UPDATE: I can wrap `ListView` into `Expanded` when to put it into a row. I tried to use `visibility_detector` to find out if the list is fully visible but it always returned 1. Maybe it does not work properly on lists. The `getWidgetBoundingBox` function was the properly returning the correct widget height on resize but the initial value was wrong just as the `constraints` values.
