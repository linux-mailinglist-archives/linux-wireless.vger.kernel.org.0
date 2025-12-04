Return-Path: <linux-wireless+bounces-29482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB122CA21FC
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 02:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C3963002E9C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 01:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E201FE471;
	Thu,  4 Dec 2025 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHYg8Nlg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFF81F5825
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764812821; cv=none; b=LvxIs/eniCX4dpojwKzYNWl60hPqIbRnjHZoB1AaonSr8t2E0/KmczywVOCm5x/5EmH+cIob9yl++GZWvBn4KbkJzh0saAwJYWP4Xv+ePUW8HolkR6aIWvIQ0bKiiDo7yzreM7FWkbHmCtBnxmIFhVUzcuV4Ze/HbiEz0tF3QEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764812821; c=relaxed/simple;
	bh=BCWYrzxSCFM9LKw0wZKibWg8uirPaHbNOitMp9iN/6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RzNVYE6/Di+0P/w1Vpm8mfmbCLGfX7FsASbNYAIwThXwOgb15rjcj2hu8uLqA8KFNs66IzvBpfHW6RaM0/lSML/f+fl08dVRz2lUijqIIz9eaSpDge2s4yyp4gITZqWQGbCs8FyUE+JKbgUNlgifswEWtR7/+jXmMwjcOznDEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHYg8Nlg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e2e3c3a83so202000f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 17:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764812817; x=1765417617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMDMCGHzdLN0t6zIBC4tN7+EuuPsRxLJ3L/TTYV+/tY=;
        b=AHYg8NlgelBC1LboBDv2+QYSBoXdgYV2k7L9JdZJHKnWyPvkQqy5HM3Z00KWvbyGH3
         Nnj9Ti5+jOBUPUmAfzpKrqDFgDB1YpCNOl1Ir975OrGgKqehM8w0GTw2xsc8m0j9cZq4
         aBWsbzX2vw85+rFYLP6dO25NSceiii7CMpw75ubVpLgJWY6kOip/bjd2R77IEwKgsGYe
         wQXhUYkBv10bAL00lp9x1heXeHxPKA/RitJCq1y8p/8Gjk7lsx7IbuMcbEyUTc7aZeID
         NaMJR5rHb3hLBY8aCzwohu6kLkG5J2GHjVIo74jNoYROrxazr69UMIyp6V1I52AF/lsi
         SDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764812817; x=1765417617;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMDMCGHzdLN0t6zIBC4tN7+EuuPsRxLJ3L/TTYV+/tY=;
        b=Xvcp+G4/Kl54CYjvm3pc2E8HAMxqtCuYaYr02YxOACWCEh66/XvBBpfC63GdiL1e/x
         XS7Jfl1PkEvNYzeCyNGHdF0Xz5bf7ru5BZXBYB9e+DyQvPxd6+GUaZEvhuIKJNIVyXYn
         V5KvHpEfQjCtdIqkggj3sIqWZ406gijYmWXjritV1un0fSjzD5+Kn9oVb/BmRKVlhBGi
         +qtTLYdlmey8oXtTbLlxZl+zO8bIptHD1ZH8woAGmG2pveNyda8sqYi+wd3BMIOV2AJb
         x8BXEQV66SIo/+dr5RSiMfTTLyVV3Ck5c4eF8wGI+rh48W3lrP+quDQvFpOOMpjDfOMV
         nuYQ==
X-Gm-Message-State: AOJu0YxfWsVkOsB+kWAM5+Ss6/kD8V8EjCxSO1CUQakW2VEuLbGR3aXS
	LC/hjMOL8J0gNRShcX07o7r+PhyrllcuUWXPV3Eg0uZIBOjO5013iFn8VFa3kKWA7oY=
