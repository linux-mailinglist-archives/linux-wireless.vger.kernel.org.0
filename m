Return-Path: <linux-wireless+bounces-10196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7A092EF23
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 20:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6C2283AE4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9399616DEC9;
	Thu, 11 Jul 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Gg3/giBA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51B28FF
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723765; cv=none; b=OUdvD52bRfN7ExGu7Opu4KX4QmMJCmPsH+LWCBw2x668DvP9u++kd7+baTPwycmM+t13uLETgxKGM4FufU/ibbQz6kON9Cai653pFuMQGuIt/qfLZ5mRYuoEIAUHVcB1+ptT1KGLiBTN7thKr0KBm7q/UAuvR4K3MycbUwl7+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723765; c=relaxed/simple;
	bh=1Koh7oLOB4zH0+Q6lxDF2FIpvCkGcfogIwdI4Xi6UB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrxXW3sR0tQBndZ/2TjuOCZwTOuyxOdIgQCAgFJZ5xljO2Ubx4+sY3mSTQkvqBu8NYOiyXU9o30koWfhKoqSaYjA/xLauuEh8RRlmCLMQ9tKEUNQ0L/mVlffJVjKtALtc7nDF8su4oVSUE80ROJpjGdrCPNJpZj/XlV4nNASmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Gg3/giBA; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720723737; x=1721328537; i=spasswolf@web.de;
	bh=EbgpMFPp9CNxLl2+ZekfMHPr980f61yKLxIYeEbPTSk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gg3/giBAL8tsbJmOX+OC27ME+6ZJyrUZmSA8zXC1uN1F/PZGoImfzcPjSmVS6X+4
	 bibLUzoa+Av+IvzUZg22uRaGvc7nDvlo1NbKLSUsyYeELpYI7dmXtJWwvqJzToNhs
	 tCSGS/cJQyHSZaM0s/rROkDAii43gQt518j+97iGU79/q60hi1LL31iBUxmnezANN
	 c7gazcn52URhyZqwGPPgInnbHTE6g/3cojKaC0JRSHzfzQEGJBKA354BCdYrs0cXt
	 7r0tXkHgSBqQ3W73GIXQg/vFkha02Eu5UXxwhSS1OrU46cGiRIq3NLNW4FUijcBeN
	 RrXwY8aJUdxoKIrIjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MoNZC-1rzUiu3uKO-00oILf; Thu, 11 Jul 2024 20:48:57 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: sean.wang@kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	deren.wu@mediatek.com,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	mingyen.hsieh@mediatek.com,
	nbd@nbd.name,
	sean.wang@mediatek.com
Subject: Re: [PATCH 46/47] wifi: mt76: mt7925: add mt7925_mac_link_bss_remove to remove per-link BSS
Date: Thu, 11 Jul 2024 20:48:53 +0200
Message-ID: <20240711184854.8237-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240613030241.5771-47-sean.wang@kernel.org
References: 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7se7GJmcB5JCd0ZNMHPI6f8/4orbRK25d5xuMTFrwW6hCxwBj0m
 yU3CTsv7IdXWtl6rxov7X/AjF0FjoQ17mNagQoQHU15io0Xj5nd8C1dkoORd3Txd5NE4Poy
 8GqEcFJXD9ydHyE/5xUAVesnJBFsb92AtBky/cNBfMjylDpqj0R1fcXgr0tRgM8e4kogM6K
 yB3aqtXqROZiChas8epGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ppQRLLMk2hA=;Hj5G66LUwdoLI4hUzQPEM5XbMNQ
 XcmU1jqNxCXEk7r65Rwyre4rnHaXn9sx7M8Q40aRBDIjsohxo1rfTMxacVFyUPP5och844gR+
 SekPeCRnFPObe1SkjuTOtMsbTr/9lAAkQIBXkJVV1B8EraRXfgGoRZLRfokgCEJFQ05kR/PQX
 gYcUsa4kD5hx04KfljV0KSLgKuYek+E3KDpYnpR8qtSiMHa4RmNmqFPuTzVlk9KRraynJNR0a
 qO0V9vhhSAOecE6jjdmOaEM1IFvxRJqW/Rj2u4nLj1s6LEjU0u7F51KVbr4tvZe80QrOk6055
 oBqTz4fc6p1Bh1pLikpljpCG6a0uTyguGe1HPkCa8kWW3ZRI5dNwBXYUO9e6xeaP8KedhCHZ2
 juQEFh+DCGcqPqqXta0tNZetaCEl3FkDZEI918rOzF0iy6hG+QYc9FmmMteGMKa89N2AQBuEb
 Uq2y+OmhSp3wuy/A42yyus1eh04Sv6EKCUiZ47hFoOOkIknGAHvM8LJmanbgEvg5ImCllawKD
 W+d5X9PopbkBRHmEy4hccZgXCgCJp6Ypv2Y3azs2Xj1FHMcNCGCtQt97ZbLErfWzPjR6kyo5b
 NSJuzW87lr1iA5CRyYb8DdH4X32PtiCu2qEk2iP22wC4HZ8v3IlfAuAI7+Mv+JiRzTkaL/sYg
 g4ocUOeJQozUmBYY4kiNXvScBAY5z4b0bKUM32eDr1OVhslUuuOaT/BdzL95Befu1xGlOzGWX
 Yk8soIiBsQnxP1izZPYYa9FnWye0w7GTqsctMUx5g/ktT1RiWWgMf9sdIpHUQL13hcJiyjcHD
 CtE//NtNXOlX09yjkDRBum3Vb6eJbMEdqnXkb+P3hs1Qs=

