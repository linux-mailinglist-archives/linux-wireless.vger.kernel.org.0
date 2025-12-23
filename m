Return-Path: <linux-wireless+bounces-30071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B6CD7FA7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 934EC300A35C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C0222D792;
	Tue, 23 Dec 2025 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kiCtD6Nc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B3221290
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460965; cv=none; b=XP8BQVuLMy1IE34s//1g82QeKBJ9R/rxaVtZGjp7gNE0UvTVDE7z7cWxsZ8bee+ReOsY65+Z/uyvCvgCaY+Elr9f7G+FCPVRwIjwvK9EPNNBxzxq22ZGwgm385nDg3XIENLqAjVZMyqvoeCMm/+C0d66BQL5/sZApv4J06049kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460965; c=relaxed/simple;
	bh=ocOXyxvOHMbASj/GheevLKKiPkcvOj52B5gWNC720Gk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=MTPpGeJ4RVFBW/Jkp/j+Sqj56hFvGSM03ZxkpIn1HSwpcijeBc+lX+6LFrVkpYhrq9eGSlmgqXix6c0+gDB4FlS3ui4M44smmJKBmTEA3c7jiW+WeWHEXeIOlQXoSdHDSSYAbKbA6PvEI46JSysPC73gdzIMuJZMOKtmrLT7Cjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kiCtD6Nc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN3ZwtC6606290, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766460958; bh=eThyjioCy34mRC9GIBIrry+5R9WQHlJtv0t+xYpMfEQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=kiCtD6Nc4xRddakWceb2f9nTA01wYiJbDOGPtZmtN8llGhXm/6UO5asHr8QHXeh0K
	 RonFWVz235RClKRFlsPCdJbLIC652EG2U0dbNXyQA0ss3vsv2J/clqi07hSSRuFXAq
	 1StZgcnt3/B8qb7yKpATLWyjGRVY5gKgBh1YgbGw9SLSdNtb9i7eFP8DiPoFNKmvKk
	 9FClc4/UsgcfQaA3cIBc0cQVEB5mGylNtDSTkpdBcxp3xCEry9UTElYxyKisiCbYV/
	 laMwtWV6h/X/3DQSbOmJHdfID+CUdtg8964spPik2Bl8ecb4z8eJKcBAGNZUKm5meO
	 uUtl7ZYU962ew==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN3ZwtC6606290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 11:35:58 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:35:57 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:35:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: 8822b: Avoid WARNING in rtw8822b_config_trx_mode()
In-Reply-To: <fb9a3444-9319-4aa2-8719-35a6308bf568@gmail.com>
References: <fb9a3444-9319-4aa2-8719-35a6308bf568@gmail.com>
Message-ID: <6510895a-6ff6-44d1-8cf1-d0ec14e4cf56@RTKEXHMBS04.realtek.com.tw>
Date: Tue, 23 Dec 2025 11:35:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> rtw8822b_set_antenna() can be called from userspace when the chip is
> powered off. In that case a WARNING is triggered in
> rtw8822b_config_trx_mode() because trying to read the RF registers
> when the chip is powered off returns an unexpected value.
>=20
> Call rtw8822b_config_trx_mode() in rtw8822b_set_antenna() only when
> the chip is powered on.
>=20
> ------------[ cut here ]------------
> write RF mode table fail
> WARNING: CPU: 0 PID: 7183 at rtw8822b.c:824 rtw8822b_config_trx_mode.cons=
tprop.0+0x835/0x840 [rtw88_8822b]
> Modules linked in: rtw88_8723du(OE) rtw88_8821cu(OE) rtw88_8822bu(OE) rtw=
88_8822cu(OE) rtw88_8821au(OE) rtw88_8812au(OE) rtw88_8814au(OE) rtw88_8723=
d(OE) rtw88_8821c(OE) rtw88_8822b(OE) rtw88_8822c(OE) rtw88_8821a(OE) rtw88=
_8812a(OE) rtw88_8814a(OE) rtw88_88xxa(OE) rtw88_8723x(OE) rtw88_usb(OE) rt=
w88_core(OE) uinput ccm rtl8xxxu(OE) mac80211 libarc4 cfg80211 rfcomm snd_s=
eq_dummy snd_hrtimer snd_seq snd_seq_device cmac algif_hash algif_skcipher =
af_alg bnep snd_sof_amd_acp70 snd_sof_amd_acp63 snd_sof_amd_vangogh snd_sof=
_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xtens=
a_dsp snd_sof snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match snd_amd_sdw_a=
cpi intel_rapl_msr soundwire_amd amd_atl uvcvideo soundwire_generic_allocat=
ion intel_rapl_common videobuf2_vmalloc soundwire_bus joydev snd_soc_sdca s=
nd_ctl_led uvc snd_hda_codec_alc269 vfat fat snd_hda_scodec_component mouse=
dev snd_hda_codec_atihdmi snd_hda_codec_realtek_lib btusb btrtl snd_soc_cor=
e snd_hda_codec_generic videobuf2_memops kvm_amd
>  btintel snd_compress snd_hda_codec_hdmi ac97_bus btbcm videobuf2_v4l2 po=
lyval_clmulni btmtk snd_pcm_dmaengine snd_hda_intel videobuf2_common snd_rp=
l_pci_acp6x snd_hda_codec ghash_clmulni_intel snd_acp_pci ee1004 hid_multit=
ouch snd_amd_acpi_mach videodev aesni_intel bluetooth snd_acp_legacy_common=
 mc snd_hda_core snd_pci_acp6x rapl snd_pci_acp5x snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_rn_pci_acp3x snd_hwdep wmi_bmof lenovo_wmi_hotkey_utilities =
