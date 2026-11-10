# Checks the sorted downloads folder, one test per task in README.md.
# Run it from this folder with: Invoke-Pester
# You don't need to change this file.

BeforeAll {
    $script:downloads = Join-Path $PSScriptRoot 'downloads'

    # The names of the files in a folder, sorted and joined, so two lists compare as one line of text.
    function Get-FileNames([string] $folder) {
        $path = Join-Path $script:downloads $folder
        if (-not (Test-Path -LiteralPath $path -PathType Container)) { return "(no $($folder.Replace('/', '\')) folder)" }
        (@(Get-ChildItem -LiteralPath $path -File -Force | ForEach-Object Name) | Sort-Object) -join ', '
    }

    $script:photos = 'beach-sunset.jpg, beach-volleyball.jpg, birthday-cake.png, dog-in-the-snow.jpg, graduation.png'
    $script:receipts = 'bike-shop-receipt.pdf, grocery-receipt.pdf, phone-repair-receipt.pdf, receipt-concert-tickets.pdf'
    $script:documents = 'lease-agreement.pdf, recipe-banana-bread.docx, resume.docx, scan-1.pdf, scan-2.pdf'
}

Describe 'Exercise: Sort the Downloads Folder' {

    It '1) every photo is in photos' {
        Get-FileNames 'photos' | Should -Be $photos -Because 'task 1 moves every .jpg and .png into downloads\photos. Make the folder with New-Item, then move them with Move-Item and the wildcards *.jpg and *.png'
        Get-FileNames '.' | Should -Not -Match '\.(jpg|png)(,|$)' -Because 'no photo should be left at the top of downloads'
    }

    It '2) every receipt is in receipts' {
        Get-FileNames 'receipts' | Should -Be $receipts -Because 'task 2 moves every file with receipt in its name into downloads\receipts. List *receipt* with Get-ChildItem first: the receipts folder matches too'
        Get-FileNames '.' | Should -Not -Match 'receipt' -Because 'no receipt should be left at the top of downloads'
    }

    It '3) the class schedule is in school\fall-2026' {
        Get-FileNames 'school/fall-2026' | Should -Match '(^|, )class-schedule\.pdf(,|$)' -Because 'task 3 makes school\fall-2026 with one New-Item and moves class-schedule.pdf into it'
        Get-FileNames '.' | Should -Not -Match 'class-schedule' -Because 'the schedule should no longer be at the top of downloads'
    }

    It '4) the old copy is renamed class-schedule-old.pdf, beside the schedule' {
        Get-FileNames 'school/fall-2026' | Should -Be 'class-schedule-old.pdf, class-schedule.pdf' -Because "task 4 renames 'class-schedule (1).pdf' to class-schedule-old.pdf (quotes around a name with a space) and puts it in school\fall-2026 too"
    }

    It '5) the other documents are in documents, and the last two files stay at the top' {
        Get-FileNames 'documents' | Should -Be $documents -Because 'task 5 moves every .pdf and .docx still at the top of downloads into downloads\documents. Do tasks 2 to 4 first, so the receipts and schedules are already sorted'
        Get-FileNames '.' | Should -Be 'game-setup.exe, unfinished-download.tmp' -Because 'only game-setup.exe and unfinished-download.tmp stay at the top of downloads. Did a wildcard match more than you meant?'
    }

    It '6) a copy of the photos folder is in backup, and the photos are still in photos' {
        Get-FileNames 'backup/photos' | Should -Be $photos -Because 'task 6 copies the whole photos folder into downloads\backup. Without -Recurse, Copy-Item copies the folder on its own, empty'
        Get-FileNames 'photos' | Should -Be $photos -Because 'a copy leaves the originals in photos. Did you use Move-Item instead of Copy-Item?'
    }
}
