Return-Path: <linux-wireless+bounces-23120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E984ABB026
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEF53AE0D7
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 12:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545792165EA;
	Sun, 18 May 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Z/0RL0QJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB986323;
	Sun, 18 May 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747570337; cv=none; b=chKYODshbbrosjTep/0JQuSLv/e6RkZUJ/ywFxbdHxdYFSVt+el18SwesI/ErcWAZOLFk3TAug9Tj0uwpLF437F1rue3wYaWSTs1/JUfAlzsBEjhwDJOGmhlkPDefalLMGYKrx45DbZ5WFq3SP8hgnFAppQavNXE6eysf36UMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747570337; c=relaxed/simple;
	bh=oAdz99++S56MHzeb5b3rVGM2zQ3HIbYPYR0zY6X677g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kY8zvAOoiHkAR47qvzIguAWx2Ux0FLz/lwma+WqA4VYO7MroIC64ZfhnkWh4Yd4k81/JvdMh7wd1/6PFIs8d0372FEodPnI2PWjQK1rKlD9KQ2WrJEGfnBpCFwVNhCjX9B5594r/wkq+d/YwXGVJ8hjVUFQHhB1v2YgvhDkB6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Z/0RL0QJ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747570325; x=1748175125; i=spasswolf@web.de;
	bh=FFrEkceV/BhI8MXaafiyrGJRu/+D9MHwt0zS5BDnZxE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z/0RL0QJOfa2ePOVX3B38E2eckL5cl3oQkysEPbtdXs0Dr7dJclhMvnZaiPYkJ3j
	 50TNp0qVF6OTKEWB1201IfFb/3MwOBIOz/PjHwMJwdYgBqRdVywuxirkU5yiZBVu1
	 jyfkpcAEaEzzNGfvw/ntpT85jQoc/rLnfRtIugKAv0lJWmVcCfupmVg18LUNLaiEU
	 FNOJ/t/KtBeAxgiaZV7NnzXsoqVRjASsQhj7yheghj5yFD4BJWpNfRDXJa0PwJMpu
	 5IgM0Hnf1PVGWuteuzZqYi4LKcOMUq3gQRklqwFearSPcjOFrbiKH0AGQQx6yyOZn
	 iPbZVzFIVtWTjgIzyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1uShBI47xs-00PDGU; Sun, 18
 May 2025 14:12:05 +0200
Message-ID: <4a893f88b6892502a5f7a61bcfc806a271a730a9.camel@web.de>
Subject: Re: lockup and kernel panic in linux-next-202505{09,12} when
 compiled with clang
From: Bert Karwatzki <spasswolf@web.de>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org"	 <linux-next@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,  Thomas Gleixner
 <tglx@linutronix.de>, linux-wireless@vger.kernel.org, spasswolf@web.de
