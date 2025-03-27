Return-Path: <linux-wireless+bounces-20869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F485A727CA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 01:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F903BBBE5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 00:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BED748F;
	Thu, 27 Mar 2025 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdLOp+Zw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49514A06
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743035751; cv=none; b=Phpvexwm3kkCxkJ6UP8tf84TuQGUgGPj4IP+zgn4i4SqIpu4Y9KfxpADRjuCx+Rr8yM0OwOsW1Y+kAc7/WJx40tWYeczjC+WPc69WWIZb8dm1Xacqn524ldQ9bYSR+w9SiN05QFS1yH1I26URw2j0MbngaHQDzhuHoxPsTw1OG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743035751; c=relaxed/simple;
	bh=maOkWnHpXi3X1Ya1MkKjQEKbwyCxdOO6JLpbZdMAkdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6QoNPnUPylcSHQieNAetgrU36OHdUIgdXArQMNFAPGlRFfxCHT9boiS3+qKSgfiXvyxa8e02c/SY4WXiYUjoplU+NNYKoIPOXBaKwY8UyDH+2vHXPjvEO3N2YoWdjSx+HYmmVk5MZYlbcafwuGZWuJSwF+xKJ2w3I3u4IPjz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdLOp+Zw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso3925345e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743035748; x=1743640548; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DSz/J7Qx55NXShxiHmdIJQXnXmcrMeZ7NT7cAs0AlSI=;
        b=ZdLOp+ZwTsli6vjnkcd6KV2wUaDPpTyZx998zM3djBsLA1+3EOxoQ5t2o3oZDia72k
         Xk2aI3jgpuvmZ3fKuO3DIv3H6A1Nuk7IxlkEdf2Goqxbddu3oLynoR74VRmPBpBLYeEJ
         NxB4RxZQQA4HZYMF26SYYmX7SDbl8MrCK61PJQQjSXFoQmWPOU6Lbhbmo5X8JGOlreqA
         5SK6H74PdHpkcyUC7nVzBHdvafTA+BfiAJ9iBsMZoFBG4jLRKv7CxPLAHt+QgKevCksR
         r6GYnsU+YQd8vjVZsnC5HKWWUdJ1816YG+1IIQjrKXFG9gB7vdyZGTZf06OVSvNNpkRY
         1X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743035748; x=1743640548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSz/J7Qx55NXShxiHmdIJQXnXmcrMeZ7NT7cAs0AlSI=;
        b=peaJ5dQ/s2H/3qtU6XdDY9RdemNPrQvZsUrfFxDhQPdGabArK50bFGDvbXUR+mook8
         qzgvn9wlAIp6k2KDea5yxD1QOTz6+X3Gf2WCNP/MR4mYMN1CxvKiCa9En0A7xWV45WaB
         UjEAta15ysKWKlIVqBpoZmFpx4kuxz0WcuQ9pycPc/ID1J59knTF5hv7J3nQ7wE+Tx3V
         Ap064Fw6w3uLZM5IT3cISNqdHqbXJ6h/rLzLy33536d8xQiRJKLLFSR4P0X5ne+MbQXU
         YpXAGTplAA6m9CdiVlcZuRKMe9umJQzlZ+RS++Wu2h+Mxgv5TqqwaLZv3WGk7GimLIxv
         UOkg==
X-Gm-Message-State: AOJu0YzYEWo4gy9OAJLZqwGLVgtFQom9IBie8ZjcdF+RDqtC4tYzhUjs
	bZVyzIFKglIgiq6fXiBRhNrYTvAO7aU9mjFUfDWVhq1EWXOCe9l9
