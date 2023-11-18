Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012997EFF51
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Nov 2023 12:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjKRLnh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Nov 2023 06:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKRLnf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Nov 2023 06:43:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D8D57
        for <linux-wireless@vger.kernel.org>; Sat, 18 Nov 2023 03:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700307794; x=1700912594; i=wahrenst@gmx.net;
        bh=gSIWooRq1OF6vM7OgTfJkmCSOtuOT2VPnA4Y3lZi92Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=cfQ+CR+MSf+IoHfeUCfokuOMCqnd7r1GOC9nJASb1E8avUFECmRjJG2D9JhGOtT/
         EZWh0a+Jai62SWT9de+UqmPckd4bHYO2kYhtB7u1BnlbCmwWcJCxej3OwHomEelMD
         h2d4kF8d/f3iJm1xYYrQYKzUcg8gcsv9AdPmpNUtOUirD9kX8iCJc30gEdbIw93xW
         AhQAdCLrEUq9zYZ8J8/U5ZdZsAt0YSLSGxKmQY/HKlkGdvapuhhps6LoDSZIpsFLD
         d+krwEsPhNiiZtbAQCmZq6WgUdOYpi/ll0/XgVvvftBuDI9e4/WY8RataTtU5n0x0
         /Lw0QgMt+1v26glStw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1r73Ye2TO6-00Fz26; Sat, 18
 Nov 2023 12:43:14 +0100
Message-ID: <0e5eba2f-e524-4f0d-8217-2770c57ad5ed@gmx.net>
Date:   Sat, 18 Nov 2023 12:43:13 +0100
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
 <004dabc3-c345-4d90-9348-5caa9b1f3849@gmx.net>
 <c3996f70-bb2a-4d26-a7e9-a1b062fa0474@broadcom.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <c3996f70-bb2a-4d26-a7e9-a1b062fa0474@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xcC5mtFpj7Gt39IB/Y23PTsyP2Zu2RekaHpXSonYYBVNKqrgIml
 iuDDODWvJ2m40lGtO+1s3lTaUVtYhGGewcogI34A8b/JWny/yrgZ4uRNG6fnfyfUP7oSNBN
 6aZFkFJXhf4b/5SyqctMmCQFyxFf2yVtzcmT8zcFw9VciCh7YSbc5U32wMiM6lcI5yXVcKx
 dIiboUJO3OX/ZIACHf0Hg==
UI-OutboundReport: notjunk:1;M01:P0:5+5UMZH+4xQ=;042sxWqLsqWxMjTFqifSoMvHva+
 9xoMj2fHn6JEDVZvsybuZi0w8Qku77KV0sIpV/UrHIgEqtfnbYADhioV+ZaYpE3q/vhG8tEDw
 OWGBkvRqAbzkmMj1bMZA5ST+s7BNf5GRj/aF8EwElfyDql+hvE/hKPV2atxEe7yKQx2q5aGgM
 LeFix4eYyFIrO2zazPv5UnJqrnDf51ZvxZHHIqZ25FM+Z381jwHLL048zHX1Wf2TxvaM5urcn
 eBDNkSOivtAIcEyA4nm8BCRKySr/AxyQpX9oHm7aD49eg++ZW1rpRqQiOvFdhe7jXMajm1GDc
 pbREO3amt0gqzasHgZER2fb+BHJLZE9v8TPiJ0kxhkcK4ULtnT3hf8P4Mt9thMbnTozuk7k2z
 YKR63BMOGKg2cTY9gnUSNhL2ZsPNSqwJgmqqb5xpewuBxHkSqNsS3hPbRoDYLF0YECsc4VLqj
 abrZsWtkRMaO4ilexrySKcN1EfxrQ0Ya3XcNY3MNXnh0nI6POZHTzSQ7i0GRrColUlFfuC5HK
 UF26m9ZfC3/jTwO60/dWnUJxxabQQhYFtlhQuuCvLlL5i3yOwtBrmhRG64U6MXbBDOSFa80KI
 gT5E3v9LkWU6lb4eXF/cDkoSeOxP5a4U9ZIfXCkgqoh7V/oRtVw7UQCx6WhskeDfACuETpgsL
 u/luQZTyHoPTGM7Zs0riHZPxevOiqCJYsQKMtCmJoCAzRGn2/wH89uk/NMW1ypmjYr+Cm6Tnk
 c/wF/Vb7vi6Qx2l3NrZ4fRtbsxA4deAAFLF+rH8JRRVraHPeAlG6htpFjt8NuIVGuZPODjcGg
 ZMbM1PiUowD31JpMr7ULYHaWnPNDyWGGNkp9N3ghxy0L52WmzUZ+eBIQ7CCvIgjKFGNubxUeb
 IN4OppJ0Ouw5jy+D9VSM+VOjdtUsU9wP4D6kixcbbg7v/0H4q+/Zsmqg8R/ca1qVjGkTJnoqG
 89MUCg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

