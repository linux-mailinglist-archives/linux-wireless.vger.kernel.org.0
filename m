Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1297ECA8F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 19:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjKOSf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 13:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKOSf2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 13:35:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A78101
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 10:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700073307; x=1700678107; i=wahrenst@gmx.net;
        bh=Xqf8Hvv1jLkek0iipEWnzN7chTmPAq2WcWiD3JrkoOU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=JHbdh7Agu7Z+PIPQnDFojR47VI+Ng4UjJOA0+0784PMRphQNiOHpW4qJqn9o8LmX
         aDYi4V4ceEXGEMj2XC3SqgMU03tGGpccgnMLDonFhAJQXFB/hPe68OAARcbLqSz9c
         cF3OsQOlGPXaK7G3U+BhS+QDpaaO91Bvyx67iDlVV2KKtpnTFoyiK8S5ko5zXFy7A
         XoS/bXCrRcgSfJ74UuzJpLD427h6jJiLFiHy3n64EE89pzE8G+BkSgKA38lXkIHz1
         I/UJ60Rxh+JY8ZS6g/b+0rNY3yAO5oV4bikO+wmCBtf4prk3X6Gkdr1IRtifqLhGs
         XR2jYLSWoGoQ7Jj8vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1qmc7i2E8r-00LFyn; Wed, 15
 Nov 2023 19:35:07 +0100
Message-ID: <004dabc3-c345-4d90-9348-5caa9b1f3849@gmx.net>
Date:   Wed, 15 Nov 2023 19:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Hector Martin <marcan@marcan.st>,
        Kalle Valo <kvalo@kernel.org>
References: <d9c9336a-6314-4de9-aead-8b865bb30f05@gmx.net>
 <18bbf6acf10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <cb07408d-af14-4b01-bd96-15c480989643@gmx.net>
 <5c462fac-b27d-41c0-a62c-a8951bf445d2@gmx.net>
 <d8f7dc94-40f5-4544-9693-01d7cbc6fefb@broadcom.com>
 <ca0fd1c5-380d-4756-a33a-cb6c84014ce4@gmx.net>
 <89d3f34a-3427-4871-971c-d960a16918ac@broadcom.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <89d3f34a-3427-4871-971c-d960a16918ac@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DNf5yWrIyynqTpZuAMwqbsGKTfX38eCjmj+W3GB7+MunPOkdPLK
 CEko6ucBcRWYFgrO83slVXR1N7uus7aOrlNxKN7XsVyz2F54cQy7IugBccYUu0ZMBFIWZAR
 9AoqPZxV9YYvuuSZGY3kAdzzQrkqrosDqWHgl+W6Mbkb90A9Jwz/LdNiTHf7/Z7zZMmrWec
 PlGLtrTMaBldUptgJfzTg==
