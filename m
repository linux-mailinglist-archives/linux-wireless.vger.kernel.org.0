Return-Path: <linux-wireless+bounces-23535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F0ACB953
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 18:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBD816862B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D48222587;
	Mon,  2 Jun 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdto8Anc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221352C326D
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880682; cv=none; b=QnYVgqjc1PSZDPWkTdrYiswuPhvlqiqEjalGTQeEjwkMmN1jeCzvpYWCOJCPbedlfJZCCU+Iy87RUyYtBugtxsUA2sLsLxJeVAlzJt8ByTM9mK+Gasy/o6IAwhBqcesFNdBJrWL1M0iLMChqVlWLMm7lWfheC6G4H5Jug7X/9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880682; c=relaxed/simple;
	bh=Q8AGZk9xAEg3eNSbIGG/aDGgeak8LXz310GWEp9RPUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcCUjUP9d+NzMNuQJ5cHQ5dPyaQJ3QrR2nw8ehgZ5Zo5YGXwuK+gP5Bk9KH9QP0ukCeEGnAfUScLdvcRuBT4MmCLbCTTSyc1ZViVZygnvzgeK1uMUnf9DRmvoocgaVkjZZSTvgRr0VZccJK4YbJxcwVgolIEQ10xAalEAHEAO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdto8Anc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so22291385e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748880677; x=1749485477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SYgdS9wcv9CAFQ9rNbAKs2qZ/8f7PDYPFZfJKPal3dw=;
        b=fdto8AncyeCsJitJP/WxjcIk8QeEnKjvCEWLJHhZyCDCIpd5DRW8YfAL4vX9DCt47I
         bw4km/R/nU8nCAyhCfZEG2GdPxIhQogMQZQagK2KqM+GwmnWri2dvrMu6bfyLlLb0IIs
         e1/FMU8JHO0LMuN/I6BkYZqjvGbbeVqYd3U/1ZZ3ItXxTbyYyey8mxY1XPelLc8K9Lts
         tQPjGm6/ECsaoZbyEH7ZEdqiYSQCx1F7oJfjkY03iaxDN3QFNBCwyMGSyd+iG4/tK4ph
         mC2UYbzBMyyi0gcU20tlz9WckxjHp6aMI2+EaosRV2lVQbqWln3bXMgT21koj1JdUcuo
         srrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748880677; x=1749485477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYgdS9wcv9CAFQ9rNbAKs2qZ/8f7PDYPFZfJKPal3dw=;
        b=ULGuSf82wA2fIG1ji+jlietdw43/U6XkbdGgWqB9NLrjaz4h8VwwsO+XTrSOxadyF3
         E0rHnxmWdHAU0ZvK1xoIvBtNnDPbZfeg8pvTElabBiauOhTYWTwG2zdzmXyqTP7pww/N
         waA94wo8xBMhLymFnJ5mQdj7ND8JZ7qQleRvDEL1/68zeioI3fy6fMJWHWqUJrolR2p0
         JauE++/5RQRnoU8PIS5l043qH7osaEnPb4sjy7wBXPqLs/gtKWZHFcYz8UEKWyfhi4WG
         8M2nYerQbwlt7V6IML+OKg+FP1G7z2RaXfsZNc6/hQNLwSJKpdflpDwaOZx6/zowAdM0
         BC7g==
X-Gm-Message-State: AOJu0Yyc4FwMwBTpJxOG18iTuz1pKD5f8xj6whE/jMF1JEdirSs02g3v
	TmjqZeGabOg3TyvnZNK+IZWxkbEHzE91XzWjw5GWWIqO3S190Z7+UfIB
X-Gm-Gg: ASbGncueCpH4L/7e9kyjpde/Ssgt0WuiM641M/+/fqDzCnNVMD/lXFERcym5BTALBZX
	LdSeNLAvBf7YKjJpDuhQn2jO7uu33JMpoEAg+rhR6hIrwN4pg4ear6RtGU7krAoXJAcK0HG8tih
	AwSx4WVPLA1ZDMbrXPaaKkBid9ZdpS5SPvB4tIR39XBUe7oUQ+Vn3mm9mCGM3FU71ND0dB3Absr
	soOf8MBQS/vXfNwbP03i1DCexp3S7y1EZrgpkC8es8Z1vlIZV9T8+Ec9PtbovOaL15fu/av8quO
	x1fjGYXf8B4Tj/1XhJkjUZpW3WTykuK0SzQD/KtmMTJhSLqpcyaHCpsOGHnTKXTheY/EWvwk/es
	=
