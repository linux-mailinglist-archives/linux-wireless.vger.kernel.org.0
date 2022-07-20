Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F83857BFAC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 23:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiGTVgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 17:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGTVgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 17:36:04 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E11F2C5
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 14:36:02 -0700 (PDT)
Date:   Wed, 20 Jul 2022 21:35:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658352960; x=1658612160;
        bh=jH4VDOPv2lb/d3yrm1e5K4Tho7HF0+4gYPmK5Trdgk4=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=Debjlo6Fhvczg02s+bKqiwa59D37w9y5r9HfcN7F3Q7yOWJGKh66VWKgimV5IreHS
         ziB+oY0zzVHeIlvQr9aSvtFo0acM2XeMiY58VbFtpKBAa1q23K1ZEhap65zhD+gNDY
         0hKiWrgtCbw5xlSrMYfInlD1rsWu0cu+CSzDoZEUdroYQbdUcrNrq76nnmgBVJ5gRo
         aMNcl7NQRNz8mETbmnQT45gpumYIATD33ZGFsXMU+dGwfWJg+aO1Mx2A7uUSenjMFo
         2GVpfFS8A+CwQghg/VME2GZiMfZ3VUbeaMLLyJTv1j6U1evrkQvVZyGk5GgXcskmtE
         hc853zAS8eG8Q==
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Reply-To: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Subject: rtw88: Doesn't work for 60-90 seconds several times a day
Message-ID: <Ej2iRcw0tVYRZD-CNBij8Uu3T-8IG-NVQ_EUM4Oz6IstXLQn0JKvkcfec1RDYKReWdi7JbPiMTOmeihtId1j91nq_IdMWYY482HTOXecGCg=@protonmail.com>
Feedback-ID: 34463299:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello.

I am unable to open any sites in Firefox for 60-90 seconds at a time.
On one occasion it was 156 seconds. Firefox gives up after 20 seconds
or so. NetworkManager reports "limited connectivity". The router doesn't
reply to pings. The journal shows that the laptop remains connected to
the router. This happens several times a day.

However, my IRC client seems to be unaffected. It never detected any
abnormally high lag during these events, not even the one that lasted
156 seconds. It checks the lag every 30 seconds. Also, the bot named
"phrik" from the #archlinux-offtopic channel reacts immediately when
I send it "!ping" during one of these events. (It sends back "pong".)
So I guess existing connections are not affected.

I have had this problem ever since support for RTL8821CE with RFE 2
was added. (The wifi card's RFE type is 2.)

Other devices connected to the same router don't have this problem.

The laptop and the router are in the same room. The distance
between them is about 3 meters.


These are the things I tried which did not help:

- The rtw88_core option disable_lps_deep=3D1

- `iw wlo1 set power_save off`

- Installing wireless-regdb and uncommenting my country in
  /etc/conf.d/wireless-regdom

- Switching the router to "n only" mode. Previously it was in "b/g/n"
  mode.

- Making the router use channel 9 instead of "auto". By itself it was
  selecting channels 1 or 11 the few times I checked that. Channel 9
  seemed less crowded than those.

- Making the router use 40 MHz channel width instead of the "20/40"
  setting. This doubled the speed but didn't help with my problem.

- The firmware from the rtl8821ce driver [0] (version 20.1.0),
  instead of the one from linux-firmware (version 24.11.0). I used the
  one with the length of 137616 bytes.

This doesn't happen with the rtl8821ce driver, which is why I extracted
that firmware from it, to see if it's a firmware issue.


Pinging the router all day seems to prevent this problem. Enabling all
the debug flags for rtw88_core also *may* prevent it. I'm not sure about
that.


Most of the time I don't have any bluetooth devices connected.
When I do, they don't cause problems.


I captured a bit of wifi traffic using another laptop, including two of
these events, and noticed something strange:

- rtw88 sends "Null function" telling the router it's going to sleep
- router immediately sends ack (after less than 1 ms)
- rtw88 resends "Null function" (same SN, Retry flag set)
- router immediately sends ack
- rtw88 resends
- router immediately sends ack
- rtw88 resends
- ...
- ...

rtw88 resends the "Null function" 3-4 times, even though the router
promptly sends ack each time, then it sends a new "Null function" with
different SN and the process repeats. This seems to happen all the time,
not just when I can't open any pages in Firefox. The rtl8821ce driver
doesn't do this, but rtw88 with the old 20.1.0 firmware does. My phone
doesn't do this either.

I can provide the captures in private.


Currently I'm using the rtw88_pci option disable_aspm=3D1, because kernel
5.18 brought the freezes back. [1]


My laptop is HP 250 G7 with a Core i3 7020U CPU.

The RTL8821CE wifi card is in M.2 slot, not soldered to the motherboard,
even though the interface is named wlo1. It has one antenna, in case
that matters.

The router is a Fiberhome HG6544C.

The network is secured with WPA2 Personal.

The kernel version is 5.18.5-arch1-1.

The wifi firmware version is 24.11.0.

NetworkManager version is 1.38.2-1.

wpa_supplicant version is 2.10-4.

The operating system is Arch Linux.



Just out of curiosity, what is C2H with id 0x15 ? It is not handled by
rtw88, but the firmware sends it often.


[0] https://raw.githubusercontent.com/tomaspinho/rtl8821ce/be733dc86781c685=
71650b395dd0fa6b53c0a039/hal/rtl8821c/hal8821c_fw.c
[1] https://lore.kernel.org/linux-wireless/Te_PJvJjKCi-lK28Zu0d8VQG0AGdwTl6=
cJydYEETLbc3gN0l8liXH1DSOZnKxUHYGxavLBCs1sqos2e6jeiRzzO0RLRSISdWvTiiPp0v9kM=
=3D@protonmail.com/