Am 15.11.23 um 21:09 schrieb Arend van Spriel:
> On 11/15/2023 7:35 PM, Stefan Wahren wrote:
>> Am 15.11.23 um 10:34 schrieb Arend van Spriel:
>>> On 11/13/2023 10:02 PM, Stefan Wahren wrote:
>>>> Hi Arend,
>>>>
>>>> Am 13.11.23 um 10:11 schrieb Arend van Spriel:
>>>>> On 11/11/2023 9:30 PM, Stefan Wahren wrote:
>>>>>> Am 11.11.23 um 19:29 schrieb Stefan Wahren:
>>>>>>>
>>>>>>> Am 11.11.23 um 18:25 schrieb Arend Van Spriel:
>>>>>>>> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net>
>>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Again look like these are disabled channels. At least chanspec
>>>>>>>> 0xd022
>>>>>>>> is 5G channel 34. You say you get this only once so not every 60
>>>>>>>> seconds?
>>>>>>> I get this everytime i trigger a reconnect to the wifi network, so
>>>>>>> not
>>>>>>> periodically (checked that). Strangely the initial automatic
>>>>>>> connect
>>>>>>> doesn't trigger this errors.
>>>>>> I additionally placed a WARN_ON_ONCE after the error log and
>>>>>> enabled the
>>>>>> firmware error log of brcmf_fil_cmd_data(). Maybe this helps.
>>>>>
>>>>> It does a bit. At least it shows this is happening with the
>>>>> dump_survey (again). I don't really understand why though. It implie=
s
>>>>> the channel is not disabled, but unclear why. The channel flags are
>>>>> changed in brcmf_construct_chaninfo() so we probably should focus
>>>>> debug on that function.
>>>>>
>>>>
>>>> i placed a pr_err at the start of brcmf_construct_chaninfo and anothe=
r
>>>> pr_err into the for loop before the "if (channel->orig_flags &
>>>> IEEE80211_CHAN_DISABLED) continue".
>>>>
>>>> pr_err("%s: Ch num %d, chanspec 0x%x, orig_flags: %x.\n", __func__,
>>>> ch.control_ch_num, ch.chspec, channel->orig_flags);
>>>>
>>>> It seems that brcmf_construct_chaninfo is called two times, but the
>>>> results are different. I could find 0xd090 in the first run, but
>>>> not in
>>>> second. The other chanspecs doesn't seem to occur in both runs. No
>>>> idea
>>>> what's going on here.
>>>
>>> Can you print all wiphy band channels before exiting
>>> brcmf_construct_chaninfo() and print both channel->orig_flags and
>>> channel->flags?
>>
>> Sure. It seems that in the first call of=C2=A0brcmf_construct_chaninfo =
the
>> channel 144 is not disabled, but in the second.
>
> I am a bit confused. So the chanspec as mentioned in this email
> subject is no longer observed, but you still see failure in
> brcmf_set_channel() for other chanspecs?

before we dive deeper into this let me summarize my observations from
the beginning. From my understanding the errors are triggered for the 5
GHz channels 34, 38, 42, 46, 144 (chanspec: 0xd022, 0xd026, 0xd02a,
0xd090). So i would focus my observations on those.

As you said that the channel flags are set in brcmf_construct_chaninfo()
i dump them, here is the output of the first call:

