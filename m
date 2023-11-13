Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFB7EA533
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 22:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjKMVDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 16:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjKMVDA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 16:03:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98E2D5C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 13:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699909358; x=1700514158; i=wahrenst@gmx.net;
        bh=oQK87BT/Xtjr0s7Tq3RiFghc31gzThLi8YkeFZy71ag=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=e7uwVWlTvBVf/Ct8GZGAHc7LCCoFm+UP9zd8ly2t4B0hVzyhOb1mgh8C/jhSnHkX
         va6FzP45qlBhmZe1zU47wgZMLhwx36Czb61OYAuOyBn3k8zjVrtB9ap3yxDjBFtHF
         DIKWzTD/mjENZ688sS6mJlnhZ9dy/pZI6uL3dbqVDOTTiCRtgbyi0qaf1kZHqxFpL
         /p838A/1mXFRbZtQWD98WBV7vXP8XQ0E14uvKneBA7ozH123nzVMlisg20Ba1TzpI
         j/CiaL6fyFgaOK8172q2MO5MA67dqsGwSYVNayXm7QIk0tJRjxWn0iQOEk2Kb469Z
         bp8eJ2oY5wkpasEdcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1rdtdW1v2m-00bZqo; Mon, 13
 Nov 2023 22:02:38 +0100
Message-ID: <ca0fd1c5-380d-4756-a33a-cb6c84014ce4@gmx.net>
Date:   Mon, 13 Nov 2023 22:02:37 +0100
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
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <d8f7dc94-40f5-4544-9693-01d7cbc6fefb@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d4mm1/JFvX4uug7bwPtYxTyVQ+P/MdWw11JX46ErsBDDRwZZhG2
 fCn7GzPEMoGUb+H1d/v6VHUhTxvhkmOzXUYYAPWRDabGxOZ3YMYCewkJoXMB8zHPJLvbLo9
 bk8YFSVnOAro2LnpnlnhY4/Ru06Qn5CTuWMLtjaO4wi3AKrxxk9Zqyp79aNO8aqWCD+l2xf
 h9nsrYWsQ/W1yxTFT2abw==
UI-OutboundReport: notjunk:1;M01:P0:6zxurlxLQ34=;Xpg4YFPl7vYOTv3c2iOfL/4+yt3
 YQsETbxQT9+ST6WYF3Yw+bqj496KWAq/u1uPY/hmPRI/8CbKOS5LAl6gE0jCzOCPdpd2Ry7Hm
 d4o/PnVRWfCw2kfNPqNuBMKAvA2mQVes8+x/oLPg+hu3axJFDyhhCPV4R/SAU0zXyBw2R8ymn
 FjLgj27YNywsnbchnDNbdqV67TddVmMA+EqD6wYdF4KUMgpR8yVOcnnQ1mZjxC8ijAzRC3I8I
 tY5Lt0SKtNtNP0ubtNCO67PycFfPXl1dEDlKYyxwK0HdSQlcmISs8VaM1J370FwfELHL65wyu
 JO/L8TPIC2eTBhj+rIV4i6KSdqDXPD8Quz7lOzksDLOv8OwZ6V8Yi0ptxNdLXXB4XSRntO0TP
 WjgQwL8oxnWZAFSzMqkwO0TFxAM9+RhA6DUuRKp9W1DmQ6qHYCIEdCQnVt9IWAkIm0nBYq7WB
 1IFBfs+f9o/BDQFS+qv7gCaZCte53mxjdna82EUKnUxA5KTbwSaJTkyUkUP+gmMDjBDZ9f92H
 6yW0y9xXDaME4XzzNGPWCb3W3UQjW08jZsppq4F4OtEJTESgCZaIGJj5mYzYpXHu1HPPu1pUQ
 DkXTw9FvO7ProLuxs06wPK49lDnvM5rRyl7Do6Ant9fN6JuW5TtPHgKLOWqBRgHv1DwcfrYcG
 F4fO5mAIJn4p+YwkObZ/Km5cQKsJxZ/sPQvbb8ZhCjVfWk5u/nBB78BE/4Rr3mKqdsSoXDqkG
 +rVOQjIjO6fT2v46uZiB5tGVn3KYkWxrbqLvd+Fln4GX1Na5sNvEGlepi0PIF+LCtB5w0gSY5
 ZAlgNEfhaxkj63nq0WoDjItSz66xt4PUQdIw9OHKnMoJChbyfYedu2hg8TmwuLk+hIsgR1/zT
 4w9X7TrCK/RAq6+3jIKmGD2qeXrEwkUoM3jVCNmeI2k93l3XH1nKwmWsjc0PEAu+mg+s2di8Q
 8hnbqw==
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

