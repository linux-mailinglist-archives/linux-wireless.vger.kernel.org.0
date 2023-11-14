Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90D97EB79C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 21:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjKNUKk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 15:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjKNUK3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 15:10:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609C1AC
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699992596; x=1700597396; i=wahrenst@gmx.net;
        bh=PCT2wYVl46+Z/20hz99jDzs66CJqcpXgUZbXAvqs6QY=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
         In-Reply-To;
        b=rys8NfDvjHX1sw+BPI+FpCbeZm7/xfieW9No/0O9avQd6uR51HxyDSv/2g5AzOiC
         lTvglILFYz7UascT5S98HcCoCnhz1tpxpxPsqCOHUpFWmkwD7QCZpn3uI1Q1wKRW+
         FWEGXZFoxo0z/IRYizkTe6Ku3hYpdl+1LY0gvqMzGa8r6VkhDaCcuk3Tb9rXnMsjy
         juBS284jA3SkeATLP2bqh7VqRlL/5aRUccdu9V6ioRKiyTgdvKcs3p32xmKnM8b+g
         kLikIjXkJ19xsc+3xpqUOciJD7kX3qpvRejhaFcRLUSCvHU4lCNLx8OZJWj6M0Ng8
         2X5+S0Wx6gSw7EynKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1rPLwQ2vbi-015sJx; Tue, 14
 Nov 2023 21:09:56 +0100
Message-ID: <883759f3-a0b2-4da7-9e9c-9786bcffb1a4@gmx.net>
Date:   Tue, 14 Nov 2023 21:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
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
In-Reply-To: <ca0fd1c5-380d-4756-a33a-cb6c84014ce4@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fMsHPeLQF5EZRwXuIhGIk9OtGZ4A7x9wXjcXGqESfqZPoIydbzc
 H9yjQKzG4dwy8wZz3js+2tNvADnxX3HG2LqNsvLQ+3xtEMYrzWfO30Jz7i6zAdd/fAdNjrv
 9FeKSKdv5nhOBIKXzNgVmpLDb0aLvOdr33uSdfsanaQyfdQwzLFtzuOVvzWsJYVLLDEVlVr
 uQURmQoZsmcirmiOcsLvQ==
UI-OutboundReport: notjunk:1;M01:P0:ks7a2J0rQTc=;3fOUyXnjowlNkDpor6eZfLxfTU6
 NrKEvDxqV9LaX4MBD+UMb7a8yRxPCDwtw80tC1lkytwyBVMBxqHyurGlYtuqAOn/koDIePAlM
 YKv4iO/HIzIyL+zBqvrhYleZjEpIEd/tLbi0os8z0YyEjF6ZYhv+OKIic7G1gp3gI5vVVqQb0
 5fZ5/EGUcP1y06wWR4ZXESce1gTVPFaOItSWHJnfRXuHKu9Z4J8wU0yEJEC0NyODmaVz0rQuu
 J7gtmfkCAd3H6kAUTsffe1spgDCDLeNN2XHmZTF32rfG9FD28vMAvC2JGPKS8XTyzRrczHkaH
 t/bJzCKOow7b0xYN9cborPjXmEk0x0GZd8Ag/8gt30kqhms9KfqhK9EIhq6opnXmT2tzvTAXE
 K3NML0cMAkBNZLw8gw7jVHRbUzucdZsrm3+vVabJy53fFeE6xhR/PoZBF6hVQU83PohLRrYiE
 vFZC5L/PLBGJM1YclDv2Zpc+jL4e9ROD5DffXsRtGZbQ5TNhTyJcR0in3VDeQbDS1B/CwsrS6
 viPuNwXXBLNI32qsUe5t+hKy598VR8A6bH39P9JzJ3I1TssUOLhfeODsZKS3H8zn/SVtBQJnR
 2wS9q9zPob9wjQa4xEntN8k5znojewI4weXsYZF3Yjwy+bzlGvuE7Y0IyafG7/h5B/Ve9W3AM
 8zVFkZR1qpt8QKtZghYgjF21qR0Yvd11Wl7MeJ8MNokCkGUoZqTEsI5uLWa4MkRawFSgjRb68
 stx2zEruM1ujIKSVklDEM+k/cscVzAfau+IjRP3jVGB7zbmx8PWCEsyzrH7A9PeBz+WEGRFbd
 Ig1cuo7Vz3rO5+vvbgVIH/BxT0xKtY5Ua4RLJRN7pbbc9ZAjqR3BfUQUSwq/FHyWF0RQzaHR/
 9s/NCYVdMpk5krADCN2LfjlD44hXivlhHTU2LN0J/zZctuGBxwdji55bZbbTOVTZ9WTpTfJG2
 bGEM5VQA5wSN6JvFaWufkqrN3DI=
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

Hi Arend,

Am 13.11.23 um 22:02 schrieb Stefan Wahren:
> Hi Arend,
>
> Am 13.11.23 um 10:11 schrieb Arend van Spriel:
>> On 11/11/2023 9:30 PM, Stefan Wahren wrote:
>>> Am 11.11.23 um 19:29 schrieb Stefan Wahren:
>>>>
>>>> Am 11.11.23 um 18:25 schrieb Arend Van Spriel:
>>>>> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net>
>>>>> wrote:
>>>>>
>>>>>
>>>>> Again look like these are disabled channels. At least chanspec 0xd02=
2
>>>>> is 5G channel 34. You say you get this only once so not every 60
>>>>> seconds?
>>>> I get this everytime i trigger a reconnect to the wifi network, so no=
t
>>>> periodically (checked that). Strangely the initial automatic connect
>>>> doesn't trigger this errors.
>>> I additionally placed a WARN_ON_ONCE after the error log and enabled
>>> the
>>> firmware error log of brcmf_fil_cmd_data(). Maybe this helps.
>>
>> It does a bit. At least it shows this is happening with the
>> dump_survey (again). I don't really understand why though. It implies
>> the channel is not disabled, but unclear why. The channel flags are
>> changed in brcmf_construct_chaninfo() so we probably should focus
>> debug on that function.
>>
>