UI-OutboundReport: notjunk:1;M01:P0:ubapq1XNXqI=;Bt++HPBZ4Br969HFDx6iuBDjo1v
 6+7pvhJewPN0n4n4f6h8EZ9dSsxglRFTzEPZqBunf9s6W2cAKVEp1Y1S+C8z4ATpTZJBAdUXe
 OauhiRklK/DFpEEdeld5d7a6iDvrmQADmCUfxl6rizufl75zaUD6YlyzSr1SsAxYYCU8NWJme
 yV45xMX8PP+yOhC5e8fjqJ0ig4X+6ojKHYx7VxG0/RsLRwo4lji2gfNmt5jLSzsspx8d27k0J
 8tkEicmTf/jxn9AdcC33ODu4ENu37SMCMYOYMC9SzbIaNyW5/WJO2R2e/dEuQiLHggWSIVUtd
 KlVsfFNJi8mI+tqX57/qgFoTd4kAPdUb+ey7m4mabpFL1WZOPx4TKLLyoIuM02CdUMpaIPiXb
 8MWk+Z99Ww3dsqH67vs07IKkGlgtjw3agDIYEXjZHSXqQnTaq7aXKk2YLGKc3ZQSeDn5Qd6Hz
 bs8XoQdlVJdYIjAy6kGkQhYItZyiJioPgIY7mRL0zDazfBqtJKcHTPFw7WdzkGmh7OHOIWuPw
 +bRiQB7qJwi4Fzjlw1k/DOpJ1jNe9zMpPqKO/yurWV6z1bDwD9lTo475Tw2bTlTQLBWHUhVnM
 5PMob9H40+U5pSjIZUhE1KmbMp7RK/qpWhFF/B7mkFZeuzB8dIV5vK54hg1fl0uSHYIFfSvRw
 iRVOFBFZ/OImWVfbtRw7YJurOC84fVfAfSDbtAcINswdAUoMlUS/WJU7PeEJ5fymKd9SFubV1
 iQA841NCKKBnNUMIISSgry73dhTQ/PVhApKjFMSreEaLIauW5f/UanoRdO0qeEbEAskG+rp9o
 jMfnl1lQbKHS/IlAOsf1x521MW8bb+QODxGXW208xqi3S9xGmFHmJBiCbfImMeCIuTgJ+Kiz6
 QEHj/bpCT4oPyhiqEQh6t6Rxg/jrq6FZopu0iYXIZNmhua6MwKIMWoJAEd59h6QycVhrWQLpz
 l8KmbDtK6JWAwyO7+C9sS4GI+xA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 15.11.23 um 10:34 schrieb Arend van Spriel:
> On 11/13/2023 10:02 PM, Stefan Wahren wrote:
>> Hi Arend,
>>
>> Am 13.11.23 um 10:11 schrieb Arend van Spriel:
>>> On 11/11/2023 9:30 PM, Stefan Wahren wrote:
>>>> Am 11.11.23 um 19:29 schrieb Stefan Wahren:
>>>>>
>>>>> Am 11.11.23 um 18:25 schrieb Arend Van Spriel:
>>>>>> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net>
>>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> Again look like these are disabled channels. At least chanspec
>>>>>> 0xd022
>>>>>> is 5G channel 34. You say you get this only once so not every 60
>>>>>> seconds?
>>>>> I get this everytime i trigger a reconnect to the wifi network, so
>>>>> not
>>>>> periodically (checked that). Strangely the initial automatic connect
>>>>> doesn't trigger this errors.
>>>> I additionally placed a WARN_ON_ONCE after the error log and
>>>> enabled the
>>>> firmware error log of brcmf_fil_cmd_data(). Maybe this helps.
>>>
>>> It does a bit. At least it shows this is happening with the
>>> dump_survey (again). I don't really understand why though. It implies
>>> the channel is not disabled, but unclear why. The channel flags are
>>> changed in brcmf_construct_chaninfo() so we probably should focus
>>> debug on that function.
>>>
>>
>> i placed a pr_err at the start of brcmf_construct_chaninfo and another
>> pr_err into the for loop before the "if (channel->orig_flags &
>> IEEE80211_CHAN_DISABLED) continue".
>>
>> pr_err("%s: Ch num %d, chanspec 0x%x, orig_flags: %x.\n", __func__,
>> ch.control_ch_num, ch.chspec, channel->orig_flags);
>>
>> It seems that brcmf_construct_chaninfo is called two times, but the
>> results are different. I could find 0xd090 in the first run, but not in
>> second. The other chanspecs doesn't seem to occur in both runs. No idea
>> what's going on here.
>
> Can you print all wiphy band channels before exiting
> brcmf_construct_chaninfo() and print both channel->orig_flags and
> channel->flags?

Sure. It seems that in the first call of=C2=A0brcmf_construct_chaninfo the
channel 144 is not disabled, but in the second.

