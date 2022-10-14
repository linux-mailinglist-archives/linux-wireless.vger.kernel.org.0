Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27185FEE44
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 14:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJNM6m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 08:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJNM6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 08:58:41 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493B9E9862
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 05:58:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z8so3567692qtv.5
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jq6LhMCspnHKspeOoKPDLtF5mlEf0rNDfjH+XDhSDw=;
        b=oVliFS2Sa3VI5lgQkpzzqxIdiRXpRDzxjYFYetGKmfj//BHrIpq0yfROk0xM0HsOKX
         FvsUAoWM+Bq88EGthNA2KJo95uY92lfeJX4K4A4SxCVwHZqdhHxP6KiDOk1/Yt09/7+7
         WvEewmBJowUaKqEO/cKrUdwBaaCD9MqJDBpfC0hW5QvwJXdsgpKo/e4G2Hk55aEH6Wev
         nlMSuxV7avGhEVZMMQrKO8g7TIlrJjDro9PNDzfDXSOcS/CAqs2/75+gEyrTH58Rec0X
         ebhAYwUbl4BetFOHiYS7PDiDbTokkn82bz1Xp7D3NrX1t3LnVSvCXB/GeXsC9cvr6aUJ
         nrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Jq6LhMCspnHKspeOoKPDLtF5mlEf0rNDfjH+XDhSDw=;
        b=nU0bW1e0Y5eDOjYZjhn4oIC+k+cEPv3D+BvsVaHUMtNjzlevTBDkYv0nqm9iaUZqEc
         rXWGJe6q5dcBUthcvCvT5pKNf7lRyoPejpg3zDoqy8Bc+gxobue2A/fufWQMm8/lgcEz
         7h3W2WAx3xLgNIxwiID3dDf0e0xCNvI2IETmau+bK7sOh6RfBEEq/rWl6mbHfFuX5Qpv
         wXaBjx8Mi1nSpj/4kQlrINje10iNn4g24dIWC+sywAPmZQDs6g98AEzbWuCqWemEa2SP
         L2ypc4BgJigtC72FimGR/fVnOJIgPMfwBKJZkodUn690oo5Pu0bnpHfMstDD8NVLeh4J
         X01w==
X-Gm-Message-State: ACrzQf1PzAUruKr7ymghvjFdR+vQabeYIulfhFawc3Xqli/H4VoiicZD
        2DC4UpnCtuf+BR1uG1jzrNwJ7rKVPGxBBkhqnOCtDqGQUv8=
X-Google-Smtp-Source: AMsMyM7n3kKXshG5OKGi0LXmz/QURt01tLittvVBVDyAjsP7hCjFmptNBlD5RCJbmQRp2FOgAkq5Tyj2Jit2cczSzxk=
X-Received: by 2002:a05:622a:48d:b0:39c:b642:824d with SMTP id
 p13-20020a05622a048d00b0039cb642824dmr3959028qtx.109.1665752319176; Fri, 14
 Oct 2022 05:58:39 -0700 (PDT)
