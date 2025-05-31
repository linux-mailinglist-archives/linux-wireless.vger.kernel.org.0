Return-Path: <linux-wireless+bounces-23512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49172AC9B4F
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 16:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407093BCF6D
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD43237162;
	Sat, 31 May 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQAYTdRg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708623BCEB
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748700582; cv=none; b=Levg0f3FJv4i5JBXz3bGThFZ0e/Gi67hLqa+H0XmoZiT0HIigQsmG/Hit7qP/uyb0SbwarW/Rom83DdBgyqgQVU2Ef6RdPfC7CDI674627sAbPMQ6VmGoVJABReNqoFcx9M4DJgztZb+zR2v+vsQ1rEkG0nF7slQR/yB5oXZ2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748700582; c=relaxed/simple;
	bh=ln2zJxB8B0GBMsALaFZtXKtXpwlkXDNptpjKy1HF+wo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OieFWje7BBMZWCm4l/3QEoOpKaYum3olZ2mLMj5sxKkdy4ED/AGFhhRMyRfC9hLXbLi3BRUU3FAq58XIrQlwjgYEDvwUfazIWiSjWzJJYBFhxX/h+aV6B0MODF7FczsWPzg9rKUWMhjkk4i2J3elWN9CkV8Svfiu9fegW2uNdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQAYTdRg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf257158fso21052915e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748700578; x=1749305378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okQBr/QtJ+GVSYE7jgFPwfHh+fDBMruhEGsbJEkgWNo=;
        b=AQAYTdRgbZBrueoaIu/XFxcuZwoW7vItiCGtBOPtGh3t3uBn0xiHQVjXhny26fgjCL
         rQImtQD+ZYncw5xQyrujwi9HR3qYvCXQqAigxkIdiyi0QAXOndVjPp5hivF5PxYhO2di
         keLpd9tRwo5HkIvinTILtIavpfgQX66FcsevVkkZVvg5Pg9d0Ca2J+xdLBKKJrro8pwe
         3C4JxGNyhJErmsSMilpy99t88ElExEjxq+m2antIeOTuIiXkdMjoZ1iiKqyC35IzqOyF
         qsOCrVuuOnZtdH1chSlehGDfHFppEUHXHb2wh7x6EiOhtPwrHppWgI8XVAtZcEI6gOkC
         W/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748700578; x=1749305378;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okQBr/QtJ+GVSYE7jgFPwfHh+fDBMruhEGsbJEkgWNo=;
        b=PIxhQeHQMAXOqs+ePQv9ZpfQNlCLw0HoGxFaG0OxlSg1LEcnm+41E1WxcGgb94EWB/
         ztZedgLAvtqYHlpgEFW3OQCM1VHcl2q7XKghiVXVZaSZuGuZm2VPZG/7U6aCke5LG8k7
         vqtYVmb3cRU+My6jwsptZpkKz6J0Q3rPTsPn7A88HXQZKoRJgwkA6BXmekJCGFfkbnJX
         H2VZogRSFfguq6D2AN4mDxWSIeKKV/MaV+fyQINXhcN1Mi4I9Bdlx82fkaekgMhp6zwl
         q5akj7IgqWB13Naa7W3ArH6E2wBjLLLpLQg/oX+5QZJqslCziNbKmGtva+xSaOSzuGrO
         WlWg==
X-Gm-Message-State: AOJu0Yzvv5epVOQgpjUvSnsqXtM1AOTBtrDFZLBEI6+ji5WYcHFZzkdq
	za6tK/mn4dxktSbmogCM/Yv4Gk9qGNalT/V1aKgJsSI8djaDVx+kckPGXxCTd1F+xsE=
X-Gm-Gg: ASbGncsIKDxpOyTbEVHbG8aKM0fTWcpUegQlrSl2XYLW161mrLXa72E4C2vT7f4oNHE
	WKUgNvIW4TZowceQg2gb0wrLo3y3e9XEvFZVqoflsmhwSkR3nq25Yk6qEZfJz8Xoc153183221c
	m6DMBqDgASBmjqhd9FMtYs6oLNWjIEEj7om9Itru5pUDZEp4oh4BpLVtLS2Lk6bKVr/vAUp0Hmf
	UZyUTZhlZQhrfVhaqaYCcJBr2HKpY3WRjybjRdP6GrylJaZhdEimx61OVjblP3wZNT+01AYs7nQ
	eeORyigcibPLkuPGYNdCLvUwRXAWzkEzhuw759aImvIQWNyExIBqddvG3LDi/9tleACffr9TLw=
	=