X-Gm-Gg: ASbGncvorXAnrEpHcEqbE2K6Or6JnSv3rss62jR58U3No2zPTBLiY4BA9oByAfsaFkM
	OpblBIeY/1iYP0zvxUCbNJCmJYjJRhY8LxglHIgOhGPZRI8gaRvuL/Lw7rcl5cRqFZVivMJPJU4
	qHtUMNKHHrQoJF+gIiHDJz5Sm+VNl01jgPRF8QtVihwDf4YolX713GFvYLlBAZ48DtUeLoYpeWL
	VvqV1fucVljnyr3/ANNe7M4evb/L1WosruwgEnkVTjEX13ll2OZ+mwG9AMvlI5dgLJAWtJQeS6V
	7HZyIOCnpWiL0gNVAc3vAfxeXQuRT8SR3DKIs//4zFDrhHbeO31sB+63
X-Google-Smtp-Source: AGHT+IH85DA0yhZSsMojIpK66snjgEO5Ve73v57TftYQECAIYDVP4wUKiUv+9tx7iRR3yNu69PjhkA==
X-Received: by 2002:a5d:584a:0:b0:391:13d6:c9e5 with SMTP id ffacd0b85a97d-39ad174cd8emr1095133f8f.19.1743035747479;
        Wed, 26 Mar 2025 17:35:47 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:4d4:f101:e41a:977a:f788:910f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efebc2sm19012035e9.21.2025.03.26.17.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 17:35:47 -0700 (PDT)
Date: Thu, 27 Mar 2025 00:35:44 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
Message-ID: <Z-SdYIm_lDvmCcO-@debian.local>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
 <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
 <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
 <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
 <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com>

On Wed, Mar 26, 2025 at 04:36:12PM +0000, Grumbach, Emmanuel wrote:
> We have all the fixes now in 6.13.7.
> If you still have issues there, please report back and I'll try to find
> some time to craft something.

Yes, I still see this in 6.14.0 on every suspend/resume with laptop
Lenovo Legion 7 16ACHg6.

[15383.744448] ------------[ cut here ]------------
[15383.744452] Timeout waiting for hardware access (CSR_GP_CNTRL 0x08040008)
[15383.744491] WARNING: CPU: 6 PID: 857 at drivers/net/wireless/intel/iwlwi=
fi/pcie/trans.c:2460 __iwl_trans_pcie_grab_nic_access+0x2c1/0x320 [iwlwifi]
[15383.744520] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq xt_conn=
track nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf=
_tables br_netfilter bridge stp llc ccm overlay qrtr rfcomm cmac algif_hash=
 algif_skcipher af_alg bnep binfmt_misc snd_hda_codec_realtek snd_hda_codec=
_generic snd_hda_codec_hdmi snd_hda_scodec_component iwlmvm mac80211 intel_=
rapl_msr intel_rapl_common snd_usb_audio btusb snd_hda_intel uvcvideo btrtl=
 snd_usbmidi_lib kvm_amd snd_intel_dspcfg btintel libarc4 videobuf2_vmalloc=
 snd_hda_codec snd_ump btbcm kvm videobuf2_memops btmtk snd_hwdep uvc snd_r=