MIME-Version: 1.0
From:   Pavlo Pyshkin <pavel.pyshkin@gmail.com>
Date:   Fri, 14 Oct 2022 14:58:28 +0200
Message-ID: <CALgEgnfZGzfF5vx4GcV8AKMTJF0YeXS-vG1VEntgk=a9Oj3Paw@mail.gmail.com>
Subject: realtek drivers: AMD-Vi: Event logged [IO_PAGE_FAULT...
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greetings!

My system is LinuxMint 20.2 which is installed on Laptop HP ProBook
455 G7 (1F3M4EA), WiFi chip is RTL8822CE.

Time after time my WiFi stops and only reboot helps. When it happens I
have WiFi connection in tray, but there is no real connection even
with local router. When I try switch off WiFi in tray and then switch
on I can not connect to router, error appears. Only after reboot WiFi
works again.

This problem appeared very often with 5 GHz WiFi and with Kernels
before 5.17.0. In that combination WiFi stoped even when I visited
speedtest site. It was impossible to pass the speed test. It looked
like wifi card "choked" with huge data flow.

It was for 5.15... 5.16... Kernels, but after 5.17.0 situation became
better. The stopping of WiFi appears once per day or per few days. My
record is 10 days of stable work before WiFi stoped.
Of course, I googled about this problem and tried to do everything.
For example, disabled power management. I compiled new Kernels, now I
have 6.0 Kernel. But the situation is the same.

The result of dmesg when wifi is stopped is:

[433208.039535] rtw_8822ce 0000:02:00.0: timed out to flush pci tx ring[1]
[435127.696255] rtw_8822ce 0000:02:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=3D0x000b address=3D0xfebf3840 flags=3D0x0000]
[435137.009872] rtw_8822ce 0000:02:00.0: timed out to flush pci tx ring[1]
[435137.009977] rtw_8822ce 0000:02:00.0: timed out to flush pci tx ring[3]
[435137.010109] rtw_8822ce 0000:02:00.0: timed out to flush pci tx ring[1]
[435137.010208] rtw_8822ce 0000:02:00.0: timed out to flush pci tx ring[3]
[435137.339506] rtw_8822ce 0000:02:00.0: timed out to flush pci tx ring[1]
[435137.339622] rtw_8822ce 0000:02:00.0: timed out to flush pci tx ring[3]
[435137.339731] rtw_8822ce 0000:02:00.0: timed out to flush pci tx ring[5]
... and so on.

Every time when Wifi stopped I see the line like this:
[435127.696255] rtw_8822ce 0000:02:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=3D0x000b address=3D0xfebf3840 flags=3D0x0000]

I assume this message somehow related to the core of the problem.

Moreover, I have found this is not only my problem. Other people also
have the similar problem with realtek chips drivers. These are the
cases:
-----------------
1) Hello,

I noticed a problem with my rtw_8822ce wifi recently, it drops
connection randomly.  Hard reboot is required.  From NetworkManager it
looks like it is connected, but there is no internet connection.

In dmesg I have:
[  521.400458] rtw_8822ce 0000:01:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=3D0x0009 address=3D0xfbc81414 flags=3D0x0000]

When I am reconnection with NetworkManager in dmesg I have lots of these
[  629.991505] rtw_8822ce 0000:01:00.0: timed out to flush pci tx ring[1]

but from logs you can observe that it is in fact connected

Full log:
[   45.038243] rtw_8822ce 0000:01:00.0: enabling device (0000 -> 0003)
[   45.044230] rtw_8822ce 0000:01:00.0: Firmware version 9.9.4, H2C version=
 15
[   45.044485] rtw_8822ce 0000:01:00.0: Firmware version 9.9.10, H2C versio=
n 15
[   45.282040] rtw_8822ce 0000:01:00.0 wlp1s0: renamed from wlan0
[   46.264046] rtw_8822ce 0000:01:00.0: start vif 28:cd:c4:6b:a5:37 on port=
 0
[   46.265701] rtw_8822ce 0000:01:00.0: stop vif 28:cd:c4:6b:a5:37 on port =
0
[   46.493493] rtw_8822ce 0000:01:00.0: start vif de:2a:1e:61:0c:c0 on port=
 0
[   50.739107] rtw_8822ce 0000:01:00.0: stop vif de:2a:1e:61:0c:c0 on port =
0
[   50.967006] rtw_8822ce 0000:01:00.0: start vif 28:cd:c4:6b:a5:37 on port=
 0
[   50.971579] rtw_8822ce 0000:01:00.0: stop vif 28:cd:c4:6b:a5:37 on port =
0
[   51.205701] rtw_8822ce 0000:01:00.0: start vif a6:28:ed:35:f0:f0 on port=
 0
[   55.285903] rtw_8822ce 0000:01:00.0: stop vif a6:28:ed:35:f0:f0 on port =
0
[   55.515710] rtw_8822ce 0000:01:00.0: start vif 28:cd:c4:6b:a5:37 on port=
 0