X-Google-Smtp-Source: AGHT+IGh7Tf7TqC3KqWs+uFnH1ovOR5by0S2DThedhGphUPjmgzTR68M6bWi71Msc9EZ4Z6X5OTgdw==
X-Received: by 2002:a05:600c:c1c8:20b0:44a:b9e4:4e6f with SMTP id 5b1f17b1804b1-450d8874cbfmr36271005e9.16.1748700578069;
        Sat, 31 May 2025 07:09:38 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:eaf:3101:2d68:caee:7294:3fe1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8f1basm51455465e9.6.2025.05.31.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 07:09:37 -0700 (PDT)
Date: Sat, 31 May 2025 15:09:35 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [REGRESSION] iwlwifi: suspend failure, bisected
Message-ID: <aDsNn70jcX6sDLLT@debian.local>
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

There is a recently introduced iwlwifi regression on suspend. It appears
the bisected commit was only supposed to fix a warning, but reverting
the commit (with a small change for revert conflict) does fix the error.

7438843df8cf7a484303caee7540a00f0ef972b2 is the first bad commit
Gustavo A. R. Silva <gustavoars@kernel.org>commit 7438843df8cf7a484303caee7=
540a00f0ef972b2
Author: Gustavo A. R. Silva <gustavoars@kernel.org>
Date:   Wed Mar 26 18:04:02 2025 -0600

    wifi: iwlwifi: mvm: Avoid -Wflex-array-member-not-at-end warning

    -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
    getting ready to enable it, globally.

    Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
    a flexible structure where the size of the flexible-array member
    is known at compile-time, and refactor the rest of the code,
    accordingly.

    So, with these changes, fix the following warning:

    drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:6430:41: warning: str=
ucture containing a flexible array member is not at the end of another stru=
cture [-Wflex-array-member-not-at-end]

    Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
    Acked-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
    Link: https://patch.msgid.link/Z-SV8gb6MuZJmmhe@kspp
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>


[   88.149152] PM: suspend entry (s2idle)
[   88.203279] Filesystems sync: 0.054 seconds
[   88.207029] Freezing user space processes
[   88.209603] Freezing user space processes completed (elapsed 0.002 secon=
ds)
[   88.209646] OOM killer disabled.
[   88.209649] Freezing remaining freezable tasks
[   88.210556] Freezing remaining freezable tasks completed (elapsed 0.000 =
seconds)
[   88.210703] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   88.797416] wlp1s0: deauthenticating from d6:92:5e:eb:ee:15 by local cho=
ice (Reason: 3=3DDEAUTH_LEAVING)
[   88.811761] iwlwifi 0000:01:00.0: Microcode SW error detected. Restartin=
g 0x0.
[   88.811990] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   88.811993] iwlwifi 0000:01:00.0: Transport status: 0x0000004B, valid: 6
[   88.811995] iwlwifi 0000:01:00.0: Loaded firmware version: 89.202a2f7b.0=
 ty-a0-gf-a0-89.ucode
