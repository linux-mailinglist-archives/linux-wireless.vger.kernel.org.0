Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBB7E96E5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 08:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjKMHHb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 02:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjKMHH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 02:07:29 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E495210EC
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 23:07:25 -0800 (PST)
X-UUID: 48472c5c81f311eea33bb35ae8d461a2-20231113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/aYVd4cNtCb/nKHkSP4/wErPogTq0zYVxwbZby0zEZw=;
        b=PkgRjJrA1QnF5l0u0K0yzktKFKccVcRoKb/KxpOXytt/Sm8o/iispHhqoLxsjiQJpmPdrYr6fe/59quRfvs+Wh3P2IxYV4Jd375w7i2lBnlbSsoUKnxYpbdDmt09eZLvAgzwww7nWxIqDEeTCOszKLw42CfRebgVeOu6nI9KUMY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:0d98b6b4-ecf4-4370-8bfa-10abc473753e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:2b439572-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 48472c5c81f311eea33bb35ae8d461a2-20231113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1236073180; Mon, 13 Nov 2023 15:07:18 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 Nov 2023 15:07:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 Nov 2023 15:07:17 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/8] wifi: mt76: mt7996: introduce mt7996_band_valid()
Date:   Mon, 13 Nov 2023 15:06:12 +0800
Message-ID: <20231113070619.19964-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231113070619.19964-1-shayne.chen@mediatek.com>
References: <20231113070619.19964-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.755500-8.000000
X-TMASE-MatchedRID: wG1TUrmhlG8pNfI+R65HNUKcYi5Qw/RVJPS3/6nvMccaK6XhXABo94kL
        qQzkcVeJ8oGtzrXY+FJ+dfwnt/TnE8637+A5hpnFdOc7KAdVCk6Z2scyRQcer1fXgfL55invgo4
        eB1LnWgg6hPK3kyg7bD6zVJwjf7ytkg6GA5mI8yyM6MEoNtf0ZYiuaoNXJrK/C/+dM49Ci+x1mJ
        9aabquY3R4MLhRWS37nSWWPYspBVStGUuyWCB/KnV7tdtvoibaH5Ww7mt8hA4HCU4zl4m4yNS/h
        fkVqvWdcQ+s71fSwpZRPYccl2GMF/WfKuqzviIee5NWR5iixe19LQinZ4QefPcjNeVeWlqY+gtH
        j7OwNO2BSJy8ngwKGdgbp5DlIb4itWEOkowStLrn8Awapnm8AQd3VjiR8Q1PiU+Jg71LeCQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.755500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8B2DCB332A7B339E6A0DB61C3C02D69EBA533BFB6F655160C12A16D96C1D4EBB2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace dbdc_support and tbtc_support with mt7996_band_valid() to
support mt7996 variants with band0/band2 dual-band support.
This changes reduces ambiguity when checking supported bands on different
variants or new chipsets, as well as during the init configurations on
DMA TX/RX queues or irq masks.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/dma.c   | 14 ++++-----
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 29 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 16 +++++-----
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 16 ++++++++--
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  3 ++
 5 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index 3514f395a017..e88096f442d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -233,13 +233,13 @@ void mt7996_dma_start(struct mt7996_dev *dev, bool reset, bool wed_reset)
 	/* enable interrupts for TX/RX rings */
 	irq_mask = MT_INT_MCU_CMD | MT_INT_RX_DONE_MCU | MT_INT_TX_DONE_MCU;
 
-	if (!dev->mphy.band_idx)
+	if (mt7996_band_valid(dev, MT_BAND0))
 		irq_mask |= MT_INT_BAND0_RX_DONE;
 
-	if (dev->dbdc_support)
+	if (mt7996_band_valid(dev, MT_BAND1))
 		irq_mask |= MT_INT_BAND1_RX_DONE;
 