Date: Sun, 18 May 2025 14:12:04 +0200
In-Reply-To: <CAL+tcoA3d-EdoGjei7aeyuA3zmj955uYkXf1wCAUy8iP3BxUjg@mail.gmail.com>
References: <20250513164807.51780-1-spasswolf@web.de> <87h61ojg3g.ffs@tglx>
				 <7471a185adcc34a79c2ab8ce1e87ab922ae2232b.camel@web.de>
				 <b644ff1714731cfb652d809d4864f0d178b24a97.camel@web.de>
				 <2d8c1929bf5ab5260dacf9aa390456b3b49ce465.camel@sipsolutions.net>
				 <2cad838b39f00d93319509d2a6a77a4c42c7fa92.camel@web.de>
				 <a12c82c394e9676e32ede6b8312f821a16fef94b.camel@sipsolutions.net>
				 <f8552d41fb7eae286803b78302390614179b33b0.camel@web.de>
				 <8684a2b4bf367e2e2a97e2b52356ffe5436a8270.camel@sipsolutions.net>
				 <ba97a2559cda1b14e0c9754523ff1152bdad90ef.camel@web.de>
				 <63cc1dbf07bde2c9d14e1f86ce2c2ce26a2a9936.camel@web.de>
				 <388bbc4c805ce029bbd08010fd30405494f998a9.camel@web.de>
				 <15f3633cbd08b30475d5b76c5cc9180fbf17a12f.camel@web.de>
				 <CAL+tcoA3d-EdoGjei7aeyuA3zmj955uYkXf1wCAUy8iP3BxUjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v3GKVKmn9NMBT9aM6UIRJ7Mzl96m3DuJByIFv5DBKQEPcBwfxjy
 vY9lR60xq/wJpcEtKYPs4PRPLhrwki5J5KqpiKFXnesMPp1saNbNB/Ufo4vd1mSToB3UKAl
 L1mpjRryI/p7sdX/a5yYRHXqXo0/CSe7OR0c7N1kocRHIo4kYI0NCwMOpYpe1WYcKOLxuDL
 H95z6/P0TmKVlenqWNo1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XZp5vgmzNRg=;XUXJXhHOh6WyiLb3J1+ryCAqnVw
 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

Am Sonntag, dem 18.05.2025 um 09:30 +0800 schrieb Jason Xing:
> Hi Bert,
>=20
> Thanks for your report and analysis!
>=20
> On Sun, May 18, 2025 at 3:49=E2=80=AFAM Bert Karwatzki <spasswolf@web.de=
> wrote:
> >=20
> > Am Samstag, dem 17.05.2025 um 13:34 +0200 schrieb Bert Karwatzki:
> > > Am Freitag, dem 16.05.2025 um 20:19 +0200 schrieb Bert Karwatzki:
> > > > I've added a debugging statement:
> > > >=20
> > > > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > > > index 3bd5ee0995fe..853493eca4f5 100644
> > > > --- a/net/mac80211/tx.c
> > > > +++ b/net/mac80211/tx.c
> > > > @@ -4586,7 +4586,11 @@ static noinline void ieee80211_8023_xmit_cl=
ang_debug_helper(struct sk_buff *skb,
>=20
> What is the caller of it? It's the function that you customized?

The only caller of ieee80211_8023_xmit_clang_debug_helper() is
ieee80211_8023_xmit(). I did this because I thought clang might
have been producing incorrect code at the time, but it turned
out clang did nothing wrong.

>=20
> > > >                                                             struct=
 ieee80211_local *local,
> > > >                                                             struct=
 ieee80211_tx_info *info)
