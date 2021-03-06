GenRap::Application.routes.draw do
  resources :languages
  resources :sub_concepts
  resources :concepts

  root to: 'exams#pending'

  resources :users, :groups, :master_questions, :exam_definitions, :exams

  match 'signup', to: 'users#new'
  match 'login', to: 'sessions#login'
  match 'logout', to: 'sessions#logout'
  match 'def', to: 'exam_definition#new'
  match 'exam_definition/destroy/:id', to: 'exam_definition#destroy'
  match 'results/exam/:id', to: 'exams#results', as: 'exam_results'
  match 'create/exam/:id', to: 'exams#create', as: 'create_exam'
  match 'pending', to: 'exams#pending'
  match 'edit/:id', to: 'exam_definition#edit'
  match 'mystats', to: 'stats#mystats'
  match 'profstats', to: 'stats#profstats'
  match 'profstats_exam', to: 'stats#profstats_exam'
  match 'resultadosExamen', to: 'stats#resultadosExamen'

  # json routes in MasterQuestion controller
  match 'master_question/concepts_for_question' => 'master_questions#concepts_for_question'
  match 'master_question/subconcepts_for_question' => 'master_questions#subconcepts_for_question'
  match 'master_question/filtered_master_questions' => 'master_questions#filtered_master_questions'
  match 'master_question/transmiting_JSON' => 'master_questions#transmiting_JSON'
  match 'master_question/get_languages' => 'master_questions#get_languages'
  match 'master_question/deleteQuestion' => 'master_questions#deleteQuestion'
  match 'master_question/deleted_questions' => 'master_questions#deleted_questions'
  match 'master_question/backup' => 'master_questions#backup'
  match 'exam/afterExam' => 'exams#afterExam'

  # json routes in Exams controller
  match 'exam/get_exams' => 'exams#get_exams'

  # json routes in ExamDefinition controller
  match 'exam_definition/exam_def' => 'exam_definition#exam_def'

  # json routes in Groups controller
  match 'group/get_groups' => 'groups#get_groups'

  # json routes in Users controller
  match 'user/get_users' => 'users#get_users'
  match 'user/get_current_user' => 'users#get_current_user'
  match 'user/set_users_cantake' => 'users#set_users_cantake'
  match 'user/set_user_cantake_own' => 'users#set_user_cantake_own'
  match 'user/change_admin/:id' => 'users#change_admin'
  match 'user/change_professor/:id' => 'users#change_professor'
  match 'user/change_student/:id' => 'users#change_student'
end
