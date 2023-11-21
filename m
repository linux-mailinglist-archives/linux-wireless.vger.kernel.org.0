Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42C7F2D57
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 13:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjKUMhK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 07:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjKUMhI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 07:37:08 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB67F125
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 04:37:04 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-db048181cd3so5329744276.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700570224; x=1701175024; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P+bDxpO1/OzSjBaFU5/hUy/0CQwKMc9P15Fd7Xk/oA0=;
        b=YmjgAr8qUMiMP+PKTvqq/qwtyRc0tG50RgYtjAbQG8NZf5mJVQMpgbRMG8Vch8Y9AY
         m5jGYGHhjguRaZyAg2w00OuJe4yiSPjku++htS5fJIkf/1K1clTr0SwM8bz+eYPs8bvr
         R2lwFd6XLgmhtYzOiqzqJNoCx0BAP4e8D4eJlA0SjNXGznwrp+J0d48NX9Rtbbsx8jTi
         tXsRuXTAaZLqRNL+YJxQqi5/2nXFfaqRefHdBhXm37V4U2hyIuz1Rpp1hbNt86z3qmhJ
         dDUOk1DfXWMWu520MkzId6x91TyalgtP2+N8dWJLW7G5dNsyNSv4qzhOzJopD48tfzq5
         bWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700570224; x=1701175024;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+bDxpO1/OzSjBaFU5/hUy/0CQwKMc9P15Fd7Xk/oA0=;
        b=rXIAUUqzM67btNqAJUZBBMR4ygOsatii/z7i4VKmFp7DhNkDpOBnvC6y6YuON74vg4
         R5vsqMh/pcW5oRXB6earx7m/zTLQhS5IYAPHGxnq/tHhiAVNAhava+JWsET+6Jbif2SK
         ki5xseC3L9bz+AsN5TQBRut+wqfjSaCJZO7FkcGIGjbe1dyZipOaTUEHJzyidzBYV6x7
         t/iSaulcv+P0gv6WgBAsh5THfwTR8xrQEVXWb4dZ/gpwe5noxlUxoAYvBvcW1mYlaX0I
         4Yyu8vWGiLfyriP9/CnbKp0iHK8ziJm3abhGhWO0sTz7zknP4bKLQtk0P4v9GEi7QxOS
         Oz9g==
X-Gm-Message-State: AOJu0YyoR5C8oQN8LCgwy0u62szLVblnzccPaiG4/ajew+wtPqsYB3p5
        JWfpURHoIwJZLgpqOyS7hPtYOT65t2l0iWQq+FYvr6PvR2Q=
X-Google-Smtp-Source: AGHT+IE+tKsCfctPQIl6UTFPpn91dYsR+CoYYA8kc72mcHkChdWdHYAzFQi0zFZMM9DTy9+2YONDLgfixKC6fof8PJg=
X-Received: by 2002:a25:1844:0:b0:da0:7826:8b98 with SMTP id
 65-20020a251844000000b00da078268b98mr8695350yby.55.1700570224009; Tue, 21 Nov
 2023 04:37:04 -0800 (PST)
MIME-Version: 1.0
From:   Michael Mallaburn <m.mallaburn@gmail.com>
Date:   Tue, 21 Nov 2023 12:36:53 +0000
Message-ID: <CAHVz7zzPAJRf_cp76C0RWi=4AjQW-V9onOcBadA5CJ=X=F5E0Q@mail.gmail.com>
Subject: Problem connecting to Amazon Luna Gamepad with rtw88_8821ce over Bluetooth
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

