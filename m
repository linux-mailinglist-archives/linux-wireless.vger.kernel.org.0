Return-Path: <linux-wireless+bounces-11078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6156994A666
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 12:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C648CB29FE2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E51C37AC;
	Wed,  7 Aug 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvxq2Ti5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE51D1F46
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027879; cv=none; b=g7YFu+V+49WsFS51Orcibjfr8XY3Qcjs+FEke8MncvdkvFG4TAJHKdZyU8UKrZ0Kg7KDURpOq4+xffZdHfVOKhgIh02bd/1kwMkD8J36V4TiUs/osiaoqiK9tPF5PhYcQtTkbSnUvB2CyqMo5p5+mYltMhGFnSeGs1ESaDjZtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027879; c=relaxed/simple;
	bh=PGz1EAPs9mU0wBKUJJUZWefqx9UYQNGvssg1I6aIAQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TGefVccuX9/U0rTrRd793+nKkUCNTwkbr23WuMzER45kaRuSMLdaLm4Zwt22CLCv21hvtojVUYCvzN5iTxJbeP+115LoqArYV39em/IzltesNsj6T/uX9luxA+NzIkA1p715KCrToALCB62w0dtP8hotaJQ3kf9gyT5OjZMSiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvxq2Ti5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281c164408so10886155e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723027876; x=1723632676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj6pA+dXtlieu+/Wr+QM/OpZ0voMd7oobqsysnkfo+g=;
        b=Tvxq2Ti5qMGfIZrPwomEMa5qTFo3TTccrjOOungW6bHCLkgCeTapzjycMDbNzbHNvh
         ixstwuwlCG+lwEYhtUtbrSQuKe1H/D9A6XEeGfhIAPwhnC/tWe3HeEoXKn30NHqMjUD8
         IaEeBsrFf1fbjK2+WrFxmD+RjBCWcrUKXkEoilfu3njs386uxjBxPbcI/8DgZK6w4QMF
         Km9evRr7US4EyLrHY/iPlJYs8X0GrZpXWvNVCMBxOWMHXRTZmw2hmoueIT9mJZjR3lND
         lumveZjkm1Fpb+mR54vijfI6r705sCimk2uF071uP3PmH8tdygfmPhEUuRFNhnZaYBhq
         /JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027876; x=1723632676;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qj6pA+dXtlieu+/Wr+QM/OpZ0voMd7oobqsysnkfo+g=;
        b=FuEeNMD5aVi8G9EJ96lRSTYtDT6kzVN/x4SGdAetdPt35EnJc1OUq3AqDEIy8u0NjJ
         13/i7Z1u//256p+UYeQj3xVse5YyahRF+K9XksAZhjUKbGr0AEgXT3JlxRh2eRo84WXi
         J3FNskI8drjNukusxf9vEfn7wF0e7yToWeO2/rQ5npry1A/dyEjpVzJOdVZtQjznfELr
         byhJTMgFmuQ+PuCBSazGCkXt6a/1AygLxRCfziPnQXUWpdNxOxFOcT3+BCfWSSv33bg/
         TBOWSpM6mREZByZ+IjghfoQB3f8XtA5QMX88E2Pq3rlSRVP3R/JMfFlGc0AdHHboj5iX
         2a+A==
X-Gm-Message-State: AOJu0YzbSg7wYIf2pR5wvE5KEQWeOdkYUMNRdn0Spf83AeQoTxd29+Fx
	wrhbAhAEoRYtwo7rTlZBLfPE5oZF9ZSV/sLXKNZBulqkq0p42v6CkWnGQ7q/
X-Google-Smtp-Source: AGHT+IHaVqh5hDZKxsfGA4fxhphmuv4p0EEriAKgdi8s80nVOxogxN4ZD4xkxAw/Ei3Ij7lqnsf/NA==
X-Received: by 2002:a05:600c:3153:b0:428:1846:4f0 with SMTP id 5b1f17b1804b1-428e6b026b1mr110693885e9.16.1723027875345;
        Wed, 07 Aug 2024 03:51:15 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:885:ed01:895f:a056:3282:b682])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905801c42sm24220965e9.34.2024.08.07.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:51:14 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:51:12 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: benjamin.berg@intel.com, miriam.rachel.korenblit@intel.com,
	regressions@lists.linux.dev, johannes@sipsolutions.net
Subject: [REGRESSION] bisected: iwlwifi: use already mapped data when TXing
 an AMSDU