Since linux-next-20240711 my linux system fails to start with a NULL pointer
error. Hardware: MSI Alpha 15 Laptop Ryzen 5800H with
04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz

[  T843] BUG: unable to handle page fault for address: ffffffffffffffa0
[  T843] #PF: supervisor read access in kernel mode
[  T843] #PF: error_code(0x0000) - not-present page
[  T843] PGD e5c81a067 P4D e5c81a067 PUD e5c81c067 PMD 0=20
[  T843] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  T843] CPU: 2 UID: 0 PID: 843 Comm: NetworkManager Not tainted 6.10.0-rc7=
-next-20240711-dirty #9
[  T843] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.107 11/10/2021
[  T843] RIP: 0010:mt792x_mac_link_bss_remove+0x24/0x110 [mt792x_lib]
[  T843] Code: 84 00 00 00 00 00 f3 0f 1e fa 41 56 41 55 41 54 49 89 f4 55 =
48 89 fd 53 48 8b 46 18 48 89 d3 44 0f b7 aa b8 00 00 00 8b 56 60 <66> 83 7=
8 a0 00 74 0f 83 fa 0e 77 0a 4c 8b b4 d0 28 ff ff ff eb 07
[  T843] RSP: 0018:ffffbc1b43b3b688 EFLAGS: 00010282
[  T843] RAX: 0000000000000000 RBX: ffff906ab80a9f00 RCX: 000fffffffe00000
[  T843] RDX: 0000000000000000 RSI: ffff906ab80a9e20 RDI: ffff9069c1712000
[  T843] RBP: ffff9069c1712000 R08: ffff9069c0402018 R09: ffffffffab226720
[  T843] R10: 0000000000000000 R11: 0000000000000000 R12: ffff906ab80a9e20
[  T843] R13: 0000000000000013 R14: 0000000000000000 R15: ffff906ab80a9990
[  T843] FS:  00007fb2edd7b500(0000) GS:ffff90786e680000(0000) knlGS:000000=
0000000000
[  T843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  T843] CR2: ffffffffffffffa0 CR3: 000000010a104000 CR4: 0000000000750ef0
[  T843] PKRU: 55555554
[  T843] Call Trace:
[  T843]  <TASK>
[  T843]  ? __die+0x1e/0x60
[  T843]  ? page_fault_oops+0x157/0x450
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? search_bpf_extables+0x5a/0x80
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? exc_page_fault+0x2bb/0x670
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? lock_timer_base+0x71/0x90
[  T843]  ? asm_exc_page_fault+0x26/0x30
[  T843]  ? mt792x_mac_link_bss_remove+0x24/0x110 [mt792x_lib]
[  T843]  ? mt792x_remove_interface+0x6e/0x90 [mt792x_lib]
[  T843]  ? ieee80211_do_stop+0x507/0x7e0 [mac80211]
[  T843]  ? ieee80211_stop+0x53/0x190 [mac80211]
[  T843]  ? __dev_close_many+0xa5/0x120
[  T843]  ? __dev_change_flags+0x18c/0x220
[  T843]  ? dev_change_flags+0x21/0x60
[  T843]  ? do_setlink+0xdf9/0x11d0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? security_sock_rcv_skb+0x33/0x50
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? __nla_validate_parse+0x61/0xd10
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? genl_done+0x53/0x80
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? netlink_dump+0x357/0x410
[  T843]  ? __rtnl_newlink+0x5d6/0x980
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? genl_family_rcv_msg_dumpit+0xdf/0xf0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? __kmalloc_cache_noprof+0x44/0x210
[  T843]  ? rtnl_newlink+0x42/0x60
[  T843]  ? rtnetlink_rcv_msg+0x152/0x3f0
[  T843]  ? mptcp_pm_nl_dump_addr+0x180/0x180
[  T843]  ? rtnl_calcit.isra.0+0x130/0x130
[  T843]  ? netlink_rcv_skb+0x56/0x100
[  T843]  ? netlink_unicast+0x199/0x290
[  T843]  ? netlink_sendmsg+0x21d/0x490
[  T843]  ? __sock_sendmsg+0x78/0x80
[  T843]  ? ____sys_sendmsg+0x23f/0x2e0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? copy_msghdr_from_user+0x68/0xa0
[  T843]  ? ___sys_sendmsg+0x81/0xd0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? crng_fast_key_erasure+0xbc/0xf0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? get_random_bytes_user+0x126/0x140
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? __fdget+0xb1/0xe0
[  T843]  ? __sys_sendmsg+0x56/0xa0
[  T843]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T843]  ? do_syscall_64+0x5f/0x170
[  T843]  ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  T843]  </TASK>
[  T843] Modules linked in: bnep nls_ascii nls_cp437 vfat fat snd_ctl_led s=
nd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component snd_hda=
_codec_hdmi btusb btrtl btintel snd_hda_intel uvcvideo btbcm snd_intel_dspc=
fg btmtk snd_hda_codec snd_soc_dmic snd_acp3x_pdm_dma snd_acp3x_rn videobuf=
2_vmalloc snd_hwdep uvc bluetooth videobuf2_memops snd_soc_core snd_hda_cor=
e videobuf2_v4l2 snd_pcm_oss snd_mixer_oss videodev snd_pcm snd_rn_pci_acp3=
x videobuf2_common snd_acp_config snd_timer msi_wmi snd_soc_acpi ecdh_gener=
ic amd_atl mc ecc sparse_keymap edac_mce_amd wmi_bmof snd ccp k10temp snd_p=
ci_acp3x soundcore ac battery button hid_sensor_prox hid_sensor_gyro_3d hid=
_sensor_als hid_sensor_accel_3d hid_sensor_magn_3d hid_sensor_trigger indus=
trialio_triggered_buffer joydev kfifo_buf industrialio amd_pmc hid_sensor_i=
io_common evdev hid_multitouch serio_raw mt7921e mt7921_common mt792x_lib m=
t76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fabrics =
configfs efi_pstore efivarfs autofs4 ext4
[  T843]  crc32c_generic mbcache jbd2 usbhid amdgpu i2c_algo_bit drm_ttm_he=
lper xhci_pci ttm drm_exec drm_suballoc_helper xhci_hcd amdxcp drm_buddy hi=
d_sensor_hub usbcore nvme gpu_sched mfd_core hid_generic crc32c_intel psmou=
se drm_display_helper amd_sfh i2c_piix4 usb_common nvme_core crc16 r8169 i2=
c_hid_acpi i2c_hid hid i2c_designware_platform i2c_designware_core
[  T843] CR2: ffffffffffffffa0
[  T843] ---[ end trace 0000000000000000 ]---