Am 13.11.23 um 10:11 schrieb Arend van Spriel:
> On 11/11/2023 9:30 PM, Stefan Wahren wrote:
>> Am 11.11.23 um 19:29 schrieb Stefan Wahren:
>>>
>>> Am 11.11.23 um 18:25 schrieb Arend Van Spriel:
>>>> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net>
>>>> wrote:
>>>>
>>>>
>>>> Again look like these are disabled channels. At least chanspec 0xd022
>>>> is 5G channel 34. You say you get this only once so not every 60
>>>> seconds?
>>> I get this everytime i trigger a reconnect to the wifi network, so not
>>> periodically (checked that). Strangely the initial automatic connect
>>> doesn't trigger this errors.
>> I additionally placed a WARN_ON_ONCE after the error log and enabled th=
e
>> firmware error log of brcmf_fil_cmd_data(). Maybe this helps.
>
> It does a bit. At least it shows this is happening with the
> dump_survey (again). I don't really understand why though. It implies
> the channel is not disabled, but unclear why. The channel flags are
> changed in brcmf_construct_chaninfo() so we probably should focus
> debug on that function.
>

i placed a pr_err at the start of brcmf_construct_chaninfo and another
pr_err into the for loop before the "if (channel->orig_flags &
IEEE80211_CHAN_DISABLED) continue".

pr_err("%s: Ch num %d, chanspec 0x%x, orig_flags: %x.\n", __func__,
ch.control_ch_num, ch.chspec, channel->orig_flags);

It seems that brcmf_construct_chaninfo is called two times, but the
results are different. I could find 0xd090 in the first run, but not in
second. The other chanspecs doesn't seem to occur in both runs. No idea
what's going on here.


[ 8.351658] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with error -=
2

[ 8.489232] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch

[ 8.625414] Console: switching to colour dummy device 80x30

[ 8.642319] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_ops [vc4])

[ 8.653613] vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops [vc4])

[ 8.653821] vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_ops [vc4])

[ 8.653996] vc4-drm soc:gpu: bound 3f004000.txp (ops vc4_txp_ops [vc4])

[ 8.654136] vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops vc4_crtc_ops
[vc4])

[ 8.654267] vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops vc4_crtc_ops
[vc4])

[ 8.654391] vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops vc4_crtc_ops
[vc4])

[ 8.654501] vc4-drm soc:gpu: bound 3fc00000.v3d (ops vc4_v3d_ops [vc4])

[ 8.666654] [drm] Initialized vc4 0.0.0 20140616 for soc:gpu on minor 0

[ 8.762647] Console: switching to colour frame buffer device 240x75

[ 8.789693] vc4-drm soc:gpu: [drm] fb0: vc4drmfb frame buffer device

[ 8.798837] hub 1-1:1.0: USB hub found

[ 8.798915] hub 1-1:1.0: 4 ports detected

[ 8.806659] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)

[ 8.807056] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0:
Jan 4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e

[ 8.811603] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-23)

[ 8.814671] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-23)

[ 8.815718] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-4)

[ 8.817080] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-23)

[ 8.817657] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-23)

[ 8.820140] brcmfmac: brcmf_construct_chaninfo called

[ 8.824102] brcmfmac: brcmf_construct_chaninfo: Ch num 1, chanspec
0x1001, orig_flags: 80180.

[ 8.824589] brcmfmac: brcmf_construct_chaninfo: Ch num 2, chanspec
0x1002, orig_flags: 80180.

[ 8.825044] brcmfmac: brcmf_construct_chaninfo: Ch num 3, chanspec
0x1003, orig_flags: 80180.

[ 8.825593] brcmfmac: brcmf_construct_chaninfo: Ch num 4, chanspec
0x1004, orig_flags: 80180.

[ 8.830446] brcmfmac: brcmf_construct_chaninfo: Ch num 5, chanspec
0x1005, orig_flags: 80180.

[ 8.830944] brcmfmac: brcmf_construct_chaninfo: Ch num 6, chanspec
0x1006, orig_flags: 80180.

[ 8.832712] brcmfmac: brcmf_construct_chaninfo: Ch num 7, chanspec
0x1007, orig_flags: 80180.

[ 8.833176] brcmfmac: brcmf_construct_chaninfo: Ch num 8, chanspec
0x1008, orig_flags: 80180.

[ 8.834938] brcmfmac: brcmf_construct_chaninfo: Ch num 9, chanspec
0x1009, orig_flags: 80180.

[ 8.835485] brcmfmac: brcmf_construct_chaninfo: Ch num 10, chanspec
0x100a, orig_flags: 80180.

[ 8.835945] brcmfmac: brcmf_construct_chaninfo: Ch num 11, chanspec
0x100b, orig_flags: 80180.

