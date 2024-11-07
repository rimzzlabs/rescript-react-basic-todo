@react.component
let make = () => {
  let (state, updateState) = React.useReducer(Todo.Todo.reducerFn, Todo.Todo.state)

  let addTodo = (title: string) =>
    updateState(AddTodo({id: Date.now()->Belt.Float.toInt, title, completed: false}))

  let removeTodo = id => updateState(id->RemoveTodo)
  let completeTodo = (int, completed) => updateState(MarkCompleteTodo(int, completed))
  let resetTodo = _ => updateState(Reset)

  <div className="max-w-2xl mx-auto w-11/12">
    <header className="pt-10 pb-4">
      <h1 className="text-4xl text-center font-bold text-balance">
        {"Todo Example with React and ReScript"->React.string}
      </h1>
    </header>
    <TodoForm addTodo={addTodo} />
    <TodoList
      todos={state.todos} removeTodo={removeTodo} completeTodo={completeTodo} resetTodo={resetTodo}
    />
  </div>
}