I bisected the error between linux-6.10-rc7 and linux-next-20240711 and the
first offending commit which showed a NULL pointer error was
https://lore.kernel.org/all/20240613030241.5771-47-sean.wang@kernel.org/
but the error is actually a different but most likely related NULL pointer =
error.
To debug this I added some printk to the offending commit:

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wire=
less/mediatek/mt76/mt792x.h
index 69eb8dac0b70..c17195559b82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -230,6 +230,7 @@ mt792x_vif_to_link(struct mt792x_vif *mvif, u8 link_id)
 	struct ieee80211_vif *vif;
=20
 	vif =3D container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+	printk(KERN_INFO "%s %d: vif =3D %px\n", __func__, __LINE__, vif);
=20
 	if (!ieee80211_vif_is_mld(vif) ||
 	    link_id >=3D IEEE80211_LINK_UNSPECIFIED)
@@ -259,6 +260,7 @@ mt792x_link_conf_to_mconf(struct ieee80211_bss_conf *li=
nk_conf)
 {
 	struct ieee80211_vif *vif =3D link_conf->vif;
 	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
+	printk(KERN_INFO "%s %d: vif =3D %px mvif =3D %px\n", __func__, __LINE__,=
 vif, mvif);
=20
 	return mt792x_vif_to_link(mvif, link_conf->link_id);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net=
/wireless/mediatek/mt76/mt792x_core.c
index 813296fad0ed..ff627f5986bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -119,23 +119,34 @@ static void mt792x_mac_link_bss_remove(struct mt792x_=
dev *dev,
 {
 	struct mt792x_bss_conf *mconf =3D mt792x_link_conf_to_mconf(link_conf);
 	int idx =3D mlink->wcid.idx;
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
=20
 	mt792x_mutex_acquire(dev);
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf, &mlink->wcid, false);
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
=20
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
=20
 	dev->mt76.vif_mask &=3D ~BIT_ULL(mconf->mt76.idx);
+	printk(KERN_INFO "%s %d: mconf->vif =3D %px\n", __func__, __LINE__, mconf=
->vif);
 	mconf->vif->phy->omac_mask &=3D ~BIT_ULL(mconf->mt76.omac_idx);
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	mt792x_mutex_release(dev);
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
=20
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	if (!list_empty(&mlink->wcid.poll_list))
 		list_del_init(&mlink->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
=20
 	mt76_wcid_cleanup(&dev->mt76, &mlink->wcid);
+	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 }
=20
 void mt792x_remove_interface(struct ieee80211_hw *hw,
@@ -143,6 +154,8 @@ void mt792x_remove_interface(struct ieee80211_hw *hw,
 {
 	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
+	printk(KERN_INFO "%s %d: hw =3D %px vif =3D %px mvif =3D %px dev =3D %px\=
n",
+			__func__, __LINE__, hw, vif, mvif, dev);
=20
 	mt792x_mac_link_bss_remove(dev, &vif->bss_conf, &mvif->sta.deflink);
 }

With these I get the following error message on startup:

[  T858] mt792x_remove_interface 157: hw =3D ffff92dc11560900 vif =3D ffff9=
2dbe072d970 mvif =3D ffff92dbe072de00 dev =3D ffff92dc11562000
[  T858] mt792x_link_conf_to_mconf 263: vif =3D ffff92dbe072d970 mvif =3D f=
fff92dbe072de00
[  T858] mt792x_vif_to_link 233: vif =3D ffff92dbe072d970
[  T858] mt792x_mac_link_bss_remove 122
[  T858] mt792x_mac_link_bss_remove 125
[  T858] mt792x_mac_link_bss_remove 127
[  T858] mt792x_mac_link_bss_remove 129
[  T858] mt792x_mac_link_bss_remove 132
[  T858] mt792x_mac_link_bss_remove 135: mconf->vif =3D 0000000000000000
[  T858] BUG: kernel NULL pointer dereference, address: 00000000000004b8
[  T858] #PF: supervisor read access in kernel mode
[  T858] #PF: error_code(0x0000) - not-present page
[  T858] PGD 0 P4D 0=20
[  T858] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  T858] CPU: 0 PID: 858 Comm: NetworkManager Not tainted 6.10.0-rc5-debug-=
01238-g1541d63c5fe2-dirty #30
[  T858] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/M=
S-158L, BIOS E158LAMS.107 11/10/2021
[  T858] RIP: 0010:mt792x_remove_interface+0x1df/0x2e0 [mt792x_lib]
[  T858] Code: 85 f0 30 00 00 49 8b 4f 18 e8 5d 4f f0 f7 49 8b 47 18 41 0f =
b6 4f 01 ba 89 00 00 00 48 c7 c6 90 24 05 c1 48 c7 c7 36 33 05 c1 <48> 8b 8=
0 b8 04 00 00 49 d3 e4 49 f7 d4 4c 21 a0 10 27 00 00 4c 8d
[  T858] RSP: 0018:ffff9fcf03db7698 EFLAGS: 00010246
[  T858] RAX: 0000000000000000 RBX: ffff92dbe072d970 RCX: 0000000000000000
[  T858] RDX: 0000000000000089 RSI: ffffffffc1052490 RDI: ffffffffc1053336
[  T858] RBP: ffff92dc11562000 R08: 0000000000000000 R09: 0000000000000003
[  T858] R10: ffff9fcf03db7550 R11: ffffffffba099d28 R12: 0000000000000001
[  T858] R13: ffff92dbe072ded8 R14: ffff92dc1156a150 R15: ffff92dbe072de00
[  T858] FS:  00007fa13c515500(0000) GS:ffff92ea6e600000(0000) knlGS:000000=
0000000000
[  T858] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  T858] CR2: 00000000000004b8 CR3: 00000001046a2000 CR4: 0000000000750ef0
[  T858] PKRU: 55555554
[  T858] Call Trace:
[  T858]  <TASK>
[  T858]  ? __die+0x1e/0x60
[  T858]  ? page_fault_oops+0x157/0x450
[  T858]  ? _prb_read_valid+0x273/0x2e0
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? exc_page_fault+0x331/0x670
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? prb_read_valid+0x16/0x20
[  T858]  ? asm_exc_page_fault+0x26/0x30
[  T858]  ? mt792x_remove_interface+0x1df/0x2e0 [mt792x_lib]
[  T858]  ? mt792x_remove_interface+0x1c3/0x2e0 [mt792x_lib]
[  T858]  ? ieee80211_do_stop+0x507/0x7e0 [mac80211]
[  T858]  ? ieee80211_stop+0x53/0x190 [mac80211]
[  T858]  ? __dev_close_many+0xa5/0x120
[  T858]  ? __dev_change_flags+0x18c/0x220
[  T858]  ? dev_change_flags+0x21/0x60
[  T858]  ? do_setlink+0xdf9/0x11d0
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? __kmalloc_large_node+0x7e/0xb0
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? security_sock_rcv_skb+0x33/0x50
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? __nla_validate_parse+0x61/0xd10
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? genl_done+0x53/0x80
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? netlink_dump+0x357/0x410
[  T858]  ? __rtnl_newlink+0x5d1/0x980
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? genl_family_rcv_msg_dumpit+0xdf/0xf0
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? kmalloc_trace_noprof+0x44/0x210
[  T858]  ? rtnl_newlink+0x42/0x60
[  T858]  ? rtnetlink_rcv_msg+0x14d/0x3f0
[  T858]  ? mptcp_pm_nl_dump_addr+0x180/0x180
[  T858]  ? rtnl_calcit.isra.0+0x130/0x130
[  T858]  ? netlink_rcv_skb+0x56/0x100
[  T858]  ? netlink_unicast+0x199/0x290
[  T858]  ? netlink_sendmsg+0x21d/0x490
[  T858]  ? __sock_sendmsg+0x78/0x80
[  T858]  ? ____sys_sendmsg+0x23f/0x2e0
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? copy_msghdr_from_user+0x68/0xa0
[  T858]  ? ___sys_sendmsg+0x81/0xd0
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? crng_fast_key_erasure+0xbc/0xf0
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? get_random_bytes_user+0x126/0x140
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? __fdget+0xb1/0xe0
[  T858]  ? __sys_sendmsg+0x56/0xa0
[  T858]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T858]  ? do_syscall_64+0x5f/0x170
[  T858]  ? entry_SYSCALL_64_after_hwframe+0x55/0x5d
[  T858]  </TASK>
[  T858] Modules linked in: cmac bnep nls_ascii nls_cp437 vfat fat snd_ctl_=
led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component bt=
usb snd_hda_codec_hdmi btrtl btintel btbcm btmtk snd_hda_intel amd_atl snd_=
intel_dspcfg bluetooth snd_acp3x_pdm_dma snd_soc_dmic snd_acp3x_rn snd_hda_=
codec uvcvideo snd_soc_core videobuf2_vmalloc uvc snd_hwdep videobuf2_memop=
s videobuf2_v4l2 snd_hda_core videodev snd_pcm_oss snd_mixer_oss snd_pcm sn=
d_rn_pci_acp3x snd_acp_config videobuf2_common snd_timer msi_wmi snd_soc_ac=
pi ecdh_generic ecc mc sparse_keymap edac_mce_amd snd wmi_bmof k10temp ccp =
snd_pci_acp3x soundcore battery ac button joydev hid_sensor_magn_3d hid_sen=
sor_gyro_3d hid_sensor_als hid_sensor_accel_3d hid_sensor_prox hid_sensor_t=
rigger industrialio_triggered_buffer kfifo_buf industrialio amd_pmc hid_sen=
sor_iio_common evdev hid_multitouch serio_raw mt7921e mt7921_common mt792x_=
lib mt76_connac_lib mt76 mac80211 libarc4 cfg80211 rfkill msr fuse nvme_fab=
rics efi_pstore configfs efivarfs autofs4 ext4
[  T858]  crc32c_generic crc16 mbcache jbd2 usbhid amdgpu i2c_algo_bit xhci=
_pci drm_ttm_helper ttm xhci_hcd drm_exec drm_suballoc_helper amdxcp nvme d=
rm_buddy hid_sensor_hub usbcore gpu_sched nvme_core mfd_core hid_generic cr=
c32c_intel psmouse amd_sfh i2c_piix4 usb_common t10_pi drm_display_helper r=
8169 i2c_hid_acpi i2c_hid hid i2c_designware_platform i2c_designware_core
[  T858] CR2: 00000000000004b8
[  T858] ---[ end trace 0000000000000000 ]---

So the problem is here that mconf->vif is still NULL probably because
on mt7921 nobody is bothering to set it.

I did a similar investigation for the error in linux-next-20240711

void mt792x_mac_link_bss_remove(struct mt792x_dev *dev,
				struct mt792x_bss_conf *mconf,
				struct mt792x_link_sta *mlink)
{
	struct ieee80211_vif *vif =3D container_of((void *)mconf->vif,
						 struct ieee80211_vif, drv_priv);
	struct ieee80211_bss_conf *link_conf;
	int idx =3D mlink->wcid.idx;

	printk(KERN_INFO "%s %d: dev =3D %px mconf =3D %px mlink =3D %px vif =3D %=
px\n",
			__func__, __LINE__, dev, mconf, mlink, vif);
	link_conf =3D mt792x_vif_to_bss_conf(vif, mconf->link_id);

This leads to the following message on startup
=20
[  T848] mt792x_mac_link_bss_remove 147: dev =3D ffff9403c1672000 mconf =3D=
 ffff9403c1a35e20 mlink =3D ffff9403c1a35f00 vif =3D fffffffffffffb70
[  T848] BUG: unable to handle page fault for address: ffffffffffffffa0
[  T848] #PF: supervisor read access in kernel mode
[  T848] #PF: error_code(0x0000) - not-present page
[skipped backtrace]

showing that vif is an invalid (though not NULL) pointer here, too.

The mt7925_ops struct contains these four ieee80211_ops which
are not present in the mt7921_ops struct. In mt7925_change_vif_links
mconf->vif is set.

from drivers/net/wireless/mediatek/mt76/mt7925/main.c:
	.vif_cfg_changed =3D mt7925_vif_cfg_changed,
	.link_info_changed =3D mt7925_link_info_changed,
	.change_vif_links =3D mt7925_change_vif_links,
	.change_sta_links =3D mt7925_change_sta_links,

So I think you're probably breaking generic code (i. e. code that is also u=
sed
on mt7921) with mt7925 specific changes.

(resend with fixed subject)

Bert Karwatzki

