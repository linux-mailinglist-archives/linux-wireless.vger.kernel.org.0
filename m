Return-Path: <linux-wireless+bounces-17722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4D9A16557
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 03:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D41164FE7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573442A9D;
	Mon, 20 Jan 2025 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwut160I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC746426;
	Mon, 20 Jan 2025 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737339874; cv=none; b=hvq5ujgOOZuQFkt0byumkZnVokVEpos33R49pCXZeAwn/N40Op8+kl+VNtHl5MVnvvxqGliDRd3j1DUyVpTo4DWYvQRBfeToHC2xw/YI/hGmNC2f1ozGUcQEcUzCIc9cYNrSqNJWkJSp7wG3bnFyZFQMx0y4N2w9/dae8jg1b7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737339874; c=relaxed/simple;
	bh=apiRDRIxUo5XOiecLfW0Fy3ODbgPrCwiyGMbHnKm/F4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=WCSjX25BGNy8ESZQ1kHraye6xSRQYIDHp5UigTs8EU7Nj//688U4ZbwJrW9iR+PdLt4jxYBTLiafQoo1ciYbEhyB37T3HnM87ULLMdGHMk6UG+CoUB0A1O3dvCejg6IhLrwbxYkk/NeKv2a3bn5AOWn1yX8F3qy1TeIcV5OhKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwut160I; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be6fdeee35so228582985a.1;
        Sun, 19 Jan 2025 18:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737339872; x=1737944672; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J9ZWe8HvrjHUq6KMvkIr3ITCXLGdt7dy5Uw4QDQYtMQ=;
        b=gwut160I2+jpDw52S4JjrzaFDe46BqY1a9edhlk1eVnSNqlM3uhYXrug0MhRX8pHjp
         o73zgH5fHyt8AoV/aLyM6wH7tW2ADJEKht0BFQzIws03J2ImzrfVB9djL5DOFHr2NUFP
         e6jqN8rfNWS1x5+sxlABxaArxSvQLEif4hGaDCzpdYu9dqtcEGjsl49wiST93JXuO+o6
         O28p/R9muOlQVIbwsXaB1RwRZ8I8kEXNZijGhQSJQK/X0G4wr7Ap4Mfpp6c0zAW7OO0B
         fRBv1NGx4Y5J9D7Hc/Wuadm54dXiND78g3fBYsXU45VDT2RCfbGbcUAS4IQYEANjRgYA
         jV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737339872; x=1737944672;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9ZWe8HvrjHUq6KMvkIr3ITCXLGdt7dy5Uw4QDQYtMQ=;
        b=fLdlOCX9aRK/3UIbBx3o0WpiT6U0Z4XBcQskMSljFI21y9KqbykibB0gZNN9ZCfZMk
         Md9uwsETP8m/JFj+1bV5WLL2HkLUW3PFhxAYpZ1gnES4IvDzDgHkSc/ZdkxIdmkcjTam
         IZEE04ZyS6g6eCmtOsWxN5HTRr6E3vZA0kVEhvUXZvn0qK7vPov4qOi7Vzzq4JgugofR
         3ldoXcTSSRTEI14Dk1O2Wzzzq1QLBosKMu6d7TRPHz8jDlaLDwuUUmLuf/fU1YTGB7fC
         pwk8B9CoaA3ORosyYUAg2dDVuh4voxsI9vk6Boc5PDrPxF4TTlbbMt5cJMrNlqihKm4H
         nGaA==
X-Forwarded-Encrypted: i=1; AJvYcCU9irs6UMRRo7cKsJtqno0L4tW2ccIUsNQ5xovouc8H7si1Fn08F/TzuHed20Bz6S24b7BIqhjhEx5iIbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+hxO0mrdMxXkSxyS1F6GsMxVLGaIHNV8b8iiC52AVEowYkHM
	2QklRTiCGOVBe67uZaoVCeD98PA6WK2RlHGy/MF+pZIKfEWr9dsc