sp5100_tco snd_acp_config snd_pcm acpi_cpufreq ideapad_laptop snd_timer i2c=
_piix4 snd_soc_acpi snd platform_profile k10temp sparse_keymap i2c_smbus cc=
p soundcore snd_pci_acp3x rfkill i2c_hid_acpi i2c_hid mac_hid vboxnetflt(OE=
) vboxnetadp(OE) vboxdrv(OE) kvm irqbypass i2c_dev crypto_user ntsync loop =
dm_mod nfnetlink ip_tables x_tables amdgpu amdxcp i2c_algo_bit drm_ttm_help=
er ttm drm_exec nvme gpu_sched serio_raw drm_suballoc_helper sdhci_acpi nvm=
e_core drm_panel_backlight_quirks sdhci drm_buddy drm_display_helper video =
nvme_keyring mmc_core cec nvme_auth wmi
> Unloaded tainted modules: rtw88_core(OE):1 rtw88_usb(OE):1 rtw88_88xxa(OE=
):1 rtw88_8723x(OE):1 rtw88_8723d(OE):1 rtw88_8821c(OE):1 rtw88_8822b(OE):1=
 rtw88_8822c(OE):1 rtw88_8821a(OE):1 rtw88_8812a(OE):1 rtw88_8814a(OE):1 rt=
w88_8723du(OE):1 rtw88_8821cu(OE):1 rtw88_8822bu(OE):1 rtw88_8822cu(OE):1 r=
tw88_8821au(OE):1 rtw88_8812au(OE):1 rtw88_8814au(OE):1 [last unloaded: rtw=
88_core(OE)]
> CPU: 0 UID: 0 PID: 7183 Comm: iw Tainted: G        W  OE       6.17.5-arc=
h1-1 #1 PREEMPT(full)  01c39fc421df2af799dd5e9180b572af860b40c1
> Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> Hardware name: LENOVO 82KR/LNVNB161216, BIOS HBCN18WW 08/27/2021
> RIP: 0010:rtw8822b_config_trx_mode.constprop.0+0x835/0x840 [rtw88_8822b]
> Code: 28 0d 60 c2 e8 2c a6 b8 c1 0f 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5=
e 41 5f c3 cc cc cc cc 48 c7 c7 76 0c 60 c2 e8 0b a6 b8 c1 <0f> 0b eb dd 0f=
 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffd082166d76a8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff890b2ee72020 RCX: 0000000000000027
> RDX: ffff890b8ec1cfc8 RSI: 0000000000000001 RDI: ffff890b8ec1cfc0
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000fff7ffff
> R10: ffffffff8699d880 R11: ffffd082166d7540 R12: 0000000000000003
> R13: 0000000000000003 R14: 0000000000000002 R15: 0000000000000033
> FS:  00007efc327b4e80(0000) GS:ffff890c08306000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056308da1b720 CR3: 0000000284c25000 CR4: 00000000003506f0
> Call Trace:
>  <TASK>
>  rtw8822b_set_antenna+0x57/0x70 [rtw88_8822b 370206f42e5890d8d5f48eb358b7=
59efa37c422b]
>  rtw_ops_set_antenna+0x50/0x80 [rtw88_core 711c8fb4f686162be4625b1d0b8e8c=
6a5ac850fb]
>  ieee80211_set_antenna+0x60/0x100 [mac80211 f1845d85d2ecacf3b71867635a050=
ece90486cf3]
>  nl80211_set_wiphy+0x384/0xe00 [cfg80211 296485ee85696d2150309a6d21a7fbca=
83d3dbda]
>  ? netdev_run_todo+0x63/0x550
>  genl_family_rcv_msg_doit+0xfc/0x160
>  genl_rcv_msg+0x1aa/0x2b0
>  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211 296485ee85696d2150309a6d21a=
7fbca83d3dbda]
>  ? __pfx_nl80211_set_wiphy+0x10/0x10 [cfg80211 296485ee85696d2150309a6d21=
a7fbca83d3dbda]
>  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211 296485ee85696d2150309a6d21=
a7fbca83d3dbda]
>  ? __pfx_genl_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x59/0x110
>  genl_rcv+0x28/0x40
>  netlink_unicast+0x285/0x3c0
>  ? __alloc_skb+0xdb/0x1a0
>  netlink_sendmsg+0x20d/0x430
>  ____sys_sendmsg+0x39f/0x3d0
>  ? import_iovec+0x2f/0x40
>  ___sys_sendmsg+0x99/0xe0
>  ? refill_obj_stock+0x12e/0x240
>  __sys_sendmsg+0x8a/0xf0
>  do_syscall_64+0x81/0x970
>  ? do_syscall_64+0x81/0x970
>  ? ksys_read+0x73/0xf0
>  ? do_syscall_64+0x81/0x970
>  ? count_memcg_events+0xc2/0x190
>  ? handle_mm_fault+0x1d7/0x2d0
>  ? do_user_addr_fault+0x21a/0x690
>  ? exc_page_fault+0x7e/0x1a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7efc324931ce
> Code: 4d 89 d8 e8 64 be 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 8=
3 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39=
 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
> RSP: 002b:00007ffd1d10c000 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00005630bd1ee400 RCX: 00007efc324931ce
> RDX: 0000000000000000 RSI: 00007ffd1d10c090 RDI: 0000000000000003
> RBP: 00007ffd1d10c010 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00005630bd1ee4d0
> R13: 00005630bd1f3680 R14: 00007ffd1d10c090 R15: 0000000000000001
>  </TASK>
> ---[ end trace 0000000000000000 ]---
>=20
> Link: https://github.com/lwfinger/rtw88/issues/366
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

44d1f624bbdd wifi: rtw88: 8822b: Avoid WARNING in rtw8822b_config_trx_mode(=
)

---
https://github.com/pkshih/rtw.git


