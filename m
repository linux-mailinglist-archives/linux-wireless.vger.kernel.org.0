Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B543C629
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbhJ0JMP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:12:15 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53722 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241178AbhJ0JMM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:12:12 -0400
X-UUID: 28a5a195c58046c4870fdcef65803508-20211027
X-UUID: 28a5a195c58046c4870fdcef65803508-20211027
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 293071886; Wed, 27 Oct 2021 17:09:42 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Oct 2021 17:09:40 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Oct
 2021 16:40:36 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 27 Oct 2021 16:40:36 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 07/11] mt76: mt7915: add txfree event v3
Date:   Wed, 27 Oct 2021 16:40:15 +0800
Message-ID: <32a32da281122974643ff10926ed1035414c1a1f.1635323366.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1635323366.git.Bo.Jiao@mediatek.com>
References: <cover.1635323366.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Update txfree v3 format.
This is an intermediate patch to add mt7916 support.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 42 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  8 ++--
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 4212dbb..d2f0537 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1282,8 +1282,10 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta = NULL;
 	LIST_HEAD(free_list);
 	struct sk_buff *tmp;
-	u8 i, count;
-	bool wake = false;
+	bool v3, wake = false;
+	u16 total, count = 0;
+	u32 txd = le32_to_cpu(free->txd);
+	u32 *cur_info;
 
 	/* clean DMA queues and unmap buffers first */
 	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
@@ -1293,14 +1295,12 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[MT_TXQ_BE], false);
 	}
 
-	/*
-	 * TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
-	 * to the time ack is received or dropped by hw (air + hw queue time).
-	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
-	 */
-	count = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
-	for (i = 0; i < count; i++) {
-		u32 msdu, info = le32_to_cpu(free->info[i]);
+	total = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
+	v3 = (FIELD_GET(MT_TX_FREE_VER, txd) == 0x4);
+
+	for (cur_info = &free->info[0]; count < total; cur_info++) {
+		u32 msdu, info = le32_to_cpu(*cur_info);
+		u8 i;
 
 		/*
 		 * 1'b1: new wcid pair.
@@ -1311,7 +1311,6 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 			struct mt76_wcid *wcid;
 			u16 idx;
 
-			count++;
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
 			wcid = rcu_dereference(dev->mt76.wcid[idx]);
 			sta = wcid_to_sta(wcid);
@@ -1326,12 +1325,25 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 			continue;
 		}
 
-		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
-		txwi = mt76_token_release(mdev, msdu, &wake);
-		if (!txwi)
+		if (v3 && (info & MT_TX_FREE_MPDU_HEADER))
 			continue;
 
-		mt7915_txwi_free(dev, txwi, sta, &free_list);
+		for (i = 0; i < 1 + v3; i++) {
+			if (v3) {
+				msdu = (info >> (15 * i)) & MT_TX_FREE_MSDU_ID_V3;
+				if (msdu == MT_TX_FREE_MSDU_ID_V3)
+					continue;
+			} else {
+				msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
+			}
+
+			txwi = mt76_token_release(mdev, msdu, &wake);
+			if (!txwi)
+				continue;
+
+			mt7915_txwi_free(dev, txwi, sta, &free_list);
+			count++;
+		}
 	}
 
 	mt7915_mac_sta_poll(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 7a2c740..4504ebc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -298,18 +298,20 @@ struct mt7915_txp {
 struct mt7915_tx_free {
 	__le16 rx_byte_cnt;
 	__le16 ctrl;
-	u8 txd_cnt;
-	u8 rsv[3];
+	__le32 txd;
 	__le32 info[];
 } __packed __aligned(4);
 
+#define MT_TX_FREE_VER			GENMASK(18, 16)
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
 #define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
 #define MT_TX_FREE_LATENCY		GENMASK(12, 0)
 /* 0: success, others: dropped */
-#define MT_TX_FREE_STATUS		GENMASK(14, 13)
 #define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
 #define MT_TX_FREE_PAIR			BIT(31)
+#define MT_TX_FREE_MPDU_HEADER		BIT(30)
+#define MT_TX_FREE_MSDU_ID_V3		GENMASK(14, 0)
+
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
-- 
2.18.0