X-Gm-Gg: ASbGncuwTsen+SUD5XX/clBf2lCxGeUQh0SOBo3ggHCRbwex6eAjv9bbddAPpgJp7qF
	8D+mQcJnnehVxh96+Znmy1uHfSymI41kJkL2hfuOA1FkMDs3O4GW5m5jVhTGBGRa0gMgzVrChsV
	vvZu/HNcsTEB/OR0gsOpE8DSp9z5rte4ytBcwMWzqK00PLhhU5D2VyyEe1xlHgiAWvl1ZJ6+uAT
	vTtFhYnaxqhDohKzVQMyQzLo37BsNwMIt2OBWKCuUnUAJXsW+T8qxIlOIUbXdz3m0uWzwiUo/u5
	78O/DvWH+sG09fKGMmghHQg2a8q8Vc8ECVnVjm0w2qtHzWz59Z09Y9kD7VcJvaH/Ygylq1yjVB4
	A5quJtFuawEFjBJWF+r6nllWKORYJ4kbDElkQxEzfQ9tUBw7kuqpkxGucz+U1Ja2ygsWZTX9RHR
	qaBEg5/MA53HUIu9NJV0qaeQ==
X-Google-Smtp-Source: AGHT+IE3c8FZTu+OYAcIw3wMuq7of/OtNy1vYc8seD7VimNSamEQJ8PVvfxNpEq0M9iiqy3sFe5BFg==
X-Received: by 2002:a5d:5d89:0:b0:425:769e:515a with SMTP id ffacd0b85a97d-42f731bcfd8mr4129107f8f.42.1764812817015;
        Wed, 03 Dec 2025 17:46:57 -0800 (PST)
Received: from debian.local ([90.248.249.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222506sm249461f8f.28.2025.12.03.17.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 17:46:56 -0800 (PST)
Date: Thu, 4 Dec 2025 01:46:54 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>
Subject: [BUG] iwlwifi intermittent crash on resume iwl_mvm_get_wd_timeout
Message-ID: <aTDoDiD55qlUZ0pn@debian.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Using kernel 6.18.0, after about 300 suspend/resume cycles, this happened:

[ 5229.166540] PM: suspend entry (s2idle)
[ 5229.418821] Filesystems sync: 0.258 seconds
[ 5229.602836] Freezing user space processes
[ 5229.604544] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[ 5229.604548] OOM killer disabled.
[ 5229.604550] Freezing remaining freezable tasks
[ 5229.605274] Freezing remaining freezable tasks completed (elapsed 0.000 =
seconds)
[ 5229.605278] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[ 5229.606308] wlp1s0: deauthenticating from d6:92:5e:eb:ee:15 by local cho=
ice (Reason: 3=3DDEAUTH_LEAVING)
[ 5229.644498] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 5229.724989] ACPI: EC: interrupt blocked
[ 5238.656667] ACPI: EC: interrupt unblocked
[ 5238.686880] [drm] PCIE GART of 1024M enabled.
[ 5238.686884] [drm] PTB located at 0x000000F41FC00000
[ 5238.686908] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ 5238.690057] amdgpu 0000:03:00.0: amdgpu: dpm has been disabled
[ 5238.695904] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ 5238.805553] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[ 5238.805557] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 1 on hub 0
[ 5238.805559] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 4 on hub 0
[ 5238.805560] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 5 on hub 0
[ 5238.805561] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 6 on hub 0
[ 5238.805562] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 7 on hub 0
[ 5238.805563] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 8 on hub 0
[ 5238.805564] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 9 on hub 0
[ 5238.805565] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 10 on hub 0
[ 5238.805566] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 11 on hub 0
[ 5238.805567] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 8
[ 5238.805568] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 8
[ 5238.805569] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 8
[ 5238.805570] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 8
[ 5238.805571] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 8
[ 5238.840655] nvme nvme0: 8/0/0 default/read/poll queues
[ 5238.973586] usb 3-3: reset full-speed USB device number 3 using xhci_hcd
[ 5240.527898] iwlwifi 0000:01:00.0: Error sending SCAN_CFG_CMD: time out a=
fter 2000ms.
[ 5240.527911] iwlwifi 0000:01:00.0: Current CMD queue read_ptr 36775 write=
_ptr 36776
[ 5240.528542] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 5240.528544] iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
[ 5240.528546] iwlwifi 0000:01:00.0: Loaded firmware version: 89.202a2f7b.0=
 ty-a0-gf-a0-89.ucode
[ 5240.528549] iwlwifi 0000:01:00.0: 0x01000071 | ADVANCED_SYSASSERT       =
  =20
