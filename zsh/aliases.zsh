# reload zsh config
alias reload!='RELOAD=1 source $HOME/.zshrc'

# rails
alias rs='rails s --binding=157.245.136.35'
alias rgs='rails g scaffold'
alias rgmo='rails g model'
alias rgmi='rails g migration'
alias rgv='rails g view'
alias rgj='rails g job'

# rake/rails
alias rdbm='rake db:migrate'
alias rdbs='rake db:seed'
alias rdbd='rake db:drop'

# tmux
alias ta='tmux a'
alias tls='tmux ls'
alias tat='tmux a -t'
alias tns='tmux new -s'
alias tsync='tmux setw synchronize-panes'
