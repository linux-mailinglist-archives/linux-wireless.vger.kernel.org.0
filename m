Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B292FE0D3
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 16:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfKOPGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 10:06:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfKOPGA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 10:06:00 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711B620732;
        Fri, 15 Nov 2019 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573830359;
        bh=ldONIwximE4K8HSR9mwXAPode5FvRkA0i6JABWkAUs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czggBMDHIC1ggBXqqi4fVqChWcjsbc4u+Y2oQCW75lvZ9pMPRk1Mqs3g7C+J105E7
         bg3xVQslAaof5/ePlGhfJGZb3hwS7mGkX5duy8lFllQE/dYTziv/CVXLDNWnXDbx33
         YfqubvkH6oTQvIHjv+gCW0FG4Xe08V0cnLhGFtME=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 3/3] mt76: mt7615: add set_coverage class support
Date:   Fri, 15 Nov 2019 17:05:26 +0200
Message-Id: <70a7bf227313579d1d967c9a4c322e21bc673895.1573828743.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1573828743.git.lorenzo@kernel.org>
References: <cover.1573828743.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the capability to configure the acktimeout for mt7615 driver. Moreover
configure slottime according to the value provided by mac80211

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 41 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 20 +++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  4 ++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 21 ++++++++++
 5 files changed, 87 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 553bd4d988f7..54108fbaf1c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -304,6 +304,7 @@ int mt7615_register_device(struct mt7615_dev *dev)
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
 			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ;
 	dev->dfs_state = -1;
+	dev->mt76.slottime = 9;
 
 	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
 				   ARRAY_SIZE(mt7615_rates));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c77adc5d2552..809ebe70d196 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -60,6 +60,47 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 }
 
+/* XXX: DBDC support */
+void mt7615_mac_set_timing(struct mt7615_dev *dev)
+{
+	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
+		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
+	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
+		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 24);
+	int offset = 3 * dev->mt76.coverage_class;
+	u32 reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
+			 FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
+	int sifs;
+	u32 val;
+
+	if (dev->mt76.chandef.chan->band == NL80211_BAND_5GHZ)
+		sifs = 16;
+	else
+		sifs = 10;
+
+	mt76_set(dev, MT_ARB_SCR,
+		 MT_ARB_SCR_TX0_DISABLE | MT_ARB_SCR_RX0_DISABLE);
+	udelay(1);
+
+	mt76_wr(dev, MT_TMAC_CDTR, cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR, ofdm + reg_offset);
+	mt76_wr(dev, MT_TMAC_ICR0,
+		FIELD_PREP(MT_IFS_EIFS, 360) |
+		FIELD_PREP(MT_IFS_RIFS, 2) |
+		FIELD_PREP(MT_IFS_SIFS, sifs) |
+		FIELD_PREP(MT_IFS_SLOT, dev->mt76.slottime));
+
+	if (dev->mt76.slottime < 20)
+		val = MT7615_CFEND_RATE_DEFAULT;
+	else
+		val = MT7615_CFEND_RATE_11B;
+
+	mt76_rmw_field(dev, MT_AGG_ACR0, MT_AGG_ACR_CFEND_RATE, val);
+
+	mt76_clear(dev, MT_ARB_SCR,
+		   MT_ARB_SCR_TX0_DISABLE | MT_ARB_SCR_RX0_DISABLE);
+}
+
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 78bbed7a4645..61df5d1da6c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -155,6 +155,7 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 	if (ret)
 		goto out;
 
+	mt7615_mac_set_timing(dev);
 	ret = mt7615_dfs_init_radar_detector(dev);
 	mt7615_mac_cca_stats_reset(dev);
 	dev->mt76.survey_time = ktime_get_boottime();
@@ -327,6 +328,15 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC)
 		mt7615_mcu_set_bss_info(dev, vif, info->assoc);
 
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		int slottime = info->use_short_slot ? 9 : 20;
+
+		if (slottime != dev->mt76.slottime) {
+			dev->mt76.slottime = slottime;
+			mt7615_mac_set_timing(dev);
+		}
+	}
+
 	/* TODO: update beacon content
 	 * BSS_CHANGED_BEACON
 	 */