[   88.811997] iwlwifi 0000:01:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   88.812000] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[   88.812001] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[   88.812003] iwlwifi 0000:01:00.0: 0x004DAD6C | branchlink2
[   88.812004] iwlwifi 0000:01:00.0: 0x004D0176 | interruptlink1
[   88.812006] iwlwifi 0000:01:00.0: 0x004D0176 | interruptlink2
[   88.812007] iwlwifi 0000:01:00.0: 0x00016AD2 | data1
[   88.812008] iwlwifi 0000:01:00.0: 0x00000010 | data2
[   88.812010] iwlwifi 0000:01:00.0: 0x00000000 | data3
[   88.812011] iwlwifi 0000:01:00.0: 0xB100EB58 | beacon time
[   88.812013] iwlwifi 0000:01:00.0: 0x926B5499 | tsf low
[   88.812014] iwlwifi 0000:01:00.0: 0x000009F8 | tsf hi
[   88.812015] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[   88.812017] iwlwifi 0000:01:00.0: 0x048BA562 | time gp2
[   88.812018] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[   88.812019] iwlwifi 0000:01:00.0: 0x00000059 | uCode version major
[   88.812021] iwlwifi 0000:01:00.0: 0x202A2F7B | uCode version minor
[   88.812022] iwlwifi 0000:01:00.0: 0x00000420 | hw version
[   88.812023] iwlwifi 0000:01:00.0: 0x58C80002 | board version
[   88.812025] iwlwifi 0000:01:00.0: 0x80B5FC4E | hcmd
[   88.812026] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[   88.812027] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[   88.812028] iwlwifi 0000:01:00.0: 0x48F04802 | isr2
[   88.812030] iwlwifi 0000:01:00.0: 0x00C3000C | isr3
[   88.812031] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[   88.812032] iwlwifi 0000:01:00.0: 0x00860103 | last cmd Id
[   88.812033] iwlwifi 0000:01:00.0: 0x00016AD2 | wait_event
[   88.812035] iwlwifi 0000:01:00.0: 0x000000D4 | l2p_control
[   88.812036] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[   88.812037] iwlwifi 0000:01:00.0: 0x00000007 | l2p_mhvalid
[   88.812039] iwlwifi 0000:01:00.0: 0x00000048 | l2p_addr_match
[   88.812040] iwlwifi 0000:01:00.0: 0x00000008 | lmpm_pmg_sel
[   88.812041] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[   88.812043] iwlwifi 0000:01:00.0: 0x0000A81C | flow_handler
[   88.812158] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   88.812159] iwlwifi 0000:01:00.0: Transport status: 0x0000004B, valid: 7
[   88.812161] iwlwifi 0000:01:00.0: 0x20101D04 | ADVANCED_SYSASSERT
[   88.812162] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[   88.812164] iwlwifi 0000:01:00.0: 0x804838B2 | umac branchlink2
[   88.812165] iwlwifi 0000:01:00.0: 0xC00814E0 | umac interruptlink1
[   88.812166] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[   88.812168] iwlwifi 0000:01:00.0: 0x00000000 | umac data1
[   88.812169] iwlwifi 0000:01:00.0: 0x00000000 | umac data2
[   88.812170] iwlwifi 0000:01:00.0: 0x00000004 | umac data3
[   88.812171] iwlwifi 0000:01:00.0: 0x00000059 | umac major
[   88.812173] iwlwifi 0000:01:00.0: 0x202A2F7B | umac minor
[   88.812174] iwlwifi 0000:01:00.0: 0x048BA55D | frame pointer
[   88.812175] iwlwifi 0000:01:00.0: 0xC0886BE8 | stack pointer
[   88.812177] iwlwifi 0000:01:00.0: 0x008D0502 | last host cmd
[   88.812178] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[   88.812273] iwlwifi 0000:01:00.0: IML/ROM dump:
[   88.812274] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   88.812379] iwlwifi 0000:01:00.0: 0x00008D5E | IML/ROM data1
[   88.812436] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[   88.812539] iwlwifi 0000:01:00.0: Fseq Registers:
[   88.812594] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
[   88.812641] iwlwifi 0000:01:00.0: 0x80440007 | FSEQ_TOP_INIT_VERSION
[   88.812691] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[   88.812742] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[   88.812787] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[   88.812893] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[   88.812943] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[   88.812989] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[   88.813040] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[   88.813088] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[   88.813136] iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   88.813141] iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   88.813144] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   88.813147] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[   88.813149] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
[   88.813152] iwlwifi 0000:01:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[   88.813209] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0x804a5578
[   88.813211] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[   88.813333] iwlwifi 0000:01:00.0: FW error in SYNC CMD TRIGGER_RX_QUEUES=
_NOTIF_CMD
[   88.813384] CPU: 7 UID: 0 PID: 2409 Comm: kworker/u64:41 Not tainted 6.1=
5.0-09113-g8477ab143069 #364 PREEMPT(voluntary)=20
[   88.813386] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.17 12/18/2024
[   88.813387] Workqueue: async async_run_entry_fn
[   88.813392] Call Trace:
[   88.813393]  <TASK>
[   88.813395]  dump_stack_lvl+0x6e/0x90
[   88.813402]  iwl_trans_pcie_send_hcmd+0x446/0x450 [iwlwifi]
[   88.813416]  ? prepare_to_wait_exclusive+0xf0/0xf0
[   88.813421]  iwl_trans_send_cmd+0x6c/0x150 [iwlwifi]
[   88.813433]  iwl_mvm_send_cmd+0x2d/0x70 [iwlmvm]
[   88.813446]  iwl_mvm_sync_rx_queues_internal+0x123/0x2e0 [iwlmvm]
[   88.813462]  iwl_mvm_sta_rx_agg+0x30f/0xa60 [iwlmvm]
[   88.813478]  ? iwl_mvm_mac_ampdu_action+0x20c/0x400 [iwlmvm]
[   88.813486]  iwl_mvm_mac_ampdu_action+0x20c/0x400 [iwlmvm]
[   88.813494]  ? lock_is_held_type+0x96/0x100
[   88.813498]  drv_ampdu_action+0x108/0x250 [mac80211]
[   88.813530]  __ieee80211_stop_rx_ba_session+0xde/0x200 [mac80211]
[   88.813559]  ieee80211_sta_tear_down_BA_sessions+0x47/0x150 [mac80211]
[   88.813582]  __sta_info_destroy_part1+0x5c/0x7e0 [mac80211]
[   88.813606]  __sta_info_flush+0x13f/0x280 [mac80211]
[   88.813631]  ieee80211_set_disassoc+0x68b/0x940 [mac80211]
[   88.813660]  ieee80211_mgd_deauth.cold+0x51/0x224 [mac80211]
[   88.813685]  cfg80211_mlme_deauth+0xe4/0x2b0 [cfg80211]
[   88.813720]  cfg80211_mlme_down+0x93/0xd0 [cfg80211]
[   88.813742]  cfg80211_disconnect+0x1b9/0x2a0 [cfg80211]
[   88.813766]  wiphy_suspend+0x22d/0x3d0 [cfg80211]
[   88.813793]  ? wiphy_resume+0x240/0x240 [cfg80211]
[   88.813815]  dpm_run_callback+0x5f/0x1e0
[   88.813818]  device_suspend+0x18d/0x5f0
[   88.813822]  async_suspend+0x1d/0x30
[   88.813824]  async_run_entry_fn+0x2e/0x130
[   88.813827]  process_one_work+0x22b/0x5b0
[   88.813833]  worker_thread+0x1da/0x3d0
[   88.813835]  ? bh_worker+0x260/0x260
[   88.813837]  kthread+0x10a/0x250
[   88.813839]  ? kthreads_online_cpu+0x130/0x130
[   88.813841]  ret_from_fork+0x20c/0x270
[   88.813843]  ? kthreads_online_cpu+0x130/0x130
[   88.813844]  ret_from_fork_asm+0x11/0x20
[   88.813852]  </TASK>
[   88.813853] iwlwifi 0000:01:00.0: Failed to trigger RX queues sync (-5)
[   88.817949] wlp1s0: HW problem - can not stop rx aggregation for d6:92:5=
e:eb:ee:15 tid 3
[   88.817951] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   88.963365] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   89.429653] iwlwifi 0000:01:00.0: Failed to trigger RX queues sync (-5)
[   89.429655] iwlwifi 0000:01:00.0: Device error - SW reset
[   89.429897] ieee80211 phy0: Hardware restart was requested
[   89.429981] iwlwifi 0000:01:00.0: Failed to send flush command (-5)
[   89.429984] iwlwifi 0000:01:00.0: flush request fail
[   89.429997] iwlwifi 0000:01:00.0: Failed to send rate scale config (-5)
[   89.430058] wlp1s0: failed to remove key (0, d6:92:5e:eb:ee:15) from har=
dware (-5)
[   89.430086] iwlwifi 0000:01:00.0: Failed to send flush command (-5)
[   89.430194] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:2): -5
[   89.430199] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:3): -5
[   89.430200] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:1): -5
[   89.430204] iwlwifi 0000:01:00.0: PHY ctxt cmd error. ret=3D-5
[   89.430222] wlp1s0: failed to remove key (1, ff:ff:ff:ff:ff:ff) from har=
dware (-5)
[   89.430262] wlp1s0: failed to remove key (4, ff:ff:ff:ff:ff:ff) from har=
dware (-5)
[   89.431375] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:3): -5
[   89.431379] iwlwifi 0000:01:00.0: Failed to send MAC_CONFIG_CMD (action:=
3): -5
[   89.431386] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:3): -5
[   89.431387] iwlwifi 0000:01:00.0: Failed to send MAC_CONFIG_CMD (action:=
3): -5
[   89.431391] iwlwifi 0000:01:00.0: LED command failed: -5
[   89.431421] ------------[ cut here ]------------
[   89.431423] WARNING: CPU: 1 PID: 2409 at drivers/net/wireless/intel/iwlw=
ifi/mvm/d3.c:3673 iwl_mvm_fast_suspend+0x102/0x110 [iwlmvm]
[   89.431441] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq xt_conn=
track nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf=
_tables br_netfilter bridge stp llc ccm overlay qrtr rfcomm cmac algif_hash=
 algif_skcipher af_alg bnep binfmt_misc snd_acp3x_rn snd_soc_dmic snd_acp3x=
