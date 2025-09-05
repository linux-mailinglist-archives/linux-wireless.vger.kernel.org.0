Return-Path: <linux-wireless+bounces-27041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF524B45C77
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927E1162EED
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885D1EFF80;
	Fri,  5 Sep 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdoOSdYG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E0220696
	for <linux-wireless@vger.kernel.org>; Fri,  5 Sep 2025 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085794; cv=none; b=u/rpctNiedlGgTrKyuBQgghN9k4Xc5CPRaEojtgsE4ZFu3E8RLNQw39WzL1l9yxANxowfvRI5n7WUDVZRWmwGjM2Vx6bsQwLrVr41v6VWhSnTqoJ4u1ecm1Hdvxqhz8el98gzIR168/on0wxDoCw8H21pwrLfSwDVfoVSR1UF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085794; c=relaxed/simple;
	bh=8p0bMP3iIV0GWjf7xhijZJc9pA+Pyafoefq8TMC0esc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lIDmnKxIXpkKyzF6B90yopdRnxcsEOAQXeIIaF2sVjtbXLw+agf8Rtka4Jps2WBEdEiJQW6H++jABIp8dJRfowIXyjMBGmunKcwHHXTxnCm9KzFa3do/0qXxWMsUwd2oSZXx0fucax7RYulYpZE3xRYlC2gzpZuctEFKPDHBWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdoOSdYG; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-89607b19f71so664586241.1
        for <linux-wireless@vger.kernel.org>; Fri, 05 Sep 2025 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757085790; x=1757690590; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7yFFUHnGZW0JHhoBdZKegiawGGy/RzVeOJmX0hlyIhA=;
        b=mdoOSdYGn2BsAj4HURWxO4yAZ3QMOoMwjxf1gE+/HN+aI4jxw6rOeDe+isl3tbR0TC
         4aANQuB9A+syBgd+bInrL7gqhhGccXbAdEkxRKcp6sOpnnTvmSPGlYRcwBhCMIVDUyv7
         F3RnoET/FjPbtk1eNqdKdlxhzakebuNZU4N5zSz08kzSK+ES1/4TZ3+LYhIeZUxtVV0x
         aJ2/kNBZDf1mNSG8uHEnQywrKlW7/fNUF/RYRY69U5ppHzm4f4dinoGFsw6tYE+LhiIi
         RJV8XnOHncIQ47myu4Zt5EADXuxZAMGZjNz/CbycN7jTc/Ytgac0bgD8eqro8bwdsYL0
         j6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085790; x=1757690590;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7yFFUHnGZW0JHhoBdZKegiawGGy/RzVeOJmX0hlyIhA=;
        b=h10B6Yb2LrrRE1r3Qd1MRnjesb0QleQsP27bGTz+BxaiesgQqgd9yODKZlyn8aq7BD
         oV7F41n89Bcaq54fy8S7oFPChqREHfLPoteZKn72UP38q/VLLz9IYyacpMDtD/+fZiBb
         Y4WoY1tGLSoCcRAQTIUIjnl1dDtLq1kjviEEcyblF7rEq84DwPGx836d3YicNoOHulR0
         fi5yk0GgkZm5rfyYgBTRqcYDGC4dJ+o7Bs5a6hTPcy8uKGI7pzgpPyY85Ui947pfjVZK
         gVQ47/EDiUTqpDyWtsxtrz5P9J8O1jehG++2niRK6m9OQZ+CFKNmzqQl4F0DtG7x5WE9
         RfHA==
X-Gm-Message-State: AOJu0Yz77/8Vvb3EjBTmc7F7xyQCGtM7fZhtuHxlsheQukOdBbiRcL66
	fupUUN1aNjNEbenBrjaQ95xxX4XE4T2dlv9fvCXLvhln5j1yWDVUyK2Ude6a8PmhhKidAwhyCNp
	8L+SYghi1+qrcjSB+n+lfGM3EkNO4/5XDMk3Er6Y=
