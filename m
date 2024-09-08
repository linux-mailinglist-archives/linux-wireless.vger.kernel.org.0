Return-Path: <linux-wireless+bounces-12636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEA39709D2
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 22:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3235F1F21B88
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2024 20:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B31741E8;
	Sun,  8 Sep 2024 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBTBn176"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93B2B9CD
	for <linux-wireless@vger.kernel.org>; Sun,  8 Sep 2024 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725828911; cv=none; b=VRXRoYItiI/LH7WUjvj2rY0ZUPRZLl51zE30nzZqdrmFVSmf1/shPLiHGgUTHMkfAcsuEpc3QuQAGzMu6Sg9gGhUV37Y6+RsudP67/U2Qw+NNMhd0+QOvQDOJlVzDYVPS6f2UqJsS3ftz7elTrW+8L/AwC4QIeEuRpkbIZpJUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725828911; c=relaxed/simple;
	bh=0uGF+JiiH76bouRpGBO2IRWe4EDO4tfUibanfEJEoQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2cfYxMQBbufYX0XHFOVngB8aEPsWddzlWr44Q+iogRX2oY1CGWoHzAfHvMVNDvGEbYus4+xjkeDxPh6Kgc/SdCZIGOQ1FwtllYF4FvtR+EeOHYH+lZKtrZBvIanh/P1WdkLtapNXaFTY6Gn7anMPloOhVjkguAePWN0bSZWsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBTBn176; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so1285795e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2024 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725828908; x=1726433708; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=czDgOOlIt6DrhvJwJhqTih6mPCUHpwHgA2H3c9eCM3w=;
        b=EBTBn176dpbyfO+ab3p22X0+XiEaQp14stSNbxaJn2IP3+54lqchgWmKP2JSjV+/Pj
         jvcTjleCkCUa2JxCS7v4ArCFSfP332uYEf7Yo/DrZalbdgXLUoMQPNdDyDPZfYQH/I4x
         GOZX0c++TadbSvkMc7sVwBCDpMEKHTPa9nLxCR72znHOmy77lZfs0s0DExbvedg5KnAr
         Z+GmV+J+dRQu5XBvBAlSMYSOo5QTSZj+B5A19qAMwjFtl0THFu6Z/FwdUvtMfTysww0e
         GcGONVUVBH7NBrX7X6Gwp+Lt1bl6Lq8jrw/s1h++3TnSjdg1NCD+Nvg2aizlq/OaQTe2
         uwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725828908; x=1726433708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czDgOOlIt6DrhvJwJhqTih6mPCUHpwHgA2H3c9eCM3w=;
        b=nNzCwD4+usy8mmLglEeNruFTIZRAKflQgs0ldWP7C7IIdwLq4SLdG7e8dm2wT7Dt3b
         OUomeUUuKS5hNGOOQdpEQHmDsvULMb1OIvazLr7MuoJzxSg19euFJ55Xs1+/8MJ45+yK
         psDWkjhtP0S4zbKxJlFYtpGuzlCDXSkt41mk1wHpa3bd4ROXkbttPtKnaO7tZEU0Gg2D
         cKVl6+2FsLO2N0gNROyCf9nug1iPQSJqAxr9ckFlxoyXXL5F9TqfVsPwTrxsP9xuQj3j
         +uhS7toB5TgzSotssYos+kV8IXB4tLxfQVugI/hwTs7PGyWSEV01LypGN/XgVVfOmilt
         aOYg==
X-Gm-Message-State: AOJu0YyUGwfoiUGc9dBtve2ZkHk9Qf0qaAtBSy9vNSqZ8qxp+BqAlrZN
	EEdv2WLIBRU32fA3jqqiaZMWCGLe0I5giQTZSSjMZBnSPewt7/43MNMt+5HJdIk=
