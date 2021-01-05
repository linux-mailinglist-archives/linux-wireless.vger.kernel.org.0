Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F552EA6CB
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 09:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhAEI4y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 03:56:54 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43164 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbhAEI4y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 03:56:54 -0500
X-UUID: 6bba947ef8de4536b0cfba2b6a85b2e6-20210105
X-UUID: 6bba947ef8de4536b0cfba2b6a85b2e6-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2089520916; Tue, 05 Jan 2021 16:56:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 16:56:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 16:56:06 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 3/6] mt76: mt7915: split edca update function
Date:   Tue, 5 Jan 2021 16:55:26 +0800
Message-ID: <20210105085529.14206-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210105085529.14206-1-shayne.chen@mediatek.com>
References: <20210105085529.14206-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FBCBC90558B69950083831F363CB329449BD05C88BD47257D909451921DC7F312000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Split parameter settings and mcu command update in mt7915_mcu_set_tx().
This is for reusing edca update function in testmode ipg setting.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 37 +++++++------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 24 ++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0baef70fc522..9f78e4ec14c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2977,30 +2977,21 @@ int mt7915_mcu_set_rts_thresh(struct mt7915_phy *phy, u32 val)
 				 sizeof(req), true);
 }
 
+int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *param)
+{
+	struct mt7915_mcu_tx *req = (struct mt7915_mcu_tx *)param;
+	u8 num = req->total;
+	size_t len = sizeof(*req) -
+		     (IEEE80211_NUM_ACS - num) * sizeof(struct edca);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, req,
+				 len, true);
+}
+
 int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif)
 {
-#define WMM_AIFS_SET		BIT(0)
-#define WMM_CW_MIN_SET		BIT(1)
-#define WMM_CW_MAX_SET		BIT(2)
-#define WMM_TXOP_SET		BIT(3)
-#define WMM_PARAM_SET		GENMASK(3, 0)
 #define TX_CMD_MODE		1
-	struct edca {
-		u8 queue;
-		u8 set;
-		u8 aifs;
-		u8 cw_min;
-		__le16 cw_max;
-		__le16 txop;
-	};
-	struct mt7915_mcu_tx {
-		u8 total;
-		u8 action;
-		u8 valid;
-		u8 mode;
-
-		struct edca edca[IEEE80211_NUM_ACS];
-	} __packed req = {
+	struct mt7915_mcu_tx req = {
 		.valid = true,
 		.mode = TX_CMD_MODE,
 		.total = IEEE80211_NUM_ACS,
@@ -3027,8 +3018,8 @@ int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif)
 		else
 			e->cw_max = cpu_to_le16(10);
 	}
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
-				 sizeof(req), true);
+
+	return mt7915_mcu_update_edca(dev, &req);
 }
 
 int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 30ec2ef4cc74..ee6d70339d92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -182,6 +182,30 @@ struct mt7915_mcu_phy_rx_info {
 #define MT_RA_RATE_DCM_EN		BIT(4)
 #define MT_RA_RATE_BW			GENMASK(14, 13)
 
+struct edca {
+	u8 queue;
+	u8 set;
+	u8 aifs;
+	u8 cw_min;
+	__le16 cw_max;
+	__le16 txop;
+};
+
+struct mt7915_mcu_tx {
+	u8 total;
+	u8 action;
+	u8 valid;
+	u8 mode;
+
+	struct edca edca[IEEE80211_NUM_ACS];
+} __packed;
+
+#define WMM_AIFS_SET		BIT(0)
+#define WMM_CW_MIN_SET		BIT(1)
+#define WMM_CW_MAX_SET		BIT(2)
+#define WMM_TXOP_SET		BIT(3)
+#define WMM_PARAM_SET		GENMASK(3, 0)
+
 #define MCU_PQ_ID(p, q)			(((p) << 15) | ((q) << 10))
 #define MCU_PKT_ID			0xa0
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index df7ac2cf052f..c9c9aefacd88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -327,6 +327,7 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 int mt7915_set_channel(struct mt7915_phy *phy);
 int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd);
 int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif);
+int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *req);
 int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
 			      struct ieee80211_sta *sta, u32 rate);
 int mt7915_mcu_set_eeprom(struct mt7915_dev *dev);
-- 
2.29.2

