Return-Path: <linux-wireless+bounces-13467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF63E98EE18
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F383F1C21795
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956B154C09;
	Thu,  3 Oct 2024 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lagy.org header.i=@lagy.org header.b="VyhtdUHb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from anon.cephalopo.net (anon.cephalopo.net [93.160.30.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE9F154425
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.160.30.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954778; cv=none; b=hUkk50Avsp02wa5p0JZo2rsETc04gueFEvXQxwZoScQuz/LMryi7XK3f/Dl02hmfzxHbQ3KwkQ9aYYWeeaXAccqwrVcrWkeSsGGyP3ZqSc+Nu0be8zf1bb9Kr5qSUEHMA6L0JpBj7SXIwL3f6j96G1/DLvqc4Q2XDyzmy+oSNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954778; c=relaxed/simple;
	bh=Mxu++gfIEzgM91X4Et7Xwtza93SVzMGLvJtf0GX04oU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lw1scc5qZr/276qPChQyoUbkz2uNBbig3rjIramr+h4ug5U8zyFXTOq1eEWI7SdsuvCBngrtB2MSVIQHbXsJze3QWV14uX6EI0xy0CwzNGzVl0yq+Pbrs3pW4TSl6wRoHTkG28kiGT3o/OpuK4/ymNYlFdOEGt5O0Rf+6/F3lS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lagy.org; spf=pass smtp.mailfrom=lagy.org; dkim=pass (2048-bit key) header.d=lagy.org header.i=@lagy.org header.b=VyhtdUHb; arc=none smtp.client-ip=93.160.30.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lagy.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lagy.org
Received: from localhost (unknown [109.70.55.226])
	by anon.cephalopo.net (Postfix) with ESMTPSA id 4XK8Np0DVMz1xnl
	for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2024 11:20:26 +0000 (UTC)
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.mailfrom=me@lagy.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lagy.org; s=def2;
	t=1727954426; x=1728559226;
	bh=IVplJjNHjxEKyn1Nnfk/T62ar2qaBk/DNkKWerHNWZs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:From:To:Reply-To:Cc:
	 Message-ID:Subject:Date;
	b=VyhtdUHbXckh+B9wgiqXRgX0TJmzR7v449szSX5UG77yQhe+R02FrGTj68yvXCElq
	 sPbDWQbF6OpaYdJydt5gcIzix6IhIQ9JVxtP8MujwKeB9N92Yp0H+fsmM53eK1hAMq
	 PGa9TZJmWB4PeveXY5QK1ZDJmnetdIARWCD8YTe7g44I+0qM6wWXP3QGpGWd0Dfr8a
	 ENheGquGrE/VYDO0xPgCljbGL232DY6gwLoQN8zMmfWLYcPno2fsyQhO7ZhlPiRX25
	 a4ztaDd2NXysZMEfrfwNUOpWIomxQWMj8VTK+8sTZ2AUPJxI8uiYdEUlLmxlBdUD32
	 JWoU/GMQRBljw==
From: =?utf-8?Q?Martin_Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: linux-wireless@vger.kernel.org
Subject: 
Date: Thu, 03 Oct 2024 13:20:25 +0200
Message-ID: <87ed4xa0w6.fsf@danelec.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hey linux-wireless,

I have experienced an allegedly microcode problem with my iwl 9260 device on
my Thinkpad X395 running latest Gentoo, kernel 6.6.51 and linux-firmware from
20240909.

