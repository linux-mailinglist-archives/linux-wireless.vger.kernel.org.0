Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C308138FF71
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhEYKml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 06:42:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45063 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229663AbhEYKml (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 06:42:41 -0400
X-UUID: fb71085d2f1244ae955715c073d19270-20210525
X-UUID: fb71085d2f1244ae955715c073d19270-20210525
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1940832024; Tue, 25 May 2021 18:34:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 18:34:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 18:34:18 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: use mt7915_mcu_get_txpower_sku() to get per-rate txpower
Date:   Tue, 25 May 2021 18:34:09 +0800
Message-ID: <20210525103409.1537-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get per-rate txpower with mcu command. This is the preparation of
co-driver for the next chipset, which has different tmac power registers
but can share this same command.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
v2: - revise commit message
    - concise some local variables
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 49 ++++---------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 34 ++++++++++++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 ++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  5 --
 4 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6a8ddee..95a6957 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -307,54 +307,23 @@ mt7915_puts_rate_txpower(struct seq_file *s, struct mt7915_phy *phy)
 		"RU26", "RU52", "RU106", "RU242/SU20",
 		"RU484/SU40", "RU996/SU80", "RU2x996/SU160"
 	};
-	struct mt7915_dev *dev = dev_get_drvdata(s->private);
-	bool ext_phy = phy != &dev->phy;
-	u32 reg_base;
-	int i, idx = 0;
+	s8 txpower[MT7915_SKU_RATE_NUM], *buf;
+	int i;
 
 	if (!phy)
 		return;
 
-	reg_base = MT_TMAC_FP0R0(ext_phy);
-	seq_printf(s, "\nBand %d\n", ext_phy);
+	seq_printf(s, "\nBand %d\n", phy != &phy->dev->phy);
 
-	for (i = 0; i < ARRAY_SIZE(mt7915_sku_group_len); i++) {
-		u8 cnt, mcs_num = mt7915_sku_group_len[i];
-		s8 txpower[12];
-		int j;
+	mt7915_mcu_get_txpower_sku(phy, txpower, sizeof(txpower));
+	for (i = 0, buf = txpower; i < ARRAY_SIZE(mt7915_sku_group_len); i++) {
+		u8 mcs_num = mt7915_sku_group_len[i];
 
-		if (i == SKU_HT_BW20 || i == SKU_HT_BW40) {
-			mcs_num = 8;
-		} else if (i >= SKU_VHT_BW20 && i <= SKU_VHT_BW160) {
+		if (i >= SKU_VHT_BW20 && i <= SKU_VHT_BW160)
 			mcs_num = 10;
-		} else if (i == SKU_HE_RU26) {
-			reg_base = MT_TMAC_FP0R18(ext_phy);
-			idx = 0;
-		}
-
-		for (j = 0, cnt = 0; j < DIV_ROUND_UP(mcs_num, 4); j++) {
-			u32 val;
-
-			if (i == SKU_VHT_BW160 && idx == 60) {
-				reg_base = MT_TMAC_FP0R15(ext_phy);
-				idx = 0;
-			}
-
-			val = mt76_rr(dev, reg_base + (idx / 4) * 4);
-
-			if (idx && idx % 4)
-				val >>= (idx % 4) * 8;
-
-			while (val > 0 && cnt < mcs_num) {
-				s8 pwr = FIELD_GET(MT_TMAC_FP_MASK, val);
-
-				txpower[cnt++] = pwr;
-				val >>= 8;
-				idx++;
-			}
-		}
 
-		mt76_seq_puts_array(s, sku_group_name[i], txpower, mcs_num);
+		mt76_seq_puts_array(s, sku_group_name[i], buf, mcs_num);
+		buf += mt7915_sku_group_len[i];
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index dcf2d4d..f4cadfc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3514,7 +3514,6 @@ int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx)
 
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 {
-#define MT7915_SKU_RATE_NUM		161
 	struct mt7915_dev *dev = phy->dev;
 	struct mt76_phy *mphy = phy->mt76;
 	struct ieee80211_hw *hw = mphy->hw;
@@ -3564,6 +3563,39 @@ int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 				 sizeof(req), true);
 }
 
+int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len)
+{
+#define RATE_POWER_INFO	2
+	struct mt7915_dev *dev = phy->dev;
+	struct {
+		u8 format_id;
+		u8 category;
+		u8 band;
+		u8 _rsv;
+	} __packed req = {
+		.format_id = 7,
+		.category = RATE_POWER_INFO,
+		.band = phy != &dev->phy,
+	};
+	s8 res[MT7915_SKU_RATE_NUM][2];
+	struct sk_buff *skb;
+	int ret, i;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+					MCU_EXT_CMD(TX_POWER_FEATURE_CTRL),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	memcpy(res, skb->data + 4, sizeof(res));
+	for (i = 0; i < len; i++)
+		txpower[i] = res[i][req.band];
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
 int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
 			      u8 en)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c4bf8ed..1f7e57d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -38,6 +38,8 @@
 #define MT7915_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
 #define MT7915_2G_RATE_DEFAULT		0x0	/* CCK 1M */
 
+#define MT7915_SKU_RATE_NUM		161
+
 struct mt7915_vif;
 struct mt7915_sta;
 struct mt7915_dfs_pulse;
@@ -343,6 +345,7 @@ int mt7915_mcu_set_rts_thresh(struct mt7915_phy *phy, u32 val);
 int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter);
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
+int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len);
 int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev);
 int mt7915_mcu_set_txbf_module(struct mt7915_dev *dev);
 int mt7915_mcu_set_txbf_sounding(struct mt7915_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 48e4b22..ee525e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -82,11 +82,6 @@
 #define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
 #define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
 
-#define MT_TMAC_FP0R0(_band)		MT_WF_TMAC(_band, 0x020)
-#define MT_TMAC_FP0R15(_band)		MT_WF_TMAC(_band, 0x080)
-#define MT_TMAC_FP0R18(_band)		MT_WF_TMAC(_band, 0x270)
-#define MT_TMAC_FP_MASK			GENMASK(7, 0)
-
 #define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
 
 #define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
-- 
2.18.0