[ 8.836390] brcmfmac: brcmf_construct_chaninfo: Ch num 36, chanspec
0xd024, orig_flags: 80000.

[ 8.836890] brcmfmac: brcmf_construct_chaninfo: Ch num 40, chanspec
0xd028, orig_flags: 80000.

[ 8.837322] brcmfmac: brcmf_construct_chaninfo: Ch num 44, chanspec
0xd02c, orig_flags: 80000.

[ 8.837758] brcmfmac: brcmf_construct_chaninfo: Ch num 48, chanspec
0xd030, orig_flags: 80000.

[ 8.839545] brcmfmac: brcmf_construct_chaninfo: Ch num 52, chanspec
0xd034, orig_flags: 80000.

[ 8.840026] brcmfmac: brcmf_construct_chaninfo: Ch num 56, chanspec
0xd038, orig_flags: 80000.

[ 8.840451] brcmfmac: brcmf_construct_chaninfo: Ch num 60, chanspec
0xd03c, orig_flags: 80000.

[ 8.840878] brcmfmac: brcmf_construct_chaninfo: Ch num 64, chanspec
0xd040, orig_flags: 80000.

[ 8.842799] brcmfmac: brcmf_construct_chaninfo: Ch num 100, chanspec
0xd064, orig_flags: 80000.

[ 8.843391] brcmfmac: brcmf_construct_chaninfo: Ch num 104, chanspec
0xd068, orig_flags: 80000.

[ 8.843802] brcmfmac: brcmf_construct_chaninfo: Ch num 108, chanspec
0xd06c, orig_flags: 80000.

[ 8.844183] brcmfmac: brcmf_construct_chaninfo: Ch num 112, chanspec
0xd070, orig_flags: 80000.

[ 8.844660] brcmfmac: brcmf_construct_chaninfo: Ch num 116, chanspec
0xd074, orig_flags: 80000.

[ 8.845042] brcmfmac: brcmf_construct_chaninfo: Ch num 120, chanspec
0xd078, orig_flags: 80000.

[ 8.845428] brcmfmac: brcmf_construct_chaninfo: Ch num 124, chanspec
0xd07c, orig_flags: 80000.

[ 8.845858] brcmfmac: brcmf_construct_chaninfo: Ch num 128, chanspec
0xd080, orig_flags: 80000.

[ 8.846277] brcmfmac: brcmf_construct_chaninfo: Ch num 132, chanspec
0xd084, orig_flags: 80000.

[ 8.846692] brcmfmac: brcmf_construct_chaninfo: Ch num 136, chanspec
0xd088, orig_flags: 80000.

[ 8.847096] brcmfmac: brcmf_construct_chaninfo: Ch num 140, chanspec
0xd08c, orig_flags: 80000.

[ 8.847475] brcmfmac: brcmf_construct_chaninfo: Ch num 144, chanspec
0xd090, orig_flags: 80000.

[ 8.856025] brcmfmac: brcmf_construct_chaninfo: Ch num 149, chanspec
0xd095, orig_flags: 80000.

[ 8.857794] brcmfmac: brcmf_construct_chaninfo: Ch num 153, chanspec
0xd099, orig_flags: 80000.

[ 8.858937] brcmfmac: brcmf_construct_chaninfo: Ch num 157, chanspec
0xd09d, orig_flags: 80000.

[ 8.859632] brcmfmac: brcmf_construct_chaninfo: Ch num 161, chanspec
0xd0a1, orig_flags: 80000.

[ 8.860063] brcmfmac: brcmf_construct_chaninfo: Ch num 165, chanspec
0xd0a5, orig_flags: 80000.

[ 8.860484] brcmfmac: brcmf_construct_chaninfo: Ch num 40, chanspec
0xd926, orig_flags: 80000.

[ 8.860497] brcmfmac: brcmf_construct_chaninfo: Ch num 48, chanspec
0xd92e, orig_flags: 80000.

[ 8.860503] brcmfmac: brcmf_construct_chaninfo: Ch num 56, chanspec
0xd936, orig_flags: 80000.

[ 8.860509] brcmfmac: brcmf_construct_chaninfo: Ch num 64, chanspec
0xd93e, orig_flags: 80000.

[ 8.860515] brcmfmac: brcmf_construct_chaninfo: Ch num 104, chanspec
0xd966, orig_flags: 80000.

[ 8.860520] brcmfmac: brcmf_construct_chaninfo: Ch num 112, chanspec
0xd96e, orig_flags: 80000.

[ 8.860526] brcmfmac: brcmf_construct_chaninfo: Ch num 120, chanspec
0xd976, orig_flags: 80000.

[ 8.860531] brcmfmac: brcmf_construct_chaninfo: Ch num 128, chanspec
0xd97e, orig_flags: 80000.