awmidi iwlwifi snd_hda_core videobuf2_v4l2 snd_seq_device ee1004 videodev r=
apl snd_pcm bluetooth snd_timer wmi_bmof ucsi_acpi pcspkr videobuf2_common =
k10temp sp5100_tco cfg80211 snd typec_ucsi mc ccp soundcore typec joydev in=
put_leds serio_raw mac_hid sch_fq_codel msr parport_pc ppdev lp parport nvm=
e_fabrics efi_pstore nfnetlink dmi_sysfs ip_tables x_tables
[15383.744635]  autofs4 btrfs blake2b_generic xor raid6_pq usbmouse hid_mic=
rosoft ff_memless hid_cmedia r8153_ecm cdc_ether usbnet r8152 mii dm_crypt =
amdgpu nouveau drm_panel_backlight_quirks mxm_wmi drm_suballoc_helper drm_g=
puvm cec i2c_algo_bit rc_core drm_ttm_helper amdxcp ttm nvme drm_buddy drm_=
exec polyval_clmulni nvme_core r8169 video gpu_sched i2c_piix4 uas ahci pol=
yval_generic hid_multitouch ghash_clmulni_intel usb_storage libahci drm_dis=
play_helper i2c_smbus realtek nvme_auth wmi i2c_hid_acpi i2c_hid hid_generi=
c usbkbd usbhid hid aesni_intel crypto_simd cryptd
[15383.744706] CPU: 6 UID: 0 PID: 857 Comm: kworker/u64:3 Not tainted 6.14.=
0-02667-g7ec4dc4e952f #244 PREEMPT(voluntary)=20
[15383.744711] Hardware name: LENOVO 82N6/LNVNB161216, BIOS GKCN65WW 01/16/=
2024
[15383.744713] Workqueue: async async_run_entry_fn
[15383.744720] RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x2c1/0x320 [iwlw=
ifi]
[15383.744741] Code: e9 6f fe ff ff be 02 00 00 00 48 89 df e8 97 f7 ff ff =
eb da 44 89 e6 48 c7 c7 00 0a 8f c5 c6 05 53 4f 16 02 01 e8 ff 2d ab e6 <0f=
> 0b e9 5a ff ff ff 4c 89 e7 e8 e0 ce 4d e7 e9 70 fd ff ff e8 76
[15383.744743] RSP: 0018:ffff88813a25f4a0 EFLAGS: 00010246
[15383.744747] RAX: 0000000000000000 RBX: ffff888137b40028 RCX: 00000000000=
00000
[15383.744750] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[15383.744752] RBP: ffff88813a25f4d0 R08: 0000000000000000 R09: 00000000000=
00000
[15383.744753] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000080=
40008
[15383.744755] R13: ffff888137b41eb0 R14: 0000000000000000 R15: 00000000000=
00011
[15383.744757] FS:  0000000000000000(0000) GS:ffff8886ba03e000(0000) knlGS:=
0000000000000000
[15383.744760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[15383.744762] CR2: 0000000000000000 CR3: 000000063caba000 CR4: 0000000000f=
50ef0
[15383.744764] PKRU: 55555554
[15383.744766] Call Trace:
[15383.744768]  <TASK>
[15383.744770]  ? show_regs.cold+0x19/0x1e
[15383.744776]  ? __warn.cold+0x60/0x230
[15383.744780]  ? __iwl_trans_pcie_grab_nic_access+0x2c1/0x320 [iwlwifi]
[15383.744798]  ? report_bug+0x211/0x2e0
[15383.744803]  ? __iwl_trans_pcie_grab_nic_access+0x2c1/0x320 [iwlwifi]
[15383.744821]  ? handle_bug+0x1cd/0x2a0
[15383.744825]  ? exc_invalid_op+0x18/0x50
[15383.744828]  ? asm_exc_invalid_op+0x1b/0x20
[15383.744833]  ? __iwl_trans_pcie_grab_nic_access+0x2c1/0x320 [iwlwifi]
[15383.744851]  ? iwl_trans_pcie_grab_nic_access+0x1b/0x50 [iwlwifi]
[15383.744869]  iwl_trans_pcie_grab_nic_access+0x2b/0x50 [iwlwifi]
[15383.744887]  _iwl_trans_grab_nic_access+0xe/0x20 [iwlwifi]
[15383.744907]  iwl_trans_pcie_read_mem+0xb9/0x240 [iwlwifi]
[15383.744926]  ? iwl_trans_pcie_release_nic_access+0x190/0x190 [iwlwifi]
[15383.744944]  ? trace_hardirqs_on+0x4f/0x60
[15383.744950]  iwl_trans_read_mem+0xe/0x20 [iwlwifi]
[15383.744968]  iwl_fwrt_read_err_table+0xe2/0x160 [iwlwifi]
[15383.744989]  ? iwl_fwrt_dump_fseq_regs+0x280/0x280 [iwlwifi]
[15383.745009]  iwl_mvm_check_rt_status+0xe4/0x2f0 [iwlmvm]
[15383.745036]  ? iwl_mvm_d3_disconnect_iter+0x60/0x60 [iwlmvm]
[15383.745054]  ? __kasan_check_read+0x11/0x20
[15383.745059]  ? iwl_fw_dbg_read_d3_debug_data+0x1b6/0x620 [iwlwifi]
[15383.745082]  iwl_mvm_fast_resume+0x18c/0x4f6 [iwlmvm]
[15383.745101]  ? iwl_mvm_fast_suspend+0x330/0x330 [iwlmvm]
[15383.745119]  ? write_profile+0x100/0x100
[15383.745124]  __iwl_mvm_mac_start+0x1d0/0x8d0 [iwlmvm]
[15383.745151]  iwl_mvm_mac_start+0xff/0x360 [iwlmvm]
[15383.745175]  drv_start+0x164/0x370 [mac80211]
[15383.745238]  ieee80211_reconfig+0x354/0x54d0 [mac80211]
[15383.745301]  ? trace_contention_end+0xd2/0x120
[15383.745305]  ? __mutex_lock+0x44f/0x15b0
[15383.745310]  ? wiphy_resume+0x8d/0x450 [cfg80211]
[15383.745367]  ? ieee80211_stop_device+0x120/0x120 [mac80211]
[15383.745424]  ? ww_mutex_lock+0x160/0x160
[15383.745427]  ? __kasan_check_write+0x14/0x20
[15383.745431]  ? do_raw_spin_lock+0x12e/0x280
[15383.745436]  ? cfg80211_bss_age+0x9a/0xd0 [cfg80211]
[15383.745498]  ? trace_hardirqs_on+0x4f/0x60
[15383.745501]  ? __local_bh_enable_ip+0xb1/0x140
[15383.745506]  ieee80211_resume+0xfb/0x170 [mac80211]
[15383.745565]  wiphy_resume+0x1a1/0x450 [cfg80211]
[15383.745632]  ? trace_device_pm_callback_start+0xfc/0x150
[15383.745636]  ? trace_rdev_return_int+0x150/0x150 [cfg80211]
[15383.745682]  dpm_run_callback+0x11d/0x230
[15383.745685]  ? dpm_wait_for_superior+0x440/0x440
[15383.745688]  ? pm_verb+0xb0/0xb0
[15383.745693]  device_resume+0x2f6/0x800
[15383.745696]  async_resume+0x1d/0x40
[15383.745699]  async_run_entry_fn+0x95/0x440
[15383.745704]  process_one_work+0x860/0x1510
[15383.745707]  ? .slowpath+0x1b/0x1b
[15383.745711]  ? pwq_dec_nr_in_flight+0xe60/0xe60
[15383.745715]  ? assign_work+0x16b/0x280
[15383.745718]  worker_thread+0x5c0/0xfa0
[15383.745723]  ? process_one_work+0x1510/0x1510
[15383.745726]  kthread+0x3a1/0x840
[15383.745729]  ? kthread_is_per_cpu+0xd0/0xd0
[15383.745731]  ? trace_hardirqs_on+0x4f/0x60
[15383.745735]  ? _raw_spin_unlock_irq+0x27/0x60
[15383.745738]  ? calculate_sigpending+0x77/0xa0
[15383.745742]  ? kthread_is_per_cpu+0xd0/0xd0
[15383.745745]  ret_from_fork+0x40/0x90
[15383.745748]  ? kthread_is_per_cpu+0xd0/0xd0
[15383.745750]  ret_from_fork_asm+0x11/0x20
[15383.745756]  </TASK>
[15383.745758] irq event stamp: 173474
[15383.745760] hardirqs last  enabled at (173473): [<ffffffffad1c9f37>] _ra=
w_spin_unlock_irq+0x27/0x60
[15383.745764] hardirqs last disabled at (173474): [<ffffffffad1ad891>] __s=
chedule+0x2d61/0x5d50
[15383.745768] softirqs last  enabled at (173092): [<ffffffffaa0c888f>] ker=
nel_fpu_end+0x4f/0x70
[15383.745771] softirqs last disabled at (173090): [<ffffffffaa0c9c6d>] ker=
nel_fpu_begin_mask+0x14d/0x1f0
[15383.745774] ---[ end trace 0000000000000000 ]---
[15383.745782] iwlwifi 0000:04:00.0: iwlwifi transaction failed, dumping re=
gisters
[15383.745786] iwlwifi 0000:04:00.0: iwlwifi device config registers:
[15383.745903] iwlwifi 0000:04:00.0: 00000000: 27238086 00100406 0280001a 0=
0000010 d1600004 00000000 00000000 00000000
[15383.745907] iwlwifi 0000:04:00.0: 00000020: 00000000 00000000 00000000 1=
6541a56 00000000 000000c8 00000000 000001ff
[15383.745910] iwlwifi 0000:04:00.0: 00000040: 00028010 10008ec0 00100c1f 0=
445e812 10120142 00000000 00000000 00000000
[15383.745912] iwlwifi 0000:04:00.0: 00000060: 00000000 00080812 00000405 0=
0000006 00000002 00000000 00000000 00000000
[15383.745915] iwlwifi 0000:04:00.0: 00000080: 800f0011 00002000 00003000 0=
0000000 00000000 00000000 00000000 00000000
[15383.745917] iwlwifi 0000:04:00.0: 000000a0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.745920] iwlwifi 0000:04:00.0: 000000c0: 00000000 00000000 c823d001 0=
d000008 00804005 00000000 00000000 00000000
[15383.745923] iwlwifi 0000:04:00.0: 000000e0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.745925] iwlwifi 0000:04:00.0: 00000100: 14c10001 00000000 00000000 0=
0462031 00000000 00002000 00000000 00000000
[15383.745928] iwlwifi 0000:04:00.0: 00000120: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.745931] iwlwifi 0000:04:00.0: 00000140: 14c00000 ff000000 000000ff 1=
5410018 10011001 0001001e 00481e1f 60010000
[15383.745933] iwlwifi 0000:04:00.0: iwlwifi device memory mapped registers:
[15383.745967] iwlwifi 0000:04:00.0: 00000000: 00880000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.745970] iwlwifi 0000:04:00.0: 00000020: 00000011 08040008 00000340 d=
55555d5 d55555d5 d55555d5 80008040 001f0042
[15383.745987] iwlwifi 0000:04:00.0: iwlwifi device AER capability structur=
e:
[15383.746017] iwlwifi 0000:04:00.0: 00000000: 14c10001 00000000 00000000 0=
0462031 00000000 00002000 00000000 00000000
[15383.746019] iwlwifi 0000:04:00.0: 00000020: 00000000 00000000 00000000
[15383.746022] iwlwifi 0000:04:00.0: iwlwifi parent port (0000:00:02.2) con=
fig registers:
[15383.746076] iwlwifi 0000:00:02.2: 00000000: 16341022 00100407 06040000 0=
0810010 00000000 00000000 00040400 000001f1
[15383.746079] iwlwifi 0000:00:02.2: 00000020: d160d160 0001fff1 00000000 0=
0000000 00000000 00000050 00000000 000200ff
[15383.746082] iwlwifi 0000:00:02.2: 00000040: 00000000 00000000 00000000 0=
0000000 c8035801 00000000 0142a010 00008022
[15383.746084] iwlwifi 0000:00:02.2: 00000060: 00002910 04737813 30120c42 0=
0042580 01400000 00010018 00000000 007019bf
[15383.746087] iwlwifi 0000:00:02.2: 00000080: 00000406 0000000e 00010003 0=
0000000 00000000 00000000 00000000 00000000
[15383.746090] iwlwifi 0000:00:02.2: 000000a0: 0081c005 fee00000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746092] iwlwifi 0000:00:02.2: 000000c0: 0000c80d 388617aa a8030008 0=
0000000 00000000 00000000 00000000 00000000
[15383.746095] iwlwifi 0000:00:02.2: 000000e0: 00000000 0006a07c 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746097] iwlwifi 0000:00:02.2: 00000100: 2701000b 01010001 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746100] iwlwifi 0000:00:02.2: 00000120: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746103] iwlwifi 0000:00:02.2: 00000140: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746105] iwlwifi 0000:00:02.2: 00000160: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746108] iwlwifi 0000:00:02.2: 00000180: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746111] iwlwifi 0000:00:02.2: 000001a0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746113] iwlwifi 0000:00:02.2: 000001c0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746116] iwlwifi 0000:00:02.2: 000001e0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[15383.746118] iwlwifi 0000:00:02.2: 00000200: 00000000 00000000 00000000
[15383.746126] iwlwifi 0000:04:00.0: iwl_mvm_check_rt_status failed, device=
 is gone during suspend
