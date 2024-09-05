Return-Path: <linux-wireless+bounces-12558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F029796E342
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFB71C23F92
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 19:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA31917DA;
	Thu,  5 Sep 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decampo-org.20230601.gappssmtp.com header.i=@decampo-org.20230601.gappssmtp.com header.b="Y0VqldXn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D24400
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564806; cv=none; b=BVShx1U1PPkwS128SwniLMoD9cPMCaZ7p1KTbqedAzZXrMDQnnOWfSpleKj7O/7DJx1JICrd3pZ1POxZhszkOGPWKb8+eFrUs3RJFtoFOsImBbzRCMjMrZ90YXDchvJNzK5UHdWK3uL/r0/GhMkYLP+UUMOIH9S/Py/Z37kF4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564806; c=relaxed/simple;
	bh=EGyxmGKT9/QJZYIvudmwgnrjte2yYR2hpBRVmrRsOJA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ObbGSL99274rrr2pX35J9EO9iN43VJQid+xMOy0rZguq9/nIQNvQQbj2ulBq1MjFbsKBU7PHQwNDJNIVDOHqlgYoZc817o/y8aV2MSOtOKGrRyd006dqwVcM6RSlpeSYwgnlb/MyNUjy+g+1PzbDa/+rbsn45DT0WO9KSBISmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decampo.org; spf=pass smtp.mailfrom=decampo.org; dkim=pass (2048-bit key) header.d=decampo-org.20230601.gappssmtp.com header.i=@decampo-org.20230601.gappssmtp.com header.b=Y0VqldXn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decampo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decampo.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bbd16fca8so10678485e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=decampo-org.20230601.gappssmtp.com; s=20230601; t=1725564798; x=1726169598; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=51p1k5hBVxnRd1zicJqWc4O9S3DG7/7bmtnp/zxb//M=;
        b=Y0VqldXnvg0DiNl7kJ6U+Bcn5uWMMmIT8Lhuq0RZ4zyp7F7E1rrmeE0UNmh0Y3AywE
         mDuWe+Tepf3UtW+Z1zDU5u8rXaVSv4EYpW5xHypsBwJ9m738BAwlevtjzXYlUq0P/Qq/
         Us5FU/saH5O1RwaKjaDhyRsg8ychMPWWR8OtpoFztMhWSQ3QQV5o9RfZsyKkDrR+E2n4
         GVTWWBpH4q4za8tUfUNaAO7Si1xq1SAlgNjKVyJWsUI3mmfFYoCvfac9YkkykbPLkRhh
         0fgs0wJj8Wp+jL+6xvgL9qZXPQeLdmen/zuBQRvnSqg1pPYg7pyM0lI+PCWvc/HkmQpu
         jCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725564798; x=1726169598;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51p1k5hBVxnRd1zicJqWc4O9S3DG7/7bmtnp/zxb//M=;
        b=wuZT1Xrn255mU09ygsFcDt68oaFx2q8lMOi8qE3arfCN0NSG6JSdyhtD2VXLvI82iR
         mg+Hlp4hZCd/L4rnN7T+Pc9CtsOrcZI4MfZSgF98W665P/LO62o8toeAmLu/GouboyRr
         3ojG1Ca52WbTdaiIxx5SRWD6CmpNxbl/cBezxlH9fdLGP0Hj21yLlUcdJCZzvuw6cMjQ
         EVbqc4NWwPFlxvs90TJLrei1MU/Bv3yHqyQ0STS0cNnQeJzwhnoYqznLAQBTTs9H4Ync
         TjEY3XwcuoSoMx1PH/+Xb5aKcJH0gQmrfN1mRdwzQFDrkqFPnUV98UlA0v5X8nE7sbO7
         89zw==
X-Gm-Message-State: AOJu0YxUAhQpSuLr6HV5eYik66sQHwXOwLScbPzKXm55h4oSiNzFH0rY
	/PiZGV/c2RjdwklphFilEiGXSA9Ms6cpRl9ZZa8Vjy3AOr/dhdd86h7w+4HVnAqtKhaVoorY97J
	zAp+z9c+3H0B4+phdsNM0bOQ99D1YEk22196DU+8jFXKPNb9DrEI=
X-Google-Smtp-Source: AGHT+IH58SgFTxpwqychJLAkrU4Mp7Eenee0BpXnXhUekdN7mhll0gRWOXt0IlwrRhCZ+mihJkKPQnctWqZSU2oMe4k=
X-Received: by 2002:a5d:634c:0:b0:374:c2e9:28b8 with SMTP id
 ffacd0b85a97d-378895ca776mr114668f8f.18.1725564796348; Thu, 05 Sep 2024
 12:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eli DeCampo <eli@decampo.org>
Date: Thu, 5 Sep 2024 15:33:05 -0400
Message-ID: <CAGCFnVBNNLgyKp_FLnvMiMnkAtwXrQbgot96Zmb_FeZNXFu+ew@mail.gmail.com>
Subject: RTW89 Driver Issues
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I wanted to report an issue with the Realtek RTW8922AE driver found at
https://github.com/lwfinger/rtw89/tree/main

As of now, I've been able to successfully install the latest version
of driver. I am able to enable wifi and search for networks with
results. However, all connections have 0% strength, and always time
out when I attempt to connect to them (or never successfully connect
when I tell my machine to stop timing out). I will provide logs to the
best of my ability below. Feel free to contact me at this email
address if you require any further information or logs.

Thank you,
Eli DeCampo

Logs:
_______________________________________________
eli@Compooper-v2:~$ sudo dmesg | grep rtw
[sudo] password for eli:
[    4.827941] rtw89core: loading out-of-tree module taints kernel.
[    4.828384] rtw89core: module verification failed: signature and/or
required key missing - tainting kernel
[    4.866465] rtw89_8852be 0000:01:00.0: firmware: direct-loading
firmware rtw89/rtw8852b_fw-1.bin
[    4.866474] rtw89_8852be 0000:01:00.0: loaded firmware
rtw89/rtw8852b_fw-1.bin
[    4.866611] rtw89_8852be 0000:01:00.0: enabling device (0000 -> 0003)
[    4.869687] rtw89_8852be 0000:01:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 5
[    4.869694] rtw89_8852be 0000:01:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 3
[    5.187409] rtw89_8852be 0000:01:00.0: chip rfe_type is 1
[    5.314770] rtw89_8852be 0000:01:00.0 wlp1s0: renamed from wlan0
eli@Compooper-v2:~$
____________________________________________________
NetworkManager logs. Note that it is definitely not a network
configuration or login issue, as I have successfully connected to this
network in the past using the same configurations/settings. I have
been using USB tethering and an android device to give my machine a
connection, so I assume that this is also included in these logs, as
well as the failed wifi connections:

