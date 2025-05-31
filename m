Return-Path: <linux-wireless+bounces-23515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666DEAC9C94
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 21:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF333BC797
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 19:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4AA18B47C;
	Sat, 31 May 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoGQbRYs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12960139D
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748720902; cv=none; b=C7JyfnG5e1qnmGF4Z/nDf0+PROlljn0y6Eqh9INCn95Zxw0PF+fpAlsPW7op63oAp9wlfm3y0L4zKHYHI1xz/5nYw7XaEL+SjhfLrj/NDbmLBIjGfif0NjgnSp0pzIHJ4BhiXX2AoHlJxrILbbp2KYmJjsrFONHwJAgk85ddwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748720902; c=relaxed/simple;
	bh=ILfrSLo/tJhn7jKIbbuYGxIizxhWdJ9qEizF4kbX0c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkAZN1agklr0/4dWKWvZEmGrdRj8lHkckjWZT3t73BHLDzC13NMmaChAiZ5RVVuoOYpFAEYWVvwdX0kbVVorHEcgH4eX3W26n7sWYWXPoilYae1YENlDIxC5oT/y14P/9AdrlOcnSaL0TLAV5BCGpPpC2vZaJaa8e2RQxPOv91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoGQbRYs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4f89c6e61so933817f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748720898; x=1749325698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j3FArGsR5iJqpX4BLpg/ioOiqLAxfUjB3oMw9td1rl0=;
        b=eoGQbRYsGCAI8ISlRDzlCOtUHN8W77QOYi8YGlOVofsDTTsCq6ZfJPXFTWauQSxCHD
         RpQsIUsPCkrYRNp5CSxMrlUovdF26Rf8Qh8ILtf2F+duK3VF0tZxCMqWHzjbU0+Wq39H
         Yzevv8A0piDd09eSFO97NJZupPsYgduZZNrzjjSouwB3WL1cYhnWhYL3+dNA5w9zLib4
         7iKEZPs/rggo1/LYaAoZ6qS6GoQkhEbe3kBLkqKy67O7LPkbA/rGYkPPT7MR606zGTHC
         8HR4bqJ+qHCGqsz0Fh2Gox6emxAdj77Q7t9ztJ3lEJ+HR99bslgUSWUW2ncLesL4XP0v
         z18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748720898; x=1749325698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3FArGsR5iJqpX4BLpg/ioOiqLAxfUjB3oMw9td1rl0=;
        b=MEASjDDaWaNZtVfR3F59cpoj0XKvVtWKh8PA8FDdAtuiNSA21X6WKD0QTI2R2Lsd/s
         ZtPrmusRLkvcvtWNGupXKnEdedf3fVDMe9SHXW48D500qgtGw7d/uY0z5MIJTybc+VCU
         YYm32Ed6Z19TQpgthuMRV0rIb52BhP6nhY4PPzJ9fjxoy7ueu0/j7PK2ngfYNLmXYfTJ
         yQ9+kqhRB4OYiFnCfLY9lIUX2suLPUYQPNdTunst/Tj38btPnPDrlv7P26f5BS/Hv7N7
         XJwCBjootAGLWusrOS7uwmur8Ov1TvPmDXrZZVj5Lrloeqd/rJRRwP3ebA5ib6uzphQg
         PciQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYVVIPa+3RpfPch+ZcGoordR3t7BUdKVRpomt4zD48lcIaKe+WmiINi/pUkUPr4BL6oemrz+v6Xd+Xgt//QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1/cpwn7kR7TzeOiQs2uFGyoQ++ZoM2YmFft0zw/OG23zQpI9
	qEILX3nI0wCUEcaH4XlhwyGHDLnJYUrora2u1PqQiLHduauVYI2yl46+9636z9bhLrw=
X-Gm-Gg: ASbGnct2R1yttMeeQQyN1HyjvmcO0wfOCexnx+l4ZKD47rpqNJWCtyvRfT06LaXmKVx
	w2j8y4rSjzerX/dSbLPylSabOmzOFxZePVdAksFEIBxtDG+NDqISG7jKYEwHcAwOKBOC1CLujv4
	/s84rj9eMvyRO7qZeYL/7NQrphekKjs11GFxNU++JcB/BLP/eZ6jtNiUKjLQv1WfT3pWsjPUZOH
	tQiDtOiroD/ejLkWq54lH2h56LE01yRqpm46KtVuD0cSr6dGIOu7HGkbT7rBU/NqV7Y1ZW+0dKS
	NinSnfGBBVQywYDffj15doZFGfi44S4XlB1W6CBjQg9/azvJ7A+Xo1YVDqzOaHu8