[ 8.860537] brcmfmac: brcmf_construct_chaninfo: Ch num 136, chanspec
0xd986, orig_flags: 80000.

[ 8.860543] brcmfmac: brcmf_construct_chaninfo: Ch num 144, chanspec
0xd98e, orig_flags: 80000.

[ 8.860548] brcmfmac: brcmf_construct_chaninfo: Ch num 153, chanspec
0xd997, orig_flags: 80000.

[ 8.860554] brcmfmac: brcmf_construct_chaninfo: Ch num 161, chanspec
0xd99f, orig_flags: 80000.

[ 8.860560] brcmfmac: brcmf_construct_chaninfo: Ch num 36, chanspec
0xd826, orig_flags: 80000.

[ 8.860565] brcmfmac: brcmf_construct_chaninfo: Ch num 44, chanspec
0xd82e, orig_flags: 80000.

[ 8.860570] brcmfmac: brcmf_construct_chaninfo: Ch num 52, chanspec
0xd836, orig_flags: 80000.

[ 8.860593] brcmfmac: brcmf_construct_chaninfo: Ch num 60, chanspec
0xd83e, orig_flags: 80000.

[ 8.860599] brcmfmac: brcmf_construct_chaninfo: Ch num 100, chanspec
0xd866, orig_flags: 80000.

[ 8.860604] brcmfmac: brcmf_construct_chaninfo: Ch num 108, chanspec
0xd86e, orig_flags: 80000.

[ 8.860610] brcmfmac: brcmf_construct_chaninfo: Ch num 116, chanspec
0xd876, orig_flags: 80000.

[ 8.860615] brcmfmac: brcmf_construct_chaninfo: Ch num 124, chanspec
0xd87e, orig_flags: 80000.

[ 8.860621] brcmfmac: brcmf_construct_chaninfo: Ch num 132, chanspec
0xd886, orig_flags: 80000.

[ 8.860626] brcmfmac: brcmf_construct_chaninfo: Ch num 140, chanspec
0xd88e, orig_flags: 80000.

[ 8.860632] brcmfmac: brcmf_construct_chaninfo: Ch num 149, chanspec
0xd897, orig_flags: 80000.

[ 8.860638] brcmfmac: brcmf_construct_chaninfo: Ch num 157, chanspec
0xd89f, orig_flags: 80000.

[ 8.860658] brcmfmac: brcmf_construct_chaninfo: Ch num 36, chanspec
0xe02a, orig_flags: 80000.

[ 8.860667] brcmfmac: brcmf_construct_chaninfo: Ch num 52, chanspec
0xe03a, orig_flags: 80000.

[ 8.860673] brcmfmac: brcmf_construct_chaninfo: Ch num 100, chanspec
0xe06a, orig_flags: 80000.

[ 8.860678] brcmfmac: brcmf_construct_chaninfo: Ch num 116, chanspec
0xe07a, orig_flags: 80000.

[ 8.860685] brcmfmac: brcmf_construct_chaninfo: Ch num 132, chanspec
0xe08a, orig_flags: 80000.

[ 8.860691] brcmfmac: brcmf_construct_chaninfo: Ch num 149, chanspec
0xe09b, orig_flags: 80000.

[ 8.860696] brcmfmac: brcmf_construct_chaninfo: Ch num 40, chanspec
0xe12a, orig_flags: 80000.

[ 8.860702] brcmfmac: brcmf_construct_chaninfo: Ch num 56, chanspec
0xe13a, orig_flags: 80000.

[ 8.860707] brcmfmac: brcmf_construct_chaninfo: Ch num 104, chanspec
0xe16a, orig_flags: 80000.

[ 8.860713] brcmfmac: brcmf_construct_chaninfo: Ch num 120, chanspec
0xe17a, orig_flags: 80000.

[ 8.860718] brcmfmac: brcmf_construct_chaninfo: Ch num 136, chanspec
0xe18a, orig_flags: 80000.

[ 8.860724] brcmfmac: brcmf_construct_chaninfo: Ch num 153, chanspec
0xe19b, orig_flags: 80000.

[ 8.860729] brcmfmac: brcmf_construct_chaninfo: Ch num 44, chanspec
0xe22a, orig_flags: 80000.

[ 8.860735] brcmfmac: brcmf_construct_chaninfo: Ch num 60, chanspec
0xe23a, orig_flags: 80000.

[ 8.860740] brcmfmac: brcmf_construct_chaninfo: Ch num 108, chanspec
0xe26a, orig_flags: 80000.

[ 8.860745] brcmfmac: brcmf_construct_chaninfo: Ch num 124, chanspec
0xe27a, orig_flags: 80000.

