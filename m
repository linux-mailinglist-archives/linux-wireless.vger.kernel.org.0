Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46E63D47D5
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhGXMmK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhGXMmK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 08:42:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE9C061575
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 06:22:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h2so6834813lfu.4
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=VBLFlRAveNTm5y3VkIIxRsoerOpfI7g0oHLz1FFsyNg=;
        b=esgbJKw6zXQ6xwmd2/J5oD+jLp5BzyxM7Hc4Ug+UHyUaFkoPVdUIVF3k2PgfH91l06
         ly1K/IGH7TQVSQ6foFRLzwcF4560CF7FTbpUCmnEeQbymYc6GgAtXKlr6iEIz8Uk+a6h
         oWtDI5673tmucNEwW9vWuCzxqn8l0wLgrxBMOUrDK+s5yjx9ajF2TQmdAaGdf5yRwqhU
         WFoKUgHpwykPp7UH7nSB0ZtaazkTBjV3XmXDYg/Dp/kM/VO8We3gZz7ZiuJhIgss8MPv
         jcbUz7Qi5eWB029ymBhBJUoiZIdrMTLlzNrfdZ0WPyp6UfOH7+JlhJEHMFtE67WmcLGw
         8tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=VBLFlRAveNTm5y3VkIIxRsoerOpfI7g0oHLz1FFsyNg=;
        b=V+9x0Tzjl7XtTe4I8nwFpo8QtJwyyzbykonVIfx8J2CcRT80K91eVfNgC0UGahQPIz
         B2XzxdeMz6Ljbd0/S6vjK3fXB3Y0IKi70z1IX1wyRcmw2bQ3KVnrrFak6uRpNlWxtWAx
         usn++8huBUUjAG1iGAbBrBlJ1M+FDvdQoHR3seulFB/8y+ro1uo5Gw/oocrfY9TuLtKD
         /GawQURdTAkbrLeKSaKFa4D7VWGqDrQgON/iYIkxOGqFzCGpaPY4iicFIPniT9Uj72oW
         ixjS/7FYXztvVNyTTctaam1k9+yxjkNgWzv2Xcoa3lW7D7Y+0N0AVaH/+r9XzzdJl4V0
         Zcow==
X-Gm-Message-State: AOAM532uWX3uORzZBdSO37/MnjXY4g+D1lMXAuX2Xfc5gLXmS4W/x6PS
        kWxkvi0locuDH/pQbnHfv7c=
X-Google-Smtp-Source: ABdhPJz3ym/jV1b504KSBJpTG9NmLC2Y57atSyE9RID4wr+NcFqaTgGZlzoX+NRZ5URD6Qp9MMGZRg==
X-Received: by 2002:ac2:435a:: with SMTP id o26mr6258107lfl.216.1627132959288;
        Sat, 24 Jul 2021 06:22:39 -0700 (PDT)
Received: from smtpclient.apple (84-10-202-70.dynamic.chello.pl. [84.10.202.70])
        by smtp.gmail.com with ESMTPSA id w17sm1069716lfu.304.2021.07.24.06.22.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jul 2021 06:22:38 -0700 (PDT)
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Current mainline brcmfmac reports error on supposedly supported
 ap6256 chip
Message-Id: <DAA2C28E-0CF2-4A1C-9110-BDEB85ADC09B@gmail.com>
Date:   Sat, 24 Jul 2021 15:22:38 +0200
To:     brcm80211-dev-list.pdl@broadcom.com, linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dears,

I working on adding support in mainline kernel for radxa-zero SBC.
=
https://www.cnx-software.com/2021/06/16/radxa-zero-sbc-quad-core-raspberry=
-pi-zero-w-alternative/ =20

So far all seems to be working well on mainline 5.13.4 kernel except =
WiFi.

radxa-zero SBC uses SDIO attached AP6256 WiFi/BT module.
Chip seems to be communicating with brcmfmac driver - but kernel dmesg =
reports error like below.

(output is after kernel compile with:

CONFIG_BRCM_TRACING=3Dy
CONFIG_BRCMDBG=3Dy

and

echo 8 > /proc/sys/kernel/printk
modprobe brcmfmac debug=3D0x6)


5.13.4 dmesg from brcmfmac probing:

[  138.188502] brcmfmac: brcmfmac_module_init No platform data =
available.
[  138.189917] brcmfmac: brcmf_sdio_probe Enter
[  138.194049] brcmfmac: F1 signature read @0x18000000=3D0x15294345
[  138.199709] brcmfmac: brcmf_chip_recognition found AXI chip: =
BCM4345/9
[  138.207838] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:51 base =
0x18000000 wrap 0x18100000
[  138.214720] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:54 base =
0x18001000 wrap 0x18101000
[  138.223405] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:9  base =
0x18002000 wrap 0x18102000
[  138.232112] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:14 base =
0x18003000 wrap 0x18103000
[  138.240834] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:21 base =
0x18004000 wrap 0x18104000
[  138.249534] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x135:0  base =
0x00000000 wrap 0x18107000
[  138.258248] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x240:0  base =
0x00000000 wrap 0x00000000
[  138.266957] brcmfmac: brcmf_chip_set_passive Enter
[  138.274227] brcmfmac: brcmf_chip_get_raminfo RAM: base=3D0x198000 =
size=3D0 (0x0) sr=3D0 (0x0)
[  138.279634] brcmfmac: brcmf_chip_get_raminfo: RAM size is =
undetermined
[  138.286085] brcmfmac: brcmf_sdio_probe_attach: brcmf_chip_attach =
failed!
[  138.292725] brcmfmac: brcmf_sdio_probe: brcmf_sdio_probe_attach =
failed
[  138.299190] brcmfmac: brcmf_sdio_remove Enter
[  138.303476] brcmfmac: brcmf_detach Enter
[  138.307444] brcmfmac: brcmf_sdio_remove Disconnected
[  138.312361] brcmfmac: brcmf_ops_sdio_probe: F2 error, probe failed =
-19...
[  138.319198] usbcore: registered new interface driver brcmfmac

i tested fw ver 7.45.96.61 and also a bit newer ver. (7.45.96.68). both =
are giving the same error. removing firmware changes nothing - so i =
think issue is in frcmfmac kernel code which is not ready yet for chip =
variant used in radxa-zero ap6256 wifi module.

Full kernel dmesg: https://pastebin.com/VT1tQUJY=20

May you pls advise me how to move forward with this issue?

