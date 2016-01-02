//COMMA SEPARATED VALUES STRING to LIST//////////////////
//© 2016 by Real Burger, Licensed under the MIT license//
list wbCommaSeparatedValuesStringToList(string str) {
    list result = llParseString2List(str, [","], []);
    integer i;
    for (i=0; i<llGetListLength(result); i++) {
        string val = llList2String(result, i);
        val = llStringTrim(val, STRING_TRIM);
        if (val != "") {
            result = llListReplaceList(result, [val], i, i);
        } else {
            result = llDeleteSubList(result, i, i);
            i --;
        }
    }
    return result;
}
///////////////////////////////////////////////////////////
default {
    state_entry() {
        llSay(0, "Enter a comma separated values string in local chat");
        llListen(0, "", llGetOwner(), "");
    }
    listen(integer chan, string name, key id, string msg) {
        list testResultList = wbCommaSeparatedValuesStringToList(msg);
        if (llGetListLength(testResultList) == 0) {
            llSay(0, "*ERROR* No valid value specified");
            llResetScript();
        } else {
            llSay(0, "Here's the list:");
            integer i;
            for (i=0; i<llGetListLength(testResultList); i++) {
                llSay(0,  llList2String(testResultList, i));
            }
            llResetScript();
        }
    }
}