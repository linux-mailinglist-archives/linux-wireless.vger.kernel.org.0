Return-Path: <linux-wireless+bounces-22964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B59AB790B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 00:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0ABC4C7D30
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCE721B9D9;
	Wed, 14 May 2025 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="e9jXUZjk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031921EA7D6;
	Wed, 14 May 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747261687; cv=none; b=qGMTUzaQXcBHguC1QN2OZZR1G7CTQsDsBvOaNlMQpuf4zAmNZRnDQR5Vkj9ePtoctHM3qIYlGBoSJt0QH2X33gM+ep23yo2xg+ITzwB488tioG3kAGC5sDa21yYR+KQA3ejsu1hJMT97Qz3FUNMTIRyWJYMfDgMI9lV8hGA266c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747261687; c=relaxed/simple;
	bh=p2/KgcElpGQb04uobmOGECHNwrOWinorRyhas1+zvQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a0SIBYiiogH/6tblmeQnWST2V/E8/XV90/+i2mrYl/GXfu61tMAsykCI+ctSYtH+fle7GgJkkwVQhf6CV20SETubiaoajFyYftdRd1kPuJFQDW28m9yR8sxXrEycEWimnTfn7ALeDhHcXEjqKr/ypuh+2wFn1x7HwzyKWt4jxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=e9jXUZjk; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747261675; x=1747866475; i=spasswolf@web.de;
	bh=fBX67rFvpoZhBh2U5TY/eZ409u46EUCNh7a/wbOQsBU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e9jXUZjka00fx4muo4pObreg8TJBAv9PfClYcCJ0DUL+cCT+fxx/THdTjcygFMSO
	 UDG9Pd7FEbM0/HsifN7Dr4pdN/bI0eEpeKiStscNBOJ4vgI+uBEeQgZGWywE75kqD
	 EKQoT/L9t3XpRmWI7eGSxqmg3kB6fPMnSGlakGVINSFxsM5PmXPbc/PlmtorqgQbr
	 cmLQnXgrA/mHALcUu529FrCXHTvdyiS+JpAb7FyIYV+MLtI37oZV6bWrlfShsRAij
	 kpBeqAOnIuzNAHnbR3TSnrJkb0fSiCb84rd/lDdUjqL8DkL3hfTxH05VJw6VrFome
	 3ptDPNcLMqrIP+bDtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1v2EES2XAJ-0149LI; Thu, 15
 May 2025 00:27:55 +0200
Message-ID: <f8552d41fb7eae286803b78302390614179b33b0.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, 
 "llvm@lists.linux.dev"
	 <llvm@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-wireless@vger.kernel.org, spasswolf@web.de
Date: Thu, 15 May 2025 00:27:54 +0200
In-Reply-To: <a12c82c394e9676e32ede6b8312f821a16fef94b.camel@sipsolutions.net>
References: <20250513164807.51780-1-spasswolf@web.de> <87h61ojg3g.ffs@tglx>
							 <7471a185adcc34a79c2ab8ce1e87ab922ae2232b.camel@web.de>
						 <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
					 <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
				 <2cad838b39f00d93319509d2a6a77a4c42c7fa92.camel@web.de>
			 <a12c82c394e9676e32ede6b8312f821a16fef94b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sNDX4ttM5JacXnZ9RXq/iwFDKZzGtG7vK5TKU6qaq+0co8MXmIF
 0vSiY8fw+0JJH4VukZ+rio4467oHy6com7b5w21pBAwWnp3MDhSkhk3bi9jzoPaYrY0+J9J
 CazenrKmLyfWG0H43Y05d8iViiHiM9VkUBhmoExL9tCFuErb4XpxcpARgHSWIXUyhahTsJY
 ROe15BxfCkGmDJnMWmt8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oQWsSxEeKVs=;Tapu2YNgSbole3q62VAC0BrhKhu
 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

Am Mittwoch, dem 14.05.2025 um 20:56 +0200 schrieb Johannes Berg:
> >=20
> > I've split off the problematic piece of code into an noinline function=
 to simplify the disassembly:
> >=20
>=20
> Oh and also, does it even still crash with that? :)

Yes, it still crashes when compiled with clang.

>=20
> Still I feel it's possibly some kind of weird side-effect and not
> strictly a compiler issue? But I don't see anything so far.
>=20
> johannes