This is a long-ish post as I have not wanted to skip any details that
could be important in resolving this issue.
Lenovo L340 system details:
Fedora 39, updated on 2023-11-20.
lspci
00:00.0 Host bridge: Intel Corporation 8th Gen Core 4-core Processor
Host Bridge/DRAM Registers [Coffee Lake H] (rev 07)
00:01.0 PCI bridge: Intel Corporation 6th-10th Gen Core Processor PCIe
Controller (x16) (rev 07)
00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-H GT2
[UHD Graphics 630]
00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200
v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 07)
00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 /
E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
00:12.0 Signal processing controller: Intel Corporation Cannon Lake
PCH Thermal Controller (rev 10)
00:14.0 USB controller: Intel Corporation Cannon Lake PCH USB 3.1 xHCI
Host Controller (rev 10)
00:14.2 RAM memory: Intel Corporation Cannon Lake PCH Shared SRAM (rev 10)
00:15.0 Serial bus controller: Intel Corporation Cannon Lake PCH
Serial IO I2C Controller #0 (rev 10)
00:15.1 Serial bus controller: Intel Corporation Cannon Lake PCH
Serial IO I2C Controller #1 (rev 10)
00:16.0 Communication controller: Intel Corporation Cannon Lake PCH
HECI Controller (rev 10)
00:17.0 SATA controller: Intel Corporation Cannon Lake Mobile PCH SATA
AHCI Controller (rev 10)
00:1d.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root
Port #9 (rev f0)
00:1d.4 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root
Port #13 (rev f0)
00:1d.5 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root
Port #14 (rev f0)
00:1e.0 Communication controller: Intel Corporation Cannon Lake PCH
Serial IO UART Host Controller (rev 10)
00:1f.0 ISA bridge: Intel Corporation HM470 Chipset LPC/eSPI Controller (rev 10)
00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
00:1f.4 SMBus: Intel Corporation Cannon Lake PCH SMBus Controller (rev 10)
00:1f.5 Serial bus controller: Intel Corporation Cannon Lake PCH SPI
Controller (rev 10)
01:00.0 VGA compatible controller: NVIDIA Corporation TU117M [GeForce
GTX 1650 Mobile / Max-Q] (rev a1)
01:00.1 Audio device: NVIDIA Corporation Device 10fa (rev a1)
06:00.0 Non-Volatile memory controller: Lite-On Technology Corporation
Device 9100 (rev 03)
07:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE
802.11ac PCIe Wireless Network Adapter
08:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 10)


I have previously connected this device via Bluetooth to other devices
including a Wii U Pro controller, which connects as follows from dmesg
...
[  338.416561] rtw_8821ce 0000:07:00.0: unhandled firmware c2h interrupt
[  347.019525] rtw_8821ce 0000:07:00.0: unhandled firmware c2h interrupt
[  353.467153] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
[  353.577153] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
[  782.029090] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
[  782.139110] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
[ 1494.321344] rtw_8821ce 0000:07:00.0: firmware failed to leave lps state
[ 1498.353437] rtw_8821ce 0000:07:00.0: firmware failed to leave lps state
[ 1501.074084] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[ 1501.074100] Bluetooth: HIDP socket layer initialized
[ 1501.290597] rtw_8821ce 0000:07:00.0: failed to send h2c command
[ 1501.712841] rtw_8821ce 0000:07:00.0: failed to send h2c command
[ 1501.793457] wiimote 0005:057E:0330.0001: unknown main item tag 0x0
[ 1501.793867] wiimote 0005:057E:0330.0001: hidraw0: BLUETOOTH HID
v0.01 Gamepad [Nintendo RVL-CNT-01-UC] on [redacted MAC]
[ 1501.793921] wiimote 0005:057E:0330.0001: New device registered
[ 1502.185405] wiimote 0005:057E:0330.0001: detected device: Nintendo
Wii U Pro Controller
[ 1502.230355] wiimote 0005:057E:0330.0001: detected extension:
Nintendo Wii U Pro Controller
[ 1502.230439] input: Nintendo Wii Remote Pro Controller as
/devices/pci0000:00/0000:00:14.0/usb1/1-14/1-14:1.0/bluetooth/hci0/hci0:1/0005:057E:0330.0001/input/input17
[ 1502.321300] rtw_8821ce 0000:07:00.0: firmware failed to leave lps state
[ 1504.305384] rtw_8821ce 0000:07:00.0: firmware failed to leave lps state
...
Obviously a lot of other issues are being reported there but nothing
to stop it connecting successfully.