X-Google-Smtp-Source: AGHT+IFKg4HuKMsg1f69eAHMSSSHDkbDSmzpp4+fNq3jhEnZ2Nram9OfXMQAUsuQgWOrrMDdXsk7dw==
X-Received: by 2002:a05:6000:2c13:b0:3a4:d994:be7d with SMTP id ffacd0b85a97d-3a4fe17ba55mr2085736f8f.23.1748720898173;
        Sat, 31 May 2025 12:48:18 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:eaf:3101:2d68:caee:7294:3fe1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8b3sm8971974f8f.20.2025.05.31.12.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 12:48:17 -0700 (PDT)
Date: Sat, 31 May 2025 20:48:15 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi: suspend failure, bisected
Message-ID: <aDtc_1OIwh0DH4Kw@debian.local>
References: <aDsNn70jcX6sDLLT@debian.local>
 <DM3PPF63A6024A9CDCDCB068431DD5249FBA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DM3PPF63A6024A9CDCDCB068431DD5249FBA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com>

On Sat, May 31, 2025 at 06:35:33PM +0000, Korenblit, Miriam Rachel wrote:
>=20
>=20
> > -----Original Message-----
> > From: Chris Bainbridge <chris.bainbridge@gmail.com>
> > Sent: Saturday, 31 May 2025 17:10
> > To: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: linux-wireless@vger.kernel.org; kvalo@kernel.org; Korenblit, Miriam
> > Rachel <miriam.rachel.korenblit@intel.com>; Berg, Johannes
> > <johannes.berg@intel.com>; benjamin@sipsolutions.net;
> > regressions@lists.linux.dev
> > Subject: [REGRESSION] iwlwifi: suspend failure, bisected
> >=20
> > Hi,
> >=20
> > There is a recently introduced iwlwifi regression on suspend. It appear=
s the
> > bisected commit was only supposed to fix a warning, but reverting the
> > commit (with a small change for revert conflict) does fix the error.
> >=20
> > 7438843df8cf7a484303caee7540a00f0ef972b2 is the first bad commit
> > Gustavo A. R. Silva <gustavoars@kernel.org>commit
>=20
> Hi Chris, thanks for the report.
> Could you please try the attached patch and see if that solves the issue?

It doesn't look like it made a difference:

[   67.779335] PM: suspend entry (s2idle)
[   68.040688] Filesystems sync: 0.260 seconds
[   68.044182] Freezing user space processes
[   68.047319] Freezing user space processes completed (elapsed 0.003 secon=
ds)
[   68.047367] OOM killer disabled.
[   68.047370] Freezing remaining freezable tasks
[   68.048775] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[   68.048925] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   68.642563] wlp1s0: deauthenticating from d6:92:5e:eb:ee:15 by local cho=
ice (Reason: 3=3DDEAUTH_LEAVING)
[   68.655494] iwlwifi 0000:01:00.0: Microcode SW error detected. Restartin=
g 0x0.
[   68.655747] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   68.655750] iwlwifi 0000:01:00.0: Transport status: 0x0000004B, valid: 6
[   68.655752] iwlwifi 0000:01:00.0: Loaded firmware version: 89.202a2f7b.0=
 ty-a0-gf-a0-89.ucode
[   68.655755] iwlwifi 0000:01:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL =
  =20