[=C2=A0=C2=A0=C2=A0 8.746495] brcmfmac: brcmf_construct_chaninfo called
[=C2=A0=C2=A0=C2=A0 8.785752] brcmfmac: 2 GHz: 0: hw_value 1: orig_flags: =
00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785777] brcmfmac: 2 GHz: 1: hw_value 2: orig_flags: =
00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785783] brcmfmac: 2 GHz: 2: hw_value 3: orig_flags: =
00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785789] brcmfmac: 2 GHz: 3: hw_value 4: orig_flags: =
00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785794] brcmfmac: 2 GHz: 4: hw_value 5: orig_flags: =
00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785800] brcmfmac: 2 GHz: 5: hw_value 6: orig_flags: =
00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785806] brcmfmac: 2 GHz: 6: hw_value 7: orig_flags: =
00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785811] brcmfmac: 2 GHz: 7: hw_value 8: orig_flags: =
00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785817] brcmfmac: 2 GHz: 8: hw_value 9: orig_flags: =
00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785823] brcmfmac: 2 GHz: 9: hw_value 10: orig_flags:=
 00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785828] brcmfmac: 2 GHz: 10: hw_value 11: orig_flags=
: 00080180,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.785834] brcmfmac: 2 GHz: 11: hw_value 12: orig_flags=
: 00080180,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785839] brcmfmac: 2 GHz: 12: hw_value 13: orig_flags=
: 00080180,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785845] brcmfmac: 2 GHz: 13: hw_value 14: orig_flags=
: 000801b0,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785850] brcmfmac: 5 GHz: 0: hw_value 34: orig_flags:=
 00080000,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785856] brcmfmac: 5 GHz: 1: hw_value 36: orig_flags:=
 00080000,
flags 00000120
[=C2=A0=C2=A0=C2=A0 8.785861] brcmfmac: 5 GHz: 2: hw_value 38: orig_flags:=
 00080000,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785867] brcmfmac: 5 GHz: 3: hw_value 40: orig_flags:=
 00080000,
flags 00000110
[=C2=A0=C2=A0=C2=A0 8.785872] brcmfmac: 5 GHz: 4: hw_value 42: orig_flags:=
 00080000,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785877] brcmfmac: 5 GHz: 5: hw_value 44: orig_flags:=
 00080000,
flags 00000120
[=C2=A0=C2=A0=C2=A0 8.785882] brcmfmac: 5 GHz: 6: hw_value 46: orig_flags:=
 00080000,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785888] brcmfmac: 5 GHz: 7: hw_value 48: orig_flags:=
 00080000,
flags 00000110
[=C2=A0=C2=A0=C2=A0 8.785893] brcmfmac: 5 GHz: 8: hw_value 52: orig_flags:=
 00080000,
flags 0000012a
[=C2=A0=C2=A0=C2=A0 8.785899] brcmfmac: 5 GHz: 9: hw_value 56: orig_flags:=
 00080000,
