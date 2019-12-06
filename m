Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D5114C28
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 06:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLFFqw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 00:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfLFFqw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 00:46:52 -0500
Received: from localhost.localdomain (unknown [37.26.146.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DFD24677;
        Fri,  6 Dec 2019 05:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575611210;
        bh=40+xgj9/p9QJJKzVKKifD9EzY7kWnw/u1MQSklXoxgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixE23Qj7cuqqPUyrpe7eYuP05XgPF93B0rMG1eC0tFKZsNIikRkeydrk3cEeck+Ef
         hFcL2GEZ3a1Xfk6HdFQdOx6SIlFsofRm/Ws6+xjKfKImqa+OttSomQjyeppLcEb+NW
         kpE5sCLw9jrIFhXntwxtJna6WmlhVIE7ZRPLvf4I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH v3 3/3] mt76: mt7615: add set_coverage class support
Date:   Fri,  6 Dec 2019 07:46:25 +0200
Message-Id: <093b38630aa5e4d91668c79ccb526e9d60924aae.1575609821.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1575609821.git.lorenzo@kernel.org>
References: <cover.1575609821.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the capability to configure acktimeout for mt7615 driver. Moreover
configure slottime according to the value provided by mac80211

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 61 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 21 +++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 +++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 21 +++++++
 5 files changed, 111 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a37562965f41..2cbacd5d6c2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -379,6 +379,7 @@ int mt7615_register_device(struct mt7615_dev *dev)
 			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 	mt7615_cap_dbdc_disable(dev);
 	dev->phy.dfs_state = -1;
+	dev->phy.slottime = 9;
 
 	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
 				   ARRAY_SIZE(mt7615_rates));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 4d528aa725fd..3689e1490ceb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -67,6 +67,67 @@ void mt7615_mac_reset_counters(struct mt7615_dev *dev)
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 }
 
+void mt7615_mac_set_timing(struct mt7615_phy *phy)
+{
+	s16 coverage_class = phy->coverage_class;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	u32 val, reg_offset, reg = ext_phy ? MT_TMAC_ICR1 : MT_TMAC_ICR0;
+	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
+		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
+	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
+		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 24);
+	int sifs, offset;
+
+	if (phy->mt76->chandef.chan->band == NL80211_BAND_5GHZ)
+		sifs = 16;
+	else
+		sifs = 10;
+
+	if (ext_phy) {
+		coverage_class = max_t(s16, dev->phy.coverage_class,
+				       coverage_class);
+		mt76_set(dev, MT_ARB_SCR,
+			 MT_ARB_SCR_TX1_DISABLE | MT_ARB_SCR_RX1_DISABLE);
+	} else {
+		struct mt7615_phy *phy_ext = mt7615_ext_phy(dev);
+
+		if (phy_ext)
+			coverage_class = max_t(s16, phy_ext->coverage_class,
+					       coverage_class);
+		mt76_set(dev, MT_ARB_SCR,
+			 MT_ARB_SCR_TX0_DISABLE | MT_ARB_SCR_RX0_DISABLE);
+	}
+	udelay(1);
+
+	offset = 3 * coverage_class;
+	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
+		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
+	mt76_wr(dev, MT_TMAC_CDTR, cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR, ofdm + reg_offset);
+
+	mt76_wr(dev, reg,
+		FIELD_PREP(MT_IFS_EIFS, 360) |
+		FIELD_PREP(MT_IFS_RIFS, 2) |
+		FIELD_PREP(MT_IFS_SIFS, sifs) |
+		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
+
+	if (phy->slottime < 20)
+		val = MT7615_CFEND_RATE_DEFAULT;
+	else
+		val = MT7615_CFEND_RATE_11B;
+
+	if (ext_phy) {
+		mt76_rmw_field(dev, MT_AGG_ACR1, MT_AGG_ACR_CFEND_RATE, val);
+		mt76_clear(dev, MT_ARB_SCR,
+			   MT_ARB_SCR_TX1_DISABLE | MT_ARB_SCR_RX1_DISABLE);
+	} else {
+		mt76_rmw_field(dev, MT_AGG_ACR0, MT_AGG_ACR_CFEND_RATE, val);
+		mt76_clear(dev, MT_ARB_SCR,
+			   MT_ARB_SCR_TX0_DISABLE | MT_ARB_SCR_RX0_DISABLE);
+	}
+}
+
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index ef14779fdbc4..0fa40b4c1399 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -230,6 +230,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 		(ext_phy * MT_CHFREQ_DBDC_IDX) |
 		phy->chfreq_seq);
 
+	mt7615_mac_set_timing(phy);
 	ret = mt7615_dfs_init_radar_detector(phy);
 	mt7615_mac_cca_stats_reset(phy);
 
@@ -406,6 +407,16 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC)
 		mt7615_mcu_set_bss_info(dev, vif, info->assoc);
 
+	if (changed & BSS_CHANGED_ERP_SLOT) {
+		int slottime = info->use_short_slot ? 9 : 20;
+		struct mt7615_phy *phy = mt7615_hw_phy(hw);
+
+		if (slottime != phy->slottime) {
+			phy->slottime = slottime;
+			mt7615_mac_set_timing(phy);
+		}
+	}
+
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		mt7615_mcu_set_bss_info(dev, vif, info->enable_beacon);
 		mt7615_mcu_wtbl_bmc(dev, vif, info->enable_beacon);
@@ -602,6 +613,15 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return ret;
 }
 
+static void
+mt7615_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+{
+	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+
+	phy->coverage_class = max_t(s16, coverage_class, 0);
+	mt7615_mac_set_timing(phy);
+}
+
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
 	.start = mt7615_start,
@@ -625,4 +645,5 @@ const struct ieee80211_ops mt7615_ops = {
 	.channel_switch_beacon = mt7615_channel_switch_beacon,
 	.get_survey = mt76_get_survey,
 	.get_antenna = mt76_get_antenna,
+	.set_coverage_class = mt7615_set_coverage_class,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 32f23f5fdd58..dc277a72d29e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -40,6 +40,9 @@
 #define MT_CHFREQ_DBDC_IDX	BIT(6)
 #define MT_CHFREQ_SEQ		GENMASK(5, 0)
 
+#define MT7615_CFEND_RATE_DEFAULT	0x69 /* chip default (24M) */
+#define MT7615_CFEND_RATE_11B		0x03 /* 11B LP, 11M */
+
 struct mt7615_vif;
 struct mt7615_sta;
 
@@ -97,6 +100,9 @@ struct mt7615_phy {
 
 	u16 chainmask;
 
+	s16 coverage_class;
+	u8 slottime;
+
 	u8 chfreq_seq;
 	u8 rdd_state;
 	int dfs_state;
@@ -283,6 +289,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
 			  struct ieee80211_key_conf *key);
+void mt7615_mac_set_timing(struct mt7615_phy *phy);
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb);
 void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data);
 void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index cece061b1108..26d121646787 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -162,14 +162,35 @@
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

