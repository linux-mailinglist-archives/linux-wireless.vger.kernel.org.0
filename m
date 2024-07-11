Return-Path: <linux-wireless+bounces-10197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5692F2B1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6910282A33
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49805158DD4;
	Thu, 11 Jul 2024 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2gsl6RV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EF158A35
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741240; cv=none; b=A0ZjhfIYyvOSs2bcOD8tszqx4d8wKmHnoWLfAAzo4cr9fsbp3bcykX+hgZOs1ZiLH8/45k7fa8tSIMQqgUew1mN6kIkRPH90KG9v0iPAc92uBiQAcnml/4bRfO9pM8CvsHHhtsvuhU+83J70Fhu7WpQ3PYb/arzDvpdnT76Ep+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741240; c=relaxed/simple;
	bh=CBZgcipMMlZybeftYQs7NXfySUTeTYBlI0IpELGCypA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubsp5+ZPmdHieT5DeyWIYSZqXj167AdNSq5hxZSExj8acBAHEVAoLiOp4LQk9hfEpQbfZ683iKfdt9wxZxa9fXpBYMyyiQVTsD0Opfetfmxj37FCqfxuB4yGLihMU6a6IMjMEfy3xWoUxYLBko0XEv0vJ39vwfKJ70evlOZ2+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2gsl6RV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82689C116B1
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720741239;
	bh=CBZgcipMMlZybeftYQs7NXfySUTeTYBlI0IpELGCypA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M2gsl6RVjJ9n2DWbrJym/OrTfA1KlnovmTu/SysQA+S1Zd8Ynb0iyDqP1N+BN82sc
	 PIb9JoqWoF6inCV2M6VLukwb/iGKsftVKkoXrd8IpteXOAjhL4iEHlxgBKuPiP4Zoo
	 jSADqqXMneMJDGvmvq8pD8AgfdAdkga2Nz2Gfc9390PMI7qN8m0NILn3MH8Z5mUNSp
	 yngahswbyqpBpVe5iy4AD97eKfORliMPD3A81M0Nzy+IkHkg+U9FefcTe8xXcgi/DQ
	 e0QDGJejBPO+7iB8SWxaVcYNShX6r1vikmpppYlDpJyuO2GanabMYCEaUC/AqRcOtR
	 EUf7OLRZLDl5Q==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77dcbc54ebso9604566b.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 16:40:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3aJTlGEFeyKpKbigksU48dSLpdGX9OZEM5GjiLTzSv2HFXSQyBohNhfeLhtYvL6MjMcb88KoedujPfGWqVi9ISplcduoBf9pT4Lsx34E=
X-Gm-Message-State: AOJu0YyUgrbwXMlwN6sYo5aDCCDzridi/BhHNEpQpg43Y0NLskejW7vi
	yaocpbf7ueojeS9QqI88X8xDfX93meMf7pGki46pIaibjSvuGM//KMSpQGTLhZ0hHuoOKrJTGOC
	TO+c2bdA0/EnUVzafocuhCBJRN+g=
X-Google-Smtp-Source: AGHT+IE8evi5+Efy8qv1M1G33XPdeuvyM927ds8XeC+G4PA35QTRG+kMvQnIHNW1xHulZHgmozuXfxUlRWT/iulbRJk=
X-Received: by 2002:a17:906:8a62:b0:a79:7ec8:f406 with SMTP id
 a640c23a62f3a-a798b5117e5mr180875066b.3.1720741238002; Thu, 11 Jul 2024
 16:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711175156.4465-1-spasswolf@web.de>
In-Reply-To: <20240711175156.4465-1-spasswolf@web.de>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 11 Jul 2024 18:40:24 -0500
X-Gmail-Original-Message-ID: <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
Message-ID: <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
To: Bert Karwatzki <spasswolf@web.de>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	mingyen.hsieh@mediatek.com, nbd@nbd.name, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bert,