The problem only occur with PREEMPT_RT=3Dy and clang,I was able to capture=
 the
panic message via netconsole:

 [  267.339591][  T575] BUG: unable to handle page fault for address:
ffffffff51e080b0
 [  267.339598][  T575] #PF: supervisor write access in kernel mode
 [  267.339602][  T575] #PF: error_code(0x0002) - not-present page
 [  267.339606][  T575] PGD f1cc3c067 P4D f1cc3c067 PUD 0=20
 [  267.339613][  T575] Oops: Oops: 0002 [#1] SMP NOPTI
 [  267.339622][  T575] CPU: 0 UID: 0 PID: 575 Comm: napi/phy0-0 Not taint=
ed
6.15.0-rc6-next-20250513-llvm-00009-gec34cd07a425 #968 PREEMPT_{RT,(full)}=
=20
 [  267.339629][  T575] Hardware name: Micro-Star International Co., Ltd. =
Alpha
15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
 [  267.339632][  T575] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c0
66 a9 83 7a 08 00 75 08 f3 90 83 7a 08 00 74 f8
 [  267.339659][  T575] RSP: 0018:ffffcc5a81edf998 EFLAGS: 00010002
 [  267.339664][  T575] RAX: ffffffffa87a5ee0 RBX: 0000000000000286 RCX:
0000000000040000
 [  267.339668][  T575] RDX: ffff8b6d2e6231c0 RSI: 0000000000000010 RDI:
ffff8b5e8855cda8
 [  267.339671][  T575] RBP: ffff8b5e852ff300 R08: fffffffffffffff8 R09:
0000000000000001
R11: ffffffffa87f07f0 R12: ffff8b5e8855cd90
 [  267.339677][  T575] R13: ffff8b5ec1bd2480 R14: ffff8b5e8855cda8 R15:
ffff8b5e8855cda8
 [  267.339681][  T575] FS:  0000000000000000(0000) GS:ffff8b6d84fc1000(00=
00)
knlGS:0000000000000000
 [  267.339684][  T575] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  267.339687][  T575] CR2: ffffffff51e080b0 CR3: 0000000f1cc3a000 CR4:
0000000000750ef0
 [  267.339690][  T575] PKRU: 55555554
 [  267.339692][  T575] Call Trace:
 [  267.339701][  T575]  <TASK>
 [  267.339705][  T575]  _raw_spin_lock_irqsave+0x57/0x60
 [  267.339714][  T575]  rt_spin_lock+0x73/0xa0
 [  267.339720][  T575]  sock_queue_err_skb+0xdc/0x140
 [  267.339727][  T575]  skb_complete_wifi_ack+0xa9/0x120
 [  267.339737][  T575]  ieee80211_report_used_skb+0x541/0x6e0 [mac80211]
 [  267.339799][  T575]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  267.339804][  T575]  ? start_dl_timer+0xcf/0x110
 [  267.339814][  T575]  ieee80211_tx_status_ext+0x3b3/0x870 [mac80211]
 [  267.339851][  T575]  ? raw_spin_rq_lock_nested+0x15/0x80
 [  267.339862][  T575]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  267.339866][  T575]  ? rt_spin_lock+0x3d/0xa0
 [  267.339873][  T575]  ? mt76_tx_status_unlock+0x38/0x230 [mt76]
 [  267.339886][  T575]  mt76_tx_status_unlock+0x1e0/0x230 [mt76]
 [  267.339901][  T575]  __mt76_tx_complete_skb+0x13b/0x2e0 [mt76]
 [  267.339912][  T575]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  267.339915][  T575]  ? rt_spin_unlock+0x12/0x40
 [  267.339918][  T575]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  267.339924][  T575]  mt76_connac2_txwi_free+0x127/0x150 [mt76_connac_l=
ib]
 [  267.339938][  T575]  mt7921_mac_tx_free+0x112/0x260 [mt7921_common]
 [  267.339950][  T575]  mt7921_rx_check+0x33/0xe0 [mt7921_common]
 [  267.339957][  T575]  mt76_dma_rx_poll+0x322/0x660 [mt76]
 [  267.339970][  T575]  ? mt792x_poll_rx+0x2a/0x120 [mt792x_lib]
 [  267.339982][  T575]  mt792x_poll_rx+0x71/0x120 [mt792x_lib]
 [  267.339989][  T575]  __napi_poll+0x2a/0x170
 [  267.339994][  T575]  ? napi_threaded_poll_loop+0x32/0x1b0
 [  267.339998][  T575]  napi_threaded_poll_loop+0xe4/0x1b0
 [  267.340001][  T575]  ? napi_threaded_poll_loop+0x32/0x1b0
 [  267.340007][  T575]  napi_threaded_poll+0x57/0x80
 [  267.340011][  T575]  ? __pfx_napi_threaded_poll+0x10/0x10
 [  267.340014][  T575]  kthread+0x25c/0x280
 [  267.340020][  T575]  ? __pfx_kthread+0x10/0x10
 [  267.340025][  T575]  ret_from_fork+0xc4/0x1b0
 [  267.340030][  T575]  ? __pfx_kthread+0x10/0x10
 [  267.340034][  T575]  ret_from_fork_asm+0x1a/0x30
 [  267.340043][  T575]  </TASK>
 [  267.340045][  T575] Modules linked in: netconsole ccm snd_seq_dummy
