Return-Path: <linux-wireless+bounces-33712-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G2WHoAewWmTQwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33712-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:05:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A47432F0CDE
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 12:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EE20301D4F4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4525D37186F;
	Mon, 23 Mar 2026 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waelti.dev header.i=@waelti.dev header.b="LSNv3IAR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE4539098F
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263507; cv=none; b=rBIY2JZ5atvcbp95GG7PmyibZPvJVI/v/U2FenWYsAeGPvZ6f6lzi1zDb6W3gHYsUpDOUexAIVgVgf+UuEAsA9e5z/cCHCHlmQniWW23SP/6fI8zfmUCcZzXoQndvjAPOncPTEorKPFsLy2Q0cg+xY6+Nkc/Lkyrddl0hQt44v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263507; c=relaxed/simple;
	bh=6gh1pck1kvvCCl4EQT5Aldh74sIXu4tYaB4jvYEgG2s=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=L5uGhnfryEliqSyyCXkZ3ra6MnGJLtLILXFscj2KwAaEL2qo07GQy/jiCeb+S14+c4QA4uTyYJ7hMdSaWXKBGjoqfX6q/tw6zA5sAuNCRnPMAjEkBygAssg/03U8ITgZiu8vOhJkjFmFe7+kvMqMOeoCKLGwy2YnH4lj1EYL5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=waelti.dev; spf=pass smtp.mailfrom=waelti.dev; dkim=pass (2048-bit key) header.d=waelti.dev header.i=@waelti.dev header.b=LSNv3IAR; arc=none smtp.client-ip=109.224.244.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=waelti.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waelti.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waelti.dev;
	s=protonmail; t=1774263491; x=1774522691;
	bh=R3IsD8UMb96v0HYhrxqE4S58UN5nH2BD6cgPLd1941Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LSNv3IARymVYAerVzKrCP7M2gljau07ptywpD73TJyNUcDnRCrXjrxHBvG+KaWg/a
	 C7LxTsKRE3x6uo0dz/kUaAkEFkPfZOxMlU6IeS0nV3tihbRoNqjFAO3qpkLxFPsUPP
	 ScKbygmTpc9R1YnMo2s/mqzvBfjHFU6idbYhGTMHMsFxQdudeFMH8bTz+bLbBVnuFr
	 urj2MYsC3ajhnlXQf7hMgHLQDPhzJwTDCqtYyYp2nKRjImj87WgO8k4Vt20I+023NC
	 Sy/esPklosYGgPiaBO5J3EgazxmHQfDuXSGsNLsX1dk04D5m9/iUtBrKjSC+lhjpi1
	 qyu3FSL4gtKxQ==