X-Google-Smtp-Source: AGHT+IGn9vQODjf11TszpaUBKNminTCApxdJ/f8lQjGLV6nFzLSa79P+20jEzE0u+w2xbLAGQNFvXQ==
X-Received: by 2002:a7b:c04a:0:b0:451:df07:d8e0 with SMTP id 5b1f17b1804b1-451df07d938mr21712035e9.11.1748880676919;
        Mon, 02 Jun 2025 09:11:16 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:eaf:3101:2d68:caee:7294:3fe1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a03bdsm15734541f8f.91.2025.06.02.09.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:11:16 -0700 (PDT)
Date: Mon, 2 Jun 2025 17:11:14 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
Message-ID: <aD3NIippz-mmJsSY@debian.local>
References: <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
 <CAP-bSRb_f1A=_+A9x8J75socYsKFKDtysZ-m0+6Ks7NdSjQ0-Q@mail.gmail.com>
 <b2674ab2706c2ed81734f2c3d6261511414186bc.camel@intel.com>
 <Z-SdYIm_lDvmCcO-@debian.local>
 <2a8fe208aaae404a724dcd9844afc2182c1ebf45.camel@intel.com>
 <43c0e4554151e015c068b79b5da7231f8674a474.camel@intel.com>
 <CAP-bSRb+qO-FhtjrGThCy2OoXU-jb3rkzzyUUkk4vP_P-u53Cg@mail.gmail.com>
 <d3f5b6aea39528ab7647e69f66fa90b26623a543.camel@intel.com>
 <CAP-bSRb_PeuFMqOjJu=akYsYANQ2ek8N1oR=8RiPXBeefM5_NA@mail.gmail.com>
 <0bfeda4daa039465e128a2eb375f09b585f47182.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0bfeda4daa039465e128a2eb375f09b585f47182.camel@intel.com>

On Sun, Jun 01, 2025 at 05:46:24AM +0000, Grumbach, Emmanuel wrote:
> On Sat, 2025-05-31 at 22:24 +0100, Chris Bainbridge wrote:
> > On Fri, 28 Mar 2025 at 04:24, Grumbach, Emmanuel
> > <emmanuel.grumbach@intel.com> wrote:
> > >=20
> > > In any case, the patch will be reviewed internally and follow its
> > > way
> > > upstream following the regular process.
> >=20
> > Hi, did this patch ever get merged? I was just testing another issue
> > and
> > noticed that iwlwifi still dumps this error on resume in the latest
> > 6.15
> > mainline git on this particular laptop.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D15220a257319ffe3bf95796326dfe0aacdbeb1c4
>=20
> It is included in 6.15.

I tested v6.15 and it is fixed. But it appears to have been broken by
subsequent commit v6.15-7613-g1b98f357dadd (Merge tag 'net-next-6.16'):

[  569.821023] ------------[ cut here ]------------
[  569.821024] Timeout waiting for hardware access (CSR_GP_CNTRL 0x08040008)
[  569.821045] WARNING: CPU: 5 PID: 4770 at drivers/net/wireless/intel/iwlw=
ifi/pcie/trans.c:2448 __iwl_trans_pcie_grab_nic_access+0x144/0x150 [iwlwifi]
[  569.821061] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq xt_conn=
track nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf=
_tables br_netfilter bridge stp llc ccm overlay qrtr rfcomm cmac algif_hash=
 algif_skcipher af_alg bnep binfmt_misc ext4 mbcache jbd2 nls_ascii nls_cp4=
37 vfat fat snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_comp=
onent iwlmvm snd_hda_codec_hdmi intel_rapl_msr snd_usb_audio snd_hda_intel =
mac80211 intel_rapl_common snd_intel_dspcfg snd_usbmidi_lib snd_hda_codec u=
vcvideo kvm_amd libarc4 snd_rawmidi snd_hwdep btusb videobuf2_vmalloc iwlwi=
fi btrtl videobuf2_memops snd_hda_core snd_seq_device btintel kvm uvc btbcm=
 videobuf2_v4l2 snd_pcm cfg80211 irqbypass btmtk videodev snd_timer bluetoo=
