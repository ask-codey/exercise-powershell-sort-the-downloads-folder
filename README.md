# Exercise: Sort the Downloads Folder

Exercise code for the lesson **Exercise: Sort the Downloads Folder** in PowerShell in Depth on [ask-codey.com](https://www.ask-codey.com).

The `downloads` folder here is a mess: eighteen files, all in one heap. You'll sort it with PowerShell, the way you'd sort your own Downloads folder, without a single drag of the mouse. A Pester check tells you which tasks are done.

## What's here

- `downloads/`: eighteen made-up files to sort. They're empty: only their names matter. For you to sort.
- `Check.Tests.ps1`: the check that looks at the `downloads` folder. You don't need to change it.

## What to do

Open PowerShell 7 and go into the `downloads` folder with `Set-Location`. Then do these six tasks with the commands from the *Making and Moving* chapter: `New-Item`, `Copy-Item`, `Move-Item`, `Rename-Item`, wildcards, and `-WhatIf` to rehearse each move first. Every folder you make goes inside `downloads`.

1. **Photos.** Make a `photos` folder and move every `.jpg` and `.png` file into it.
2. **Receipts.** Make a `receipts` folder and move every file with `receipt` in its name into it.
3. **School.** Make `school\fall-2026` (a `fall-2026` folder inside a `school` folder) with one command, and move `class-schedule.pdf` into it.
4. **The old copy.** `class-schedule (1).pdf` is an older copy of the schedule. Rename it `class-schedule-old.pdf`, and put it in `school\fall-2026` too.
5. **Documents.** Make a `documents` folder and move every `.pdf` and `.docx` file still at the top of `downloads` into it. `game-setup.exe` and `unfinished-download.tmp` stay where they are.
6. **Backup.** Make a `backup` folder and copy the whole `photos` folder into it, every photo included, so there's a `backup\photos`. The photos stay in `photos` as well.

## Check your work

The check needs Pester 5 or newer. Install it once, if you haven't already:

```powershell
Install-PSResource Pester
```

Then, from this folder (the one with `Check.Tests.ps1` in it, not `downloads`):

```powershell
Invoke-Pester
```

At first every test fails: that is expected. Each task you finish turns its test green. A failing test's message says which task it is and what it found.

Made a mistake? Nothing here is real, so you can fix it with the same commands: move a file back, or rename it again. To start over, download the exercise again.

If PowerShell says the check *cannot be loaded because running scripts is disabled* or *is not digitally signed*, the folder came from a download that Windows marked as from the internet. Unblock its files once with `Get-ChildItem -Recurse | Unblock-File`, from this folder, and run `Invoke-Pester` again. *Why a Script Won't Run: The Execution Policy*, in Module 5, explains what that does.

## Tips

- Before you move anything with a wildcard, list it: `Get-ChildItem` with the same pattern shows what will move. Or add `-WhatIf` to the move itself.
- A pattern matches folders as well as files. Once there's a `receipts` folder, `*receipt*` matches it too.
- Do the tasks in order. Task 5 is easier once the receipts and the schedules are already sorted.
- A name with a space needs quotes. Tab adds them for you.
- Copy-Item copies a folder with everything in it only with `-Recurse`.

## Hand it in

When it works, push your solution to a public repo of your own on GitHub, then paste that repo's address into **Submit your exercise** on the lesson page at [ask-codey.com](https://www.ask-codey.com). That's what completes the lesson. The lesson page shows the Git commands, step by step.
