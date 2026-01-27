Return-Path: <linux-wireless+bounces-31223-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEQKIfateGlasAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31223-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 13:22:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B37943EC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 13:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A67383018C10
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FF134CFAF;
	Tue, 27 Jan 2026 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTAEpuSp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925834C990
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516527; cv=none; b=pd2axMs/gBsHRL3T8ij5PEOVQarlhiGwYyqg58gEqHi15sHPozNk4Xy3a1V/9TzCHkJBNVeJKHQD5w/qBsLUEvw9i4LIJROEd+XqPJItDYoti74lqkgVDQuDiAtxyXq7BjZsC0SQCf2zDBviiszfJ1+Qm/+qzl6KUwFCyUsLUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516527; c=relaxed/simple;
	bh=1V0xXOfv91TAi3nFP6S49hHSBV0gjCwwsNRea6ynl2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbtzYkZMGRjYjm2bbJZafGurOA+jWYW0TvgfF8zO7eUic8IbEAwYxLn+cvUx8VWdnn0MYAHiJrcWUBprt+6q6KE2eoxi869bbfWcBhSxY7o2qNMacm8CjDB6DxU6Sym9EAsuY/1qbJjuWcbSlI15As3ng3ijZTT8pIoFJ69a30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTAEpuSp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806bf03573so1405545e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 04:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769516523; x=1770121323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwkK39zENXrNnMu7mgbNCwmzsc2dsQCUEvVaxr/ga3A=;
        b=JTAEpuSpCOiNUcQ+zwD/7/9yQ4K8XW4z2SztAaT2Wh2kwtiCw1pOxS8vakSVv4pFkM
         MOoiSHagvVnGFk/qoLR/RCCv+pe3jz3EuFKznRIhZ1uOIR7E39Nvb/FNFZjegPMKtCUj
         0JE1ru25OYWuph0OEszyJB0fKKjdCTv63jMyELQNLA5R8ctlaMNuTFdaSA2rddu52d7Q
         Xnw+K+BeALPRsEBIlbK8j3Rqz2rCJC9/7w+EBdTvGv/jNNhfD6AY7/ty97NU479GWvjD
         y1V8OqE1WjI7VzwKpMhAgT6wfv+7rE6Vt9PdzIFjMZ30JP3LqQc7N0O587A7OI3LXRrh
         OzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769516523; x=1770121323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwkK39zENXrNnMu7mgbNCwmzsc2dsQCUEvVaxr/ga3A=;
        b=wduh7ZeznSM9ag9JX2g8KD8ATCW5cNC7xgk5tOzQv/2F7ky3hgGXOTSrCd+fIaWjJE
         bRQrh6FlLoTZv4kDapDqYJ8stUBh9HOIFO7dv/577kXBIIBuIiBm9ION9qeYxzutKDWl
         APlX86rXqDbJMSO2NisbcPiLvdNS7rUsOCYt81D9BfXE7FnDC8nUgQabU/GD6I/DG+No
         WNdTtoVwPtME+ksFybeL1vDnmKwgA7obvIT4/6+emguk6+z7o2DcXXgz8HOcmUUa9oOM
         mP2DLWAyaMF52i6a17gCVZKQyl+nFwP8R1GFf3CqbkzE+JfrkBqdTOWKu5PcbDW6oZ3/
         P9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWpTPbk/xyysw5s2LowprdvGykA40O5L6HMK0bgcDep6zk8fNjT1m5SW7/nfdv1PWLiX1Yo9atNtAW/dUAb5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBOlUdMbkwGX4yRLZY7SUFBEF3PTkxsPOsfvQ6WDcZnRSLw6L
	1TeZyXJ6xv5N9wZ0Knka4k9LIqM17sB6flzu9vn/uDjh1Sdq252wA52k