> > > >  {
> > > > -       if (unlikely(skb->sk && sock_flag(skb->sk, SOCK_WIFI_STATU=
S))) {
> > > > +       if (unlikely(skb->sk && ((skb_shinfo(skb)->tx_flags & SKBT=
X_WIFI_STATUS) ||
> > > > +                               sock_flag(skb->sk, SOCK_WIFI_STATU=
S)))) {
> > > > +               if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS=
) ^ sock_flag(skb->sk, SOCK_WIFI_STATUS))
> > > > +                       printk(KERN_INFO "%s: skb_shinfo(skb)->tx_=
flags & SKBTX_WIFI_STATUS =3D %u sock_flag(skb->sk,
> > > > SOCK_WIFI_STATUS) =3D %u\n",
> > > > +                                       __func__, (skb_shinfo(skb)=
->tx_flags & SKBTX_WIFI_STATUS), sock_flag(skb->sk,
> > > > SOCK_WIFI_STATUS));
> > > >                 info->status_data =3D ieee80211_store_ack_skb(loca=
l, skb,
> > > >                                                             &info-=
>flags, NULL);
> > > >                 if (info->status_data)
> > > >=20
> > > > This gives the following logoutput (and a lockup), indicating that=
 sock_flag(skb->sk, SOCK_WIFI_STATUS) and
> > > > (skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) are actually NOT e=
quivalent (when compiled with clang and
> > > > PREEMPT_RT=3Dy)
>=20
> Moving skc_flags out of the union can solve the issue, right? Simple
> modification looks like this:
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 3e15d7105ad2..5810c7b80507 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -189,13 +189,13 @@ struct sock_common {
>=20
>         atomic64_t              skc_cookie;
>=20
> +       unsigned long   skc_flags;
>         /* following fields are padding to force
>          * offset(struct sock, sk_refcnt) =3D=3D 128 on 64bit arches
>          * assuming IPV6 is enabled. We use this padding differently
>          * for different kind of 'sockets'
>          */
>         union {
> -               unsigned long   skc_flags;
>                 struct sock     *skc_listener; /* request_sock */
>                 struct inet_timewait_death_row *skc_tw_dr; /*
> inet_timewait_sock */
>         };
>=20
> Can you give it a try?

I thought this would work, but applying this patch on both on next-2025051=
3 and=20
next-20250516 gives the usual kernel panic (captured via netconsole) or th=
e lockup
(which I'm not repeating here ~1000 lines).


[  199.627464][  T580] Oops: general protection fault, probably for non-ca=
nonical address 0xff510aa8ab572985: 0000 [#1] SMP NOPTI
[  199.627475][  T580] CPU: 8 UID: 0 PID: 580 Comm: napi/phy0-0 Not tainte=
d 6.15.0-rc6-next-20250513-llvm-00005-gdd968010bbfa #993 PREEMPT_{RT,(full=
)}=20
[  199.627481][  T580] Hardware name: Micro-Star International Co., Ltd. A=
lpha 15 B5EEK/MS-158L, BIOS E158LAMS.10F 11/11/2024
[  199.627484][  T580] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c0
[  199.627494][  T580] Code: c8 c1 e8 10 66 87 47 02 66 85 c0 74 40 0f b7 =
c0 89 c6 83 e6 03 c1 e6 04 83 e0 fc 49 c7 c0 f8 ff ff ff 49 8b 84 40 a0 fa=
 98 ab <48>
89 94 06 c0 21 06 ac 83 7a 08 00 75 08 f3 90 83 7a 08 00 74 f8
[  199.627497][  T580] RSP: 0018:ffffd0c301e77998 EFLAGS: 00010006
[  199.627501][  T580] RAX: ff510aa8ff5107b5 RBX: 0000000000000286 RCX: 00=
00000000240000
[  199.627503][  T580] RDX: ffff8a716e8231c0 RSI: 0000000000000010 RDI: ff=
ff8a64c7ed35f8
[  199.627505][  T580] RBP: ffff8a62c8751200 R08: fffffffffffffff8 R09: 00=
00000000000001
[  199.627507][  T580] R10: 0000000000000001 R11: ffffffffab1f0820 R12: ff=
ff8a64c7ed35e0
[  199.627509][  T580] R13: ffff8a62cbaf2480 R14: ffff8a64c7ed35f8 R15: ff=
ff8a64c7ed35f8
[  199.627511][  T580] FS:  0000000000000000(0000) GS:ffff8a71c27c1000(000=
0) knlGS:0000000000000000
[  199.627513][  T580] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  199.627515][  T580] CR2: 00007fbadcaec0b0 CR3: 00000007fc23a000 CR4: 00=
00000000750ef0
[  199.627518][  T580] PKRU: 55555554
[  199.627519][  T580] Call Trace:
[  199.627522][  T580]  <TASK>
[  199.627525][  T580]  _raw_spin_lock_irqsave+0x57/0x60
[  199.627531][  T580]  rt_spin_lock+0x73/0xa0
[  199.627536][  T580]  sock_queue_err_skb+0xdc/0x140
[  199.627542][  T580]  skb_complete_wifi_ack+0xa9/0x120
[  199.627551][  T580]  ieee80211_report_used_skb+0x541/0x6e0 [mac80211]
[  199.627598][  T580]  ? srso_alias_return_thunk+0x5/0xfbef5
[  199.627604][  T580]  ? srso_alias_return_thunk+0x5/0xfbef5
[  199.627608][  T580]  ieee80211_tx_status_ext+0x3b3/0x870 [mac80211]
[  199.627636][  T580]  ? srso_alias_return_thunk+0x5/0xfbef5
[  199.627638][  T580]  ? rt_spin_lock+0x3d/0xa0
[  199.627646][  T580]  ? mt76_tx_status_unlock+0x38/0x230 [mt76]
[  199.627657][  T580]  mt76_tx_status_unlock+0x1e0/0x230 [mt76]
[  199.627668][  T580]  __mt76_tx_complete_skb+0x13b/0x2e0 [mt76]
[  199.627676][  T580]  ? srso_alias_return_thunk+0x5/0xfbef5
[  199.627679][  T580]  ? rt_spin_unlock+0x12/0x40
[  199.627682][  T580]  ? srso_alias_return_thunk+0x5/0xfbef5
[  199.627688][  T580]  mt76_connac2_txwi_free+0x127/0x150 [mt76_connac_li=
b]
[  199.627698][  T580]  mt7921_mac_tx_free+0x112/0x260 [mt7921_common]
[  199.627708][  T580]  mt7921_rx_check+0x33/0xe0 [mt7921_common]
[  199.627715][  T580]  mt76_dma_rx_poll+0x322/0x660 [mt76]
[  199.627725][  T580]  ? mt792x_poll_rx+0x2a/0x120 [mt792x_lib]
[  199.627732][  T580]  mt792x_poll_rx+0x71/0x120 [mt792x_lib]
[  199.627739][  T580]  __napi_poll+0x2a/0x170
[  199.627743][  T580]  ? napi_threaded_poll_loop+0x32/0x1b0
[  199.627746][  T580]  napi_threaded_poll_loop+0xe4/0x1b0
[  199.627749][  T580]  ? napi_threaded_poll_loop+0x32/0x1b0
[  199.627751][  T580]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  199.627757][  T580]  napi_threaded_poll+0x57/0x80
[  199.627760][  T580]  ? __pfx_napi_threaded_poll+0x10/0x10
[  199.627763][  T580]  kthread+0x25c/0x280
[  199.627769][  T580]  ? __pfx_kthread+0x10/0x10
[  199.627773][  T580]  ret_from_fork+0xc4/0x1b0
[  199.627777][  T580]  ? __pfx_kthread+0x10/0x10
[  199.627781][  T580]  ret_from_fork_asm+0x1a/0x30
[  199.627788][  T580]  </TASK>
[  199.627789][  T580] Modules linked in: sd_mod scsi_mod scsi_common netc=
onsole ccm snd_seq_dummy snd_hrtimer snd_seq_midi snd_rawmidi snd_seq_midi=
_event
snd_seq snd_seq_device rfcomm bnep nls_ascii nls_cp437 vfat fat snd_ctl_le=
d snd_hda_codec_realtek snd_hda_scodec_component snd_hda_codec_generic
snd_hda_codec_hdmi btusb btbcm btintel btrtl snd_hda_intel btmtk snd_intel=
_dspcfg snd_hda_codec snd_soc_dmic snd_acp3x_rn snd_acp3x_pdm_dma snd_hwde=
p bluetooth
snd_hda_core snd_soc_core uvcvideo videobuf2_vmalloc videobuf2_memops snd_=
pcm_oss uvc videobuf2_v4l2 snd_mixer_oss videodev snd_pcm snd_rn_pci_acp3x
snd_acp_config videobuf2_common snd_timer snd_soc_acpi msi_wmi ecdh_generi=
c ecc sparse_keymap mc wmi_bmof edac_mce_amd snd k10temp snd_pci_acp3x ccp=
 soundcore