X-Google-Smtp-Source: AGHT+IFkYvRcUvlCGSg+B5CRlQqhyVmUTFURPUGwdyDY3RKqEy2JWSwqvl/KYWSc/cGMjH/IQ71wCw==
X-Received: by 2002:a05:600c:5248:b0:42c:b23f:7ba5 with SMTP id 5b1f17b1804b1-42cb23f7d26mr27422195e9.10.1725828907328;
        Sun, 08 Sep 2024 13:55:07 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:c56:fd01:3715:1975:8d7:6033])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d363asm4227732f8f.72.2024.09.08.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 13:55:06 -0700 (PDT)
Date: Sun, 8 Sep 2024 21:55:04 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
Message-ID: <Zt4PKMCp_FTx3kac@debian.local>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
 <d59125316423abd2f67e1c111eb54d083b7cc014.camel@intel.com>
 <d3a83162570aaede579ecde64e00350ce1e6b452.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d3a83162570aaede579ecde64e00350ce1e6b452.camel@intel.com>

On Sun, Sep 08, 2024 at 10:54:09AM +0000, Grumbach, Emmanuel wrote:
>=20
> Strike that.
>=20
> Can you please take the patch in attached instead?

Sure, the error with v6.11-rc6+patch is:

[   63.289157] ------------[ cut here ]------------
[   63.289168] Timeout waiting for hardware access (CSR_GP_CNTRL 0x08040008)
[   63.289213] WARNING: CPU: 11 PID: 861 at drivers/net/wireless/intel/iwlw=
ifi/pcie/trans.c:2247 __iwl_trans_pcie_grab_nic_access+0x197/0x1a0 [iwlwifi]
[   63.289233] Modules linked in: rfcomm xt_conntrack nft_chain_nat xt_MASQ=
UERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ip=
v4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables nfnetlink br_netfil=
ter bridge stp llc nvme_fabrics ccm snd_seq_dummy snd_hrtimer snd_seq overl=
ay qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc snd_soc_dmic=
 snd_acp3x_rn snd_acp3x_pdm_dma snd_sof_amd_rembrandt snd_sof_amd_renoir sn=
d_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp iwlmvm snd_sof snd_hda_codec_r=
ealtek snd_sof_utils intel_rapl_msr snd_hda_codec_generic intel_rapl_common=
 snd_hda_scodec_component snd_hda_codec_hdmi snd_soc_core mac80211 snd_comp=
ress btusb snd_pci_ps btrtl snd_rpl_pci_acp6x snd_acp_pci btintel libarc4 s=
nd_acp_legacy_common snd_hda_intel kvm_amd snd_usb_audio snd_pci_acp6x btbc=
m btmtk snd_intel_dspcfg snd_ctl_led snd_pci_acp5x snd_hda_codec kvm snd_us=
bmidi_lib uvcvideo snd_ump videobuf2_vmalloc videobuf2_memops ee1004 snd_hw=
dep snd_rawmidi uvc snd_hda_core snd_seq_device rapl
[   63.289293]  videobuf2_v4l2 snd_rn_pci_acp3x hp_wmi sparse_keymap snd_pc=
m snd_acp_config iwlwifi platform_profile pcspkr videodev snd_soc_acpi snd_=
timer wmi_bmof bluetooth videobuf2_common ucsi_acpi sp5100_tco k10temp snd_=
pci_acp3x snd cfg80211 typec_ucsi mc soundcore ccp typec amd_pmc acpi_tad i=
nput_leds joydev serio_raw mac_hid msr parport_pc ppdev lp parport efi_psto=
re dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_generic libcrc32c xor=
 raid6_pq usbmouse hid_microsoft ff_memless usbkbd dm_crypt hid_cmedia r815=
3_ecm cdc_ether usbnet r8152 mii usbhid uas usb_storage amdgpu i2c_algo_bit=
 drm_ttm_helper ttm drm_exec nvme drm_suballoc_helper amdxcp hid_multitouch=
 drm_buddy nvme_core video gpu_sched xhci_pci hid_generic crct10dif_pclmul =
crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel drm_displa=
y_helper amd_sfh xhci_pci_renesas nvme_auth i2c_hid_acpi i2c_piix4 i2c_hid =
i2c_smbus hid wmi aesni_intel crypto_simd cryptd
[   63.289360] CPU: 11 UID: 0 PID: 861 Comm: kworker/u64:11 Not tainted 6.1=
1.0-rc6-dirty #188
[   63.289362] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.12 04/11/2023
[   63.289364] Workqueue: async async_run_entry_fn
[   63.289370] RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x197/0x1a0 [iwlw=
ifi]
[   63.289379] Code: e4 31 c0 e9 6f ff ff ff 31 f6 48 89 df e8 f1 fc ff ff =
eb e5 44 89 e6 48 c7 c7 d8 e9 dd c1 c6 05 3b f2 02 00 01 e8 09 c8 b6 e3 <0f=
> 0b eb 93 0f 1f 44 00 00 0f 1f 44 00 00 55 be 00 02 00 00 48 89
[   63.289381] RSP: 0018:ffff9db243a37a38 EFLAGS: 00010246
[   63.289383] RAX: 0000000000000000 RBX: ffff8ce309198028 RCX: 00000000000=
00000
[   63.289384] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[   63.289385] RBP: ffff9db243a37a60 R08: 0000000000000000 R09: 00000000000=
00000
[   63.289386] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000080=
40008
[   63.289387] R13: 0000000000000000 R14: ffff8ce309199e30 R15: 00000000000=
00011
[   63.289388] FS:  0000000000000000(0000) GS:ffff8ce60e780000(0000) knlGS:=
0000000000000000
[   63.289389] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.289390] CR2: 00007cedb4dc5180 CR3: 0000000147658000 CR4: 0000000000f=
50ef0
[   63.289391] PKRU: 55555554
[   63.289392] Call Trace:
[   63.289393]  <TASK>
[   63.289395]  ? show_regs+0x68/0x80
[   63.289399]  ? __warn+0x8e/0x1b0
[   63.289404]  ? __iwl_trans_pcie_grab_nic_access+0x197/0x1a0 [iwlwifi]
[   63.289413]  ? report_bug+0x17e/0x1b0
[   63.289419]  ? handle_bug+0x46/0x80
[   63.289423]  ? exc_invalid_op+0x18/0x80
[   63.289424]  ? asm_exc_invalid_op+0x1b/0x20
[   63.289431]  ? __iwl_trans_pcie_grab_nic_access+0x197/0x1a0 [iwlwifi]
[   63.289440]  ? __iwl_trans_pcie_grab_nic_access+0x197/0x1a0 [iwlwifi]
[   63.289448]  ? iwl_trans_pcie_grab_nic_access+0x1b/0x50 [iwlwifi]
[   63.289457]  iwl_trans_pcie_grab_nic_access+0x2b/0x50 [iwlwifi]
[   63.289465]  _iwl_trans_grab_nic_access+0xe/0x20 [iwlwifi]
[   63.289475]  iwl_trans_pcie_read_mem+0x47/0x150 [iwlwifi]
[   63.289485]  iwl_trans_read_mem+0xe/0x20 [iwlwifi]
[   63.289495]  iwl_mvm_check_rt_status+0xbb/0x160 [iwlmvm]
[   63.289511]  iwl_mvm_fast_resume+0xa3/0x1b6 [iwlmvm]
[   63.289521]  __iwl_mvm_mac_start+0xfe/0x2d0 [iwlmvm]
[   63.289530]  iwl_mvm_mac_start+0x59/0xf0 [iwlmvm]
[   63.289541]  drv_start+0x85/0x170 [mac80211]
[   63.289580]  ieee80211_reconfig+0xe1/0x1ed0 [mac80211]
[   63.289607]  ? trace_contention_end+0x7a/0xb0
[   63.289612]  ? __mutex_lock+0x123/0x830
[   63.289619]  ? cfg80211_bss_age+0x55/0x70 [cfg80211]
[   63.289661]  ? rtnl_lock+0x17/0x20
[   63.289665]  ? wiphy_resume+0x62/0x1e0 [cfg80211]
[   63.289686]  ieee80211_resume+0x55/0x70 [mac80211]
[   63.289710]  wiphy_resume+0xbc/0x1e0 [cfg80211]
[   63.289729]  ? wiphy_suspend+0x170/0x170 [cfg80211]
[   63.289747]  dpm_run_callback+0x5b/0x110
[   63.289753]  device_resume+0xc7/0x2d0
[   63.289756]  async_resume+0x1d/0x40
[   63.289758]  async_run_entry_fn+0x2d/0x120
[   63.289760]  process_one_work+0x210/0x730
[   63.289766]  worker_thread+0x193/0x340
[   63.289769]  ? apply_wqattrs_cleanup.part.0+0xc0/0xc0
[   63.289771]  kthread+0xf3/0x120
[   63.289774]  ? kthread_insert_work_sanity_check+0x60/0x60
[   63.289776]  ret_from_fork+0x40/0x70
[   63.289779]  ? kthread_insert_work_sanity_check+0x60/0x60
[   63.289781]  ret_from_fork_asm+0x11/0x20
[   63.289787]  </TASK>
[   63.289788] irq event stamp: 13936
[   63.289789] hardirqs last  enabled at (13942): [<ffffffffa59acfba>] cons=
ole_unlock+0x14a/0x170
[   63.289792] hardirqs last disabled at (13947): [<ffffffffa59acf9f>] cons=
ole_unlock+0x12f/0x170
[   63.289794] softirqs last  enabled at (12300): [<ffffffffc1998a95>] cfg8=
0211_bss_age+0x55/0x70 [cfg80211]
[   63.289813] softirqs last disabled at (12302): [<ffffffffc1d7afab>] iwl_=
trans_pcie_grab_nic_access+0x1b/0x50 [iwlwifi]
[   63.289823] ---[ end trace 0000000000000000 ]---
[   63.289826] iwlwifi 0000:01:00.0: iwlwifi transaction failed, dumping re=
gisters
[   63.289828] iwlwifi 0000:01:00.0: iwlwifi device config registers:
[   63.290275] iwlwifi 0000:01:00.0: 00000000: 27258086 00100406 0280001a 0=
0000010 fcf00004 00000000 00000000 00000000
[   63.290277] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000 00000000 0=
0248086 00000000 000000c8 00000000 000001ff
[   63.290278] iwlwifi 0000:01:00.0: 00000040: 00028010 10008ec0 00100c1f 0=
545e812 10120142 00000000 00000000 00000000
[   63.290279] iwlwifi 0000:01:00.0: 00000060: 00000000 00080812 00000405 0=
0000006 00000002 00000000 00000000 00000000
[   63.290280] iwlwifi 0000:01:00.0: 00000080: 800f0011 00002000 00003000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290281] iwlwifi 0000:01:00.0: 000000a0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290282] iwlwifi 0000:01:00.0: 000000c0: 00000000 00000000 c823d001 0=
d000008 00804005 00000000 00000000 00000000
[   63.290284] iwlwifi 0000:01:00.0: 000000e0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290285] iwlwifi 0000:01:00.0: 00000100: 14c10001 00000000 00000000 0=
0462031 00000000 00002000 00000000 00000000
[   63.290286] iwlwifi 0000:01:00.0: 00000120: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290287] iwlwifi 0000:01:00.0: 00000140: 14c00000 ff000000 000000ff 1=
5410018 10011001 0001001e 00481e1f 40b6000f
[   63.290288] iwlwifi 0000:01:00.0: iwlwifi device memory mapped registers:
[   63.290533] iwlwifi 0000:01:00.0: 00000000: 40880000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290534] iwlwifi 0000:01:00.0: 00000020: 00000011 08040008 00000420 d=
55555d5 d55555d5 d55555d5 80008040 041f0042
[   63.290594] iwlwifi 0000:01:00.0: iwlwifi device AER capability structur=
e:
[   63.290663] iwlwifi 0000:01:00.0: 00000000: 14c10001 00000000 00000000 0=
0462031 00000000 00002000 00000000 00000000
[   63.290664] iwlwifi 0000:01:00.0: 00000020: 00000000 00000000 00000000
[   63.290665] iwlwifi 0000:01:00.0: iwlwifi parent port (0000:00:02.2) con=
fig registers:
[   63.290798] iwlwifi 0000:00:02.2: 00000000: 16341022 00100407 06040000 0=
0810010 00000000 00000000 00010100 000001f1
[   63.290799] iwlwifi 0000:00:02.2: 00000020: fcf0fcf0 0001fff1 00000000 0=
0000000 00000000 00000050 00000000 001200ff
[   63.290800] iwlwifi 0000:00:02.2: 00000040: 00000000 00000000 00000000 0=
0000000 c8035801 00000000 0142a010 00008022
[   63.290801] iwlwifi 0000:00:02.2: 00000060: 00002910 05737813 30120042 0=
0042580 01400000 00010018 00000000 007019bf
[   63.290803] iwlwifi 0000:00:02.2: 00000080: 00000406 0000000e 00010002 0=
0000000 00000000 00000000 00000000 00000000
[   63.290804] iwlwifi 0000:00:02.2: 000000a0: 0081c005 fee00000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290805] iwlwifi 0000:00:02.2: 000000c0: 0000c80d 14531022 a8030008 0=
0000000 00000000 00000000 00000000 00000000
[   63.290806] iwlwifi 0000:00:02.2: 000000e0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290807] iwlwifi 0000:00:02.2: 00000100: 2701000b 01010001 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290808] iwlwifi 0000:00:02.2: 00000120: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290809] iwlwifi 0000:00:02.2: 00000140: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290810] iwlwifi 0000:00:02.2: 00000160: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290811] iwlwifi 0000:00:02.2: 00000180: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290812] iwlwifi 0000:00:02.2: 000001a0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290813] iwlwifi 0000:00:02.2: 000001c0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290814] iwlwifi 0000:00:02.2: 000001e0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[   63.290815] iwlwifi 0000:00:02.2: 00000200: 00000000 00000000 00000000
[   63.290857] iwlwifi 0000:01:00.0: iwl_mvm_check_rt_status failed, device=
 is gone during suspend