Message-ID: <ZrNRoEbdkxkKFMBi@debian.local>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I hit the following bug in 6.11.0-rc2. Reverting the offending commit
fixes the issue. This happens immediately when I run `iperf3 -bidir`.

#regzbot introduced: 90db50755228252f94b143bbf2380242688b1104

90db50755228252f94b143bbf2380242688b1104 is the first bad commit
commit 90db50755228252f94b143bbf2380242688b1104
Author: Benjamin Berg <benjamin.berg@intel.com>
Date:   Wed Jul 3 12:58:55 2024 +0300

    wifi: iwlwifi: use already mapped data when TXing an AMSDU

    The previous commits added mappings for the SKB and TSO page. This
    switches the code to use these mappings instead of creating new ones.

    Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
    Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
    Reviewed-by: Johannes Berg <johannes.berg@intel.com>
    Link: https://patch.msgid.link/20240703125541.35d89c5e4ae8.I4feb8d34e7b=
30768d21365ec22c944bacc274d0b@changeid
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>

 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 64 +++++++++++++++++--=
----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c      | 21 +++++---
 2 files changed, 63 insertions(+), 22 deletions(-)

[   42.873868] ------------[ cut here ]------------
[   42.873989] WARNING: CPU: 1 PID: 529 at drivers/net/wireless/intel/iwlwi=
fi/pcie/tx.c:1836 iwl_pcie_get_sgt_tb_phys (drivers/net/wireless/intel/iwlw=
ifi/pcie/tx.c:1836) iwlwifi
[   42.874019] Modules linked in: nvme_fabrics ccm qrtr overlay cmac algif_=
hash algif_skcipher af_alg bnep binfmt_misc iwlmvm snd_acp3x_rn snd_acp3x_p=
dm_dma snd_soc_dmic mac80211 snd_sof_amd_rembrandt snd_sof_amd_renoir snd_s=
of_amd_acp snd_sof_pci snd_sof_xtensa_dsp libarc4 snd_sof snd_ctl_led snd_h=
da_codec_realtek snd_sof_utils snd_soc_core uvcvideo snd_hda_codec_generic =
videobuf2_vmalloc videobuf2_memops snd_hda_codec_hdmi snd_hda_scodec_compon=
ent uvc snd_compress snd_pci_ps snd_hda_intel videobuf2_v4l2 snd_rpl_pci_ac=
p6x videodev snd_intel_dspcfg btusb snd_acp_pci snd_acp_legacy_common snd_h=
da_codec btrtl btintel snd_hwdep snd_hda_core videobuf2_common snd_pci_acp6=
x btbcm snd_pcm intel_rapl_msr btmtk iwlwifi mc intel_rapl_common snd_pci_a=
cp5x snd_timer snd_rn_pci_acp3x snd_acp_config snd snd_soc_acpi kvm_amd cfg=
80211 bluetooth snd_pci_acp3x soundcore ee1004 kvm ccp k10temp sp5100_tco i=
nput_leds joydev serio_raw hp_wmi sparse_keymap ucsi_acpi rapl mac_hid type=
c_ucsi pcspkr amd_pmc platform_profile wmi_bmof typec
[   42.874165]  hid_multitouch acpi_tad msr parport_pc ppdev lp parport efi=
_pstore dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_generic libcrc32=
c xor raid6_pq uas usb_storage amdgpu i2c_algo_bit drm_ttm_helper ttm drm_e=
xec nvme drm_suballoc_helper amdxcp drm_buddy hid_generic nvme_core video i=
2c_piix4 xhci_pci gpu_sched crct10dif_pclmul crc32_pclmul polyval_clmulni p=
olyval_generic ghash_clmulni_intel drm_display_helper amd_sfh i2c_smbus xhc=
i_pci_renesas nvme_auth i2c_hid_acpi i2c_hid wmi hid aesni_intel crypto_sim=
d cryptd
[   42.874309] CPU: 1 UID: 0 PID: 529 Comm: irq/77-iwlwifi: Not tainted 6.1=
1.0-rc2 #50
[   42.874319] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.14 10/25/2023
[   42.874326] RIP: 0010:iwl_pcie_get_sgt_tb_phys (drivers/net/wireless/int=
el/iwlwifi/pcie/tx.c:1836) iwlwifi
[ 42.874352] Code: 48 8d 34 0a 48 39 f3 72 0e 8b 47 18 48 01 c8 48 01 c2 48=
 39 d3 72 2b e8 41 7c 1e c2 41 83 c5 01 48 89 c7 45 3b 6c 24 08 72 b6 <0f> =