battery ac button joydev hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor=
_prox hid_sensor_als hid_sensor_gyro_3d hid_sensor_trigger hid_sensor_iio_=
common
industrialio_triggered_buffer kfifo_buf amd_pmc evdev industrialio mt7921e=
 mt
May 18 13:22:44 7921_common mt792x_lib mt76_connac_lib mt76
[  199.627877][  T580]  mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fab=
rics efi_pstore configfs efivarfs autofs4 ext4 mbcache jbd2 amdgpu usbhid
drm_panel_backlight_quirks cec drm_buddy drm_suballoc_helper drm_exec i2c_=
algo_bit drm_display_helper gpu_sched drm_ttm_helper hid_sensor_hub ttm xh=
ci_pci
hid_multitouch mfd_core hid_generic xhci_hcd i2c_hid_acpi drm_client_lib u=
sbcore psmouse amd_sfh i2c_hid drm_kms_helper nvme hid serio_raw nvme_core=
 amdxcp
r8169 i2c_piix4 crc16 usb_common i2c_smbus i2c_designware_platform i2c_des=
ignware_core
[  199.627931][  T580] ---[ end trace 0000000000000000 ]---
[  199.781799][  T580] RIP: 0010:queued_spin_lock_slowpath+0x120/0x1c0
[  199.781799][  T580] Code: c8 c1 e8 10 66 87 47 02 66 85 c0 74 40 0f b7 =
c0 89 c6 83 e6 03 c1 e6 04 83 e0 fc 49 c7 c0 f8 ff ff ff 49 8b 84 40 a0 fa=
 98 ab <48>
