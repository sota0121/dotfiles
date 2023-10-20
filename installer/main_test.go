package main

import (
	"bytes"
	"os"
	"testing"
)

func TestRun(t *testing.T) {
	// テスト用の引数を設定
	os.Args = []string{"installer", "-f", "test.txt"}

	// 標準出力をキャプチャ
	var buf bytes.Buffer
	out = &buf

	// テスト対象の関数を呼び出し
	run()

	// 期待される出力を定義
	expected := "Installing test.txt...\nInstallation complete.\n"

	// 出力が期待されるものと一致するかどうかを検証
	if buf.String() != expected {
		t.Errorf("Unexpected output: %s", buf.String())
	}
}
