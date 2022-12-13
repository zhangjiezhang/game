package main

import (
	"github.com/zhangjiezhang/game/twenty48"
	"log"

	"github.com/hajimehoshi/ebiten/v2"
)

func main() {
	game, err := twenty48.NewGame()
	if err != nil {
		log.Fatal(err)
	}
	ebiten.SetWindowSize(twenty48.ScreenWidth, twenty48.ScreenHeight)
	ebiten.SetWindowTitle("2048 (Ebitengine Demo)")
	if err := ebiten.RunGame(game); err != nil {
		log.Fatal(err)
	}
}
