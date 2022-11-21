Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF09663181B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 02:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKUBPA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 20:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUBPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 20:15:00 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FFC2AC76
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 17:14:58 -0800 (PST)
X-UUID: 46651e80d60b45588b32667e783c2396-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PeqfZxLKUnLk1pziaV+m7BIw04gGZPPXIPIo9XSuRwo=;
        b=j/61jGu9HbrpVtVJI9mkbDGcnpLPDq4FVmgkz6Yh8iSck3DAt9/WzZron+FJxic3bg8rlFlG0LhJYa1fcgsGnucKAvPHsUiObeWPwdwuzZ8COTtME6Cqr36LynpEHaKfbdTshDEfWPAIUOZN++7grKv5mWSV/VBFfo8kVY3Ti88=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:c80c14db-f5f3-4c22-8080-67a8eb581ca3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:d72ecaf8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 46651e80d60b45588b32667e783c2396-20221121
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 941686995; Mon, 21 Nov 2022 09:14:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 09:14:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 09:14:52 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/3] wifi: mt76: mt7915: add basedband Txpower info into debugfs
Date:   Mon, 21 Nov 2022 09:14:49 +0800
Message-ID: <939ea87376523dbce05384f412cbbda4bbcb1998.1668992110.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This helps user to debug Txpower propagation path easily.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2: fix phy1 offset
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c    | 18 +++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/regs.h   |  4 ++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 096cb8a4db3d..de06bb6b971b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -967,11 +967,17 @@ mt7915_rate_txpower_show(struct seq_file *file, void *data)
 		"RU484/SU40", "RU996/SU80", "RU2x996/SU160"
 	};
 	struct mt7915_phy *phy = file->private;
+	struct mt7915_dev *dev = phy->dev;
 	s8 txpower[MT7915_SKU_RATE_NUM], *buf;
-	int i;
+	u32 reg;
+	int i, ret;
+
+	ret = mt7915_mcu_get_txpower_sku(phy, txpower, sizeof(txpower));
+	if (ret)
+		return ret;
+
+	seq_printf(file, "\nPhy %d\n", phy != &dev->phy);
 
-	seq_printf(file, "\nBand %d\n", phy != &phy->dev->phy);
-	mt7915_mcu_get_txpower_sku(phy, txpower, sizeof(txpower));
 	for (i = 0, buf = txpower; i < ARRAY_SIZE(mt7915_sku_group_len); i++) {
 		u8 mcs_num = mt7915_sku_group_len[i];
 
@@ -982,6 +988,12 @@ mt7915_rate_txpower_show(struct seq_file *file, void *data)
 		buf += mt7915_sku_group_len[i];
 	}
 
+	reg = is_mt7915(&dev->mt76) ? MT_WF_PHY_TPC_CTRL_STAT(phy->band_idx) :
+	      MT_WF_PHY_TPC_CTRL_STAT_MT7916(phy->band_idx);
+	/* Txpower propagation path: TMAC -> TXV -> BBP */
+	seq_printf(file, "\nBaseband transmit power %ld\n",
+		   mt76_get_field(dev, reg, MT_WF_PHY_TPC_POWER));
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 0c61f1256f3b..5f8e728f048b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -1179,6 +1179,10 @@ enum offs_rev {
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR		BIT(29)
 
+#define MT_WF_PHY_TPC_CTRL_STAT(_phy)		MT_WF_PHY(0xe7a0 + ((_phy) << 16))
+#define MT_WF_PHY_TPC_CTRL_STAT_MT7916(_phy)	MT_WF_PHY(0xe7a0 + ((_phy) << 20))
+#define MT_WF_PHY_TPC_POWER			GENMASK(15, 8)
+
 #define MT_MCU_WM_CIRQ_BASE			0x89010000
 #define MT_MCU_WM_CIRQ(ofs)			(MT_MCU_WM_CIRQ_BASE + (ofs))
 #define MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR	MT_MCU_WM_CIRQ(0x80)
-- 
2.36.1

