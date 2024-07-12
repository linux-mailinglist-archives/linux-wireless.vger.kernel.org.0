Return-Path: <linux-wireless+bounces-10208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA1692F94F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 13:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4933BB234C6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 11:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A39156F53;
	Fri, 12 Jul 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="dd5lVODX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56915B96F
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782411; cv=none; b=ODn7ssGoU+aSi1M7EpZLAWkaH64oudk6CEqY9LS8sl/vpYmrT4kFIU79yNfWTzMkSPXRlwrE/NclAqFORNqliYw9zRtJ8WQn2T+dWaEVM0OB89ASNhh2itwzUlj79UOY+P4xFRu/lqzoAYHL4J0G0jdF6o1ATOvZEr3wrsdHr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782411; c=relaxed/simple;
	bh=3OABt4Yxxf04HhhBLhMWVaamEYt7JIFRTKsV7vZu874=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oit7x7qmlqMvx9Uy4jbhWKUaxR39jAyTcuvRLQ5ZX1jlJD4xPhMHivUMQ81rKck4yn/bV5oVbBWB/R83d/pLdf72vXDGNWxfRYalI7J4+z+0LGAqMYATJCAn0zfEf05Y8ErD2c1izivj0gwuIwc62skM4xdAR4nAAn7FzTVz0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=dd5lVODX; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720782389; x=1721387189; i=spasswolf@web.de;
	bh=q92fhPX4kXDIj3XC5L/JsimBcmHFEBNccMRA9m/iVI0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dd5lVODXCKY0HkQQLVPYmMqug/MWvz4/wooGXikb2eo0m4+i496LPXQahiDbmDJC
	 4k+vCHokOJFldJCZwvwpzlXvPqUch489Dsc0BAA88lLS0l28HQfNYkRdwukpqNXEi
	 E2TjY8sedhULZ03pCLVUOBfdVfI6u3055OFLpA6WK76RhOnxIrXmvBQsEL00bdwdk
	 xzo8qpdFqmOYpCeLu8EhznGd20x8we4rZf3vzgO+u6W9/58B0oPFPyNrSzMC6l0Eo
	 w8Zo4Skno7LnChikA8zGKb4J1QQNK2PRpcmDXCgdRHpSmuKWx/g9v3SPiGzB+kXpT
	 Bay1FdPphpAlOVnDKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5o3-1samoP41Pl-00DRL9; Fri, 12
 Jul 2024 13:06:29 +0200
Message-ID: <adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
From: Bert Karwatzki <spasswolf@web.de>
To: Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
 linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
 mingyen.hsieh@mediatek.com, nbd@nbd.name, sean.wang@mediatek.com,
 spasswolf@web.de
Date: Fri, 12 Jul 2024 13:06:26 +0200
In-Reply-To: <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
References: <20240711175156.4465-1-spasswolf@web.de>
	 <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bf/j34gYdq9Wl8QGkxFsDGe/yreEyB3/pTPMiSkx43guFk44MFa
 hWN5JRAk2gADTzGYz3yAFizw1QUl80qK4QTXZrTEk216ZSqye9PLJwiM8u53e47HC0li8z+
 FfHs/QqzHQkj3xsIbDTyVTOXTFViC9wuWtvoW2OWd8rrJgO3J/EJ+lWeLHeQ5Y6UeJeWKiD
 S0dh7wgsXYL3hh93MtJDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ix/YJ0xf3RM=;PauEsIEKUE0N9RJFz7f0gLIZjtK
 8lhvRM9A/CELsV3O8hf77TOrKrH/QxxwXoGUJR+UM/9pu1MBd1zP9ok56gioHHYfsIsC2fmy3
 RteC6ueVv3DcqjzNGSacU0vPHQW/93VWh6wIkQNEZyFAco2TXG12yPeJuZBHRJ/pKnPJmddo7
 OrDSb+c1BK3n6RMwISYBqltLEjVPT5dsi0HcQX53VsNZcY0ULKfd29YgJZuYuSQ229f79b9Uu
 vdGS/BvfzrdbskpudILnFn1Wd1AUCb/zoylxnglmcz1g+CkhnorAGrsqwro+LUiuVSuLv1RV/
 L5ijTzlouNigUl5GbX1j6Kqyi8AAmjTgtFqUxGUghvLltOhswXlXtFPT432GXbh0cSP28q/Qy
 hYNXMTHusttclKIfKa7ip/o2ngQw+pRpeOGQ3aASN0aS1mEk7nBgWH1uPAKLJITHBRU5wdbcC
 H6nHLHGVgeHbMzS3K2xZC0JPuN2qSWt86lfTvmtLyu9HjLqSixpCGhkeliLShCoJFOtemHEuO
 fr5chBMQxauYoyAODDPsDWYRcoxQCsNPaclfBvlyUMqgcFzbC1st7xvU6oixqT6uXGIsPxn7V
 rLpwatv6AVACUK8/NCfuhXM3OH+Hfjz0OiPyt0I2d8o4doRDUiZHXx39ZkPMsDDflKwqEZMVw
 ZVOm8ymAnlcvuEIKi5nT+pS59d68dxrHUGo74sSBDJZ9NSZ3S89gmQiyvV8ibzWdAd/cqJch2
 Im3+/ilHhqwyHK9xHwvNZVVBvxGsLKkaN2EtgmJ23xRInHChH4IVFKPvFcEGDF9TIqJn1Iw0e
 XKuniJTvTn/+SwnqXalPF38w==