-	if (dev->tbtc_support)
+	if (mt7996_band_valid(dev, MT_BAND2))
 		irq_mask |= MT_INT_BAND2_RX_DONE;
 
 	if (mtk_wed_device_active(wed) && wed_reset) {
@@ -382,7 +382,7 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
-	if (dev->dbdc_support) {
+	if (mt7996_band_valid(dev, MT_BAND1)) {
 		/* rx msdu page queue for band1 */
 		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND1].flags =
 			MT_WED_RRO_Q_MSDU_PG(1) | MT_QFLAG_WED_RRO_EN;
@@ -396,7 +396,7 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
 			return ret;
 	}
 
-	if (dev->tbtc_support) {
+	if (mt7996_band_valid(dev, MT_BAND2)) {
 		/* rx msdu page queue for band2 */
 		mdev->q_rx[MT_RXQ_MSDU_PAGE_BAND2].flags =
 			MT_WED_RRO_Q_MSDU_PG(2) | MT_QFLAG_WED_RRO_EN;
@@ -516,7 +516,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
-	if (dev->tbtc_support || dev->mphy.band_idx == MT_BAND2) {
+	if (mt7996_band_valid(dev, MT_BAND2)) {
 		/* rx data queue for band2 */
 		rx_base = MT_RXQ_RING_BASE(MT_RXQ_BAND2) + hif1_ofs;
 		ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_BAND2],
@@ -570,7 +570,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 		if (ret)
 			return ret;
 
-		if (dev->tbtc_support || dev->mphy.band_idx == MT_BAND2) {
+		if (mt7996_band_valid(dev, MT_BAND2)) {
 			/* rx rro data queue for band2 */
 			dev->mt76.q_rx[MT_RXQ_RRO_BAND2].flags =
 				MT_WED_RRO_Q_DATA(1) | MT_QFLAG_WED_RRO_EN;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 1896571ad140..64fa2f28c8c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -540,7 +540,8 @@ int mt7996_txbf_init(struct mt7996_dev *dev)
 {
 	int ret;
 
-	if (dev->dbdc_support) {
+	if (mt7996_band_valid(dev, MT_BAND1) ||
+	    mt7996_band_valid(dev, MT_BAND2)) {
 		ret = mt7996_mcu_set_txbf(dev, BF_MOD_EN_CTRL);
 		if (ret)
 			return ret;
@@ -563,11 +564,7 @@ static int mt7996_register_phy(struct mt7996_dev *dev, struct mt7996_phy *phy,
 	int ret;
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 
-	if (band != MT_BAND1 && band != MT_BAND2)
-		return 0;
-
-	if ((band == MT_BAND1 && !dev->dbdc_support) ||
-	    (band == MT_BAND2 && !dev->tbtc_support))
+	if (!mt7996_band_valid(dev, band) || band == MT_BAND0)
 		return 0;
 
 	if (phy)
@@ -897,9 +894,6 @@ static int mt7996_init_hardware(struct mt7996_dev *dev)
 	INIT_LIST_HEAD(&dev->wed_rro.poll_list);
 	spin_lock_init(&dev->wed_rro.lock);
 
-	dev->dbdc_support = true;
-	dev->tbtc_support = true;
-
 	ret = mt7996_dma_init(dev);
 	if (ret)
 		return ret;
@@ -1331,8 +1325,6 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
-	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
-
 	ret = mt7996_register_phy(dev, mt7996_phy2(dev), MT_BAND1);
 	if (ret)
 		return ret;
@@ -1341,13 +1333,24 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
+	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
+
 	dev->recovery.hw_init_done = true;
 
 	ret = mt7996_init_debugfs(&dev->phy);
 	if (ret)
-		return ret;
+		goto error;
 
-	return mt7996_coredump_register(dev);
+	ret = mt7996_coredump_register(dev);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	cancel_work_sync(&dev->init_work);
+
+	return ret;
 }
 
 void mt7996_unregister_device(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ea2f08614ba3..d56e63cb11ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2964,9 +2964,10 @@ mt7996_mcu_init_rx_airtime(struct mt7996_dev *dev)
 {
 	struct uni_header hdr = {};
 	struct sk_buff *skb;
-	int len, num;
+	int len, num, i;
 
-	num = 2 + 2 * (dev->dbdc_support + dev->tbtc_support);
+	num = 2 + 2 * (mt7996_band_valid(dev, MT_BAND1) +
+		       mt7996_band_valid(dev, MT_BAND2));
 	len = sizeof(hdr) + num * sizeof(struct vow_rx_airtime);
 	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, len);
 	if (!skb)
@@ -2974,13 +2975,10 @@ mt7996_mcu_init_rx_airtime(struct mt7996_dev *dev)
 
 	skb_put_data(skb, &hdr, sizeof(hdr));
 
-	mt7996_add_rx_airtime_tlv(skb, dev->mt76.phy.band_idx);
-
-	if (dev->dbdc_support)
-		mt7996_add_rx_airtime_tlv(skb, MT_BAND1);
-
-	if (dev->tbtc_support)
-		mt7996_add_rx_airtime_tlv(skb, MT_BAND2);
+	for (i = 0; i < __MT_MAX_BAND; i++) {
+		if (mt7996_band_valid(dev, i))
+			mt7996_add_rx_airtime_tlv(skb, i);
+	}
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_WM_UNI_CMD(VOW), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 0ba00e4166d9..aefd09c7d6e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -280,8 +280,6 @@ struct mt7996_dev {
 
 	u32 hw_pattern;
 
-	bool dbdc_support:1;
-	bool tbtc_support:1;
 	bool flash_mode:1;
 	bool has_eht:1;
 	bool has_rro:1;
@@ -393,6 +391,17 @@ mt7996_phy3(struct mt7996_dev *dev)
 	return __mt7996_phy(dev, MT_BAND2);
 }
 
+static inline bool
+mt7996_band_valid(struct mt7996_dev *dev, u8 band)
+{
+	/* tri-band support */
+	if (band <= MT_BAND2 &&
+	    mt76_get_field(dev, MT_PAD_GPIO, MT_PAD_GPIO_ADIE_COMB) <= 1)
+		return true;
+
+	return band == MT_BAND0 || band == MT_BAND2;
+}
+
 extern const struct ieee80211_ops mt7996_ops;
 extern struct pci_driver mt7996_pci_driver;
 extern struct pci_driver mt7996_hif_driver;
@@ -494,7 +503,8 @@ int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id);
 
 static inline u8 mt7996_max_interface_num(struct mt7996_dev *dev)
 {
-	return MT7996_MAX_INTERFACES * (1 + dev->dbdc_support + dev->tbtc_support);
+	return MT7996_MAX_INTERFACES * (1 + mt7996_band_valid(dev, MT_BAND1) +
+					mt7996_band_valid(dev, MT_BAND2));
 }
 
 static inline u16 mt7996_wtbl_size(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 6102df912741..d8904cbc2856 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -629,6 +629,9 @@ enum base_rev {
 #define MT_TOP_MISC				MT_TOP(0xf0)
 #define MT_TOP_MISC_FW_STATE			GENMASK(2, 0)
 
+#define MT_PAD_GPIO				0x700056f0
+#define MT_PAD_GPIO_ADIE_COMB			GENMASK(16, 15)
+
 #define MT_HW_REV				0x70010204
 #define MT_HW_REV1				0x8a00
 
-- 
2.39.2