here are more traces. I placed a warning everytime channelspec 0xd090 is
encoded or decoded. I hope this helps. As you can see below most of them
are triggered periodically by wpa_supplicant.

[=C2=A0=C2=A0=C2=A0 8.975943] ------------[ cut here ]------------
[=C2=A0=C2=A0=C2=A0 8.975964] WARNING: CPU: 0 PID: 65 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:242
brcmu_d11ac_decchspec+0x1ac/0x304 [brcmutil]
[=C2=A0=C2=A0=C2=A0 8.975997] brcmu_d11ac_decchspec called chnum 144 + con=
trol 144 =3D
chanspec 0xd090
[=C2=A0=C2=A0=C2=A0 8.976004] Modules linked in: brcmfmac_wcc crc32_arm_ce=
 vc4 brcmfmac
snd_soc_hdmi_codec brcmutil snd_soc_core sha256_generic libsha256
sha256_arm ac97_bus hci_uart snd_pcm_dmaengine cfg80211 snd_pcm btbcm
snd_timer bluetooth snd soundcore ecdh_generic drm_dma_helper ecc
onboard_usb_hub(+) libaes raspberrypi_hwmon bcm2835_thermal microchip
lan78xx
[=C2=A0=C2=A0=C2=A0 8.976113] CPU: 0 PID: 65 Comm: kworker/0:2 Not tainted
6.6.0-15494-g6bc986ab839c-dirty #139
[=C2=A0=C2=A0=C2=A0 8.976121] Hardware name: BCM2835
[=C2=A0=C2=A0=C2=A0 8.976126] Workqueue: events request_firmware_work_func
[=C2=A0=C2=A0=C2=A0 8.976152]=C2=A0 unwind_backtrace from show_stack+0x10/=
0x14
[=C2=A0=C2=A0=C2=A0 8.976169]=C2=A0 show_stack from dump_stack_lvl+0x40/0x=
4c
[=C2=A0=C2=A0=C2=A0 8.976185]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0=C2=A0=C2=A0 8.976203]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x=
178
[=C2=A0=C2=A0=C2=A0 8.976219]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_dec=
chspec+0x1ac/0x304
[brcmutil]
[=C2=A0=C2=A0=C2=A0 8.976247]=C2=A0 brcmu_d11ac_decchspec [brcmutil] from
brcmf_setup_wiphybands+0x224/0x900 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.976307]=C2=A0 brcmf_setup_wiphybands [brcmfmac] from
brcmf_cfg80211_attach+0xa44/0x13c8 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.976375]=C2=A0 brcmf_cfg80211_attach [brcmfmac] from
brcmf_attach+0x184/0x4a4 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.976442]=C2=A0 brcmf_attach [brcmfmac] from
brcmf_sdio_firmware_callback+0x788/0x930 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.976508]=C2=A0 brcmf_sdio_firmware_callback [brcmfmac=
] from
brcmf_fw_request_done+0x160/0x180 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.976574]=C2=A0 brcmf_fw_request_done [brcmfmac] from
request_firmware_work_func+0x4c/0x88
[=C2=A0=C2=A0=C2=A0 8.976617]=C2=A0 request_firmware_work_func from proces=
s_one_work+0x168/0x374
[=C2=A0=C2=A0=C2=A0 8.976632]=C2=A0 process_one_work from worker_thread+0x=
29c/0x4e8
[=C2=A0=C2=A0=C2=A0 8.976642]=C2=A0 worker_thread from kthread+0xe0/0xfc
[=C2=A0=C2=A0=C2=A0 8.976657]=C2=A0 kthread from ret_from_fork+0x14/0x28
[=C2=A0=C2=A0=C2=A0 8.976670] Exception stack(0xf147dfb0 to 0xf147dff8)
[=C2=A0=C2=A0=C2=A0 8.976677] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 8.976684] dfc0: 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 8.976691] dfe0: 00000000 00000000 00000000 00000000 00=
000013 00000000
[=C2=A0=C2=A0=C2=A0 8.976696] ---[ end trace 0000000000000000 ]---
[=C2=A0=C2=A0=C2=A0 8.976703] ------------[ cut here ]------------
[=C2=A0=C2=A0=C2=A0 8.976706] WARNING: CPU: 0 PID: 65 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:97
brcmu_d11ac_encchspec+0x114/0x120 [brcmutil]
[=C2=A0=C2=A0=C2=A0 8.976721] brcmu_d11ac_encchspec called chanspec 0xd090=
 =3D chnum 144
[=C2=A0=C2=A0=C2=A0 8.976726] Modules linked in: brcmfmac_wcc crc32_arm_ce=
 vc4 brcmfmac