[ 8.860755] brcmfmac: brcmf_construct_chaninfo: Ch num 140, chanspec
0xe28a, orig_flags: 80000.

[ 8.860760] brcmfmac: brcmf_construct_chaninfo: Ch num 157, chanspec
0xe29b, orig_flags: 80000.

[ 8.860766] brcmfmac: brcmf_construct_chaninfo: Ch num 48, chanspec
0xe32a, orig_flags: 80000.

[ 8.860771] brcmfmac: brcmf_construct_chaninfo: Ch num 64, chanspec
0xe33a, orig_flags: 80000.

[ 8.860776] brcmfmac: brcmf_construct_chaninfo: Ch num 112, chanspec
0xe36a, orig_flags: 80000.

[ 8.860782] brcmfmac: brcmf_construct_chaninfo: Ch num 128, chanspec
0xe37a, orig_flags: 80000.

[ 8.860787] brcmfmac: brcmf_construct_chaninfo: Ch num 144, chanspec
0xe38a, orig_flags: 80000.

[ 8.860795] brcmfmac: brcmf_construct_chaninfo: Ch num 161, chanspec
0xe39b, orig_flags: 80000.

[ 8.861554] onboard-usb-hub 3f980000.usb:usb-port@1: supply vdd not
found, using dummy regulator

[ 8.868702] onboard-usb-hub 3f980000.usb:usb-port@1:usb-port@1: supply
vdd not found, using dummy regulator

[ 8.891096] hub 1-1:1.0: USB hub found

[ 8.891187] hub 1-1:1.0: 4 ports detected

[ 8.896919] onboard-usb-hub 3f980000.usb:usb-port@1:usb-port@1: supply
vdd not found, using dummy regulator

[ 9.208425] usb 1-1.1: new high-speed USB device number 7 using dwc2

[ 9.339358] hub 1-1.1:1.0: USB hub found

[ 9.339475] hub 1-1.1:1.0: 3 ports detected

[ 9.438390] usb 1-1.3: new low-speed USB device number 8 using dwc2

[ 9.519198] Bluetooth: hci0: BCM: features 0x2f

[ 9.520993] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+

[ 9.521000] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342

[ 9.595589] input: HID 046a:0011 as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/0003:046A:0011=
.0003/input/input2

[ 9.658786] hid-generic 0003:046A:0011.0003: input: USB HID v1.11
Keyboard [HID 046a:0011] on usb-3f980000.usb-1.3/input0

[ 9.678424] usb 1-1.1.2: new low-speed USB device number 9 using dwc2

[ 9.816709] input: PixArt Microsoft USB Optical Mouse as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003=
:045E:00CB.0004/input/input3

[ 9.817000] hid-generic 0003:045E:00CB.0004: input: USB HID v1.11 Mouse
[PixArt Microsoft USB Optical Mouse] on usb-3f980000.usb-1.1.2/input0

[ 10.128368] usb 1-1.1.1: new high-speed USB device number 10 using dwc2

[ 10.534399] lan78xx 1-1.1.1:1.0 (unnamed net_device) (uninitialized):
No External EEPROM. Setting MAC Speed

[ 12.358759] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-23)

[ 12.475324] Adding 102396k swap on /var/swap. Priority:-2 extents:1
across:102396k SS

[ 12.534653] brcmfmac: brcmf_construct_chaninfo called

[ 12.538461] brcmfmac: brcmf_construct_chaninfo: Ch num 1, chanspec
0x1001, orig_flags: 80180.

[ 12.539514] brcmfmac: brcmf_construct_chaninfo: Ch num 2, chanspec
0x1002, orig_flags: 80180.

[ 12.539967] brcmfmac: brcmf_construct_chaninfo: Ch num 3, chanspec
0x1003, orig_flags: 80180.

[ 12.540446] brcmfmac: brcmf_construct_chaninfo: Ch num 4, chanspec
0x1004, orig_flags: 80180.

[ 12.540979] brcmfmac: brcmf_construct_chaninfo: Ch num 5, chanspec
0x1005, orig_flags: 80180.

[ 12.541417] brcmfmac: brcmf_construct_chaninfo: Ch num 6, chanspec
0x1006, orig_flags: 80180.

[ 12.541807] brcmfmac: brcmf_construct_chaninfo: Ch num 7, chanspec
0x1007, orig_flags: 80180.

[ 12.542184] brcmfmac: brcmf_construct_chaninfo: Ch num 8, chanspec
0x1008, orig_flags: 80180.

[ 12.542572] brcmfmac: brcmf_construct_chaninfo: Ch num 9, chanspec
0x1009, orig_flags: 80180.

[ 12.548876] brcmfmac: brcmf_construct_chaninfo: Ch num 10, chanspec
0x100a, orig_flags: 80180.