[   68.655757] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[   68.655759] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[   68.655760] iwlwifi 0000:01:00.0: 0x004DAD6C | branchlink2
[   68.655762] iwlwifi 0000:01:00.0: 0x000146B2 | interruptlink1
[   68.655763] iwlwifi 0000:01:00.0: 0x000146B2 | interruptlink2
[   68.655764] iwlwifi 0000:01:00.0: 0x00016AD2 | data1
[   68.655766] iwlwifi 0000:01:00.0: 0x00000010 | data2
[   68.655767] iwlwifi 0000:01:00.0: 0x00000000 | data3
[   68.655768] iwlwifi 0000:01:00.0: 0x79C17988 | beacon time
[   68.655770] iwlwifi 0000:01:00.0: 0x6356E654 | tsf low
[   68.655771] iwlwifi 0000:01:00.0: 0x000009FD | tsf hi
[   68.655772] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[   68.655774] iwlwifi 0000:01:00.0: 0x033059C3 | time gp2
[   68.655775] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[   68.655776] iwlwifi 0000:01:00.0: 0x00000059 | uCode version major
[   68.655778] iwlwifi 0000:01:00.0: 0x202A2F7B | uCode version minor
[   68.655779] iwlwifi 0000:01:00.0: 0x00000420 | hw version
[   68.655780] iwlwifi 0000:01:00.0: 0x58C80002 | board version
[   68.655782] iwlwifi 0000:01:00.0: 0x8026FC4E | hcmd
[   68.655783] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[   68.655784] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[   68.655786] iwlwifi 0000:01:00.0: 0x48F04802 | isr2
[   68.655787] iwlwifi 0000:01:00.0: 0x00C0000C | isr3
[   68.655788] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[   68.655789] iwlwifi 0000:01:00.0: 0x00B90103 | last cmd Id
[   68.655791] iwlwifi 0000:01:00.0: 0x00016AD2 | wait_event
[   68.655792] iwlwifi 0000:01:00.0: 0x000000D4 | l2p_control
[   68.655793] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[   68.655795] iwlwifi 0000:01:00.0: 0x00000007 | l2p_mhvalid
[   68.655796] iwlwifi 0000:01:00.0: 0x00000048 | l2p_addr_match
[   68.655797] iwlwifi 0000:01:00.0: 0x00000008 | lmpm_pmg_sel
[   68.655799] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[   68.655800] iwlwifi 0000:01:00.0: 0x0000B810 | flow_handler
[   68.655917] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   68.655918] iwlwifi 0000:01:00.0: Transport status: 0x0000004B, valid: 7
[   68.655920] iwlwifi 0000:01:00.0: 0x2000209A | ADVANCED_SYSASSERT
[   68.655923] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[   68.655924] iwlwifi 0000:01:00.0: 0x804838B2 | umac branchlink2
[   68.655926] iwlwifi 0000:01:00.0: 0xC00814E0 | umac interruptlink1
[   68.655928] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[   68.655929] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data1
[   68.655930] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[   68.655931] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[   68.655932] iwlwifi 0000:01:00.0: 0x00000059 | umac major
[   68.655932] iwlwifi 0000:01:00.0: 0x202A2F7B | umac minor
[   68.655933] iwlwifi 0000:01:00.0: 0x033059BE | frame pointer
[   68.655934] iwlwifi 0000:01:00.0: 0xC0886C20 | stack pointer
[   68.655935] iwlwifi 0000:01:00.0: 0x00C00502 | last host cmd
[   68.655936] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[   68.656032] iwlwifi 0000:01:00.0: IML/ROM dump:
[   68.656032] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[   68.656130] iwlwifi 0000:01:00.0: 0x00008D5F | IML/ROM data1
[   68.656188] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[   68.656260] iwlwifi 0000:01:00.0: Fseq Registers:
[   68.656306] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
[   68.656352] iwlwifi 0000:01:00.0: 0x80440007 | FSEQ_TOP_INIT_VERSION
[   68.656355] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[   68.656358] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[   68.656361] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[   68.656364] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[   68.656367] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[   68.656370] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[   68.656373] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[   68.656378] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[   68.656383] iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   68.656388] iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   68.656391] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   68.656394] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[   68.656397] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
[   68.656400] iwlwifi 0000:01:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[   68.656507] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0x804a5578
[   68.656554] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[   68.656672] iwlwifi 0000:01:00.0: FW error in SYNC CMD TRIGGER_RX_QUEUES=
_NOTIF_CMD
[   68.656687] CPU: 13 UID: 0 PID: 2449 Comm: kworker/u64:38 Not tainted 6.=
15.0-09114-g351e969adca9 #380 PREEMPT(voluntary)=20
[   68.656689] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.17 12/18/2024
[   68.656690] Workqueue: async async_run_entry_fn
[   68.656694] Call Trace:
[   68.656695]  <TASK>
[   68.656697]  dump_stack_lvl+0x6e/0x90
[   68.656702]  iwl_trans_pcie_send_hcmd+0x446/0x450 [iwlwifi]
[   68.656715]  ? prepare_to_wait_exclusive+0xf0/0xf0
[   68.656719]  iwl_trans_send_cmd+0x6c/0x150 [iwlwifi]
[   68.656728]  iwl_mvm_send_cmd+0x2d/0x70 [iwlmvm]
[   68.656738]  iwl_mvm_sync_rx_queues_internal+0x123/0x2e0 [iwlmvm]
[   68.656750]  iwl_mvm_sta_rx_agg+0x30f/0xa60 [iwlmvm]
[   68.656764]  ? iwl_mvm_mac_ampdu_action+0x20c/0x400 [iwlmvm]
[   68.656770]  iwl_mvm_mac_ampdu_action+0x20c/0x400 [iwlmvm]
[   68.656776]  ? lock_is_held_type+0x96/0x100
[   68.656780]  drv_ampdu_action+0x108/0x250 [mac80211]
[   68.656801]  __ieee80211_stop_rx_ba_session+0xde/0x200 [mac80211]
[   68.656822]  ieee80211_sta_tear_down_BA_sessions+0x47/0x150 [mac80211]
[   68.656840]  __sta_info_destroy_part1+0x5c/0x7e0 [mac80211]
[   68.656862]  __sta_info_flush+0x13f/0x280 [mac80211]
[   68.656886]  ieee80211_set_disassoc+0x68b/0x940 [mac80211]
[   68.656918]  ieee80211_mgd_deauth.cold+0x51/0x224 [mac80211]
[   68.656952]  cfg80211_mlme_deauth+0xe4/0x2b0 [cfg80211]
[   68.656987]  cfg80211_mlme_down+0x93/0xd0 [cfg80211]
[   68.657009]  cfg80211_disconnect+0x1b9/0x2a0 [cfg80211]
[   68.657031]  wiphy_suspend+0x22d/0x3d0 [cfg80211]
[   68.659918]  ? wiphy_resume+0x240/0x240 [cfg80211]
[   68.659953]  dpm_run_callback+0x5f/0x1e0
[   68.659958]  device_suspend+0x18d/0x5f0
[   68.659964]  async_suspend+0x1d/0x30
[   68.659966]  async_run_entry_fn+0x2e/0x130
[   68.659970]  process_one_work+0x22b/0x5b0
[   68.659976]  worker_thread+0x1da/0x3d0
[   68.659978]  ? bh_worker+0x260/0x260
[   68.659980]  kthread+0x10a/0x250
[   68.659982]  ? kthreads_online_cpu+0x130/0x130
[   68.659984]  ret_from_fork+0x20c/0x270
[   68.659986]  ? kthreads_online_cpu+0x130/0x130
[   68.659987]  ret_from_fork_asm+0x11/0x20
[   68.659996]  </TASK>
[   68.660026] iwlwifi 0000:01:00.0: Failed to trigger RX queues sync (-5)
[   68.660358] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[   68.661681] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   69.276552] wlp1s0: HW problem - can not stop rx aggregation for d6:92:5=
e:eb:ee:15 tid 3
[   69.276554] iwlwifi 0000:01:00.0: Device error - SW reset
[   69.276559] wlp1s0: HW problem - can not stop rx aggregation for d6:92:5=
e:eb:ee:15 tid 4
[   69.276571] iwlwifi 0000:01:00.0: Failed to trigger RX queues sync (-5)
[   69.276802] ieee80211 phy0: Hardware restart was requested
[   69.276884] iwlwifi 0000:01:00.0: Failed to send flush command (-5)
[   69.276887] iwlwifi 0000:01:00.0: flush request fail
[   69.276901] iwlwifi 0000:01:00.0: Failed to send rate scale config (-5)
[   69.276963] wlp1s0: failed to remove key (0, d6:92:5e:eb:ee:15) from har=
dware (-5)
[   69.276995] iwlwifi 0000:01:00.0: Failed to send flush command (-5)
[   69.277100] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:2): -5
[   69.277104] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:3): -5
[   69.277106] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:1): -5
[   69.277111] iwlwifi 0000:01:00.0: PHY ctxt cmd error. ret=3D-5
[   69.277128] wlp1s0: failed to remove key (1, ff:ff:ff:ff:ff:ff) from har=
dware (-5)
[   69.277172] wlp1s0: failed to remove key (4, ff:ff:ff:ff:ff:ff) from har=
dware (-5)
[   69.277917] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:3): -5
[   69.277919] iwlwifi 0000:01:00.0: Failed to send MAC_CONFIG_CMD (action:=
3): -5
[   69.277924] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (action=
:3): -5
[   69.277925] iwlwifi 0000:01:00.0: Failed to send MAC_CONFIG_CMD (action:=
3): -5
[   69.277929] iwlwifi 0000:01:00.0: LED command failed: -5
[   69.277952] ------------[ cut here ]------------
[   69.277953] WARNING: CPU: 13 PID: 2449 at drivers/net/wireless/intel/iwl=
wifi/mvm/d3.c:3673 iwl_mvm_fast_suspend+0x102/0x110 [iwlmvm]
[   69.277966] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq xt_conn=
track nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf=
_tables br_netfilter bridge stp llc ccm overlay qrtr rfcomm cmac algif_hash=
 algif_skcipher af_alg bnep binfmt_misc snd_acp3x_rn snd_soc_dmic snd_acp3x=