89 94 06 c0 21 06 ac 83 7a 08 00 75 08 f3 90 83 7a 08 00 74 f8
[  199.781799][  T580] RSP: 0018:ffffd0c301e77998 EFLAGS: 00010006
[  199.781799][  T580] RAX: ff510aa8ff5107b5 RBX: 0000000000000286 RCX: 00=
00000000240000
[  199.781799][  T580] RDX: ffff8a716e8231c0 RSI: 0000000000000010 RDI: ff=
ff8a64c7ed35f8
[  199.781799][  T580] RBP: ffff8a62c8751200 R08: fffffffffffffff8 R09: 00=
00000000000001
[  199.781799][  T580] R10: 0000000000000001 R11: ffffffffab1f0820 R12: ff=
ff8a64c7ed35e0
[  199.781799][  T580] R13: ffff8a62cbaf2480 R14: ffff8a64c7ed35f8 R15: ff=
ff8a64c7ed35f8
[  199.781799][  T580] FS:  0000000000000000(0000) GS:ffff8a71c27c1000(000=
0) knlGS:0000000000000000
[  199.781799][  T580] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  199.781799][  T580] CR2: 00007fbadcaec0b0 CR3: 00000007fc23a000 CR4: 00=
00000000750ef0
[  199.781799][  T580] PKRU: 55555554
[  199.781799][  T580] Kernel panic - not syncing: Fatal exception in inte=
rrupt
[  199.788541][  T580] Kernel Offset: 0x29800000 from 0xffffffff81000000 (=
relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  199.788541][  T580] ---[ end Kernel panic - not syncing: Fatal exceptio=
n in interrupt ]---

I even tried this version of your patch, to keep the offset of skc_refcnt =
at 128,
but it doesn't  work, either.

commit fca84c5cde713be480544a64ed6680afc3319670
Author: Bert Karwatzki <spasswolf@web.de>
Date:   Sun May 18 13:32:36 2025 +0200

    include: net: sock: move skc_flags out of the union
   =20
    Signed-off-by: Bert Karwatzki <spasswolf@web.de>

