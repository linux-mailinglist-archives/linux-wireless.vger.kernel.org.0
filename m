Return-Path: <linux-wireless+bounces-33867-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGz6HVk3xGnkxQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33867-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 20:28:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83232B3EC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 20:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6425307CC3A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D412351C3A;
	Wed, 25 Mar 2026 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waelti.dev header.i=@waelti.dev header.b="EZEUcsAU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA7D35A393
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466744; cv=none; b=qtrp5UiZ24lYbR+e57kizia++m6Q/k2YfgnCGpJnGOGIJnPgJR0FUP0s55ioSWuoJV0NLMFAGBldifm1VeqPF6GLRk3JfKypdRWnuZLdgVOONPrCNB+hMFF4ho+Ktq8D+knF0bpvFx3NGSYfI4r4r3qvSZQXOdy1f/Ty7iUNqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466744; c=relaxed/simple;
	bh=S0/EeLiCdssCR97eT+6M9vsFoYo4F0q54R7URk1sUrs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6JEm7G80GIPy8SpyE6QXxc25coywFfZKr9dvW3hbUfk+9NJdb3kIoPnWEScf8QBUETCYvzFYrCXbabkkLLsDumR1XRgp6sP3nWmpYt4EmJ0huBQOfugwbbT7BsBXo8D4mTkoWj6n2CP03jrKb/p6Pemt9ZBNjljG5QBe1Ujw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=waelti.dev; spf=pass smtp.mailfrom=waelti.dev; dkim=pass (2048-bit key) header.d=waelti.dev header.i=@waelti.dev header.b=EZEUcsAU; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=waelti.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waelti.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waelti.dev;
	s=protonmail; t=1774466730; x=1774725930;
	bh=1pkEwT5ezBo/JFS2x6OxLbXqLypNAF0nkPTpt0PC2Fw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EZEUcsAUMhlltmyKrQdESu/wPeierIMsWBM9zVmK4BZoM+pNuJchG0VwPnsdaaiDL
	 LaFanrtoDBaFSKJLWBP8nMtkZsnAqxPzBk9oj36MnAuM8hunRR4TYnlE5E4FxbqtAn
	 XlCA/Hkdgw4FI2Sm1qQGvoFaZaeKZP+72+EzFUsh/dYN0JqX+IgCgm8hwEcbSQu3gW
	 KjVHclndIMMQixJZErbY+aTnCBiSkUxOYETo7Gs51bMOmT3lXY4blQAQTZKLupoA2g
	 xnsL782nQQBzJd4wQ6XX4EsqBNvuYAXJduCF84QHaJI3gP3gI0uFBuiv/MJy3+lD1e
	 3sWir+2tJ/VYQ==
