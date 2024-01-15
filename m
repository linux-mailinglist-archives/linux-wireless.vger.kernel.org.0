Return-Path: <linux-wireless+bounces-1898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E282D30B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8DB2814C9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 02:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549E15BE;
	Mon, 15 Jan 2024 02:05:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F715BB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F23tY023479368, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F23tY023479368
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 10:03:55 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 15 Jan 2024 10:03:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 10:03:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Mon, 15 Jan 2024 10:03:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        "Lorenzo
 Bianconi" <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen
	<Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin
	<km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh
	<ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Quan Zhou
	<quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen
	<shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH 1/2] wifi: mt76: mt7921e: fix use-after-free in free_irq()
Thread-Topic: [PATCH 1/2] wifi: mt76: mt7921e: fix use-after-free in
 free_irq()
Thread-Index: AQHaRf8Mfdr/M2DJQ0qJZHApLacQLbDaIV+w
Date: Mon, 15 Jan 2024 02:03:54 +0000
Message-ID: <3a3fc58206ec436e8cdfd97d71350795@realtek.com>
References: <572d6af305a09fc8bdd96a8ee57399039803a2bb.1705135817.git.deren.wu@mediatek.com>
In-Reply-To: <572d6af305a09fc8bdd96a8ee57399039803a2bb.1705135817.git.deren.wu@mediatek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Deren Wu <deren.wu@mediatek.com>
> Sent: Saturday, January 13, 2024 5:00 PM
> To: Felix Fietkau <nbd@nbd.name>; Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Sean Wang <sean.wang@mediatek.com>; Soul Huang <Soul.Huang@mediatek.c=
om>; Ming Yen Hsieh
> <mingyen.hsieh@mediatek.com>; Leon Yen <Leon.Yen@mediatek.com>; Eric-SY C=
hang
> <Eric-SY.Chang@mediatek.com>; KM Lin <km.lin@mediatek.com>; Robin Chiu <r=
obin.chiu@mediatek.com>; CH Yeh
> <ch.yeh@mediatek.com>; Posh Sun <posh.sun@mediatek.com>; Quan Zhou <quan.=
zhou@mediatek.com>; Ryder Lee
> <ryder.lee@mediatek.com>; Shayne Chen <shayne.chen@mediatek.com>; linux-w=
ireless
> <linux-wireless@vger.kernel.org>; linux-mediatek <linux-mediatek@lists.in=
fradead.org>; Deren Wu
> <deren.wu@mediatek.com>
> Subject: [PATCH 1/2] wifi: mt76: mt7921e: fix use-after-free in free_irq(=
)
>=20
> From commit a304e1b82808 ("[PATCH] Debug shared irqs"), there is a test
> to make sure the shared irq handler should be able to handle the unexpect=
ed
> event after deregistration. For this case, let's apply MT76_REMOVED flag =
to
> indicate the device was removed and do not run into the resource access
> anymore.
>=20
> BUG: KASAN: use-after-free in mt7921_irq_handler+0xd8/0x100 [mt7921e]
> Read of size 8 at addr ffff88824a7d3b78 by task rmmod/11115
> CPU: 28 PID: 11115 Comm: rmmod Tainted: G        W    L    5.17.0 #10
> Hardware name: Micro-Star International Co., Ltd. MS-7D73/MPG B650I
> EDGE WIFI (MS-7D73), BIOS 1.81 01/05/2024
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6f/0xa0
>  print_address_description.constprop.0+0x1f/0x190
>  ? mt7921_irq_handler+0xd8/0x100 [mt7921e]
>  ? mt7921_irq_handler+0xd8/0x100 [mt7921e]
>  kasan_report.cold+0x7f/0x11b
>  ? mt7921_irq_handler+0xd8/0x100 [mt7921e]
>  mt7921_irq_handler+0xd8/0x100 [mt7921e]
>  free_irq+0x627/0xaa0
>  devm_free_irq+0x94/0xd0
>  ? devm_request_any_context_irq+0x160/0x160
>  ? kobject_put+0x18d/0x4a0
>  mt7921_pci_remove+0x153/0x190 [mt7921e]
>  pci_device_remove+0xa2/0x1d0
>  __device_release_driver+0x346/0x6e0
>  driver_detach+0x1ef/0x2c0
>  bus_remove_driver+0xe7/0x2d0
>  ? __check_object_size+0x57/0x310
>  pci_unregister_driver+0x26/0x250
>  __do_sys_delete_module+0x307/0x510
>  ? free_module+0x6a0/0x6a0
>  ? fpregs_assert_state_consistent+0x4b/0xb0
>  ? rcu_read_lock_sched_held+0x10/0x70
>  ? syscall_enter_from_user_mode+0x20/0x70
>  ? trace_hardirqs_on+0x1c/0x130
>  do_syscall_64+0x5c/0x80
>  ? trace_hardirqs_on_prepare+0x72/0x160
>  ? do_syscall_64+0x68/0x80
>  ? trace_hardirqs_on_prepare+0x72/0x160
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>=20
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes:
> https://lore.kernel.org/linux-wireless/CABXGCsOdvVwdLmSsC8TZ1jF0UOg_F_W3w=
qLECWX620PUkvNk=3DA@mail.gmail.
> com/
> Fixes: 9270270d6219 ("wifi: mt76: mt7921: fix PCI DMA hang after reboot")
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 1 +
>  drivers/net/wireless/mediatek/mt76/mt792x_dma.c | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> index 57903c6e4f11..2f04d6658b6b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -387,6 +387,7 @@ static void mt7921_pci_remove(struct pci_dev *pdev)
>         struct mt792x_dev *dev =3D container_of(mdev, struct mt792x_dev, =
mt76);
>=20
>         mt7921e_unregister_device(dev);
> +       set_bit(MT76_REMOVED, &mdev->phy.state);

Can it do below like mt7921_pci_suspend() to safely stop interrupt handler?
Instead of setting a flag.=20

        synchronize_irq(pdev->irq);
        tasklet_kill(&mdev->irq_tasklet);


>         devm_free_irq(&pdev->dev, pdev->irq, dev);
>         mt76_free_device(&dev->mt76);
>         pci_free_irq_vectors(pdev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> index 488326ce5ed4..3893dbe866fe 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
> @@ -12,6 +12,8 @@ irqreturn_t mt792x_irq_handler(int irq, void *dev_insta=
nce)
>  {
>         struct mt792x_dev *dev =3D dev_instance;
>=20

If PCI is removed, is it still safe to access 'dev_instance'?

> +       if (test_bit(MT76_REMOVED, &dev->mt76.phy.state))
> +               return IRQ_NONE;
>         mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
>=20
>         if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
> --
> 2.18.0
>=20


