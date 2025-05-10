Return-Path: <linux-wireless+bounces-22829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDF3AB251B
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 21:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E5F1B642D1
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2F31D63F5;
	Sat, 10 May 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="o0k4Y/fG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from puleglot.ru (puleglot.ru [195.201.32.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83054219E4
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.32.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746904271; cv=none; b=jb15WwhZO2Fhl4LKWIk5DPpe/OUg0rhVttxoAFGq4uTYDiaeIgf+xN7XrjnyPfiZ8KjUu5NZAg+z4NC/Nz454qE7dG2KaWES/vSvDZxwezZby/p5L2KAmfPbbnu/mkwXZBubwz8DEQ/uQrXKw7MHai8wIHImdSCjjQBXmFfdHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746904271; c=relaxed/simple;
	bh=JYp4nFHQQk8qB8UabG3PLAgBiDh7UpHMFPZTkVdC1Lc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=pAKuLJTZRtPKiMZGaIXsyRgvG4OANRo6a8UbgJT70F8jeAEve+3HDczTv2PXEunL0bKG+eR4BJpQvyMfyU8RuBtEF7fOxPLnhF9P8fFjF5P8fOMW+/g0pjbQI/Jh12BYNw6gYTTB09nFYkUCmofWJ4pAY5mVrlZdWkfNMkqxZ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me; spf=pass smtp.mailfrom=puleglot.ru; dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b=o0k4Y/fG; arc=none smtp.client-ip=195.201.32.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puleglot.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
	s=mymail; h=Sender:MIME-Version:Content-Transfer-Encoding:Content-Type:Date:
	Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qfXEjF71xFVymGADcoLTMTSoVRnbc42VebWO0Wh4yyY=; b=o0k4Y/fGrqMdtMqwuY+0Ocn/bh
	tF+FZp3s2jF/ZeeqtEP2mLijpQtoQXPqI1dCNj7hGjYQQRGVc/192LuPlLueDvPJBo0YYh6pYrzHB
	nqHbIj18gNh+dj5x7IJ45nmq9gFR9HMeqbmxoq4zI8QYsafOPnb1Sf0k/BBzW1mEYshU=;
Received: from [62.217.191.191] (helo=[192.168.1.144])
	by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <puleglot@puleglot.ru>)
	id 1uDpQq-000000001i1-1ITB;
	Sat, 10 May 2025 22:00:20 +0300
Message-ID: <9073c24c1fe0e00a8b925548c90ab2f15f3df2b3.camel@tsoy.me>
Subject: ath12k: kernel BUG at net/core/skbuff.c:209!
From: Alexander Tsoy <alexander@tsoy.me>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Sat, 10 May 2025 22:00:19 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: puleglot@puleglot.ru

Hello!

I recently got two QCNCM865 (wcn7850) cards and experience kernel
panics on different systems and different kernel versions. Card info:

[   13.584230] ath12k_pci 0000:0b:00.0: BAR 0 [mem 0xfc200000-0xfc3fffff 64=
bit]: assigned
[   13.584252] ath12k_pci 0000:0b:00.0: enabling device (0000 -> 0002)
[   13.584636] ath12k_pci 0000:0b:00.0: MSI vectors: 16
[   13.584644] ath12k_pci 0000:0b:00.0: Hardware name: wcn7850 hw2.0
[   14.210605] ath12k_pci 0000:0b:00.0: chip_id 0x2 chip_family 0x4 board_i=
d 0xff soc_id 0x40170200
[   14.210613] ath12k_pci 0000:0b:00.0: fw_version 0x100301e1 fw_build_time=
stamp 2023-12-06 04:05 fw_build_id QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c=
5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3


Kernels I've tried so far: 6.12.24..6.12.28, 6.14.5, 6.15.0-rc5

Synthetic load like pumping traffic via netcat or iperf seems unable to
trigger this bug, but something like downloading of Steam games or
torrents is triggering this bug very quickly.

