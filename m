Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3310DE09
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfK3Pau (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:50 -0500
Received: from nbd.name ([46.4.11.11]:56050 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xnJlZo3Eg+eSS05flctIJuc1jZZX7csHIMAINS45x24=; b=fYNY/Cj/xKs5OZF6vSJ2t5PuMs
        3HnpBcE8dbkRS07rcb+BJ47iZxsrO2i5bT5+QyW72mVvh+9VoeMH3id7kfKcIVKKT7HuamKegTdaV
        sfiHdg2ofZfbpAPEbZAe1JYH4u/7sumepKDYhBJoDZNMqJz+ept9p4N7QAjX6Cq/BwxE=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006hh-8h
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0A0E5721EBE1; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 19/29] mt76: mt7615: add multiple wiphy support for smart carrier sense
Date:   Sat, 30 Nov 2019 16:30:35 +0100
Message-Id: <20191130153045.28105-19-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use per-phy radio stats and tuning registers

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  21 ++-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 134 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   2 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  11 +-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |   9 +-
 5 files changed, 112 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index f6b75f832e6a..05a0172b32ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -74,15 +74,28 @@ static const struct file_operations fops_ampdu_stat = {
 	.release = single_release,
 };
 
+static void
+mt7615_radio_read_phy(struct mt7615_phy *phy, struct seq_file *s)
+{
+	struct mt7615_dev *dev = dev_get_drvdata(s->private);
+	bool ext_phy = phy != &dev->phy;
+
+	if (!phy)
+		return;
+
+	seq_printf(s, "Radio %d sensitivity: ofdm=%d cck=%d\n", ext_phy,
+		   phy->ofdm_sensitivity, phy->cck_sensitivity);
+	seq_printf(s, "Radio %d false CCA: ofdm=%d cck=%d\n", ext_phy,
+		   phy->false_cca_ofdm, phy->false_cca_cck);
+}
+
 static int
 mt7615_radio_read(struct seq_file *s, void *data)
 {
 	struct mt7615_dev *dev = dev_get_drvdata(s->private);
 
-	seq_printf(s, "Sensitivity: ofdm=%d cck=%d\n",
-		   dev->ofdm_sensitivity, dev->cck_sensitivity);
-	seq_printf(s, "False CCA: ofdm=%d cck=%d\n",
-		   dev->false_cca_ofdm, dev->false_cca_cck);
+	mt7615_radio_read_phy(&dev->phy, s);
+	mt7615_radio_read_phy(mt7615_ext_phy(dev), s);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 967388e88503..71b3de5c810c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1234,38 +1234,46 @@ void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 }
 
 static void
-mt7615_mac_set_default_sensitivity(struct mt7615_dev *dev)
+mt7615_mac_set_default_sensitivity(struct mt7615_phy *phy)
 {
-	mt76_rmw(dev, MT_WF_PHY_B0_MIN_PRI_PWR,
-		 MT_WF_PHY_B0_PD_OFDM_MASK,
-		 MT_WF_PHY_B0_PD_OFDM(0x13c));
-	mt76_rmw(dev, MT_WF_PHY_B1_MIN_PRI_PWR,
-		 MT_WF_PHY_B1_PD_OFDM_MASK,
-		 MT_WF_PHY_B1_PD_OFDM(0x13c));
-
-	mt76_rmw(dev, MT_WF_PHY_B0_RXTD_CCK_PD,
-		 MT_WF_PHY_B0_PD_CCK_MASK,
-		 MT_WF_PHY_B0_PD_CCK(0x92));
-	mt76_rmw(dev, MT_WF_PHY_B1_RXTD_CCK_PD,
-		 MT_WF_PHY_B1_PD_CCK_MASK,
-		 MT_WF_PHY_B1_PD_CCK(0x92));
-
-	dev->ofdm_sensitivity = -98;
-	dev->cck_sensitivity = -110;
-	dev->last_cca_adj = jiffies;
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+
+	if (!ext_phy) {
+		mt76_rmw(dev, MT_WF_PHY_B0_MIN_PRI_PWR,
+			 MT_WF_PHY_B0_PD_OFDM_MASK,
+			 MT_WF_PHY_B0_PD_OFDM(0x13c));
+		mt76_rmw(dev, MT_WF_PHY_B0_RXTD_CCK_PD,
+			 MT_WF_PHY_B0_PD_CCK_MASK,
+			 MT_WF_PHY_B0_PD_CCK(0x92));
+	} else {
+		mt76_rmw(dev, MT_WF_PHY_B1_MIN_PRI_PWR,
+			 MT_WF_PHY_B1_PD_OFDM_MASK,
+			 MT_WF_PHY_B1_PD_OFDM(0x13c));
+		mt76_rmw(dev, MT_WF_PHY_B1_RXTD_CCK_PD,
+			 MT_WF_PHY_B1_PD_CCK_MASK,
+			 MT_WF_PHY_B1_PD_CCK(0x92));
+	}
+
+	phy->ofdm_sensitivity = -98;
+	phy->cck_sensitivity = -110;
+	phy->last_cca_adj = jiffies;
 }
 
 void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable)
 {
+	struct mt7615_phy *ext_phy;
+
 	mutex_lock(&dev->mt76.mutex);
 
 	if (dev->scs_en == enable)
 		goto out;
 
 	if (enable) {
-		/* DBDC not supported */
 		mt76_set(dev, MT_WF_PHY_B0_MIN_PRI_PWR,
 			 MT_WF_PHY_B0_PD_BLK);
+		mt76_set(dev, MT_WF_PHY_B1_MIN_PRI_PWR,
+			 MT_WF_PHY_B1_PD_BLK);
 		if (is_mt7622(&dev->mt76)) {
 			mt76_set(dev, MT_MIB_M0_MISC_CR, 0x7 << 8);
 			mt76_set(dev, MT_MIB_M0_MISC_CR, 0x7);
@@ -1277,33 +1285,43 @@ void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable)
 			   MT_WF_PHY_B1_PD_BLK);
 	}
 