X-Gm-Gg: AZuq6aK+Y11L6kUWRnv/qGSJMkv8NWi2pNDVV9NuquIafBxqKCn5iTyGSJIGgW7DbBO
	tUJ3rWXoHiTZTCYZjWx5H/KQHPp6EJ1Jf18z0iARUnI1t7PMDJFe7DZ+sZvsWLSROHwQWe69kW4
	c6byyvP1zLMUM9PSqIaZRU2vxg2CrqzKDfRJ8xoVP1Tgh2ZXuVNbbguIuRUn+IE9BIAS9X+EHz5
	x8z6hgffzHuYDBlIFiPT7uCelyRVdSX9Td6WV5wcelSxJXCOcPYP93DAEGJxI3vVYKAq1E26u8x
	NrwwA9CHV+CIk3Bobp6LT5QnUeSjW1ZUz7frVem01AjlILJiNI723kUmFi1U2ag4R4N03QyfFJW
	pHVH4aq7T16F2gxuqKxZzMfk0yvK/fBDfY5bGDMHWMGBe01nC0QzyJviWvcAFg10y5ejKsGmrau
	63LbOpbPfoZLpGTukdpeblo40=
X-Received: by 2002:a05:600c:1f88:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-48069c39a00mr21417355e9.13.1769516522462;
        Tue, 27 Jan 2026 04:22:02 -0800 (PST)