Any ideas on what's going on here? I'm ready to test any patch.

Below are a couple of panic messages from different systems/kernels:

[210794.707322] skbuff: skb_over_panic: text:ffffffffc1bc2de6 len:15608 put=
:15608 head:ffff94f91a36d800 data:ffff94f91a36d840 tail:0x3d38 end:0x8c0 de=
v:<NULL>
[210794.721271] ------------[ cut here ]------------
[210794.726008] kernel BUG at net/core/skbuff.c:209!
[210794.730745] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[210794.736600] CPU: 1 UID: 0 PID: 5304 Comm: irq/105-DP_EXT_ Tainted: G   =
        O       6.12.24-gentoo #1
[210794.746184] Tainted: [O]=3DOOT_MODULE
[210794.749778] Hardware name: ASUS System Product Name/Pro WS X570-ACE, BI=
OS 5002 01/13/2025
[210794.758058] RIP: 0010:skb_panic+0x4f/0x60
[210794.762174] Code: 51 8b 88 c0 00 00 00 51 8b 88 bc 00 00 00 51 89 f9 48=
 c7 c7 a0 e2 11 b1 ff b0 d0 00 00 00 4c 8b 88 c8 00 00 00 e8 61 f7 45 ff <0=
f> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90
[210794.781049] RSP: 0018:ffffbb8d8023cc48 EFLAGS: 00010246
[210794.786378] RAX: 000000000000008e RBX: ffff94fe48e27400 RCX: 0000000000=
000000
[210794.793620] RDX: 0000000000000000 RSI: ffffffffb106a8c4 RDI: 00000000ff=
ffffff
[210794.800858] RBP: ffff94f2c62cb248 R08: 0000000000000000 R09: 0000000000=
000003
[210794.808099] R10: ffffbb8d8023caf0 R11: ffffffffb17e0488 R12: ffff94f42c=
e6a030
[210794.815338] R13: ffffbb8d8023cc90 R14: ffff94f91a36d840 R15: ffff94f2c6=
2c0000
[210794.822580] FS:  0000000000000000(0000) GS:ffff9501aec40000(0000) knlGS=
:0000000000000000
[210794.830774] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[210794.836626] CR2: 00007fa5dc040028 CR3: 0000000faa436000 CR4: 0000000000=
f50ef0
[210794.843866] PKRU: 55555554
[210794.846678] Call Trace:
[210794.849232]  <IRQ>
[210794.851350]  skb_put+0x45/0x50
[210794.854511]  ath12k_dp_rx_wbm_err+0x2c6/0x480 [ath12k]
[210794.859774]  ? srso_alias_return_thunk+0x5/0xfbef5
[210794.864679]  ath12k_dp_rx_process_wbm_err+0x35f/0x580 [ath12k]
[210794.870634]  ? srso_alias_return_thunk+0x5/0xfbef5
[210794.875544]  ath12k_dp_service_srng+0x285/0x2f0 [ath12k]
[210794.880991]  ? srso_alias_return_thunk+0x5/0xfbef5
[210794.885905]  ? srso_alias_return_thunk+0x5/0xfbef5
[210794.890808]  ? __irq_put_desc_unlock+0x17/0x40
[210794.895371]  ath12k_pci_ext_grp_napi_poll+0x20/0x70 [ath12k]
[210794.901151]  __napi_poll+0x26/0x1b0
[210794.904752]  net_rx_action+0x3ba/0x8c0
[210794.908613]  ? srso_alias_return_thunk+0x5/0xfbef5
[210794.913527]  handle_softirqs+0xf7/0x300
[210794.917481]  do_softirq+0x71/0x90
[210794.920909]  </IRQ>
[210794.923109]  <TASK>
[210794.925316]  __local_bh_enable_ip+0x6e/0x70
[210794.929614]  irq_forced_thread_fn+0x64/0x70
[210794.933913]  irq_thread+0x131/0x200
[210794.937515]  ? __pfx_irq_forced_thread_fn+0x10/0x10
[210794.942507]  ? __pfx_irq_thread_dtor+0x10/0x10
[210794.947065]  ? __pfx_irq_thread+0x10/0x10
[210794.951185]  kthread+0xdc/0x110
[210794.954435]  ? __pfx_kthread+0x10/0x10
[210794.958297]  ret_from_fork+0x2f/0x50
[210794.961985]  ? __pfx_kthread+0x10/0x10
[210794.965841]  ret_from_fork_asm+0x1a/0x30
[210794.969881]  </TASK>
[210794.972166] Modules linked in: exfat uas rfcomm michael_mic snd_seq_mid=
i snd_seq_midi_event vfat fat bridge stp llc wireguard curve25519_x86_64 li=
bchacha20poly1305 ip6_udp_tunnel udp_tunnel libcurve25519_generic xt_MASQUE=
RADE iptable_nat nf_nat bnep nf_conntrack_netbios_ns nf_conntrack_broadcast=
 iptable_raw xt_recent xt_limit xt_multiport xt_comment xt_CT ip6table_raw =
