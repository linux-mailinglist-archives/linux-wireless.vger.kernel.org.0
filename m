Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CB66828FE
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjAaJgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjAaJgp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52082F782
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:42 -0800 (PST)
X-UUID: be3891c4a14a11eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UadLTcEeSeeRKaGDm1cbt1YK38Xlcczw26w3sEeodGI=;
        b=Jz0UZxfot82w5Ylviu+LN+oEpnp9O0UiGsXGRdo5MZJ3ywPEy1nbdl5M48avEs+J6tjI2lR00Kl5ktMKMjhKfkdkL5VE2ulLMYP/k6zNrltrmfK7Bs+bMkvv5mjpS1KAtI4BAgb32Bm7IujkHtnQ5Okfj0MA1njCKK/9I7iNMMY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:f8baed65-59a4-4f78-ad75-56ed23f1611d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:162c04f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: be3891c4a14a11eda06fc9ecc4dadd91-20230131
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1431304172; Tue, 31 Jan 2023 17:36:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 31 Jan 2023 17:36:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:29 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 08/13] wifi: mt76: mt7996: add helpers for wtbl and interface limit
Date:   Tue, 31 Jan 2023 17:36:06 +0800
Message-ID: <20230131093611.30914-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230131093611.30914-1-shayne.chen@mediatek.com>
References: <20230131093611.30914-1-shayne.chen@mediatek.com>
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

Add helpers to get the maximum wtbl size and interface num based
on hw caps.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c    |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mt7996.h  | 17 +++++++++++++----
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 7a9692a66ed8..6bcf2649d8df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -256,7 +256,7 @@ static void mt7996_mac_init(struct mt7996_dev *dev)
 
 	mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
 
-	for (i = 0; i < MT7996_WTBL_SIZE; i++)
+	for (i = 0; i < mt7996_wtbl_size(dev); i++)
 		mt7996_mac_wtbl_update(dev, i,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 96ced4c039ce..bdc54ff74311 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1486,7 +1486,7 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	if (pid < MT_PACKET_ID_FIRST)
 		return;
 
-	if (wcidx >= MT7996_WTBL_SIZE)
+	if (wcidx >= mt7996_wtbl_size(dev))
 		return;
 
 	rcu_read_lock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 2031fffe6f4e..993573e0c313 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -170,7 +170,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 		phy->monitor_vif = vif;
 
 	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mvif->mt76.idx >= (MT7996_MAX_INTERFACES << dev->dbdc_support)) {
+	if (mvif->mt76.idx >= mt7996_max_interface_num(dev)) {
 		ret = -ENOSPC;
 		goto out;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 00f3beda74cc..b919a7bc606b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -11,12 +11,11 @@
 #include "../mt76_connac.h"
 #include "regs.h"
 
-#define MT7996_MAX_INTERFACES		19
+#define MT7996_MAX_INTERFACES		19	/* per-band */
 #define MT7996_MAX_WMM_SETS		4
-#define MT7996_WTBL_SIZE		544
-#define MT7996_WTBL_RESERVED		(MT7996_WTBL_SIZE - 1)
+#define MT7996_WTBL_RESERVED		(mt7996_wtbl_size(dev) - 1)
 #define MT7996_WTBL_STA			(MT7996_WTBL_RESERVED - \
-					 MT7996_MAX_INTERFACES)
+					 mt7996_max_interface_num(dev))
 
 #define MT7996_WATCHDOG_TIME		(HZ / 10)
 #define MT7996_RESET_TIMEOUT		(30 * HZ)
@@ -447,6 +446,16 @@ int mt7996_mcu_fw_dbg_ctrl(struct mt7996_dev *dev, u32 module, u8 level);
 void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb);
 void mt7996_mcu_exit(struct mt7996_dev *dev);
 
+static inline u8 mt7996_max_interface_num(struct mt7996_dev *dev)
+{
+	return MT7996_MAX_INTERFACES * (1 + dev->dbdc_support + dev->tbtc_support);
+}
+
+static inline u16 mt7996_wtbl_size(struct mt7996_dev *dev)
+{
+	return (dev->wtbl_size_group << 8) + 64;
+}
+
 void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
 				  u32 clear, u32 set);
 
-- 
2.25.1