snd_soc_hdmi_codec brcmutil snd_soc_core sha256_generic libsha256
sha256_arm ac97_bus hci_uart snd_pcm_dmaengine cfg80211 snd_pcm btbcm
snd_timer bluetooth snd soundcore ecdh_generic drm_dma_helper ecc
onboard_usb_hub(+) libaes raspberrypi_hwmon bcm2835_thermal microchip
lan78xx
[=C2=A0=C2=A0=C2=A0 8.976802] CPU: 0 PID: 65 Comm: kworker/0:2 Tainted: G =
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
6.6.0-15494-g6bc986ab839c-dirty #139
[=C2=A0=C2=A0=C2=A0 8.976809] Hardware name: BCM2835
[=C2=A0=C2=A0=C2=A0 8.976813] Workqueue: events request_firmware_work_func
[=C2=A0=C2=A0=C2=A0 8.976824]=C2=A0 unwind_backtrace from show_stack+0x10/=
0x14
[=C2=A0=C2=A0=C2=A0 8.976837]=C2=A0 show_stack from dump_stack_lvl+0x40/0x=
4c
[=C2=A0=C2=A0=C2=A0 8.976849]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0=C2=A0=C2=A0 8.976864]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x=
178
[=C2=A0=C2=A0=C2=A0 8.976880]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_enc=
chspec+0x114/0x120
[brcmutil]
[=C2=A0=C2=A0=C2=A0 8.976898]=C2=A0 brcmu_d11ac_encchspec [brcmutil] from
brcmf_setup_wiphybands+0x56c/0x900 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.976943]=C2=A0 brcmf_setup_wiphybands [brcmfmac] from
brcmf_cfg80211_attach+0xa44/0x13c8 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.977010]=C2=A0 brcmf_cfg80211_attach [brcmfmac] from
brcmf_attach+0x184/0x4a4 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.977076]=C2=A0 brcmf_attach [brcmfmac] from
brcmf_sdio_firmware_callback+0x788/0x930 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.977143]=C2=A0 brcmf_sdio_firmware_callback [brcmfmac=
] from
brcmf_fw_request_done+0x160/0x180 [brcmfmac]
[=C2=A0=C2=A0=C2=A0 8.977209]=C2=A0 brcmf_fw_request_done [brcmfmac] from
request_firmware_work_func+0x4c/0x88
[=C2=A0=C2=A0=C2=A0 8.977251]=C2=A0 request_firmware_work_func from proces=
s_one_work+0x168/0x374
[=C2=A0=C2=A0=C2=A0 8.977263]=C2=A0 process_one_work from worker_thread+0x=
29c/0x4e8
[=C2=A0=C2=A0=C2=A0 8.977272]=C2=A0 worker_thread from kthread+0xe0/0xfc
[=C2=A0=C2=A0=C2=A0 8.977285]=C2=A0 kthread from ret_from_fork+0x14/0x28
[=C2=A0=C2=A0=C2=A0 8.977298] Exception stack(0xf147dfb0 to 0xf147dff8)
[=C2=A0=C2=A0=C2=A0 8.977304] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 8.977311] dfc0: 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 8.977318] dfe0: 00000000 00000000 00000000 00000000 00=
000013 00000000
[=C2=A0=C2=A0=C2=A0 8.977323] ---[ end trace 0000000000000000 ]---
[=C2=A0=C2=A0=C2=A0 9.088758] hub 1-1:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 9.088869] hub 1-1:1.0: 4 ports detected
[=C2=A0=C2=A0=C2=A0 9.092510] onboard-usb-hub 3f980000.usb:usb-port@1: sup=
ply vdd not
found, using dummy regulator
[=C2=A0=C2=A0=C2=A0 9.096491] onboard-usb-hub 3f980000.usb:usb-port@1:usb-=
port@1:
supply vdd not found, using dummy regulator
[=C2=A0=C2=A0=C2=A0 9.400501] hub 1-1:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 9.400604] hub 1-1:1.0: 4 ports detected
[=C2=A0=C2=A0=C2=A0 9.410719] onboard-usb-hub 3f980000.usb:usb-port@1:usb-=
port@1:
supply vdd not found, using dummy regulator
[=C2=A0=C2=A0=C2=A0 9.679050] Bluetooth: hci0: BCM: features 0x2f
[=C2=A0=C2=A0=C2=A0 9.680875] Bluetooth: hci0: BCM43455 37.4MHz Raspberry =
Pi 3+
[=C2=A0=C2=A0=C2=A0 9.680892] Bluetooth: hci0: BCM4345C0 (003.001.025) bui=
ld 0342
[=C2=A0=C2=A0=C2=A0 9.718250] usb 1-1.1: new high-speed USB device number =
7 using dwc2
[=C2=A0=C2=A0=C2=A0 9.849052] hub 1-1.1:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 9.849181] hub 1-1.1:1.0: 3 ports detected
[=C2=A0=C2=A0=C2=A0 9.948228] usb 1-1.3: new low-speed USB device number 8=
 using dwc2