[   60.163246] rtw_8822ce 0000:01:00.0: sta 5a:ef:68:a6:25:96 joined
with macid 0
[  521.400458] rtw_8822ce 0000:01:00.0: AMD-Vi: Event logged
[IO_PAGE_FAULT domain=3D0x0009 address=3D0xfbc81414 flags=3D0x0000]
[  629.991505] rtw_8822ce 0000:01:00.0: timed out to flush pci tx ring[1]
[  629.991610] rtw_8822ce 0000:01:00.0: timed out to flush pci tx ring[3]
[  629.991746] rtw_8822ce 0000:01:00.0: timed out to flush pci tx ring[1]
[  629.991844] rtw_8822ce 0000:01:00.0: timed out to flush pci tx ring[3]
[  630.262274] rtw_8822ce 0000:01:00.0: timed out to flush pci tx ring[1]
[  630.262383] rtw_8822ce 0000:01:00.0: timed out to flush pci tx ring[3]
[  630.262481] rtw_8822ce 0000:01:00.0: timed out to flush pci tx ring[5]
.=E2=80=A6
( https://bugzilla.kernel.org/show_bug.cgi?id=3D214097 )

2)  This happens whenever under medium load. It is very consistent.
When it occurs, there is no network connectivity until I ifconfig eth0
down/up, dhclient eth0. Then it works until I put a load on the
network card again by just pushing some files back and forth. Basic
Internet usage doesn't seem to trigger it, but higher speed traffic
to/from a machine on the network and poof, gone. The network card
still appears in lspci, ifconfig insists it is working, but no traffic
will move until I reset it. Dmesg line is:

[ 1140.466954] AMD-Vi: Event logged [IO_PAGE_FAULT device=3D28:00.0
domain=3D0x000b address=3D0x0000000001091000 flags=3D0x0050]

Device 28:00:00 is:

28:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)

Slackware 64 bit, current patch level, 4.4.88 kernel.

A bit of googling turned up some old complaints of this, having to do
with the nic driver.

I'm not quite sure where to go from here, other than trying a
different (newer or older) kernel. Advice welcome.

(  https://www.linuxquestions.org/questions/slackware-14/amd-vi-event-logge=
d-%5Bio_page_fault-ethernet-controller-4175615079/
 )

3)  So I recently upgraded the internals of my Ubuntu Server so that
it's running a new motherboard, new processor, etc. And ever since
then, I've been getting errors that look like this:
Code:
AMD-Vi: Event logged [IO_PAGE_FAULT device=3D02:00.0 domain 0x001d
address=3D0x0000000000003000 flags=3D0x0050]
Sometimes they don't appear to do anything, however sometimes after
encountering this, the network stops working properly.

I've searched for answers regarding this, however most are either
unresolved or involve hardware that isn't relevant here (such as the
graphics card causing the fault, and issues starting the desktop
environment). Running
Code:
sudo lspci -vnn | grep 02:00.0 -A9
confirms this and lists info about the ethernet controller:
Code:
02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
(rev. 0c)
        Subsystem: Micro-Star International Co., Ltd. [MSI] Device [1462:79=
69]
        Flags: bus master, fast devsel, latency 0, IRQ 87
        I/O ports at e000 [size=3D256]
        Memory at fe900000 (64-bit, non-prefetchable) [size=3D4K]
        Memory at d0800000 (64-bit, prefetchable) [size=3D16K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 01
        Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
I've also read that there is probably an issue with IOMMU, however I
have no way to control whether or not this is turned on in the BIOS
(there is no option), and adding
Code:
iommu=3Dpf
or
Code:
iommu=3Dsoft
doesn't have any effect on the problem. Is there anyone that could
shed some light on this? The server is currently unusable, since the
problem happens usually within 5 minutes of booting, and only a reboot
can fix it.

(  https://ubuntuforums.org/showthread.php?t=3D2290992  )

------------------------------

I hope my problem, and mentioned problem of other people shows that
there is objective problem with drivers for Realtek wifi cards. I hope
that this message will help to improve these drivers.

Thanks.
- - - - -
Pavlo Pyshkin, PhD
Phone: +380969266455
Web: pavlopyshkin . wordpress . com
