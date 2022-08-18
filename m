Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3819597F6C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 09:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbiHRHmj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbiHRHmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 03:42:36 -0400
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDA16555A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 00:42:35 -0700 (PDT)
Date:   Thu, 18 Aug 2022 07:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1660808554; x=1661067754;
        bh=g5h/Wm/qy+Rw27cZR7sskbUZyZ3/x8+OxJJPOx18Vfw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=L38BcskR5pd/0mPnwLqTT63m6vKfumdlUL4ziC3rXHU1vQunnRomA2l5tS/SlD1PR
         kOqkEyhfv+XkZB/52ELbD8/mIOORb51a4+YrQ6SqPZ9CBwsN7nEPUmMeZh/HMbISX1
         6NICnEQntMYnQe9QjwfD3piZEIPwKhXxCfnI+Q83UY/cc9I7TmCbm6mE1p1IYvAkhn
         8nh52l7Yvc288VtvyCAL8k/OYUxxBczFcwGn/KdBc9gd3/7RaS5q4GqeWSuAXUy9gK
         KFx4GU0KOyZyLJCi2TrxZoqtqdSVwMnWyr6gKXy8ZBhgsMaP2QZ+c2bfEPk2+0hXyJ
         Qf6t3NQs/pGAQ==
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Cc:     "pkshih@realtek.com" <pkshih@realtek.com>
Reply-To: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Subject: Re: rtw88: Doesn't work for 60-90 seconds several times a day
Message-ID: <zo6mNApc8pZyF1NC9s5aXHV8KH9XRlJRwJuw031DGp4u2n9psBxnPVHBbHfJU7D1Zp5QrTbXRtHeEeTO06jl7QBcl6AM9IPkQ-4EqS-MdD0=@protonmail.com>
In-Reply-To: <Ej2iRcw0tVYRZD-CNBij8Uu3T-8IG-NVQ_EUM4Oz6IstXLQn0JKvkcfec1RDYKReWdi7JbPiMTOmeihtId1j91nq_IdMWYY482HTOXecGCg=@protonmail.com>
References: <Ej2iRcw0tVYRZD-CNBij8Uu3T-8IG-NVQ_EUM4Oz6IstXLQn0JKvkcfec1RDYKReWdi7JbPiMTOmeihtId1j91nq_IdMWYY482HTOXecGCg=@protonmail.com>
Feedback-ID: 34463299:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thursday, July 21st, 2022 at 12:35 AM, rtl8821cerfe2 <rtl8821cerfe2@prot=
onmail.com> wrote:

> Hello.
>=20
> I am unable to open any sites in Firefox for 60-90 seconds at a time.
> On one occasion it was 156 seconds. Firefox gives up after 20 seconds
> or so. NetworkManager reports "limited connectivity". The router doesn't
> reply to pings. The journal shows that the laptop remains connected to
> the router. This happens several times a day.
>=20
> However, my IRC client seems to be unaffected. It never detected any
> abnormally high lag during these events, not even the one that lasted
> 156 seconds. It checks the lag every 30 seconds. Also, the bot named
> "phrik" from the #archlinux-offtopic channel reacts immediately when
> I send it "!ping" during one of these events. (It sends back "pong".)
> So I guess existing connections are not affected.
>=20
> I have had this problem ever since support for RTL8821CE with RFE 2
> was added. (The wifi card's RFE type is 2.)
>=20
> Other devices connected to the same router don't have this problem.
>=20
> The laptop and the router are in the same room. The distance
> between them is about 3 meters.
>=20
>=20
> These are the things I tried which did not help:
>=20
> - The rtw88_core option disable_lps_deep=3D1
>=20
> - `iw wlo1 set power_save off`
>=20
> - Installing wireless-regdb and uncommenting my country in
> /etc/conf.d/wireless-regdom
>=20
> - Switching the router to "n only" mode. Previously it was in "b/g/n"
> mode.
>=20
> - Making the router use channel 9 instead of "auto". By itself it was
> selecting channels 1 or 11 the few times I checked that. Channel 9
> seemed less crowded than those.
>=20
> - Making the router use 40 MHz channel width instead of the "20/40"
> setting. This doubled the speed but didn't help with my problem.
>=20
> - The firmware from the rtl8821ce driver [0] (version 20.1.0),
> instead of the one from linux-firmware (version 24.11.0). I used the
> one with the length of 137616 bytes.
>=20
> This doesn't happen with the rtl8821ce driver, which is why I extracted
> that firmware from it, to see if it's a firmware issue.
>=20
>=20
> Pinging the router all day seems to prevent this problem. Enabling all
> the debug flags for rtw88_core also may prevent it. I'm not sure about
> that.
>=20
>=20
> Most of the time I don't have any bluetooth devices connected.
> When I do, they don't cause problems.
>=20
>=20
> I captured a bit of wifi traffic using another laptop, including two of
> these events, and noticed something strange:
>=20
> - rtw88 sends "Null function" telling the router it's going to sleep
> - router immediately sends ack (after less than 1 ms)
> - rtw88 resends "Null function" (same SN, Retry flag set)
> - router immediately sends ack
> - rtw88 resends
> - router immediately sends ack
> - rtw88 resends
> - ...
> - ...
>=20
> rtw88 resends the "Null function" 3-4 times, even though the router
> promptly sends ack each time, then it sends a new "Null function" with
> different SN and the process repeats. This seems to happen all the time,
> not just when I can't open any pages in Firefox. The rtl8821ce driver
> doesn't do this, but rtw88 with the old 20.1.0 firmware does. My phone
> doesn't do this either.
>=20
> I can provide the captures in private.
>=20
>=20
> Currently I'm using the rtw88_pci option disable_aspm=3D1, because kernel
> 5.18 brought the freezes back. [1]
>=20
>=20
> My laptop is HP 250 G7 with a Core i3 7020U CPU.
>=20
> The RTL8821CE wifi card is in M.2 slot, not soldered to the motherboard,
> even though the interface is named wlo1. It has one antenna, in case
> that matters.
>=20
> The router is a Fiberhome HG6544C.
>=20
> The network is secured with WPA2 Personal.
>=20
> The kernel version is 5.18.5-arch1-1.
>=20
> The wifi firmware version is 24.11.0.
>=20
> NetworkManager version is 1.38.2-1.
>=20
> wpa_supplicant version is 2.10-4.
>=20
> The operating system is Arch Linux.
>=20
>=20
>=20
> Just out of curiosity, what is C2H with id 0x15 ? It is not handled by
> rtw88, but the firmware sends it often.
>=20
>=20
> [0] https://raw.githubusercontent.com/tomaspinho/rtl8821ce/be733dc86781c6=
8571650b395dd0fa6b53c0a039/hal/rtl8821c/hal8821c_fw.c
> [1] https://lore.kernel.org/linux-wireless/Te_PJvJjKCi-lK28Zu0d8VQG0AGdwT=
l6cJydYEETLbc3gN0l8liXH1DSOZnKxUHYGxavLBCs1sqos2e6jeiRzzO0RLRSISdWvTiiPp0v9=
kM=3D@protonmail.com/


Frank's recent message [0] got me thinking and digging again. I added some =
rtw_warn and found something interesting:

2022-08-18T10:20:44.585943+0300 home wpa_supplicant[441]: wlo1: CTRL-EVENT-=
BEACON-LOSS
2022-08-18T10:20:44.592099+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_enqueue: sn: 128
2022-08-18T10:20:44.592997+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: src=3Df, sn=3D128, st=3D0
2022-08-18T10:20:44.593569+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: tx_report->queue: 128

2022-08-18T10:20:45.599099+0300 home wpa_supplicant[441]: wlo1: CTRL-EVENT-=
BEACON-LOSS
2022-08-18T10:20:45.602156+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_enqueue: sn: 132
2022-08-18T10:20:45.602924+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: src=3Df, sn=3D132, st=3D0
2022-08-18T10:20:45.603495+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: tx_report->queue: 132

2022-08-18T10:20:46.585960+0300 home wpa_supplicant[441]: wlo1: CTRL-EVENT-=
BEACON-LOSS
2022-08-18T10:20:46.592130+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_enqueue: sn: 136
2022-08-18T10:20:46.593381+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: src=3Df, sn=3D136, st=3D0
2022-08-18T10:20:46.594114+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: tx_report->queue: 136

2022-08-18T10:20:47.572620+0300 home wpa_supplicant[441]: wlo1: CTRL-EVENT-=
BEACON-LOSS
2022-08-18T10:20:47.575483+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_enqueue: sn: 140
2022-08-18T10:20:47.576486+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: src=3Df, sn=3D140, st=3D0
2022-08-18T10:20:47.577287+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: tx_report->queue: 140

2022-08-18T10:20:48.558864+0300 home wpa_supplicant[441]: wlo1: CTRL-EVENT-=
BEACON-LOSS
2022-08-18T10:20:48.562131+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_enqueue: sn: 144
2022-08-18T10:20:48.562394+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: src=3Df, sn=3D144, st=3D0
2022-08-18T10:20:48.562565+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: tx_report->queue: 144

2022-08-18T10:20:56.559084+0300 home wpa_supplicant[441]: wlo1: CTRL-EVENT-=
BEACON-LOSS
2022-08-18T10:20:56.562157+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_enqueue: sn: 148
2022-08-18T10:20:56.565498+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: src=3Df, sn=3D148, st=3D0
2022-08-18T10:20:56.566860+0300 home kernel: rtw_8821ce 0000:02:00.0: rtw_t=
x_report_handle: tx_report->queue: 148

It looks like the TX reports are coming in just a little too late. In my ca=
ptures I see the router sends the ack very quickly, and the card sends the =
TX reports pretty quickly after the requests are enqueued, so I assume rtw8=
8 is not transmitting quickly enough the frames that require a TX report?

I forgot to mention in my previous message that I'm on 2.4 GHz.


[0] https://lore.kernel.org/linux-wireless/6415466b-f745-df14-2a0b-40861bd1=
ea10@googlemail.com/