[=C2=A0=C2=A0 10.086630] input: PixArt Microsoft USB Optical Mouse as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/0003:045E:00CB=
.0003/input/input2
[=C2=A0=C2=A0 10.086801] hid-generic 0003:045E:00CB.0003: input: USB HID v=
1.11
Mouse [PixArt Microsoft USB Optical Mouse] on usb-3f980000.usb-1.3/input0
[=C2=A0=C2=A0 10.178204] usb 1-1.1.2: new low-speed USB device number 9 us=
ing dwc2
[=C2=A0=C2=A0 10.330533] input: HID 046a:0011 as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003=
:046A:0011.0004/input/input3
[=C2=A0=C2=A0 10.398633] hid-generic 0003:046A:0011.0004: input: USB HID v=
1.11
Keyboard [HID 046a:0011] on usb-3f980000.usb-1.1.2/input0
[=C2=A0=C2=A0 10.698223] usb 1-1.1.1: new high-speed USB device number 10 =
using dwc2
[=C2=A0=C2=A0 11.094825] lan78xx 1-1.1.1:1.0 (unnamed net_device) (uniniti=
alized):
No External EEPROM. Setting MAC Speed
[=C2=A0=C2=A0 12.498318] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-23)
[=C2=A0=C2=A0 12.660488] Adding 102396k swap on /var/swap.=C2=A0 Priority:=
-2 extents:1
across:102396k SS
[=C2=A0=C2=A0 12.697733] brcmfmac: brcmf_construct_chaninfo called
[=C2=A0=C2=A0 13.152186] Bluetooth: MGMT ver 1.22
[=C2=A0=C2=A0 13.282983] lan78xx 1-1.1.1:1.0 eth0: Link is Down
[=C2=A0=C2=A0 24.316057] ieee80211 phy0: brcmf_fil_cmd_data: Firmware erro=
r: (-23)
[=C2=A0=C2=A0 91.455424] ------------[ cut here ]------------
[=C2=A0=C2=A0 91.455449] WARNING: CPU: 2 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:97
brcmu_d11ac_encchspec+0x114/0x120 [brcmutil]
[=C2=A0=C2=A0 91.455503] brcmu_d11ac_encchspec called chanspec 0xd090 =3D =
chnum 144
[=C2=A0=C2=A0 91.455516] Modules linked in: aes_arm aes_generic cmac brcmf=
mac_wcc
crc32_arm_ce vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core
sha256_generic libsha256 sha256_arm ac97_bus hci_uart snd_pcm_dmaengine
cfg80211 snd_pcm btbcm snd_timer bluetooth snd soundcore ecdh_generic
drm_dma_helper ecc onboard_usb_hub libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx
[=C2=A0=C2=A0 91.455717] CPU: 2 PID: 466 Comm: wpa_supplicant Tainted: G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-15494-g6bc98=
6ab839c-dirty #139
[=C2=A0=C2=A0 91.455734] Hardware name: BCM2835
[=C2=A0=C2=A0 91.455750]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0=C2=A0 91.455786]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0=C2=A0 91.455817]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0=C2=A0 91.455851]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x178
[=C2=A0=C2=A0 91.455887]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_encchspe=
c+0x114/0x120
[brcmutil]
[=C2=A0=C2=A0 91.455931]=C2=A0 brcmu_d11ac_encchspec [brcmutil] from
brcmf_run_escan+0x12c/0x370 [brcmfmac]
[=C2=A0=C2=A0 91.456041]=C2=A0 brcmf_run_escan [brcmfmac] from brcmf_do_es=
can+0x60/0xa8
[brcmfmac]
[=C2=A0=C2=A0 91.456197]=C2=A0 brcmf_do_escan [brcmfmac] from
brcmf_cfg80211_scan+0x10c/0x210 [brcmfmac]
[=C2=A0=C2=A0 91.456351]=C2=A0 brcmf_cfg80211_scan [brcmfmac] from
cfg80211_scan+0x14c/0x268 [cfg80211]
[=C2=A0=C2=A0 91.456613]=C2=A0 cfg80211_scan [cfg80211] from
nl80211_trigger_scan+0x304/0x630 [cfg80211]
[=C2=A0=C2=A0 91.456916]=C2=A0 nl80211_trigger_scan [cfg80211] from
genl_rcv_msg+0x240/0x358
[=C2=A0=C2=A0 91.457086]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10=
c
[=C2=A0=C2=A0 91.457113]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0=C2=A0 91.457138]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0=C2=A0 91.457163]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/=
0x454
[=C2=A0=C2=A0 91.457188]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0=
x26c
[=C2=A0=C2=A0 91.457221]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x=
94
[=C2=A0=C2=A0 91.457256]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0=C2=A0 91.457293]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0=C2=A0 91.457322] Exception stack(0xf111dfa8 to 0xf111dff0)
[=C2=A0=C2=A0 91.457340] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0024721=
0 0026f770 00000004
bea179c8 00000000 00000000
[=C2=A0=C2=A0 91.457357] dfc0: 00247210 0026f770 00247198 00000128 b6ef100=
0
00000000 00000001 00000004
[=C2=A0=C2=A0 91.457370] dfe0: 0000006c bea17980 b6ed65bc b6a39970
[=C2=A0=C2=A0 91.457382] ---[ end trace 0000000000000000 ]---
[=C2=A0 123.538108] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
23)
[=C2=A0 145.284330] ------------[ cut here ]------------
[=C2=A0 145.284347] WARNING: CPU: 3 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:97
brcmu_d11ac_encchspec+0x114/0x120 [brcmutil]
[=C2=A0 145.284376] brcmu_d11ac_encchspec called chanspec 0xd090 =3D chnum=
 144
