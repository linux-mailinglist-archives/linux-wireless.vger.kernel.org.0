Return-Path: <linux-wireless+bounces-27192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E17B503BA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766AE3A7D3E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E66369998;
	Tue,  9 Sep 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TRT45Tn0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B517F369996;
	Tue,  9 Sep 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437129; cv=none; b=H74yTxmorqGysMYHpMDI++pfi8RjDKckKYvUOstdXMvDSmuHeApc+EKQ9k7yXKz7g6wb6Gs+McWq6hdEed0lc00ljGJRZrEfcM/K75FeNOR3A59nNY/5MoFJIt7XTjk0ulB74Xq0+zWCPYJK3gW2q+gRkzC41R0l82n+nGOYuCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437129; c=relaxed/simple;
	bh=DLhfa5+9DoY5lsuN1ol0kWdQECfwecIf4HXanNvtWTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1Q+d34CGssyeBRwQCxaK4QWZNzOmdnqgg4jdI2HSJqXGuLvXxk97K8iTD0XQJv8Sp5djP33gDdDh9sFu0frhXN37EzL/JTntAukQ56MjW6EPaFOwWWlpGwEPObig5904FtgU3mFkLaDr2CPBOhPviVxJwThGg+XcvmusYH7Jdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TRT45Tn0; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jw
	2aIxXWsYXdPwv2V/QwP9BHN0l08lU+tS+x+VF/I1A=; b=TRT45Tn0is6KMdBsQi
	qTugs6RbB1dLnu7UkGbS36MYGZiRH2rMVXa0+DywyDJtdEvi2GjPnbsnHj53FiNr
	QbKYvSq+TkrLrFvWox+uHBtcppQ2MnzyBcBVw1YBvj8n3kiUoXEu5FJH0tVvMjE5
	6OcFFnjNcdgw5EQP41/pl39l8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCXGeykXMBogDHnCA--.25189S4;
	Wed, 10 Sep 2025 00:58:29 +0800 (CST)
From: David Wang <00107082@163.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: IWL Error Log Dump since 6.17.0-rc5
Date: Wed, 10 Sep 2025 00:58:11 +0800
Message-ID: <20250909165811.10729-1-00107082@163.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCXGeykXMBogDHnCA--.25189S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfur1kAr4rXry5Cr4UZr15XFb_yoW5urWxCo
	Z5JF97JrWfK34kAw18uws5CrWYqw1ftasagF1xA34YyrnxAw48C34Utw4fXw4DX3WkJ3s8
	Ja9Fkrn7W3yUJwn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RijjyDUUUU
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEgvDqmjAWc1W9wAAst

Hi,

I have an *old* wireless pcie card installed, sometimes my device would start reconnect to my router,
and I would see short batch of event logs about it, but after upgrading to 6.17.0-rc5, 
kernel logs starts flooding with IWL Error Log Dumps:

	[  904.086184] iwlwifi 0000:21:00.0: Microcode SW error detected.  Restarting 0x2000000.
	[  904.086356] iwlwifi 0000:21:00.0: Start IWL Error Log Dump:
	[  904.086360] iwlwifi 0000:21:00.0: Transport status: 0x0000004A, valid: 6
	[  904.086364] iwlwifi 0000:21:00.0: Loaded firmware version: 17.bfb58538.0 7260-17.ucode
	[  904.086367] iwlwifi 0000:21:00.0: 0x00001030 | ADVANCED_SYSASSERT          
	[  904.086371] iwlwifi 0000:21:00.0: 0x00800221 | trm_hw_status0
	[  904.086375] iwlwifi 0000:21:00.0: 0x00000000 | trm_hw_status1
	[  904.086378] iwlwifi 0000:21:00.0: 0x00000B30 | branchlink2
	[  904.086380] iwlwifi 0000:21:00.0: 0x000164C0 | interruptlink1
(A longer log is pasted at the end.)