qrtr_mhi cdc_ncm cdc_ether usbnet intel_rapl_msr asus_ec_sensors qrtr intel=
_rapl_common amd64_edac ath12k snd_hda_codec_realtek mhi snd_hda_codec_gene=
ric snd_hda_scodec_component kvm_amd qmi_helpers kvm irqbypass snd_hda_code=
c_hdmi mac80211 wmi_bmof snd_hda_intel snd_intel_dspcfg r8152 snd_intel_sdw=
_acpi uvcvideo mii uvc btusb pcspkr snd_hda_codec videobuf2_vmalloc btrtl s=
nd_hda_core cfg80211 videobuf2_memops btintel btbcm videobuf2_v4l2 btmtk sn=
d_usb_audio videodev snd_usbmidi_lib videobuf2_common bluetooth snd_ump snd=
_hwdep snd_rawmidi snd_pcm mc igb tpm_tis tpm_tis_core tpm libaescfb ecdh_g=
eneric ecc tcp_yeah tcp_vegas sch_fq_codel vhba(O) nfsd
[210794.972311]  auth_rpcgss amdgpu video amdxcp i2c_algo_bit drm_ttm_helpe=
r ttm drm_exec gpu_sched drm_suballoc_helper drm_buddy crc32c_intel drm_dis=
play_helper sp5100_tco wmi vhost_scsi target_core_mod configfs vhost_net tu=
n tap vhost vhost_iotlb nct6775 nct6775_core hwmon_vid jc42 regmap_i2c fuse=
 ee1004 i2c_dev efivarfs
[210795.090352] ---[ end trace 0000000000000000 ]---
[210795.193353] pstore: backend (efi_pstore) writing error (-28)
[210795.199120] RIP: 0010:skb_panic+0x4f/0x60
[210795.203244] Code: 51 8b 88 c0 00 00 00 51 8b 88 bc 00 00 00 51 89 f9 48=
 c7 c7 a0 e2 11 b1 ff b0 d0 00 00 00 4c 8b 88 c8 00 00 00 e8 61 f7 45 ff <0=
f> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90
[210795.222130] RSP: 0018:ffffbb8d8023cc48 EFLAGS: 00010246
[210795.227465] RAX: 000000000000008e RBX: ffff94fe48e27400 RCX: 0000000000=
000000
[210795.234717] RDX: 0000000000000000 RSI: ffffffffb106a8c4 RDI: 00000000ff=
ffffff
[210795.241964] RBP: ffff94f2c62cb248 R08: 0000000000000000 R09: 0000000000=
000003
[210795.249212] R10: ffffbb8d8023caf0 R11: ffffffffb17e0488 R12: ffff94f42c=
e6a030
[210795.256468] R13: ffffbb8d8023cc90 R14: ffff94f91a36d840 R15: ffff94f2c6=
2c0000
[210795.263719] FS:  0000000000000000(0000) GS:ffff9501aec40000(0000) knlGS=
:0000000000000000
[210795.271925] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[210795.277785] CR2: 00007fa5dc040028 CR3: 0000000faa436000 CR4: 0000000000=
f50ef0
[210795.285032] PKRU: 55555554
[210795.287852] Kernel panic - not syncing: Fatal exception in interrupt
[210795.295414] Kernel Offset: 0x2ea00000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
[210795.402321] ---[ end Kernel panic - not syncing: Fatal exception in int=
errupt ]---



