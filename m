Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7DA128EA0
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 16:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfLVPHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 10:07:20 -0500
Received: from nbd.name ([46.4.11.11]:47412 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfLVPHT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 10:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bsjuho1caCIpPL5XbIBIBSjfd6ILFRIyZkXFBYPxV14=; b=VKwYFdv2jnIi24pq+GGJC3p8ac
        B5/kzbYyTnFu448/OEm1ymGrsXLHjogtJZs5b0ol7HqW1AQjGjGoebjP/5a4ECpMnKX+XtOS5QV41
        r5aOz+s1zjX0Mnb9i64EnmsqawI28o/k4MaYVy4MFGGWxBxGYVZNTnHbQD2shMX/8Apo=;
Received: from [81.95.5.44] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ij2pB-00030W-Ry
        for linux-wireless@vger.kernel.org; Sun, 22 Dec 2019 16:07:18 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 505A7742EAFB; Sun, 22 Dec 2019 16:07:17 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/4] mt76: mt7615: measure channel noise and report it via survey
Date:   Sun, 22 Dec 2019 16:07:14 +0100
Message-Id: <20191222150717.51379-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Read measurements every 100 ms and build a simple moving average

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 ++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 42 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 ++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 ++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  6 +++
 6 files changed, 60 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 0c71d671f29a..cd9a3882cb9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -617,6 +617,9 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	survey->channel = chan;
 	survey->filled = SURVEY_INFO_TIME | SURVEY_INFO_TIME_BUSY;
 	survey->filled |= dev->drv->survey_flags;
+	if (state->noise)
+		survey->filled |= SURVEY_INFO_NOISE_DBM;
+
 	if (chan == phy->main_chan) {
 		survey->filled |= SURVEY_INFO_IN_USE;
 
@@ -627,6 +630,7 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	survey->time_busy = div_u64(state->cc_busy, 1000);
 	survey->time_rx = div_u64(state->cc_rx, 1000);
 	survey->time = div_u64(state->cc_active, 1000);
+	survey->noise = state->noise;
 
 	spin_lock_bh(&dev->cc_lock);
 	survey->time_bss_rx = div_u64(state->cc_bss_rx, 1000);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f819d9e4ff5f..217f8c5ad201 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -328,6 +328,8 @@ struct mt76_channel_state {
 	u64 cc_rx;
 	u64 cc_bss_rx;
 	u64 cc_tx;
+
+	s8 noise;
 };
 
 struct mt76_sband {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 903b8395a446..1b52d8b79496 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1379,6 +1379,19 @@ void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable)
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+void mt7615_mac_enable_nf(struct mt7615_dev *dev, bool ext_phy)
+{
+	u32 rxtd;
+
+	if (ext_phy)
+		rxtd = MT_WF_PHY_RXTD2(10);
+	else
+		rxtd = MT_WF_PHY_RXTD(12);
+
+	mt76_set(dev, rxtd, BIT(18) | BIT(29));
+	mt76_set(dev, MT_WF_PHY_R0_PHYMUX_5(ext_phy), 0x5 << 12);
+}
+
 void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
@@ -1511,13 +1524,35 @@ mt7615_mac_scs_check(struct mt7615_phy *phy)
 		mt7615_mac_set_default_sensitivity(phy);
 }
 
+static u8
+mt7615_phy_get_nf(struct mt7615_dev *dev, int idx)
+{
+	static const u8 nf_power[] = { 92, 89, 86, 83, 80, 75, 70, 65, 60, 55, 52 };
+	u32 reg = idx ? MT_WF_PHY_RXTD2(17) : MT_WF_PHY_RXTD(20);
+	u32 val, sum = 0, n = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nf_power); i++, reg += 4) {
+		val = mt76_rr(dev, reg);
+		sum += val * nf_power[i];
+		n += val;
+	}
+
+	if (!n)
+		return 0;
+
+	return sum / n;
+}
+
 static void
 mt7615_phy_update_channel(struct mt76_phy *mphy, int idx)
 {
 	struct mt7615_dev *dev = container_of(mphy->dev, struct mt7615_dev, mt76);
+	struct mt7615_phy *phy = mphy->priv;
 	struct mt76_channel_state *state;
 	u64 busy_time, tx_time, rx_time, obss_time;
 	u32 obss_reg = idx ? MT_WF_RMAC_MIB_TIME6 : MT_WF_RMAC_MIB_TIME5;
+	int nf;
 
 	busy_time = mt76_get_field(dev, MT_MIB_SDR9(idx),
 				   MT_MIB_SDR9_BUSY_MASK);
@@ -1527,11 +1562,18 @@ mt7615_phy_update_channel(struct mt76_phy *mphy, int idx)
 				 MT_MIB_SDR37_RXTIME_MASK);
 	obss_time = mt76_get_field(dev, obss_reg, MT_MIB_OBSSTIME_MASK);
 