[=C2=A0 145.284383] Modules linked in: aes_arm aes_generic cmac brcmfmac_w=
cc
crc32_arm_ce vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core
sha256_generic libsha256 sha256_arm ac97_bus hci_uart snd_pcm_dmaengine
cfg80211 snd_pcm btbcm snd_timer bluetooth snd soundcore ecdh_generic
drm_dma_helper ecc onboard_usb_hub libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx
[=C2=A0 145.284479] CPU: 3 PID: 466 Comm: wpa_supplicant Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-15494-g6bc98=
6ab839c-dirty #139
[=C2=A0 145.284487] Hardware name: BCM2835
[=C2=A0 145.284495]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0 145.284515]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0 145.284531]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0 145.284547]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x178
[=C2=A0 145.284563]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_encchspec+0x1=
14/0x120
[brcmutil]
[=C2=A0 145.284582]=C2=A0 brcmu_d11ac_encchspec [brcmutil] from
brcmf_run_escan+0x12c/0x370 [brcmfmac]
[=C2=A0 145.284636]=C2=A0 brcmf_run_escan [brcmfmac] from brcmf_do_escan+0=
x60/0xa8
[brcmfmac]
[=C2=A0 145.284703]=C2=A0 brcmf_do_escan [brcmfmac] from
brcmf_cfg80211_scan+0x10c/0x210 [brcmfmac]
[=C2=A0 145.284769]=C2=A0 brcmf_cfg80211_scan [brcmfmac] from
cfg80211_scan+0x14c/0x268 [cfg80211]
[=C2=A0 145.284992]=C2=A0 cfg80211_scan [cfg80211] from
nl80211_trigger_scan+0x304/0x630 [cfg80211]
[=C2=A0 145.285294]=C2=A0 nl80211_trigger_scan [cfg80211] from
genl_rcv_msg+0x240/0x358
[=C2=A0 145.285467]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c
[=C2=A0 145.285494]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0 145.285519]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0 145.285545]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/0x454
[=C2=A0 145.285569]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c
[=C2=A0 145.285601]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
[=C2=A0 145.285637]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0 145.285674]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0 145.285703] Exception stack(0xf111dfa8 to 0xf111dff0)
[=C2=A0 145.285721] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00247210 0027=
2f60 00000004
bea179c8 00000000 00000000
[=C2=A0 145.285738] dfc0: 00247210 00272f60 00247198 00000128 b6ef1000
00000000 00000001 00000004
[=C2=A0 145.285752] dfe0: 0000006c bea17980 b6ed65bc b6a39970
[=C2=A0 145.285776] ---[ end trace 0000000000000000 ]---
[=C2=A0 149.309644] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 149.309682] ------------[ cut here ]------------
[=C2=A0 149.309693] WARNING: CPU: 3 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:8077
brcmf_cfg80211_dump_survey+0x330/0x348 [brcmfmac]
[=C2=A0 149.309804] Modules linked in: aes_arm aes_generic cmac brcmfmac_w=
cc
crc32_arm_ce vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core
sha256_generic libsha256 sha256_arm ac97_bus hci_uart snd_pcm_dmaengine
cfg80211 snd_pcm btbcm snd_timer bluetooth snd soundcore ecdh_generic
drm_dma_helper ecc onboard_usb_hub libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx
[=C2=A0 149.310007] CPU: 3 PID: 466 Comm: wpa_supplicant Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-15494-g6bc98=
6ab839c-dirty #139
[=C2=A0 149.310025] Hardware name: BCM2835
[=C2=A0 149.310041]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0 149.310079]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0 149.310109]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0 149.310144]=C2=A0 __warn from warn_slowpath_fmt+0x170/0x178
[=C2=A0 149.310181]=C2=A0 warn_slowpath_fmt from
brcmf_cfg80211_dump_survey+0x330/0x348 [brcmfmac]
[=C2=A0 149.310284]=C2=A0 brcmf_cfg80211_dump_survey [brcmfmac] from
nl80211_dump_survey+0x174/0x2bc [cfg80211]
[=C2=A0 149.310559]=C2=A0 nl80211_dump_survey [cfg80211] from genl_dumpit+=
0x38/0x74
[=C2=A0 149.310731]=C2=A0 genl_dumpit from netlink_dump+0x158/0x334
[=C2=A0 149.310756]=C2=A0 netlink_dump from __netlink_dump_start+0x1bc/0x2=
7c
[=C2=A0 149.310780]=C2=A0 __netlink_dump_start from genl_rcv_msg+0x148/0x3=
58
[=C2=A0 149.310805]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c
[=C2=A0 149.310831]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0 149.310856]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0 149.310882]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/0x454
[=C2=A0 149.310908]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c
[=C2=A0 149.310939]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
[=C2=A0 149.310975]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0 149.311013]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0 149.311043] Exception stack(0xf111dfa8 to 0xf111dff0)
[=C2=A0 149.311062] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00247210 0027=
4eb0 00000004
bea168c8 00000000 00000000
[=C2=A0 149.311079] dfc0: 00247210 00274eb0 00247198 00000128 b6ef1000
bea16994 00000001 00000004
[=C2=A0 149.311094] dfe0: 0000006c bea16880 b6ed65bc b6a39970
[=C2=A0 149.311105] ---[ end trace 0000000000000000 ]---
[=C2=A0 149.311115] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
reason -52
[=C2=A0 149.419712] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 149.419741] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
reason -52
[=C2=A0 149.529708] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 149.529738] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
reason -52
[=C2=A0 149.639725] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 149.639754] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
reason -52
[=C2=A0 151.399302] ------------[ cut here ]------------
[=C2=A0 151.399327] WARNING: CPU: 3 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:97
brcmu_d11ac_encchspec+0x114/0x120 [brcmutil]
[=C2=A0 151.399380] brcmu_d11ac_encchspec called chanspec 0xd090 =3D chnum=
 144