Date: Mon, 23 Mar 2026 10:58:07 +0000
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: =?utf-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>
Cc: "pkshih@realtek.com" <pkshih@realtek.com>
Subject: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration on AP bandwidth change
Message-ID: <SnJ_b28_Uro9Xtlb2ew62uypaut_7wD44Qnmibm2Yj4FgSS7cayhZvqkK8-AXGNAc-xdwYST6E2GDCMcoZh33PjukvAsXwaqMzx8Z14_aA0=@waelti.dev>
Feedback-ID: 168448313:user:proton
X-Pm-Message-ID: 94b7e0144da9cb9d37f03779038ff95face99442
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[waelti.dev,quarantine];
	R_DKIM_ALLOW(-0.20)[waelti.dev:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-33712-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[waelti.dev:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrey@waelti.dev,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A47432F0CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
=20
I am experiencing a reproducible HWSI bus lockup on the RTL8922AE
(rtw89_8922ae) triggered by the connected AP changing its advertised
bandwidth in a beacon. During the lockup, the radio is unresponsive and the=
 only fix I could find is reconnecting to the network.
=20
The issue occurs on every boot within seconds of association, and also duri=
ng normal operation whenever the AP re-advertises its
channel width.
=20
I have tested with both the in-tree driver on kernel 6.19 and the
latest out-of-tree driver from morrownr/rtw89 (git HEAD). Both
reproduce the issue identically.

User-visible impact
-------------------
=20
During the HWSI busy window, all network traffic basically stops. Existing =
TCP connections stall and time-sensitive applications (VoIP, video calls) b=
reak. The Wi-Fi/BT coexistence is also disrupted, causing paired Bluetooth =
devices to disconnect.
=20
The issue reproduces on every association and also during
runtime when the AP periodically re-advertises its bandwidth (sometimes eve=
ry few minutes), making connectivity unreliable.

Boot-to-bug dmesg (trimmed to relevant entries)
------------------------------------------------

[   17.659262] rtw89_8922ae 0000:03:00.0: loaded firmware rtw89/rtw8922a_fw=
-4.bin
[   17.659440] rtw89_8922ae 0000:03:00.0: enabling device (0000 -> 0003)
[   17.666964] rtw89_8922ae 0000:03:00.0: Firmware version 0.35.80.3 (8ef4f=
0cf), cmd version 1, type 1
[   17.666968] rtw89_8922ae 0000:03:00.0: Firmware version 0.35.80.3 (8ef4f=
0cf), cmd version 1, type 3
[   17.685115] rtw89_8922ae 0000:03:00.0: chip rfe_type is 1
[   17.685886] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:0=
8.1/0000:04:00.6/sound/card1/input24
[   17.685913] input: HD-Audio Generic Headphone as /devices/pci0000:00/000=
0:00:08.1/0000:04:00.6/sound/card1/input25
[   17.687499] rtw89_8922ae 0000:03:00.0: Firmware version 0.1.0.0 (7b39381=
8), cmd version 0, type 64
[   17.687504] rtw89_8922ae 0000:03:00.0: Firmware element BB version: 00 4=
9 00 00
[   17.687511] rtw89_8922ae 0000:03:00.0: Firmware element radio A version:=
 00 33 00 00
[   17.687516] rtw89_8922ae 0000:03:00.0: Firmware element NCTL version: 00=
 0f 00 00
[   17.687536] rtw89_8922ae 0000:03:00.0: Firmware element TXPWR version: 0=
0 46 00 00
[   17.687537] rtw89_8922ae 0000:03:00.0: Firmware element TXPWR version: 0=
0 46 00 00
[   17.687538] rtw89_8922ae 0000:03:00.0: Firmware element TXPWR version: 0=
0 46 00 00
[   17.687546] rtw89_8922ae 0000:03:00.0: Firmware element PWR_TRK version:=
 00 33 00 00
[   17.687550] rtw89_8922ae 0000:03:00.0: Firmware element REGD version: 00=
 49 00 08
[   17.691873] rtw89_8922ae 0000:03:00.0: rfkill hardware state changed to =
enable
[   18.108033] systemd-journald[808]: Received client request to flush runt=
ime journal.
[   18.367229] input: keyd virtual keyboard as /devices/virtual/input/input=
26
[   18.383013] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   18.383017] Bluetooth: BNEP filters: protocol multicast
[   18.383021] Bluetooth: BNEP socket layer initialized
[   18.410929] input: keyd virtual pointer as /devices/virtual/input/input2=
7
[   18.464298] Bluetooth: hci0: RTL: fw version 0x41c0c905
[   18.647322] Bluetooth: hci0: AOSP extensions version v1.00
[   18.647546] Bluetooth: MGMT ver 1.23
[   18.655814] NET: Registered PF_ALG protocol family
[   21.985205] wlan0: authenticate with 7c:10:c9:b5:b4:4c (local address=3D=
7c:fa:80:c3:5b:f9)
[   21.985210] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 1/3)
[   22.001200] wlan0: authenticate with 7c:10:c9:b5:b4:4c (local address=3D=
7c:fa:80:c3:5b:f9)
[   22.001210] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 1/3)
[   22.002893] wlan0: authenticated
[   22.003792] wlan0: associate with 7c:10:c9:b5:b4:4c (try 1/3)
[   22.005327] wlan0: RX AssocResp from 7c:10:c9:b5:b4:4c (capab=3D0x1011 s=
tatus=3D0 aid=3D17)
[   22.111182] wlan0: associated
[   22.111255] wlan0: Ignore NSS change to invalid 4 in VHT opmode notif fr=
om 7c:10:c9:b5:b4:4c
[   22.111263] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised by=
 7c:10:c9:b5:b4:4c