[ 12.549333] brcmfmac: brcmf_construct_chaninfo: Ch num 11, chanspec
0x100b, orig_flags: 80180.

[ 12.550512] brcmfmac: brcmf_construct_chaninfo: Ch num 12, chanspec
0x100c, orig_flags: 80180.

[ 12.550953] brcmfmac: brcmf_construct_chaninfo: Ch num 13, chanspec
0x100d, orig_flags: 80180.

[ 12.554027] brcmfmac: brcmf_construct_chaninfo: Ch num 5, chanspec
0x1903, orig_flags: 80180.

[ 12.554055] brcmfmac: brcmf_construct_chaninfo: Ch num 6, chanspec
0x1904, orig_flags: 80180.

[ 12.554060] brcmfmac: brcmf_construct_chaninfo: Ch num 7, chanspec
0x1905, orig_flags: 80180.

[ 12.554064] brcmfmac: brcmf_construct_chaninfo: Ch num 8, chanspec
0x1906, orig_flags: 80180.

[ 12.554068] brcmfmac: brcmf_construct_chaninfo: Ch num 9, chanspec
0x1907, orig_flags: 80180.

[ 12.554073] brcmfmac: brcmf_construct_chaninfo: Ch num 10, chanspec
0x1908, orig_flags: 80180.

[ 12.554078] brcmfmac: brcmf_construct_chaninfo: Ch num 11, chanspec
0x1909, orig_flags: 80180.

[ 12.554083] brcmfmac: brcmf_construct_chaninfo: Ch num 12, chanspec
0x190a, orig_flags: 80180.

[ 12.554087] brcmfmac: brcmf_construct_chaninfo: Ch num 13, chanspec
0x190b, orig_flags: 80180.

[ 12.554091] brcmfmac: brcmf_construct_chaninfo: Ch num 1, chanspec
0x1803, orig_flags: 80180.

[ 12.554095] brcmfmac: brcmf_construct_chaninfo: Ch num 2, chanspec
0x1804, orig_flags: 80180.

[ 12.554099] brcmfmac: brcmf_construct_chaninfo: Ch num 3, chanspec
0x1805, orig_flags: 80180.

[ 12.554104] brcmfmac: brcmf_construct_chaninfo: Ch num 4, chanspec
0x1806, orig_flags: 80180.

[ 12.554108] brcmfmac: brcmf_construct_chaninfo: Ch num 5, chanspec
0x1807, orig_flags: 80180.

[ 12.554113] brcmfmac: brcmf_construct_chaninfo: Ch num 6, chanspec
0x1808, orig_flags: 80180.

[ 12.554118] brcmfmac: brcmf_construct_chaninfo: Ch num 7, chanspec
0x1809, orig_flags: 80180.

[ 12.554122] brcmfmac: brcmf_construct_chaninfo: Ch num 8, chanspec
0x180a, orig_flags: 80180.

[ 12.554126] brcmfmac: brcmf_construct_chaninfo: Ch num 9, chanspec
0x180b, orig_flags: 80180.

[ 12.554131] brcmfmac: brcmf_construct_chaninfo: Ch num 36, chanspec
0xd024, orig_flags: 80000.

[ 12.554794] brcmfmac: brcmf_construct_chaninfo: Ch num 40, chanspec
0xd028, orig_flags: 80000.

[ 12.555338] brcmfmac: brcmf_construct_chaninfo: Ch num 44, chanspec
0xd02c, orig_flags: 80000.

[ 12.555859] brcmfmac: brcmf_construct_chaninfo: Ch num 48, chanspec
0xd030, orig_flags: 80000.

[ 12.556366] brcmfmac: brcmf_construct_chaninfo: Ch num 52, chanspec
0xd034, orig_flags: 80000.

[ 12.556904] brcmfmac: brcmf_construct_chaninfo: Ch num 56, chanspec
0xd038, orig_flags: 80000.

[ 12.557437] brcmfmac: brcmf_construct_chaninfo: Ch num 60, chanspec
0xd03c, orig_flags: 80000.

[ 12.557946] brcmfmac: brcmf_construct_chaninfo: Ch num 64, chanspec
0xd040, orig_flags: 80000.

[ 12.558511] brcmfmac: brcmf_construct_chaninfo: Ch num 100, chanspec
0xd064, orig_flags: 80000.

[ 12.562331] brcmfmac: brcmf_construct_chaninfo: Ch num 104, chanspec
0xd068, orig_flags: 80000.

[ 12.562838] brcmfmac: brcmf_construct_chaninfo: Ch num 108, chanspec
0xd06c, orig_flags: 80000.

[ 12.564164] brcmfmac: brcmf_construct_chaninfo: Ch num 112, chanspec
0xd070, orig_flags: 80000.