[ 5240.528551] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[ 5240.528552] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[ 5240.528554] iwlwifi 0000:01:00.0: 0x004DAD6C | branchlink2
[ 5240.528555] iwlwifi 0000:01:00.0: 0x004D09AE | interruptlink1
[ 5240.528556] iwlwifi 0000:01:00.0: 0x004D09AE | interruptlink2
[ 5240.528557] iwlwifi 0000:01:00.0: 0x00016AD2 | data1
[ 5240.528558] iwlwifi 0000:01:00.0: 0x00000010 | data2
[ 5240.528559] iwlwifi 0000:01:00.0: 0x00000000 | data3
[ 5240.528560] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[ 5240.528561] iwlwifi 0000:01:00.0: 0x361F4791 | tsf low
[ 5240.528563] iwlwifi 0000:01:00.0: 0x00000001 | tsf hi
[ 5240.528564] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[ 5240.528565] iwlwifi 0000:01:00.0: 0x3620F6C2 | time gp2
[ 5240.528566] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[ 5240.528567] iwlwifi 0000:01:00.0: 0x00000059 | uCode version major
[ 5240.528568] iwlwifi 0000:01:00.0: 0x202A2F7B | uCode version minor
[ 5240.528569] iwlwifi 0000:01:00.0: 0x00000000 | hw version
[ 5240.528570] iwlwifi 0000:01:00.0: 0x00000000 | board version
[ 5240.528571] iwlwifi 0000:01:00.0: 0x801FF800 | hcmd
[ 5240.528572] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[ 5240.528574] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[ 5240.528575] iwlwifi 0000:01:00.0: 0x48F04002 | isr2
[ 5240.528576] iwlwifi 0000:01:00.0: 0x00C3000C | isr3
[ 5240.528577] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[ 5240.528578] iwlwifi 0000:01:00.0: 0x00840103 | last cmd Id
[ 5240.528579] iwlwifi 0000:01:00.0: 0x00016AD2 | wait_event
[ 5240.528580] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[ 5240.528581] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[ 5240.528582] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[ 5240.528583] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[ 5240.528584] iwlwifi 0000:01:00.0: 0x00000018 | lmpm_pmg_sel
[ 5240.528585] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[ 5240.528587] iwlwifi 0000:01:00.0: 0x00003058 | flow_handler
[ 5240.528924] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 5240.528925] iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
[ 5240.528927] iwlwifi 0000:01:00.0: 0x211010B8 | ADVANCED_SYSASSERT
[ 5240.528929] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[ 5240.528930] iwlwifi 0000:01:00.0: 0x804838B2 | umac branchlink2
[ 5240.528931] iwlwifi 0000:01:00.0: 0xC00814E0 | umac interruptlink1
[ 5240.528932] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[ 5240.528933] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[ 5240.528934] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[ 5240.528936] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[ 5240.528937] iwlwifi 0000:01:00.0: 0x00000059 | umac major
[ 5240.528938] iwlwifi 0000:01:00.0: 0x202A2F7B | umac minor
[ 5240.528939] iwlwifi 0000:01:00.0: 0x3620F6BD | frame pointer
[ 5240.528940] iwlwifi 0000:01:00.0: 0xC0886C04 | stack pointer
[ 5240.528941] iwlwifi 0000:01:00.0: 0x00A601D3 | last host cmd
[ 5240.528942] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[ 5240.529236] iwlwifi 0000:01:00.0: IML/ROM dump:
[ 5240.529237] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[ 5240.529364] iwlwifi 0000:01:00.0: 0x00008DF6 | IML/ROM data1
[ 5240.529433] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[ 5240.529498] iwlwifi 0000:01:00.0: Fseq Registers:
[ 5240.529554] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
[ 5240.529610] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_TOP_INIT_VERSION
[ 5240.529667] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[ 5240.529724] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[ 5240.529780] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[ 5240.529838] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 5240.529841] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[ 5240.529897] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[ 5240.529953] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[ 5240.530013] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[ 5240.530071] iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[ 5240.530077] iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[ 5240.530138] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[ 5240.530196] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[ 5240.530199] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
[ 5240.530255] iwlwifi 0000:01:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[ 5240.530377] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0xc0080040
[ 5240.530439] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[ 5240.530533] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[ 5241.115517] iwlwifi 0000:01:00.0: Device error - SW reset
[ 5241.115841] iwlwifi 0000:01:00.0: iwl_mvm_check_rt_status failed, device=
 is gone during suspend