snd_hrtimer snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_seq_de=
vice
rfcomm bnep nls_ascii nls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek
snd_hda_scodec_component snd_hda_codec_generic snd_hda_codec_hdmi btusb bt=
bcm
btintel snd_hda_intel btrtl btmtk snd_intel_dspcfg snd_hda_codec snd_soc_d=
mic
snd_acp3x_pdm_dma snd_acp3x_rn uvcvideo bluetooth snd_soc_core snd_hwdep
videobuf2_vmalloc videobuf2_memops uvc snd_hda_core videobuf2_v4l2 snd_pcm=
_oss
videodev snd_mixer_oss snd_pcm snd_rn_pci_acp3x videobuf2_common snd_acp_c=
onfig
snd_soc_acpi msi_wmi ecdh_generic ecc mc wmi_bmof sparse_keymap snd_timer
edac_mce_amd snd k10temp ccp snd_pci_acp3x soundcore battery ac button joy=
dev
hid_sensor_gyro_3d hid_sensor_magn_3d hid_sensor_als hid_sensor_prox
hid_sensor_accel_3d hid_sensor_trigger hid_sensor_iio_common amd_pmc
industrialio_triggered_buffer kfifo_buf evdev industrialio mt7921e mt7921_=
common
mt792x_lib mt76_
libarc4 cfg80211
 [  267.340161][  T575]  rfkill msr fuse nvme_fabrics efi_pstore configfs
efivarfs autofs4 ext4 mbcache jbd2 amdgpu usbhid drm_panel_backlight_quirk=
s cec
drm_buddy drm_suballoc_helper drm_exec i2c_algo_bit drm_display_helper xhc=
i_pci
gpu_sched drm_ttm_helper xhci_hcd hid_sensor_hub ttm hid_multitouch mfd_co=
re
hid_generic psmouse i2c_hid_acpi drm_client_lib nvme amd_sfh usbcore i2c_h=
id
drm_kms_helper hid serio_raw nvme_core r8169 i2c_piix4 i2c_smbus usb_commo=
n
amdxcp crc16 i2c_designware_platform i2c_designware_core
 [  267.340214][  T575] CR2: ffffffff51e080b0
 [  267.340219][  T575] ---[ end trace 0000000000000000 ]---
 [  267.536499][  T575] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c0
66 a9 83 7a 08 00 75 08 f3 90 83 7a 08 00 74 f8
 [  267.536514][  T575] RSP: 0018:ffffcc5a81edf998 EFLAGS: 00010002
 [  267.536518][  T575] RAX: ffffffffa87a5ee0 RBX: 0000000000000286 RCX:
0000000000040000
 [  267.536521][  T575] RDX: ffff8b6d2e6231c0 RSI: 0000000000000010 RDI:
ffff8b5e8855cda8
 [  267.536523][  T575] RBP: ffff8b5e852ff300 R08: fffffffffffffff8 R09:
0000000000000001
R11: ffffffffa87f07f0 R12: ffff8b5e8855cd90
 [  267.536526][  T575] R13: ffff8b5ec1bd2480 R14: ffff8b5e8855cda8 R15:
ffff8b5e8855cda8
 [  267.536528][  T575] FS:  0000000000000000(0000) GS:ffff8b6d84fc1000(00=
00)
knlGS:0000000000000000
 [  267.536530][  T575] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  267.536532][  T575] CR2: ffffffff51e080b0 CR3: 0000000f1cc3a000 CR4:
0000000000750ef0
 [  267.536534][  T575] PKRU: 55555554
 [  267.536536][  T575] Kernel panic - not syncing: Fatal exception in int=
errupt
 [  267.536948][  T575] Kernel Offset: 0x26e00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 [  267.735256][  T575] ---[ end Kernel panic - not syncing: Fatal excepti=
on in
interrupt ]---

Another try showed a different error (non-canonical address!)

[  115.685734][  T579] Oops: general protection fault, probably for non-
canonical address 0x9d504b8ce3373: 0000 [#1] SMP NOPTI
 [  115.685742][  T579] CPU: 13 UID: 0 PID: 579 Comm: napi/phy0-0 Not tain=
ted
6.15.0-rc6-next-20250513-llvm-00009-gec34cd07a425 #970 PREEMPT_{RT,(full)}=
=20
 [  115.685747][  T579] Hardware name: Micro-Star International Co., Ltd. =
Alpha
15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
 [  115.685749][  T579] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c0
86 b9 83 7a 08 00 75 08 f3 90 83 7a 08 00 74 f8
 [  115.685758][  T579] RSP: 0018:ffffd0c244fc3998 EFLAGS: 00010006
 [  115.685761][  T579] RAX: 0009d504ff4811a3 RBX: 0000000000000286 RCX:
0000000000380000
 [  115.685764][  T579] RDX: ffff8e13ee9631c0 RSI: 0000000000000010 RDI:
ffff8e08c29126a8
 [  115.685765][  T579] RBP: ffff8e055300d400 R08: fffffffffffffff8 R09:
0000000000000001
R11: ffffffffb89f07f0 R12: ffff8e08c2912690
 [  115.685769][  T579] R13: ffff8e056a2f2480 R14: ffff8e08c29126a8 R15:
ffff8e08c29126a8
 [  115.685771][  T579] FS:  0000000000000000(0000) GS:ffff8e1435101000(00=
00)
knlGS:0000000000000000
 [  115.685773][  T579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  115.685776][  T579] CR2: 00007f56b8d28000 CR3: 0000000163d15000 CR4:
0000000000750ef0
 [  115.685778][  T579] PKRU: 55555554
 [  115.685779][  T579] Call Trace:
 [  115.685782][  T579]  <TASK>
 [  115.685784][  T579]  _raw_spin_lock_irqsave+0x57/0x60
 [  115.685790][  T579]  rt_spin_lock+0x73/0xa0
 [  115.685795][  T579]  sock_queue_err_skb+0xdc/0x140
 [  115.685801][  T579]  skb_complete_wifi_ack+0xa9/0x120
 [  115.685809][  T579]  ieee80211_report_used_skb+0x541/0x6e0 [mac80211]
 [  115.685858][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685862][  T579]  ? wake_up_q+0x4e/0xe0
 [  115.685867][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685872][  T579]  ieee80211_tx_status_ext+0x3b3/0x870 [mac80211]
 [  115.685902][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685905][  T579]  ? rt_spin_lock+0x3d/0xa0
 [  115.685910][  T579]  ? mt76_tx_status_unlock+0x38/0x230 [mt76]
 [  115.685920][  T579]  mt76_tx_status_unlock+0x1e0/0x230 [mt76]
 [  115.685932][  T579]  __mt76_tx_complete_skb+0x13b/0x2e0 [mt76]
 [  115.685942][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685945][  T579]  ? rt_spin_unlock+0x12/0x40
 [  115.685947][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685954][  T579]  mt76_connac2_txwi_free+0x127/0x150 [mt76_connac_l=
ib]
 [  115.685964][  T579]  mt7921_mac_tx_free+0x112/0x260 [mt7921_common]
 [  115.685975][  T579]  mt7921_rx_check+0x33/0xe0 [mt7921_common]
 [  115.685982][  T579]  mt76_dma_rx_poll+0x322/0x660 [mt76]
 [  115.685993][  T579]  ? mt792x_poll_rx+0x2a/0x120 [mt792x_lib]
 [  115.686001][  T579]  mt792x_poll_rx+0x71/0x120 [mt792x_lib]
 [  115.686009][  T579]  __napi_poll+0x2a/0x170
 [  115.686013][  T579]  ? napi_threaded_poll_loop+0x32/0x1b0
 [  115.686017][  T579]  napi_threaded_poll_loop+0xe4/0x1b0
 [  115.686020][  T579]  ? napi_threaded_poll_loop+0x32/0x1b0
 [  115.686026][  T579]  napi_threaded_poll+0x57/0x80
 [  115.686029][  T579]  ? __pfx_napi_threaded_poll+0x10/0x10
 [  115.686032][  T579]  kthread+0x25c/0x280
 [  115.686038][  T579]  ? __pfx_kthread+0x10/0x10
 [  115.686043][  T579]  ret_from_fork+0xc4/0x1b0
 [  115.686047][  T579]  ? __pfx_kthread+0x10/0x10
 [  115.686051][  T579]  ret_from_fork_asm+0x1a/0x30
 [  115.686058][  T579]  </TASK>
 [  115.686060][  T579] Modules linked in: ccm netconsole snd_seq_dummy
snd_hrtimer snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_seq_de=
vice
rfcomm bnep nls_ascii nls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek
snd_hda_scodec_component snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_=
intel
btusb snd_intel_dspcfg btbcm snd_hda_codec btintel btrtl uvcvideo
snd_acp3x_pdm_dma btmtk snd_soc_dmic snd_hwdep snd_acp3x_rn snd_soc_core
snd_hda_core videobuf2_vmalloc videobuf2_memops uvc bluetooth snd_pcm_oss
videobuf2_v4l2 snd_mixer_oss videodev snd_pcm snd_rn_pci_acp3x snd_acp_con=
fig
videobuf2_common snd_timer msi_wmi snd_soc_acpi ecdh_generic ecc mc wmi_bm=
of
sparse_keymap edac_mce_amd snd ccp soundcore k10temp snd_pci_acp3x battery=
 ac
button joydev hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d
hid_sensor_als hid_sensor_magn_3d hid_sensor_trigger hid_sensor_iio_common
amd_pmc industrialio_triggered_buffer kfifo_buf evdev industrialio mt7921e
mt7921_common mt792x_lib mt76_
libarc4 cfg80211
 [  115.686166][  T579]  rfkill msr fuse nvme_fabrics configfs efi_pstore
efivarfs autofs4 ext4 mbcache jbd2 amdgpu usbhid drm_panel_backlight_quirk=
s cec
drm_buddy drm_suballoc_helper drm_exec i2c_algo_bit drm_display_helper xhc=
i_pci
gpu_sched hid_sensor_hub xhci_hcd psmouse drm_ttm_helper mfd_core hid_mult=
itouch
hid_generic ttm i2c_hid_acpi serio_raw usbcore drm_client_lib nvme amd_sfh
i2c_hid hid drm_kms_helper nvme_core r8169 i2c_piix4 amdxcp usb_common crc=
16
i2c_smbus i2c_designware_platform i2c_designware_core
 [  115.686236][  T579] ---[ end trace 0000000000000000 ]---
 [  115.782274][  T579] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c0
86 b9 83 7a 08 00 75 08 f3 90 83 7a 08 00 74 f8
 [  115.782274][  T579] RSP: 0018:ffffd0c244fc3998 EFLAGS: 00010006
 [  115.782274][  T579] RAX: 0009d504ff4811a3 RBX: 0000000000000286 RCX:
0000000000380000
 [  115.782274][  T579] RDX: ffff8e13ee9631c0 RSI: 0000000000000010 RDI:
ffff8e08c29126a8
 [  115.846760][  T579] RBP: ffff8e055300d400 R08: fffffffffffffff8 R09:
0000000000000001
R11: ffffffffb89f07f0 R12: ffff8e08c2912690
 [  115.846760][  T579] R13: ffff8e056a2f2480 R14: ffff8e08c29126a8 R15:
ffff8e08c29126a8
 [  115.846765][  T579] FS:  0000000000000000(0000) GS:ffff8e1435101000(00=
00)
knlGS:0000000000000000
 [  115.846765][  T579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  115.846770][  T579] CR2: 00007f56b8d28000 CR3: 000000018d63a000 CR4:
0000000000750ef0
 [  115.846770][  T579] PKRU: 55555554
 [  115.846773][  T579] Kernel panic - not syncing: Fatal exception in int=
errupt
 [  115.846773][  T579] Kernel Offset: 0x37000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 [  115.685734][  T579] Oops: general protection fault, probably for non-
canonical address 0x9d504b8ce3373: 0000 [#1] SMP NOPTI
 [  115.685742][  T579] CPU: 13 UID: 0 PID: 579 Comm: napi/phy0-0 Not tain=
ted
6.15.0-rc6-next-20250513-llvm-00009-gec34cd07a425 #970 PREEMPT_{RT,(full)}=
=20
 [  115.685747][  T579] Hardware name: Micro-Star International Co., Ltd. =
Alpha
15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
 [  115.685749][  T579] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c0
86 b9 83 7a 08 00 75 08 f3 90 83 7a 08 00 74 f8
 [  115.685758][  T579] RSP: 0018:ffffd0c244fc3998 EFLAGS: 00010006
 [  115.685761][  T579] RAX: 0009d504ff4811a3 RBX: 0000000000000286 RCX:
0000000000380000
 [  115.685764][  T579] RDX: ffff8e13ee9631c0 RSI: 0000000000000010 RDI:
ffff8e08c29126a8
 [  115.685765][  T579] RBP: ffff8e055300d400 R08: fffffffffffffff8 R09:
0000000000000001
R11: ffffffffb89f07f0 R12: ffff8e08c2912690
 [  115.685769][  T579] R13: ffff8e056a2f2480 R14: ffff8e08c29126a8 R15:
ffff8e08c29126a8
 [  115.685771][  T579] FS:  0000000000000000(0000) GS:ffff8e1435101000(00=
00)
knlGS:0000000000000000
 [  115.685773][  T579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  115.685776][  T579] CR2: 00007f56b8d28000 CR3: 0000000163d15000 CR4:
0000000000750ef0
 [  115.685778][  T579] PKRU: 55555554
 [  115.685779][  T579] Call Trace:
 [  115.685782][  T579]  <TASK>
 [  115.685784][  T579]  _raw_spin_lock_irqsave+0x57/0x60
 [  115.685790][  T579]  rt_spin_lock+0x73/0xa0
 [  115.685795][  T579]  sock_queue_err_skb+0xdc/0x140
 [  115.685801][  T579]  skb_complete_wifi_ack+0xa9/0x120
 [  115.685809][  T579]  ieee80211_report_used_skb+0x541/0x6e0 [mac80211]
 [  115.685858][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685862][  T579]  ? wake_up_q+0x4e/0xe0
 [  115.685867][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685872][  T579]  ieee80211_tx_status_ext+0x3b3/0x870 [mac80211]
 [  115.685902][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685905][  T579]  ? rt_spin_lock+0x3d/0xa0
 [  115.685910][  T579]  ? mt76_tx_status_unlock+0x38/0x230 [mt76]
 [  115.685920][  T579]  mt76_tx_status_unlock+0x1e0/0x230 [mt76]
 [  115.685932][  T579]  __mt76_tx_complete_skb+0x13b/0x2e0 [mt76]
 [  115.685942][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685945][  T579]  ? rt_spin_unlock+0x12/0x40
 [  115.685947][  T579]  ? srso_alias_return_thunk+0x5/0xfbef5
 [  115.685954][  T579]  mt76_connac2_txwi_free+0x127/0x150 [mt76_connac_l=
ib]
 [  115.685964][  T579]  mt7921_mac_tx_free+0x112/0x260 [mt7921_common]
 [  115.685975][  T579]  mt7921_rx_check+0x33/0xe0 [mt7921_common]
 [  115.685982][  T579]  mt76_dma_rx_poll+0x322/0x660 [mt76]
 [  115.685993][  T579]  ? mt792x_poll_rx+0x2a/0x120 [mt792x_lib]
 [  115.686001][  T579]  mt792x_poll_rx+0x71/0x120 [mt792x_lib]
 [  115.686009][  T579]  __napi_poll+0x2a/0x170
 [  115.686013][  T579]  ? napi_threaded_poll_loop+0x32/0x1b0
 [  115.686017][  T579]  napi_threaded_poll_loop+0xe4/0x1b0
 [  115.686020][  T579]  ? napi_threaded_poll_loop+0x32/0x1b0
 [  115.686026][  T579]  napi_threaded_poll+0x57/0x80
 [  115.686029][  T579]  ? __pfx_napi_threaded_poll+0x10/0x10
 [  115.686032][  T579]  kthread+0x25c/0x280
 [  115.686038][  T579]  ? __pfx_kthread+0x10/0x10
 [  115.686043][  T579]  ret_from_fork+0xc4/0x1b0
 [  115.686047][  T579]  ? __pfx_kthread+0x10/0x10
 [  115.686051][  T579]  ret_from_fork_asm+0x1a/0x30
 [  115.686058][  T579]  </TASK>
 [  115.686060][  T579] Modules linked in: ccm netconsole snd_seq_dummy
snd_hrtimer snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_seq_de=
vice
rfcomm bnep nls_ascii nls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek
snd_hda_scodec_component snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_=
intel
btusb snd_intel_dspcfg btbcm snd_hda_codec btintel btrtl uvcvideo
snd_acp3x_pdm_dma btmtk snd_soc_dmic snd_hwdep snd_acp3x_rn snd_soc_core
snd_hda_core videobuf2_vmalloc videobuf2_memops uvc bluetooth snd_pcm_oss
videobuf2_v4l2 snd_mixer_oss videodev snd_pcm snd_rn_pci_acp3x snd_acp_con=
fig
videobuf2_common snd_timer msi_wmi snd_soc_acpi ecdh_generic ecc mc wmi_bm=
of
sparse_keymap edac_mce_amd snd ccp soundcore k10temp snd_pci_acp3x battery=
 ac
button joydev hid_sensor_prox hid_sensor_accel_3d hid_sensor_gyro_3d
hid_sensor_als hid_sensor_magn_3d hid_sensor_trigger hid_sensor_iio_common
amd_pmc industrialio_triggered_buffer kfifo_buf evdev industrialio mt7921e
mt7921_common mt792x_lib mt76_
libarc4 cfg80211
 [  115.686166][  T579]  rfkill msr fuse nvme_fabrics configfs efi_pstore
efivarfs autofs4 ext4 mbcache jbd2 amdgpu usbhid drm_panel_backlight_quirk=
s cec
drm_buddy drm_suballoc_helper drm_exec i2c_algo_bit drm_display_helper xhc=
i_pci
gpu_sched hid_sensor_hub xhci_hcd psmouse drm_ttm_helper mfd_core hid_mult=
itouch
hid_generic ttm i2c_hid_acpi serio_raw usbcore drm_client_lib nvme amd_sfh
i2c_hid hid drm_kms_helper nvme_core r8169 i2c_piix4 amdxcp usb_common crc=
16
i2c_smbus i2c_designware_platform i2c_designware_core
 [  115.686236][  T579] ---[ end trace 0000000000000000 ]---
 [  115.782274][  T579] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c0
86 b9 83 7a 08 00 75 08 f3 90 83 7a 08 00 74 f8
 [  115.782274][  T579] RSP: 0018:ffffd0c244fc3998 EFLAGS: 00010006
 [  115.782274][  T579] RAX: 0009d504ff4811a3 RBX: 0000000000000286 RCX:
0000000000380000
 [  115.782274][  T579] RDX: ffff8e13ee9631c0 RSI: 0000000000000010 RDI:
ffff8e08c29126a8
 [  115.846760][  T579] RBP: ffff8e055300d400 R08: fffffffffffffff8 R09:
0000000000000001
R11: ffffffffb89f07f0 R12: ffff8e08c2912690
 [  115.846760][  T579] R13: ffff8e056a2f2480 R14: ffff8e08c29126a8 R15:
ffff8e08c29126a8
 [  115.846765][  T579] FS:  0000000000000000(0000) GS:ffff8e1435101000(00=
00)
knlGS:0000000000000000
 [  115.846765][  T579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  115.846770][  T579] CR2: 00007f56b8d28000 CR3: 000000018d63a000 CR4:
0000000000750ef0
 [  115.846770][  T579] PKRU: 55555554
 [  115.846773][  T579] Kernel panic - not syncing: Fatal exception in int=
errupt
 [  115.846773][  T579] Kernel Offset: 0x37000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 [  115.846773][  T579] ---[ end Kernel panic - not syncing: Fatal excepti=
on in
interrupt ]---


Bert Karwatzki