Am Donnerstag, dem 11.07.2024 um 18:40 -0500 schrieb Sean Wang:
> Hi Bert,
>
> Thanks for the detailed debug log. I've quickly made a change to fix
> the issue. Right now, I can't access the test environment, but I'll
> test it and send it out as soon as possible. Here's the patch.
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 2e6268cb06c0..1bab93d049df 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -303,6 +303,7 @@ mt7921_add_interface(struct ieee80211_hw *hw,
> struct ieee80211_vif *vif)
>
>         mvif->bss_conf.mt76.omac_idx =3D mvif->bss_conf.mt76.idx;
>         mvif->phy =3D phy;
> +       mvif->bss_conf.vif =3D mvif;
>         mvif->bss_conf.mt76.band_idx =3D 0;
>         mvif->bss_conf.mt76.wmm_idx =3D mvif->bss_conf.mt76.idx %
> MT76_CONNAC_MAX_WMM_SETS;
>

I wrote earlier that this patch works fine with linux-next-20240711 and at=
 first
it did, but then another NULL pointer error occured. I'm not sure if I can
bisect this as it does not trigger automatically it seems. Also I'm curren=
tly
bisecting the problem with linux-20240712

Bert Karwatzki

[  T853] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  T853] #PF: supervisor read access in kernel mode
[  T853] #PF: error_code(0x0000) - not-present page
[  T853] PGD 0 P4D 0
[  T853] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  T853] CPU: 7 UID: 0 PID: 853 Comm: NetworkManager Not tainted 6.10.0-rc=
7-
next-20240711-debug-dirty #32
[  T853] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/=
MS-
158L, BIOS E158LAMS.107 11/10/2021
[  T853] RIP: 0010:mt7921_ipv6_addr_change+0x3b/0x1d0 [mt7921_common]
[  T853] Code: 68 02 00 00 41 54 4c 89 ef 53 48 89 d3 48 83 e4 f0 48 83 ec=
 60 65