At the begining, I also got a kernel warning (which seems gone now, not 100% sure though, after I upgrade my iwlwifi firmwares to 20250808):

	43.618734+08:00 mypower kernel: WARNING: CPU: 5 PID: 83 at drivers/net/wireless/intel/iwlwifi/iwl-trans.c:732 iwl_trans_wait_tx_queues_empty+0x3c/0x40 [iwlwifi]
	...
	43.618737+08:00 mypower kernel: CPU: 5 UID: 0 PID: 83 Comm: kworker/5:1 Tainted: P           OE       6.17.0-rc5-linan-0 #727 PREEMPT(voluntary) 
	43.618737+08:00 mypower kernel: Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
	43.618738+08:00 mypower kernel: Hardware name: Micro-Star International Co., Ltd. MS-7B89/B450M MORTAR MAX (MS-7B89), BIOS 2.L0 07/18/2024
	43.618738+08:00 mypower kernel: Workqueue: events iwl_trans_reprobe_wk [iwlwifi]
	43.618739+08:00 mypower kernel: RIP: 0010:iwl_trans_wait_tx_queues_empty+0x3c/0x40 [iwlwifi]
	43.618739+08:00 mypower kernel: Code: fa 6c ff ff 80 3d 66 16 44 00 00 74 0a b8 fb ff ff ff e9 97 24 ac cb 48 c7 c7 d3 06 9f c1 c6 05 4c 16 44 00 01 e8 d4 cd f6 ca <0f> 0b eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
	43.618740+08:00 mypower kernel: RSP: 0018:ffffb089c03b7668 EFLAGS: 00010286
	43.618741+08:00 mypower kernel: RAX: 0000000000000000 RBX: ffff8c271fff0ad0 RCX: 0000000000000002
	43.618741+08:00 mypower kernel: RDX: ffff8c29ef09b208 RSI: 0000000000000001 RDI: 00000000ffffffff
	43.618742+08:00 mypower kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000ffffefff
	43.618743+08:00 mypower kernel: R10: 0000000000000005 R11: ffffb089c03b7508 R12: ffff8c271fff0ad0
	43.618743+08:00 mypower kernel: R13: 0000000000000400 R14: ffff8c26d215a008 R15: 000000000000000a
	43.618744+08:00 mypower kernel: FS:  0000000000000000(0000) GS:ffff8c2a60f64000(0000) knlGS:0000000000000000
	43.618744+08:00 mypower kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	43.618745+08:00 mypower kernel: CR2: 00007f7da301980c CR3: 00000001062ac000 CR4: 0000000000350ef0
	43.618745+08:00 mypower kernel: Call Trace:
	43.618746+08:00 mypower kernel:  <TASK>
	43.618746+08:00 mypower kernel:  iwl_mvm_sta_tx_agg_flush+0x127/0x1a0 [iwlmvm]
	43.618747+08:00 mypower kernel:  iwl_mvm_mac_ampdu_action+0x195/0x3e0 [iwlmvm]
	43.618747+08:00 mypower kernel:  drv_ampdu_action+0xd8/0x190 [mac80211]
	43.618748+08:00 mypower kernel:  __ieee80211_stop_tx_ba_session+0x165/0x240 [mac80211]
	43.618749+08:00 mypower kernel:  ieee80211_sta_tear_down_BA_sessions+0x4e/0xb0 [mac80211]
	43.618749+08:00 mypower kernel:  __sta_info_destroy_part1+0x3d/0x4e0 [mac80211]
	43.618750+08:00 mypower kernel:  ? srso_return_thunk+0x5/0x5f
	43.618750+08:00 mypower kernel:  ? iwl_mvm_bss_info_changed_station_common+0xad/0x110 [iwlmvm]
	43.618751+08:00 mypower kernel:  __sta_info_flush+0x11a/0x240 [mac80211]
	...


No sure whether this is a bug or not, but those dumping logs are very disturbing....


Here is a long log:

[  904.086184] iwlwifi 0000:21:00.0: Microcode SW error detected.  Restarting 0x2000000.
[  904.086356] iwlwifi 0000:21:00.0: Start IWL Error Log Dump:
[  904.086360] iwlwifi 0000:21:00.0: Transport status: 0x0000004A, valid: 6
[  904.086364] iwlwifi 0000:21:00.0: Loaded firmware version: 17.bfb58538.0 7260-17.ucode
[  904.086367] iwlwifi 0000:21:00.0: 0x00001030 | ADVANCED_SYSASSERT          
[  904.086371] iwlwifi 0000:21:00.0: 0x00800221 | trm_hw_status0
[  904.086375] iwlwifi 0000:21:00.0: 0x00000000 | trm_hw_status1
[  904.086378] iwlwifi 0000:21:00.0: 0x00000B30 | branchlink2
[  904.086380] iwlwifi 0000:21:00.0: 0x000164C0 | interruptlink1
[  904.086383] iwlwifi 0000:21:00.0: 0x00000000 | interruptlink2
[  904.086386] iwlwifi 0000:21:00.0: 0xDEADBEEF | data1
[  904.086389] iwlwifi 0000:21:00.0: 0xDEADBEEF | data2
[  904.086392] iwlwifi 0000:21:00.0: 0xDEADBEEF | data3
[  904.086395] iwlwifi 0000:21:00.0: 0x32C1393B | beacon time
[  904.086399] iwlwifi 0000:21:00.0: 0x060356C5 | tsf low
[  904.086402] iwlwifi 0000:21:00.0: 0x00000001 | tsf hi
[  904.086405] iwlwifi 0000:21:00.0: 0x00000421 | time gp1
[  904.086408] iwlwifi 0000:21:00.0: 0x2CE1413E | time gp2
[  904.086411] iwlwifi 0000:21:00.0: 0x00000000 | uCode revision type
[  904.086415] iwlwifi 0000:21:00.0: 0x00000011 | uCode version major
[  904.086418] iwlwifi 0000:21:00.0: 0xBFB58538 | uCode version minor
[  904.086421] iwlwifi 0000:21:00.0: 0x00000144 | hw version
[  904.086424] iwlwifi 0000:21:00.0: 0x40489204 | board version
[  904.086427] iwlwifi 0000:21:00.0: 0x0B06001C | hcmd
[  904.086430] iwlwifi 0000:21:00.0: 0xA6F2300A | isr0
[  904.086433] iwlwifi 0000:21:00.0: 0x0181E000 | isr1
[  904.086436] iwlwifi 0000:21:00.0: 0x00000012 | isr2
[  904.086438] iwlwifi 0000:21:00.0: 0x404038C4 | isr3
[  904.086441] iwlwifi 0000:21:00.0: 0x00000000 | isr4
[  904.086444] iwlwifi 0000:21:00.0: 0x10814112 | last cmd Id
[  904.086447] iwlwifi 0000:21:00.0: 0x00000000 | wait_event
[  904.086450] iwlwifi 0000:21:00.0: 0x000000C4 | l2p_control
[  904.086453] iwlwifi 0000:21:00.0: 0x0001D410 | l2p_duration
[  904.086457] iwlwifi 0000:21:00.0: 0x00000007 | l2p_mhvalid
[  904.086460] iwlwifi 0000:21:00.0: 0x00000081 | l2p_addr_match
[  904.086463] iwlwifi 0000:21:00.0: 0x00000017 | lmpm_pmg_sel
[  904.086466] iwlwifi 0000:21:00.0: 0x15041745 | timestamp
[  904.086469] iwlwifi 0000:21:00.0: 0x00005868 | flow_handler
[  904.086480] iwlwifi 0000:21:00.0: Fseq Registers:
[  904.086488] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  904.086495] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  904.086503] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  904.086511] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  904.086519] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  904.086527] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  904.086534] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVI_ID
[  904.086542] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVR_ID
[  904.086550] iwlwifi 0000:21:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  904.086557] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  904.086565] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  904.086573] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  904.086581] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_PREV_CNVIO_INIT_VERSION
[  904.086588] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_WIFI_FSEQ_VERSION
[  904.086596] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_BT_FSEQ_VERSION
[  904.086604] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CLASS_TP_VERSION
[  904.086625] iwlwifi 0000:21:00.0: Collecting data: trigger 2 fired.
[  904.086637] iwlwifi 0000:21:00.0: Device error - SW reset
[  904.086643] ieee80211 phy0: Hardware restart was requested
[  904.560156] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 0
[  904.560165] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 4
[  904.560169] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 5
[  904.560362] iwlwifi 0000:21:00.0: restart completed
[  905.776822] iwlwifi 0000:21:00.0: Microcode SW error detected.  Restarting 0x2000000.
[  905.776990] iwlwifi 0000:21:00.0: Start IWL Error Log Dump:
[  905.776993] iwlwifi 0000:21:00.0: Transport status: 0x0000004A, valid: 6
[  905.776997] iwlwifi 0000:21:00.0: Loaded firmware version: 17.bfb58538.0 7260-17.ucode
[  905.777000] iwlwifi 0000:21:00.0: 0x00001030 | ADVANCED_SYSASSERT          
[  905.777004] iwlwifi 0000:21:00.0: 0x00800221 | trm_hw_status0
[  905.777007] iwlwifi 0000:21:00.0: 0x00000000 | trm_hw_status1
[  905.777010] iwlwifi 0000:21:00.0: 0x00000B30 | branchlink2
[  905.777013] iwlwifi 0000:21:00.0: 0x000164C0 | interruptlink1
[  905.777016] iwlwifi 0000:21:00.0: 0x00000000 | interruptlink2
[  905.777018] iwlwifi 0000:21:00.0: 0xDEADBEEF | data1
[  905.777021] iwlwifi 0000:21:00.0: 0xDEADBEEF | data2
[  905.777024] iwlwifi 0000:21:00.0: 0xDEADBEEF | data3
[  905.777027] iwlwifi 0000:21:00.0: 0x00406FEF | beacon time
[  905.777030] iwlwifi 0000:21:00.0: 0x061D22D7 | tsf low
[  905.777033] iwlwifi 0000:21:00.0: 0x00000001 | tsf hi
[  905.777035] iwlwifi 0000:21:00.0: 0x00000423 | time gp1
[  905.777038] iwlwifi 0000:21:00.0: 0x0012F0C1 | time gp2
[  905.777041] iwlwifi 0000:21:00.0: 0x00000000 | uCode revision type
[  905.777043] iwlwifi 0000:21:00.0: 0x00000011 | uCode version major
[  905.777046] iwlwifi 0000:21:00.0: 0xBFB58538 | uCode version minor
[  905.777049] iwlwifi 0000:21:00.0: 0x00000144 | hw version
[  905.777052] iwlwifi 0000:21:00.0: 0x40489204 | board version
[  905.777055] iwlwifi 0000:21:00.0: 0x0B15001C | hcmd
[  905.777057] iwlwifi 0000:21:00.0: 0xA6F2300A | isr0
[  905.777060] iwlwifi 0000:21:00.0: 0x0101E000 | isr1
[  905.777063] iwlwifi 0000:21:00.0: 0x0000001A | isr2
[  905.777066] iwlwifi 0000:21:00.0: 0x004120C4 | isr3
[  905.777069] iwlwifi 0000:21:00.0: 0x00000000 | isr4
[  905.777071] iwlwifi 0000:21:00.0: 0x10010112 | last cmd Id
[  905.777074] iwlwifi 0000:21:00.0: 0x00000000 | wait_event
[  905.777077] iwlwifi 0000:21:00.0: 0x000000C4 | l2p_control
[  905.777080] iwlwifi 0000:21:00.0: 0x0001CC10 | l2p_duration
[  905.777082] iwlwifi 0000:21:00.0: 0x00000007 | l2p_mhvalid
[  905.777085] iwlwifi 0000:21:00.0: 0x00000081 | l2p_addr_match
[  905.777087] iwlwifi 0000:21:00.0: 0x00000017 | lmpm_pmg_sel
[  905.777090] iwlwifi 0000:21:00.0: 0x15041745 | timestamp
[  905.777092] iwlwifi 0000:21:00.0: 0x0000D0E0 | flow_handler
[  905.777102] iwlwifi 0000:21:00.0: Fseq Registers:
[  905.777109] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  905.777116] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  905.777123] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  905.777130] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  905.777137] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  905.777178] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  905.777186] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVI_ID
[  905.777194] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVR_ID
[  905.777201] iwlwifi 0000:21:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  905.777209] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  905.777216] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  905.777224] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  905.777232] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_PREV_CNVIO_INIT_VERSION
[  905.777239] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_WIFI_FSEQ_VERSION
[  905.777247] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_BT_FSEQ_VERSION
[  905.777254] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CLASS_TP_VERSION
[  905.777289] iwlwifi 0000:21:00.0: Collecting data: trigger 2 fired.
[  905.777300] iwlwifi 0000:21:00.0: Device error - reprobe!
[  906.021240] iwlwifi 0000:21:00.0: Failed to send MAC_CONTEXT_CMD (action:3): -5
[  906.021252] iwlwifi 0000:21:00.0: mcast filter cmd error. ret=-5
[  906.021255] iwlwifi 0000:21:00.0: Failed to synchronize multicast groups update
[  906.021272] wlo1: deauthenticating from a8:57:4e:6d:2b:e4 by local choice (Reason: 3=DEAUTH_LEAVING)
[  906.021286] iwlwifi 0000:21:00.0: Failed to send MAC_CONTEXT_CMD (action:2): -5
[  906.021289] iwlwifi 0000:21:00.0: failed to update MAC 90:2e:1c:61:f1:2a
[  906.021293] iwlwifi 0000:21:00.0: failed to update power mode
[  906.021314] iwlwifi 0000:21:00.0: Failed to send flush command (-5)
[  906.021316] iwlwifi 0000:21:00.0: flush request fail
[  906.021339] iwlwifi 0000:21:00.0: Failed to send MAC_CONTEXT_CMD (action:2): -5
[  906.021342] iwlwifi 0000:21:00.0: failed to update MAC 90:2e:1c:61:f1:2a
[  906.021345] iwlwifi 0000:21:00.0: Failed to send quota: -5
[  906.021348] iwlwifi 0000:21:00.0: failed to update quotas
[  906.021351] iwlwifi 0000:21:00.0: Failed to send MAC_CONTEXT_CMD (action:2): -5
[  906.021353] iwlwifi 0000:21:00.0: failed to update MAC 90:2e:1c:61:f1:2a (clear after unassoc)
[  906.021356] iwlwifi 0000:21:00.0: Failed to synchronize multicast groups update
[  906.021360] iwlwifi 0000:21:00.0: failed to update power mode
[  906.021389] iwlwifi 0000:21:00.0: Failed to send flush command (-5)
[  906.021392] iwlwifi 0000:21:00.0: flush request fail
[  906.021420] wlo1: failed to remove key (0, a8:57:4e:6d:2b:e4) from hardware (-5)
[  906.021469] iwlwifi 0000:21:00.0: Failed to send quota: -5
[  906.021473] iwlwifi 0000:21:00.0: Failed to send binding (action:3): -5
[  906.021477] iwlwifi 0000:21:00.0: Failed to send MAC_CONTEXT_CMD (action:2): -5
[  906.021480] iwlwifi 0000:21:00.0: failed to update MAC 90:2e:1c:61:f1:2a
[  906.021484] iwlwifi 0000:21:00.0: PHY ctxt cmd error. ret=-5
[  906.038648] iwlwifi 0000:21:00.0: Failed to send MAC_CONTEXT_CMD (action:3): -5
[  906.038668] iwlwifi 0000:21:00.0: Failed to disable queue 1 (ret=-5)
[  906.038672] iwlwifi 0000:21:00.0: Failed to remove station. Id=1
[  906.038676] iwlwifi 0000:21:00.0: Failed sending remove station
[  906.189767] ACPI: \: failed to evaluate _DSM 2c176672-0b22-294b-814f-75e4dd26b5fd rev:0 func:0 (0x1001)
[  906.189774] ACPI: \: failed to evaluate _DSM 2c176672-0b22-294b-814f-75e4dd26b5fd rev:0 func:0 (0x1001)
[  906.189877] iwlwifi 0000:21:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
[  906.189887] iwlwifi 0000:21:00.0: PCI dev 08b1/c070, rev=0x144, rfid=0xd55555d5
[  906.189891] iwlwifi 0000:21:00.0: Detected Intel(R) Dual Band Wireless AC 7260
[  906.190931] iwlwifi 0000:21:00.0: loaded firmware version 17.bfb58538.0 7260-17.ucode op_mode iwlmvm
[  906.209496] iwlwifi 0000:21:00.0: base HW address: 90:2e:1c:61:f1:2a, OTP minor version: 0x0
[  906.433395] ieee80211 phy1: Selected rate control algorithm 'iwl-mvm-rs'
[  906.438002] iwlwifi 0000:21:00.0 wlo1: renamed from wlan0
[  906.701690] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade rev:0 func:0 (0x1001)
[  910.360437] wlo1: authenticate with a8:57:4e:6d:2b:e4 (local address=90:2e:1c:61:f1:2a)
[  910.360994] wlo1: send auth to a8:57:4e:6d:2b:e4 (try 1/3)
[  910.365463] wlo1: authenticated
[  910.365625] wlo1: associate with a8:57:4e:6d:2b:e4 (try 1/3)
[  910.369335] wlo1: RX AssocResp from a8:57:4e:6d:2b:e4 (capab=0x431 status=0 aid=6)
[  910.370417] wlo1: associated
[  913.757185] iwlwifi 0000:21:00.0: Microcode SW error detected.  Restarting 0x2000000.
[  913.757352] iwlwifi 0000:21:00.0: Start IWL Error Log Dump:
[  913.757355] iwlwifi 0000:21:00.0: Transport status: 0x0000004A, valid: 6
[  913.757358] iwlwifi 0000:21:00.0: Loaded firmware version: 17.bfb58538.0 7260-17.ucode
[  913.757361] iwlwifi 0000:21:00.0: 0x00001030 | ADVANCED_SYSASSERT          
[  913.757364] iwlwifi 0000:21:00.0: 0x00800221 | trm_hw_status0
[  913.757367] iwlwifi 0000:21:00.0: 0x00000000 | trm_hw_status1
[  913.757369] iwlwifi 0000:21:00.0: 0x00000B30 | branchlink2
[  913.757372] iwlwifi 0000:21:00.0: 0x000164C0 | interruptlink1
[  913.757374] iwlwifi 0000:21:00.0: 0x00000000 | interruptlink2
[  913.757377] iwlwifi 0000:21:00.0: 0xDEADBEEF | data1
[  913.757379] iwlwifi 0000:21:00.0: 0xDEADBEEF | data2
[  913.757382] iwlwifi 0000:21:00.0: 0xDEADBEEF | data3
[  913.757384] iwlwifi 0000:21:00.0: 0x05408A5D | beacon time
[  913.757386] iwlwifi 0000:21:00.0: 0x0696E82B | tsf low
[  913.757389] iwlwifi 0000:21:00.0: 0x00000001 | tsf hi
[  913.757391] iwlwifi 0000:21:00.0: 0x00000421 | time gp1
[  913.757394] iwlwifi 0000:21:00.0: 0x00670401 | time gp2
[  913.757396] iwlwifi 0000:21:00.0: 0x00000000 | uCode revision type
[  913.757398] iwlwifi 0000:21:00.0: 0x00000011 | uCode version major
[  913.757401] iwlwifi 0000:21:00.0: 0xBFB58538 | uCode version minor
[  913.757403] iwlwifi 0000:21:00.0: 0x00000144 | hw version
[  913.757406] iwlwifi 0000:21:00.0: 0x40489204 | board version
[  913.757408] iwlwifi 0000:21:00.0: 0x0B09001C | hcmd
[  913.757411] iwlwifi 0000:21:00.0: 0xA6F23008 | isr0
[  913.757413] iwlwifi 0000:21:00.0: 0x0181E000 | isr1
[  913.757415] iwlwifi 0000:21:00.0: 0x0000001A | isr2
[  913.757418] iwlwifi 0000:21:00.0: 0x004120C4 | isr3
[  913.757420] iwlwifi 0000:21:00.0: 0x00000000 | isr4
[  913.757423] iwlwifi 0000:21:00.0: 0x10010112 | last cmd Id
[  913.757425] iwlwifi 0000:21:00.0: 0x00000000 | wait_event
[  913.757427] iwlwifi 0000:21:00.0: 0x000000C4 | l2p_control
[  913.757430] iwlwifi 0000:21:00.0: 0x0001D410 | l2p_duration
[  913.757432] iwlwifi 0000:21:00.0: 0x00000007 | l2p_mhvalid
[  913.757435] iwlwifi 0000:21:00.0: 0x00000081 | l2p_addr_match
[  913.757437] iwlwifi 0000:21:00.0: 0x00000017 | lmpm_pmg_sel
[  913.757439] iwlwifi 0000:21:00.0: 0x15041745 | timestamp
[  913.757442] iwlwifi 0000:21:00.0: 0x00002838 | flow_handler
[  913.757452] iwlwifi 0000:21:00.0: Fseq Registers:
[  913.757459] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  913.757466] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  913.757473] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  913.757480] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  913.757487] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  913.757493] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  913.757500] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVI_ID
[  913.757507] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVR_ID
[  913.757514] iwlwifi 0000:21:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  913.757521] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  913.757528] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  913.757535] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  913.757542] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_PREV_CNVIO_INIT_VERSION
[  913.757549] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_WIFI_FSEQ_VERSION
[  913.757556] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_BT_FSEQ_VERSION
[  913.757563] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CLASS_TP_VERSION
[  913.757576] iwlwifi 0000:21:00.0: Collecting data: trigger 2 fired.
[  913.757583] iwlwifi 0000:21:00.0: Device error - SW reset
[  913.757587] ieee80211 phy1: Hardware restart was requested
[  914.224117] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 0
[  914.224125] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 5
[  914.224173] iwlwifi 0000:21:00.0: restart completed
[ 1043.639858] iwlwifi 0000:21:00.0: Microcode SW error detected.  Restarting 0x2000000.
[ 1043.640026] iwlwifi 0000:21:00.0: Start IWL Error Log Dump:
[ 1043.640030] iwlwifi 0000:21:00.0: Transport status: 0x0000004A, valid: 6
[ 1043.640033] iwlwifi 0000:21:00.0: Loaded firmware version: 17.bfb58538.0 7260-17.ucode
[ 1043.640036] iwlwifi 0000:21:00.0: 0x00001030 | ADVANCED_SYSASSERT          
[ 1043.640039] iwlwifi 0000:21:00.0: 0x00800621 | trm_hw_status0
[ 1043.640042] iwlwifi 0000:21:00.0: 0x00000000 | trm_hw_status1
[ 1043.640045] iwlwifi 0000:21:00.0: 0x00000B30 | branchlink2
[ 1043.640048] iwlwifi 0000:21:00.0: 0x000164C0 | interruptlink1
[ 1043.640050] iwlwifi 0000:21:00.0: 0x00000000 | interruptlink2
[ 1043.640053] iwlwifi 0000:21:00.0: 0xDEADBEEF | data1
[ 1043.640056] iwlwifi 0000:21:00.0: 0xDEADBEEF | data2
[ 1043.640058] iwlwifi 0000:21:00.0: 0xDEADBEEF | data3
[ 1043.640061] iwlwifi 0000:21:00.0: 0x35817D36 | beacon time
[ 1043.640063] iwlwifi 0000:21:00.0: 0x0E54C2CB | tsf low
[ 1043.640066] iwlwifi 0000:21:00.0: 0x00000001 | tsf hi
[ 1043.640069] iwlwifi 0000:21:00.0: 0x00000424 | time gp1
[ 1043.640072] iwlwifi 0000:21:00.0: 0x07B723A8 | time gp2
[ 1043.640074] iwlwifi 0000:21:00.0: 0x00000000 | uCode revision type
[ 1043.640077] iwlwifi 0000:21:00.0: 0x00000011 | uCode version major
[ 1043.640079] iwlwifi 0000:21:00.0: 0xBFB58538 | uCode version minor
[ 1043.640082] iwlwifi 0000:21:00.0: 0x00000144 | hw version
[ 1043.640085] iwlwifi 0000:21:00.0: 0x40489204 | board version
[ 1043.640088] iwlwifi 0000:21:00.0: 0x0B0F001C | hcmd
[ 1043.640090] iwlwifi 0000:21:00.0: 0xA6F2300A | isr0
[ 1043.640093] iwlwifi 0000:21:00.0: 0x0101E000 | isr1
[ 1043.640096] iwlwifi 0000:21:00.0: 0x0000001A | isr2
[ 1043.640098] iwlwifi 0000:21:00.0: 0x404024C4 | isr3
[ 1043.640101] iwlwifi 0000:21:00.0: 0x00000000 | isr4
[ 1043.640104] iwlwifi 0000:21:00.0: 0x10810112 | last cmd Id
[ 1043.640106] iwlwifi 0000:21:00.0: 0x00000000 | wait_event
[ 1043.640109] iwlwifi 0000:21:00.0: 0x000000C4 | l2p_control
[ 1043.640112] iwlwifi 0000:21:00.0: 0x0001CC10 | l2p_duration
[ 1043.640115] iwlwifi 0000:21:00.0: 0x00000007 | l2p_mhvalid
[ 1043.640118] iwlwifi 0000:21:00.0: 0x00000081 | l2p_addr_match
[ 1043.640121] iwlwifi 0000:21:00.0: 0x00000017 | lmpm_pmg_sel
[ 1043.640123] iwlwifi 0000:21:00.0: 0x15041745 | timestamp
[ 1043.640126] iwlwifi 0000:21:00.0: 0x0000B0C0 | flow_handler
[ 1043.640136] iwlwifi 0000:21:00.0: Fseq Registers:
[ 1043.640143] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ERROR_CODE
[ 1043.640150] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[ 1043.640157] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[ 1043.640164] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_OTP_VERSION
[ 1043.640171] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[ 1043.640178] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[ 1043.640184] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVI_ID
[ 1043.640191] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVR_ID
[ 1043.640198] iwlwifi 0000:21:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[ 1043.640205] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[ 1043.640212] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 1043.640219] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 1043.640226] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_PREV_CNVIO_INIT_VERSION
[ 1043.640233] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_WIFI_FSEQ_VERSION
[ 1043.640240] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_BT_FSEQ_VERSION
[ 1043.640247] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CLASS_TP_VERSION
[ 1043.640261] iwlwifi 0000:21:00.0: Collecting data: trigger 2 fired.
[ 1043.640267] iwlwifi 0000:21:00.0: Device error - SW reset
[ 1043.640272] ieee80211 phy1: Hardware restart was requested
[ 1044.109207] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 0
[ 1044.109221] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 5
[ 1044.109273] iwlwifi 0000:21:00.0: restart completed
[ 2383.973111] iwlwifi 0000:21:00.0: Microcode SW error detected.  Restarting 0x2000000.
[ 2383.973296] iwlwifi 0000:21:00.0: Start IWL Error Log Dump:
[ 2383.973301] iwlwifi 0000:21:00.0: Transport status: 0x0000004A, valid: 6
[ 2383.973304] iwlwifi 0000:21:00.0: Loaded firmware version: 17.bfb58538.0 7260-17.ucode
[ 2383.973308] iwlwifi 0000:21:00.0: 0x00001030 | ADVANCED_SYSASSERT          
[ 2383.973311] iwlwifi 0000:21:00.0: 0x00800621 | trm_hw_status0
[ 2383.973314] iwlwifi 0000:21:00.0: 0x00000000 | trm_hw_status1
[ 2383.973316] iwlwifi 0000:21:00.0: 0x00000B30 | branchlink2
[ 2383.973319] iwlwifi 0000:21:00.0: 0x000164C0 | interruptlink1
[ 2383.973322] iwlwifi 0000:21:00.0: 0x00000000 | interruptlink2
[ 2383.973324] iwlwifi 0000:21:00.0: 0xDEADBEEF | data1
[ 2383.973327] iwlwifi 0000:21:00.0: 0xDEADBEEF | data2
[ 2383.973329] iwlwifi 0000:21:00.0: 0xDEADBEEF | data3
[ 2383.973331] iwlwifi 0000:21:00.0: 0x09013603 | beacon time
[ 2383.973334] iwlwifi 0000:21:00.0: 0x5E38A574 | tsf low
[ 2383.973336] iwlwifi 0000:21:00.0: 0x00000001 | tsf hi
[ 2383.973339] iwlwifi 0000:21:00.0: 0x00000423 | time gp1
[ 2383.973341] iwlwifi 0000:21:00.0: 0x4FDD63CC | time gp2
[ 2383.973344] iwlwifi 0000:21:00.0: 0x00000000 | uCode revision type
[ 2383.973346] iwlwifi 0000:21:00.0: 0x00000011 | uCode version major
[ 2383.973349] iwlwifi 0000:21:00.0: 0xBFB58538 | uCode version minor
[ 2383.973352] iwlwifi 0000:21:00.0: 0x00000144 | hw version
[ 2383.973354] iwlwifi 0000:21:00.0: 0x40489204 | board version
[ 2383.973357] iwlwifi 0000:21:00.0: 0x0417001C | hcmd
[ 2383.973359] iwlwifi 0000:21:00.0: 0xA6F23008 | isr0
[ 2383.973362] iwlwifi 0000:21:00.0: 0x0101E000 | isr1
[ 2383.973365] iwlwifi 0000:21:00.0: 0x0000001A | isr2
[ 2383.973368] iwlwifi 0000:21:00.0: 0x0040E4C4 | isr3
[ 2383.973371] iwlwifi 0000:21:00.0: 0x00000000 | isr4
[ 2383.973374] iwlwifi 0000:21:00.0: 0x10010112 | last cmd Id
[ 2383.973376] iwlwifi 0000:21:00.0: 0x00000000 | wait_event
[ 2383.973379] iwlwifi 0000:21:00.0: 0x000000C4 | l2p_control
[ 2383.973382] iwlwifi 0000:21:00.0: 0x0001CC10 | l2p_duration
[ 2383.973385] iwlwifi 0000:21:00.0: 0x00000007 | l2p_mhvalid
[ 2383.973388] iwlwifi 0000:21:00.0: 0x00000081 | l2p_addr_match
[ 2383.973390] iwlwifi 0000:21:00.0: 0x00000017 | lmpm_pmg_sel
[ 2383.973393] iwlwifi 0000:21:00.0: 0x15041745 | timestamp
[ 2383.973396] iwlwifi 0000:21:00.0: 0x00008898 | flow_handler
[ 2383.973409] iwlwifi 0000:21:00.0: Fseq Registers:
[ 2383.973417] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ERROR_CODE
[ 2383.973425] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[ 2383.973433] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[ 2383.973440] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_OTP_VERSION
[ 2383.973448] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[ 2383.973456] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[ 2383.973463] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVI_ID
[ 2383.973471] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVR_ID
[ 2383.973479] iwlwifi 0000:21:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[ 2383.973486] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[ 2383.973493] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 2383.973500] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 2383.973508] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_PREV_CNVIO_INIT_VERSION
[ 2383.973515] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_WIFI_FSEQ_VERSION
[ 2383.973522] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_BT_FSEQ_VERSION
[ 2383.973529] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CLASS_TP_VERSION
[ 2383.973549] iwlwifi 0000:21:00.0: Collecting data: trigger 2 fired.
[ 2383.973558] iwlwifi 0000:21:00.0: Device error - SW reset
[ 2383.973564] ieee80211 phy1: Hardware restart was requested
[ 2384.433441] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 0
[ 2384.433451] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 4
[ 2384.433498] iwlwifi 0000:21:00.0: restart completed
[ 5084.874914] iwlwifi 0000:21:00.0: Microcode SW error detected.  Restarting 0x2000000.
[ 5084.875081] iwlwifi 0000:21:00.0: Start IWL Error Log Dump:
[ 5084.875084] iwlwifi 0000:21:00.0: Transport status: 0x0000004A, valid: 6
[ 5084.875087] iwlwifi 0000:21:00.0: Loaded firmware version: 17.bfb58538.0 7260-17.ucode
[ 5084.875090] iwlwifi 0000:21:00.0: 0x00001030 | ADVANCED_SYSASSERT          
[ 5084.875093] iwlwifi 0000:21:00.0: 0x00800223 | trm_hw_status0
[ 5084.875095] iwlwifi 0000:21:00.0: 0x00000000 | trm_hw_status1
[ 5084.875098] iwlwifi 0000:21:00.0: 0x00000B30 | branchlink2
[ 5084.875100] iwlwifi 0000:21:00.0: 0x000164C0 | interruptlink1
[ 5084.875103] iwlwifi 0000:21:00.0: 0x00000000 | interruptlink2
[ 5084.875105] iwlwifi 0000:21:00.0: 0xDEADBEEF | data1
[ 5084.875107] iwlwifi 0000:21:00.0: 0xDEADBEEF | data2
[ 5084.875110] iwlwifi 0000:21:00.0: 0xDEADBEEF | data3
[ 5084.875112] iwlwifi 0000:21:00.0: 0x2FC13682 | beacon time
[ 5084.875114] iwlwifi 0000:21:00.0: 0xFF352391 | tsf low
[ 5084.875117] iwlwifi 0000:21:00.0: 0x00000001 | tsf hi
[ 5084.875119] iwlwifi 0000:21:00.0: 0x0000040C | time gp1
[ 5084.875121] iwlwifi 0000:21:00.0: 0xA0F699F9 | time gp2
[ 5084.875124] iwlwifi 0000:21:00.0: 0x00000000 | uCode revision type
[ 5084.875126] iwlwifi 0000:21:00.0: 0x00000011 | uCode version major
[ 5084.875129] iwlwifi 0000:21:00.0: 0xBFB58538 | uCode version minor
[ 5084.875131] iwlwifi 0000:21:00.0: 0x00000144 | hw version
[ 5084.875133] iwlwifi 0000:21:00.0: 0x40489204 | board version
[ 5084.875136] iwlwifi 0000:21:00.0: 0x0433001C | hcmd
[ 5084.875138] iwlwifi 0000:21:00.0: 0xA6F23008 | isr0
[ 5084.875140] iwlwifi 0000:21:00.0: 0x0101E000 | isr1
[ 5084.875143] iwlwifi 0000:21:00.0: 0x0000001A | isr2
[ 5084.875145] iwlwifi 0000:21:00.0: 0x004124C4 | isr3
[ 5084.875147] iwlwifi 0000:21:00.0: 0x00000000 | isr4
[ 5084.875150] iwlwifi 0000:21:00.0: 0x10010112 | last cmd Id
[ 5084.875152] iwlwifi 0000:21:00.0: 0x00000000 | wait_event
[ 5084.875154] iwlwifi 0000:21:00.0: 0x000000C4 | l2p_control
[ 5084.875157] iwlwifi 0000:21:00.0: 0x0001DC10 | l2p_duration
[ 5084.875159] iwlwifi 0000:21:00.0: 0x00000007 | l2p_mhvalid
[ 5084.875162] iwlwifi 0000:21:00.0: 0x00000081 | l2p_addr_match
[ 5084.875164] iwlwifi 0000:21:00.0: 0x00000017 | lmpm_pmg_sel
[ 5084.875166] iwlwifi 0000:21:00.0: 0x15041745 | timestamp
[ 5084.875169] iwlwifi 0000:21:00.0: 0x000090A0 | flow_handler
[ 5084.875178] iwlwifi 0000:21:00.0: Fseq Registers:
[ 5084.875185] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ERROR_CODE
[ 5084.875192] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[ 5084.875199] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[ 5084.875206] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_OTP_VERSION
[ 5084.875213] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[ 5084.875220] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[ 5084.875227] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVI_ID
[ 5084.875234] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CNVR_ID
[ 5084.875240] iwlwifi 0000:21:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[ 5084.875247] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[ 5084.875254] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 5084.875261] iwlwifi 0000:21:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 5084.875268] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_PREV_CNVIO_INIT_VERSION
[ 5084.875275] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_WIFI_FSEQ_VERSION
[ 5084.875282] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_BT_FSEQ_VERSION
[ 5084.875289] iwlwifi 0000:21:00.0: 0x00000000 | FSEQ_CLASS_TP_VERSION
[ 5084.875306] iwlwifi 0000:21:00.0: Collecting data: trigger 2 fired.
[ 5084.875313] iwlwifi 0000:21:00.0: Device error - SW reset
[ 5084.875317] ieee80211 phy1: Hardware restart was requested
[ 5085.329970] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 2
[ 5085.329978] wlo1: HW problem - can not stop rx aggregation for a8:57:4e:6d:2b:e4 tid 4
[ 5085.330023] iwlwifi 0000:21:00.0: restart completed


FYI
David