_pdm_dma nls_ascii snd_sof_amd_rembrandt nls_cp437 snd_sof_amd_acp snd_sof_=
pci snd_sof_xtensa_dsp vfat snd_sof snd_ctl_led fat snd_hda_codec_realtek s=
nd_sof_utils snd_hda_codec_generic snd_soc_core iwlmvm snd_hda_codec_hdmi s=
nd_compress snd_hda_scodec_component uvcvideo btusb snd_pci_ps intel_rapl_m=
sr snd_hda_intel snd_soc_acpi_amd_match intel_rapl_common videobuf2_vmalloc=
 snd_usb_audio snd_rpl_pci_acp6x mac80211 btrtl snd_intel_dspcfg videobuf2_=
memops snd_acp_pci kvm_amd btintel snd_usbmidi_lib snd_hda_codec uvc snd_am=
d_acpi_mach libarc4 snd_acp_legacy_common videobuf2_v4l2 btbcm snd_hwdep kv=
m snd_pci_acp6x videodev snd_rawmidi snd_pci_acp5x hp_wmi
[   69.278021]  btmtk snd_hda_core iwlwifi snd_seq_device irqbypass ucsi_ac=
pi snd_rn_pci_acp3x bluetooth videobuf2_common platform_profile ee1004 snd_=
pcm sg snd_acp_config rapl typec_ucsi cfg80211 pcspkr mc sparse_keymap wmi_=
bmof snd_timer snd_soc_acpi sp5100_tco roles snd k10temp watchdog rfkill cc=
p snd_pci_acp3x typec soundcore ac battery acpi_tad amd_pmc serio_raw joyde=
v evdev msr parport_pc ppdev dm_mod lp parport nvme_fabrics efi_pstore conf=
igfs nfnetlink efivarfs ip_tables x_tables autofs4 crc32c_cryptoapi sd_mod =
hid_microsoft ff_memless btrfs blake2b_generic xor raid6_pq uas usb_storage=
 scsi_mod scsi_common r8153_ecm cdc_ether usbnet r8152 mii libphy mdio_bus =