[ 12.564634] brcmfmac: brcmf_construct_chaninfo: Ch num 116, chanspec
0xd074, orig_flags: 80000.

[ 12.565152] brcmfmac: brcmf_construct_chaninfo: Ch num 120, chanspec
0xd078, orig_flags: 80000.

[ 12.567545] brcmfmac: brcmf_construct_chaninfo: Ch num 124, chanspec
0xd07c, orig_flags: 80000.

[ 12.568093] brcmfmac: brcmf_construct_chaninfo: Ch num 128, chanspec
0xd080, orig_flags: 80000.

[ 12.570298] brcmfmac: brcmf_construct_chaninfo: Ch num 132, chanspec
0xd084, orig_flags: 80000.

[ 12.571631] brcmfmac: brcmf_construct_chaninfo: Ch num 136, chanspec
0xd088, orig_flags: 80000.

[ 12.575890] brcmfmac: brcmf_construct_chaninfo: Ch num 140, chanspec
0xd08c, orig_flags: 80000.

[ 12.576378] brcmfmac: brcmf_construct_chaninfo: Ch num 40, chanspec
0xd926, orig_flags: 80000.

[ 12.576393] brcmfmac: brcmf_construct_chaninfo: Ch num 48, chanspec
0xd92e, orig_flags: 80000.

[ 12.576399] brcmfmac: brcmf_construct_chaninfo: Ch num 56, chanspec
0xd936, orig_flags: 80000.

[ 12.576405] brcmfmac: brcmf_construct_chaninfo: Ch num 64, chanspec
0xd93e, orig_flags: 80000.

[ 12.576412] brcmfmac: brcmf_construct_chaninfo: Ch num 104, chanspec
0xd966, orig_flags: 80000.

[ 12.576418] brcmfmac: brcmf_construct_chaninfo: Ch num 112, chanspec
0xd96e, orig_flags: 80000.

[ 12.576424] brcmfmac: brcmf_construct_chaninfo: Ch num 120, chanspec
0xd976, orig_flags: 80000.

[ 12.576434] brcmfmac: brcmf_construct_chaninfo: Ch num 128, chanspec
0xd97e, orig_flags: 80000.

[ 12.576440] brcmfmac: brcmf_construct_chaninfo: Ch num 136, chanspec
0xd986, orig_flags: 80000.

[ 12.576446] brcmfmac: brcmf_construct_chaninfo: Ch num 36, chanspec
0xd826, orig_flags: 80000.

[ 12.576452] brcmfmac: brcmf_construct_chaninfo: Ch num 44, chanspec
0xd82e, orig_flags: 80000.

[ 12.576458] brcmfmac: brcmf_construct_chaninfo: Ch num 52, chanspec
0xd836, orig_flags: 80000.

[ 12.576464] brcmfmac: brcmf_construct_chaninfo: Ch num 60, chanspec
0xd83e, orig_flags: 80000.

[ 12.576470] brcmfmac: brcmf_construct_chaninfo: Ch num 100, chanspec
0xd866, orig_flags: 80000.

[ 12.576476] brcmfmac: brcmf_construct_chaninfo: Ch num 108, chanspec
0xd86e, orig_flags: 80000.

[ 12.576482] brcmfmac: brcmf_construct_chaninfo: Ch num 116, chanspec
0xd876, orig_flags: 80000.

[ 12.576487] brcmfmac: brcmf_construct_chaninfo: Ch num 124, chanspec
0xd87e, orig_flags: 80000.

[ 12.576493] brcmfmac: brcmf_construct_chaninfo: Ch num 132, chanspec
0xd886, orig_flags: 80000.

[ 12.576499] brcmfmac: brcmf_construct_chaninfo: Ch num 36, chanspec
0xe02a, orig_flags: 80000.

[ 12.576505] brcmfmac: brcmf_construct_chaninfo: Ch num 52, chanspec
0xe03a, orig_flags: 80000.

[ 12.576511] brcmfmac: brcmf_construct_chaninfo: Ch num 100, chanspec
0xe06a, orig_flags: 80000.

[ 12.576517] brcmfmac: brcmf_construct_chaninfo: Ch num 116, chanspec
0xe07a, orig_flags: 80000.

[ 12.576522] brcmfmac: brcmf_construct_chaninfo: Ch num 40, chanspec
0xe12a, orig_flags: 80000.

[ 12.576528] brcmfmac: brcmf_construct_chaninfo: Ch num 56, chanspec
0xe13a, orig_flags: 80000.

[ 12.576534] brcmfmac: brcmf_construct_chaninfo: Ch num 104, chanspec
0xe16a, orig_flags: 80000.

[ 12.576540] brcmfmac: brcmf_construct_chaninfo: Ch num 120, chanspec
0xe17a, orig_flags: 80000.

