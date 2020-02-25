#!/usr/bin/env bash
dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. ""${dir}"/../dye4b.sh"

TITLE="What is Lorem Ipsum?"
LOREM="Lorem Ipsum"
DESCRIPTION=" is simply dummy text of the printing and typesetting industry."

TITLE_FOREGROUND_EFFECT="$(fg_ce -c white -e bold)"
LOREM_FOREGROUND_EFFECT="$(fg_ce -c yellow -e bold)"
DESCRIPTION_FOREGROUND_EFFECT="$(fg_ce -c yellow -e normal)"
BACKGROUND="$(bgc -c black)"
TITLE_CONFIG=""${BACKGROUND}""${TITLE_FOREGROUND_EFFECT}""
LOREM_CONFIG=""${BACKGROUND}""${LOREM_FOREGROUND_EFFECT}""
DESCRIPTION_CONFIG=""${BACKGROUND}""${DESCRIPTION_FOREGROUND_EFFECT}""

echo -ne ""${TITLE_CONFIG}""${TITLE}"\n\n"
echo -ne ""$(esc_ctrl)""
echo -ne ""${LOREM_CONFIG}""${LOREM}""$(esc_ctrl)""${DESCRIPTION_CONFIG}""${DESCRIPTION}"""$(esc_ctrl)""\n\n"