[=C2=A0 151.399392] Modules linked in: aes_arm aes_generic cmac brcmfmac_w=
cc
crc32_arm_ce vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core
sha256_generic libsha256 sha256_arm ac97_bus hci_uart snd_pcm_dmaengine
cfg80211 snd_pcm btbcm snd_timer bluetooth snd soundcore ecdh_generic
drm_dma_helper ecc onboard_usb_hub libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx
[=C2=A0 151.399596] CPU: 3 PID: 466 Comm: wpa_supplicant Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-15494-g6bc98=
6ab839c-dirty #139
[=C2=A0 151.399613] Hardware name: BCM2835
[=C2=A0 151.399629]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0 151.399666]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0 151.399697]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0 151.399732]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x178
[=C2=A0 151.399768]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_encchspec+0x1=
14/0x120
[brcmutil]
[=C2=A0 151.399813]=C2=A0 brcmu_d11ac_encchspec [brcmutil] from
brcmf_cfg80211_dump_survey+0xe8/0x348 [brcmfmac]
[=C2=A0 151.399925]=C2=A0 brcmf_cfg80211_dump_survey [brcmfmac] from
nl80211_dump_survey+0x174/0x2bc [cfg80211]
[=C2=A0 151.400191]=C2=A0 nl80211_dump_survey [cfg80211] from genl_dumpit+=
0x38/0x74
[=C2=A0 151.400361]=C2=A0 genl_dumpit from netlink_dump+0x158/0x334
[=C2=A0 151.400386]=C2=A0 netlink_dump from __netlink_dump_start+0x1bc/0x2=
7c
[=C2=A0 151.400410]=C2=A0 __netlink_dump_start from genl_rcv_msg+0x148/0x3=
58
[=C2=A0 151.400435]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c
[=C2=A0 151.400461]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0 151.400486]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0 151.400512]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/0x454
[=C2=A0 151.400537]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c
[=C2=A0 151.400569]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
[=C2=A0 151.400605]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0 151.400642]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0 151.400671] Exception stack(0xf111dfa8 to 0xf111dff0)
[=C2=A0 151.400689] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00247210 0027=
4eb0 00000004
bea168c8 00000000 00000000
[=C2=A0 151.400706] dfc0: 00247210 00274eb0 00247198 00000128 b6ef1000
bea16994 00000001 00000004
[=C2=A0 151.400720] dfe0: 0000006c bea16880 b6ed65bc b6a39970
[=C2=A0 151.400731] ---[ end trace 0000000000000000 ]---
[=C2=A0 151.401108] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-=
20)
[=C2=A0 151.401128] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
reason -52
[=C2=A0 151.503492] ------------[ cut here ]------------
[=C2=A0 151.503514] WARNING: CPU: 3 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:97
brcmu_d11ac_encchspec+0x114/0x120 [brcmutil]
[=C2=A0 151.503544] brcmu_d11ac_encchspec called chanspec 0xd090 =3D chnum=
 144
[=C2=A0 151.503549] Modules linked in: aes_arm aes_generic cmac brcmfmac_w=
cc
crc32_arm_ce vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core
sha256_generic libsha256 sha256_arm ac97_bus hci_uart snd_pcm_dmaengine
cfg80211 snd_pcm btbcm snd_timer bluetooth snd soundcore ecdh_generic
drm_dma_helper ecc onboard_usb_hub libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx
[=C2=A0 151.503648] CPU: 3 PID: 466 Comm: wpa_supplicant Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-15494-g6bc98=
6ab839c-dirty #139
[=C2=A0 151.503656] Hardware name: BCM2835
[=C2=A0 151.503665]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0 151.503685]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0 151.503701]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0 151.503717]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x178
[=C2=A0 151.503732]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_encchspec+0x1=
14/0x120
[brcmutil]
[=C2=A0 151.503753]=C2=A0 brcmu_d11ac_encchspec [brcmutil] from
brcmf_run_escan+0x12c/0x370 [brcmfmac]
[=C2=A0 151.503811]=C2=A0 brcmf_run_escan [brcmfmac] from brcmf_do_escan+0=
x60/0xa8
[brcmfmac]
[=C2=A0 151.503879]=C2=A0 brcmf_do_escan [brcmfmac] from
brcmf_cfg80211_scan+0x10c/0x210 [brcmfmac]
[=C2=A0 151.503946]=C2=A0 brcmf_cfg80211_scan [brcmfmac] from
cfg80211_scan+0x14c/0x268 [cfg80211]
[=C2=A0 151.504092]=C2=A0 cfg80211_scan [cfg80211] from
nl80211_trigger_scan+0x304/0x630 [cfg80211]
[=C2=A0 151.504222]=C2=A0 nl80211_trigger_scan [cfg80211] from
genl_rcv_msg+0x240/0x358
[=C2=A0 151.504297]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c
[=C2=A0 151.504308]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0 151.504319]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0 151.504330]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/0x454
[=C2=A0 151.504341]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c
[=C2=A0 151.504357]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
[=C2=A0 151.504372]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0 151.504388]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0 151.504403] Exception stack(0xf111dfa8 to 0xf111dff0)
[=C2=A0 151.504411] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00247210 0027=
4eb0 00000004
bea179c8 00000000 00000000
[=C2=A0 151.504418] dfc0: 00247210 00274eb0 00247198 00000128 b6ef1000
00000000 00000001 00000004
[=C2=A0 151.504424] dfe0: 0000006c bea17980 b6ed65bc b6a39970
[=C2=A0 151.504431] ---[ end trace 0000000000000000 ]---
[=C2=A0 211.470819] ------------[ cut here ]------------
[=C2=A0 211.470844] WARNING: CPU: 3 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:97
brcmu_d11ac_encchspec+0x114/0x120 [brcmutil]
[=C2=A0 211.470897] brcmu_d11ac_encchspec called chanspec 0xd090 =3D chnum=
 144
