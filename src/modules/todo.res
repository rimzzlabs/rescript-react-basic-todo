module Todo = {
  type todo = {id: int, title: string}
  type state = {todos: array<todo>}
  type todoId = int
  type action = AddTodo(todo) | RemoveTodo(todoId) | Reset
  let state = {todos: []}

  let reducerFn = (state, action) => {
    switch action {
    | AddTodo(todo) => {todos: state.todos->Array.concat([todo])}
    | RemoveTodo(todoId) => {todos: state.todos->Array.filter(v => v.id !== todoId)}
    | Reset => {todos: []}
    }
  }
}