[ 5241.116025] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 5241.116025] iwlwifi 0000:01:00.0: Transport status: 0x00000442, valid: 6
[ 5241.116026] iwlwifi 0000:01:00.0: Loaded firmware version: 89.202a2f7b.0=
 ty-a0-gf-a0-89.ucode
[ 5241.116027] iwlwifi 0000:01:00.0: 0x01000071 | ADVANCED_SYSASSERT       =
  =20
[ 5241.116028] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[ 5241.116029] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[ 5241.116030] iwlwifi 0000:01:00.0: 0x004DAD6C | branchlink2
[ 5241.116030] iwlwifi 0000:01:00.0: 0x004D09AE | interruptlink1
[ 5241.116031] iwlwifi 0000:01:00.0: 0x004D09AE | interruptlink2
[ 5241.116031] iwlwifi 0000:01:00.0: 0x00016AD2 | data1
[ 5241.116032] iwlwifi 0000:01:00.0: 0x00000010 | data2
[ 5241.116033] iwlwifi 0000:01:00.0: 0x00000000 | data3
[ 5241.116033] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[ 5241.116034] iwlwifi 0000:01:00.0: 0x361F4791 | tsf low
[ 5241.116034] iwlwifi 0000:01:00.0: 0x00000001 | tsf hi
[ 5241.116035] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[ 5241.116035] iwlwifi 0000:01:00.0: 0x3620F6C2 | time gp2
[ 5241.116036] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[ 5241.116037] iwlwifi 0000:01:00.0: 0x00000059 | uCode version major
[ 5241.116037] iwlwifi 0000:01:00.0: 0x202A2F7B | uCode version minor
[ 5241.116038] iwlwifi 0000:01:00.0: 0x00000000 | hw version
[ 5241.116038] iwlwifi 0000:01:00.0: 0x00000000 | board version
[ 5241.116039] iwlwifi 0000:01:00.0: 0x801FF800 | hcmd
[ 5241.116040] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[ 5241.116040] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[ 5241.116041] iwlwifi 0000:01:00.0: 0x48F04002 | isr2
[ 5241.116041] iwlwifi 0000:01:00.0: 0x00C3000C | isr3
[ 5241.116042] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[ 5241.116042] iwlwifi 0000:01:00.0: 0x00840103 | last cmd Id
[ 5241.116043] iwlwifi 0000:01:00.0: 0x00016AD2 | wait_event
[ 5241.116043] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[ 5241.116044] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[ 5241.116045] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[ 5241.116045] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[ 5241.116046] iwlwifi 0000:01:00.0: 0x00000018 | lmpm_pmg_sel
[ 5241.116046] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[ 5241.116047] iwlwifi 0000:01:00.0: 0x00003058 | flow_handler
[ 5241.116376] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 5241.116377] iwlwifi 0000:01:00.0: Transport status: 0x00000442, valid: 7
[ 5241.116377] iwlwifi 0000:01:00.0: 0x211010B8 | ADVANCED_SYSASSERT
[ 5241.116378] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[ 5241.116379] iwlwifi 0000:01:00.0: 0x804838B2 | umac branchlink2
[ 5241.116379] iwlwifi 0000:01:00.0: 0xC00814E0 | umac interruptlink1
[ 5241.116380] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[ 5241.116381] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[ 5241.116381] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[ 5241.116382] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[ 5241.116382] iwlwifi 0000:01:00.0: 0x00000059 | umac major
[ 5241.116383] iwlwifi 0000:01:00.0: 0x202A2F7B | umac minor
[ 5241.116383] iwlwifi 0000:01:00.0: 0x3620F6BD | frame pointer
[ 5241.116384] iwlwifi 0000:01:00.0: 0xC0886C04 | stack pointer
[ 5241.116384] iwlwifi 0000:01:00.0: 0x00A601D3 | last host cmd
[ 5241.116385] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[ 5241.116683] iwlwifi 0000:01:00.0: IML/ROM dump:
[ 5241.116683] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[ 5241.116751] iwlwifi 0000:01:00.0: 0x00008DF6 | IML/ROM data1
[ 5241.116818] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[ 5241.116882] iwlwifi 0000:01:00.0: Fseq Registers:
[ 5241.116884] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
[ 5241.116887] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_TOP_INIT_VERSION
[ 5241.116890] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[ 5241.116893] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[ 5241.116895] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[ 5241.116898] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 5241.116901] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[ 5241.116903] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[ 5241.116906] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[ 5241.116911] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[ 5241.116916] iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[ 5241.116920] iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[ 5241.116923] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[ 5241.116926] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[ 5241.116929] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
[ 5241.116931] iwlwifi 0000:01:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[ 5241.116999] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0xc0080040
[ 5241.117002] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[ 5241.117004] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[ 5241.906581] iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[ 5241.906658] iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[ 5241.906780] iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
[ 5241.906797] iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[ 5242.024242] OOM killer enabled.
[ 5242.024245] Restarting tasks: Starting
[ 5242.025332] Restarting tasks: Done
[ 5242.025967] efivarfs: resyncing variable state
[ 5242.027760] Bluetooth: hci0: Firmware timestamp 2024.18 buildtype 1 buil=
d 81528
[ 5242.027768] Bluetooth: hci0: Firmware SHA1: 0xa8bb3f39
[ 5242.027775] Bluetooth: hci0: No support for _PRR ACPI method
[ 5242.030729] efivarfs: finished resyncing variable state
[ 5242.030761] random: crng reseeded on system resumption
[ 5242.031257] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.=
sfi
[ 5242.031272] Bluetooth: hci0: Boot Address: 0x100800
[ 5242.031275] Bluetooth: hci0: Firmware Version: 120-18.24
[ 5242.031277] Bluetooth: hci0: Firmware already loaded
[ 5242.040739] Bluetooth: hci0: Fseq status: Success (0x00)
[ 5242.040745] Bluetooth: hci0: Fseq executed: 00.00.02.42
[ 5242.040748] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[ 5242.041700] PM: suspend exit
[ 5242.202466] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[ 5242.202473] #PF: supervisor read access in kernel mode
[ 5242.202476] #PF: error_code(0x0000) - not-present page
[ 5242.202478] PGD 0 P4D 0=20
[ 5242.202482] Oops: Oops: 0000 [#1] SMP
[ 5242.202491] CPU: 14 UID: 0 PID: 881 Comm: wpa_supplicant Tainted: G     =
   W           6.18.0 #191 PREEMPT(voluntary)=20
[ 5242.202497] Tainted: [W]=3DWARN
[ 5242.202499] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.14 10/25/2023
[ 5242.202502] RIP: 0010:iwl_mvm_get_wd_timeout+0x26/0x30 [iwlmvm]
[ 5242.202529] Code: 00 0f 1f 00 0f 1f 44 00 00 48 8b 47 08 48 8b 57 10 48 =
8b 40 10 48 8b 92 30 01 00 00 48 8b 00 48 0f ba e2 26 8b 00 73 08 31 d2 <83=
> 3e 03 0f 44 c2 c3 0f 1f 00 0f 1f 44 00 00 41 55 41 54 49 89 d4
[ 5242.202532] RSP: 0018:ffffad3b05313378 EFLAGS: 00010246
[ 5242.202535] RAX: 0000000000002710 RBX: ffff970a606d4eb0 RCX: 00000000000=
00000
[ 5242.202537] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff97088b0=
2b0e8
[ 5242.202538] RBP: ffff9708b43ea948 R08: 0000000000000000 R09: 00000000000=
00000
[ 5242.202540] R10: ffffad3b05313428 R11: 0000000000000000 R12: ffff97088b0=
2b0e8
[ 5242.202541] R13: ffff970a606d4eb0 R14: ffff9708b43ea9a0 R15: ffff97088b0=
2b0e8
[ 5242.202543] FS:  00007f6742ae6840(0000) GS:ffff970bf1918000(0000) knlGS:=
0000000000000000
[ 5242.202545] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5242.202547] CR2: 0000000000000000 CR3: 0000000102e89000 CR4: 00000000007=
50ef0
[ 5242.202549] PKRU: 55555554
[ 5242.202551] Call Trace:
[ 5242.202554]  <TASK>
[ 5242.202556]  iwl_mvm_realloc_queues_after_restart+0x32/0x180 [iwlmvm]
[ 5242.202575]  iwl_mvm_mld_add_sta+0x357/0x780 [iwlmvm]
[ 5242.202588]  iwl_mvm_mac_sta_state_common+0x18b/0xc60 [iwlmvm]
[ 5242.202603]  drv_sta_state+0x11d/0x880 [mac80211]
[ 5242.202635]  sta_info_insert_rcu+0x7fd/0xf30 [mac80211]
[ 5242.202667]  sta_info_insert+0xb/0x70 [mac80211]
[ 5242.202695]  ieee80211_prep_connection+0x6a1/0x890 [mac80211]
[ 5242.202745]  ieee80211_mgd_auth+0x2ce/0x580 [mac80211]
[ 5242.202779]  ? rcu_is_watching+0xd/0x40
[ 5242.202786]  cfg80211_mlme_auth+0xd9/0x270 [cfg80211]
[ 5242.202828]  nl80211_authenticate+0x386/0x3f0 [cfg80211]
[ 5242.202863]  genl_family_rcv_msg_doit+0xfb/0x150
[ 5242.202881]  genl_rcv_msg+0x1b5/0x2c0
[ 5242.202885]  ? __cfg80211_wdev_from_attrs+0x310/0x310 [cfg80211]
[ 5242.202913]  ? nl80211_parse_key+0x310/0x310 [cfg80211]
[ 5242.202940]  ? nlmsg_trim+0x20/0x20 [cfg80211]
[ 5242.202969]  ? genl_family_rcv_msg_dumpit+0x100/0x100
[ 5242.202972]  netlink_rcv_skb+0x4b/0xf0
[ 5242.202977]  genl_rcv+0x24/0x40
[ 5242.202980]  netlink_unicast+0x1f5/0x2d0
[ 5242.202983]  ? __virt_addr_valid+0x112/0x2d0
[ 5242.202987]  netlink_sendmsg+0x216/0x450
[ 5242.202991]  __sock_sendmsg+0x38/0x70
[ 5242.202994]  ____sys_sendmsg+0x23f/0x2b0
[ 5242.202997]  ? import_iovec+0x2b/0x30
[ 5242.203001]  ___sys_sendmsg+0x99/0xe0
[ 5242.203010]  __sys_sendmsg+0x84/0xe0
[ 5242.203013]  ? _copy_from_user+0x22/0x80
[ 5242.203018]  do_syscall_64+0x95/0x6e0
[ 5242.203022]  ? __sys_setsockopt+0x90/0xd0
[ 5242.203026]  ? rcu_is_watching+0xd/0x40
[ 5242.203029]  ? do_syscall_64+0x1ad/0x6e0
[ 5242.203032]  ? rcu_is_watching+0xd/0x40
[ 5242.203034]  ? do_syscall_64+0x1ad/0x6e0
[ 5242.203037]  ? rcu_is_watching+0xd/0x40
[ 5242.203040]  ? do_syscall_64+0x1ad/0x6e0
[ 5242.203043]  ? rcu_is_watching+0xd/0x40
[ 5242.203045]  ? do_syscall_64+0x1ad/0x6e0
[ 5242.203048]  ? rcu_is_watching+0xd/0x40
[ 5242.203050]  ? do_syscall_64+0x1ad/0x6e0
[ 5242.203055]  ? rcu_is_watching+0xd/0x40
[ 5242.203057]  ? do_syscall_64+0x1ad/0x6e0
[ 5242.203059]  ? rcu_is_watching+0xd/0x40
[ 5242.203061]  ? do_syscall_64+0x1ad/0x6e0
[ 5242.203064]  ? rcu_is_watching+0xd/0x40
[ 5242.203067]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 5242.203070] RIP: 0033:0x7f6742d1cab0
[ 5242.203073] Code: 00 f7 d8 64 89 02 b8 ff ff ff ff eb bb 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 00 80 3d b9 c5 0d 00 00 74 17 b8 2e 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
[ 5242.203075] RSP: 002b:00007ffe42a34ee8 EFLAGS: 00000202 ORIG_RAX: 000000=
000000002e
[ 5242.203078] RAX: ffffffffffffffda RBX: 000055723bcdba00 RCX: 00007f6742d=
1cab0
[ 5242.203080] RDX: 0000000000000000 RSI: 00007ffe42a34f20 RDI: 00000000000=
00006
[ 5242.203081] RBP: 000055723bda1ff0 R08: 0000000000000004 R09: 00000000000=
0000d
[ 5242.203083] R10: 00007ffe42a35004 R11: 0000000000000202 R12: 000055723bc=
dbce0
[ 5242.203084] R13: 00007ffe42a34f20 R14: 0000000000000000 R15: 00007ffe42a=
35004
[ 5242.203089]  </TASK>
[ 5242.203091] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE =
nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm=
_user xfrm_algo xt_addrtype nft_compat x_tables nf_tables br_netfilter brid=
ge stp llc snd_seq_dummy snd_hrtimer snd_seq snd_seq_device ccm overlay qrt=
r rfcomm cmac algif_hash algif_skcipher af_alg bnep binfmt_misc nls_ascii n=
ls_cp437 vfat fat iwlmvm mac80211 uvcvideo videobuf2_vmalloc videobuf2_memo=
ps libarc4 uvc videobuf2_v4l2 videodev snd_hda_codec_generic videobuf2_comm=
on snd_hda_codec_hdmi iwlwifi snd_acp3x_pdm_dma mc snd_soc_dmic snd_acp3x_r=
n snd_soc_core amd_atl intel_rapl_msr snd_hda_intel intel_rapl_common sg sn=
d_hda_codec btusb kvm_amd cfg80211 btrtl btintel snd_intel_dspcfg snd_compr=
ess snd_hwdep snd_hda_core btbcm kvm snd_pci_acp6x btmtk snd_pcm bluetooth =
ucsi_acpi snd_timer typec_ucsi snd_pci_acp5x snd roles snd_rn_pci_acp3x ecd=
h_generic typec ccp snd_acp_config ee1004 ecc rfkill soundcore evdev snd_so=
c_acpi joydev snd_pci_acp3x sp5100_tco k10temp irqbypass
[ 5242.203158]  watchdog rapl serio_raw thunderbolt pcspkr ac battery wmi_b=
mof amd_pmc acpi_tad dm_mod msr parport_pc ppdev lp nvme_fabrics fuse parpo=
rt efi_pstore configfs nfnetlink efivarfs autofs4 crc32c_cryptoapi sd_mod u=
as usb_storage scsi_mod scsi_common btrfs blake2b_generic xor raid6_pq amdg=
pu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc_hel=
per drm_buddy drm_panel_backlight_quirks xhci_pci gpu_sched hid_multitouch =
amdxcp xhci_hcd hid_generic drm_display_helper drm_kms_helper i2c_hid_acpi =
nvme cec i2c_hid ghash_clmulni_intel amd_sfh usbcore i2c_piix4 rc_core vide=
o hid nvme_core crc16 usb_common i2c_smbus fan button drm wmi aesni_intel
[ 5242.203211] CR2: 0000000000000000
[ 5242.203214] ---[ end trace 0000000000000000 ]---
[ 5242.210158] Bluetooth: MGMT ver 1.23
[ 5242.518003] RIP: 0010:iwl_mvm_get_wd_timeout+0x26/0x30 [iwlmvm]
[ 5242.518035] Code: 00 0f 1f 00 0f 1f 44 00 00 48 8b 47 08 48 8b 57 10 48 =
8b 40 10 48 8b 92 30 01 00 00 48 8b 00 48 0f ba e2 26 8b 00 73 08 31 d2 <83=
> 3e 03 0f 44 c2 c3 0f 1f 00 0f 1f 44 00 00 41 55 41 54 49 89 d4
[ 5242.518039] RSP: 0018:ffffad3b05313378 EFLAGS: 00010246
[ 5242.518044] RAX: 0000000000002710 RBX: ffff970a606d4eb0 RCX: 00000000000=
00000
[ 5242.518046] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff97088b0=
2b0e8
[ 5242.518047] RBP: ffff9708b43ea948 R08: 0000000000000000 R09: 00000000000=
00000
[ 5242.518049] R10: ffffad3b05313428 R11: 0000000000000000 R12: ffff97088b0=
2b0e8
[ 5242.518051] R13: ffff970a606d4eb0 R14: ffff9708b43ea9a0 R15: ffff97088b0=
2b0e8
[ 5242.518053] FS:  00007f6742ae6840(0000) GS:ffff970bf1918000(0000) knlGS:=
0000000000000000
[ 5242.518055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5242.518056] CR2: 0000000000000000 CR3: 0000000102e89000 CR4: 00000000007=
50ef0
[ 5242.518057] PKRU: 55555554
[ 5242.518059] note: wpa_supplicant[881] exited with irqs disabled