diff --git a/include/net/sock.h b/include/net/sock.h
index 3e15d7105ad2..e73929a4da6e 100644
=2D-- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -195,7 +195,6 @@ struct sock_common {
 	 * for different kind of 'sockets'
 	 */
 	union {
-		unsigned long	skc_flags;
 		struct sock	*skc_listener; /* request_sock */
 		struct inet_timewait_death_row *skc_tw_dr; /* inet_timewait_sock */
 	};
@@ -221,6 +220,9 @@ struct sock_common {
 	};
=20
 	refcount_t		skc_refcnt;
+
+	/* place skc_flags here to keep offset(struct sock, sk_refcnt) =3D=3D 12=
8 */
+	unsigned long	skc_flags;
 	/* private: */
 	int                     skc_dontcopy_end[0];
 	union {

> > >=20
> > > I've added more debugging output:
> > >=20
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index e223102337c7..e13560b5b7a8 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -2735,8 +2735,10 @@ static inline void _sock_tx_timestamp(struct =
sock *sk,
> > >                               *tskey =3D atomic_inc_return(&sk->sk_t=
skey) - 1;
> > >               }
> > >       }
> > > -     if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS)))
> > > +     if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS))) {
> > > +             printk(KERN_INFO "%s: setting SKBTX_WIFI_STATUS for sk=
 =3D %px\n", __func__, sk);
> > >               *tx_flags |=3D SKBTX_WIFI_STATUS;
> > > +     }
> > >  }
> > >=20
> > >  static inline void sock_tx_timestamp(struct sock *sk,
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index e02a78538e3e..f6589ad5ba36 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -1548,6 +1548,7 @@ int sk_setsockopt(struct sock *sk, int level, =
int optname,
> > >               break;
> > >=20
> > >       case SO_WIFI_STATUS:
> > > +             printk(KERN_INFO "%s: setting SOCK_WIFI_STATUS to %u f=
or sk =3D %px\n", __func__, valbool, sk);
> > >               sock_valbool_flag(sk, SOCK_WIFI_STATUS, valbool);
> > >               break;
> > >=20
> > > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > > index 853493eca4f5..eee2f80949c6 100644
> > > --- a/net/mac80211/tx.c
> > > +++ b/net/mac80211/tx.c
> > > @@ -4588,9 +4588,12 @@ static noinline void ieee80211_8023_xmit_clan=
g_debug_helper(struct sk_buff *skb,
> > >  {
> > >       if (unlikely(skb->sk && ((skb_shinfo(skb)->tx_flags & SKBTX_WI=
FI_STATUS) ||
> > >                               sock_flag(skb->sk, SOCK_WIFI_STATUS)))=
) {
> > > -             if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ =
sock_flag(skb->sk, SOCK_WIFI_STATUS))
> > > +             if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ =
sock_flag(skb->sk, SOCK_WIFI_STATUS)) {
> > >                       printk(KERN_INFO "%s: skb_shinfo(skb)->tx_flag=
s & SKBTX_WIFI_STATUS =3D %u sock_flag(skb->sk, SOCK_WIFI_STATUS) =3D %u\n=
",
> > >                                       __func__, (skb_shinfo(skb)->tx=
_flags & SKBTX_WIFI_STATUS), sock_flag(skb->sk, SOCK_WIFI_STATUS));
> > > +                     printk(KERN_INFO "%s: skb->sk =3D %px skb->sk-=
>sk_flags =3D 0x%lx\n", __func__, skb->sk, skb->sk->sk_flags);
> > > +                     return; // This should make this case non-fata=
l.
> > > +             }
> > >               info->status_data =3D ieee80211_store_ack_skb(local, s=
kb,
> > >                                                           &info->fla=
gs, NULL);
> > >               if (info->status_data)
> > >=20
> > >=20
> > >=20
> > > This gives after ~15min uptime
> > >=20
> > > [  189.337797] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  189.337803] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1b798c4e00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > > [  191.325256] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  191.325259] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1b798c5a00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > > [  257.591831] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  257.591844] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1baf3bca00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > > [  301.786963] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  301.786967] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1c1bc40100 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > > [  302.780881] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  302.780884] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1a44cf6000 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > > [  482.792298] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  482.792304] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1da0f4de00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > > [  482.806144] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  482.806148] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1da0f4c500 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > > [  482.817280] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  482.817284] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1da0f4df00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > > [  552.327291] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  552.327295] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1da0f4de00 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > > [  916.971599] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =3D 0 sock_flag(skb->sk, SOCK_=
WIFI_STATUS) =3D 1
> > > [  916.971607] [    T576] ieee80211_8023_xmit_clang_debug_helper: sk=
b->sk =3D ffff8c1a62834000 skb->sk->sk_flags =3D 0xffffffffb4efe640
> > >=20
> > > The printk()s in sk_set_sockopt() and _sock_tx_timestamp() are not c=
alled at all so the flag
> > > SOCK_WIFI_STATUS is actually nevers set! What is printed when printi=
ng skb->sk->sk_flags looks
> > > suspiciously like a pointer, and as sk_flags is actually a member of=
 a union in struct sock_common