[   32.623170] hid-sensor-hub 0020:1022:0001.0004: hidraw3: SENSOR HUB HID =
v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[   33.076564] wlan0: AP 7c:10:c9:b5:b4:4c changed bandwidth in beacon, new=
 used config is 5220.000 MHz, width 5 (5250.000/0 MHz)
[   33.090085] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.102460] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.114775] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.127371] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.141826] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.153783] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.165901] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.178402] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.191675] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.205185] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.217544] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.229788] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.242802] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.257200] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.269858] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.282153] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.295625] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.307822] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.320258] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.332693] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.345004] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.360051] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.373084] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.385703] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.397827] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.411372] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.426744] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.438969] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.451407] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.464456] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.477296] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.489589] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.502064] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[   33.514235] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[   33.514249] wlan0: Ignore NSS change to invalid 4 in VHT opmode notif fr=
om 7c:10:c9:b5:b4:4c
[   34.491697] rfkill: input handler disabled
[   34.778186] Bluetooth: RFCOMM TTY layer initialized
[   34.778198] Bluetooth: RFCOMM socket layer initialized
[   34.778201] Bluetooth: RFCOMM ver 1.11
[   39.723603] rfkill: input handler enabled
[   40.871391] rfkill: input handler disabled
[   41.010414] nvme nvme0: using unchecked data buffer
[   43.272141] warning: `ThreadPoolForeg' uses wireless extensions which wi=
ll stop working for Wi-Fi 7 hardware; use nl80211

Environment
-----------

Linux version 6.19.9-1-cachyos (linux-cachyos@cachyos) (clang version 22.1.=
1, LLD 22.1.1) #1 SMP PREEMPT_DYNAMIC Thu, 19 Mar 2026 20:13:27 +0000

03:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8922A=
E 802.11be PCIe Wireless Network Adapter [10ec:8922] (rev 01)
=09Subsystem: Lenovo Device [17aa:4922]
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B- DisINTx+
=09Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
=09Latency: 0
=09Interrupt: pin A routed to IRQ 112
=09IOMMU group: 15
=09Region 0: I/O ports at 2000 [size=3D256]
=09Region 2: Memory at 80b00000 (64-bit, non-prefetchable) [size=3D1M]
=09Capabilities: <access denied>
=09Kernel driver in use: rtw89_8922ae
=09Kernel modules: rtw89_8922ae

rtw89_8922ae           12288  0
rtw89_8922a            77824  1 rtw89_8922ae
rtw89_pci             131072  1 rtw89_8922ae
rtw89_core           1236992  2 rtw89_8922a,rtw89_pci
mac80211             1806336  2 rtw89_core,rtw89_pci
cfg80211             1523712  3 rtw89_core,rtw89_8922a,mac80211
rfkill                 45056  9 rtw89_core,bluetooth,ideapad_laptop,cfg8021=
1

Hardware:    Lenovo Yoga 7 2-in-1 14AKP10 (machine type 83JR)
Chip:        RTL8922AE (PCI ID 10ec:8922)
Firmware:    rtw89/rtw8922a_fw-4.bin, version 0.35.80.3 (8ef4f0cf)
RFE type:    1

I am happy to provide additional debugging information, test patches, or co=
llect further traces if needed.
=20
Thanks,
Jeffrey W=C3=A4lti