-- Boot f8a58a8f90914b1891fd262bb22e1176 --
Sep 05 14:37:12 Compooper-v2 systemd[1]: Starting
NetworkManager.service - Network Manager...
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.2843] NetworkManager (version 1.42.4) is starting...
(boot:f8a58a8f-9091-4b18-91fd-262bb22e1176)
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.2843] Read config: /etc/NetworkManager/NetworkManager.conf
(lib: no-mac-addr-change.conf) (etc: default-wifi-powersav>
Sep 05 14:37:12 Compooper-v2 systemd[1]: Started
NetworkManager.service - Network Manager.
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.2857] bus-manager: acquired D-Bus service
"org.freedesktop.NetworkManager"
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.2894] manager[0x560b5cc19000]: monitoring kernel firmware
directory '/lib/firmware'.
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.2894] monitoring ifupdown state file
'/run/network/ifstate'.
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3797] hostname: hostname: using hostnamed
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3797] hostname: static hostname changed from (none) to
"Compooper-v2"
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3802] dns-mgr: init: dns=default,systemd-resolved
rc-manager=symlink (auto)
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3819] rfkill1: found Wi-Fi radio killswitch (at
/sys/devices/pci0000:00/0000:00:1c.0/0000:01:00.0/ieee80211/phy0/rfki>
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3821] manager[0x560b5cc19000]: rfkill: Wi-Fi hardware
radio set disabled
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3822] manager[0x560b5cc19000]: rfkill: WWAN hardware radio
set enabled
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3863] Loaded device plugin: NMWifiFactory
(/usr/lib/x86_64-linux-gnu/NetworkManager/1.42.4/libnm-device-plugin-wifi.s>
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3871] Loaded device plugin: NMAtmManager
(/usr/lib/x86_64-linux-gnu/NetworkManager/1.42.4/libnm-device-plugin-adsl.so)
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3913] Loaded device plugin: NMWwanFactory
(/usr/lib/x86_64-linux-gnu/NetworkManager/1.42.4/libnm-device-plugin-wwan.s>
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3936] Loaded device plugin: NMBluezManager
(/usr/lib/x86_64-linux-gnu/NetworkManager/1.42.4/libnm-device-plugin-bluet>
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3958] Loaded device plugin: NMTeamFactory
(/usr/lib/x86_64-linux-gnu/NetworkManager/1.42.4/libnm-device-plugin-team.s>
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3959] manager: rfkill: Wi-Fi disabled by radio killswitch;
disabled by state file
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3960] manager: rfkill: WWAN enabled by radio killswitch;
enabled by state file
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3960] manager: Networking is enabled by state file
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3973] settings: Loaded settings plugin: ifupdown
("/usr/lib/x86_64-linux-gnu/NetworkManager/1.42.4/libnm-settings-plu>
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3973] settings: Loaded settings plugin: keyfile (internal)
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3973] ifupdown: management mode: unmanaged
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3973] ifupdown:       interface-parser: parsing file
/etc/network/interfaces
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3974] ifupdown:       interface-parser: source line
includes interfaces file(s) /etc/network/interfaces.d/*
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3974] ifupdown: interfaces file
/etc/network/interfaces.d/* doesn't exist
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.3975] ifupdown:       interface-parser: finished parsing
file /etc/network/interfaces
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4104] dhcp: init: Using DHCP client 'internal'
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4109] manager: (lo): new Loopback device
(/org/freedesktop/NetworkManager/Devices/1)
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4124] device (lo): state change: unmanaged -> unavailable
(reason 'connection-assumed', sys-iface-state: 'external')
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4130] device (lo): state change: unavailable ->
disconnected (reason 'connection-assumed', sys-iface-state: 'external>
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4138] device (lo): Activation: starting connection 'lo'
(27278893-ee55-4a9a-ac14-b46acea9fe4c)
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4143] device (wlp1s0): driver supports Access Point (AP)
mode
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4150] manager: (wlp1s0): new 802.11 Wi-Fi device
(/org/freedesktop/NetworkManager/Devices/2)
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4154] device (wlp1s0): state change: unmanaged ->
unavailable (reason 'managed', sys-iface-state: 'external')
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4275] device (lo): state change: disconnected -> prepare
(reason 'none', sys-iface-state: 'external')
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4278] device (lo): state change: prepare -> config (reason
'none', sys-iface-state: 'external')
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4280] device (lo): state change: config -> ip-config
(reason 'none', sys-iface-state: 'external')
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4285] device (lo): state change: ip-config -> ip-check
(reason 'none', sys-iface-state: 'external')
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4312] device (lo): state change: ip-check -> secondaries
(reason 'none', sys-iface-state: 'external')
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4315] device (lo): state change: secondaries -> activated
(reason 'none', sys-iface-state: 'external')
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4321] device (lo): Activation: successful, device
activated.
Sep 05 14:37:12 Compooper-v2 NetworkManager[876]: <info>
[1725561432.4327] manager: startup complete
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2117] manager: (usb0): new Ethernet device
(/org/freedesktop/NetworkManager/Devices/3)
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2125] device (usb0): carrier: link connected
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2292] device (usb0): state change: unmanaged ->
unavailable (reason 'managed', sys-iface-state: 'external')
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2300] device (usb0): state change: unavailable ->
disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2304] policy: auto-activating connection 'Wired connection
1' (82a6fc99-e2a6-3dd5-9899-56401ca77009)
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2307] device (usb0): Activation: starting connection
'Wired connection 1' (82a6fc99-e2a6-3dd5-9899-56401ca77009)
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2307] device (usb0): state change: disconnected -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2309] manager: NetworkManager state is now CONNECTING
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <warn>
[1725561437.2311] device (usb0): set-link: failure to set link
negotiation
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2311] device (usb0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2314] device (usb0): state change: config -> ip-config
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2318] dhcp4 (usb0): activation: beginning transaction
(timeout in 45 seconds)
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2413] dhcp4 (usb0): state changed new lease,
address=192.168.168.112
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2418] policy: set 'Wired connection 1' (usb0) as default
for IPv4 routing and DNS
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2482] device (usb0): state change: ip-config -> ip-check
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2508] device (usb0): state change: ip-check -> secondaries
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2509] device (usb0): state change: secondaries ->
activated (reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2513] manager: NetworkManager state is now CONNECTED_SITE
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2516] device (usb0): Activation: successful, device
activated.
Sep 05 14:37:17 Compooper-v2 NetworkManager[876]: <info>
[1725561437.2520] manager: NetworkManager state is now
CONNECTED_GLOBAL
Sep 05 14:37:24 Compooper-v2 NetworkManager[876]: <info>
[1725561444.0389] agent-manager:
agent[51fe2059b6f8b183,:1.46/org.kde.plasma.networkmanagement/1000]:
agent registered
Sep 05 14:37:24 Compooper-v2 NetworkManager[876]: <info>
[1725561444.6416] audit: op="statistics" interface="wlp1s0" ifindex=2
args="500" pid=1714 uid=1000 result="success"
Sep 05 14:37:24 Compooper-v2 NetworkManager[876]: <info>
[1725561444.6426] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 14:37:24 Compooper-v2 NetworkManager[876]: <info>
[1725561444.7220] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 14:37:24 Compooper-v2 NetworkManager[876]: <info>
[1725561444.9368] manager: (F8:A9:D0:F6:0A:DC): new Bluetooth device
(/org/freedesktop/NetworkManager/Devices/4)
Sep 05 14:37:24 Compooper-v2 NetworkManager[876]: <info>
[1725561444.9374] device (F8:A9:D0:F6:0A:DC): state change: unmanaged
-> unavailable (reason 'managed', sys-iface-state: 'externa>
Sep 05 14:37:24 Compooper-v2 NetworkManager[876]: <info>
[1725561444.9382] device (F8:A9:D0:F6:0A:DC): state change:
unavailable -> disconnected (reason 'none', sys-iface-state: 'managed>
Sep 05 14:37:24 Compooper-v2 NetworkManager[876]: <info>
[1725561444.9444] audit: op="statistics" interface="F8:A9:D0:F6:0A:DC"
args="500" pid=1714 uid=1000 result="success"
Sep 05 14:37:24 Compooper-v2 NetworkManager[876]: <info>
[1725561444.9493] audit: op="statistics" interface="F8:A9:D0:F6:0A:DC"
args="500" pid=1714 uid=1000 result="success"
Sep 05 14:37:29 Compooper-v2 NetworkManager[876]: <info>
[1725561449.1274] audit: op="statistics" interface="usb0" ifindex=3
args="2000" pid=1606 uid=1000 result="success"
Sep 05 14:37:29 Compooper-v2 NetworkManager[876]: <info>
[1725561449.1312] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 14:37:31 Compooper-v2 NetworkManager[876]: <info>
[1725561451.7181] manager: rfkill: Wi-Fi hardware radio set enabled
Sep 05 14:37:31 Compooper-v2 NetworkManager[876]: <info>
[1725561451.8269] audit: op="radio-control" arg="wireless-enabled:on"
pid=1606 uid=1000 result="success"
Sep 05 14:37:31 Compooper-v2 NetworkManager[876]: <info>
[1725561451.8274] manager: rfkill: Wi-Fi now enabled by radio
killswitch
Sep 05 14:37:31 Compooper-v2 NetworkManager[876]: <info>
[1725561451.8758] device (wlp1s0): supplicant interface state:
internal-starting -> disconnected
Sep 05 14:37:31 Compooper-v2 NetworkManager[876]: <info>
[1725561451.8758] Wi-Fi P2P device controlled by interface wlp1s0
created
Sep 05 14:37:31 Compooper-v2 NetworkManager[876]: <info>
[1725561451.8761] manager: (p2p-dev-wlp1s0): new 802.11 Wi-Fi P2P
device (/org/freedesktop/NetworkManager/Devices/5)
Sep 05 14:37:31 Compooper-v2 NetworkManager[876]: <info>
[1725561451.8763] device (p2p-dev-wlp1s0): state change: unmanaged ->
unavailable (reason 'managed', sys-iface-state: 'external')
Sep 05 14:37:31 Compooper-v2 NetworkManager[876]: <info>
[1725561451.8768] device (wlp1s0): state change: unavailable ->
disconnected (reason 'supplicant-available', sys-iface-state: 'ma>
Sep 05 14:37:31 Compooper-v2 NetworkManager[876]: <info>
[1725561451.8775] device (p2p-dev-wlp1s0): state change: unavailable
-> disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.6861] policy: auto-activating connection 'Oswego-Secure'
(6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.6864] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.6865] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.6867] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.6868] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.6868] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7205] device (wlp1s0): state change: need-auth -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7207] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7209] device (wlp1s0): Activation: (wifi) connection
'Oswego-Secure' has security, and secrets exist.  No new secrets>
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7209] Config: added 'ssid' value 'Oswego-Secure'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7209] Config: added 'scan_ssid' value '1'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7209] Config: added 'bgscan' value 'simple:30:-65:300'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7209] Config: added 'key_mgmt' value 'WPA-EAP FT-EAP
FT-EAP-SHA384 WPA-EAP-SHA256'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7209] Config: added 'auth_alg' value 'OPEN'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7210] Config: added 'password' value '<hidden>'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7210] Config: added 'eap' value 'PEAP'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7210] Config: added 'fragment_size' value '1266'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7210] Config: added 'phase2' value 'auth=MSCHAPV2'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7210] Config: added 'identity' value 'edecampo'
Sep 05 14:37:35 Compooper-v2 NetworkManager[876]: <info>
[1725561455.7210] Config: added 'proactive_key_caching' value '1'
Sep 05 14:37:36 Compooper-v2 NetworkManager[876]: <info>
[1725561456.0650] device (wlp1s0): supplicant interface state:
disconnected -> authenticating
Sep 05 14:37:36 Compooper-v2 NetworkManager[876]: <info>
[1725561456.0651] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> authenticating
Sep 05 14:37:36 Compooper-v2 NetworkManager[876]: <info>
[1725561456.3381] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 14:37:36 Compooper-v2 NetworkManager[876]: <info>
[1725561456.3382] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 14:37:36 Compooper-v2 NetworkManager[876]: <info>
[1725561456.5499] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 14:37:36 Compooper-v2 NetworkManager[876]: <info>
[1725561456.5499] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 14:37:37 Compooper-v2 NetworkManager[876]: <info>
[1725561457.3777] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 14:37:37 Compooper-v2 NetworkManager[876]: <info>
[1725561457.3778] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 14:37:37 Compooper-v2 NetworkManager[876]: <info>
[1725561457.6502] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 14:37:37 Compooper-v2 NetworkManager[876]: <info>
[1725561457.6502] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 14:37:38 Compooper-v2 NetworkManager[876]: <info>
[1725561458.2673] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 14:37:38 Compooper-v2 NetworkManager[876]: <info>
[1725561458.2674] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 14:37:38 Compooper-v2 NetworkManager[876]: <info>
[1725561458.9839] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 14:37:38 Compooper-v2 NetworkManager[876]: <info>
[1725561458.9840] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 14:37:39 Compooper-v2 NetworkManager[876]: <info>
[1725561459.2587] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 14:37:39 Compooper-v2 NetworkManager[876]: <info>
[1725561459.2587] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 14:37:39 Compooper-v2 NetworkManager[876]: <info>
[1725561459.7011] manager: rfkill: Wi-Fi hardware radio set disabled
Sep 05 14:37:39 Compooper-v2 NetworkManager[876]: <info>
[1725561459.7012] device (wlp1s0): state change: config -> unavailable
(reason 'none', sys-iface-state: 'managed')
Sep 05 14:37:39 Compooper-v2 NetworkManager[876]: <info>
[1725561459.7136] audit: op="radio-control" arg="wireless-enabled:off"
pid=1606 uid=1000 result="success"
Sep 05 14:37:39 Compooper-v2 NetworkManager[876]: <info>
[1725561459.7140] manager: rfkill: Wi-Fi now disabled by radio
killswitch
Sep 05 14:37:39 Compooper-v2 NetworkManager[876]: <info>
[1725561459.7143] device (p2p-dev-wlp1s0): state change: disconnected
-> unavailable (reason 'supplicant-failed', sys-iface-state>
Sep 05 15:07:16 Compooper-v2 NetworkManager[876]: <info>
[1725563236.5835] dhcp4 (usb0): state changed new lease,
address=192.168.168.112
Sep 05 15:20:10 Compooper-v2 NetworkManager[876]: <info>
[1725564010.2212] manager: rfkill: Wi-Fi now enabled by radio
killswitch
Sep 05 15:20:12 Compooper-v2 NetworkManager[876]: <info>
[1725564012.7958] audit: op="statistics" interface="usb0" ifindex=3
args="2000" pid=1606 uid=1000 result="success"
Sep 05 15:20:12 Compooper-v2 NetworkManager[876]: <info>
[1725564012.8003] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 15:20:20 Compooper-v2 NetworkManager[876]: <info>
[1725564020.8458] audit: op="statistics" interface="usb0" ifindex=3
args="2000" pid=1606 uid=1000 result="success"
Sep 05 15:20:20 Compooper-v2 NetworkManager[876]: <info>
[1725564020.8499] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 15:20:22 Compooper-v2 NetworkManager[876]: <info>
[1725564022.5315] manager: rfkill: Wi-Fi hardware radio set enabled
Sep 05 15:20:22 Compooper-v2 NetworkManager[876]: <info>
[1725564022.5322] audit: op="radio-control" arg="wireless-enabled:on"
pid=1606 uid=1000 result="success"
Sep 05 15:20:22 Compooper-v2 NetworkManager[876]: <info>
[1725564022.5523] device (wlp1s0): supplicant interface state:
internal-starting -> inactive
Sep 05 15:20:22 Compooper-v2 NetworkManager[876]: <info>
[1725564022.5523] device (wlp1s0): state change: unavailable ->
disconnected (reason 'supplicant-available', sys-iface-state: 'ma>
Sep 05 15:20:22 Compooper-v2 NetworkManager[876]: <info>
[1725564022.5528] device (p2p-dev-wlp1s0): state change: unavailable
-> disconnected (reason 'supplicant-available', sys-iface-st>
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2740] policy: auto-activating connection 'Oswego-Secure'
(6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2744] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2745] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2747] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2750] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2750] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2846] device (wlp1s0): state change: need-auth -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2849] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2853] device (wlp1s0): Activation: (wifi) connection
'Oswego-Secure' has security, and secrets exist.  No new secrets>
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2853] Config: added 'ssid' value 'Oswego-Secure'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2853] Config: added 'scan_ssid' value '1'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2854] Config: added 'bgscan' value 'simple:30:-65:300'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2854] Config: added 'key_mgmt' value 'WPA-EAP FT-EAP
FT-EAP-SHA384 WPA-EAP-SHA256'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2854] Config: added 'auth_alg' value 'OPEN'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2854] Config: added 'password' value '<hidden>'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2854] Config: added 'eap' value 'PEAP'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2854] Config: added 'fragment_size' value '1266'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2854] Config: added 'phase2' value 'auth=MSCHAPV2'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2855] Config: added 'identity' value 'edecampo'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.2855] Config: added 'proactive_key_caching' value '1'
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.5239] device (wlp1s0): supplicant interface state:
inactive -> authenticating
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.5240] device (p2p-dev-wlp1s0): supplicant management
interface state: inactive -> authenticating
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.7906] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:20:26 Compooper-v2 NetworkManager[876]: <info>
[1725564026.7906] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:20:30 Compooper-v2 NetworkManager[876]: <info>
[1725564030.8042] device (wlp1s0): supplicant interface state:
disconnected -> authenticating
Sep 05 15:20:30 Compooper-v2 NetworkManager[876]: <info>
[1725564030.8043] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> authenticating
Sep 05 15:20:31 Compooper-v2 NetworkManager[876]: <info>
[1725564031.0871] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:20:31 Compooper-v2 NetworkManager[876]: <info>
[1725564031.0872] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:20:31 Compooper-v2 NetworkManager[876]: <info>
[1725564031.7030] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:20:31 Compooper-v2 NetworkManager[876]: <info>
[1725564031.7030] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:20:32 Compooper-v2 NetworkManager[876]: <info>
[1725564032.3591] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 15:20:32 Compooper-v2 NetworkManager[876]: <info>
[1725564032.3591] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 15:20:32 Compooper-v2 NetworkManager[876]: <info>
[1725564032.6342] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:20:32 Compooper-v2 NetworkManager[876]: <info>
[1725564032.6342] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:20:33 Compooper-v2 NetworkManager[876]: <info>
[1725564033.7496] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:20:33 Compooper-v2 NetworkManager[876]: <info>
[1725564033.7496] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:20:34 Compooper-v2 NetworkManager[876]: <info>
[1725564034.2514] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 15:20:34 Compooper-v2 NetworkManager[876]: <info>
[1725564034.2515] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 15:20:34 Compooper-v2 NetworkManager[876]: <info>
[1725564034.4428] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:20:34 Compooper-v2 NetworkManager[876]: <info>
[1725564034.4428] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:20:39 Compooper-v2 NetworkManager[876]: <info>
[1725564039.5615] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:20:39 Compooper-v2 NetworkManager[876]: <info>
[1725564039.5616] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:20:45 Compooper-v2 NetworkManager[876]: <info>
[1725564045.8503] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 15:20:45 Compooper-v2 NetworkManager[876]: <info>
[1725564045.8503] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 15:20:46 Compooper-v2 NetworkManager[876]: <info>
[1725564046.1224] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:20:46 Compooper-v2 NetworkManager[876]: <info>
[1725564046.1225] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:20:51 Compooper-v2 NetworkManager[876]: <warn>
[1725564051.8572] device (wlp1s0): Activation: (wifi) association took
too long, failing activation
Sep 05 15:20:51 Compooper-v2 NetworkManager[876]: <info>
[1725564051.8573] device (wlp1s0): state change: config -> failed
(reason 'ssid-not-found', sys-iface-state: 'managed')
Sep 05 15:20:51 Compooper-v2 NetworkManager[876]: <warn>
[1725564051.8585] device (wlp1s0): Activation: failed for connection
'Oswego-Secure'
Sep 05 15:20:51 Compooper-v2 NetworkManager[876]: <info>
[1725564051.8591] device (wlp1s0): state change: failed ->
disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.4937] policy: auto-activating connection 'Oswego-Secure'
(6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.4950] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.4951] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.4955] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.4958] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.4958] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5206] device (wlp1s0): state change: need-auth -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5208] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5210] device (wlp1s0): Activation: (wifi) connection
'Oswego-Secure' has security, and secrets exist.  No new secrets>
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5210] Config: added 'ssid' value 'Oswego-Secure'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5210] Config: added 'scan_ssid' value '1'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5210] Config: added 'bgscan' value 'simple:30:-65:300'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5210] Config: added 'key_mgmt' value 'WPA-EAP FT-EAP
FT-EAP-SHA384 WPA-EAP-SHA256'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5210] Config: added 'auth_alg' value 'OPEN'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5210] Config: added 'password' value '<hidden>'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5210] Config: added 'eap' value 'PEAP'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5210] Config: added 'fragment_size' value '1266'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5211] Config: added 'phase2' value 'auth=MSCHAPV2'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5211] Config: added 'identity' value 'edecampo'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.5211] Config: added 'proactive_key_caching' value '1'
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.7613] device (wlp1s0): supplicant interface state:
disconnected -> authenticating
Sep 05 15:20:55 Compooper-v2 NetworkManager[876]: <info>
[1725564055.7613] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> authenticating
Sep 05 15:20:56 Compooper-v2 NetworkManager[876]: <info>
[1725564056.0275] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:20:56 Compooper-v2 NetworkManager[876]: <info>
[1725564056.0275] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:21:03 Compooper-v2 NetworkManager[876]: <info>
[1725564063.9843] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:21:03 Compooper-v2 NetworkManager[876]: <info>
[1725564063.9843] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:21:06 Compooper-v2 NetworkManager[876]: <info>
[1725564066.9697] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 15:21:06 Compooper-v2 NetworkManager[876]: <info>
[1725564066.9697] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 15:21:07 Compooper-v2 NetworkManager[876]: <info>
[1725564067.2345] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:21:07 Compooper-v2 NetworkManager[876]: <info>
[1725564067.2345] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:21:09 Compooper-v2 NetworkManager[876]: <info>
[1725564069.9873] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:21:09 Compooper-v2 NetworkManager[876]: <info>
[1725564069.9874] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:21:20 Compooper-v2 NetworkManager[876]: <warn>
[1725564080.8574] device (wlp1s0): Activation: (wifi) association took
too long, failing activation
Sep 05 15:21:20 Compooper-v2 NetworkManager[876]: <info>
[1725564080.8575] device (wlp1s0): state change: config -> failed
(reason 'ssid-not-found', sys-iface-state: 'managed')
Sep 05 15:21:20 Compooper-v2 NetworkManager[876]: <warn>
[1725564080.8581] device (wlp1s0): Activation: failed for connection
'Oswego-Secure'
Sep 05 15:21:20 Compooper-v2 NetworkManager[876]: <info>
[1725564080.8583] device (wlp1s0): state change: failed ->
disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5142] device (wlp1s0): supplicant interface state:
scanning -> disconnected
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5143] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> disconnected
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5146] policy: auto-activating connection 'Oswego-Secure'
(6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5154] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5158] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5162] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5165] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5165] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5399] device (wlp1s0): state change: need-auth -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5401] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5404] device (wlp1s0): Activation: (wifi) connection
'Oswego-Secure' has security, and secrets exist.  No new secrets>
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5405] Config: added 'ssid' value 'Oswego-Secure'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5405] Config: added 'scan_ssid' value '1'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5405] Config: added 'bgscan' value 'simple:30:-65:300'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5405] Config: added 'key_mgmt' value 'WPA-EAP FT-EAP
FT-EAP-SHA384 WPA-EAP-SHA256'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5405] Config: added 'auth_alg' value 'OPEN'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5405] Config: added 'password' value '<hidden>'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5405] Config: added 'eap' value 'PEAP'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5405] Config: added 'fragment_size' value '1266'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5406] Config: added 'phase2' value 'auth=MSCHAPV2'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5406] Config: added 'identity' value 'edecampo'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.5406] Config: added 'proactive_key_caching' value '1'
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.7820] device (wlp1s0): supplicant interface state:
disconnected -> authenticating
Sep 05 15:21:24 Compooper-v2 NetworkManager[876]: <info>
[1725564084.7821] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> authenticating
Sep 05 15:21:25 Compooper-v2 NetworkManager[876]: <info>
[1725564085.0583] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:21:25 Compooper-v2 NetworkManager[876]: <info>
[1725564085.0584] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:21:32 Compooper-v2 NetworkManager[876]: <info>
[1725564092.9815] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:21:32 Compooper-v2 NetworkManager[876]: <info>
[1725564092.9816] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:21:35 Compooper-v2 NetworkManager[876]: <info>
[1725564095.8642] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 15:21:35 Compooper-v2 NetworkManager[876]: <info>
[1725564095.8643] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 15:21:36 Compooper-v2 NetworkManager[876]: <info>
[1725564096.1313] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:21:36 Compooper-v2 NetworkManager[876]: <info>
[1725564096.1313] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:21:43 Compooper-v2 NetworkManager[876]: <info>
[1725564103.9855] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:21:43 Compooper-v2 NetworkManager[876]: <info>
[1725564103.9856] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:21:44 Compooper-v2 NetworkManager[876]: <info>
[1725564104.4282] audit: op="statistics" interface="usb0" ifindex=3
args="2000" pid=1606 uid=1000 result="success"
Sep 05 15:21:44 Compooper-v2 NetworkManager[876]: <info>
[1725564104.4320] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 15:21:48 Compooper-v2 NetworkManager[876]: <info>
[1725564108.1884] audit: op="statistics" interface="usb0" ifindex=3
args="2000" pid=1606 uid=1000 result="success"
Sep 05 15:21:48 Compooper-v2 NetworkManager[876]: <info>
[1725564108.1931] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 15:21:49 Compooper-v2 NetworkManager[876]: <warn>
[1725564109.8581] device (wlp1s0): Activation: (wifi) association took
too long, failing activation
Sep 05 15:21:49 Compooper-v2 NetworkManager[876]: <info>
[1725564109.8581] device (wlp1s0): state change: config -> failed
(reason 'ssid-not-found', sys-iface-state: 'managed')
Sep 05 15:21:49 Compooper-v2 NetworkManager[876]: <warn>
[1725564109.8589] device (wlp1s0): Activation: failed for connection
'Oswego-Secure'
Sep 05 15:21:49 Compooper-v2 NetworkManager[876]: <info>
[1725564109.8592] device (wlp1s0): state change: failed ->
disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5330] device (wlp1s0): supplicant interface state:
scanning -> disconnected
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5331] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> disconnected
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5531] policy: auto-activating connection 'Oswego-Secure'
(6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5535] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5535] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5537] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5539] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5539] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5654] device (wlp1s0): state change: need-auth -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5656] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5658] device (wlp1s0): Activation: (wifi) connection
'Oswego-Secure' has security, and secrets exist.  No new secrets>
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5658] Config: added 'ssid' value 'Oswego-Secure'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5658] Config: added 'scan_ssid' value '1'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5658] Config: added 'bgscan' value 'simple:30:-65:300'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5658] Config: added 'key_mgmt' value 'WPA-EAP FT-EAP
FT-EAP-SHA384 WPA-EAP-SHA256'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5658] Config: added 'auth_alg' value 'OPEN'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5659] Config: added 'password' value '<hidden>'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5659] Config: added 'eap' value 'PEAP'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5659] Config: added 'fragment_size' value '1266'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5659] Config: added 'phase2' value 'auth=MSCHAPV2'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5659] Config: added 'identity' value 'edecampo'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5659] Config: added 'proactive_key_caching' value '1'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5897] audit: op="connection-update"
uuid="6fdb1cc1-73a2-465f-948f-4a3cb1b78750" name="Oswego-Secure"
args="connection>
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5924] device (wlp1s0): state change: config ->
deactivating (reason 'new-activation', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5931] device (wlp1s0): disconnecting for new activation
request.
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.5932] audit: op="connection-activate"
uuid="6fdb1cc1-73a2-465f-948f-4a3cb1b78750" name="Oswego-Secure"
pid=5810 uid=0>
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8099] device (wlp1s0): supplicant interface state:
disconnected -> authenticating
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8100] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> authenticating
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8100] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8100] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8101] device (wlp1s0): state change: deactivating ->
disconnected (reason 'new-activation', sys-iface-state: 'managed>
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8106] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (6fdb1cc1-73a2-465f-948f-4a3cb1b78750)
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8110] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8113] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8115] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8115] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <warn>
[1725564113.8117] device (wlp1s0): no secrets: No agents were
available for this request.
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8117] device (wlp1s0): state change: need-auth -> failed
(reason 'no-secrets', sys-iface-state: 'managed')
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <warn>
[1725564113.8118] device (wlp1s0): Activation: failed for connection
'Oswego-Secure'
Sep 05 15:21:53 Compooper-v2 NetworkManager[876]: <info>
[1725564113.8119] device (wlp1s0): state change: failed ->
disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 15:22:24 Compooper-v2 NetworkManager[876]: <info>
[1725564144.7228] audit: op="connection-delete"
uuid="6fdb1cc1-73a2-465f-948f-4a3cb1b78750" name="Oswego-Secure"
pid=5837 uid=0 r>
Sep 05 15:22:27 Compooper-v2 NetworkManager[876]: <info>
[1725564147.0937] audit: op="connection-add-activate" pid=5843 uid=0
result="fail" reason="Failed to determine AP security inform>
Sep 05 15:22:31 Compooper-v2 NetworkManager[876]: <info>
[1725564151.9843] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:22:31 Compooper-v2 NetworkManager[876]: <info>
[1725564151.9844] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:22:35 Compooper-v2 NetworkManager[876]: <info>
[1725564155.4944] device (wlp1s0): supplicant interface state:
scanning -> disconnected
Sep 05 15:22:35 Compooper-v2 NetworkManager[876]: <info>
[1725564155.4944] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> disconnected
Sep 05 15:22:42 Compooper-v2 NetworkManager[876]: <info>
[1725564162.7950] audit: op="connection-add-activate" pid=5856 uid=0
result="fail" reason="Failed to determine AP security inform>
Sep 05 15:22:42 Compooper-v2 NetworkManager[876]: <info>
[1725564162.9833] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:22:42 Compooper-v2 NetworkManager[876]: <info>
[1725564162.9833] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:22:46 Compooper-v2 NetworkManager[876]: <info>
[1725564166.4928] device (wlp1s0): supplicant interface state:
scanning -> disconnected
Sep 05 15:22:46 Compooper-v2 NetworkManager[876]: <info>
[1725564166.4929] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> disconnected
Sep 05 15:22:47 Compooper-v2 NetworkManager[876]: <info>
[1725564167.7720] audit: op="statistics" interface="usb0" ifindex=3
args="2000" pid=1606 uid=1000 result="success"
Sep 05 15:22:47 Compooper-v2 NetworkManager[876]: <info>
[1725564167.7767] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 15:22:53 Compooper-v2 NetworkManager[876]: <info>
[1725564173.9840] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:22:53 Compooper-v2 NetworkManager[876]: <info>
[1725564173.9840] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:22:57 Compooper-v2 NetworkManager[876]: <info>
[1725564177.4939] device (wlp1s0): supplicant interface state:
scanning -> disconnected
Sep 05 15:22:57 Compooper-v2 NetworkManager[876]: <info>
[1725564177.4940] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> disconnected
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0305] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (80dcfee1-83e9-4d1c-9f11-8e94b05b72ea)
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0306] audit: op="connection-add-activate"
uuid="80dcfee1-83e9-4d1c-9f11-8e94b05b72ea" name="Oswego-Secure"
pid=1606 u>
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0310] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0314] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0317] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0317] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0525] device (wlp1s0): state change: need-auth -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0529] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0532] device (wlp1s0): Activation: (wifi) connection
'Oswego-Secure' has security, and secrets exist.  No new secrets>
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0533] Config: added 'ssid' value 'Oswego-Secure'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0533] Config: added 'scan_ssid' value '1'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0533] Config: added 'bgscan' value 'simple:30:-65:300'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0533] Config: added 'key_mgmt' value 'WPA-EAP FT-EAP
FT-EAP-SHA384 WPA-EAP-SHA256'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0533] Config: added 'auth_alg' value 'OPEN'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0533] Config: added 'password' value '<hidden>'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0533] Config: added 'eap' value 'PEAP'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0534] Config: added 'fragment_size' value '1266'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0534] Config: added 'phase2' value 'auth=MSCHAPV2'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0534] Config: added 'identity' value 'edecampo'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.0534] Config: added 'proactive_key_caching' value '1'
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.2982] device (wlp1s0): supplicant interface state:
disconnected -> authenticating
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.2982] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> authenticating
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.5644] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.5645] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.9777] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:23:02 Compooper-v2 NetworkManager[876]: <info>
[1725564182.9777] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:23:03 Compooper-v2 NetworkManager[876]: <info>
[1725564183.9385] audit: op="statistics" interface="usb0" ifindex=3
args="2000" pid=1606 uid=1000 result="success"
Sep 05 15:23:03 Compooper-v2 NetworkManager[876]: <info>
[1725564183.9439] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 15:23:09 Compooper-v2 NetworkManager[876]: <info>
[1725564189.0106] audit: op="statistics" interface="usb0" ifindex=3
args="2000" pid=1606 uid=1000 result="success"
Sep 05 15:23:09 Compooper-v2 NetworkManager[876]: <info>
[1725564189.0167] audit: op="statistics" interface="usb0" ifindex=3
args="500" pid=1714 uid=1000 result="success"
Sep 05 15:23:12 Compooper-v2 NetworkManager[876]: <info>
[1725564192.7691] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 15:23:12 Compooper-v2 NetworkManager[876]: <info>
[1725564192.7691] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 15:23:13 Compooper-v2 NetworkManager[876]: <info>
[1725564193.0438] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:23:13 Compooper-v2 NetworkManager[876]: <info>
[1725564193.0438] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:23:21 Compooper-v2 NetworkManager[876]: <info>
[1725564201.9833] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:23:21 Compooper-v2 NetworkManager[876]: <info>
[1725564201.9834] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:23:26 Compooper-v2 NetworkManager[876]: <warn>
[1725564206.8573] device (wlp1s0): Activation: (wifi) association took
too long, failing activation
Sep 05 15:23:26 Compooper-v2 NetworkManager[876]: <info>
[1725564206.8574] device (wlp1s0): state change: config -> failed
(reason 'ssid-not-found', sys-iface-state: 'managed')
Sep 05 15:23:26 Compooper-v2 NetworkManager[876]: <warn>
[1725564206.8583] device (wlp1s0): Activation: failed for connection
'Oswego-Secure'
Sep 05 15:23:26 Compooper-v2 NetworkManager[876]: <info>
[1725564206.8588] device (wlp1s0): state change: failed ->
disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5011] device (wlp1s0): supplicant interface state:
scanning -> disconnected
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5012] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> disconnected
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5172] policy: auto-activating connection 'Oswego-Secure'
(80dcfee1-83e9-4d1c-9f11-8e94b05b72ea)
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5176] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (80dcfee1-83e9-4d1c-9f11-8e94b05b72ea)
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5176] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5179] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5180] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5180] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5275] device (wlp1s0): state change: need-auth -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5278] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5282] device (wlp1s0): Activation: (wifi) connection
'Oswego-Secure' has security, and secrets exist.  No new secrets>
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5282] Config: added 'ssid' value 'Oswego-Secure'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5283] Config: added 'scan_ssid' value '1'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5283] Config: added 'bgscan' value 'simple:30:-65:300'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5283] Config: added 'key_mgmt' value 'WPA-EAP FT-EAP
FT-EAP-SHA384 WPA-EAP-SHA256'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5283] Config: added 'auth_alg' value 'OPEN'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5283] Config: added 'password' value '<hidden>'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5283] Config: added 'eap' value 'PEAP'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5283] Config: added 'fragment_size' value '1266'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5284] Config: added 'phase2' value 'auth=MSCHAPV2'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5284] Config: added 'identity' value 'edecampo'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.5284] Config: added 'proactive_key_caching' value '1'
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.7692] device (wlp1s0): supplicant interface state:
disconnected -> authenticating
Sep 05 15:23:28 Compooper-v2 NetworkManager[876]: <info>
[1725564208.7692] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> authenticating
Sep 05 15:23:29 Compooper-v2 NetworkManager[876]: <info>
[1725564209.0429] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:23:29 Compooper-v2 NetworkManager[876]: <info>
[1725564209.0429] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:23:31 Compooper-v2 NetworkManager[876]: <info>
[1725564211.9841] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:23:31 Compooper-v2 NetworkManager[876]: <info>
[1725564211.9842] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:23:39 Compooper-v2 NetworkManager[876]: <info>
[1725564219.7513] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 15:23:39 Compooper-v2 NetworkManager[876]: <info>
[1725564219.7513] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 15:23:40 Compooper-v2 NetworkManager[876]: <info>
[1725564220.0274] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:23:40 Compooper-v2 NetworkManager[876]: <info>
[1725564220.0274] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:23:41 Compooper-v2 NetworkManager[876]: <info>
[1725564221.9858] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:23:41 Compooper-v2 NetworkManager[876]: <info>
[1725564221.9858] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:23:53 Compooper-v2 NetworkManager[876]: <warn>
[1725564233.8582] device (wlp1s0): Activation: (wifi) association took
too long, failing activation
Sep 05 15:23:53 Compooper-v2 NetworkManager[876]: <info>
[1725564233.8583] device (wlp1s0): state change: config -> failed
(reason 'ssid-not-found', sys-iface-state: 'managed')
Sep 05 15:23:53 Compooper-v2 NetworkManager[876]: <warn>
[1725564233.8592] device (wlp1s0): Activation: failed for connection
'Oswego-Secure'
Sep 05 15:23:53 Compooper-v2 NetworkManager[876]: <info>
[1725564233.8596] device (wlp1s0): state change: failed ->
disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5643] policy: auto-activating connection 'Oswego-Secure'
(80dcfee1-83e9-4d1c-9f11-8e94b05b72ea)
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5646] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (80dcfee1-83e9-4d1c-9f11-8e94b05b72ea)
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5647] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5649] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5651] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5651] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5739] device (wlp1s0): state change: need-auth -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5741] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5743] device (wlp1s0): Activation: (wifi) connection
'Oswego-Secure' has security, and secrets exist.  No new secrets>
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5743] Config: added 'ssid' value 'Oswego-Secure'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5743] Config: added 'scan_ssid' value '1'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5744] Config: added 'bgscan' value 'simple:30:-65:300'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5744] Config: added 'key_mgmt' value 'WPA-EAP FT-EAP
FT-EAP-SHA384 WPA-EAP-SHA256'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5744] Config: added 'auth_alg' value 'OPEN'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5744] Config: added 'password' value '<hidden>'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5744] Config: added 'eap' value 'PEAP'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5744] Config: added 'fragment_size' value '1266'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5744] Config: added 'phase2' value 'auth=MSCHAPV2'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5744] Config: added 'identity' value 'edecampo'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.5744] Config: added 'proactive_key_caching' value '1'
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.8103] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 15:23:56 Compooper-v2 NetworkManager[876]: <info>
[1725564236.8104] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 15:23:57 Compooper-v2 NetworkManager[876]: <info>
[1725564237.0773] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:23:57 Compooper-v2 NetworkManager[876]: <info>
[1725564237.0774] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:24:08 Compooper-v2 NetworkManager[876]: <info>
[1725564248.7824] device (wlp1s0): supplicant interface state:
disconnected -> authenticating
Sep 05 15:24:08 Compooper-v2 NetworkManager[876]: <info>
[1725564248.7824] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> authenticating
Sep 05 15:24:09 Compooper-v2 NetworkManager[876]: <info>
[1725564249.0474] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:24:09 Compooper-v2 NetworkManager[876]: <info>
[1725564249.0474] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:24:11 Compooper-v2 NetworkManager[876]: <info>
[1725564251.9815] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:24:11 Compooper-v2 NetworkManager[876]: <info>
[1725564251.9815] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:24:21 Compooper-v2 NetworkManager[876]: <warn>
[1725564261.8578] device (wlp1s0): Activation: (wifi) association took
too long, failing activation
Sep 05 15:24:21 Compooper-v2 NetworkManager[876]: <info>
[1725564261.8579] device (wlp1s0): state change: config -> failed
(reason 'ssid-not-found', sys-iface-state: 'managed')
Sep 05 15:24:21 Compooper-v2 NetworkManager[876]: <warn>
[1725564261.8591] device (wlp1s0): Activation: failed for connection
'Oswego-Secure'
Sep 05 15:24:21 Compooper-v2 NetworkManager[876]: <info>
[1725564261.8596] device (wlp1s0): state change: failed ->
disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5227] device (wlp1s0): supplicant interface state:
scanning -> disconnected
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5228] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> disconnected
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5364] policy: auto-activating connection 'Oswego-Secure'
(80dcfee1-83e9-4d1c-9f11-8e94b05b72ea)
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5369] device (wlp1s0): Activation: starting connection
'Oswego-Secure' (80dcfee1-83e9-4d1c-9f11-8e94b05b72ea)
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5370] device (wlp1s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5373] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5376] device (wlp1s0): Activation: (wifi) access point
'Oswego-Secure' has security, but secrets are required.
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5376] device (wlp1s0): state change: config -> need-auth
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5469] device (wlp1s0): state change: need-auth -> prepare
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5472] device (wlp1s0): state change: prepare -> config
(reason 'none', sys-iface-state: 'managed')
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5475] device (wlp1s0): Activation: (wifi) connection
'Oswego-Secure' has security, and secrets exist.  No new secrets>
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5476] Config: added 'ssid' value 'Oswego-Secure'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5476] Config: added 'scan_ssid' value '1'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5476] Config: added 'bgscan' value 'simple:30:-65:300'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5476] Config: added 'key_mgmt' value 'WPA-EAP FT-EAP
FT-EAP-SHA384 WPA-EAP-SHA256'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5477] Config: added 'auth_alg' value 'OPEN'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5477] Config: added 'password' value '<hidden>'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5477] Config: added 'eap' value 'PEAP'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5477] Config: added 'fragment_size' value '1266'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5477] Config: added 'phase2' value 'auth=MSCHAPV2'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5477] Config: added 'identity' value 'edecampo'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.5477] Config: added 'proactive_key_caching' value '1'
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.7891] device (wlp1s0): supplicant interface state:
disconnected -> authenticating
Sep 05 15:24:25 Compooper-v2 NetworkManager[876]: <info>
[1725564265.7891] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> authenticating
Sep 05 15:24:26 Compooper-v2 NetworkManager[876]: <info>
[1725564266.0796] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:24:26 Compooper-v2 NetworkManager[876]: <info>
[1725564266.0796] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:24:33 Compooper-v2 NetworkManager[876]: <info>
[1725564273.9837] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:24:33 Compooper-v2 NetworkManager[876]: <info>
[1725564273.9837] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:24:37 Compooper-v2 NetworkManager[876]: <info>
[1725564277.0076] device (wlp1s0): supplicant interface state:
scanning -> authenticating
Sep 05 15:24:37 Compooper-v2 NetworkManager[876]: <info>
[1725564277.0077] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> authenticating
Sep 05 15:24:37 Compooper-v2 NetworkManager[876]: <info>
[1725564277.2756] device (wlp1s0): supplicant interface state:
authenticating -> disconnected
Sep 05 15:24:37 Compooper-v2 NetworkManager[876]: <info>
[1725564277.2757] device (p2p-dev-wlp1s0): supplicant management
interface state: authenticating -> disconnected
Sep 05 15:24:39 Compooper-v2 NetworkManager[876]: <info>
[1725564279.9830] device (wlp1s0): supplicant interface state:
disconnected -> scanning
Sep 05 15:24:39 Compooper-v2 NetworkManager[876]: <info>
[1725564279.9831] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> scanning
Sep 05 15:24:50 Compooper-v2 NetworkManager[876]: <warn>
[1725564290.8577] device (wlp1s0): Activation: (wifi) association took
too long, failing activation
Sep 05 15:24:50 Compooper-v2 NetworkManager[876]: <info>
[1725564290.8578] device (wlp1s0): state change: config -> failed
(reason 'ssid-not-found', sys-iface-state: 'managed')
Sep 05 15:24:50 Compooper-v2 NetworkManager[876]: <warn>
[1725564290.8590] device (wlp1s0): Activation: failed for connection
'Oswego-Secure'
Sep 05 15:24:50 Compooper-v2 NetworkManager[876]: <info>
[1725564290.8594] device (wlp1s0): state change: failed ->
disconnected (reason 'none', sys-iface-state: 'managed')
Sep 05 15:24:54 Compooper-v2 NetworkManager[876]: <info>
[1725564294.5250] device (wlp1s0): supplicant interface state:
scanning -> disconnected
Sep 05 15:24:54 Compooper-v2 NetworkManager[876]: <info>
[1725564294.5251] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> disconnected
Sep 05 15:25:18 Compooper-v2 NetworkManager[876]: <info>
[1725564318.5418] device (wlp1s0): supplicant interface state:
disconnected -> inactive
Sep 05 15:25:18 Compooper-v2 NetworkManager[876]: <info>
[1725564318.5419] device (p2p-dev-wlp1s0): supplicant management
interface state: disconnected -> inactive
Sep 05 15:25:31 Compooper-v2 NetworkManager[876]: <info>
[1725564331.9833] device (wlp1s0): supplicant interface state:
inactive -> scanning
Sep 05 15:25:31 Compooper-v2 NetworkManager[876]: <info>
[1725564331.9834] device (p2p-dev-wlp1s0): supplicant management
interface state: inactive -> scanning
Sep 05 15:25:35 Compooper-v2 NetworkManager[876]: <info>
[1725564335.5202] device (wlp1s0): supplicant interface state:
scanning -> inactive
Sep 05 15:25:35 Compooper-v2 NetworkManager[876]: <info>
[1725564335.5202] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> inactive
Sep 05 15:25:42 Compooper-v2 NetworkManager[876]: <info>
[1725564342.9815] device (wlp1s0): supplicant interface state:
inactive -> scanning
Sep 05 15:25:42 Compooper-v2 NetworkManager[876]: <info>
[1725564342.9816] device (p2p-dev-wlp1s0): supplicant management
interface state: inactive -> scanning
Sep 05 15:25:46 Compooper-v2 NetworkManager[876]: <info>
[1725564346.5214] device (wlp1s0): supplicant interface state:
scanning -> inactive
Sep 05 15:25:46 Compooper-v2 NetworkManager[876]: <info>
[1725564346.5215] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> inactive
Sep 05 15:25:53 Compooper-v2 NetworkManager[876]: <info>
[1725564353.9816] device (wlp1s0): supplicant interface state:
inactive -> scanning
Sep 05 15:25:53 Compooper-v2 NetworkManager[876]: <info>
[1725564353.9816] device (p2p-dev-wlp1s0): supplicant management
interface state: inactive -> scanning
Sep 05 15:25:57 Compooper-v2 NetworkManager[876]: <info>
[1725564357.5387] device (wlp1s0): supplicant interface state:
scanning -> inactive
Sep 05 15:25:57 Compooper-v2 NetworkManager[876]: <info>
[1725564357.5388] device (p2p-dev-wlp1s0): supplicant management
interface state: scanning -> inactive