[   63.644257] iwlwifi 0000:01:00.0: HW error, resetting before reading
[   63.650214] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   63.650216] iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: -=
469787919
[   63.650219] iwlwifi 0000:01:00.0: Loaded firmware version: 89.202a2f7b.0=
 ty-a0-gf-a0-89.ucode
[   63.650222] iwlwifi 0000:01:00.0: 0xD7DF3FD8 | ADVANCED_SYSASSERT       =
  =20
[   63.650224] iwlwifi 0000:01:00.0: 0xBBDDA603 | trm_hw_status0
[   63.650226] iwlwifi 0000:01:00.0: 0x56FBF22F | trm_hw_status1
[   63.650228] iwlwifi 0000:01:00.0: 0xBE17FF9E | branchlink2
[   63.650230] iwlwifi 0000:01:00.0: 0x7F363EDB | interruptlink1
[   63.650232] iwlwifi 0000:01:00.0: 0xDBD3159E | interruptlink2
[   63.650233] iwlwifi 0000:01:00.0: 0x172F3A94 | data1
[   63.650235] iwlwifi 0000:01:00.0: 0x9BF71489 | data2
[   63.650236] iwlwifi 0000:01:00.0: 0xC92FF43C | data3
[   63.650238] iwlwifi 0000:01:00.0: 0xF88C4ACB | beacon time
[   63.650240] iwlwifi 0000:01:00.0: 0x53527DA5 | tsf low
[   63.650241] iwlwifi 0000:01:00.0: 0x5CBA38FC | tsf hi
[   63.650243] iwlwifi 0000:01:00.0: 0xFFF79FED | time gp1
[   63.650244] iwlwifi 0000:01:00.0: 0xAD3B101D | time gp2
[   63.650246] iwlwifi 0000:01:00.0: 0xB148E1EB | uCode revision type
[   63.650248] iwlwifi 0000:01:00.0: 0xDCFBF5F3 | uCode version major
[   63.650249] iwlwifi 0000:01:00.0: 0xF837C970 | uCode version minor
[   63.650251] iwlwifi 0000:01:00.0: 0x43C37AEF | hw version
[   63.650252] iwlwifi 0000:01:00.0: 0xEE224593 | board version
[   63.650254] iwlwifi 0000:01:00.0: 0xF63DB3A8 | hcmd
[   63.650256] iwlwifi 0000:01:00.0: 0x9FCD276E | isr0
[   63.650257] iwlwifi 0000:01:00.0: 0x4F7CFEDF | isr1
[   63.650259] iwlwifi 0000:01:00.0: 0xBF29DF97 | isr2
[   63.650260] iwlwifi 0000:01:00.0: 0x33533328 | isr3
[   63.650262] iwlwifi 0000:01:00.0: 0x38419101 | isr4
[   63.650264] iwlwifi 0000:01:00.0: 0x643244C7 | last cmd Id
[   63.650265] iwlwifi 0000:01:00.0: 0x71514BC3 | wait_event
[   63.650267] iwlwifi 0000:01:00.0: 0xF4210485 | l2p_control
[   63.650268] iwlwifi 0000:01:00.0: 0x020026F9 | l2p_duration
[   63.650270] iwlwifi 0000:01:00.0: 0x50A43120 | l2p_mhvalid
[   63.650272] iwlwifi 0000:01:00.0: 0xE9812900 | l2p_addr_match
[   63.650273] iwlwifi 0000:01:00.0: 0x89488353 | lmpm_pmg_sel
[   63.650275] iwlwifi 0000:01:00.0: 0x12170048 | timestamp
[   63.650276] iwlwifi 0000:01:00.0: 0x04D922CA | flow_handler
[   63.650585] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[   63.650586] iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 8=
55094539
[   63.650588] iwlwifi 0000:01:00.0: 0xF58DFA0C | ADVANCED_SYSASSERT
[   63.650590] iwlwifi 0000:01:00.0: 0xEFEDF773 | umac branchlink1
[   63.650592] iwlwifi 0000:01:00.0: 0x5E2AAECF | umac branchlink2
[   63.650594] iwlwifi 0000:01:00.0: 0xFF55EE2F | umac interruptlink1
[   63.650595] iwlwifi 0000:01:00.0: 0xF65CE077 | umac interruptlink2
[   63.650597] iwlwifi 0000:01:00.0: 0x5EFFE16D | umac data1
[   63.650598] iwlwifi 0000:01:00.0: 0x8C7E5FDE | umac data2
[   63.650599] iwlwifi 0000:01:00.0: 0x3D930F84 | umac data3
[   63.650599] iwlwifi 0000:01:00.0: 0x60937FFB | umac major
[   63.650600] iwlwifi 0000:01:00.0: 0xA9DFBAD6 | umac minor
[   63.650601] iwlwifi 0000:01:00.0: 0xFB5FE976 | frame pointer
[   63.650602] iwlwifi 0000:01:00.0: 0xC31FFE75 | stack pointer
[   63.650603] iwlwifi 0000:01:00.0: 0xAEE7C3C7 | last host cmd
[   63.650604] iwlwifi 0000:01:00.0: 0xFDD3EBFB | isr status reg
[   63.650882] iwlwifi 0000:01:00.0: IML/ROM dump:
[   63.650883] iwlwifi 0000:01:00.0: 0x00000000 | IML/ROM error/state
[   63.650981] iwlwifi 0000:01:00.0: 0x00000000 | IML/ROM data1
[   63.651039] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[   63.651138] iwlwifi 0000:01:00.0: Fseq Registers:
[   63.651141] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
[   63.651186] iwlwifi 0000:01:00.0: 0x80440007 | FSEQ_TOP_INIT_VERSION
[   63.651232] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[   63.651278] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[   63.651323] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[   63.651367] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[   63.651370] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[   63.651414] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[   63.651459] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[   63.651506] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[   63.651511] iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[   63.651560] iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[   63.651605] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[   63.651608] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[   63.651611] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
[   63.651614] iwlwifi 0000:01:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[   63.651717] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0xc00c0000
[   63.651761] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0x0
[   63.651765] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).

