Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2DD740A06
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjF1H4Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:56:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52954 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230243AbjF1HyQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:16 -0400
X-UUID: a92b0b3e158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eT+h0gobxZAxWtZtit0yrYXxG3O0OM/ESXkwv7nAg/U=;
        b=S7PHhqVhCNyXzvaRcN6U/2QSF9vq6CdII24HwmrBNW8Lu+kXy6EiR2LqFF+vXrW36AVsSohJkelGZuf1No4VcOgPTfKe1HtqekWSdKoYtgeKSb60sfpdZtr/NZBP9kRz4+8SltEXbMzt2+yxVhIWlbzTC2kopgF4trPP6noTB3A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:9f82cc1f-ece3-4cc6-9855-9abcdaae7f7d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:62899b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a92b0b3e158211eeb20a276fd37b9834-20230628
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1059428968; Wed, 28 Jun 2023 15:09:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:09:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:09:00 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 11/11] wifi: mt76: mt7921: move mt7921u_disconnect mt792x-lib
Date:   Wed, 28 Jun 2023 15:07:24 +0800
Message-ID: <4c0ef45ef191600edde809f2233d25c6b5dbf15d.1687920269.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687920269.git.deren.wu@mediatek.com>
References: <cover.1687920269.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

mt7921u_disconnect routine is shared between mt7921 and mt7925 so move
it in mt792x-usb module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 19 +----------------
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 +-
 .../net/wireless/mediatek/mt76/mt792x_usb.c   | 21 +++++++++++++++++--
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index c3981bc893ac..59cd3d98bf90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -254,23 +254,6 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 	return ret;
 }
 
-static void mt7921u_disconnect(struct usb_interface *usb_intf)
-{
-	struct mt792x_dev *dev = usb_get_intfdata(usb_intf);
-
-	cancel_work_sync(&dev->init_work);
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
-		return;
-
-	mt76_unregister_device(&dev->mt76);
-	mt792xu_cleanup(dev);
-
-	usb_set_intfdata(usb_intf, NULL);
-	usb_put_dev(interface_to_usbdev(usb_intf));
-
-	mt76_free_device(&dev->mt76);
-}
-
 #ifdef CONFIG_PM
 static int mt7921u_suspend(struct usb_interface *intf, pm_message_t state)
 {
@@ -350,7 +333,7 @@ static struct usb_driver mt7921u_driver = {
 	.name		= KBUILD_MODNAME,
 	.id_table	= mt7921u_device_table,
 	.probe		= mt7921u_probe,
-	.disconnect	= mt7921u_disconnect,
+	.disconnect	= mt792xu_disconnect,
 #ifdef CONFIG_PM
 	.suspend	= mt7921u_suspend,
 	.resume		= mt7921u_resume,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index d80f80bc7656..5d5ab8630041 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -336,7 +336,7 @@ u32 mt792xu_rr(struct mt76_dev *dev, u32 addr);
 void mt792xu_wr(struct mt76_dev *dev, u32 addr, u32 val);
 u32 mt792xu_rmw(struct mt76_dev *dev, u32 addr, u32 mask, u32 val);
 void mt792xu_copy(struct mt76_dev *dev, u32 offset, const void *data, int len);
-void mt792xu_cleanup(struct mt792x_dev *dev);
+void mt792xu_disconnect(struct usb_interface *usb_intf);
 
 int __mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 97480c9c9974..20e7f9c7c88c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -91,14 +91,13 @@ int mt792xu_mcu_power_on(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt792xu_mcu_power_on);
 
-void mt792xu_cleanup(struct mt792x_dev *dev)
+static void mt792xu_cleanup(struct mt792x_dev *dev)
 {
 	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 	mt792xu_wfsys_reset(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 	mt76u_queues_deinit(&dev->mt76);
 }
-EXPORT_SYMBOL_GPL(mt792xu_cleanup);
 
 static u32 mt792xu_uhw_rr(struct mt76_dev *dev, u32 addr)
 {
@@ -288,5 +287,23 @@ int mt792xu_init_reset(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt792xu_init_reset);
 
+void mt792xu_disconnect(struct usb_interface *usb_intf)
+{
+	struct mt792x_dev *dev = usb_get_intfdata(usb_intf);
+
+	cancel_work_sync(&dev->init_work);
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
+		return;
+
+	mt76_unregister_device(&dev->mt76);
+	mt792xu_cleanup(dev);
+
+	usb_set_intfdata(usb_intf, NULL);
+	usb_put_dev(interface_to_usbdev(usb_intf));
+
+	mt76_free_device(&dev->mt76);
+}
+EXPORT_SYMBOL_GPL(mt792xu_disconnect);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
-- 
2.18.0