+	nf = mt7615_phy_get_nf(dev, idx);
+	if (!phy->noise)
+		phy->noise = nf << 4;
+	else if (nf)
+		phy->noise += nf - (phy->noise >> 4);
+
 	state = mphy->chan_state;
 	state->cc_busy += busy_time;
 	state->cc_tx += tx_time;
 	state->cc_rx += rx_time + obss_time;
 	state->cc_bss_rx += rx_time;
+	state->noise = -(phy->noise >> 4);
 }
 
 void mt7615_update_channel(struct mt76_dev *mdev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 4ffa920d4f4d..2a85859da754 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -40,11 +40,13 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	if (!running) {
 		mt7615_mcu_ctrl_pm_state(dev, 0, 0);
 		mt7615_mcu_set_mac_enable(dev, 0, true);
+		mt7615_mac_enable_nf(dev, 0);
 	}
 
 	if (phy != &dev->phy) {
 		mt7615_mcu_ctrl_pm_state(dev, 1, 0);
 		mt7615_mcu_set_mac_enable(dev, 1, true);
+		mt7615_mac_enable_nf(dev, 1);
 	}
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
@@ -238,6 +240,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mt7615_mac_cca_stats_reset(phy);
 
 	mt7615_mac_reset_counters(dev);
+	phy->noise = 0;
 
 out:
 	clear_bit(MT76_RESET, &phy->mt76->state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 48810eda1cd6..eaafae9cc279 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -94,6 +94,8 @@ struct mt7615_phy {
 	u32 rxfilter;
 	u32 omac_mask;
 
+	u16 noise;
+
 	unsigned long last_cca_adj;
 	int false_cca_ofdm, false_cca_cck;
 	s8 ofdm_sensitivity;
@@ -288,6 +290,7 @@ bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
 void mt7615_mac_reset_counters(struct mt7615_dev *dev);
 void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy);
 void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable);
+void mt7615_mac_enable_nf(struct mt7615_dev *dev, bool ext_phy);
 void mt7615_mac_sta_poll(struct mt7615_dev *dev);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 26d121646787..46db0faae93d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -104,6 +104,9 @@
 #define MT_WF_PHY_B1_PD_OFDM(v)		((v) << 16)
 #define MT_WF_PHY_B1_PD_BLK		BIT(25)
 
+#define MT_WF_PHY_RXTD_BASE		MT_WF_PHY(0x2200)
+#define MT_WF_PHY_RXTD(_n)		(MT_WF_PHY_RXTD_BASE + ((_n) << 2))
+
 #define MT_WF_PHY_B0_RXTD_CCK_PD	MT_WF_PHY(0x2310)
 #define MT_WF_PHY_B0_PD_CCK_MASK	GENMASK(8, 1)
 #define MT_WF_PHY_B0_PD_CCK(v)		((v) << 1)
@@ -112,6 +115,9 @@
 #define MT_WF_PHY_B1_PD_CCK_MASK	GENMASK(31, 24)
 #define MT_WF_PHY_B1_PD_CCK(v)		((v) << 24)
 
+#define MT_WF_PHY_RXTD2_BASE		MT_WF_PHY(0x2a00)
+#define MT_WF_PHY_RXTD2(_n)		(MT_WF_PHY_RXTD2_BASE + ((_n) << 2))
+
 #define MT_WF_CFG_BASE			0x20200
 #define MT_WF_CFG(ofs)			(MT_WF_CFG_BASE + (ofs))
 
-- 
2.24.0