flags 0000011a
[=C2=A0=C2=A0=C2=A0 8.785904] brcmfmac: 5 GHz: 10: hw_value 60: orig_flags=
: 00080000,
flags 0000012a
[=C2=A0=C2=A0=C2=A0 8.785909] brcmfmac: 5 GHz: 11: hw_value 64: orig_flags=
: 00080000,
flags 0000011a
[=C2=A0=C2=A0=C2=A0 8.785914] brcmfmac: 5 GHz: 12: hw_value 100: orig_flag=
s: 00080000,
flags 0000012a
[=C2=A0=C2=A0=C2=A0 8.785920] brcmfmac: 5 GHz: 13: hw_value 104: orig_flag=
s: 00080000,
flags 0000011a
[=C2=A0=C2=A0=C2=A0 8.785926] brcmfmac: 5 GHz: 14: hw_value 108: orig_flag=
s: 00080000,
flags 0000012a
[=C2=A0=C2=A0=C2=A0 8.785931] brcmfmac: 5 GHz: 15: hw_value 112: orig_flag=
s: 00080000,
flags 0000011a
[=C2=A0=C2=A0=C2=A0 8.785937] brcmfmac: 5 GHz: 16: hw_value 116: orig_flag=
s: 00080000,
flags 0000012a
[=C2=A0=C2=A0=C2=A0 8.785942] brcmfmac: 5 GHz: 17: hw_value 120: orig_flag=
s: 00080000,
flags 0000011a
[=C2=A0=C2=A0=C2=A0 8.785947] brcmfmac: 5 GHz: 18: hw_value 124: orig_flag=
s: 00080000,
flags 0000012a
[=C2=A0=C2=A0=C2=A0 8.785953] brcmfmac: 5 GHz: 19: hw_value 128: orig_flag=
s: 00080000,
flags 0000011a
[=C2=A0=C2=A0=C2=A0 8.785958] brcmfmac: 5 GHz: 20: hw_value 132: orig_flag=
s: 00080000,
flags 0000012a
[=C2=A0=C2=A0=C2=A0 8.785963] brcmfmac: 5 GHz: 21: hw_value 136: orig_flag=
s: 00080000,
flags 0000011a
[=C2=A0=C2=A0=C2=A0 8.785968] brcmfmac: 5 GHz: 22: hw_value 140: orig_flag=
s: 00080000,
flags 0000012a
[=C2=A0=C2=A0=C2=A0 8.785974] brcmfmac: 5 GHz: 23: hw_value 144: orig_flag=
s: 00080000,
flags 0000011a
[=C2=A0=C2=A0=C2=A0 8.785980] brcmfmac: 5 GHz: 24: hw_value 149: orig_flag=
s: 00080000,
flags 00000120
[=C2=A0=C2=A0=C2=A0 8.785985] brcmfmac: 5 GHz: 25: hw_value 153: orig_flag=
s: 00080000,
flags 00000110
[=C2=A0=C2=A0=C2=A0 8.785991] brcmfmac: 5 GHz: 26: hw_value 157: orig_flag=
s: 00080000,
flags 00000120
[=C2=A0=C2=A0=C2=A0 8.785996] brcmfmac: 5 GHz: 27: hw_value 161: orig_flag=
s: 00080000,
flags 00000110
[=C2=A0=C2=A0=C2=A0 8.786001] brcmfmac: 5 GHz: 28: hw_value 165: orig_flag=
s: 00080000,
flags 000001b0
[=C2=A0=C2=A0=C2=A0 8.788704] hub 1-1:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 8.788821] hub 1-1:1.0: 4 ports detected
[=C2=A0=C2=A0=C2=A0 8.791957] onboard-usb-hub 3f980000.usb:usb-port@1: sup=
ply vdd not
found, using dummy regulator
[=C2=A0=C2=A0=C2=A0 8.793702] hub 1-1:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 8.793771] hub 1-1:1.0: 4 ports detected
[=C2=A0=C2=A0=C2=A0 8.802200] onboard-usb-hub 3f980000.usb:usb-port@1:usb-=
port@1:
supply vdd not found, using dummy regulator
[=C2=A0=C2=A0=C2=A0 9.118321] usb 1-1.1: new high-speed USB device number =
7 using dwc2
[=C2=A0=C2=A0=C2=A0 9.259037] hub 1-1.1:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 9.259172] hub 1-1.1:1.0: 3 ports detected
[=C2=A0=C2=A0=C2=A0 9.358264] usb 1-1.3: new low-speed USB device number 8=
 using dwc2
[=C2=A0=C2=A0=C2=A0 9.448978] Bluetooth: hci0: BCM: features 0x2f
[=C2=A0=C2=A0=C2=A0 9.450779] Bluetooth: hci0: BCM43455 37.4MHz Raspberry =
Pi 3+
[=C2=A0=C2=A0=C2=A0 9.450787] Bluetooth: hci0: BCM4345C0 (003.001.025) bui=
ld 0342
[=C2=A0=C2=A0=C2=A0 9.516274] input: HID 046a:0011 as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/0003:046A:0011=
.0003/input/input2
[=C2=A0=C2=A0=C2=A0 9.581849] hid-generic 0003:046A:0011.0003: input: USB =
HID v1.11
Keyboard [HID 046a:0011] on usb-3f980000.usb-1.3/input0
[=C2=A0=C2=A0=C2=A0 9.588292] usb 1-1.1.2: new low-speed USB device number=
 9 using dwc2