When I try to use the controller in KDE>System Settings>Input
Devices>Game Controller, I can see that the input is not being
registered: and I get the following in dmesg looping every second or
so:
[ 1604.337675] rtw_8821ce 0000:07:00.0: firmware failed to leave lps state
[ 1604.341032] rtw_8821ce 0000:07:00.0: failed to send h2c command
[ 1604.344479] rtw_8821ce 0000:07:00.0: failed to send h2c command
[ 1604.347918] rtw_8821ce 0000:07:00.0: failed to send h2c command
[ 1604.351364] rtw_8821ce 0000:07:00.0: failed to send h2c command
[ 1606.221257] rtw_8821ce 0000:07:00.0: failed to send h2c command
At some point also "[ 1729.588089] wiimote 0005:057E:0330.0001: Device
removed" is observed, but the loop above continues.

Turning off power saving via /etc/NetworkManager/conf.d/wifi_powersave.conf
containing
[connection]
wifi.powersave = 2
and rebooting allows the Bluetooth to work and I can see the WiiU
remote inputs in the KDE settings menu.
The only entries in dmesg now are related to time outs:
[   65.261253] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
[   65.373248] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
[  184.045755] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
[  184.155711] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
[  223.677830] rtw_8821ce 0000:07:00.0: timed out to flush queue 1
[  223.788994] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
[  223.899831] rtw_8821ce 0000:07:00.0: timed out to flush queue 1
[  224.009935] rtw_8821ce 0000:07:00.0: timed out to flush queue 2
...
Eventually the flushes did stop shortly after disconnecting the WiiU
Pro Controller, however, the controller is working.

Moving on to the Amazon Luna Controller.
This appears as "Luna Gamepad" when searching for Bluetooth devices.
Upon connecting, the GUI interface times out and the dmesg log is:
[ 1216.069940] Bluetooth: hci0: unexpected cc 0x0c7c length: 1 < 3
[ 1216.115131] Bluetooth: hci0: unexpected SMP command 0x06 from [redacted MAC]
[ 1216.115138] Bluetooth: hci0: unexpected SMP command 0x07 from [redacted MAC]
[ 1216.115140] Bluetooth: hci0: unexpected SMP command 0x08 from [redacted MAC]
[ 1216.115142] Bluetooth: hci0: unexpected SMP command 0x09 from [redacted MAC]
[ 1216.117156] Bluetooth: hci0: unexpected SMP command 0x0a from [redacted MAC]

Using a TP-Link Bluetooth USB adaptor (UB5A), I can confirm the
userspace stack is working correctly as I was able to connect to the
Luna Controller and check the inputs in the KDE Settings menu.

Lastly, whilst not likely relevant, I had upgraded my BIOS yesterday
to fix this long-standing and repeating message that swamped all logs:
May 31 21:02:17 fedora kernel: pcieport 0000:00:1d.4: AER: Multiple
Corrected error received: 0000:07:00.0
May 31 21:02:17 fedora kernel: rtw_8821ce 0000:07:00.0: PCIe Bus
Error: severity=Corrected, type=Physical Layer, (Receiver ID)
May 31 21:02:17 fedora kernel: rtw_8821ce 0000:07:00.0:   device
[10ec:c821] error status/mask=00000001/0000e000
May 31 21:02:17 fedora kernel: rtw_8821ce 0000:07:00.0:    [ 0] RxErr
                (First)
After seeing that the issue affected two out-of-kernel drivers for the
same chip, and one of those maintainers mentioned the board doesn't
support some functionality, I chanced an update and it solved the
issue for me. This issue went unobserved for some time as my errors
were being corrected, however, other people have not been so lucky.
Perhaps there is some way of detecting the correct support and disable
whatever feature causes this where applicable.
I can confirm that my issues connecting to the Luna Controller are not
related to this and the same errors were being reported pre- and
post-bios update. (And on Fedora 37 before an upgrade to 39).

I have mentioned a few issues, but the main one is the unexpected
cc/SMP commands that prevent the Amazon Luna Controller from
connecting via Bluetooth.
Thank you to anyone that can help.
Regards,
Mike
