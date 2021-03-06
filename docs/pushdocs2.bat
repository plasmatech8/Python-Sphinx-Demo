@echo off

:: Creates a seperate project folder, copies the docs/build/html/ folder into it and pushes to gh-pages. 

:: html directory, docs directory, git URL
set "htmlDir=%cd%\build\html"
set "docsDir=%cd%"
set /p url="Enter repo URL: "

:: Go outside of project folder
cd ../../

:: Create a new folder outside of the current project
set  counter=0
:TryNext
set /a counter+=1
mkdir "%projName%-docs (%counter%)" 2>nul || goto :TryNext

:: Folder name, gh-pages directory
set "dir=%projName%-docs (%counter%)"

:: Clone the gh-pages branch of the repo
git clone -b gh-pages "%url%" "%dir%"
cd "%dir%"

:: Copy/overwrite all files and subdirectories
echo "%htmlDir%"
xcopy "%htmlDir%" . /s /y

:: Git commit and push
git add .
git commit -m "Updated gh-pages documentation..."
git push origin gh-pages

cd "%docsDir%"
pause