Date: Wed, 25 Mar 2026 19:25:27 +0000
To: Ping-Ke Shih <pkshih@realtek.com>
From: =?utf-8?Q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: wifi: rtw89: rtw8922ae: HWSI bus lockup during RF recalibration on AP bandwidth change
Message-ID: <uyjP590fzro7xuECRhUp6nlegi4hnWSBbrrFd-tcCcKeeKbDaoUThi7EkMNUMC2LYibyA0jaAqR7GrIchbJcGVh5CSgiGa39jMQkLq5F9QY=@waelti.dev>
In-Reply-To: <8bf447cc627746cca6eb30ae283bbbe6@realtek.com>
References: <SnJ_b28_Uro9Xtlb2ew62uypaut_7wD44Qnmibm2Yj4FgSS7cayhZvqkK8-AXGNAc-xdwYST6E2GDCMcoZh33PjukvAsXwaqMzx8Z14_aA0=@waelti.dev> <8bf447cc627746cca6eb30ae283bbbe6@realtek.com>
Feedback-ID: 168448313:user:proton
X-Pm-Message-ID: 056d6a3d391a7d41f22774826d66b4fca6109cda
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[waelti.dev:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33867-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[waelti.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrey@waelti.dev,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: ED83232B3EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

<pkshih@realtek.com> wrote:

> Jeffrey W=C3=A4lti <jeffrey@waelti.dev> wrote:
> > Hi,
> >
> > I am experiencing a reproducible HWSI bus lockup on the RTL8922AE
> > (rtw89_8922ae) triggered by the connected AP changing its advertised
> > bandwidth in a beacon. During the lockup, the radio is unresponsive and=
 the only
> > fix I could find is reconnecting to the network.
> >
> > The issue occurs on every boot within seconds of association, and also =
during
> > normal operation whenever the AP re-advertises its
> > channel width.
> >
> > I have tested with both the in-tree driver on kernel 6.19 and the
> > latest out-of-tree driver from morrownr/rtw89 (git HEAD). Both
> > reproduce the issue identically.
>=20
> Please try to disable power save and ASPM by
> 1) iw wlan0 set power_save off
> 2) reference and install https://github.com/lwfinger/rtw89/blob/main/70-r=
tw89.conf
>    and then cold reboot.
>=20
> >
> > User-visible impact
> > -------------------
> >
> > During the HWSI busy window, all network traffic basically stops. Exist=
ing TCP
> > connections stall and time-sensitive applications (VoIP, video calls) b=
reak. The
> > Wi-Fi/BT coexistence is also disrupted, causing paired Bluetooth device=
s to
> > disconnect.
> >
> > The issue reproduces on every association and also during
> > runtime when the AP periodically re-advertises its bandwidth (sometimes=
 every
> > few minutes), making connectivity unreliable.
> >
> > Boot-to-bug dmesg (trimmed to relevant entries)
> > ------------------------------------------------
> >
> > [   17.659262] rtw89_8922ae 0000:03:00.0: loaded firmware
> > rtw89/rtw8922a_fw-4.bin
> > [   17.659440] rtw89_8922ae 0000:03:00.0: enabling device (0000 -> 0003=
)
> > [   17.666964] rtw89_8922ae 0000:03:00.0: Firmware version 0.35.80.3 (8=
ef4f0cf),
> > cmd version 1, type 1
> > [   17.666968] rtw89_8922ae 0000:03:00.0: Firmware version 0.35.80.3 (8=
ef4f0cf),
> > cmd version 1, type 3
> > [   17.685115] rtw89_8922ae 0000:03:00.0: chip rfe_type is 1
> > [   17.685886] input: HD-Audio Generic Mic as
> > /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input24
> > [   17.685913] input: HD-Audio Generic Headphone as
> > /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input25
> > [   17.687499] rtw89_8922ae 0000:03:00.0: Firmware version 0.1.0.0 (7b3=
93818),
> > cmd version 0, type 64
> > [   17.687504] rtw89_8922ae 0000:03:00.0: Firmware element BB version: =
00 49 00
> > 00
> > [   17.687511] rtw89_8922ae 0000:03:00.0: Firmware element radio A vers=
ion: 00
> > 33 00 00
> > [   17.687516] rtw89_8922ae 0000:03:00.0: Firmware element NCTL version=
: 00 0f
> > 00 00
> > [   17.687536] rtw89_8922ae 0000:03:00.0: Firmware element TXPWR versio=
n: 00 46
> > 00 00
> > [   17.687537] rtw89_8922ae 0000:03:00.0: Firmware element TXPWR versio=
n: 00 46
> > 00 00
> > [   17.687538] rtw89_8922ae 0000:03:00.0: Firmware element TXPWR versio=
n: 00 46
> > 00 00
> > [   17.687546] rtw89_8922ae 0000:03:00.0: Firmware element PWR_TRK vers=
ion: 00
> > 33 00 00
> > [   17.687550] rtw89_8922ae 0000:03:00.0: Firmware element REGD version=
: 00 49
> > 00 08
> > [   17.691873] rtw89_8922ae 0000:03:00.0: rfkill hardware state changed=
 to
> > enable
> > [   18.108033] systemd-journald[808]: Received client request to flush =
runtime
> > journal.
> > [   18.367229] input: keyd virtual keyboard as /devices/virtual/input/i=
nput26
> > [   18.383013] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> > [   18.383017] Bluetooth: BNEP filters: protocol multicast
> > [   18.383021] Bluetooth: BNEP socket layer initialized
> > [   18.410929] input: keyd virtual pointer as /devices/virtual/input/in=
put27
> > [   18.464298] Bluetooth: hci0: RTL: fw version 0x41c0c905
> > [   18.647322] Bluetooth: hci0: AOSP extensions version v1.00
> > [   18.647546] Bluetooth: MGMT ver 1.23
> > [   18.655814] NET: Registered PF_ALG protocol family
> > [   21.985205] wlan0: authenticate with 7c:10:c9:b5:b4:4c (local
> > address=3D7c:fa:80:c3:5b:f9)
> > [   21.985210] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 1/3)
> > [   22.001200] wlan0: authenticate with 7c:10:c9:b5:b4:4c (local
> > address=3D7c:fa:80:c3:5b:f9)
> > [   22.001210] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 1/3)
> > [   22.002893] wlan0: authenticated
> > [   22.003792] wlan0: associate with 7c:10:c9:b5:b4:4c (try 1/3)
> > [   22.005327] wlan0: RX AssocResp from 7c:10:c9:b5:b4:4c (capab=3D0x10=
11
> > status=3D0 aid=3D17)
> > [   22.111182] wlan0: associated
> > [   22.111255] wlan0: Ignore NSS change to invalid 4 in VHT opmode noti=
f from
> > 7c:10:c9:b5:b4:4c
> > [   22.111263] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertise=
d by
> > 7c:10:c9:b5:b4:4c
> > [   32.623170] hid-sensor-hub 0020:1022:0001.0004: hidraw3: SENSOR HUB =
HID
> > v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
> > [   33.076564] wlan0: AP 7c:10:c9:b5:b4:4c changed bandwidth in beacon,=
 new used