th rapl pcspkr wmi_bmof ee1004 videobuf2_common k10temp snd mc rfkill ccp s=
g soundcore battery ac joydev evdev msr parport_pc ppdev lp parport nvme_fa=
brics efi_pstore configfs nfnetlink efivarfs ip_tables
[  569.821098]  x_tables autofs4 crc32c_cryptoapi btrfs blake2b_generic xor=
 raid6_pq dm_crypt hid_microsoft ff_memless hid_cmedia r8153_ecm cdc_ether =
usbnet r8152 mii usbhid amdgpu sd_mod nouveau uas usb_storage drm_gpuvm mxm=
_wmi drm_client_lib i2c_algo_bit drm_panel_backlight_quirks drm_ttm_helper =
drm_suballoc_helper ttm amdxcp drm_exec hid_multitouch drm_buddy dm_mod hid=
_generic gpu_sched ahci r8169 libahci ucsi_acpi sp5100_tco drm_display_help=
er realtek xhci_pci i2c_hid_acpi nvme libata typec_ucsi ghash_clmulni_intel=
 watchdog mdio_devres drm_kms_helper xhci_hcd i2c_hid roles nvme_core scsi_=
mod sha512_ssse3 i2c_piix4 libphy cec hid usbcore typec video nvme_keyring =
aesni_intel serio_raw scsi_common i2c_smbus crc16 mdio_bus rc_core usb_comm=
on drm nvme_auth wmi button
[  569.821129] CPU: 5 UID: 0 PID: 4770 Comm: kworker/u64:14 Not tainted 6.1=
5.0-09114-g7379fa3aa8d0 #429 PREEMPT(voluntary)=20
[  569.821132] Hardware name: LENOVO 82N6/LNVNB161216, BIOS GKCN65WW 01/16/=
2024
[  569.821133] Workqueue: async async_run_entry_fn
[  569.821136] RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x144/0x150 [iwlw=
ifi]
[  569.821145] Code: bc c6 31 c0 eb 82 be 03 00 00 00 48 89 df e8 e3 fc ff =
ff eb e5 89 c6 48 c7 c7 38 d3 82 c2 c6 05 b0 7f 76 00 01 e8 9c 4b f3 c5 <0f=
> 0b eb a3 0f 1f 84 00 00 00 00 00 66 0f 1f 00 0f 1f 44 00 00 55
[  569.821146] RSP: 0018:ffffad114d0dfac0 EFLAGS: 00010286
[  569.821147] RAX: 0000000000000000 RBX: ffff90db20b18028 RCX: 00000000000=
00027
[  569.821148] RDX: ffff90e0c9a9e188 RSI: 0000000000000001 RDI: ffff90e0c9a=
9e180
[  569.821149] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[  569.821149] R10: 0000000000000000 R11: 0000000000000003 R12: 00000000080=
40008
[  569.821150] R13: ffff90db20b19db8 R14: 0000000000000001 R15: 00000000000=
00011
[  569.821150] FS:  0000000000000000(0000) GS:ffff90e1401c6000(0000) knlGS:=
0000000000000000
[  569.821151] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  569.821152] CR2: 0000000000000000 CR3: 000000001863b000 CR4: 0000000000f=
50ef0
[  569.821153] PKRU: 55555554
[  569.821154] Call Trace:
[  569.821155]  <TASK>
[  569.821158]  ? iwl_trans_pcie_grab_nic_access+0x1a/0x50 [iwlwifi]
[  569.821165]  iwl_trans_pcie_grab_nic_access+0x2c/0x50 [iwlwifi]
[  569.821172]  iwl_trans_pcie_read_mem+0x46/0x140 [iwlwifi]
[  569.821180]  iwl_fwrt_read_err_table+0x59/0x90 [iwlwifi]
[  569.821190]  iwl_mvm_check_rt_status+0x3a/0x110 [iwlmvm]
[  569.821202]  ? iwl_mvm_mac_start+0x2e/0xe0 [iwlmvm]
[  569.821211]  ? iwl_fw_dbg_read_d3_debug_data+0x4f/0x130 [iwlwifi]
[  569.821220]  iwl_mvm_fast_resume+0xa5/0x1e0 [iwlmvm]
[  569.821227]  __iwl_mvm_mac_start+0xe2/0x2c0 [iwlmvm]
[  569.821234]  iwl_mvm_mac_start+0x4f/0xe0 [iwlmvm]
[  569.821240]  drv_start+0x73/0x1d0 [mac80211]
[  569.821267]  ieee80211_reconfig+0x97/0x1ec0 [mac80211]
[  569.821291]  ? wiphy_resume+0x61/0x240 [cfg80211]
[  569.821331]  ? __mutex_lock+0xdb/0xed0
[  569.821340]  wiphy_resume+0xa7/0x240 [cfg80211]
[  569.821357]  ? addresses_show+0x90/0x90 [cfg80211]
[  569.821372]  dpm_run_callback+0x5f/0x1e0
[  569.821375]  device_resume+0xd9/0x200
[  569.821376]  async_resume+0x1d/0x30
[  569.821378]  async_run_entry_fn+0x2e/0x130
[  569.821380]  process_one_work+0x22b/0x5b0
[  569.821383]  worker_thread+0x1da/0x3d0
[  569.821384]  ? bh_worker+0x260/0x260
[  569.821385]  kthread+0x10a/0x250
[  569.821387]  ? kthreads_online_cpu+0x130/0x130
[  569.821388]  ret_from_fork+0x20c/0x270
[  569.821390]  ? kthreads_online_cpu+0x130/0x130
[  569.821391]  ret_from_fork_asm+0x11/0x20
[  569.821394]  </TASK>
[  569.821395] irq event stamp: 0
[  569.821395] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  569.821397] hardirqs last disabled at (0): [<ffffffff87af6ef0>] copy_pro=
cess+0xbb0/0x2da0
[  569.821398] softirqs last  enabled at (0): [<ffffffff87af6ef0>] copy_pro=
cess+0xbb0/0x2da0
[  569.821399] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  569.821400] ---[ end trace 0000000000000000 ]---
[  569.821402] iwlwifi 0000:04:00.0: iwlwifi transaction failed, dumping re=
gisters
[  569.821403] iwlwifi 0000:04:00.0: iwlwifi device config registers:
[  569.821512] iwlwifi 0000:04:00.0: 00000000: 27238086 00100406 0280001a 0=
0000010 d1600004 00000000 00000000 00000000
[  569.821514] iwlwifi 0000:04:00.0: 00000020: 00000000 00000000 00000000 1=
6541a56 00000000 000000c8 00000000 000001ff
[  569.821515] iwlwifi 0000:04:00.0: 00000040: 00028010 10008ec0 00100c1f 0=
445e812 10120142 00000000 00000000 00000000
[  569.821515] iwlwifi 0000:04:00.0: 00000060: 00000000 00080812 00000405 0=
0000006 00010002 00000000 00000000 00000000
[  569.821516] iwlwifi 0000:04:00.0: 00000080: 800f0011 00002000 00003000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821517] iwlwifi 0000:04:00.0: 000000a0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821518] iwlwifi 0000:04:00.0: 000000c0: 00000000 00000000 c823d001 0=
d000008 00804005 00000000 00000000 00000000
[  569.821518] iwlwifi 0000:04:00.0: 000000e0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821519] iwlwifi 0000:04:00.0: 00000100: 14c10001 00000000 00000000 0=
0462031 00000000 00002000 00000000 00000000
[  569.821520] iwlwifi 0000:04:00.0: 00000120: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821521] iwlwifi 0000:04:00.0: 00000140: 14c00000 ff000000 000000ff 1=
5410018 10011001 0001001e 00481e1f 60010000
[  569.821521] iwlwifi 0000:04:00.0: iwlwifi device memory mapped registers:
[  569.821554] iwlwifi 0000:04:00.0: 00000000: 00880000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821555] iwlwifi 0000:04:00.0: 00000020: 00000011 08040008 00000340 d=
55555d5 d55555d5 d55555d5 80008040 001f0042
[  569.821573] iwlwifi 0000:04:00.0: iwlwifi device AER capability structur=
e:
[  569.821584] iwlwifi 0000:04:00.0: 00000000: 14c10001 00000000 00000000 0=
0462031 00000000 00002000 00000000 00000000
[  569.821585] iwlwifi 0000:04:00.0: 00000020: 00000000 00000000 00000000
[  569.821586] iwlwifi 0000:04:00.0: iwlwifi parent port (0000:00:02.2) con=
fig registers:
[  569.821630] iwlwifi 0000:00:02.2: 00000000: 16341022 00100407 06040000 0=
0810010 00000000 00000000 00040400 000001f1
[  569.821631] iwlwifi 0000:00:02.2: 00000020: d160d160 0001fff1 00000000 0=
0000000 00000000 00000050 00000000 000200ff
[  569.821632] iwlwifi 0000:00:02.2: 00000040: 00000000 00000000 00000000 0=
0000000 c8035801 00000000 0142a010 00008022
[  569.821632] iwlwifi 0000:00:02.2: 00000060: 00002910 04737813 30120c42 0=
0042580 01400000 00010018 00000000 007019bf
[  569.821633] iwlwifi 0000:00:02.2: 00000080: 00000406 0000000e 00010003 0=
0000000 00000000 00000000 00000000 00000000
[  569.821634] iwlwifi 0000:00:02.2: 000000a0: 0081c005 fee00000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821635] iwlwifi 0000:00:02.2: 000000c0: 0000c80d 388617aa a8030008 0=
0000000 00000000 00000000 00000000 00000000
[  569.821635] iwlwifi 0000:00:02.2: 000000e0: 00000000 0006a07c 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821636] iwlwifi 0000:00:02.2: 00000100: 2701000b 01010001 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821637] iwlwifi 0000:00:02.2: 00000120: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821637] iwlwifi 0000:00:02.2: 00000140: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821639] iwlwifi 0000:00:02.2: 00000160: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821639] iwlwifi 0000:00:02.2: 00000180: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821640] iwlwifi 0000:00:02.2: 000001a0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821640] iwlwifi 0000:00:02.2: 000001c0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821641] iwlwifi 0000:00:02.2: 000001e0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000
[  569.821641] iwlwifi 0000:00:02.2: 00000200: 00000000 00000000 00000000
[  569.821645] iwlwifi 0000:04:00.0: iwl_mvm_check_rt_status failed, device=
 is gone during suspend