X-Gm-Gg: ASbGncufvjbxJgHFudrJlUtubt4AoyrTy6gzty2KuUtb0QKJ1lD+FluZagkp7BZ9yZ0
	ybbnmnqow6+NtMM0TH/3Am3YxZxp2AZUdhmGz/cvo6xgTgYa6AZWR7+bfaxMaQuRk5I2HOQQj2I
	WOd3o2SnZpSXjhLaXW7570sfpVRHjlldZCZ4NV74KVGhPElxnOue/D6D62eSXnDo5poH48gGUuL
	mRg+BS+qzc0v8yGFSFse2M52mE06ifCk8Y/2qmqRy8oOyc4P9TPEdqdWI1pxOZQl9FH3NRF4M1x
	eo30lDOqPsHJlh8w7s9iJQsVzEQAHfZuRiuSWx3GQySpQ7A+mkE=
X-Google-Smtp-Source: AGHT+IHg3lkhvUPdnFYgZ1tPEEo9g1X77YZUxL9CF5ZC2UGsWatwkfnzg7TSKWb8vf2XtTXuq3mgWg==
X-Received: by 2002:a05:620a:2484:b0:7b6:d799:1f84 with SMTP id af79cd13be357-7be631f5c52mr1646967485a.15.1737339871641;
        Sun, 19 Jan 2025 18:24:31 -0800 (PST)