[15383.783676] iwlwifi 0000:04:00.0: HW error, resetting before reading
[15383.791947] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[15383.791950] iwlwifi 0000:04:00.0: Transport status: 0x00000042, valid: -=
796211154
[15383.791954] iwlwifi 0000:04:00.0: Loaded firmware version: 77.85be44d3.0=
 cc-a0-77.ucode
[15383.791957] iwlwifi 0000:04:00.0: 0x1B28316F | ADVANCED_SYSASSERT       =
  =20
[15383.791960] iwlwifi 0000:04:00.0: 0x07CB5057 | trm_hw_status0
[15383.791963] iwlwifi 0000:04:00.0: 0x2A1DCDE0 | trm_hw_status1
[15383.791966] iwlwifi 0000:04:00.0: 0xD22C0130 | branchlink2
[15383.791968] iwlwifi 0000:04:00.0: 0x9A73E879 | interruptlink1
[15383.791971] iwlwifi 0000:04:00.0: 0x7F7775FC | interruptlink2
[15383.791973] iwlwifi 0000:04:00.0: 0x7FDBD77F | data1
[15383.791976] iwlwifi 0000:04:00.0: 0xBDFDE763 | data2
[15383.791979] iwlwifi 0000:04:00.0: 0xFDC7CAEF | data3
[15383.791981] iwlwifi 0000:04:00.0: 0xBF8FAF9D | beacon time
[15383.791984] iwlwifi 0000:04:00.0: 0xF3FCAFB3 | tsf low
[15383.791986] iwlwifi 0000:04:00.0: 0xB7FA4DD2 | tsf hi
[15383.791989] iwlwifi 0000:04:00.0: 0xF3EE5BFC | time gp1
[15383.791991] iwlwifi 0000:04:00.0: 0xFA797F39 | time gp2
[15383.791994] iwlwifi 0000:04:00.0: 0xFEF8E6EF | uCode revision type
[15383.791997] iwlwifi 0000:04:00.0: 0x7BADF3CB | uCode version major
[15383.791999] iwlwifi 0000:04:00.0: 0xFFDA66A7 | uCode version minor
[15383.792002] iwlwifi 0000:04:00.0: 0xFBFAFE7E | hw version
[15383.792004] iwlwifi 0000:04:00.0: 0xDDCB7727 | board version
[15383.792007] iwlwifi 0000:04:00.0: 0x5BFF3DFD | hcmd
[15383.792010] iwlwifi 0000:04:00.0: 0xFFFDE56F | isr0
[15383.792012] iwlwifi 0000:04:00.0: 0xD83727DC | isr1
[15383.792015] iwlwifi 0000:04:00.0: 0xAC3B77BF | isr2
[15383.792017] iwlwifi 0000:04:00.0: 0x1C7E63B1 | isr3
[15383.792020] iwlwifi 0000:04:00.0: 0x93383FFF | isr4
[15383.792022] iwlwifi 0000:04:00.0: 0x6BF7DEFC | last cmd Id
[15383.792025] iwlwifi 0000:04:00.0: 0xCE6FEDC6 | wait_event
[15383.792028] iwlwifi 0000:04:00.0: 0x75FF7EBF | l2p_control
[15383.792030] iwlwifi 0000:04:00.0: 0xF7AFFA7E | l2p_duration
[15383.792033] iwlwifi 0000:04:00.0: 0x99FFE5E9 | l2p_mhvalid
[15383.792035] iwlwifi 0000:04:00.0: 0x6CFFFEE7 | l2p_addr_match
[15383.792038] iwlwifi 0000:04:00.0: 0x89EE5751 | lmpm_pmg_sel
[15383.792040] iwlwifi 0000:04:00.0: 0xF77DF97C | timestamp
[15383.792043] iwlwifi 0000:04:00.0: 0xF3F7BDFF | flow_handler
[15383.792102] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[15383.792105] iwlwifi 0000:04:00.0: Transport status: 0x00000042, valid: 2=
097381227
[15383.792108] iwlwifi 0000:04:00.0: 0x49298241 | ADVANCED_SYSASSERT
[15383.792111] iwlwifi 0000:04:00.0: 0x539EF45C | umac branchlink1
[15383.792114] iwlwifi 0000:04:00.0: 0x0D61894C | umac branchlink2
[15383.792116] iwlwifi 0000:04:00.0: 0xBDD65FAF | umac interruptlink1
[15383.792119] iwlwifi 0000:04:00.0: 0x0B452D49 | umac interruptlink2
[15383.792122] iwlwifi 0000:04:00.0: 0x5DFDDFB8 | umac data1
[15383.792124] iwlwifi 0000:04:00.0: 0x142DF604 | umac data2
[15383.792127] iwlwifi 0000:04:00.0: 0xFAFA7F24 | umac data3
[15383.792129] iwlwifi 0000:04:00.0: 0x860B40B6 | umac major
[15383.792132] iwlwifi 0000:04:00.0: 0xD3FEAFAC | umac minor
[15383.792134] iwlwifi 0000:04:00.0: 0x50A92A11 | frame pointer
[15383.792137] iwlwifi 0000:04:00.0: 0x93554FFB | stack pointer
[15383.792139] iwlwifi 0000:04:00.0: 0xE8574491 | last host cmd
[15383.792142] iwlwifi 0000:04:00.0: 0xDDFA1DF7 | isr status reg
[15383.792183] iwlwifi 0000:04:00.0: IML/ROM dump:
[15383.792185] iwlwifi 0000:04:00.0: 0x00000000 | IML/ROM error/state
[15383.792226] iwlwifi 0000:04:00.0: 0x00000000 | IML/ROM data1
[15383.792269] iwlwifi 0000:04:00.0: 0x00000000 | IML/ROM WFPM_AUTH_KEY_0
[15383.792309] iwlwifi 0000:04:00.0: Fseq Registers:
[15383.792359] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_ERROR_CODE
[15383.792425] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_TOP_INIT_VERSION
[15383.792490] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_CNVIO_INIT_VERSION
[15383.792555] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_OTP_VERSION
[15383.792619] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_TOP_CONTENT_VERSION
[15383.792684] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_ALIVE_TOKEN
[15383.792749] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_CNVI_ID
[15383.792813] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_CNVR_ID
[15383.792878] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | CNVI_AUX_MISC_CHIP
[15383.792943] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | CNVR_AUX_MISC_CHIP
[15383.793007] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[15383.793072] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[15383.793137] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[15383.793201] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_WIFI_FSEQ_VERSION
[15383.793266] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_BT_FSEQ_VERSION
[15383.793331] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_CLASS_TP_VERSION
[15383.793402] iwlwifi 0000:04:00.0: UMAC CURRENT PC: 0xa5a5a5a2
[15383.793467] iwlwifi 0000:04:00.0: LMAC1 CURRENT PC: 0xa5a5a5a2
[15383.793473] iwlwifi 0000:04:00.0: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).

