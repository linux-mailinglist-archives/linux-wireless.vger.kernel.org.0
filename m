Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370E32CE9A6
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 09:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgLDIbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 03:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgLDIbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 03:31:46 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAF4C061A4F
        for <linux-wireless@vger.kernel.org>; Fri,  4 Dec 2020 00:31:05 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z136so4957259iof.3
        for <linux-wireless@vger.kernel.org>; Fri, 04 Dec 2020 00:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UTWwhjcorEEfJLHE+vCaW/55G6hzw4fbEC2Y9Nz8soI=;
        b=Ton3n6XJX6t4O1oO0AbSZDGn0y7+k0Svu/9HGYJ/GYUiUy3/tvmHhde7lQRF5X+Qy3
         r6KpJdQuepgBYohRGxLQjwgc8LDTO/g9vJYklb0ok2741Ev9ji/ikPDOlTCC+d0sCw6c
         SPFw12TzzBByH1KOT/uWbVxWsSe6/C8VjilGX/o4HFcutcXj5BxxY4WgEmi42MU6kLvp
         7GkT+5Keq5+0VCW+mAI+uN2zTGVEbn7Rp0T49b4VCsLqfuazrqNCR9K3O3UBBvid3GBp
         OChgcUtf9GfYzVfkcB74ImSCo6uTETSChPOCUUY58Qeb0vGGZ9MmqV/wc6mI/vz2TQ9L
         jvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UTWwhjcorEEfJLHE+vCaW/55G6hzw4fbEC2Y9Nz8soI=;
        b=NNamH7FpDikX+PaFnzd1oMAV+D69PHczZr58TiFHXkgJmIEz2+4K6Tv72vLSDCGSRF
         dWTpiLRHfkhwbXR04u6kw9tJ3k7nx0ynBkcfdfysiZAeRhhTpHLefACyoJMTnX8B6b/a
         /8Zp7kRO36NBiUCOymOPG2CMDDjr/tKczEgWyoD4F5wwdO2kll4TksggaFoObiotGgJE
         Aj3U83sTd2oH5xni1KncTPAroaKXhP4xFgsu4Yv5E1MeDVAV/ht8bKJKu8EdjApv5N7/
         gG3gwRVeXVG2pGHr50ePiaQuozHAnWt+H75DWWXVy+JnMljRvKS3oItIqbjO/z9QAyEC
         y3jg==
X-Gm-Message-State: AOAM532PShn43VVWKgqeKwWfhF2h4L0Kpap3YBhi815igTXIU2PLsQrv
        OT3Ikrs0twvdAVKkjIdL5jPHoAZz9t2Qxc9NSP2/HdOTUCgDaw==
X-Google-Smtp-Source: ABdhPJyHFDd1um/csRoxJ0AqIdKRruPoOzSU4K5u2pEmrkeuJCEzBaGJnILXy0HVQ0WmOgmoimDlfzcHKJqY8nqjtgQ=
X-Received: by 2002:a05:6602:2dcf:: with SMTP id l15mr4853676iow.120.1607070665106;
 Fri, 04 Dec 2020 00:31:05 -0800 (PST)
MIME-Version: 1.0
From:   Venkat Hallale <venkathallale1@gmail.com>
Date:   Fri, 4 Dec 2020 14:00:55 +0530
Message-ID: <CAFXQVFBzEKjmo9u34ER8u40j2sW7Ack043RRO4D7yE5qBTnd+g@mail.gmail.com>
Subject: AR9271 driver not creating wlan0 interface
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am using the Olimex USB MOD-WIFI-AR9271 USB dongle on the ARM based
board with Linux kernel-4.12.29-yocto-standard. It is based on the
AR9271 chip-set and the drive I used which comes along with the main
line Kernel i.e. bundled with 4.2 kernel.


As it is loading all the required drivers, here is the lsmod output.

 root@337D66:~# lsmod
Module                  Size  Used by
ath9k_htc              57344  0
ath9k_common           16384  1 ath9k_htc
ath9k_hw              352256  2 ath9k_htc,ath9k_common
ath                    24576  3 ath9k_htc,ath9k_hw,ath9k_common
mac80211              512000  1 ath9k_htc
cfg80211              471040  4 ath9k_htc,mac80211,ath,ath9k_common
usb_f_ecm              16384  1
g_ether                16384  0
usb_f_rndis            24576  2 g_ether
u_ether                20480  3 usb_f_ecm,g_ether,usb_f_rndis
libcomposite           45056  3 usb_f_ecm,g_ether,usb_f_rndis
configfs               28672  4 usb_f_ecm,usb_f_rndis,libcomposite
leds_pca955x           16384  0
ci_hdrc_imx            20480  0
ci_hdrc                49152  1 ci_hdrc_imx
ehci_hcd               65536  1 ci_hdrc
usbmisc_imx            20480  1 ci_hdrc_imx


The dmesg logs are,

[  623.054126] usb 1-1.1: new high-speed USB device number 7 using ci_hdrc
[  623.243317] usb 1-1.1: ath9k_htc: Firmware
ath9k_htc/htc_9271-1.4.0.fw requested
[  623.541841] usb 1-1.1: ath9k_htc: Transferred FW:
ath9k_htc/htc_9271-1.4.0.fw, size: 51008
[  623.794152] ath9k_htc 1-1.1:1.0: ath9k_htc: HTC initialized with 33 credits
[  624.095253] ath9k_htc 1-1.1:1.0: ath9k_htc: FW Version: 1.4
[  624.100988] ath9k_htc 1-1.1:1.0: FW RMW support: On
[  624.106028] ath: EEPROM regdomain: 0x809c
[  624.106037] ath: EEPROM indicates we should expect a country code
[  624.106537] ath: doing EEPROM country->regdmn map search
[  624.106549] ath: country maps to regdmn code: 0x52
[  624.106557] ath: Country alpha2 being used: CN
[  624.106564] ath: Regpair used: 0x52
[  624.131101] ieee80211 phy1: Atheros AR9271 Rev:1
[  624.513216] usb 1-1.1: ath9k_htc: USB layer deinitialized


But it is not creating any wlan0 interfaces.  Any pointers to solve
this issue will be greatly appreciated.

If this is not the right forum to discuss, please excuse me and ignore
the email.

Regards,
Venkat