[  569.859044] iwlwifi 0000:04:00.0: HW error, resetting before reading
[  569.867222] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[  569.867223] iwlwifi 0000:04:00.0: Transport status: 0x00001042, valid: -=
837590520
[  569.867225] iwlwifi 0000:04:00.0: Loaded firmware version: 77.f31a351f.0=
 cc-a0-77.ucode
[  569.867227] iwlwifi 0000:04:00.0: 0x4914172A | ADVANCED_SYSASSERT       =
  =20
[  569.867229] iwlwifi 0000:04:00.0: 0xA9F8D040 | trm_hw_status0
[  569.867231] iwlwifi 0000:04:00.0: 0xFCD4020A | trm_hw_status1
[  569.867232] iwlwifi 0000:04:00.0: 0x0AAA3201 | branchlink2
[  569.867233] iwlwifi 0000:04:00.0: 0x38E445D1 | interruptlink1
[  569.867235] iwlwifi 0000:04:00.0: 0x018A42A2 | interruptlink2
[  569.867236] iwlwifi 0000:04:00.0: 0x10A93903 | data1
[  569.867237] iwlwifi 0000:04:00.0: 0x890A0006 | data2
[  569.867238] iwlwifi 0000:04:00.0: 0x77480560 | data3
[  569.867239] iwlwifi 0000:04:00.0: 0xE0C16D43 | beacon time
[  569.867241] iwlwifi 0000:04:00.0: 0x5AC0C404 | tsf low
[  569.867242] iwlwifi 0000:04:00.0: 0x482B5E00 | tsf hi
[  569.867243] iwlwifi 0000:04:00.0: 0xA0CEC818 | time gp1
[  569.867244] iwlwifi 0000:04:00.0: 0x45261000 | time gp2
[  569.867245] iwlwifi 0000:04:00.0: 0x184068BB | uCode revision type
[  569.867246] iwlwifi 0000:04:00.0: 0x5A46AE2B | uCode version major
[  569.867248] iwlwifi 0000:04:00.0: 0x3E016C53 | uCode version minor
[  569.867249] iwlwifi 0000:04:00.0: 0x231E5AF5 | hw version
[  569.867250] iwlwifi 0000:04:00.0: 0x8E61F260 | board version
[  569.867251] iwlwifi 0000:04:00.0: 0xA1500048 | hcmd
[  569.867252] iwlwifi 0000:04:00.0: 0xC6E2E480 | isr0
[  569.867253] iwlwifi 0000:04:00.0: 0xC9892883 | isr1
[  569.867255] iwlwifi 0000:04:00.0: 0xD01F76E0 | isr2
[  569.867256] iwlwifi 0000:04:00.0: 0x8139B741 | isr3
[  569.867257] iwlwifi 0000:04:00.0: 0x19227480 | isr4
[  569.867258] iwlwifi 0000:04:00.0: 0x228C3280 | last cmd Id
[  569.867259] iwlwifi 0000:04:00.0: 0xE0348003 | wait_event
[  569.867260] iwlwifi 0000:04:00.0: 0xC41C4530 | l2p_control
[  569.867261] iwlwifi 0000:04:00.0: 0xEFDBD77B | l2p_duration
[  569.867263] iwlwifi 0000:04:00.0: 0xE6FBAAF7 | l2p_mhvalid
[  569.867264] iwlwifi 0000:04:00.0: 0xABFFBB9E | l2p_addr_match
[  569.867265] iwlwifi 0000:04:00.0: 0x7DFFD7FD | lmpm_pmg_sel
[  569.867266] iwlwifi 0000:04:00.0: 0xA3387FBD | timestamp
[  569.867267] iwlwifi 0000:04:00.0: 0xB9EFFFFF | flow_handler
[  569.867325] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[  569.867326] iwlwifi 0000:04:00.0: Transport status: 0x00001042, valid: 2=
097381227
[  569.867328] iwlwifi 0000:04:00.0: 0x49218A45 | ADVANCED_SYSASSERT
[  569.867330] iwlwifi 0000:04:00.0: 0x52AEF04C | umac branchlink1
[  569.867331] iwlwifi 0000:04:00.0: 0x0F618944 | umac branchlink2
[  569.867332] iwlwifi 0000:04:00.0: 0xBDD64DAF | umac interruptlink1
[  569.867333] iwlwifi 0000:04:00.0: 0x08042D49 | umac interruptlink2
[  569.867335] iwlwifi 0000:04:00.0: 0x5DFDDFB8 | umac data1
[  569.867336] iwlwifi 0000:04:00.0: 0x142CF404 | umac data2
[  569.867337] iwlwifi 0000:04:00.0: 0xFAF87F65 | umac data3
[  569.867338] iwlwifi 0000:04:00.0: 0x060B40B0 | umac major
[  569.867339] iwlwifi 0000:04:00.0: 0xD3FEE3A8 | umac minor
[  569.867340] iwlwifi 0000:04:00.0: 0x44AC2A11 | frame pointer
[  569.867342] iwlwifi 0000:04:00.0: 0x9755CFFB | stack pointer
[  569.867343] iwlwifi 0000:04:00.0: 0xC8574091 | last host cmd
[  569.867344] iwlwifi 0000:04:00.0: 0xD9FA3CE7 | isr status reg
[  569.867383] iwlwifi 0000:04:00.0: IML/ROM dump:
[  569.867384] iwlwifi 0000:04:00.0: 0x00000000 | IML/ROM error/state
[  569.867426] iwlwifi 0000:04:00.0: 0x00000000 | IML/ROM data1
[  569.867452] iwlwifi 0000:04:00.0: 0x00000000 | IML/ROM WFPM_AUTH_KEY_0
[  569.867475] iwlwifi 0000:04:00.0: Fseq Registers:
[  569.867525] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_ERROR_CODE
[  569.867590] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_TOP_INIT_VERSION
[  569.867653] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_CNVIO_INIT_VERSION
[  569.867717] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_OTP_VERSION
[  569.867781] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_TOP_CONTENT_VERSION
[  569.867845] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_ALIVE_TOKEN
[  569.867909] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_CNVI_ID
[  569.867972] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_CNVR_ID
[  569.868036] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | CNVI_AUX_MISC_CHIP
[  569.868100] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | CNVR_AUX_MISC_CHIP
[  569.868163] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[  569.868226] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[  569.868289] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[  569.868352] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_WIFI_FSEQ_VERSION
[  569.868415] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_BT_FSEQ_VERSION
[  569.868479] iwlwifi 0000:04:00.0: 0xA5A5A5A2 | FSEQ_CLASS_TP_VERSION
[  569.868548] iwlwifi 0000:04:00.0: UMAC CURRENT PC: 0xa5a5a5a2
[  569.868611] iwlwifi 0000:04:00.0: LMAC1 CURRENT PC: 0xa5a5a5a2
[  569.868614] iwlwifi 0000:04:00.0: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).