0b 48 c7 c0 ff ff ff ff 5b 41 5c 41 5d 5d 31 d2 31 c9 31 f6 31
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 8d 34 0a          	lea    (%rdx,%rcx,1),%rsi
   4:	48 39 f3             	cmp    %rsi,%rbx
   7:	72 0e                	jb     0x17
   9:	8b 47 18             	mov    0x18(%rdi),%eax
   c:	48 01 c8             	add    %rcx,%rax
   f:	48 01 c2             	add    %rax,%rdx
  12:	48 39 d3             	cmp    %rdx,%rbx
  15:	72 2b                	jb     0x42
  17:	e8 41 7c 1e c2       	call   0xffffffffc21e7c5d
  1c:	41 83 c5 01          	add    $0x1,%r13d
  20:	48 89 c7             	mov    %rax,%rdi
  23:	45 3b 6c 24 08       	cmp    0x8(%r12),%r13d
  28:	72 b6                	jb     0xffffffffffffffe0
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  33:	5b                   	pop    %rbx
  34:	41 5c                	pop    %r12
  36:	41 5d                	pop    %r13
  38:	5d                   	pop    %rbp
  39:	31 d2                	xor    %edx,%edx
  3b:	31 c9                	xor    %ecx,%ecx
  3d:	31 f6                	xor    %esi,%esi
  3f:	31                   	.byte 0x31

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
   9:	5b                   	pop    %rbx
   a:	41 5c                	pop    %r12
   c:	41 5d                	pop    %r13
   e:	5d                   	pop    %rbp
   f:	31 d2                	xor    %edx,%edx
  11:	31 c9                	xor    %ecx,%ecx
  13:	31 f6                	xor    %esi,%esi
  15:	31                   	.byte 0x31
[   42.874357] RSP: 0018:ffffb263803dff00 EFLAGS: 00010246
[   42.874364] RAX: ffff97e55199c4e0 RBX: ffff97e550670000 RCX: 00000000000=
05e50
[   42.874368] RDX: 0000000000000000 RSI: ffff97e549c8de50 RDI: ffff97e5519=
9c4e0
[   42.874372] RBP: ffffb263803dff18 R08: 0000000000000000 R09: 00000000000=
00000
[   42.874375] R10: 0000000000000000 R11: 0000000000000000 R12: ffff97e5519=
9c490
[   42.874379] R13: 0000000000000002 R14: ffff97e54a8b8028 R15: ffff97e5519=
9c490
[   42.874382] FS:  0000000000000000(0000) GS:ffff97e84d080000(0000) knlGS:=
0000000000000000
[   42.874387] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.874391] CR2: 00005c2f48bdc078 CR3: 000000019d658000 CR4: 0000000000f=
50ef0
[   42.874395] PKRU: 55555554
[   42.874399] Call Trace:
[   42.874402]  <IRQ>
[   42.874408] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[   42.874417] ? __warn (kernel/panic.c:735)
[   42.874428] ? iwl_pcie_get_sgt_tb_phys (drivers/net/wireless/intel/iwlwi=
fi/pcie/tx.c:1836) iwlwifi
[   42.874451] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[   42.874463] ? handle_bug (arch/x86/kernel/traps.c:218)
[   42.874469] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator=
 1))