Thanks for the detailed debug log. I've quickly made a change to fix
the issue. Right now, I can't access the test environment, but I'll
test it and send it out as soon as possible. Here's the patch.

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2e6268cb06c0..1bab93d049df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -303,6 +303,7 @@ mt7921_add_interface(struct ieee80211_hw *hw,
struct ieee80211_vif *vif)

        mvif->bss_conf.mt76.omac_idx =3D mvif->bss_conf.mt76.idx;
        mvif->phy =3D phy;
+       mvif->bss_conf.vif =3D mvif;
        mvif->bss_conf.mt76.band_idx =3D 0;
        mvif->bss_conf.mt76.wmm_idx =3D mvif->bss_conf.mt76.idx %
MT76_CONNAC_MAX_WMM_SETS;

On Thu, Jul 11, 2024 at 12:52=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> Since linux-next-20240711 my linux system fails to start with a NULL poin=
ter
> error. Hardware: MSI Alpha 15 Laptop Ryzen 5800H with
> 04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
>
> [  T843] BUG: unable to handle page fault for address: ffffffffffffffa0
> [  T843] #PF: supervisor read access in kernel mode
> [  T843] #PF: error_code(0x0000) - not-present page
> [  T843] PGD e5c81a067 P4D e5c81a067 PUD e5c81c067 PMD 0
> [  T843] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  T843] CPU: 2 UID: 0 PID: 843 Comm: NetworkManager Not tainted 6.10.0-r=
c7-next-20240711-dirty #9
> [  T843] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK=
/MS-158L, BIOS E158LAMS.107 11/10/2021
> [  T843] RIP: 0010:mt792x_mac_link_bss_remove+0x24/0x110 [mt792x_lib]
> [  T843] Code: 84 00 00 00 00 00 f3 0f 1e fa 41 56 41 55 41 54 49 89 f4 5=
5 48 89 fd 53 48 8b 46 18 48 89 d3 44 0f b7 aa b8 00 00 00 8b 56 60 <66> 83=
 78 a0 00 74 0f 83 fa 0e 77 0a 4c 8b b4 d0 28 ff ff ff eb 07
> [  T843] RSP: 0018:ffffbc1b43b3b688 EFLAGS: 00010282
> [  T843] RAX: 0000000000000000 RBX: ffff906ab80a9f00 RCX: 000fffffffe0000=
0
> [  T843] RDX: 0000000000000000 RSI: ffff906ab80a9e20 RDI: ffff9069c171200=
0
> [  T843] RBP: ffff9069c1712000 R08: ffff9069c0402018 R09: ffffffffab22672=
0
> [  T843] R10: 0000000000000000 R11: 0000000000000000 R12: ffff906ab80a9e2=
0
> [  T843] R13: 0000000000000013 R14: 0000000000000000 R15: ffff906ab80a999=
0
> [  T843] FS:  00007fb2edd7b500(0000) GS:ffff90786e680000(0000) knlGS:0000=
000000000000
> [  T843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  T843] CR2: ffffffffffffffa0 CR3: 000000010a104000 CR4: 0000000000750ef=
0
> [  T843] PKRU: 55555554
> [  T843] Call Trace:
> [  T843]  <TASK>
> [  T843]  ? __die+0x1e/0x60
> [  T843]  ? page_fault_oops+0x157/0x450
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? search_bpf_extables+0x5a/0x80
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? exc_page_fault+0x2bb/0x670
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? lock_timer_base+0x71/0x90
> [  T843]  ? asm_exc_page_fault+0x26/0x30
> [  T843]  ? mt792x_mac_link_bss_remove+0x24/0x110 [mt792x_lib]
> [  T843]  ? mt792x_remove_interface+0x6e/0x90 [mt792x_lib]
> [  T843]  ? ieee80211_do_stop+0x507/0x7e0 [mac80211]
> [  T843]  ? ieee80211_stop+0x53/0x190 [mac80211]
> [  T843]  ? __dev_close_many+0xa5/0x120
> [  T843]  ? __dev_change_flags+0x18c/0x220
> [  T843]  ? dev_change_flags+0x21/0x60
> [  T843]  ? do_setlink+0xdf9/0x11d0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? security_sock_rcv_skb+0x33/0x50
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? __nla_validate_parse+0x61/0xd10
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? genl_done+0x53/0x80
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? netlink_dump+0x357/0x410
> [  T843]  ? __rtnl_newlink+0x5d6/0x980
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? genl_family_rcv_msg_dumpit+0xdf/0xf0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? __kmalloc_cache_noprof+0x44/0x210
> [  T843]  ? rtnl_newlink+0x42/0x60
> [  T843]  ? rtnetlink_rcv_msg+0x152/0x3f0
> [  T843]  ? mptcp_pm_nl_dump_addr+0x180/0x180
> [  T843]  ? rtnl_calcit.isra.0+0x130/0x130
> [  T843]  ? netlink_rcv_skb+0x56/0x100
> [  T843]  ? netlink_unicast+0x199/0x290
> [  T843]  ? netlink_sendmsg+0x21d/0x490
> [  T843]  ? __sock_sendmsg+0x78/0x80
> [  T843]  ? ____sys_sendmsg+0x23f/0x2e0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? copy_msghdr_from_user+0x68/0xa0
> [  T843]  ? ___sys_sendmsg+0x81/0xd0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? crng_fast_key_erasure+0xbc/0xf0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? get_random_bytes_user+0x126/0x140
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? __fdget+0xb1/0xe0
> [  T843]  ? __sys_sendmsg+0x56/0xa0
> [  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T843]  ? do_syscall_64+0x5f/0x170
> [  T843]  ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [  T843]  </TASK>
> [  T843] Modules linked in: bnep nls_ascii nls_cp437 vfat fat snd_ctl_led=
 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component snd_h=