@@ -520,6 +530,15 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
+static void
+mt7615_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+{
+	struct mt7615_dev *dev = hw->priv;
+
+	dev->mt76.coverage_class = coverage_class;
+	mt7615_mac_set_timing(dev);
+}
+
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
 	.start = mt7615_start,
@@ -543,4 +562,5 @@ const struct ieee80211_ops mt7615_ops = {
 	.channel_switch_beacon = mt7615_channel_switch_beacon,
 	.get_survey = mt76_get_survey,
 	.get_antenna = mt76_get_antenna,
+	.set_coverage_class = mt7615_set_coverage_class,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index d537f68c5531..3c4a4b3e45d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -36,6 +36,9 @@
 #define MT_FRAC_SCALE		12
 #define MT_FRAC(val, div)	(((val) << MT_FRAC_SCALE) / (div))
 
+#define MT7615_CFEND_RATE_DEFAULT	0x69 /* chip default (24M) */
+#define MT7615_CFEND_RATE_11B		0x03 /* 11B LP, 11M */
+
 struct mt7615_vif;
 struct mt7615_sta;
 
@@ -246,6 +249,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
 			  struct ieee80211_key_conf *key);
+void mt7615_mac_set_timing(struct mt7615_dev *dev);
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb);
 void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data);
 void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 61a4aa9ac6e6..5ac52758d7b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -153,14 +153,35 @@
 #define MT_AGG_SCR			MT_WF_AGG(0x0fc)
 #define MT_AGG_SCR_NLNAV_MID_PTEC_DIS	BIT(3)
 
+#define MT_WF_ARB_BASE			0x20c00
+#define MT_WF_ARB(ofs)			(MT_WF_ARB_BASE + (ofs))
+
+#define MT_ARB_SCR			MT_WF_ARB(0x080)
+#define MT_ARB_SCR_TX0_DISABLE		BIT(8)
+#define MT_ARB_SCR_RX0_DISABLE		BIT(9)
+#define MT_ARB_SCR_TX1_DISABLE		BIT(10)
+#define MT_ARB_SCR_RX1_DISABLE		BIT(11)
+
 #define MT_WF_TMAC_BASE			0x21000
 #define MT_WF_TMAC(ofs)			(MT_WF_TMAC_BASE + (ofs))
 
+#define MT_TMAC_CDTR			MT_WF_TMAC(0x090)
+#define MT_TMAC_ODTR			MT_WF_TMAC(0x094)
+#define MT_TIMEOUT_VAL_PLCP		GENMASK(15, 0)
+#define MT_TIMEOUT_VAL_CCA		GENMASK(31, 16)
+
 #define MT_TMAC_TRCR0			MT_WF_TMAC(0x09c)
 #define MT_TMAC_TRCR1			MT_WF_TMAC(0x070)
 #define MT_TMAC_TRCR_CCA_SEL		GENMASK(31, 30)
 #define MT_TMAC_TRCR_SEC_CCA_SEL	GENMASK(29, 28)
 
+#define MT_TMAC_ICR0			MT_WF_TMAC(0x0a4)
+#define MT_TMAC_ICR1			MT_WF_TMAC(0x074)
+#define MT_IFS_EIFS			GENMASK(8, 0)
+#define MT_IFS_RIFS			GENMASK(14, 10)
+#define MT_IFS_SIFS			GENMASK(22, 16)
+#define MT_IFS_SLOT			GENMASK(30, 24)
+
 #define MT_TMAC_CTCR0			MT_WF_TMAC(0x0f4)
 #define MT_TMAC_CTCR0_INS_DDLMT_REFTIME	GENMASK(5, 0)
 #define MT_TMAC_CTCR0_INS_DDLMT_DENSITY	GENMASK(15, 12)
-- 
2.21.0

