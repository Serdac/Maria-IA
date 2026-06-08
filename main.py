import flet as ft

def main(page: ft.Page):
    page.title = "María IA"
    page.vertical_alignment = ft.MainAxisAlignment.CENTER

    txt_input = ft.TextField(label="Escribe algo para María...")
    text_output = ft.Text(value="Esperando tu mensaje...")

    def btn_click(e):
        text_output.value = f"María dice: Hola, recibí tu mensaje: {txt_input.value}"
        page.update()

    page.add(
        ft.Row([txt_input, ft.ElevatedButton("Enviar", on_click=btn_click)]),
        text_output
    )

ft.app(target=main)
