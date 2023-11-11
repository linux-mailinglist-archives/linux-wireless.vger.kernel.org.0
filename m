Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5757E8C97
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 21:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjKKUak (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Nov 2023 15:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKUaj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Nov 2023 15:30:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C102D61
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 12:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699734627; x=1700339427; i=wahrenst@gmx.net;
        bh=If0X1LffeFc+tTxk5YRs6OSpj9R6JXfkzuFuFG1WuNE=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
         In-Reply-To;
        b=N2tWTTDGQlcNT+Vsr7P0IV9U4VDT90Tx2xBiCcBfVwFeMlw6CGxuLxOVErwfZSAp
         0QAx1gqjjvEDf1IZliGesOwD/8cB1PQNPErhPdOdMFt0wjo6lv7wUo3fMH//cduyi
         ipn4AFqeVQVT0nKs+qEwFO9yf/tj5r/c3m3VCZD3UEfn4SRAvVJLiaHeyh3x8KhwM
         yPmK279EonvfPB4JfyG2QhuBUBfc6op0XWCvnICg4+GbAjFZ67e9++VVlJ+XlUL1v
         MznCddrCdKGMe50/em0zzkNIdRESBXftqJDPbz8O8P6GgPFxP5H07GrjK2c/3vMld
         b+m6BtOs2Gw1HG1e0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDjA-1r6plV13oE-00Cjkh; Sat, 11
 Nov 2023 21:30:27 +0100
Message-ID: <5c462fac-b27d-41c0-a62c-a8951bf445d2@gmx.net>
Date:   Sat, 11 Nov 2023 21:30:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
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
Content-Language: en-US
In-Reply-To: <cb07408d-af14-4b01-bd96-15c480989643@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XVbUITVmhFznrRqcSg+h+F9G1/MYtfPWuz5b4/0gxlOhFj1xKMb
 9mPW0+gloe239MVveiWxXEHiVt70bsAPpaar48s0OUKx3WZ4twnZniQtDx5iTzd7O7FYDvS
 wnmAXedsOx31daWaYLFeRogVysZH3A4L9bCB7IOeyp7Fa2duxQGIbjHh4ClZscMSFiCDPk3
 dV8E12AhrfK1LMNjp/9XQ==
UI-OutboundReport: notjunk:1;M01:P0:UnwMHspM2Pg=;LsIMlDg/Be0mV1wS63b2OhORnrQ
 oTgtpOcSueXlNcUxPyK93hTlsXLZrY67cSE0Z7j6Hmz17wd4MjqrT08l+sAJNgCTKBh7S2bkW
 0NLUdYfx2VwN7bgDxTOSTgn8PAPvr80HzjW9H7Ew/MOtoFvGKLkdNFiGFROQgxzqQT0H5W6QH
 6V/aw4iPrpXG6fzWx7jI29d6xNNSuBq61JJsDYkgKS9sIfwF9879jlpiFFgg49BiPNqjFbFlR
 LH2+yr/jCofKqulSCjsoYZUD6Z0pINLYfJc2jMEZJM8gdAcG6VxbE7JDhEBHx44g9CosvM/6b
 mCKSjqH5owpVYXoypqhwF2vA7ql683Xij4ahXrOna2epEbRRgYSIeSmZZJ2T4usvzGsxG3USA
 5x+Jf1izrb71EPqrtQndQstzLTUT+REogVnVx7tuWtLsAeLBb0kK4X2q7BpWkSf/XCaB7RpQ0
 cp4L2xVKzHiDBybDj86jo4uDILcXHp3BbMMvTD5Ya+29o8GuSfqWPZvRLlz+aS9GLP7WOrp/D
 mBq+B1mnxg0IN7QPejdKCL8NwOUN8qdRYs7UwQgfM2HR4BwoImrcl/v5pEHVwmggXhuX/XbGl
 uQvPmS+LQR9LERN2ouYJvlxKxz+A4QBAu/neoqVU9YuljC0QORJz+WmPAiG/BVZWR2EshpF1U
 C6DqbUxcS4C/p2vVLubKqkNGEdF+EJvLePVT+Cd5aacq1kmtVD/ofPcM7bj0ba4xAufBy/FGs
 VTR37w99f/rjwpvbqRCeIsULBVZ3w1SzC0JjC1n94c/Ld9QEG6IiXSuh2Cdy6Y+JwRtLKrA4i
 yjhFln7W52pr7wLX8SLym+RQ7DomKXHqjCSgSECNFvpjIYuTSO6or+q8Ltac8iEld8Tzw8wZi
 rOXWivF6E1dBfU2lB3Ry8HrYPvgy+3Z+0nHsFqGl8HLHRvsKGBguC90+4VhvBqsqoeBLgESxC
 Oliy4g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 11.11.23 um 19:29 schrieb Stefan Wahren:
>
> Am 11.11.23 um 18:25 schrieb Arend Van Spriel:
>> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>>
>>
>> Again look like these are disabled channels. At least chanspec 0xd022
>> is 5G channel 34. You say you get this only once so not every 60
>> seconds?
> I get this everytime i trigger a reconnect to the wifi network, so not
> periodically (checked that). Strangely the initial automatic connect
> doesn't trigger this errors.
I additionally placed a WARN_ON_ONCE after the error log and enabled the
firmware error log of brcmf_fil_cmd_data(). Maybe this helps.

Here is the output after the first reconnect:

[=C2=A0=C2=A0 98.820098] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-20)
[=C2=A0=C2=A0 98.820135] ------------[ cut here ]------------
[=C2=A0=C2=A0 98.820145] WARNING: CPU: 3 PID: 469 at
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:8073
brcmf_cfg80211_dump_survey+0x330/0x348 [brcmfmac]
[=C2=A0=C2=A0 98.820256] Modules linked in: aes_arm aes_generic cmac brcmf=
mac_wcc
vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core sha256_generic
ac97_bus libsha256 snd_pcm_dmaengine sha256_arm snd_pcm cfg80211
hci_uart snd_timer btbcm snd bluetooth soundcore onboard_usb_hub
drm_dma_helper ecdh_generic ecc libaes raspberrypi_hwmon bcm2835_thermal
microchip lan78xx crc32_arm_ce
[=C2=A0=C2=A0 98.820459] CPU: 3 PID: 469 Comm: wpa_supplicant Not tainted
6.6.0-15494-g6bc986ab839c-dirty #136
[=C2=A0=C2=A0 98.820476] Hardware name: BCM2835
[=C2=A0=C2=A0 98.820495]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0=C2=A0 98.820534]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0=C2=A0 98.820564]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0=C2=A0 98.820600]=C2=A0 __warn from warn_slowpath_fmt+0x170/0x178
[=C2=A0=C2=A0 98.820636]=C2=A0 warn_slowpath_fmt from
brcmf_cfg80211_dump_survey+0x330/0x348 [brcmfmac]
[=C2=A0=C2=A0 98.820749]=C2=A0 brcmf_cfg80211_dump_survey [brcmfmac] from
nl80211_dump_survey+0x174/0x2bc [cfg80211]
[=C2=A0=C2=A0 98.821014]=C2=A0 nl80211_dump_survey [cfg80211] from genl_du=
mpit+0x38/0x74
[=C2=A0=C2=A0 98.821185]=C2=A0 genl_dumpit from netlink_dump+0x158/0x334
[=C2=A0=C2=A0 98.821211]=C2=A0 netlink_dump from __netlink_dump_start+0x1b=
c/0x27c
[=C2=A0=C2=A0 98.821234]=C2=A0 __netlink_dump_start from genl_rcv_msg+0x14=
8/0x358
[=C2=A0=C2=A0 98.821259]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10=
c
[=C2=A0=C2=A0 98.821285]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0=C2=A0 98.821310]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0=C2=A0 98.821336]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/=
0x454
[=C2=A0=C2=A0 98.821361]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0=
x26c
[=C2=A0=C2=A0 98.821393]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x=
94
[=C2=A0=C2=A0 98.821428]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0=C2=A0 98.821466]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0=C2=A0 98.821495] Exception stack(0xf10f9fa8 to 0xf10f9ff0)
[=C2=A0=C2=A0 98.821512] 9fa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0024721=
0 00247628 00000004
bed3d8c8 00000000 00000000
[=C2=A0=C2=A0 98.821530] 9fc0: 00247210 00247628 00247198 00000128 b6f3200=
0
bed3d994 00000001 00000004
[=C2=A0=C2=A0 98.821543] 9fe0: 0000006c bed3d880 b6f175bc b6a7a970
[=C2=A0=C2=A0 98.821554] ---[ end trace 0000000000000000 ]---
[=C2=A0=C2=A0 98.821566] brcmfmac: brcmf_set_channel: set chanspec 0xd022 =
fail,
reason -52
[=C2=A0=C2=A0 98.930254] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-20)
[=C2=A0=C2=A0 98.930287] brcmfmac: brcmf_set_channel: set chanspec 0xd026 =
fail,
reason -52
[=C2=A0=C2=A0 99.040104] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-20)
[=C2=A0=C2=A0 99.040134] brcmfmac: brcmf_set_channel: set chanspec 0xd02a =
fail,
reason -52
[=C2=A0=C2=A0 99.150242] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-20)
[=C2=A0=C2=A0 99.150279] brcmfmac: brcmf_set_channel: set chanspec 0xd02e =
fail,
reason -52
[=C2=A0 100.910174] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 100.910211] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
reason -52
[=C2=A0 115.670205] net_ratelimit: 10 callbacks suppressed
[=C2=A0 115.670232] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 115.670259] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
reason -52
[=C2=A0 115.780284] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 115.780313] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
reason -52
[=C2=A0 115.890261] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 115.890296] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
reason -52
[=C2=A0 116.000283] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 116.000313] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
reason -52
[=C2=A0 117.760217] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 117.760253] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
reason -52

>
> Regards
>>
>> Regards,
>> Arend
>>
>>> Best regards
>>>
>>> [1] -
>>> https://lore.kernel.org/linux-wireless/2635fd4f-dfa0-1d87-058b-e455cee=
96750@i2se.com/
>>>
>>> [2] -
>>> https://lore.kernel.org/linux-wireless/2635fd4f-dfa0-1d87-058b-e455cee=
96750@i2se.com/
>>>
>>
>>
>>
>