usbhid amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_back=
light_quirks drm_exec drm_suballoc_helper amdxcp drm_buddy gpu_sched hid_mu=
ltitouch hid_generic drm_display_helper nvme xhci_pci drm_kms_helper nvme_c=
ore i2c_hid_acpi xhci_hcd cec ghash_clmulni_intel nvme_keyring i2c_hid amd_=
sfh usbcore rc_core i2c_piix4 video sha512_ssse3 nvme_auth
[   69.278088]  hid usb_common crc16 i2c_smbus fan button wmi drm aesni_int=
el
[   69.278096] CPU: 13 UID: 0 PID: 2449 Comm: kworker/u64:38 Not tainted 6.=
15.0-09114-g351e969adca9 #380 PREEMPT(voluntary)=20
[   69.278098] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.17 12/18/2024
[   69.278099] Workqueue: async async_run_entry_fn
[   69.278104] RIP: 0010:iwl_mvm_fast_suspend+0x102/0x110 [iwlmvm]
[   69.278111] Code: 48 8b 3b 89 c1 48 c7 c2 d0 11 92 c2 31 f6 e8 e5 c3 96 =
ff eb b6 48 8b 3b 89 c1 48 c7 c2 a0 11 92 c2 31 f6 e8 d0 c3 96 ff eb 90 <0f=
> 0b e9 6c ff ff ff e8 52 1a 5e ee 66 90 66 0f 1f 00 0f 1f 44 00
[   69.278112] RSP: 0018:ffffb858061abc90 EFLAGS: 00010282
[   69.278114] RAX: 00000000fffffffb RBX: ffff9dced082b0a8 RCX: 00000000000=
00000
[   69.278115] RDX: 0000000000000000 RSI: ffffb858061abc10 RDI: ffff9dceced=
20028
[   69.278116] RBP: 0000000000000001 R08: 0000000000000001 R09: 00000000000=
00077
[   69.278117] R10: ffffb858061abcd0 R11: 0000000000000005 R12: ffff9dced08=
2b0d8
[   69.278118] R13: ffff9dced082b200 R14: ffff9dced082b1b8 R15: ffff9dced08=
2b0a8
[   69.278119] FS:  0000000000000000(0000) GS:ffff9dd21b7c6000(0000) knlGS:=
0000000000000000
[   69.278120] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.278121] CR2: 00007f26f400e038 CR3: 00000003abe3b000 CR4: 0000000000f=
50ef0
[   69.278122] PKRU: 55555554
[   69.278123] Call Trace:
[   69.278124]  <TASK>
[   69.278127]  __iwl_mvm_mac_stop+0xf4/0x170 [iwlmvm]
[   69.278135]  iwl_mvm_mac_stop+0xe6/0x150 [iwlmvm]
[   69.278143]  drv_stop+0x6e/0x1e0 [mac80211]
[   69.278165]  __ieee80211_suspend+0x38c/0x4e0 [mac80211]
[   69.278189]  wiphy_suspend+0xbf/0x3d0 [cfg80211]
[   69.278212]  ? wiphy_resume+0x240/0x240 [cfg80211]
[   69.278228]  dpm_run_callback+0x5f/0x1e0
[   69.278231]  device_suspend+0x18d/0x5f0
[   69.278235]  async_suspend+0x1d/0x30
[   69.278236]  async_run_entry_fn+0x2e/0x130
[   69.278239]  process_one_work+0x22b/0x5b0
[   69.278244]  worker_thread+0x1da/0x3d0
[   69.278247]  ? bh_worker+0x260/0x260
[   69.278248]  kthread+0x10a/0x250
[   69.278250]  ? kthreads_online_cpu+0x130/0x130
[   69.278253]  ret_from_fork+0x20c/0x270
[   69.278255]  ? kthreads_online_cpu+0x130/0x130
[   69.278256]  ret_from_fork_asm+0x11/0x20
[   69.278263]  </TASK>
[   69.278264] irq event stamp: 3307
[   69.278265] hardirqs last  enabled at (3313): [<ffffffffb01a339e>] __up_=
console_sem+0x5e/0x70
[   69.278268] hardirqs last disabled at (3318): [<ffffffffb01a3383>] __up_=
console_sem+0x43/0x70
[   69.278270] softirqs last  enabled at (1838): [<ffffffffc2687dee>] ieee8=
0211_stop_device+0x1e/0x90 [mac80211]
[   69.278289] softirqs last disabled at (1832): [<ffffffffc2687dee>] ieee8=
0211_stop_device+0x1e/0x90 [mac80211]
[   69.278305] ---[ end trace 0000000000000000 ]---
[   69.278306] iwlwifi 0000:01:00.0: fast suspend: couldn't send D3_CONFIG_=
CMD -5
[   71.288600] iwlwifi 0000:01:00.0: Timeout entering D3
[   71.288615] iwlwifi 0000:01:00.0: fast suspend: trans_d3_suspend failed =
-110
[   71.289046] PM: suspend of devices complete after 2649.981 msecs
[   71.289056] PM: start suspend of devices complete after 3233.752 msecs
[   71.293998] Disabling GPIO #9 interrupt for suspend.
[   71.294615] PM: late suspend of devices complete after 5.547 msecs
[   71.297174] ACPI: EC: interrupt blocked
[   71.327771] PM: noirq suspend of devices complete after 32.591 msecs

