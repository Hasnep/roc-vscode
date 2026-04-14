import type { ExtensionContext } from "vscode";
import { commands, window, workspace } from "vscode";
import {
	type Executable,
	LanguageClient,
	type LanguageClientOptions,
} from "vscode-languageclient/node";

// The language client will only exist after activation
let client: LanguageClient | undefined;

export async function activate(context: ExtensionContext) {
	// Get the path to the Roc binary
	const rocPath =
		((workspace.getConfiguration("roc").get("path") as string | undefined) || "roc") ?? "roc";

	// Create the language client
	const serverOptions: Executable = { command: rocPath, args: ["experimental-lsp"] };
	const clientOptions: LanguageClientOptions = {
		documentSelector: [{ scheme: "file", language: "roc" }],
	};
	client = new LanguageClient("roc", "Roc", serverOptions, clientOptions);
	await client.start();

	// Add a command to restart the LSP
	context.subscriptions.push(
		commands.registerCommand("roc.restart", async () => {
			await client?.start();
			window.showInformationMessage("Roc LSP has restarted.");
		}),
	);
}

export async function deactivate() {
	await client?.dispose();
	client = undefined;
}
