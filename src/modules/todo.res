module Todo = {
  type todo = {id: int, title: string, completed: bool}
  type state = {todos: array<todo>}
  type todoId = int
  type action = AddTodo(todo) | RemoveTodo(todoId) | MarkCompleteTodo(int, bool) | Reset

  let state = {todos: []}

  let appendTodos = (todo: todo) => (todos: array<todo>) => {todos: todos->Array.concat([todo])}
  let removeTodos = (todoId: int) => (todos: array<todo>) => {
    todos: todos->Array.filter(t => t.id !== todoId),
  }

  let markCompleteTodo = (~todoId: int, ~completed: bool) => (todos: array<todo>) => {
    let todoIndex = Array.findIndex(todos, todo => todo.id === todoId)
    let todo = todos[todoIndex]

    switch todo {
    | Some(todo) => {
        let updatedTodo = {...todo, completed: !completed}
        let newTodos = todos->Array.slice(~start=0, ~end=todos->Array.length)
        newTodos->Array.set(todoIndex, updatedTodo)

        {todos: newTodos}
      }
    | None => {todos: todos}
    }
  }

  let isValidTitle = (val: string) => {
    val->String.replaceRegExp(%re("/\s+/g"), "")->String.length > 0
  }

  let reducerFn = (state, action) => {
    switch action {
    | AddTodo(todo) => appendTodos(todo)(state.todos)
    | RemoveTodo(todoId) => removeTodos(todoId)(state.todos)
    | MarkCompleteTodo(todoId, completed) => markCompleteTodo(~todoId, ~completed)(state.todos)
    | Reset => {todos: []}
    }
  }
}