[=C2=A0=C2=A0=C2=A0 8.785850] brcmfmac: 5 GHz: 0: hw_value 34: orig_flags:=
 00080000,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785861] brcmfmac: 5 GHz: 2: hw_value 38: orig_flags:=
 00080000,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785872] brcmfmac: 5 GHz: 4: hw_value 42: orig_flags:=
 00080000,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785882] brcmfmac: 5 GHz: 6: hw_value 46: orig_flags:=
 00080000,
flags 00000001
[=C2=A0=C2=A0=C2=A0 8.785974] brcmfmac: 5 GHz: 23: hw_value 144: orig_flag=
s: 00080000,
flags 0000011a

All of them except 144 are disabled via flags. Btw wpa_supplicant is
configured to country DE within the configuration.

The second and last time brcmf_construct_chaninfo() is called is a few
seconds later during boot, we get the following:

[=C2=A0=C2=A0 12.490877] brcmfmac: 5 GHz: 0: hw_value 34: orig_flags: 0008=
0000,
flags 00000001
[=C2=A0=C2=A0 12.490891] brcmfmac: 5 GHz: 2: hw_value 38: orig_flags: 0008=
0000,
flags 00000001
[=C2=A0=C2=A0 12.490904] brcmfmac: 5 GHz: 4: hw_value 42: orig_flags: 0008=
0000,
flags 00000001
[=C2=A0=C2=A0 12.490918] brcmfmac: 5 GHz: 6: hw_value 46: orig_flags: 0008=
0000,
flags 00000001
[=C2=A0=C2=A0 12.491031] brcmfmac: 5 GHz: 23: hw_value 144: orig_flags: 00=
080000,
flags 00000001

Now all of them are disabled via flags.

So after that i trigger the reconnect to the same 5 GHz network as
before. brcmf_construct_chaninfo is never called again, but at the time
brcmf_set_channel is called the flags for these channels are completely
different:

[=C2=A0=C2=A0 90.010002] brcmfmac: brcmf_set_channel: set chanspec 0xd022 =
fail,
reason -52
[=C2=A0=C2=A0 90.010017] brcmfmac: hw_value 34, orig_flags: 00080000, flag=
s 00080220
[=C2=A0=C2=A0 90.120007] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-20)
[=C2=A0=C2=A0 90.120038] brcmfmac: brcmf_set_channel: set chanspec 0xd026 =
fail,
reason -52
[=C2=A0=C2=A0 90.120053] brcmfmac: hw_value 38, orig_flags: 00080000, flag=
s 00080200
[=C2=A0=C2=A0 90.230029] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-20)
[=C2=A0=C2=A0 90.230058] brcmfmac: brcmf_set_channel: set chanspec 0xd02a =
fail,
reason -52
[=C2=A0=C2=A0 90.230073] brcmfmac: hw_value 42, orig_flags: 00080000, flag=
s 00080200
[=C2=A0=C2=A0 90.340042] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-20)
[=C2=A0=C2=A0 90.340071] brcmfmac: brcmf_set_channel: set chanspec 0xd02e =
fail,
reason -52
[=C2=A0=C2=A0 90.340086] brcmfmac: hw_value 46, orig_flags: 00080000, flag=
s 00080210
[=C2=A0=C2=A0 92.100073] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-20)
[=C2=A0=C2=A0 92.100110] brcmfmac: brcmf_set_channel: set chanspec 0xd090 =
fail,
reason -52
[=C2=A0=C2=A0 92.100126] brcmfmac: hw_value 144, orig_flags: 00080000, fla=
gs 00080118

Where does these new flags come from? It's clear that these doesn't come
from brcmf_construct_chaninfo(). So what manipulates the flags
afterwards? Shouldn't brcmf_construct_chaninfo() called on reconnect?

Best regards

>
> brcmf_construct_chaninfo() is called from brcmf_setup_wiphybands() and
> that function is called in two places:
>
> 1) brcmf_cfg80211_attach(): right after wiphy_register()
> 2) brcmf_cfg80211_reg_notifier()
>
> Can we figure out if brcmf_cfg80211_reg_notifier() is indeed invoked
> on your platform and what country is being configured. If the country
> is indeed changed than it can be expected that some channels are
> disabled or enabled.
>
> Regards,
> Arend