_pdm_dma snd_sof_amd_rembrandt snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_d=
sp snd_ctl_led snd_sof snd_hda_codec_realtek nls_ascii snd_sof_utils snd_so=
c_core nls_cp437 snd_hda_codec_generic snd_compress snd_hda_codec_hdmi vfat=
 snd_hda_scodec_component uvcvideo snd_pci_ps fat intel_rapl_msr snd_hda_in=
tel snd_soc_acpi_amd_match intel_rapl_common videobuf2_vmalloc snd_usb_audi=
o snd_rpl_pci_acp6x iwlmvm snd_intel_dspcfg videobuf2_memops snd_acp_pci sn=
d_amd_acpi_mach btusb uvc snd_hda_codec snd_usbmidi_lib kvm_amd mac80211 sn=
d_acp_legacy_common btrtl videobuf2_v4l2 snd_hwdep btintel snd_rawmidi snd_=
pci_acp6x kvm snd_hda_core videodev libarc4 btbcm
[   89.431514]  snd_pci_acp5x snd_seq_device hp_wmi btmtk snd_rn_pci_acp3x =
iwlwifi snd_pcm irqbypass videobuf2_common ucsi_acpi platform_profile ee100=
4 snd_acp_config snd_timer bluetooth rapl mc pcspkr sg cfg80211 typec_ucsi =
sparse_keymap wmi_bmof snd_soc_acpi snd sp5100_tco roles snd_pci_acp3x k10t=
emp watchdog ccp soundcore rfkill typec battery ac acpi_tad joydev amd_pmc =
serio_raw evdev msr parport_pc ppdev dm_mod lp parport nvme_fabrics efi_pst=
ore configfs nfnetlink efivarfs ip_tables x_tables autofs4 crc32c_cryptoapi=
 btrfs blake2b_generic sd_mod xor raid6_pq hid_microsoft ff_memless r8153_e=