[ 12.576546] brcmfmac: brcmf_construct_chaninfo: Ch num 44, chanspec
0xe22a, orig_flags: 80000.

[ 12.576554] brcmfmac: brcmf_construct_chaninfo: Ch num 60, chanspec
0xe23a, orig_flags: 80000.

[ 12.576560] brcmfmac: brcmf_construct_chaninfo: Ch num 108, chanspec
0xe26a, orig_flags: 80000.

[ 12.576566] brcmfmac: brcmf_construct_chaninfo: Ch num 124, chanspec
0xe27a, orig_flags: 80000.

[ 12.576572] brcmfmac: brcmf_construct_chaninfo: Ch num 48, chanspec
0xe32a, orig_flags: 80000.

[ 12.576578] brcmfmac: brcmf_construct_chaninfo: Ch num 64, chanspec
0xe33a, orig_flags: 80000.

[ 12.576584] brcmfmac: brcmf_construct_chaninfo: Ch num 112, chanspec
0xe36a, orig_flags: 80000.

[ 12.576590] brcmfmac: brcmf_construct_chaninfo: Ch num 128, chanspec
0xe37a, orig_flags: 80000.

[ 12.954647] Bluetooth: MGMT ver 1.22

[ 13.068104] lan78xx 1-1.1.1:1.0 eth0: Link is Down

[ 22.651995] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-23)

[ 115.162918] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-23)

[ 150.177646] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)

[ 150.177681] ------------[ cut here ]------------

[ 150.177691] WARNING: CPU: 2 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:8077
brcmf_cfg80211_dump_survey+0x330/0x348 [brcmfmac]

[ 150.177802] Modules linked in: aes_arm aes_generic cmac brcmfmac_wcc
vc4 snd_soc_hdmi_codec brcmfmac snd_soc_core crc32_arm_ce brcmutil
ac97_bus snd_pcm_dmaengine snd_pcm sha256_generic libsha256 sha256_arm
snd_timer hci_uart cfg80211 snd btbcm soundcore bluetooth
onboard_usb_hub drm_dma_helper ecdh_generic ecc libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx

[ 150.178002] CPU: 2 PID: 466 Comm: wpa_supplicant Not tainted
6.6.0-15494-g6bc986ab839c-dirty #139

[ 150.178020] Hardware name: BCM2835

[ 150.178039] unwind_backtrace from show_stack+0x10/0x14

[ 150.178077] show_stack from dump_stack_lvl+0x40/0x4c

[ 150.178106] dump_stack_lvl from __warn+0x7c/0x124

[ 150.178142] __warn from warn_slowpath_fmt+0x170/0x178

[ 150.178178] warn_slowpath_fmt from
brcmf_cfg80211_dump_survey+0x330/0x348 [brcmfmac]

[ 150.178290] brcmf_cfg80211_dump_survey [brcmfmac] from
nl80211_dump_survey+0x174/0x2bc [cfg80211]

[ 150.178543] nl80211_dump_survey [cfg80211] from genl_dumpit+0x38/0x74

[ 150.178714] genl_dumpit from netlink_dump+0x158/0x334

[ 150.178739] netlink_dump from __netlink_dump_start+0x1bc/0x27c

[ 150.178762] __netlink_dump_start from genl_rcv_msg+0x148/0x358

[ 150.178788] genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c

[ 150.178814] netlink_rcv_skb from genl_rcv+0x24/0x34

[ 150.178838] genl_rcv from netlink_unicast+0x1f4/0x2d0

[ 150.178864] netlink_unicast from netlink_sendmsg+0x1cc/0x454

[ 150.178888] netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c

[ 150.178921] ____sys_sendmsg from ___sys_sendmsg+0x68/0x94

[ 150.178956] ___sys_sendmsg from sys_sendmsg+0x4c/0x88

[ 150.178993] sys_sendmsg from ret_fast_syscall+0x0/0x54

[ 150.179022] Exception stack(0xf0c59fa8 to 0xf0c59ff0)

[ 150.179039] 9fa0: 00247210 00265500 00000004 befbd8c8 00000000 00000000

[ 150.179057] 9fc0: 00247210 00265500 00247198 00000128 b6f5f000
befbd994 00000001 00000004

[ 150.179070] 9fe0: 0000006c befbd880 b6f445bc b6aa7970

[ 150.179082] ---[ end trace 0000000000000000 ]---

[ 150.179093] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
reason -52

[ 150.287764] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)

[ 150.287792] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
reason -52

[ 150.397629] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)

[ 150.397663] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
reason -52

[ 150.507731] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)

[ 150.507760] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
reason -52

[ 152.267615] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)

[ 152.267652] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
reason -52

