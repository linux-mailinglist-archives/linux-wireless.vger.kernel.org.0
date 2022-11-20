Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE46631611
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 20:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKTTvr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 14:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKTTvp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 14:51:45 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2ED2ED43
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 11:51:41 -0800 (PST)
X-UUID: 31a48c5c4e3341bb85737d7fe5f737c8-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0OVfeHC4EQB12+w5a2/NZH9YZPufCTe/TK7F6rvOOMw=;
        b=KnxT/3vqiJ1fA5+qKWbsvJnqavZCSCue9Gj7995xfMlU3MNNyc407NrSu8Zfybv/J/eUMetvCprE47fRL2Cum1eKCibEBRWUBi2LB+G9z1OsLgU/X5XX45n+x6dBgyEfrA6fuTvcVxZSlEV/fLYXMKYzeQq+Ad4EXOi+TkTcITw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:2730e156-6f24-44a6-ba25-c9ac3c930eeb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:2730e156-6f24-44a6-ba25-c9ac3c930eeb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:7f134a2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221121035133A9G5QKKU,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 31a48c5c4e3341bb85737d7fe5f737c8-20221121
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1549334039; Mon, 21 Nov 2022 03:51:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 03:51:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 03:51:31 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/3] wifi: mt76: mt7915: add basedband Txpower info into debugfs
Date:   Mon, 21 Nov 2022 03:51:28 +0800
Message-ID: <c73db8d9bb03efe8cb403434aeedad25d958e258.1668973479.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This helps user to debug Txpower propagation path easily.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c  | 16 +++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h |  3 +++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 096cb8a4db3d..1244f5c4172b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -967,11 +967,16 @@ mt7915_rate_txpower_show(struct seq_file *file, void *data)
 		"RU484/SU40", "RU996/SU80", "RU2x996/SU160"
 	};
 	struct mt7915_phy *phy = file->private;
+	struct mt7915_dev *dev = phy->dev;
 	s8 txpower[MT7915_SKU_RATE_NUM], *buf;
-	int i;
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
 
@@ -982,6 +987,11 @@ mt7915_rate_txpower_show(struct seq_file *file, void *data)
 		buf += mt7915_sku_group_len[i];
 	}
 
+	/* Txpower propagation path: TMAC -> TXV -> BBP */
+	seq_printf(file, "\nBaseband transmit power %ld\n",
+		   mt76_get_field(dev, MT_WF_PHY_TPC_CTRL_STAT(phy->band_idx),
+				  MT_WF_PHY_TPC_POWER));
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 0c61f1256f3b..00fc31cb7e82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -1179,6 +1179,9 @@ enum offs_rev {
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY	BIT(18)
 #define MT_WF_PHY_RXTD12_IRPI_SW_CLR		BIT(29)
 
+#define MT_WF_PHY_TPC_CTRL_STAT(_phy)	MT_WF_PHY(0xe7a0 + ((_phy) << 16))
+#define MT_WF_PHY_TPC_POWER		GENMASK(15, 8)
+
 #define MT_MCU_WM_CIRQ_BASE			0x89010000
 #define MT_MCU_WM_CIRQ(ofs)			(MT_MCU_WM_CIRQ_BASE + (ofs))
 #define MT_MCU_WM_CIRQ_IRQ_MASK_CLR_ADDR	MT_MCU_WM_CIRQ(0x80)
-- 
2.36.1