> > > it seems clang is using sk_flags for one of the other union members =
here
> > >=20
> > > struct sock_common {
> > > [...]
> > >       union {
> > >               unsigned long   skc_flags;
> > >               struct sock     *skc_listener; /* request_sock */
> > >               struct inet_timewait_death_row *skc_tw_dr; /* inet_tim=
ewait_sock */
> > >       };
> > > [...]
> > > }
> > >=20
> > > Bert Karwatzki
> >=20
> > I added even more debugging output and found out why commit 76a853f86c=
97 (" wifi: free
> > SKBTX_WIFI_STATUS skb tx_flags flag") does not work.
> >=20
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index e13560b5b7a8..6e1291d2e5a1 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2738,6 +2738,8 @@ static inline void _sock_tx_timestamp(struct soc=
k *sk,
> >         if (unlikely(sock_flag(sk, SOCK_WIFI_STATUS))) {
> >                 printk(KERN_INFO "%s: setting SKBTX_WIFI_STATUS for sk=
 =3D %px\n", __func__, sk);
> >                 *tx_flags |=3D SKBTX_WIFI_STATUS;
> > +       } else {
> > +               printk(KERN_INFO "%s: NOT setting SKBTX_WIFI_STATUS fo=
r sk =3D %px\n", __func__, sk);
> >         }
> >  }
> >=20
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connectio=
n_sock.c
> > index 20915895bdaa..4913b09c0617 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -912,6 +912,7 @@ reqsk_alloc_noprof(const struct request_sock_ops *=
ops, struct sock *sk_listener,
> >                         return NULL;
> >                 }
> >                 req->rsk_listener =3D sk_listener;
> > +               printk(KERN_INFO "%s: sk_listener =3D %px\n", __func__=
, sk_listener);
> >         }
> >         req->rsk_ops =3D ops;
> >         req_to_sk(req)->sk_prot =3D sk_listener->sk_prot;
> > @@ -986,6 +987,7 @@ static struct request_sock *inet_reqsk_clone(struc=
t request_sock *req,
> >         nreq_sk->sk_incoming_cpu =3D req_sk->sk_incoming_cpu;
> >=20
> >         nreq->rsk_listener =3D sk;
> > +       printk(KERN_INFO "%s: rsk_listener =3D%px\n", __func__, sk);
> >=20
> >         /* We need not acquire fastopenq->lock
> >          * because the child socket is locked in inet_csk_listen_stop(=
).
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_so=
ck.c
> > index 67efe9501581..1a3108ec7503 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -190,6 +190,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const s=
truct sock *sk,
> >                 const struct inet_sock *inet =3D inet_sk(sk);
> >=20
> >                 tw->tw_dr           =3D dr;
> > +               printk(KERN_INFO "%s: sk =3D %px tw_dr =3D %px\n", __f=
unc__, sk, dr);
> >                 /* Give us an identity. */
> >                 tw->tw_daddr        =3D inet->inet_daddr;
> >                 tw->tw_rcv_saddr    =3D inet->inet_rcv_saddr;
> > diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> > index eee2f80949c6..227b86427e06 100644
> > --- a/net/mac80211/tx.c
> > +++ b/net/mac80211/tx.c
> > @@ -4586,6 +4586,8 @@ static noinline void ieee80211_8023_xmit_clang_d=
ebug_helper(struct sk_buff *skb,
> >                                                             struct iee=
e80211_local *local,
> >                                                             struct iee=
e80211_tx_info *info)
> >  {
> > +       if (skb->sk)
> > +               printk(KERN_INFO "%s: skb->sk =3D %px skb->sk->sk_flag=
s =3D 0x%lx\n", __func__, skb->sk, skb->sk->sk_flags);
> >         if (unlikely(skb->sk && ((skb_shinfo(skb)->tx_flags & SKBTX_WI=
FI_STATUS) ||
> >                                 sock_flag(skb->sk, SOCK_WIFI_STATUS)))=
) {
> >                 if ((skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS) ^ =
sock_flag(skb->sk, SOCK_WIFI_STATUS)) {
> >=20
> >=20
> > This monitor the value of skb->sk->sk_flags not only in the error case=
 but in all cases, and also monitors
> > the places where the other members of the sk_flags union are set. The =
error occurs when at the start
> > of ieee80211_8023_xmit_clang_debug_helper() sk_flags is not actually t=
he skc_flags member of the union
> > but insted is skc_tw_dr which is only interpreted is flags.
> >  So why does it work with gcc but fail with clang? sock_flag(skb->sk, =
SOCK_WIFI_STATUS) test bit 19 of
> > skb->sk->sk_flags
>=20
> Could you say more about this? I don't follow it. Why does the gcc
> test just miss the crash issue? Is there anything (like call trace)
> different between them?
>=20

I think it is just pointer lottery, the pointer in the gcc version has bit
19 not set while the pointer in the clang version has bit 19 set. Why this=
 is
always the case, I don't know, there is KASLR active after all.
 By the way, the pointer value that is incorrectly used as sk_flags set
in inet_twsk_alloc() (called by tcp_time_wait()):


struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
					   struct inet_timewait_death_row *dr,
					   const int state)
{
	struct inet_timewait_sock *tw;

	if (refcount_read(&dr->tw_refcount) - 1 >=3D
	    READ_ONCE(dr->sysctl_max_tw_buckets))
		return NULL;

	tw =3D kmem_cache_alloc(sk->sk_prot_creator->twsk_prot->twsk_slab,
			      GFP_ATOMIC);
	if (tw) {
		const struct inet_sock *inet =3D inet_sk(sk);

		tw->tw_dr	    =3D dr; // This is incorrectly use as sk_flags!xXX


> My worry is that all the callers calling sock_flag might have such
> potential risk...
>=20
> Thanks,
> Jason

I'd worry that, too. How can callers of sock_flag() know which part of the=
 union is
active? At least for debugging purposes one could add a bool to struct soc=
k_common
which is false by default and gets set to true when the pointer members of=
 the union are
set, e.g. in inet_twsk_alloc():


struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
					   struct inet_timewait_death_row *dr,
					   const int state)
{
	struct inet_timewait_sock *tw;

	if (refcount_read(&dr->tw_refcount) - 1 >=3D
	    READ_ONCE(dr->sysctl_max_tw_buckets))
		return NULL;

	tw =3D kmem_cache_alloc(sk->sk_prot_creator->twsk_prot->twsk_slab,
			      GFP_ATOMIC);
	if (tw) {
		const struct inet_sock *inet =3D inet_sk(sk);

		tw->tw_dr	    =3D dr;
                tw->is_pointer =3D true;

>=20


Bert Karwatzki