[=C2=A0 211.470909] Modules linked in: aes_arm aes_generic cmac brcmfmac_w=
cc
crc32_arm_ce vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core
sha256_generic libsha256 sha256_arm ac97_bus hci_uart snd_pcm_dmaengine
cfg80211 snd_pcm btbcm snd_timer bluetooth snd soundcore ecdh_generic
drm_dma_helper ecc onboard_usb_hub libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx
[=C2=A0 211.471110] CPU: 3 PID: 466 Comm: wpa_supplicant Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-15494-g6bc98=
6ab839c-dirty #139
[=C2=A0 211.471127] Hardware name: BCM2835
[=C2=A0 211.471142]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0 211.471179]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0 211.471210]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0 211.471244]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x178
[=C2=A0 211.471280]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_encchspec+0x1=
14/0x120
[brcmutil]
[=C2=A0 211.471324]=C2=A0 brcmu_d11ac_encchspec [brcmutil] from
brcmf_run_escan+0x12c/0x370 [brcmfmac]
[=C2=A0 211.471440]=C2=A0 brcmf_run_escan [brcmfmac] from brcmf_do_escan+0=
x60/0xa8
[brcmfmac]
[=C2=A0 211.471594]=C2=A0 brcmf_do_escan [brcmfmac] from
brcmf_cfg80211_scan+0x10c/0x210 [brcmfmac]
[=C2=A0 211.471749]=C2=A0 brcmf_cfg80211_scan [brcmfmac] from
cfg80211_scan+0x14c/0x268 [cfg80211]
[=C2=A0 211.472012]=C2=A0 cfg80211_scan [cfg80211] from
nl80211_trigger_scan+0x304/0x630 [cfg80211]
[=C2=A0 211.472321]=C2=A0 nl80211_trigger_scan [cfg80211] from
genl_rcv_msg+0x240/0x358
[=C2=A0 211.472490]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c
[=C2=A0 211.472517]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0 211.472542]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0 211.472567]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/0x454
[=C2=A0 211.472591]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c
[=C2=A0 211.472624]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
[=C2=A0 211.472660]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0 211.472697]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0 211.472727] Exception stack(0xf111dfa8 to 0xf111dff0)
[=C2=A0 211.472744] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00247210 0026=
a638 00000004
bea179c8 00000000 00000000
[=C2=A0 211.472762] dfc0: 00247210 0026a638 00247198 00000128 b6ef1000
00000000 00000001 00000004
[=C2=A0 211.472776] dfe0: 0000006c bea17980 b6ed65bc b6a39970
[=C2=A0 211.472787] ---[ end trace 0000000000000000 ]---
[=C2=A0 271.474968] ------------[ cut here ]------------
[=C2=A0 271.474991] WARNING: CPU: 3 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:97
brcmu_d11ac_encchspec+0x114/0x120 [brcmutil]
[=C2=A0 271.475044] brcmu_d11ac_encchspec called chanspec 0xd090 =3D chnum=
 144
[=C2=A0 271.475057] Modules linked in: aes_arm aes_generic cmac brcmfmac_w=
cc
crc32_arm_ce vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core
sha256_generic libsha256 sha256_arm ac97_bus hci_uart snd_pcm_dmaengine
cfg80211 snd_pcm btbcm snd_timer bluetooth snd soundcore ecdh_generic
drm_dma_helper ecc onboard_usb_hub libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx
[=C2=A0 271.475258] CPU: 3 PID: 466 Comm: wpa_supplicant Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-15494-g6bc98=
6ab839c-dirty #139
[=C2=A0 271.475276] Hardware name: BCM2835
[=C2=A0 271.475292]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0 271.475327]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0 271.475357]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0 271.475393]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x178
[=C2=A0 271.475429]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_encchspec+0x1=
14/0x120
[brcmutil]
[=C2=A0 271.475473]=C2=A0 brcmu_d11ac_encchspec [brcmutil] from
brcmf_run_escan+0x12c/0x370 [brcmfmac]
[=C2=A0 271.475588]=C2=A0 brcmf_run_escan [brcmfmac] from brcmf_do_escan+0=
x60/0xa8
[brcmfmac]
[=C2=A0 271.475742]=C2=A0 brcmf_do_escan [brcmfmac] from
brcmf_cfg80211_scan+0x10c/0x210 [brcmfmac]
[=C2=A0 271.475895]=C2=A0 brcmf_cfg80211_scan [brcmfmac] from
cfg80211_scan+0x14c/0x268 [cfg80211]
[=C2=A0 271.476158]=C2=A0 cfg80211_scan [cfg80211] from
nl80211_trigger_scan+0x304/0x630 [cfg80211]
[=C2=A0 271.476461]=C2=A0 nl80211_trigger_scan [cfg80211] from
genl_rcv_msg+0x240/0x358
[=C2=A0 271.476630]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c
[=C2=A0 271.476658]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0 271.476683]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0 271.476708]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/0x454
[=C2=A0 271.476733]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c
[=C2=A0 271.476765]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
[=C2=A0 271.476800]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0 271.476837]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0 271.476866] Exception stack(0xf111dfa8 to 0xf111dff0)
[=C2=A0 271.476884] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00247210 0026=
b968 00000004
bea179c8 00000000 00000000
[=C2=A0 271.476901] dfc0: 00247210 0026b968 00247198 00000128 b6ef1000
00000000 00000001 00000004
[=C2=A0 271.476914] dfe0: 0000006c bea17980 b6ed65bc b6a39970
[=C2=A0 271.476926] ---[ end trace 0000000000000000 ]---
[=C2=A0 331.477561] ------------[ cut here ]------------
[=C2=A0 331.477586] WARNING: CPU: 0 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:97
brcmu_d11ac_encchspec+0x114/0x120 [brcmutil]
[=C2=A0 331.477640] brcmu_d11ac_encchspec called chanspec 0xd090 =3D chnum=
 144