[  728.842234] skbuff: skb_over_panic: text:ffffffffc0b10eef len:7418 put:7=
418 head:ffff9173aaf8c600 data:ffff9173aaf8c640 tail:0x1d3a end:0x8c0 dev:<=
NULL>
[  728.855904] ------------[ cut here ]------------
[  728.860526] kernel BUG at net/core/skbuff.c:209!
[  728.865166] Oops: invalid opcode: 0000 [#1] SMP PTI
[  728.870051] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.15.0-rc5 =
#1 PREEMPT=20
[  728.877710] Hardware name: Supermicro X9SCL/X9SCM/X9SCL/X9SCM, BIOS 2.3 =
06/12/2018
[  728.885273] RIP: 0010:skb_panic+0x4f/0x60
[  728.889297] Code: 51 8b 88 c0 00 00 00 51 8b 88 bc 00 00 00 51 89 f9 48 =
c7 c7 68 db eb 9f ff b0 d0 00 00 00 4c 8b 88 c8 00 00 00 e8 b1 2a 43 ff <0f=
> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90
[  728.908050] RSP: 0018:ffffb27340178c40 EFLAGS: 00010246
[  728.913284] RAX: 000000000000008c RBX: ffff91732fbda730 RCX: 00000000000=
00000
[  728.920415] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 00000000fff=
fffff
[  728.927549] RBP: ffffb27340178dd0 R08: 0000000000000000 R09: 00000000000=
00003
[  728.934683] R10: ffffb27340178ae8 R11: ffffffffa05e2468 R12: ffff91732fb=
da000
[  728.941815] R13: ffff917334812068 R14: ffff917282482c00 R15: ffffb273401=
78d68
[  728.948947] FS:  0000000000000000(0000) GS:ffff9175fec1d000(0000) knlGS:=
0000000000000000
[  728.957031] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  728.962779] CR2: 0000254e68cc5000 CR3: 0000000147a30002 CR4: 00000000001=
726f0
[  728.969911] Call Trace:
[  728.972364]  <IRQ>
[  728.974383]  skb_put+0x45/0x50
[  728.977445]  ath12k_dp_rx_process_wbm_err+0x73f/0xab0 [ath12k]
[  728.983318]  ath12k_dp_service_srng+0x27f/0x2f0 [ath12k]
[  728.988666]  ? _raw_spin_unlock_irqrestore+0x1a/0x40
[  728.993639]  ? __irq_put_desc_unlock+0x17/0x40
[  728.998096]  ath12k_pci_ext_grp_napi_poll+0x20/0x70 [ath12k]
[  729.003781]  __napi_poll+0x26/0x1e0
[  729.007283]  net_rx_action+0x3b3/0x890
[  729.011046]  handle_softirqs+0xef/0x2f0
[  729.014892]  ? handle_edge_irq+0x9e/0x240
[  729.018912]  irq_exit_rcu+0xb7/0x100
[  729.022500]  common_interrupt+0xbc/0xe0
[  729.026351]  </IRQ>
[  729.028462]  <TASK>
[  729.030567]  asm_common_interrupt+0x26/0x40
[  729.034764] RIP: 0010:cpuidle_enter_state+0xc6/0x410
[  729.039737] Code: 00 e8 de 9a 16 ff e8 99 ee ff ff 8b 53 04 49 89 c5 0f =
1f 44 00 00 31 ff e8 e7 96 15 ff 45 84 ff 0f 85 3a 02 00 00 fb 45 85 f6 <0f=
> 88 81 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d 0c c4 48
[  729.058482] RSP: 0018:ffffb273400cbe88 EFLAGS: 00000202
[  729.063707] RAX: ffff9175fec1d000 RBX: ffff91759fcf5c58 RCX: 00000000000=
0001f
[  729.070842] RDX: 0000000000000003 RSI: ffffffff9ff332f7 RDI: ffffffff9fe=
dffc2
[  729.077971] RBP: 0000000000000004 R08: 0000000000000002 R09: 000000e6175=
62680
[  729.085107] R10: 0000000000000e3c R11: 0000000000000390 R12: ffffffffa06=
dd9e0
[  729.092236] R13: 000000a9b261b9dc R14: 0000000000000004 R15: 00000000000=
00000
[  729.099372]  ? cpuidle_enter_state+0xb9/0x410
[  729.103737]  cpuidle_enter+0x28/0x40
[  729.107318]  do_idle+0x1bd/0x230
[  729.110549]  cpu_startup_entry+0x24/0x30
[  729.114477]  start_secondary+0x112/0x130
[  729.118403]  common_startup_64+0x13e/0x148
[  729.122503]  </TASK>
[  729.124694] Modules linked in: michael_mic bridge stp llc wireguard curv=
e25519_x86_64 libchacha20poly1305 ip6_udp_tunnel udp_tunnel libcurve25519_g=
eneric xt_recent xt_limit xt_multiport xt_comment xt_MASQUERADE iptable_nat=
 nf_nat nf_conntrack_netbios_ns nf_conntrack_broadcast iptable_raw xt_CT ip=