X-Gm-Gg: ASbGncvAJ1qG19D62kcfJR+eY8VLvIyXj+uojcVMnWrVTOjOxoIbSEX1BKHAklbxkgr
	3dSq3a5SYCA+mq4WxTsPIQhLSumfdpDH9AKJCccoPWJdfKW/v6MPaXNVNxyoC9uoYXIh1hvKPAS
	3RQHDqDR9BILUJvUKFYJTRbXfu9/JV4fNEurWpaSThb33tNl9hpN9VuaVeYz5L3faksY2Vs9hLi
	aNRpDuWJKBmlQYMPGlD1NSnVkqFcIpQvViJhhlKnMt5/JxCpUoT1JF+MOClrg==
X-Google-Smtp-Source: AGHT+IEN4MZSbqBM4PoTjnF2nHn0zCh/uuRuZAhrdQG4W9Y8NKAf76jFyb2UY4c2AVpWqOqypP848icg0GjlV0OKRus=
X-Received: by 2002:a05:6102:6b0a:b0:4f9:69a9:4ec4 with SMTP id
 ada2fe7eead31-52b1c14d260mr7635378137.26.1757085789994; Fri, 05 Sep 2025
 08:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nader Ben Ammar <nader.ben.ammar@gmail.com>
Date: Fri, 5 Sep 2025 16:22:59 +0100
X-Gm-Features: Ac12FXw8Jb8nkvpAELirwGljNK-cml9jH_5cCJ_V9DsekRi66P-Et4uzC9I6Lyk
Message-ID: <CAN1oh1qev4bBBGABpBX5bqga1RzTaYayVAYoJqKPeashQhY+=A@mail.gmail.com>
Subject: Bug Report] wifi: rtw89: RTL8852BE fails to resume from suspend on
 kernel 6.14
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm reporting a bug with the rtw89 driver for Realtek RTL8852BE PCIe
WiFi on kernel 6.14.0-29-generic. The WiFi fails to resume from
suspend, requiring a reboot to regain connectivity.

Hardware:
- Device: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax
Wireless Network Controller
- Subsystem: Hewlett-Packard Company RTL8852BE PCIe 802.11ax Wireless
Network Controller
- PCI ID: 01:00.0

Kernel Version:
Linux HP-Laptop 6.14.0-29-generic #29~24.04.1-Ubuntu SMP
PREEMPT_DYNAMIC Thu Aug 14 16:52:50 UTC 2 x86_64 x86_64 x86_64
GNU/Linux

Driver:
- Out-of-tree rtw89 driver from https://github.com/morrownr/rtw89
- Module: rtw89_8852be_git
- Firmware: rtw89/rtw8852b_fw-1.bin (version 0.29.128.0)

Steps to Reproduce:
1. Connect to a WiFi network.
2. Suspend the system: `systemctl suspend`
3. Resume the system.
4. WiFi is disconnected and does not reconnect automatically. Manual
reconnection fails until reboot.

Expected Behavior:
WiFi should reconnect after resume.

Actual Behavior:
WiFi remains disconnected. `iwconfig` or `nmcli` shows no connection.
Logs show no errors on resume, but the device is unresponsive.

Kernel Command Line:
BOOT_IMAGE=/boot/vmlinuz-6.14.0-29-generic
root=UUID=95dcee12-84fe-4ab6-a174-0de1f81679bc ro quiet splash
mem_sleep_default=deep pcie_aspm=off pci=noaer pci_port_pm=off
acpi_osi=Linux rtw89.disable_ps_mode=1 pci=noaer pcie_aspm=off
rtw89.debug_mask=0x0001 vt.handoff=7

Driver Config (/etc/modprobe.d/rtw89.conf):
#
# Configuration file for the out-of-kernel rtw89 drivers
#
# Link: https://github.com/morrownr/rtw89
#

options rtw89_core_git debug_mask=0x0
options rtw89_core_git disable_ps_mode=y

options rtw89_pci_git disable_clkreq=y
options rtw89_pci_git disable_aspm_l1=y
options rtw89_pci_git disable_aspm_l1ss=y