-	mt7615_mac_set_default_sensitivity(dev);
+	mt7615_mac_set_default_sensitivity(&dev->phy);
+	ext_phy = mt7615_ext_phy(dev);
+	if (ext_phy)
+		mt7615_mac_set_default_sensitivity(ext_phy);
+
 	dev->scs_en = enable;
 
 out:
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-void mt7615_mac_cca_stats_reset(struct mt7615_dev *dev)
+void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy)
 {
-	mt76_clear(dev, MT_WF_PHY_R0_B0_PHYMUX_5, GENMASK(22, 20));
-	mt76_set(dev, MT_WF_PHY_R0_B0_PHYMUX_5, BIT(22) | BIT(20));
+	struct mt7615_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
+	u32 reg = MT_WF_PHY_R0_PHYMUX_5(ext_phy);
+
+	mt76_clear(dev, reg, GENMASK(22, 20));
+	mt76_set(dev, reg, BIT(22) | BIT(20));
 }
 
 static void
-mt7615_mac_adjust_sensitivity(struct mt7615_dev *dev,
+mt7615_mac_adjust_sensitivity(struct mt7615_phy *phy,
 			      u32 rts_err_rate, bool ofdm)
 {
-	int false_cca = ofdm ? dev->false_cca_ofdm : dev->false_cca_cck;
+	struct mt7615_dev *dev = phy->dev;
+	int false_cca = ofdm ? phy->false_cca_ofdm : phy->false_cca_cck;
+	bool ext_phy = phy != &dev->phy;
 	u16 def_th = ofdm ? -98 : -110;
 	bool update = false;
 	s8 *sensitivity;
 	int signal;
 
-	sensitivity = ofdm ? &dev->ofdm_sensitivity : &dev->cck_sensitivity;
-	signal = mt76_get_min_avg_rssi(&dev->mt76, false);
+	sensitivity = ofdm ? &phy->ofdm_sensitivity : &phy->cck_sensitivity;
+	signal = mt76_get_min_avg_rssi(&dev->mt76, ext_phy);
 	if (!signal) {
-		mt7615_mac_set_default_sensitivity(dev);
+		mt7615_mac_set_default_sensitivity(phy);
 		return;
 	}
 
@@ -1338,29 +1356,37 @@ mt7615_mac_adjust_sensitivity(struct mt7615_dev *dev,
 		u16 val;
 
 		if (ofdm) {
-			/* DBDC not supported */
 			val = *sensitivity * 2 + 512;
-			mt76_rmw(dev, MT_WF_PHY_B0_MIN_PRI_PWR,
-				 MT_WF_PHY_B0_PD_OFDM_MASK,
-				 MT_WF_PHY_B0_PD_OFDM(val));
+			if (!ext_phy)
+				mt76_rmw(dev, MT_WF_PHY_B0_MIN_PRI_PWR,
+					 MT_WF_PHY_B0_PD_OFDM_MASK,
+					 MT_WF_PHY_B0_PD_OFDM(val));
+			else
+				mt76_rmw(dev, MT_WF_PHY_B1_MIN_PRI_PWR,
+					 MT_WF_PHY_B1_PD_OFDM_MASK,
+					 MT_WF_PHY_B1_PD_OFDM(val));
 		} else {
 			val = *sensitivity + 256;
-			mt76_rmw(dev, MT_WF_PHY_B0_RXTD_CCK_PD,
-				 MT_WF_PHY_B0_PD_CCK_MASK,
-				 MT_WF_PHY_B0_PD_CCK(val));
-			mt76_rmw(dev, MT_WF_PHY_B1_RXTD_CCK_PD,
-				 MT_WF_PHY_B1_PD_CCK_MASK,
-				 MT_WF_PHY_B1_PD_CCK(val));
+			if (!ext_phy)
+				mt76_rmw(dev, MT_WF_PHY_B0_RXTD_CCK_PD,
+					 MT_WF_PHY_B0_PD_CCK_MASK,
+					 MT_WF_PHY_B0_PD_CCK(val));
+			else
+				mt76_rmw(dev, MT_WF_PHY_B1_RXTD_CCK_PD,
+					 MT_WF_PHY_B1_PD_CCK_MASK,
+					 MT_WF_PHY_B1_PD_CCK(val));
 		}
-		dev->last_cca_adj = jiffies;
+		phy->last_cca_adj = jiffies;
 	}
 }
 
 static void
-mt7615_mac_scs_check(struct mt7615_dev *dev)
+mt7615_mac_scs_check(struct mt7615_phy *phy)
 {
+	struct mt7615_dev *dev = phy->dev;
 	u32 val, rts_cnt = 0, rts_retries_cnt = 0, rts_err_rate = 0;
 	u32 mdrdy_cck, mdrdy_ofdm, pd_cck, pd_ofdm;
+	bool ext_phy = phy != &dev->phy;
 	int i;
 
 	if (!dev->scs_en)
@@ -1369,7 +1395,7 @@ mt7615_mac_scs_check(struct mt7615_dev *dev)
 	for (i = 0; i < 4; i++) {
 		u32 data;
 
-		val = mt76_rr(dev, MT_MIB_MB_SDR0(i));
+		val = mt76_rr(dev, MT_MIB_MB_SDR(ext_phy, i));
 		data = FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
 		if (data > rts_retries_cnt) {
 			rts_cnt = FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
@@ -1377,29 +1403,29 @@ mt7615_mac_scs_check(struct mt7615_dev *dev)
 		}
 	}
 
-	val = mt76_rr(dev, MT_WF_PHY_R0_B0_PHYCTRL_STS0);
+	val = mt76_rr(dev, MT_WF_PHY_R0_PHYCTRL_STS0(ext_phy));
 	pd_cck = FIELD_GET(MT_WF_PHYCTRL_STAT_PD_CCK, val);
 	pd_ofdm = FIELD_GET(MT_WF_PHYCTRL_STAT_PD_OFDM, val);
 
-	val = mt76_rr(dev, MT_WF_PHY_R0_B0_PHYCTRL_STS5);
+	val = mt76_rr(dev, MT_WF_PHY_R0_PHYCTRL_STS5(ext_phy));
 	mdrdy_cck = FIELD_GET(MT_WF_PHYCTRL_STAT_MDRDY_CCK, val);
 	mdrdy_ofdm = FIELD_GET(MT_WF_PHYCTRL_STAT_MDRDY_OFDM, val);
 
-	dev->false_cca_ofdm = pd_ofdm - mdrdy_ofdm;
-	dev->false_cca_cck = pd_cck - mdrdy_cck;
-	mt7615_mac_cca_stats_reset(dev);
+	phy->false_cca_ofdm = pd_ofdm - mdrdy_ofdm;
+	phy->false_cca_cck = pd_cck - mdrdy_cck;
+	mt7615_mac_cca_stats_reset(phy);
 
 	if (rts_cnt + rts_retries_cnt)
 		rts_err_rate = MT_FRAC(rts_retries_cnt,
 				       rts_cnt + rts_retries_cnt);
 
 	/* cck */
-	mt7615_mac_adjust_sensitivity(dev, rts_err_rate, false);
+	mt7615_mac_adjust_sensitivity(phy, rts_err_rate, false);
 	/* ofdm */
-	mt7615_mac_adjust_sensitivity(dev, rts_err_rate, true);
+	mt7615_mac_adjust_sensitivity(phy, rts_err_rate, true);
 
-	if (time_after(jiffies, dev->last_cca_adj + 10 * HZ))
-		mt7615_mac_set_default_sensitivity(dev);
+	if (time_after(jiffies, phy->last_cca_adj + 10 * HZ))
+		mt7615_mac_set_default_sensitivity(phy);
 }
 
 static void
@@ -1440,6 +1466,7 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev;
+	struct mt7615_phy *ext_phy;
 	int i, idx;
 
 	dev = (struct mt7615_dev *)container_of(work, struct mt76_dev,
@@ -1448,7 +1475,12 @@ void mt7615_mac_work(struct work_struct *work)
 	mutex_lock(&dev->mt76.mutex);
 	mt76_update_survey(&dev->mt76);
 	if (++dev->mac_work_count == 5) {
-		mt7615_mac_scs_check(dev);
+		ext_phy = mt7615_ext_phy(dev);
+
+		mt7615_mac_scs_check(&dev->phy);
+		if (ext_phy)
+			mt7615_mac_scs_check(ext_phy);
+
 		dev->mac_work_count = 0;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 421876fc5696..9b11ca218873 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -194,7 +194,7 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 		goto out;
 
 	ret = mt7615_dfs_init_radar_detector(dev);
-	mt7615_mac_cca_stats_reset(dev);
+	mt7615_mac_cca_stats_reset(phy);
 
 	mt7615_mac_reset_counters(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 527408d587c7..88e903324f07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -84,6 +84,11 @@ struct mt7615_phy {
 	struct mt7615_dev *dev;
 
 	u32 rxfilter;
+
+	unsigned long last_cca_adj;
+	int false_cca_ofdm, false_cca_cck;
+	s8 ofdm_sensitivity;
+	s8 cck_sensitivity;
 };
 
 struct mt7615_dev {
@@ -112,11 +117,7 @@ struct mt7615_dev {
 	u32 hw_pattern;
 	int dfs_state;
 
-	int false_cca_ofdm, false_cca_cck;
-	unsigned long last_cca_adj;
 	u8 mac_work_count;
-	s8 ofdm_sensitivity;
-	s8 cck_sensitivity;
 	bool scs_en;
 
 	spinlock_t token_lock;
@@ -280,7 +281,7 @@ static inline void mt7615_irq_disable(struct mt7615_dev *dev, u32 mask)
 void mt7615_update_channel(struct mt76_dev *mdev);
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
 void mt7615_mac_reset_counters(struct mt7615_dev *dev);
-void mt7615_mac_cca_stats_reset(struct mt7615_dev *dev);
+void mt7615_mac_cca_stats_reset(struct mt7615_phy *phy);
 void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable);
 void mt7615_mac_sta_poll(struct mt7615_dev *dev);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 50da79a276f8..afb1eb08462d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -84,13 +84,13 @@
 #define MT_WF_PHY_WF2_RFCTRL0		MT_WF_PHY(0x1900)
 #define MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN	BIT(9)
 
-#define MT_WF_PHY_R0_B0_PHYMUX_5	MT_WF_PHY(0x0614)
+#define MT_WF_PHY_R0_PHYMUX_5(_phy)	MT_WF_PHY(0x0614 + ((_phy) << 9))
 
-#define MT_WF_PHY_R0_B0_PHYCTRL_STS0	MT_WF_PHY(0x020c)
+#define MT_WF_PHY_R0_PHYCTRL_STS0(_phy)	MT_WF_PHY(0x020c + ((_phy) << 9))
 #define MT_WF_PHYCTRL_STAT_PD_OFDM	GENMASK(31, 16)
 #define MT_WF_PHYCTRL_STAT_PD_CCK	GENMASK(15, 0)
 
-#define MT_WF_PHY_R0_B0_PHYCTRL_STS5	MT_WF_PHY(0x0220)
+#define MT_WF_PHY_R0_PHYCTRL_STS5(_phy)	MT_WF_PHY(0x0220 + ((_phy) << 9))
 #define MT_WF_PHYCTRL_STAT_MDRDY_OFDM	GENMASK(31, 16)
 #define MT_WF_PHYCTRL_STAT_MDRDY_CCK	GENMASK(15, 0)
 
@@ -295,7 +295,8 @@
 #define MT_WF_MIB(ofs)			(MT_WF_MIB_BASE + (ofs))
 
 #define MT_MIB_M0_MISC_CR		MT_WF_MIB(0x00c)
-#define MT_MIB_MB_SDR0(n)		MT_WF_MIB(0x100 + ((n) << 4))
+#define MT_MIB_MB_SDR(_band, n)		MT_WF_MIB(0x100 + ((_band) << 9) + \
+						  ((n) << 4))
 #define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
 #define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
 
-- 
2.24.0