> > config is 5220.000 MHz, width 5 (5250.000/0 MHz)
> > [   33.090085] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.102460] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.114775] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.127371] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.141826] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.153783] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.165901] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.178402] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.191675] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.205185] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.217544] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.229788] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.242802] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.257200] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.269858] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.282153] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.295625] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.307822] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.320258] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.332693] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.345004] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.360051] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.373084] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.385703] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.397827] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.411372] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.426744] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.438969] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.451407] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.464456] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.477296] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.489589] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.502064] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
> > [   33.514235] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a=
] HWSI
> > is busy
> > [   33.514249] wlan0: Ignore NSS change to invalid 4 in VHT opmode noti=
f from
> > 7c:10:c9:b5:b4:4c
> > [   34.491697] rfkill: input handler disabled
> > [   34.778186] Bluetooth: RFCOMM TTY layer initialized
> > [   34.778198] Bluetooth: RFCOMM socket layer initialized
> > [   34.778201] Bluetooth: RFCOMM ver 1.11
> > [   39.723603] rfkill: input handler enabled
> > [   40.871391] rfkill: input handler disabled
> > [   41.010414] nvme nvme0: using unchecked data buffer
> > [   43.272141] warning: `ThreadPoolForeg' uses wireless extensions whic=
h will
> > stop working for Wi-Fi 7 hardware; use nl80211
> >
> > Environment
> > -----------
> >
> > Linux version 6.19.9-1-cachyos (linux-cachyos@cachyos) (clang version 2=
2.1.1,
> > LLD 22.1.1) #1 SMP PREEMPT_DYNAMIC Thu, 19 Mar 2026 20:13:27 +0000
> >
> > 03:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8=
922AE
> > 802.11be PCIe Wireless Network Adapter [10ec:8922] (rev 01)
> >         Subsystem: Lenovo Device [17aa:4922]
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err-
> > Stepping- SERR- FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort-
> > <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0
> >         Interrupt: pin A routed to IRQ 112
> >         IOMMU group: 15
> >         Region 0: I/O ports at 2000 [size=3D256]
> >         Region 2: Memory at 80b00000 (64-bit, non-prefetchable) [size=
=3D1M]
> >         Capabilities: <access denied>
> >         Kernel driver in use: rtw89_8922ae
> >         Kernel modules: rtw89_8922ae
> >
> > rtw89_8922ae           12288  0
> > rtw89_8922a            77824  1 rtw89_8922ae
> > rtw89_pci             131072  1 rtw89_8922ae
> > rtw89_core           1236992  2 rtw89_8922a,rtw89_pci
> > mac80211             1806336  2 rtw89_core,rtw89_pci
> > cfg80211             1523712  3 rtw89_core,rtw89_8922a,mac80211
> > rfkill                 45056  9 rtw89_core,bluetooth,ideapad_laptop,cfg=
80211
> >
> > Hardware:    Lenovo Yoga 7 2-in-1 14AKP10 (machine type 83JR)
> > Chip:        RTL8922AE (PCI ID 10ec:8922)
> > Firmware:    rtw89/rtw8922a_fw-4.bin, version 0.35.80.3 (8ef4f0cf)
> > RFE type:    1
> >
> > I am happy to provide additional debugging information, test patches, o=
r collect
> > further traces if needed.
>=20
> Please help to test the latest kernel 7.0-rc with additional patch [1].
>=20
> [1] https://lore.kernel.org/linux-wireless/20260310080146.31113-4-pkshih@=
realtek.com/
>=20
> Ping-Ke
>=20
>=20

Thank you for coming back to me so quickly, I just encountered the same thi=
ng with kernel 7.0-rc5.

[26055.113514] wlan0: authenticate with 7c:10:c9:b5:b4:4c (local address=3D=
7c:fa:80:c3:5b:f9)
[26055.113528] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 1/3)
[26055.133089] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 2/3)
[26055.150902] wlan0: authenticate with 7c:10:c9:b5:b4:4c (local address=3D=
7c:fa:80:c3:5b:f9)
[26055.150914] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 1/3)
[26055.153246] wlan0: authenticated
[26055.153721] wlan0: associate with 7c:10:c9:b5:b4:4c (try 1/3)
[26055.155584] wlan0: RX AssocResp from 7c:10:c9:b5:b4:4c (capab=3D0x1011 s=
tatus=3D0 aid=3D27)
[26055.271023] wlan0: associated
[26055.271237] wlan0: Ignore NSS change to invalid 4 in VHT opmode notif fr=
om 7c:10:c9:b5:b4:4c
[26055.271248] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised by=
 7c:10:c9:b5:b4:4c
[26065.984663] wlan0: AP 7c:10:c9:b5:b4:4c changed bandwidth in beacon, new=
 used config is 5220.000 MHz, width 5 (5250.000/0 MHz)
[26065.999102] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.012897] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.026604] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.040218] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.055075] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.066562] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.078117] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.090357] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.102961] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.115725] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.127339] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.139004] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.150442] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.161916] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.173963] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.185870] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.197456] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.209340] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.221632] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.233635] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.245872] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.259756] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.271685] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.283509] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.295651] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.308285] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.320675] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.332706] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.344874] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.356848] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.369061] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.381196] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.393249] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26066.405227] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26066.405240] wlan0: Ignore NSS change to invalid 4 in VHT opmode notif fr=
om 7c:10:c9:b5:b4:4c
[26078.276959] wlan0: authenticate with 7c:10:c9:b5:b4:48 (local address=3D=
7c:fa:80:c3:5b:f9)
[26078.276970] wlan0: send auth to 7c:10:c9:b5:b4:48 (try 1/3)
[26078.295560] wlan0: authenticate with 7c:10:c9:b5:b4:48 (local address=3D=
7c:fa:80:c3:5b:f9)
[26078.295573] wlan0: send auth to 7c:10:c9:b5:b4:48 (try 1/3)
[26078.305323] wlan0: authenticated
[26078.307561] wlan0: associate with 7c:10:c9:b5:b4:48 (try 1/3)
[26078.313095] wlan0: RX AssocResp from 7c:10:c9:b5:b4:48 (capab=3D0x1411 s=
tatus=3D0 aid=3D33)
[26078.424096] wlan0: associated
[26165.453429] ideapad_acpi VPC2004:00: unexpected charge_types: both [Fast=
] and [Long_Life] are enabled
[26226.049306] wlan0: disconnect from AP 7c:10:c9:b5:b4:48 for new auth to =
7c:10:c9:b5:b4:4c
[26226.283858] wlan0: authenticate with 7c:10:c9:b5:b4:4c (local address=3D=
7c:fa:80:c3:5b:f9)
[26226.283870] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 1/3)
[26226.284759] wlan0: authenticated
[26226.286909] wlan0: associate with 7c:10:c9:b5:b4:4c (try 1/3)
[26226.289664] wlan0: RX ReassocResp from 7c:10:c9:b5:b4:4c (capab=3D0x1011=
 status=3D0 aid=3D13)
[26226.400500] wlan0: associated
[26226.400560] wlan0: Ignore NSS change to invalid 4 in VHT opmode notif fr=
om 7c:10:c9:b5:b4:4c
[26226.400566] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised by=
 7c:10:c9:b5:b4:4c
[26237.305703] wlan0: AP 7c:10:c9:b5:b4:4c changed bandwidth in beacon, new=
 used config is 5220.000 MHz, width 5 (5250.000/0 MHz)
[26237.323124] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.338894] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.352942] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.366488] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.380974] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.396258] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.410103] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.423962] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.439875] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.454635] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.468377] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.482203] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.496234] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.510190] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.524248] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.536842] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.550513] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.564329] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.578157] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.591944] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.605710] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.621850] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.635990] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.650297] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.664291] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.679167] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.694107] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.708096] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.722032] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.735945] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.749689] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.763441] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.777281] rtw89_8922ae 0000:03:00.0: poll HWSI is busy
[26237.791136] rtw89_8922ae 0000:03:00.0: [rtw89_phy_write_full_rf_v2_a] HW=
SI is busy
[26237.791148] wlan0: Ignore NSS change to invalid 4 in VHT opmode notif fr=
om 7c:10:c9:b5:b4:4c
[26323.825259] wlan0: deauthenticating from 7c:10:c9:b5:b4:4c by local choi=
ce (Reason: 3=3DDEAUTH_LEAVING)
[26324.373581] wlan0: authenticate with 7c:10:c9:b5:b4:4c (local address=3D=
7c:fa:80:c3:5b:f9)
[26324.373593] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 1/3)
[26324.391589] wlan0: authenticate with 7c:10:c9:b5:b4:4c (local address=3D=
7c:fa:80:c3:5b:f9)
[26324.391624] wlan0: send auth to 7c:10:c9:b5:b4:4c (try 1/3)
[26324.393858] wlan0: authenticated
[26324.394270] wlan0: associate with 7c:10:c9:b5:b4:4c (try 1/3)
[26324.395784] wlan0: RX AssocResp from 7c:10:c9:b5:b4:4c (capab=3D0x1011 s=
tatus=3D0 aid=3D20)
[26324.503689] wlan0: associated
[26324.503778] wlan0: Limiting TX power to 23 (23 - 0) dBm as advertised by=
 7c:10:c9:b5:b4:4c

Jeffrey W=C3=A4lti