[   42.874475] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
[   42.874491] ? iwl_pcie_get_sgt_tb_phys (drivers/net/wireless/intel/iwlwi=
fi/pcie/tx.c:1836) iwlwifi
[   42.874514] iwl_txq_gen2_tx (drivers/net/wireless/intel/iwlwifi/pcie/tx-=
gen2.c:263 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c:338 drivers/ne=
t/wireless/intel/iwlwifi/pcie/tx-gen2.c:517 drivers/net/wireless/intel/iwlw=
ifi/pcie/tx-gen2.c:777) iwlwifi
[   42.874551] iwl_trans_tx (drivers/net/wireless/intel/iwlwifi/iwl-trans.c=
:417) iwlwifi
[   42.874575] iwl_mvm_tx_mpdu (drivers/net/wireless/intel/iwlwifi/mvm/tx.c=
:1320) iwlmvm
[   42.874610] ? iwl_mvm_tx_tso_segment (drivers/net/wireless/intel/iwlwifi=
/mvm/tx.c:973) iwlmvm
[   42.874641] iwl_mvm_tx_skb_sta (drivers/net/wireless/intel/iwlwifi/mvm/t=
x.c:1417 (discriminator 4)) iwlmvm
[   42.874677] iwl_mvm_tx_skb (drivers/net/wireless/intel/iwlwifi/mvm/mac80=
211.c:801) iwlmvm
[   42.874702] iwl_mvm_mac_itxq_xmit (./arch/x86/include/asm/bitops.h:206 .=
/arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumente=
d-non-atomic.h:142 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:911) i=
wlmvm
[   42.874728] iwl_mvm_mac_wake_tx_queue (drivers/net/wireless/intel/iwlwif=
i/mvm/mac80211.c:960) iwlmvm
[   42.874751] ieee80211_queue_skb (net/mac80211/tx.c:1666) mac80211
[   42.874836] __ieee80211_xmit_fast (net/mac80211/tx.c:3732) mac80211
[   42.874905] ? find_held_lock (kernel/locking/lockdep.c:5249)
[   42.874913] ? skb_mac_gso_segment (./include/linux/rcupdate.h:336 ./incl=
ude/linux/rcupdate.h:869 net/core/gso.c:57)
[   42.874936] __ieee80211_subif_start_xmit (net/mac80211/tx.c:3796 net/mac=
80211/tx.c:4308) mac80211
[   42.874994] ieee80211_subif_start_xmit (net/mac80211/tx.c:4537) mac80211
[   42.875047] ? lock_acquire (kernel/locking/lockdep.c:466 kernel/locking/=
lockdep.c:5761 kernel/locking/lockdep.c:5724)
[   42.875053] ? __dev_queue_xmit (./include/linux/netdevice.h:4358 net/cor=
e/dev.c:4419)
[   42.875064] dev_hard_start_xmit (./include/linux/netdevice.h:4913 ./incl=
ude/linux/netdevice.h:4922 net/core/dev.c:3580 net/core/dev.c:3596)
[   42.875070] ? dev_hard_start_xmit (./include/linux/netdevice.h:4913 ./in=
clude/linux/netdevice.h:4922 net/core/dev.c:3580 net/core/dev.c:3596)
[   42.875081] __dev_queue_xmit (net/core/dev.h:168 net/core/dev.c:4424)
[   42.875087] ? select_task_rq_fair (./include/linux/rcupdate.h:336 ./incl=
ude/linux/rcupdate.h:869 kernel/sched/fair.c:8251)
[   42.875095] ? lock_acquire (kernel/locking/lockdep.c:466 kernel/locking/=
lockdep.c:5761 kernel/locking/lockdep.c:5724)
[   42.875100] ? mark_held_locks (kernel/locking/lockdep.c:4273)
[   42.875104] ip_finish_output2 (./include/linux/netdevice.h:3105 ./includ=
e/net/neighbour.h:526 ./include/net/neighbour.h:540 net/ipv4/ip_output.c:23=
5)
[   42.875107] ? rcu_read_lock_held (kernel/rcu/update.c:352)
[   42.875112] __ip_finish_output (net/ipv4/ip_output.c:313 net/ipv4/ip_out=
put.c:295)
[   42.875116] ip_finish_output (net/ipv4/ip_output.c:330)
[   42.875119] ip_output (net/ipv4/ip_output.c:437)
[   42.875122] __ip_queue_xmit (./include/net/dst.h:450 net/ipv4/ip_output.=
c:129 net/ipv4/ip_output.c:535)
[   42.875126] ip_queue_xmit (net/ipv4/ip_output.c:550)
[   42.875128] __tcp_transmit_skb (net/ipv4/tcp_output.c:1466)
[   42.875137] tcp_write_xmit (net/ipv4/tcp_output.c:2829)
[   42.875142] __tcp_push_pending_frames (net/ipv4/tcp_output.c:3014)
[   42.875145] tcp_rcv_established (net/ipv4/tcp_input.c:5712 net/ipv4/tcp_=
input.c:6145)
[   42.875148] ? lock_is_held_type (kernel/locking/lockdep.c:5500 kernel/lo=
cking/lockdep.c:5831)
[   42.875152] tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1956)
[   42.875155] tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2344)
[   42.875158] ? lock_release (kernel/locking/lockdep.c:5435 kernel/locking=
/lockdep.c:5780)
[   42.875162] ? lock_is_held_type (kernel/locking/lockdep.c:5500 kernel/lo=
cking/lockdep.c:5831)
[   42.875167] ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205)
[   42.875171] ip_local_deliver_finish (./include/linux/rcupdate.h:867 net/=
ipv4/ip_input.c:234)
[   42.875175] ip_local_deliver (net/ipv4/ip_input.c:257)
[   42.875178] ip_rcv_finish (net/ipv4/ip_input.c:451)
[   42.875181] ip_rcv (net/ipv4/ip_input.c:572)
[   42.875185] __netif_receive_skb_core.constprop.0 (net/core/dev.c:2237 ne=
t/core/dev.c:2252 net/core/dev.c:5617)
[   42.875189] ? __lock_acquire (kernel/locking/lockdep.c:4598 kernel/locki=
ng/lockdep.c:5096)
[   42.875197] __netif_receive_skb_list_core (net/core/dev.c:5738)
[   42.875200] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63)
[   42.875205] netif_receive_skb_list_internal (net/core/dev.c:5806 net/cor=
e/dev.c:5896)
[   42.875210] napi_complete_done (./include/linux/list.h:37 ./include/net/=
gro.h:516 ./include/net/gro.h:511 net/core/dev.c:6247)
[   42.875214] iwl_pcie_napi_poll_msix (drivers/net/wireless/intel/iwlwifi/=
pcie/rx.c:1065) iwlwifi
[   42.875225] __napi_poll.constprop.0 (net/core/dev.c:6773)
[   42.875229] net_rx_action (net/core/dev.c:6843 net/core/dev.c:6963)
[   42.875238] handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./in=
clude/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softir=
q.c:555)
[   42.875242] ? iwl_pcie_irq_rx_msix_handler (./include/linux/bottom_half.=
h:33 drivers/net/wireless/intel/iwlwifi/pcie/rx.c:1669) iwlwifi
[   42.875252] ? iwl_pcie_irq_rx_msix_handler (drivers/net/wireless/intel/i=
wlwifi/pcie/rx.c:1663) iwlwifi
[   42.875260] __do_softirq (kernel/softirq.c:589)
[   42.875264] do_softirq.part.0 (kernel/softirq.c:455)
[   42.875266]  </IRQ>
[   42.875268]  <TASK>
[   42.875269] __local_bh_enable_ip (kernel/softirq.c:457 kernel/softirq.c:=
382)
[   42.875272] ? iwl_pcie_irq_rx_msix_handler (./include/linux/bottom_half.=
h:33 drivers/net/wireless/intel/iwlwifi/pcie/rx.c:1669) iwlwifi
[   42.875281] iwl_pcie_irq_rx_msix_handler (drivers/net/wireless/intel/iwl=
wifi/pcie/rx.c:1671) iwlwifi
[   42.875290] ? irq_thread (kernel/irq/manage.c:1322)
[   42.875293] irq_thread_fn (kernel/irq/manage.c:1222)
[   42.875296] ? irq_thread (kernel/irq/manage.c:1322)
[   42.875298] irq_thread (kernel/irq/manage.c:1328)
[   42.875300] ? disable_irq_nosync (kernel/irq/manage.c:1219)
[   42.875303] ? irq_thread (kernel/irq/manage.c:1237)
[   42.875306] ? irq_set_affinity_notifier (kernel/irq/manage.c:1304)
[   42.875308] kthread (kernel/kthread.c:389)
[   42.875312] ? kthread_insert_work_sanity_check (kernel/kthread.c:342)
[   42.875315] ret_from_fork (arch/x86/kernel/process.c:153)
[   42.875318] ? kthread_insert_work_sanity_check (kernel/kthread.c:342)
[   42.875321] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
[   42.875328]  </TASK>
[   42.875330] irq event stamp: 29672
[   42.875331] hardirqs last enabled at (29680): console_unlock (./arch/x86=
/include/asm/paravirt.h:698 ./arch/x86/include/asm/irqflags.h:155 kernel/pr=
intk/printk.c:341 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120)
[   42.875334] hardirqs last disabled at (29687): console_unlock (kernel/pr=
intk/printk.c:339 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120)
[   42.875337] softirqs last enabled at (27924): iwl_pcie_irq_rx_msix_handl=
er (./include/linux/bottom_half.h:33 drivers/net/wireless/intel/iwlwifi/pci=
e/rx.c:1669) iwlwifi
[   42.875346] softirqs last disabled at (27925): __do_softirq (kernel/soft=
irq.c:589)
[   42.875348] ---[ end trace 0000000000000000 ]---