...
[    5.019881] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[    5.019956] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    5.024925] iwlwifi 0000:01:00.0: Detected crf-id 0x2816, cnv-id 0x1000200 wfpm id 0x80000000
[    5.024988] iwlwifi 0000:01:00.0: PCI dev 2526/0014, rev=0x321, rfid=0x105110
[    5.025406] Loading firmware: iwlwifi-9260-th-b0-jf-b0-46.ucode
...
[    5.035262] iwlwifi 0000:01:00.0: WRT: Overriding region id 0
[    5.035272] iwlwifi 0000:01:00.0: WRT: Overriding region id 1
[    5.035276] iwlwifi 0000:01:00.0: WRT: Overriding region id 2
[    5.035280] iwlwifi 0000:01:00.0: WRT: Overriding region id 3
[    5.035284] iwlwifi 0000:01:00.0: WRT: Overriding region id 4
[    5.035288] iwlwifi 0000:01:00.0: WRT: Overriding region id 6
[    5.035292] iwlwifi 0000:01:00.0: WRT: Overriding region id 8
[    5.035295] iwlwifi 0000:01:00.0: WRT: Overriding region id 9
[    5.035299] iwlwifi 0000:01:00.0: WRT: Overriding region id 10
[    5.035303] iwlwifi 0000:01:00.0: WRT: Overriding region id 11
[    5.035307] iwlwifi 0000:01:00.0: WRT: Overriding region id 15
[    5.035311] iwlwifi 0000:01:00.0: WRT: Overriding region id 16
[    5.035314] iwlwifi 0000:01:00.0: WRT: Overriding region id 18
[    5.035318] iwlwifi 0000:01:00.0: WRT: Overriding region id 19
[    5.035322] iwlwifi 0000:01:00.0: WRT: Overriding region id 20
[    5.035325] iwlwifi 0000:01:00.0: WRT: Overriding region id 21
[    5.035329] iwlwifi 0000:01:00.0: WRT: Overriding region id 28
[    5.036252] Loading firmware: iwl-debug-yoyo.bin
[    5.038536] iwlwifi 0000:01:00.0: loaded firmware version 46.7e3e4b69.0 9260-th-b0-jf-b0-46.ucode op_mode iwlmvm
[    5.044167] Loading firmware: intel/ibt-18-16-1.sfi
[    5.046810] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
[    5.046855] Bluetooth: hci0: Boot Address: 0x40800
[    5.046859] Bluetooth: hci0: Firmware Version: 201-12.24
[    5.046862] Bluetooth: hci0: Firmware already loaded
[    5.052201] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported.
...
[    5.279801] iwlwifi 0000:01:00.0: Detected Intel(R) Wireless-AC 9260 160MHz, REV=0x321
[    5.333795] iwlwifi 0000:01:00.0: base HW address: 28:7f:cf:99:60:8d, OTP minor version: 0x4
[    5.427830] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
[   17.234466] iwlwifi 0000:01:00.0: Registered PHC clock: iwlwifi-PTP, with index: 0
...

Shortly after the laptop resumes from sleep and reconnects to my Android
phone, using Androids WiFi hotspot feature, the interface fails to transfer
packets.

Here are snippets from my dmesg when the firmware error occurs:

...
[  347.657148] wlp1s0: authenticate with 12:a3:95:0e:b9:2f
[  347.664823] wlp1s0: send auth to 12:a3:95:0e:b9:2f (try 1/3)
[  347.704345] wlp1s0: authenticated
[  347.707271] wlp1s0: associate with 12:a3:95:0e:b9:2f (try 1/3)
[  347.709076] wlp1s0: RX AssocResp from 12:a3:95:0e:b9:2f (capab=0x11 status=0 aid=1)
[  347.712401] wlp1s0: associated
[  347.799211] wlp1s0: Limiting TX power to 0 (-128 - 0) dBm as advertised by 12:a3:95:0e:b9:2f
[  359.698821] iwlwifi 0000:01:00.0: Microcode SW error detected.  Restarting 0x2000000.
[  359.698989] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  359.698995] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[  359.699002] iwlwifi 0000:01:00.0: Loaded firmware version: 46.7e3e4b69.0 9260-th-b0-jf-b0-46.ucode
[  359.699009] iwlwifi 0000:01:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL    
[  359.699016] iwlwifi 0000:01:00.0: 0x00802AF4 | trm_hw_status0
[  359.699021] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[  359.699027] iwlwifi 0000:01:00.0: 0x00481F0A | branchlink2
[  359.699032] iwlwifi 0000:01:00.0: 0x0047161E | interruptlink1
[  359.699036] iwlwifi 0000:01:00.0: 0x00006BBC | interruptlink2
[  359.699041] iwlwifi 0000:01:00.0: 0x0001B2BA | data1
[  359.699047] iwlwifi 0000:01:00.0: 0x00001000 | data2
[  359.699052] iwlwifi 0000:01:00.0: 0xF0000008 | data3
[  359.699056] iwlwifi 0000:01:00.0: 0x1D4139E0 | beacon time
[  359.699061] iwlwifi 0000:01:00.0: 0x01F13623 | tsf low
[  359.699065] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[  359.699070] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[  359.699075] iwlwifi 0000:01:00.0: 0x00E81542 | time gp2
[  359.699080] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[  359.699084] iwlwifi 0000:01:00.0: 0x0000002E | uCode version major
[  359.699089] iwlwifi 0000:01:00.0: 0x7E3E4B69 | uCode version minor
[  359.699094] iwlwifi 0000:01:00.0: 0x00000321 | hw version
[  359.699098] iwlwifi 0000:01:00.0: 0x00C89001 | board version
[  359.699103] iwlwifi 0000:01:00.0: 0x0C00001C | hcmd
[  359.699107] iwlwifi 0000:01:00.0: 0x80022007 | isr0
[  359.699112] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[  359.699116] iwlwifi 0000:01:00.0: 0x08101802 | isr2
[  359.699121] iwlwifi 0000:01:00.0: 0x4041FDC8 | isr3
[  359.699125] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[  359.699130] iwlwifi 0000:01:00.0: 0x0075011D | last cmd Id
[  359.699134] iwlwifi 0000:01:00.0: 0x0001B2BA | wait_event
[  359.699138] iwlwifi 0000:01:00.0: 0x00000080 | l2p_control
[  359.699143] iwlwifi 0000:01:00.0: 0x00002020 | l2p_duration
[  359.699147] iwlwifi 0000:01:00.0: 0x0000003F | l2p_mhvalid
[  359.699152] iwlwifi 0000:01:00.0: 0x000000CE | l2p_addr_match
[  359.699156] iwlwifi 0000:01:00.0: 0x0000000D | lmpm_pmg_sel
[  359.699161] iwlwifi 0000:01:00.0: 0x28020945 | timestamp
[  359.699165] iwlwifi 0000:01:00.0: 0x0000284C | flow_handler
[  359.699261] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  359.699265] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[  359.699271] iwlwifi 0000:01:00.0: 0x20100705 | ADVANCED_SYSASSERT
[  359.699276] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[  359.699281] iwlwifi 0000:01:00.0: 0xC0088A6A | umac branchlink2
[  359.699285] iwlwifi 0000:01:00.0: 0xC0084CF0 | umac interruptlink1
[  359.699290] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[  359.699294] iwlwifi 0000:01:00.0: 0x00004424 | umac data1
[  359.699299] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[  359.699303] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[  359.699307] iwlwifi 0000:01:00.0: 0x0000002E | umac major
[  359.699312] iwlwifi 0000:01:00.0: 0x7E3E4B69 | umac minor
[  359.699316] iwlwifi 0000:01:00.0: 0x00E81528 | frame pointer
[  359.699321] iwlwifi 0000:01:00.0: 0xC0886C60 | stack pointer
[  359.699325] iwlwifi 0000:01:00.0: 0x00760118 | last host cmd
[  359.699330] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[  359.699406] iwlwifi 0000:01:00.0: IML/ROM dump:
[  359.699410] iwlwifi 0000:01:00.0: 0x00002320 | IML/ROM error/state
[  359.699487] iwlwifi 0000:01:00.0: 0x00000003 | IML/ROM data1
[  359.699562] iwlwifi 0000:01:00.0: Fseq Registers:
[  359.699599] iwlwifi 0000:01:00.0: 0x08A424D2 | FSEQ_ERROR_CODE
[  359.699637] iwlwifi 0000:01:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  359.699674] iwlwifi 0000:01:00.0: 0x4E8E5F2A | FSEQ_CNVIO_INIT_VERSION
[  359.699713] iwlwifi 0000:01:00.0: 0x0000A371 | FSEQ_OTP_VERSION
[  359.699752] iwlwifi 0000:01:00.0: 0xD7157882 | FSEQ_TOP_CONTENT_VERSION
[  359.699789] iwlwifi 0000:01:00.0: 0xC1439130 | FSEQ_ALIVE_TOKEN
[  359.699826] iwlwifi 0000:01:00.0: 0xFF0F02BA | FSEQ_CNVI_ID
[  359.699863] iwlwifi 0000:01:00.0: 0x52D2F2BA | FSEQ_CNVR_ID
[  359.699901] iwlwifi 0000:01:00.0: 0x01000200 | CNVI_AUX_MISC_CHIP
[  359.699940] iwlwifi 0000:01:00.0: 0x01300202 | CNVR_AUX_MISC_CHIP
[  359.699980] iwlwifi 0000:01:00.0: 0x0000485B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  359.700086] iwlwifi 0000:01:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  359.700118] iwlwifi 0000:01:00.0: 0xCBE3DDDE | FSEQ_PREV_CNVIO_INIT_VERSION
[  359.700155] iwlwifi 0000:01:00.0: 0xC1A8F489 | FSEQ_WIFI_FSEQ_VERSION
[  359.700192] iwlwifi 0000:01:00.0: 0xFA7B7D04 | FSEQ_BT_FSEQ_VERSION
[  359.700231] iwlwifi 0000:01:00.0: 0x20420107 | FSEQ_CLASS_TP_VERSION
[  359.700277] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[  359.700285] ieee80211 phy0: Hardware restart was requested
[  367.176971] iwlwifi 0000:01:00.0: Microcode SW error detected.  Restarting 0x2000000.
[  367.177140] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  367.177146] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[  367.177153] iwlwifi 0000:01:00.0: Loaded firmware version: 46.7e3e4b69.0 9260-th-b0-jf-b0-46.ucode
[  367.177159] iwlwifi 0000:01:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL    
[  367.177166] iwlwifi 0000:01:00.0: 0x00802AF4 | trm_hw_status0
[  367.177172] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[  367.177177] iwlwifi 0000:01:00.0: 0x00481F0A | branchlink2
[  367.177182] iwlwifi 0000:01:00.0: 0x0047161E | interruptlink1
[  367.177187] iwlwifi 0000:01:00.0: 0x00006BBC | interruptlink2
[  367.177193] iwlwifi 0000:01:00.0: 0x0001B2BA | data1
[  367.177198] iwlwifi 0000:01:00.0: 0x00001000 | data2
[  367.177203] iwlwifi 0000:01:00.0: 0xF0000008 | data3
[  367.177208] iwlwifi 0000:01:00.0: 0x11012E32 | beacon time
[  367.177213] iwlwifi 0000:01:00.0: 0x026351D4 | tsf low
[  367.177219] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[  367.177224] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[  367.177229] iwlwifi 0000:01:00.0: 0x006955BB | time gp2
[  367.177234] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[  367.177239] iwlwifi 0000:01:00.0: 0x0000002E | uCode version major
[  367.177244] iwlwifi 0000:01:00.0: 0x7E3E4B69 | uCode version minor
[  367.177249] iwlwifi 0000:01:00.0: 0x00000321 | hw version
[  367.177255] iwlwifi 0000:01:00.0: 0x00C89001 | board version
[  367.177260] iwlwifi 0000:01:00.0: 0x0C02001C | hcmd
[  367.177265] iwlwifi 0000:01:00.0: 0x80022007 | isr0
[  367.177269] iwlwifi 0000:01:00.0: 0x01000000 | isr1
[  367.177274] iwlwifi 0000:01:00.0: 0x08101802 | isr2
[  367.177278] iwlwifi 0000:01:00.0: 0x4041FCC8 | isr3
[  367.177283] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[  367.177287] iwlwifi 0000:01:00.0: 0x00550400 | last cmd Id
[  367.177292] iwlwifi 0000:01:00.0: 0x0001B2BA | wait_event
[  367.177296] iwlwifi 0000:01:00.0: 0x00000080 | l2p_control
[  367.177301] iwlwifi 0000:01:00.0: 0x00002020 | l2p_duration
[  367.177305] iwlwifi 0000:01:00.0: 0x0000003F | l2p_mhvalid
[  367.177309] iwlwifi 0000:01:00.0: 0x000000CE | l2p_addr_match
[  367.177314] iwlwifi 0000:01:00.0: 0x0000000D | lmpm_pmg_sel
[  367.177318] iwlwifi 0000:01:00.0: 0x28020945 | timestamp
[  367.177323] iwlwifi 0000:01:00.0: 0x0000C0E4 | flow_handler
[  367.177424] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  367.177428] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[  367.177433] iwlwifi 0000:01:00.0: 0x20100705 | ADVANCED_SYSASSERT
[  367.177439] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[  367.177443] iwlwifi 0000:01:00.0: 0xC0088A6A | umac branchlink2
[  367.177448] iwlwifi 0000:01:00.0: 0xC0084CF0 | umac interruptlink1
[  367.177452] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[  367.177457] iwlwifi 0000:01:00.0: 0x00004424 | umac data1
[  367.177461] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[  367.177466] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[  367.177470] iwlwifi 0000:01:00.0: 0x0000002E | umac major
[  367.177475] iwlwifi 0000:01:00.0: 0x7E3E4B69 | umac minor
[  367.177479] iwlwifi 0000:01:00.0: 0x006955A3 | frame pointer
[  367.177483] iwlwifi 0000:01:00.0: 0xC0886C60 | stack pointer
[  367.177488] iwlwifi 0000:01:00.0: 0x00550400 | last host cmd
[  367.177492] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[  367.177569] iwlwifi 0000:01:00.0: IML/ROM dump:
[  367.177573] iwlwifi 0000:01:00.0: 0x00002320 | IML/ROM error/state
[  367.177647] iwlwifi 0000:01:00.0: 0x00000003 | IML/ROM data1
[  367.177725] iwlwifi 0000:01:00.0: Fseq Registers:
[  367.177763] iwlwifi 0000:01:00.0: 0x08A424D2 | FSEQ_ERROR_CODE
[  367.177801] iwlwifi 0000:01:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  367.177839] iwlwifi 0000:01:00.0: 0x4E8E5F2A | FSEQ_CNVIO_INIT_VERSION
[  367.177877] iwlwifi 0000:01:00.0: 0x0000A371 | FSEQ_OTP_VERSION
[  367.177915] iwlwifi 0000:01:00.0: 0xD7157882 | FSEQ_TOP_CONTENT_VERSION
[  367.177953] iwlwifi 0000:01:00.0: 0xC1439130 | FSEQ_ALIVE_TOKEN
[  367.177991] iwlwifi 0000:01:00.0: 0xFF0F02BA | FSEQ_CNVI_ID
[  367.178029] iwlwifi 0000:01:00.0: 0x52D2F2BA | FSEQ_CNVR_ID
[  367.178067] iwlwifi 0000:01:00.0: 0x01000200 | CNVI_AUX_MISC_CHIP
[  367.178108] iwlwifi 0000:01:00.0: 0x01300202 | CNVR_AUX_MISC_CHIP
[  367.178148] iwlwifi 0000:01:00.0: 0x0000485B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  367.178237] iwlwifi 0000:01:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  367.178274] iwlwifi 0000:01:00.0: 0xCBE3DDDE | FSEQ_PREV_CNVIO_INIT_VERSION
[  367.178312] iwlwifi 0000:01:00.0: 0xC1A8F489 | FSEQ_WIFI_FSEQ_VERSION
[  367.178351] iwlwifi 0000:01:00.0: 0xFA7B7D04 | FSEQ_BT_FSEQ_VERSION
[  367.178389] iwlwifi 0000:01:00.0: 0x20420107 | FSEQ_CLASS_TP_VERSION
[  367.178430] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[  367.178442] ieee80211 phy0: Hardware restart was requested
[  374.668955] iwlwifi 0000:01:00.0: Microcode SW error detected.  Restarting 0x2000000.
[  374.669166] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  374.669172] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[  374.669178] iwlwifi 0000:01:00.0: Loaded firmware version: 46.7e3e4b69.0 9260-th-b0-jf-b0-46.ucode
[  374.669185] iwlwifi 0000:01:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL    
[  374.669191] iwlwifi 0000:01:00.0: 0x00002AF0 | trm_hw_status0
[  374.669196] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[  374.669201] iwlwifi 0000:01:00.0: 0x00481F0A | branchlink2
[  374.669206] iwlwifi 0000:01:00.0: 0x0047161E | interruptlink1
[  374.669211] iwlwifi 0000:01:00.0: 0x00006BBC | interruptlink2
[  374.669215] iwlwifi 0000:01:00.0: 0x0001B2BA | data1
[  374.669220] iwlwifi 0000:01:00.0: 0x00001000 | data2
[  374.669224] iwlwifi 0000:01:00.0: 0xF0000008 | data3
[  374.669229] iwlwifi 0000:01:00.0: 0x1100ECAF | beacon time
[  374.669234] iwlwifi 0000:01:00.0: 0x02D5A355 | tsf low
[  374.669238] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[  374.669243] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[  374.669247] iwlwifi 0000:01:00.0: 0x006974E9 | time gp2
[  374.669251] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[  374.669256] iwlwifi 0000:01:00.0: 0x0000002E | uCode version major
[  374.669260] iwlwifi 0000:01:00.0: 0x7E3E4B69 | uCode version minor
[  374.669265] iwlwifi 0000:01:00.0: 0x00000321 | hw version
[  374.669270] iwlwifi 0000:01:00.0: 0x00C89001 | board version
[  374.669274] iwlwifi 0000:01:00.0: 0x0C03001C | hcmd
[  374.669279] iwlwifi 0000:01:00.0: 0x80022007 | isr0
[  374.669283] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[  374.669287] iwlwifi 0000:01:00.0: 0x08101802 | isr2
[  374.669292] iwlwifi 0000:01:00.0: 0x4041FCC8 | isr3
[  374.669296] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[  374.669301] iwlwifi 0000:01:00.0: 0x00540400 | last cmd Id
[  374.669305] iwlwifi 0000:01:00.0: 0x0001B2BA | wait_event
[  374.669310] iwlwifi 0000:01:00.0: 0x00000080 | l2p_control
[  374.669314] iwlwifi 0000:01:00.0: 0x00000020 | l2p_duration
[  374.669319] iwlwifi 0000:01:00.0: 0x0000003F | l2p_mhvalid
[  374.669323] iwlwifi 0000:01:00.0: 0x00000080 | l2p_addr_match
[  374.669327] iwlwifi 0000:01:00.0: 0x0000000D | lmpm_pmg_sel
[  374.669332] iwlwifi 0000:01:00.0: 0x28020945 | timestamp
[  374.669336] iwlwifi 0000:01:00.0: 0x0000C0E4 | flow_handler
[  374.669451] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  374.669455] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[  374.669461] iwlwifi 0000:01:00.0: 0x20100705 | ADVANCED_SYSASSERT
[  374.669466] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[  374.669470] iwlwifi 0000:01:00.0: 0xC0088A6A | umac branchlink2
[  374.669475] iwlwifi 0000:01:00.0: 0xC0084CF0 | umac interruptlink1
[  374.669479] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[  374.669484] iwlwifi 0000:01:00.0: 0x00004424 | umac data1
[  374.669488] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[  374.669493] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[  374.669497] iwlwifi 0000:01:00.0: 0x0000002E | umac major
[  374.669501] iwlwifi 0000:01:00.0: 0x7E3E4B69 | umac minor
[  374.669506] iwlwifi 0000:01:00.0: 0x006974D1 | frame pointer
[  374.669510] iwlwifi 0000:01:00.0: 0xC0886C60 | stack pointer
[  374.669515] iwlwifi 0000:01:00.0: 0x00540400 | last host cmd
[  374.669519] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[  374.669612] iwlwifi 0000:01:00.0: IML/ROM dump:
[  374.669616] iwlwifi 0000:01:00.0: 0x00002320 | IML/ROM error/state
[  374.669702] iwlwifi 0000:01:00.0: 0x00000003 | IML/ROM data1
[  374.669777] iwlwifi 0000:01:00.0: Fseq Registers:
[  374.669836] iwlwifi 0000:01:00.0: 0x08A424D2 | FSEQ_ERROR_CODE
[  374.669890] iwlwifi 0000:01:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  374.669927] iwlwifi 0000:01:00.0: 0x4E8E5F2A | FSEQ_CNVIO_INIT_VERSION
[  374.669963] iwlwifi 0000:01:00.0: 0x0000A371 | FSEQ_OTP_VERSION
[  374.670001] iwlwifi 0000:01:00.0: 0xD7157882 | FSEQ_TOP_CONTENT_VERSION
[  374.670039] iwlwifi 0000:01:00.0: 0xC1439130 | FSEQ_ALIVE_TOKEN
[  374.670077] iwlwifi 0000:01:00.0: 0xFF0F02BA | FSEQ_CNVI_ID
[  374.670114] iwlwifi 0000:01:00.0: 0x52D2F2BA | FSEQ_CNVR_ID
[  374.670151] iwlwifi 0000:01:00.0: 0x01000200 | CNVI_AUX_MISC_CHIP
[  374.670191] iwlwifi 0000:01:00.0: 0x01300202 | CNVR_AUX_MISC_CHIP
[  374.670231] iwlwifi 0000:01:00.0: 0x0000485B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  374.670322] iwlwifi 0000:01:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  374.670360] iwlwifi 0000:01:00.0: 0xCBE3DDDE | FSEQ_PREV_CNVIO_INIT_VERSION
[  374.670398] iwlwifi 0000:01:00.0: 0xC1A8F489 | FSEQ_WIFI_FSEQ_VERSION
[  374.670435] iwlwifi 0000:01:00.0: 0xFA7B7D04 | FSEQ_BT_FSEQ_VERSION
[  374.670472] iwlwifi 0000:01:00.0: 0x20420107 | FSEQ_CLASS_TP_VERSION
[  374.670518] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[  374.670531] ieee80211 phy0: Hardware restart was requested
...


Have any of you got any ideas about what to problem could be?

/Martin