[=C2=A0 331.477658] Modules linked in: aes_arm aes_generic cmac brcmfmac_w=
cc
crc32_arm_ce vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core
sha256_generic libsha256 sha256_arm ac97_bus hci_uart snd_pcm_dmaengine
cfg80211 snd_pcm btbcm snd_timer bluetooth snd soundcore ecdh_generic
drm_dma_helper ecc onboard_usb_hub libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx
[=C2=A0 331.477866] CPU: 0 PID: 466 Comm: wpa_supplicant Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-15494-g6bc98=
6ab839c-dirty #139
[=C2=A0 331.477883] Hardware name: BCM2835
[=C2=A0 331.477898]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0 331.477935]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0 331.477964]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0 331.477999]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x178
[=C2=A0 331.478035]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_encchspec+0x1=
14/0x120
[brcmutil]
[=C2=A0 331.478080]=C2=A0 brcmu_d11ac_encchspec [brcmutil] from
brcmf_run_escan+0x12c/0x370 [brcmfmac]
[=C2=A0 331.478191]=C2=A0 brcmf_run_escan [brcmfmac] from brcmf_do_escan+0=
x60/0xa8
[brcmfmac]
[=C2=A0 331.478347]=C2=A0 brcmf_do_escan [brcmfmac] from
brcmf_cfg80211_scan+0x10c/0x210 [brcmfmac]
[=C2=A0 331.478501]=C2=A0 brcmf_cfg80211_scan [brcmfmac] from
cfg80211_scan+0x14c/0x268 [cfg80211]
[=C2=A0 331.478755]=C2=A0 cfg80211_scan [cfg80211] from
nl80211_trigger_scan+0x304/0x630 [cfg80211]
[=C2=A0 331.479058]=C2=A0 nl80211_trigger_scan [cfg80211] from
genl_rcv_msg+0x240/0x358
[=C2=A0 331.479228]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c
[=C2=A0 331.479256]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0 331.479280]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0 331.479305]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/0x454
[=C2=A0 331.479330]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c
[=C2=A0 331.479363]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
[=C2=A0 331.479398]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0 331.479435]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0 331.479464] Exception stack(0xf111dfa8 to 0xf111dff0)
[=C2=A0 331.479481] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00247210 0027=
63b8 00000004
bea179c8 00000000 00000000
[=C2=A0 331.479498] dfc0: 00247210 002763b8 00247198 00000128 b6ef1000
00000000 00000001 00000004
[=C2=A0 331.479512] dfe0: 0000006c bea17980 b6ed65bc b6a39970
[=C2=A0 331.479548] ---[ end trace 0000000000000000 ]---
[=C2=A0 391.479034] ------------[ cut here ]------------
[=C2=A0 391.479056] WARNING: CPU: 0 PID: 466 at
drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c:97
brcmu_d11ac_encchspec+0x114/0x120 [brcmutil]
[=C2=A0 391.479102] brcmu_d11ac_encchspec called chanspec 0xd090 =3D chnum=
 144
[=C2=A0 391.479113] Modules linked in: aes_arm aes_generic cmac brcmfmac_w=
cc
crc32_arm_ce vc4 brcmfmac snd_soc_hdmi_codec brcmutil snd_soc_core
sha256_generic libsha256 sha256_arm ac97_bus hci_uart snd_pcm_dmaengine
cfg80211 snd_pcm btbcm snd_timer bluetooth snd soundcore ecdh_generic
drm_dma_helper ecc onboard_usb_hub libaes raspberrypi_hwmon
bcm2835_thermal microchip lan78xx
[=C2=A0 391.479301] CPU: 0 PID: 466 Comm: wpa_supplicant Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.6.0-15494-g6bc98=
6ab839c-dirty #139
[=C2=A0 391.479316] Hardware name: BCM2835
[=C2=A0 391.479331]=C2=A0 unwind_backtrace from show_stack+0x10/0x14
[=C2=A0 391.479362]=C2=A0 show_stack from dump_stack_lvl+0x40/0x4c
[=C2=A0 391.479389]=C2=A0 dump_stack_lvl from __warn+0x7c/0x124
[=C2=A0 391.479419]=C2=A0 __warn from warn_slowpath_fmt+0x110/0x178
[=C2=A0 391.479450]=C2=A0 warn_slowpath_fmt from brcmu_d11ac_encchspec+0x1=
14/0x120
[brcmutil]
[=C2=A0 391.479489]=C2=A0 brcmu_d11ac_encchspec [brcmutil] from
brcmf_run_escan+0x12c/0x370 [brcmfmac]
[=C2=A0 391.479586]=C2=A0 brcmf_run_escan [brcmfmac] from brcmf_do_escan+0=
x60/0xa8
[brcmfmac]
[=C2=A0 391.479718]=C2=A0 brcmf_do_escan [brcmfmac] from
brcmf_cfg80211_scan+0x10c/0x210 [brcmfmac]
[=C2=A0 391.479850]=C2=A0 brcmf_cfg80211_scan [brcmfmac] from
cfg80211_scan+0x14c/0x268 [cfg80211]
[=C2=A0 391.480070]=C2=A0 cfg80211_scan [cfg80211] from
nl80211_trigger_scan+0x304/0x630 [cfg80211]
[=C2=A0 391.480332]=C2=A0 nl80211_trigger_scan [cfg80211] from
genl_rcv_msg+0x240/0x358
[=C2=A0 391.480478]=C2=A0 genl_rcv_msg from netlink_rcv_skb+0xb4/0x10c
[=C2=A0 391.480501]=C2=A0 netlink_rcv_skb from genl_rcv+0x24/0x34
[=C2=A0 391.480523]=C2=A0 genl_rcv from netlink_unicast+0x1f4/0x2d0
[=C2=A0 391.480545]=C2=A0 netlink_unicast from netlink_sendmsg+0x1cc/0x454
[=C2=A0 391.480566]=C2=A0 netlink_sendmsg from ____sys_sendmsg+0xa0/0x26c
[=C2=A0 391.480593]=C2=A0 ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
[=C2=A0 391.480623]=C2=A0 ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[=C2=A0 391.480655]=C2=A0 sys_sendmsg from ret_fast_syscall+0x0/0x54
[=C2=A0 391.480681] Exception stack(0xf111dfa8 to 0xf111dff0)
[=C2=A0 391.480696] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00247210 0024=
7628 00000004
bea179c8 00000000 00000000
[=C2=A0 391.480711] dfc0: 00247210 00247628 00247198 00000128 b6ef1000
00000000 00000001 00000004
[=C2=A0 391.480723] dfe0: 0000006c bea17980 b6ed65bc b6a39970
[=C2=A0 391.480755] ---[ end trace 0000000000000000 ]---
