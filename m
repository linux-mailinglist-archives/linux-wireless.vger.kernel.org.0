Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F1638481
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 08:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKYHgx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 02:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKYHgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 02:36:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E3C264BF
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 23:36:46 -0800 (PST)
X-UUID: 65eb905388454e5c96cf3dc6b9d690ce-20221125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7OfNukSIJCfSvdmDLdM4fonmtezX9J+mk1ntbpFnZ7M=;
        b=DcTOISLexRWAtT4I8V/oIPsa1AW2kvH8Ts91KtuDL7PSHtXH+WZuEH732wZBU/Typ5oen+gxxSZyxhCzqKER6zM2QWTETu3o8LhaWnHBSG0qRn6P66ONzc0ncJOZ4/uytZ61OKHmt2IKxWrO7AFMLZoJn5Jic6IKijGC3fh13GI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:d62941e8-2613-43f2-9159-d64db94a0cb7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:3a6d39dc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 65eb905388454e5c96cf3dc6b9d690ce-20221125
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 510169411; Fri, 25 Nov 2022 15:36:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 25 Nov 2022 15:36:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 25 Nov 2022 15:36:40 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921e: introduce reboot notifier support
Date:   Fri, 25 Nov 2022 15:36:00 +0800
Message-ID: <28482de35c4f1589dcf96b662a48bc558fe46e8f.1669361180.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Leon Yen <Leon.Yen@mediatek.com>

Some combinations of hosts cannnot detect mt7921e after reboot. The
interoperability issue is caused by the status mismatch between host
and chip fw. In such cases, the driver should stop chip activities
and reset chip to default state before reboot.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 6fc04ed34ec3..64156d32b62d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -306,6 +306,7 @@ struct mt7921_dev {
 	struct sk_buff_head ipv6_ns_list;
 
 	enum environment_cap country_ie_env;
+	struct notifier_block reboot_nb;
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 28342ec940f0..6d20b3ed5db1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/reboot.h>
 
 #include "mt7921.h"
 #include "mac.h"
@@ -110,6 +111,7 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 	struct mt76_connac_pm *pm = &dev->pm;
 
 	cancel_work_sync(&dev->init_work);
+	unregister_reboot_notifier(&dev->reboot_nb);
 	mt76_unregister_device(&dev->mt76);
 	mt76_for_each_q_rx(&dev->mt76, i)
 		napi_disable(&dev->mt76.napi[i]);
@@ -226,6 +228,24 @@ static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	return dev->bus_ops->rmw(mdev, addr, mask, val);
 }
 
+static int mt7921e_reboot_notifier(struct notifier_block *nb,
+				   unsigned long code, void *unused)
+{
+	struct mt7921_dev *dev = container_of(nb, struct mt7921_dev,
+					      reboot_nb);
+	struct mt76_connac_pm *pm = &dev->pm;
+
+	cancel_delayed_work_sync(&pm->ps_work);
+	cancel_work_sync(&pm->wake_work);
+
+	/* chip cleanup before reboot */
+	mt7921_mcu_drv_pmctrl(dev);
+	mt7921_dma_cleanup(dev);
+	mt7921_wfsys_reset(dev);
+
+	return NOTIFY_DONE;
+}
+
 static int mt7921_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -361,6 +381,11 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_irq;
 
+	dev->reboot_nb.notifier_call = mt7921e_reboot_notifier;
+	ret = register_reboot_notifier(&dev->reboot_nb);
+	if (ret)
+		goto err_free_irq;
+
 	return 0;
 
 err_free_irq:
-- 
2.18.0