[=C2=A0=C2=A0=C2=A0 9.726779] input: PixArt Microsoft USB Optical Mouse as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003=
:045E:00CB.0004/input/input3
[=C2=A0=C2=A0=C2=A0 9.727131] hid-generic 0003:045E:00CB.0004: input: USB =
HID v1.11
Mouse [PixArt Microsoft USB Optical Mouse] on usb-3f980000.usb-1.1.2/input=
0
[=C2=A0=C2=A0 10.038321] usb 1-1.1.1: new high-speed USB device number 10 =
using dwc2
[=C2=A0=C2=A0 10.445710] lan78xx 1-1.1.1:1.0 (unnamed net_device) (uniniti=
alized):
No External EEPROM. Setting MAC Speed
[=C2=A0=C2=A0 12.311539] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-23)
[=C2=A0=C2=A0 12.453863] brcmfmac: brcmf_construct_chaninfo called
[=C2=A0=C2=A0 12.490762] brcmfmac: 2 GHz: 0: hw_value 1: orig_flags: 00080=
180,
flags 000001a0
[=C2=A0=C2=A0 12.490789] brcmfmac: 2 GHz: 1: hw_value 2: orig_flags: 00080=
180,
flags 000001a0
[=C2=A0=C2=A0 12.490796] brcmfmac: 2 GHz: 2: hw_value 3: orig_flags: 00080=
180,
flags 000001a0
[=C2=A0=C2=A0 12.490803] brcmfmac: 2 GHz: 3: hw_value 4: orig_flags: 00080=
180,
flags 000001a0
[=C2=A0=C2=A0 12.490810] brcmfmac: 2 GHz: 4: hw_value 5: orig_flags: 00080=
180,
flags 00000180
[=C2=A0=C2=A0 12.490817] brcmfmac: 2 GHz: 5: hw_value 6: orig_flags: 00080=
180,
flags 00000180
[=C2=A0=C2=A0 12.490823] brcmfmac: 2 GHz: 6: hw_value 7: orig_flags: 00080=
180,
flags 00000180
[=C2=A0=C2=A0 12.490830] brcmfmac: 2 GHz: 7: hw_value 8: orig_flags: 00080=
180,
flags 00000180
[=C2=A0=C2=A0 12.490837] brcmfmac: 2 GHz: 8: hw_value 9: orig_flags: 00080=
180,
flags 00000180
[=C2=A0=C2=A0 12.490843] brcmfmac: 2 GHz: 9: hw_value 10: orig_flags: 0008=
0180,
flags 00000190
[=C2=A0=C2=A0 12.490850] brcmfmac: 2 GHz: 10: hw_value 11: orig_flags: 000=
80180,
flags 00000190
[=C2=A0=C2=A0 12.490857] brcmfmac: 2 GHz: 11: hw_value 12: orig_flags: 000=
80180,
flags 00000190
[=C2=A0=C2=A0 12.490864] brcmfmac: 2 GHz: 12: hw_value 13: orig_flags: 000=
80180,
flags 00000190
[=C2=A0=C2=A0 12.490870] brcmfmac: 2 GHz: 13: hw_value 14: orig_flags: 000=
801b0,
flags 00000001
[=C2=A0=C2=A0 12.490877] brcmfmac: 5 GHz: 0: hw_value 34: orig_flags: 0008=
0000,
flags 00000001
[=C2=A0=C2=A0 12.490884] brcmfmac: 5 GHz: 1: hw_value 36: orig_flags: 0008=
0000,
flags 00000120
[=C2=A0=C2=A0 12.490891] brcmfmac: 5 GHz: 2: hw_value 38: orig_flags: 0008=
0000,
flags 00000001
[=C2=A0=C2=A0 12.490897] brcmfmac: 5 GHz: 3: hw_value 40: orig_flags: 0008=
0000,
flags 00000110
[=C2=A0=C2=A0 12.490904] brcmfmac: 5 GHz: 4: hw_value 42: orig_flags: 0008=
0000,
flags 00000001
[=C2=A0=C2=A0 12.490910] brcmfmac: 5 GHz: 5: hw_value 44: orig_flags: 0008=
0000,
flags 00000120
[=C2=A0=C2=A0 12.490918] brcmfmac: 5 GHz: 6: hw_value 46: orig_flags: 0008=
0000,
flags 00000001
[=C2=A0=C2=A0 12.490924] brcmfmac: 5 GHz: 7: hw_value 48: orig_flags: 0008=
0000,
flags 00000110
[=C2=A0=C2=A0 12.490931] brcmfmac: 5 GHz: 8: hw_value 52: orig_flags: 0008=
0000,
flags 0000012a
[=C2=A0=C2=A0 12.490937] brcmfmac: 5 GHz: 9: hw_value 56: orig_flags: 0008=
0000,
flags 0000011a
[=C2=A0=C2=A0 12.490944] brcmfmac: 5 GHz: 10: hw_value 60: orig_flags: 000=
80000,
flags 0000012a
[=C2=A0=C2=A0 12.490951] brcmfmac: 5 GHz: 11: hw_value 64: orig_flags: 000=
80000,
flags 0000011a
[=C2=A0=C2=A0 12.490957] brcmfmac: 5 GHz: 12: hw_value 100: orig_flags: 00=
080000,
flags 0000012a
[=C2=A0=C2=A0 12.490964] brcmfmac: 5 GHz: 13: hw_value 104: orig_flags: 00=
080000,
flags 0000011a
[=C2=A0=C2=A0 12.490971] brcmfmac: 5 GHz: 14: hw_value 108: orig_flags: 00=
080000,
flags 0000012a
[=C2=A0=C2=A0 12.490978] brcmfmac: 5 GHz: 15: hw_value 112: orig_flags: 00=
080000,
flags 0000011a
[=C2=A0=C2=A0 12.490984] brcmfmac: 5 GHz: 16: hw_value 116: orig_flags: 00=
080000,
flags 0000012a
[=C2=A0=C2=A0 12.490991] brcmfmac: 5 GHz: 17: hw_value 120: orig_flags: 00=
080000,
flags 0000011a
[=C2=A0=C2=A0 12.490997] brcmfmac: 5 GHz: 18: hw_value 124: orig_flags: 00=
080000,
flags 0000012a
[=C2=A0=C2=A0 12.491004] brcmfmac: 5 GHz: 19: hw_value 128: orig_flags: 00=
080000,
flags 0000011a
[=C2=A0=C2=A0 12.491011] brcmfmac: 5 GHz: 20: hw_value 132: orig_flags: 00=
080000,
flags 000001aa
[=C2=A0=C2=A0 12.491017] brcmfmac: 5 GHz: 21: hw_value 136: orig_flags: 00=
080000,
flags 0000019a
[=C2=A0=C2=A0 12.491024] brcmfmac: 5 GHz: 22: hw_value 140: orig_flags: 00=
080000,
flags 000001ba
[=C2=A0=C2=A0 12.491031] brcmfmac: 5 GHz: 23: hw_value 144: orig_flags: 00=
080000,
flags 00000001
[=C2=A0=C2=A0 12.491038] brcmfmac: 5 GHz: 24: hw_value 149: orig_flags: 00=
080000,
flags 00000001
[=C2=A0=C2=A0 12.491044] brcmfmac: 5 GHz: 25: hw_value 153: orig_flags: 00=
080000,
flags 00000001
[=C2=A0=C2=A0 12.491051] brcmfmac: 5 GHz: 26: hw_value 157: orig_flags: 00=
080000,
flags 00000001
[=C2=A0=C2=A0 12.491057] brcmfmac: 5 GHz: 27: hw_value 161: orig_flags: 00=
080000,
flags 00000001
[=C2=A0=C2=A0 12.491064] brcmfmac: 5 GHz: 28: hw_value 165: orig_flags: 00=
080000,
flags 00000001
>
>
> Gr. AvS