Received: from ?IPv6:2600:4041:5b0d:f100:fec2:7085:7ce5:711c? ([2600:4041:5b0d:f100:fec2:7085:7ce5:711c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d9949sm393481885a.71.2025.01.19.18.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 18:24:30 -0800 (PST)
Message-ID: <3600f032dc921e44459c266aab76806428267c5e.camel@gmail.com>
Subject: mt7915e card fails to init on Linux 6.3 and newer
From: Jared Van Bortel <jared.e.vb@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 19 Jan 2025 21:24:29 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

I recently purchased a WallysTech DR7915 mPCIe Wi-Fi card (PCI ID
14c3:7915) for my ThinkPad W500. It is ostensibly based on the MT7915
and MT7975 chips, using the mt7915e driver. I tried it on linux-stable
6.12.10 and was unable to get it to work. But it works fine on 6.1 LTS.

(As an aside - why is the latest firmware provided by mainline Linux
version 20220929104113a, while OpenWRT is providing 20240429200502?)

I bisected the issue to commit 9e81c2c7b9af6a5f160e0a9a7f009c37910402ee
("wifi: mt76: mt7915: enable per-phy led support"), which is included in
kernel 6.3. This is what I get in dmesg before this commit (good
behavior):

[   34.976575] mt7915e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build Time:=
 20220929104113a
[   34.990089] mt7915e 0000:03:00.0: WM Firmware Version: ____000000, Build=
 Time: 20220929104145
[   35.012664] mt7915e 0000:03:00.0: WA Firmware Version: DEV_000000, Build=
 Time: 20220929104205
[   35.178619] mt7915e 0000:03:00.0 wlp3s0: renamed from wlan0
[   44.588223] wlan0: authenticate with XX:XX:XX:XX:XX:XX
[   44.598831] wlan0: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
[   44.601589] wlan0: authenticate with XX:XX:XX:XX:XX:XX
[   44.601594] wlan0: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
[   44.611058] wlan0: authenticate with XX:XX:XX:XX:XX:XX
[   44.611064] wlan0: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
[   44.612714] wlan0: authenticated

This is what I get after that commit (bad behavior):

[   37.507795] mt7915e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build Time:=
 20220929104113a
[   37.521157] mt7915e 0000:03:00.0: WM Firmware Version: ____000000, Build=
 Time: 20220929104145
[   37.541817] mt7915e 0000:03:00.0: WA Firmware Version: DEV_000000, Build=
 Time: 20220929104205
[   37.707782] mt7915e 0000:03:00.0 wlp3s0: renamed from wlan0
[   42.984991] pcieport 0000:00:1c.1: pciehp: Slot(1-2): Link Down
[   42.984999] pcieport 0000:00:1c.1: pciehp: Slot(1-2): Card not present
[   64.651072] mt7915e 0000:03:00.0: Message 00001eed (seq 9) timeout
[   85.131081] mt7915e 0000:03:00.0: Message 000007ed (seq 11) timeout
[   85.132693] mt7915e 0000:03:00.0 wlp3s0f0: renamed from wlan0
[  105.614421] mt7915e 0000:03:00.0: Message 000007ed (seq 1) timeout
[  107.701101] mt7915e 0000:03:00.0: Timeout for initializing firmware
[  107.701154] mt7915e 0000:03:00.0: Failed to exit mcu
[  107.844646] pci 0000:03:00.0: Removing from iommu group 6
[  107.844679] pcieport 0000:00:1c.1: pciehp: Slot(1-2): Card present
[  109.541013] pcieport 0000:00:1c.1: pciehp: Slot(1-2): No link
[  109.541024] pcieport 0000:00:1c.1: pciehp: Slot(1-2): Card present
[  111.234338] pcieport 0000:00:1c.1: pciehp: Slot(1-2): No link

On kernel 6.12.10, this failure leads to a page fault, sometimes
immediately:

[  127.807503] [     T73] mt7915e 0000:03:00.0: Message 00001eed (seq 7) ti=
meout
[  127.914244] [     T73] BUG: unable to handle page fault for address: fff=
fabc5c0628ff0
[  127.914294] [     T73] #PF: supervisor write access in kernel mode
[  127.914329] [     T73] #PF: error_code(0x0002) - not-present page
[  127.914363] [     T73] PGD 100000067 P4D 100000067 PUD 100209067 PMD 103=
e7f067 PTE 0
[  127.914406] [     T73] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
[  127.914429] [     T73] CPU: 0 UID: 0 PID: 73 Comm: kworker/u16:6 Kdump: =
loaded Tainted: G          I        6.12.10-arch1-1 #1 ac0cff2c6581af0a10f6=
e278cbc98026cc1e3dec
[  127.914489] [     T73] Tainted: [I]=3DFIRMWARE_WORKAROUND
[  127.914510] [     T73] Hardware name: LENOVO 40612ZU/40612ZU, BIOS 6FET9=
3WW (3.23 ) 10/12/2012
[  127.914538] [     T73] Workqueue: mt76 mt7915_mac_reset_work [mt7915e]
[  127.914578] [     T73] RIP: 0010:mt76_dma_rx_fill+0x157/0x4c0 [mt76]
[  127.914615] [     T73] Code: 8b 54 24 40 85 c0 4c 8b 44 24 18 4c 8b 4c 2=
4 20 4c 8b 5c 24 28 0f 88 2a 03 00 00 c1 e0 10 44 89 ce 44 09 d8 81 ce 00 0=
1 00 00 <45> 89 34 24 41 89 44 24 08 41 89 74 24 04 41 c7 44 24 0c 00 00 00
[  127.914677] [     T73] RSP: 0018:ffffabc5c03afcf8 EFLAGS: 00010246
[  127.914699] [     T73] RAX: 0000000000000000 RBX: ffff9b694630d800 RCX: =
0000000000000000
[  127.914726] [     T73] RDX: 0000000000000000 RSI: 0000000006c00000 RDI: =
0000000000000000
[  127.914753] [     T73] RBP: ffff9b6947ef45d8 R08: ffff9b6948210000 R09: =
0000000006c00000
[  127.914779] [     T73] R10: 00000000000006c0 R11: 0000000000000000 R12: =
ffffabc5c0628ff0
[  127.914806] [     T73] R13: ffff9b69c630d800 R14: 00000000ffd15800 R15: =
0000000000000000
[  127.914833] [     T73] FS:  0000000000000000(0000) GS:ffff9b6a77c00000(0=
000) knlGS:0000000000000000
[  127.914868] [     T73] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  127.914891] [     T73] CR2: ffffabc5c0628ff0 CR3: 000000004b622000 CR4: =
00000000000426f0
[  127.914918] [     T73] Call Trace:
[  127.914930] [     T73]  <TASK>
[  127.914942] [     T73]  ? __die_body.cold+0x19/0x27
[  127.914967] [     T73]  ? page_fault_oops+0x15a/0x2d0
[  127.914992] [     T73]  ? search_bpf_extables+0x5f/0x80
[  127.915016] [     T73]  ? exc_page_fault+0x18a/0x190
[  127.915035] [     T73]  ? asm_exc_page_fault+0x26/0x30
[  127.915056] [     T73]  ? mt76_dma_rx_fill+0x157/0x4c0 [mt76 8ebc1f1034f=
dcf4b82c21f7f79b6854fd3dd0e30]
[  127.915096] [     T73]  ? mt76_dma_rx_fill+0x1ef/0x4c0 [mt76 8ebc1f1034f=
dcf4b82c21f7f79b6854fd3dd0e30]
[  127.915137] [     T73]  ? mt76_dma_rx_cleanup.part.0+0x5e/0x160 [mt76 8e=
bc1f1034fdcf4b82c21f7f79b6854fd3dd0e30]
[  127.915185] [     T73]  ? mt76_dma_rx_cleanup.part.0+0x6c/0x160 [mt76 8e=
bc1f1034fdcf4b82c21f7f79b6854fd3dd0e30]
[  127.915233] [     T73]  mt7915_dma_reset+0x1e1/0x230 [mt7915e 7945e3c7bf=
de237a78fef4a04127eb6221537724]
[  127.915280] [     T73]  mt7915_mac_reset_work+0x67e/0xcd0 [mt7915e 7945e=
3c7bfde237a78fef4a04127eb6221537724]
[  127.915323] [     T73]  process_one_work+0x17b/0x330
[  127.915343] [     T73]  worker_thread+0x2ce/0x3f0
[  127.915365] [     T73]  ? __pfx_worker_thread+0x10/0x10
[  127.915389] [     T73]  kthread+0xcf/0x100
[  127.915406] [     T73]  ? __pfx_kthread+0x10/0x10
[  127.915428] [     T73]  ret_from_fork+0x31/0x50
[  127.915449] [     T73]  ? __pfx_kthread+0x10/0x10
[  127.915470] [     T73]  ret_from_fork_asm+0x1a/0x30
[  127.915494] [     T73]  </TASK>
[  127.915507] [     T73] Modules linked in: mt7915e mt76_connac_lib mt76 m=
ac80211 libarc4 cfg80211 snd_seq_dummy snd_hrtimer snd_seq snd_seq_device i=
p6t_REJECT nf_reject_ipv6 ipt_REJECT xt_multiport xt_cgroup xt_mark xt_owne=
r xt_tcpudp nft_compat amdgpu amdxcp drm_exec gpu_sched nft_masq drm_buddy =
nft_ct nft_reject_ipv4 nf_reject_ipv4 nft_reject act_csum cls_u32 sch_htb n=
ft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables br=
idge stp llc btusb btrtl btintel btbcm btmtk bluetooth crc16 joydev mousede=
v snd_hda_codec_hdmi snd_hda_codec_conexant kvm_intel iTCO_wdt snd_hda_code=
c_generic intel_pmc_bxt radeon snd_hda_intel mei_wdt iTCO_vendor_support sn=
d_intel_dspcfg kvm i2c_algo_bit snd_intel_sdw_acpi pcmcia i2c_i801 drm_suba=
lloc_helper snd_hda_codec drm_ttm_helper i2c_smbus snd_hda_core sha512_ssse=
3 ttm i2c_mux sha1_ssse3 snd_hwdep yenta_socket psmouse acpi_cpufreq pcspkr=
 e1000e r592 pcmcia_rsrc pktcdvd mei_me snd_pcm memstick ptp drm_display_he=
lper pcmcia_core lpc_ich intel_agp snd_timer mei pps_core cec intel_gtt
[  127.915596] [     T73]  think_lmi mac_hid firmware_attributes_class wmi_=
bmof coretemp thinkpad_acpi platform_profile sparse_keymap rfkill snd sound=
core video wmi sg crypto_user dm_mod loop nfnetlink ip_tables x_tables btrf=
s blake2b_generic libcrc32c crc32c_generic serio_raw sdhci_pci xor atkbd ra=
id6_pq libps2 vivaldi_fmap firewire_ohci cqhci sr_mod sdhci firewire_core s=
ha256_ssse3 mmc_core cdrom i8042 crc_itu_t serio
[  127.916035] [     T73] CR2: ffffabc5c0628ff0


It would be nice to be able to use this card on a more recent kernel. I
can assist with debugging and testing, assuming I haven't somehow gotten
a defective unit - but I don't think that would really explain why I can
use it just fine on 6.1 LTS.

Thanks,
Jared Van Bortel