48 8b 04 25 28 00 00 00 48 89 44 24 58 48 8b 86 70 09 00 00 <4c> 8b 60 08 =
0f b6
86 90 04 00 00 48 c7 44 24 05 00 00 00 00 88 44
[  T853] RSP: 0018:ffffb1d203ef35e0 EFLAGS: 00010282
[  T853] RAX: 0000000000000000 RBX: ffff8c73c1ada000 RCX: 0000000000000000
[  T853] RDX: ffff8c73c1ada000 RSI: ffff8c73849d9990 RDI: ffff8c73c1ada268
[  T853] RBP: ffffb1d203ef3668 R08: ffff8c73c19703c0 R09: 0000000000000000
[  T853] R10: ffffb1d203ef36b0 R11: 0000000000000000 R12: 0000000000000002
[  T853] R13: ffff8c73c1ada268 R14: 00000000ffffffff R15: ffff8c73846b08d8
[  T853] FS:  00007f640a9e6500(0000) GS:ffff8c822e5c0000(0000)
knlGS:0000000000000000
[  T853] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  T853] CR2: 0000000000000008 CR3: 00000001043e0000 CR4: 0000000000750ef0
[  T853] PKRU: 55555554
[  T853] Call Trace:
[  T853]  <TASK>
[  T853]  ? __die+0x1e/0x60
[  T853]  ? page_fault_oops+0x157/0x450
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? pollwake+0x73/0xa0
[  T853]  ? wake_up_state+0x10/0x10
[  T853]  ? exc_page_fault+0x331/0x670
[  T853]  ? asm_exc_page_fault+0x26/0x30
[  T853]  ? mt7921_ipv6_addr_change+0x3b/0x1d0 [mt7921_common]
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? __ipv6_ifa_notify+0x16f/0x4d0
[  T853]  ? ieee80211_ifa6_changed+0x5e/0x70 [mac80211]
[  T853]  ? atomic_notifier_call_chain+0x51/0x80
[  T853]  ? addrconf_ifdown.isra.0+0x43f/0x810
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? addrconf_notify+0x15d/0x760
[  T853]  ? __timer_delete_sync+0x70/0xd0
[  T853]  ? raw_notifier_call_chain+0x43/0x60
[  T853]  ? __dev_notify_flags+0x91/0xf0
[  T853]  ? dev_change_flags+0x4f/0x60
[  T853]  ? do_setlink+0xdf9/0x11d0
[  T853]  ? __skb_flow_dissect+0xc30/0x1a40
[  T853]  ? drain_stock+0x63/0xa0
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? __nla_validate_parse+0x61/0xd10
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? update_load_avg+0x77/0x6d0
[  T853]  ? __rtnl_newlink+0x5d6/0x980
[  T853]  ? __entry_text_end+0x102398/0x10239b
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? kmem_cache_alloc_node_noprof+0x4c/0x220
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? __kmalloc_cache_noprof+0x44/0x210
[  T853]  ? rtnl_newlink+0x42/0x60
[  T853]  ? rtnetlink_rcv_msg+0x152/0x3f0
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? netlink_unicast+0x238/0x290
[  T853]  ? rtnl_calcit.isra.0+0x130/0x130
[  T853]  ? netlink_rcv_skb+0x56/0x100
[  T853]  ? netlink_unicast+0x199/0x290
[  T853]  ? netlink_sendmsg+0x21d/0x490
[  T853]  ? __sock_sendmsg+0x78/0x80
[  T853]  ? ____sys_sendmsg+0x23f/0x2e0
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? copy_msghdr_from_user+0x68/0xa0
[  T853]  ? ___sys_sendmsg+0x81/0xd0
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? crng_fast_key_erasure+0xbc/0xf0
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? get_random_bytes_user+0x126/0x140
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? __fdget+0xb1/0xe0
[  T853]  ? __sys_sendmsg+0x56/0xa0
[  T853]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T853]  ? do_syscall_64+0x5f/0x170
[  T853]  ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  T853]  </TASK>
[  T853] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq_midi
snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm cmac bnep nls=
_ascii
nls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic
snd_hda_scodec_component snd_hda_codec_hdmi btusb btrtl btintel snd_hda_in=
tel
btbcm btmtk snd_intel_dspcfg snd_hda_codec snd_soc_dmic snd_acp3x_pdm_dma
snd_acp3x_rn bluetooth snd_soc_core uvcvideo snd_hwdep snd_hda_core
videobuf2_vmalloc uvc videobuf2_memops videobuf2_v4l2 snd_pcm_oss videodev
snd_mixer_oss snd_pcm snd_rn_pci_acp3x hid_sensor_gyro_3d hid_sensor_magn_=
3d
hid_sensor_accel_3d hid_sensor_als hid_sensor_prox snd_acp_config
videobuf2_common snd_timer hid_sensor_trigger msi_wmi snd_soc_acpi ecdh_ge=
neric
amd_atl ecc mc snd edac_mce_amd wmi_bmof sparse_keymap ccp soundcore k10te=
mp
snd_pci_acp3x button industrialio_triggered_buffer battery joydev ac kfifo=
_buf
industrialio hid_sensor_iio_common amd_pmc evdev hid_multitouch serio_raw
mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76
[  T853]  mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics efi_pstor=
e
configfs efivarfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu
i2c_algo_bit drm_ttm_helper ttm drm_exec xhci_pci drm_suballoc_helper amdx=
cp
drm_buddy xhci_hcd gpu_sched hid_sensor_hub drm_display_helper usbcore nvm=
e
mfd_core hid_generic crc32c_intel psmouse amd_sfh i2c_piix4 usb_common crc=
16
nvme_core r8169 i2c_hid_acpi i2c_hid hid i2c_designware_platform
i2c_designware_core
[  T853] CR2: 0000000000000008
[  T853] ---[ end trace 0000000000000000 ]---