cm cdc_ether usbnet uas usb_storage scsi_mod scsi_common r8152 mii libphy m=
dio_bus usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_pa=
nel_backlight_quirks drm_exec drm_suballoc_helper amdxcp drm_buddy hid_mult=
itouch gpu_sched hid_generic drm_display_helper xhci_pci drm_kms_helper nvm=
e i2c_hid_acpi xhci_hcd cec nvme_core ghash_clmulni_intel i2c_hid amd_sfh u=
sbcore rc_core nvme_keyring i2c_piix4 video sha512_ssse3 hid
[   89.431604]  usb_common crc16 nvme_auth i2c_smbus fan button wmi drm aes=
ni_intel
[   89.431614] CPU: 1 UID: 0 PID: 2409 Comm: kworker/u64:41 Not tainted 6.1=
5.0-09113-g8477ab143069 #364 PREEMPT(voluntary)=20
[   89.431617] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.17 12/18/2024
[   89.431619] Workqueue: async async_run_entry_fn
[   89.431624] RIP: 0010:iwl_mvm_fast_suspend+0x102/0x110 [iwlmvm]
[   89.431635] Code: 48 8b 3b 89 c1 48 c7 c2 d0 51 2d c2 31 f6 e8 e5 b3 9b =
ff eb b6 48 8b 3b 89 c1 48 c7 c2 a0 51 2d c2 31 f6 e8 d0 b3 9b ff eb 90 <0f=
> 0b e9 6c ff ff ff e8 52 0a 23 ef 66 90 66 0f 1f 00 0f 1f 44 00
[   89.431637] RSP: 0018:ffffb013c619fc90 EFLAGS: 00010282
[   89.431639] RAX: 00000000fffffffb RBX: ffff974e86d2b0a8 RCX: 00000000000=
00000
[   89.431641] RDX: 0000000000000000 RSI: ffffb013c619fc10 RDI: ffff974e91d=
10028
[   89.431642] RBP: 0000000000000001 R08: 0000000000000001 R09: 00000000000=
00077
[   89.431643] R10: ffffb013c619fcd0 R11: 0000000000000005 R12: ffff974e86d=
2b0d8
[   89.431644] R13: ffff974e86d2b200 R14: ffff974e86d2b1b8 R15: ffff974e86d=
2b0a8
[   89.431646] FS:  0000000000000000(0000) GS:ffff9751da7c6000(0000) knlGS:=
0000000000000000
[   89.431647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.431649] CR2: 00007f5f7dd08a20 CR3: 000000037303b000 CR4: 0000000000f=
50ef0
[   89.431650] PKRU: 55555554
[   89.431651] Call Trace:
[   89.431653]  <TASK>
[   89.431656]  __iwl_mvm_mac_stop+0xf4/0x170 [iwlmvm]
[   89.431673]  iwl_mvm_mac_stop+0xe6/0x150 [iwlmvm]
[   89.431686]  drv_stop+0x6e/0x1e0 [mac80211]
[   89.431730]  __ieee80211_suspend+0x38c/0x4e0 [mac80211]
[   89.431767]  wiphy_suspend+0xbf/0x3d0 [cfg80211]
[   89.431811]  ? wiphy_resume+0x240/0x240 [cfg80211]
[   89.431845]  dpm_run_callback+0x5f/0x1e0
[   89.431849]  device_suspend+0x18d/0x5f0
[   89.431854]  async_suspend+0x1d/0x30
[   89.431856]  async_run_entry_fn+0x2e/0x130
[   89.431860]  process_one_work+0x22b/0x5b0
[   89.431867]  worker_thread+0x1da/0x3d0
[   89.431871]  ? bh_worker+0x260/0x260
[   89.431873]  kthread+0x10a/0x250
[   89.431875]  ? kthreads_online_cpu+0x130/0x130
[   89.431878]  ret_from_fork+0x20c/0x270
[   89.431881]  ? kthreads_online_cpu+0x130/0x130
[   89.431883]  ret_from_fork_asm+0x11/0x20
[   89.431893]  </TASK>
[   89.431894] irq event stamp: 3177
[   89.431895] hardirqs last  enabled at (3183): [<ffffffffb0ba339e>] __up_=
console_sem+0x5e/0x70
[   89.431899] hardirqs last disabled at (3188): [<ffffffffb0ba3383>] __up_=
console_sem+0x43/0x70
[   89.431901] softirqs last  enabled at (1708): [<ffffffffc245fdee>] ieee8=
0211_stop_device+0x1e/0x90 [mac80211]
[   89.431939] softirqs last disabled at (1702): [<ffffffffc245fdee>] ieee8=
0211_stop_device+0x1e/0x90 [mac80211]
[   89.431969] ---[ end trace 0000000000000000 ]---
[   89.431970] iwlwifi 0000:01:00.0: fast suspend: couldn't send D3_CONFIG_=
CMD -5
[   91.450917] iwlwifi 0000:01:00.0: Timeout entering D3
[   91.450931] iwlwifi 0000:01:00.0: fast suspend: trans_d3_suspend failed =
-110
[   91.451335] PM: suspend of devices complete after 2660.094 msecs
[   91.451349] PM: start suspend of devices complete after 3239.729 msecs
[   91.454951] Disabling GPIO #9 interrupt for suspend.
[   91.455586] PM: late suspend of devices complete after 4.232 msecs
[   91.460716] ACPI: EC: interrupt blocked
[   91.488965] PM: noirq suspend of devices complete after 32.848 msecs

#regzbot introduced: 7438843df8cf7a484303caee7540a00f0ef972b2