Received: from debian.local ([2a0a:ef40:e94:5d01:a218:5589:9f9c:4f52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e71503sm41882744f8f.25.2026.01.27.04.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:22:02 -0800 (PST)
Date: Tue, 27 Jan 2026 12:21:59 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Message-ID: <aXit5795WQLL290t@debian.local>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local>
 <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
 <DM3PPF63A6024A9FCE1CF29C0492A406E7AA390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DM3PPF63A6024A9FCE1CF29C0492A406E7AA390A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31223-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41B37943EC
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 05:05:31AM +0000, Korenblit, Miriam Rachel wrote:
>=20
> Just making sure: have you been able to reproduce the assert (ADVANCED_SY=
SASSERT in the log), and then the panic didn't happen?

Yes, the ADVANCED_SYSASSERT was logged but there was no subsequent null poi=
nter
dereference.

> If yes, please test the attached patch, which is supposed to fix the asse=
rt itself. With this, you are not even supposed to see an assert.

I ran this through 15 suspend/resume cycles with network traffic. The
ADVANCED_SYSASSERT did not occur, so it looks like the patch does fix
the SYSASSERT. There was a warning logged once out of the 15 cycles:

[  454.184873] ------------[ cut here ]------------
[  454.184894] WR pointer moved while flushing 216 -> 239
[  454.184898] WARNING: drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tran=
s.c:2570 at iwl_trans_pcie_wait_txq_empty+0x4f7/0x6d0 [iwlwifi], CPU#9: kwo=
rker/u64:38/4331
[  454.184927] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq xt_conn=
track nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat x_=
tables nf_tables br_netfilter bridge stp llc ccm overlay qrtr rfcomm cmac a=
lgif_hash algif_skcipher af_alg bnep binfmt_misc ext4 mbcache jbd2 nls_asci=
i nls_cp437 vfat fat snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn snd_hda_co=
dec_generic snd_soc_core intel_rapl_msr snd_compress amd_atl intel_rapl_com=
mon snd_hda_codec_hdmi iwlmvm mac80211 snd_hda_intel libarc4 snd_usb_audio =
uvcvideo kvm_amd snd_hda_codec snd_pci_acp6x btusb videobuf2_vmalloc snd_us=
bmidi_lib snd_intel_dspcfg snd_pci_acp5x btrtl videobuf2_memops snd_rawmidi=
 snd_hwdep btintel kvm btbcm uvc snd_seq_device snd_hda_core btmtk irqbypas=
s videobuf2_v4l2 snd_rn_pci_acp3x iwlwifi snd_pcm rapl videodev snd_acp_con=
fig bluetooth pcspkr cfg80211 snd_soc_acpi snd_timer wmi_bmof ecdh_generic =
videobuf2_common ee1004 ecc k10temp snd_pci_acp3x mc snd
[  454.185174]  rfkill soundcore ccp ac battery sg button amd_pmc acpi_tad =
joydev evdev msr parport_pc ppdev lp parport nvme_fabrics fuse efi_pstore c=
onfigfs nfnetlink efivarfs autofs4 crc32c_cryptoapi btrfs blake2b libblake2=
b xor raid6_pq dm_crypt hid_microsoft ff_memless hid_cmedia r8153_ecm cdc_e=
ther usbnet dm_mod r8152 mii libphy mdio_bus sd_mod uas usb_storage scsi_mo=
d usbhid scsi_common amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm =
drm_exec drm_suballoc_helper drm_buddy drm_panel_backlight_quirks gpu_sched=
 amdxcp hid_multitouch drm_display_helper ucsi_acpi hid_generic typec_ucsi =
drm_kms_helper roles xhci_pci sp5100_tco video xhci_hcd typec cec i2c_hid_a=
cpi watchdog i2c_hid amd_sfh ghash_clmulni_intel serio_raw rc_core usbcore =
nvme thunderbolt hid i2c_piix4 crc16 i2c_smbus nvme_core fan usb_common drm=
 wmi aesni_intel
[  454.185402] CPU: 9 UID: 0 PID: 4331 Comm: kworker/u64:38 Not tainted 6.1=
9.0-rc6-00341-gf1d1ad131417 #406 PREEMPT(voluntary)
[  454.185408] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.17 12/18/2024
[  454.185412] Workqueue: async async_run_entry_fn
[  454.185423] RIP: 0010:iwl_trans_pcie_wait_txq_empty+0x4fe/0x6d0 [iwlwifi]
[  454.185446] Code: 48 c7 04 03 00 00 00 00 48 81 c4 88 00 00 00 89 d0 5b =
5d 41 5c 41 5d 41 5e 41 5f c3 48 8d 3d 99 65 09 00 0f b6 d3 40 0f b6 f6 <67=
> 48 0f b9 3a ba 92 ff ff ff eb bb 48 89 c7 e8 8e 7a 05 de e9 4e
[  454.185450] RSP: 0018:ffff888110abf488 EFLAGS: 00010297
[  454.185456] RAX: fffffbfff4a42250 RBX: 00000000000033ef RCX: 00000000000=
00006
[  454.185460] RDX: 00000000000000ef RSI: 00000000000000d8 RDI: ffffffffc4c=
207b0
[  454.185464] RBP: dffffc0000000000 R08: 0000000000000001 R09: 00000000000=
00000
[  454.185468] R10: 000000000000335f R11: 0000000000000006 R12: ffffed102c4=
293b0
[  454.185471] R13: ffff888162149c00 R14: ffff888162149d80 R15: ffff8881621=
49d00
[  454.185475] FS:  0000000000000000(0000) GS:ffff8883e3d30000(0000) knlGS:=
0000000000000000
[  454.185479] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  454.185483] CR2: 00007ff3d9400000 CR3: 00000002b9b2d000 CR4: 00000000007=
50ef0
[  454.185487] PKRU: 55555554
[  454.185490] Call Trace:
[  454.185494]  <TASK>
[  454.185506]  ? iwl_trans_pcie_rxq_dma_data+0x220/0x220 [iwlwifi]
[  454.185530]  ? __local_bh_enable_ip+0xab/0x130
[  454.185540]  iwl_mvm_wait_sta_queues_empty+0x8c/0xd0 [iwlmvm]
[  454.185568]  iwl_mvm_mac_flush+0x668/0xd20 [iwlmvm]
[  454.185591]  ? lock_is_held_type+0xd5/0x130
[  454.185602]  __ieee80211_flush_queues+0x3cd/0x7c0 [mac80211]
[  454.185679]  ieee80211_set_disassoc+0x123f/0x1ac0 [mac80211]
[  454.185752]  ? ieee80211_powersave_allowed+0x360/0x360 [mac80211]
[  454.185818]  ? unwind_next_frame+0x2e2/0x1ea0
[  454.185830]  ieee80211_mgd_deauth.cold+0xa3/0x71e [mac80211]
[  454.185900]  ? __lock_acquire+0x459/0x2170
[  454.185908]  ? ieee80211_mgd_assoc+0x4ae0/0x4ae0 [mac80211]
[  454.185988]  ? lock_is_held_type+0xd5/0x130
[  454.185999]  cfg80211_mlme_deauth+0x33b/0x890 [cfg80211]
[  454.186080]  ? cfg80211_mlme_assoc+0xa50/0xa50 [cfg80211]
[  454.186164]  cfg80211_mlme_down+0x17a/0x240 [cfg80211]
[  454.186236]  ? cfg80211_mlme_disassoc+0x540/0x540 [cfg80211]
[  454.186315]  cfg80211_disconnect+0x50f/0x800 [cfg80211]
[  454.186393]  wiphy_suspend+0x1f8/0x350 [cfg80211]
[  454.186472]  ? rdev_suspend+0x2a0/0x2a0 [cfg80211]
[  454.186544]  dpm_run_callback+0xfc/0x410
[  454.186554]  ? dpm_async_suspend_superior+0x2e0/0x2e0
[  454.186561]  ? pm_verb+0x90/0x90
[  454.186566]  ? _raw_spin_unlock_irqrestore+0x48/0x60
[  454.186578]  device_suspend+0x37b/0x1080
[  454.186587]  ? async_suspend_late+0x30/0x30
[  454.186594]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
[  454.186601]  ? lockdep_hardirqs_on+0x78/0x100
[  454.186612]  ? device_suspend+0x1080/0x1080
[  454.186616]  async_suspend+0x19/0x30
[  454.186622]  async_run_entry_fn+0x93/0x500
[  454.186633]  process_one_work+0x849/0x1420
[  454.186651]  ? pwq_dec_nr_in_flight+0xe00/0xe00
[  454.186665]  ? assign_work+0x168/0x240
[  454.186670]  ? lock_is_held_type+0xd5/0x130
[  454.186679]  worker_thread+0x5ef/0xfd0
[  454.186697]  ? process_one_work+0x1420/0x1420
[  454.186701]  kthread+0x3ad/0x760
[  454.186709]  ? kthread_is_per_cpu+0xb0/0xb0
[  454.186713]  ? ret_from_fork+0x71/0x800
[  454.186719]  ? ret_from_fork+0x71/0x800
[  454.186725]  ? _raw_spin_unlock_irq+0x24/0x50
[  454.186732]  ? kthread_is_per_cpu+0xb0/0xb0
[  454.186739]  ret_from_fork+0x54a/0x800
[  454.186746]  ? exit_thread+0x70/0x70
[  454.186754]  ? __switch_to+0x36f/0xd60
[  454.186761]  ? kthread_is_per_cpu+0xb0/0xb0
[  454.186768]  ret_from_fork_asm+0x11/0x20
[  454.186789]  </TASK>
[  454.186792] irq event stamp: 1499703
[  454.186795] hardirqs last  enabled at (1499709): [<ffffffffa241cdee>] __=
up_console_sem+0x5e/0x70
[  454.186802] hardirqs last disabled at (1499714): [<ffffffffa241cdd3>] __=
up_console_sem+0x43/0x70
[  454.186808] softirqs last  enabled at (1498148): [<ffffffffc4b8a152>] iw=
l_trans_pcie_wait_txq_empty+0x432/0x6d0 [iwlwifi]
[  454.186831] softirqs last disabled at (1498146): [<ffffffffc4b8a00f>] iw=
l_trans_pcie_wait_txq_empty+0x2ef/0x6d0 [iwlwifi]
[  454.186852] ---[ end trace 0000000000000000 ]---

I think that this is probably a different bug though - checking previous
logs with journalctl, I see the same warning occurred once with
6.17.0-06871-gf79e772258df which predates the "remove STATUS_SUSPENDED"
commit.