# Blacklist the in-kernel rtw89 drivers
blacklist rtw89_8851bu
blacklist rtw89_8851be
blacklist rtw89_8851b
blacklist rtw89_8852au
blacklist rtw89_8852ae
blacklist rtw89_8852a
blacklist rtw89_8852b_common
blacklist rtw89_8852bu
blacklist rtw89_8852be
blacklist rtw89_8852b
blacklist rtw89_8852bte
blacklist rtw89_8852bt
blacklist rtw89_8852cu
blacklist rtw89_8852ce
blacklist rtw89_8852c
blacklist rtw89_8922au
blacklist rtw89_8922ae
blacklist rtw89_8922a
blacklist rtw89_core
blacklist rtw89_usb
blacklist rtw89_pci

# Blacklist Larry's rtw89 drivers
blacklist rtw89core
blacklist rtw89pci
blacklist rtw_8851b
blacklist rtw_8851be
blacklist rtw_8852a
blacklist rtw_8852ae
blacklist rtw_8852b
blacklist rtw_8852be
blacklist rtw_8852c
blacklist rtw_8852ce
blacklist rtw_8922a

lspci -vvv Output for 01:00.0:
01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE
PCIe 802.11ax Wireless Network Controller
        DeviceName: Realtek PCIe GBE Family Controller
        Subsystem: Hewlett-Packard Company RTL8852BE PCIe 802.11ax
Wireless Network Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 145
        IOMMU group: 12
        Region 0: I/O ports at 3000 [size=256]
        Region 2: Memory at 80500000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: <access denied>
        Kernel driver in use: rtw89_8852be_git
        Kernel modules: rtw89_8852be, rtw89_8852be_git

dmesg | grep -i rtw89 Output:
[    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-6.14.0-29-generic
root=UUID=95dcee12-84fe-4ab6-a174-0de1f81679bc ro quiet splash
mem_sleep_default=deep pcie_aspm=off pci=noaer pci_port_pm=off
acpi_osi=Linux rtw89.disable_ps_mode=1 pci=noaer pcie_aspm=off
rtw89.debug_mask=0x0001 vt.handoff=7
[    0.033699] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-6.14.0-29-generic
root=UUID=95dcee12-84fe-4ab6-a174-0de1f81679bc ro quiet splash
mem_sleep_default=deep pcie_aspm=off pci=noaer pci_port_pm=off
acpi_osi=Linux rtw89.disable_ps_mode=1 pci=noaer pcie_aspm=off
rtw89.debug_mask=0x0001 vt.handoff=7
[    3.261978] rtw89_core_git: loading out-of-tree module taints kernel.
[    3.261986] rtw89_core_git: module verification failed: signature
and/or required key missing - tainting kernel
[    3.716552] rtw89_8852be_git 0000:01:00.0: loaded firmware
rtw89/rtw8852b_fw-1.bin
[    3.716635] rtw89_8852be_git 0000:01:00.0: enabling device (0000 -> 0003)
[    3.718487] rtw89_8852be_git 0000:01:00.0: git commit
[    3.724889] rtw89_8852be_git 0000:01:00.0: Firmware version
0.29.128.0 (418a672d), cmd version 0, type 5
[    3.724901] rtw89_8852be_git 0000:01:00.0: Firmware version
0.29.128.0 (418a672d), cmd version 0, type 3
[    4.017001] rtw89_8852be_git 0000:01:00.0: chip rfe_type is 1
[    4.046776] rtw89_8852be_git 0000:01:00.0: rfkill hardware state
changed to enable
[    4.079934] rtw89_8852be_git 0000:01:00.0 wlo1: renamed from wlan0

Additional Notes:
- This issue appears to have started with kernel 6.6+ due to changes
in PCIe power management.
- Disabling power save mode and ASPM in the driver config did not resolve it.
- The out-of-tree driver is used to avoid issues with the in-kernel version.
- Tested on kernels 6.5 and 6.14 with the same result.

Please investigate and provide a fix. Let me know if you need more information.

Thanks,
Nader

