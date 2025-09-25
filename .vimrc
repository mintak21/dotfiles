" system
set fenc=utf-8
set noswapfile
set autoread "変更を自動ロード
set history=100 "コマンド100件記憶
set undolevels=100 "Uのアンドゥを100回まで可能に
set timeoutlen=100 "<ESC>高速化
filetype plugin indent on "filetypr detection/plugin/indentをON

" editor
set cursorline "カーソル行を強調
set autoindent "新しい行のインデントをあわせる
set smartindent
syntax enable "シンタックスハイライト有効

" search
set ignorecase "小文字だけなら大小区別しない
set smartcase "大文字があるときは大小区別する
set wrapscan "最後->最初に戻る
set hlsearch "ハイライト
set incsearch "コマンド打ち込み中もマッチングさせる

" display
set number "行番号
set title "タイトル表示
set showcmd "入力中コマンドを表示
set showmode "モードを表示
set showmatch  "対応するカッコを表示
set ruler      "右下に行番号とカラムを表示
set wildmenu   "コマンド候補一覧バー
set noerrorbells "エラーメッセージ表示時、ビープを鳴らさない
set laststatus=2 "ステータスラインを常に表示

" color
" コメント行
hi Comment ctermfg=4

