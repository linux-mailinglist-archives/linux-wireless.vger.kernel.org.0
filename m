Return-Path: <linux-wireless+bounces-1872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FBC82CAA0
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 10:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5754E284C0F
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D5A38;
	Sat, 13 Jan 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u3Y3RCuK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63D07E8
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 38a018b6b1f211ee9e680517dc993faa-20240113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jUpRoMwXiMcq+F1SDXQGYUVejYi/UalmN4jhxJyXTww=;
	b=u3Y3RCuKfj+geE0kVp42OZ3QJ0/vbcSK+UW+zz8V4T4b39coQDqrhBBPDq9foYo89eSRim39rDL9uNbLSyiIcBJDo66ERO57e6UIYRq8THRtn8Gc4f5j08L5luPYqqTGy8SkguoWMBlkqFdOdbc0r9vCqKqMLWQ19nYojNfB0B8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f1ba8b34-dd5a-43e7-8d88-60d4abd0e7f4,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:98e9348e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 38a018b6b1f211ee9e680517dc993faa-20240113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1456607307; Sat, 13 Jan 2024 17:00:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 13 Jan 2024 17:00:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 13 Jan 2024 17:00:37 +0800
From: Deren Wu <deren.wu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Soul Huang <Soul.Huang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Leon Yen
	<Leon.Yen@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Quan Zhou
	<quan.zhou@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Deren Wu
	<deren.wu@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7921e: fix use-after-free in free_irq()
Date: Sat, 13 Jan 2024 17:00:22 +0800
Message-ID: <572d6af305a09fc8bdd96a8ee57399039803a2bb.1705135817.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From commit a304e1b82808 ("[PATCH] Debug shared irqs"), there is a test
to make sure the shared irq handler should be able to handle the unexpected
event after deregistration. For this case, let's apply MT76_REMOVED flag to
indicate the device was removed and do not run into the resource access
anymore.

BUG: KASAN: use-after-free in mt7921_irq_handler+0xd8/0x100 [mt7921e]
Read of size 8 at addr ffff88824a7d3b78 by task rmmod/11115
CPU: 28 PID: 11115 Comm: rmmod Tainted: G        W    L    5.17.0 #10
Hardware name: Micro-Star International Co., Ltd. MS-7D73/MPG B650I
EDGE WIFI (MS-7D73), BIOS 1.81 01/05/2024
Call Trace:
 <TASK>
 dump_stack_lvl+0x6f/0xa0
 print_address_description.constprop.0+0x1f/0x190
 ? mt7921_irq_handler+0xd8/0x100 [mt7921e]
 ? mt7921_irq_handler+0xd8/0x100 [mt7921e]
 kasan_report.cold+0x7f/0x11b
 ? mt7921_irq_handler+0xd8/0x100 [mt7921e]
 mt7921_irq_handler+0xd8/0x100 [mt7921e]
 free_irq+0x627/0xaa0
 devm_free_irq+0x94/0xd0
 ? devm_request_any_context_irq+0x160/0x160
 ? kobject_put+0x18d/0x4a0
 mt7921_pci_remove+0x153/0x190 [mt7921e]
 pci_device_remove+0xa2/0x1d0
 __device_release_driver+0x346/0x6e0
 driver_detach+0x1ef/0x2c0
 bus_remove_driver+0xe7/0x2d0
 ? __check_object_size+0x57/0x310
 pci_unregister_driver+0x26/0x250
 __do_sys_delete_module+0x307/0x510
 ? free_module+0x6a0/0x6a0
 ? fpregs_assert_state_consistent+0x4b/0xb0
 ? rcu_read_lock_sched_held+0x10/0x70
 ? syscall_enter_from_user_mode+0x20/0x70
 ? trace_hardirqs_on+0x1c/0x130
 do_syscall_64+0x5c/0x80
 ? trace_hardirqs_on_prepare+0x72/0x160
 ? do_syscall_64+0x68/0x80
 ? trace_hardirqs_on_prepare+0x72/0x160
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CABXGCsOdvVwdLmSsC8TZ1jF0UOg_F_W3wqLECWX620PUkvNk=A@mail.gmail.com/
Fixes: 9270270d6219 ("wifi: mt76: mt7921: fix PCI DMA hang after reboot")
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 57903c6e4f11..2f04d6658b6b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -387,6 +387,7 @@ static void mt7921_pci_remove(struct pci_dev *pdev)
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 
 	mt7921e_unregister_device(dev);
+	set_bit(MT76_REMOVED, &mdev->phy.state);
 	devm_free_irq(&pdev->dev, pdev->irq, dev);
 	mt76_free_device(&dev->mt76);
 	pci_free_irq_vectors(pdev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 488326ce5ed4..3893dbe866fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -12,6 +12,8 @@ irqreturn_t mt792x_irq_handler(int irq, void *dev_instance)
 {
 	struct mt792x_dev *dev = dev_instance;
 
+	if (test_bit(MT76_REMOVED, &dev->mt76.phy.state))
+		return IRQ_NONE;
 	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
 
 	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
-- 
2.18.0