da_codec_hdmi btusb btrtl btintel snd_hda_intel uvcvideo btbcm snd_intel_ds=
pcfg btmtk snd_hda_codec snd_soc_dmic snd_acp3x_pdm_dma snd_acp3x_rn videob=
uf2_vmalloc snd_hwdep uvc bluetooth videobuf2_memops snd_soc_core snd_hda_c=
ore videobuf2_v4l2 snd_pcm_oss snd_mixer_oss videodev snd_pcm snd_rn_pci_ac=
p3x videobuf2_common snd_acp_config snd_timer msi_wmi snd_soc_acpi ecdh_gen=
eric amd_atl mc ecc sparse_keymap edac_mce_amd wmi_bmof snd ccp k10temp snd=
_pci_acp3x soundcore ac battery button hid_sensor_prox hid_sensor_gyro_3d h=
id_sensor_als hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_trigger ind=
ustrialio_triggered_buffer joydev kfifo_buf industrialio amd_pmc hid_sensor=
_iio_common evdev hid_multitouch serio_raw mt7921e mt7921_common mt792x_lib=
 mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabric=
s configfs efi_pstore efivarfs autofs4 ext4
> [  T843]  crc32c_generic mbcache jbd2 usbhid amdgpu i2c_algo_bit drm_ttm_=
helper xhci_pci ttm drm_exec drm_suballoc_helper xhci_hcd amdxcp drm_buddy =
hid_sensor_hub usbcore nvme gpu_sched mfd_core hid_generic crc32c_intel psm=
ouse drm_display_helper amd_sfh i2c_piix4 usb_common nvme_core crc16 r8169 =
i2c_hid_acpi i2c_hid hid i2c_designware_platform i2c_designware_core
> [  T843] CR2: ffffffffffffffa0
> [  T843] ---[ end trace 0000000000000000 ]---
>
> I bisected the error between linux-6.10-rc7 and linux-next-20240711 and t=
he
> first offending commit which showed a NULL pointer error was
> https://lore.kernel.org/all/20240613030241.5771-47-sean.wang@kernel.org/
> but the error is actually a different but most likely related NULL pointe=
r error.
> To debug this I added some printk to the offending commit:
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wi=
reless/mediatek/mt76/mt792x.h
> index 69eb8dac0b70..c17195559b82 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
> @@ -230,6 +230,7 @@ mt792x_vif_to_link(struct mt792x_vif *mvif, u8 link_i=
d)
>         struct ieee80211_vif *vif;
>
>         vif =3D container_of((void *)mvif, struct ieee80211_vif, drv_priv=
);
> +       printk(KERN_INFO "%s %d: vif =3D %px\n", __func__, __LINE__, vif)=
;
>
>         if (!ieee80211_vif_is_mld(vif) ||
>             link_id >=3D IEEE80211_LINK_UNSPECIFIED)
> @@ -259,6 +260,7 @@ mt792x_link_conf_to_mconf(struct ieee80211_bss_conf *=
link_conf)
>  {
>         struct ieee80211_vif *vif =3D link_conf->vif;
>         struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> +       printk(KERN_INFO "%s %d: vif =3D %px mvif =3D %px\n", __func__, _=
_LINE__, vif, mvif);
>
>         return mt792x_vif_to_link(mvif, link_conf->link_id);
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/n=
et/wireless/mediatek/mt76/mt792x_core.c
> index 813296fad0ed..ff627f5986bd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> @@ -119,23 +119,34 @@ static void mt792x_mac_link_bss_remove(struct mt792=
x_dev *dev,
>  {
>         struct mt792x_bss_conf *mconf =3D mt792x_link_conf_to_mconf(link_=
conf);
>         int idx =3D mlink->wcid.idx;
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>
>         mt792x_mutex_acquire(dev);
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>         mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>         mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mlink->wcid, =
false);
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>
>         rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>
>         dev->mt76.vif_mask &=3D ~BIT_ULL(mconf->mt76.idx);
> +       printk(KERN_INFO "%s %d: mconf->vif =3D %px\n", __func__, __LINE_=
_, mconf->vif);
>         mconf->vif->phy->omac_mask &=3D ~BIT_ULL(mconf->mt76.omac_idx);
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>         mt792x_mutex_release(dev);
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>
>         spin_lock_bh(&dev->mt76.sta_poll_lock);
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>         if (!list_empty(&mlink->wcid.poll_list))
>                 list_del_init(&mlink->wcid.poll_list);
>         spin_unlock_bh(&dev->mt76.sta_poll_lock);
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>
>         mt76_wcid_cleanup(&dev->mt76, &mlink->wcid);
> +       printk(KERN_INFO "%s %d\n", __func__, __LINE__);
>  }
>
>  void mt792x_remove_interface(struct ieee80211_hw *hw,
> @@ -143,6 +154,8 @@ void mt792x_remove_interface(struct ieee80211_hw *hw,
>  {
>         struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
>         struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
> +       printk(KERN_INFO "%s %d: hw =3D %px vif =3D %px mvif =3D %px dev =
=3D %px\n",
> +                       __func__, __LINE__, hw, vif, mvif, dev);
>
>         mt792x_mac_link_bss_remove(dev, &vif->bss_conf, &mvif->sta.deflin=
k);
>  }
>
> With these I get the following error message on startup:
>
> [  T858] mt792x_remove_interface 157: hw =3D ffff92dc11560900 vif =3D fff=
f92dbe072d970 mvif =3D ffff92dbe072de00 dev =3D ffff92dc11562000
> [  T858] mt792x_link_conf_to_mconf 263: vif =3D ffff92dbe072d970 mvif =3D=
 ffff92dbe072de00
> [  T858] mt792x_vif_to_link 233: vif =3D ffff92dbe072d970
> [  T858] mt792x_mac_link_bss_remove 122
> [  T858] mt792x_mac_link_bss_remove 125
> [  T858] mt792x_mac_link_bss_remove 127
> [  T858] mt792x_mac_link_bss_remove 129
> [  T858] mt792x_mac_link_bss_remove 132
> [  T858] mt792x_mac_link_bss_remove 135: mconf->vif =3D 0000000000000000
> [  T858] BUG: kernel NULL pointer dereference, address: 00000000000004b8
> [  T858] #PF: supervisor read access in kernel mode
> [  T858] #PF: error_code(0x0000) - not-present page
> [  T858] PGD 0 P4D 0
> [  T858] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  T858] CPU: 0 PID: 858 Comm: NetworkManager Not tainted 6.10.0-rc5-debu=
g-01238-g1541d63c5fe2-dirty #30
> [  T858] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK=
/MS-158L, BIOS E158LAMS.107 11/10/2021
> [  T858] RIP: 0010:mt792x_remove_interface+0x1df/0x2e0 [mt792x_lib]
> [  T858] Code: 85 f0 30 00 00 49 8b 4f 18 e8 5d 4f f0 f7 49 8b 47 18 41 0=
f b6 4f 01 ba 89 00 00 00 48 c7 c6 90 24 05 c1 48 c7 c7 36 33 05 c1 <48> 8b=
 80 b8 04 00 00 49 d3 e4 49 f7 d4 4c 21 a0 10 27 00 00 4c 8d
> [  T858] RSP: 0018:ffff9fcf03db7698 EFLAGS: 00010246
> [  T858] RAX: 0000000000000000 RBX: ffff92dbe072d970 RCX: 000000000000000=
0
> [  T858] RDX: 0000000000000089 RSI: ffffffffc1052490 RDI: ffffffffc105333=
6
> [  T858] RBP: ffff92dc11562000 R08: 0000000000000000 R09: 000000000000000=
3
> [  T858] R10: ffff9fcf03db7550 R11: ffffffffba099d28 R12: 000000000000000=
1
> [  T858] R13: ffff92dbe072ded8 R14: ffff92dc1156a150 R15: ffff92dbe072de0=
0
> [  T858] FS:  00007fa13c515500(0000) GS:ffff92ea6e600000(0000) knlGS:0000=
000000000000
> [  T858] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  T858] CR2: 00000000000004b8 CR3: 00000001046a2000 CR4: 0000000000750ef=
0
> [  T858] PKRU: 55555554
> [  T858] Call Trace:
> [  T858]  <TASK>
> [  T858]  ? __die+0x1e/0x60
> [  T858]  ? page_fault_oops+0x157/0x450
> [  T858]  ? _prb_read_valid+0x273/0x2e0
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? exc_page_fault+0x331/0x670
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? prb_read_valid+0x16/0x20
> [  T858]  ? asm_exc_page_fault+0x26/0x30
> [  T858]  ? mt792x_remove_interface+0x1df/0x2e0 [mt792x_lib]
> [  T858]  ? mt792x_remove_interface+0x1c3/0x2e0 [mt792x_lib]
> [  T858]  ? ieee80211_do_stop+0x507/0x7e0 [mac80211]
> [  T858]  ? ieee80211_stop+0x53/0x190 [mac80211]
> [  T858]  ? __dev_close_many+0xa5/0x120
> [  T858]  ? __dev_change_flags+0x18c/0x220
> [  T858]  ? dev_change_flags+0x21/0x60
> [  T858]  ? do_setlink+0xdf9/0x11d0
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? __kmalloc_large_node+0x7e/0xb0
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? security_sock_rcv_skb+0x33/0x50
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? __nla_validate_parse+0x61/0xd10
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? genl_done+0x53/0x80
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? netlink_dump+0x357/0x410
> [  T858]  ? __rtnl_newlink+0x5d1/0x980
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? genl_family_rcv_msg_dumpit+0xdf/0xf0
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? kmalloc_trace_noprof+0x44/0x210
> [  T858]  ? rtnl_newlink+0x42/0x60
> [  T858]  ? rtnetlink_rcv_msg+0x14d/0x3f0
> [  T858]  ? mptcp_pm_nl_dump_addr+0x180/0x180
> [  T858]  ? rtnl_calcit.isra.0+0x130/0x130
> [  T858]  ? netlink_rcv_skb+0x56/0x100
> [  T858]  ? netlink_unicast+0x199/0x290
> [  T858]  ? netlink_sendmsg+0x21d/0x490
> [  T858]  ? __sock_sendmsg+0x78/0x80
> [  T858]  ? ____sys_sendmsg+0x23f/0x2e0
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? copy_msghdr_from_user+0x68/0xa0
> [  T858]  ? ___sys_sendmsg+0x81/0xd0
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? crng_fast_key_erasure+0xbc/0xf0
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? get_random_bytes_user+0x126/0x140
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? __fdget+0xb1/0xe0
> [  T858]  ? __sys_sendmsg+0x56/0xa0
> [  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  T858]  ? do_syscall_64+0x5f/0x170
> [  T858]  ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [  T858]  </TASK>
> [  T858] Modules linked in: cmac bnep nls_ascii nls_cp437 vfat fat snd_ct=
l_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component =
btusb snd_hda_codec_hdmi btrtl btintel btbcm btmtk snd_hda_intel amd_atl sn=
d_intel_dspcfg bluetooth snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn snd_hd=
a_codec uvcvideo snd_soc_core videobuf2_vmalloc uvc snd_hwdep videobuf2_mem=
ops videobuf2_v4l2 snd_hda_core videodev snd_pcm_oss snd_mixer_oss snd_pcm =
snd_rn_pci_acp3x snd_acp_config videobuf2_common snd_timer msi_wmi snd_soc_=
acpi ecdh_generic ecc mc sparse_keymap edac_mce_amd snd wmi_bmof k10temp cc=
p snd_pci_acp3x soundcore battery ac button joydev hid_sensor_magn_3d hid_s=
ensor_gyro_3d hid_sensor_als hid_sensor_accel_3d hid_sensor_prox hid_sensor=
_trigger industrialio_triggered_buffer kfifo_buf industrialio amd_pmc hid_s=
ensor_iio_common evdev hid_multitouch serio_raw mt7921e mt7921_common mt792=
x_lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_f=
abrics efi_pstore configfs efivarfs autofs4 ext4
> [  T858]  crc32c_generic crc16 mbcache jbd2 usbhid amdgpu i2c_algo_bit xh=
ci_pci drm_ttm_helper ttm xhci_hcd drm_exec drm_suballoc_helper amdxcp nvme=
 drm_buddy hid_sensor_hub usbcore gpu_sched nvme_core mfd_core hid_generic =
crc32c_intel psmouse amd_sfh i2c_piix4 usb_common t10_pi drm_display_helper=
 r8169 i2c_hid_acpi i2c_hid hid i2c_designware_platform i2c_designware_core
> [  T858] CR2: 00000000000004b8
> [  T858] ---[ end trace 0000000000000000 ]---
>
> So the problem is here that mconf->vif is still NULL probably because
> on mt7921 nobody is bothering to set it.
>
> I did a similar investigation for the error in linux-next-20240711
>
> void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
>                                 struct mt792x_bss_conf *mconf,
>                                 struct mt792x_link_sta *mlink)
> {
>         struct ieee80211_vif *vif =3D container_of((void *)mconf->vif,
>                                                  struct ieee80211_vif, dr=
v_priv);
>         struct ieee80211_bss_conf *link_conf;
>         int idx =3D mlink->wcid.idx;
>
>         printk(KERN_INFO "%s %d: dev =3D %px mconf =3D %px mlink =3D %px =
vif =3D %px\n",
>                         __func__, __LINE__, dev, mconf, mlink, vif);
>         link_conf =3D mt792x_vif_to_bss_conf(vif, mconf->link_id);
>
> This leads to the following message on startup
>
> [  T848] mt792x_mac_link_bss_remove 147: dev =3D ffff9403c1672000 mconf =
=3D ffff9403c1a35e20 mlink =3D ffff9403c1a35f00 vif =3D fffffffffffffb70
> [  T848] BUG: unable to handle page fault for address: ffffffffffffffa0
> [  T848] #PF: supervisor read access in kernel mode
> [  T848] #PF: error_code(0x0000) - not-present page
> [skipped backtrace]
>
> showing that vif is an invalid (though not NULL) pointer here, too.
>
> Bert Karwatzki