6table_raw joydev qrtr_mhi intel_rapl_msr qrtr intel_rapl_common ath12k mhi=
 x86_pkg_temp_thermal qmi_helpers ipmi_ssif mac80211 kvm_intel kvm cfg80211=
 acpi_ipmi e1000e ipmi_si video ipmi_devintf irqbypass ipmi_msghandler ie31=
200_edac wmi pcspkr lpc_ich tcp_yeah tcp_vegas sch_fq_codel mgag200 drm_cli=
ent_lib i2c_algo_bit drm_shmem_helper drm_kms_helper vhost_scsi target_core=
_mod configfs vhost_net tun tap vhost vhost_iotlb jc42 fuse at24 regmap_i2c=
 i2c_dev
[  729.190654] ---[ end trace 0000000000000000 ]---
[  729.309410] RIP: 0010:skb_panic+0x4f/0x60
[  729.313439] Code: 51 8b 88 c0 00 00 00 51 8b 88 bc 00 00 00 51 89 f9 48 =
c7 c7 68 db eb 9f ff b0 d0 00 00 00 4c 8b 88 c8 00 00 00 e8 b1 2a 43 ff <0f=
> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90
[  729.332191] RSP: 0018:ffffb27340178c40 EFLAGS: 00010246
[  729.337424] RAX: 000000000000008c RBX: ffff91732fbda730 RCX: 00000000000=
00000
[  729.344569] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 00000000fff=
fffff
[  729.351711] RBP: ffffb27340178dd0 R08: 0000000000000000 R09: 00000000000=
00003
[  729.358849] R10: ffffb27340178ae8 R11: ffffffffa05e2468 R12: ffff91732fb=
da000
[  729.365992] R13: ffff917334812068 R14: ffff917282482c00 R15: ffffb273401=
78d68
[  729.373131] FS:  0000000000000000(0000) GS:ffff9175fec1d000(0000) knlGS:=
0000000000000000
[  729.381227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  729.386978] CR2: 0000254e68cc5000 CR3: 0000000147a30002 CR4: 00000000001=
726f0
[  729.394111] Kernel panic - not syncing: Fatal exception in interrupt
[  729.400512] Kernel Offset: 0x1d800000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
[  729.574165] ---[ end Kernel panic - not syncing: Fatal exception in inte=
rrupt ]---


