import * as core from '@actions/core'
import {exec} from '@actions/exec'
import * as fs from 'fs'
import * as yaml from 'yaml'
import path from 'path'

async function run(): Promise<void> {
  try {
    const ms: string = core.getInput('milliseconds')
    core.debug(`Waiting ${ms} milliseconds mike !!!...`) // debug is only output if you set the secret `ACTIONS_RUNNER_DEBUG` to true
    const fileContents = fs.readFileSync(path.join(__dirname,'..','tools','tools.yaml'), 'utf-8')
    const data = yaml.parse(fileContents)
    for (const tool of data.tools) {
      //if there is a command, use the command directly
      await exec(path.join(__dirname,'..', 'tools', tool.name, 'install.sh'))
    }
    // core.info(yaml.stringify(data.tools[0].name))
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
