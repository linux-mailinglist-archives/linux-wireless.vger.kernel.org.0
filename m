Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 112D478102
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2019 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfG1TDl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jul 2019 15:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfG1TDk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jul 2019 15:03:40 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C892D2085A;
        Sun, 28 Jul 2019 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564340619;
        bh=c6q+UmbeYr3eKKA/2/xGLZOR5HzEHI6tkIBW21tOQlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxh9KRJebvxhiqSKZikrlZAElhLRWVqNMAZ/7lceAf1Y0RpIqNFp4AzZgx2/k6WKb
         z1x47dAs0L5pay7eNog/1ADe39JjU5adyZfvNr1nbrAOAxJj/epiTRcK5tMp38Uk+4
         pdcbh1snAMu4yCGAjL8b5rKWi7CpjvZWI9rTHd74=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 2/2] mt76: mt7615: add Smart Carrier Sense support
Date:   Sun, 28 Jul 2019 21:03:18 +0200
Message-Id: <5f29df2939f71310ac835f2cd0ee9fd1f1de8085.1564340063.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564340063.git.lorenzo@kernel.org>
References: <cover.1564340063.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce Smart Carrier Sense support in order to tune device
sensitivity according to RTS error rate and False CCA reported by the
radio

Tested-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch relies on 'mt76: mt7615: fix MT7615_WATCHDOG_TIME definition'
https://patchwork.kernel.org/patch/11049597/
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   9 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  39 ++++
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 176 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  14 ++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  36 ++++
 7 files changed, 273 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 80664e8234bd..20f83e5b9337 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -27,9 +27,12 @@
 #include <net/mac80211.h>
 #include "util.h"
 
-#define MT_TX_RING_SIZE     256
-#define MT_MCU_RING_SIZE    32
-#define MT_RX_BUF_SIZE      2048
+#define MT_TX_RING_SIZE		256
+#define MT_MCU_RING_SIZE	32
+#define MT_RX_BUF_SIZE		2048
+
+#define MT_FRAC_SCALE		12
+#define MT_FRAC(val, div)	(((val) << MT_FRAC_SCALE) / (div))
 
 struct mt76_dev;
 struct mt76_wcid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index ed605fcc99f9..4dbaf5047b37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -13,6 +13,42 @@ mt7615_radar_pattern_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_radar_pattern, NULL,
 			 mt7615_radar_pattern_set, "%lld\n");
 
+static int
+mt7615_scs_set(void *data, u64 val)
+{
+	struct mt7615_dev *dev = data;
+
+	mt7615_mac_set_scs(dev, val);
+
+	return 0;
+}
+
+static int
+mt7615_scs_get(void *data, u64 *val)
+{
+	struct mt7615_dev *dev = data;
+
+	*val = dev->scs_en;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_scs, mt7615_scs_get,
+			 mt7615_scs_set, "%lld\n");
+
+static int
+mt7615_radio_read(struct seq_file *s, void *data)
+{
+	struct mt7615_dev *dev = dev_get_drvdata(s->private);
+
+	seq_printf(s, "Sensitivity: ofdm=%d cck=%d\n",
+		   dev->ofdm_sensitivity, dev->cck_sensitivity);
+	seq_printf(s, "False CCA: ofdm=%d cck=%d\n",
+		   dev->false_cca_ofdm, dev->false_cca_cck);
+
+	return 0;
+}
+
 int mt7615_init_debugfs(struct mt7615_dev *dev)
 {
 	struct dentry *dir;
@@ -21,6 +57,9 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	if (!dir)
 		return -ENOMEM;
 
+	debugfs_create_file("scs", 0600, dir, dev, &fops_scs);
+	debugfs_create_devm_seqfile(dev->mt76.dev, "radio", dir,
+				    mt7615_radio_read);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
 	/* test pattern knobs */
 	debugfs_create_u8("pattern_len", 0600, dir,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index be144e13fe4c..1104e4c8aaa6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -50,6 +50,7 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		 MT_TMAC_CTCR0_INS_DDLMT_EN);
 
 	mt7615_mcu_set_rts_thresh(dev, 0x92b);
+	mt7615_mac_set_scs(dev, false);
 
 	mt76_rmw(dev, MT_AGG_SCR, MT_AGG_SCR_NLNAV_MID_PTEC_DIS,
 		 MT_AGG_SCR_NLNAV_MID_PTEC_DIS);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 6b3e6931b380..1ab4a189e5eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1068,6 +1068,175 @@ void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	dev_kfree_skb(skb);
 }
 
+static void
+mt7615_mac_set_default_sensitivity(struct mt7615_dev *dev)
+{
+	mt76_rmw(dev, MT_WF_PHY_B0_MIN_PRI_PWR,
+		 MT_WF_PHY_B0_PD_OFDM_MASK,
+		 MT_WF_PHY_B0_PD_OFDM(0x13c));
+	mt76_rmw(dev, MT_WF_PHY_B1_MIN_PRI_PWR,
+		 MT_WF_PHY_B1_PD_OFDM_MASK,
+		 MT_WF_PHY_B1_PD_OFDM(0x13c));
+
+	mt76_rmw(dev, MT_WF_PHY_B0_RXTD_CCK_PD,
+		 MT_WF_PHY_B0_PD_CCK_MASK,
+		 MT_WF_PHY_B0_PD_CCK(0x92));
+	mt76_rmw(dev, MT_WF_PHY_B1_RXTD_CCK_PD,
+		 MT_WF_PHY_B1_PD_CCK_MASK,
+		 MT_WF_PHY_B1_PD_CCK(0x92));
+
+	dev->ofdm_sensitivity = -98;
+	dev->cck_sensitivity = -110;
+	dev->last_cca_adj = jiffies;
+}
+
+void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable)
+{
+	mutex_lock(&dev->mt76.mutex);
+
+	if (dev->scs_en == enable)
+		goto out;
+
+	if (enable) {
+		/* DBDC not supported */
+		mt76_set(dev, MT_WF_PHY_B0_MIN_PRI_PWR,
+			 MT_WF_PHY_B0_PD_BLK);
+		if (is_mt7622(&dev->mt76)) {
+			mt76_set(dev, MT_MIB_M0_MISC_CR, 0x7 << 8);
+			mt76_set(dev, MT_MIB_M0_MISC_CR, 0x7);
+		}
+	} else {
+		mt76_clear(dev, MT_WF_PHY_B0_MIN_PRI_PWR,
+			   MT_WF_PHY_B0_PD_BLK);
+		mt76_clear(dev, MT_WF_PHY_B1_MIN_PRI_PWR,
+			   MT_WF_PHY_B1_PD_BLK);
+	}
+
+	mt7615_mac_set_default_sensitivity(dev);
+	dev->scs_en = enable;
+
+out:
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+void mt7615_mac_cca_stats_reset(struct mt7615_dev *dev)
+{
+	mt76_clear(dev, MT_WF_PHY_R0_B0_PHYMUX_5, GENMASK(22, 20));
+	mt76_set(dev, MT_WF_PHY_R0_B0_PHYMUX_5, BIT(22) | BIT(20));
+}
+
+static void
+mt7615_mac_adjust_sensitivity(struct mt7615_dev *dev,
+			      u32 rts_err_rate, bool ofdm)
+{
+	int false_cca = ofdm ? dev->false_cca_ofdm : dev->false_cca_cck;
+	u16 def_th = ofdm ? -98 : -110;
+	bool update = false;
+	s8 *sensitivity;
+	int signal;
+
+	sensitivity = ofdm ? &dev->ofdm_sensitivity : &dev->cck_sensitivity;
+	signal = mt76_get_min_avg_rssi(&dev->mt76);
+	if (!signal) {
+		mt7615_mac_set_default_sensitivity(dev);
+		return;
+	}
+
+	signal = min(signal, -72);
+	if (false_cca > 500) {
+		if (rts_err_rate > MT_FRAC(40, 100))
+			return;
+
+		/* decrease coverage */
+		if (*sensitivity == def_th && signal > -90) {
+			*sensitivity = -90;
+			update = true;
+		} else if (*sensitivity + 2 < signal) {
+			*sensitivity += 2;
+			update = true;
+		}
+	} else if ((false_cca > 0 && false_cca < 50) ||
+		   rts_err_rate > MT_FRAC(60, 100)) {
+		/* increase coverage */
+		if (*sensitivity - 2 >= def_th) {
+			*sensitivity -= 2;
+			update = true;
+		}
+	}
+
+	if (*sensitivity > signal) {
+		*sensitivity = signal;
+		update = true;
+	}
+
+	if (update) {
+		u16 val;
+
+		if (ofdm) {
+			/* DBDC not supported */
+			val = *sensitivity * 2 + 512;
+			mt76_rmw(dev, MT_WF_PHY_B0_MIN_PRI_PWR,
+				 MT_WF_PHY_B0_PD_OFDM_MASK,
+				 MT_WF_PHY_B0_PD_OFDM(val));
+		} else {
+			val = *sensitivity + 256;
+			mt76_rmw(dev, MT_WF_PHY_B0_RXTD_CCK_PD,
+				 MT_WF_PHY_B0_PD_CCK_MASK,
+				 MT_WF_PHY_B0_PD_CCK(val));
+			mt76_rmw(dev, MT_WF_PHY_B1_RXTD_CCK_PD,
+				 MT_WF_PHY_B1_PD_CCK_MASK,
+				 MT_WF_PHY_B1_PD_CCK(val));
+		}
+		dev->last_cca_adj = jiffies;
+	}
+}
+
+static void
+mt7615_mac_scs_check(struct mt7615_dev *dev)
+{
+	u32 val, rts_cnt = 0, rts_retries_cnt = 0, rts_err_rate = 0;
+	u32 mdrdy_cck, mdrdy_ofdm, pd_cck, pd_ofdm;
+	int i;
+
+	if (!dev->scs_en)
+		return;
+
+	for (i = 0; i < 4; i++) {
+		u32 data;
+
+		val = mt76_rr(dev, MT_MIB_MB_SDR0(i));
+		data = FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
+		if (data > rts_retries_cnt) {
+			rts_cnt = FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
+			rts_retries_cnt = data;
+		}
+	}
+
+	val = mt76_rr(dev, MT_WF_PHY_R0_B0_PHYCTRL_STS0);
+	pd_cck = FIELD_GET(MT_WF_PHYCTRL_STAT_PD_CCK, val);
+	pd_ofdm = FIELD_GET(MT_WF_PHYCTRL_STAT_PD_OFDM, val);
+
+	val = mt76_rr(dev, MT_WF_PHY_R0_B0_PHYCTRL_STS5);
+	mdrdy_cck = FIELD_GET(MT_WF_PHYCTRL_STAT_MDRDY_CCK, val);
+	mdrdy_ofdm = FIELD_GET(MT_WF_PHYCTRL_STAT_MDRDY_OFDM, val);
+
+	dev->false_cca_ofdm = pd_ofdm - mdrdy_ofdm;
+	dev->false_cca_cck = pd_cck - mdrdy_cck;
+	mt7615_mac_cca_stats_reset(dev);
+
+	if (rts_cnt + rts_retries_cnt)
+		rts_err_rate = MT_FRAC(rts_retries_cnt,
+				       rts_cnt + rts_retries_cnt);
+
+	/* cck */
+	mt7615_mac_adjust_sensitivity(dev, rts_err_rate, false);
+	/* ofdm */
+	mt7615_mac_adjust_sensitivity(dev, rts_err_rate, true);
+
+	if (time_after(jiffies, dev->last_cca_adj + 10 * HZ))
+		mt7615_mac_set_default_sensitivity(dev);
+}
+
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev;
@@ -1075,6 +1244,13 @@ void mt7615_mac_work(struct work_struct *work)
 	dev = (struct mt7615_dev *)container_of(work, struct mt76_dev,
 						mac_work.work);
 
+	mutex_lock(&dev->mt76.mutex);
+	if (++dev->mac_work_count == 5) {
+		mt7615_mac_scs_check(dev);
+		dev->mac_work_count = 0;
+	}
+	mutex_unlock(&dev->mt76.mutex);
+
 	mt76_tx_status_check(&dev->mt76, NULL, false);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 9138153f4686..6b881e862595 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -148,6 +148,7 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 		goto out;
 
 	ret = mt7615_dfs_init_radar_detector(dev);
+	mt7615_mac_cca_stats_reset(dev);
 
 out:
 	clear_bit(MT76_RESET, &dev->mt76.state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index a014f7b17825..c83d1d212ac9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -86,6 +86,13 @@ struct mt7615_dev {
 	u32 hw_pattern;
 	int dfs_state;
 
+	int false_cca_ofdm, false_cca_cck;
+	unsigned long last_cca_adj;
+	u8 mac_work_count;
+	s8 ofdm_sensitivity;
+	s8 cck_sensitivity;
+	bool scs_en;
+
 	spinlock_t token_lock;
 	struct idr token;
 };
@@ -191,6 +198,11 @@ int mt7615_dfs_start_radar_detector(struct mt7615_dev *dev);
 int mt7615_dfs_stop_radar_detector(struct mt7615_dev *dev);
 int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev);
 
+static inline bool is_mt7622(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7622;
+}
+
 static inline void mt7615_dfs_check_channel(struct mt7615_dev *dev)
 {
 	enum nl80211_chan_width width = dev->mt76.chandef.width;
@@ -212,6 +224,8 @@ static inline void mt7615_irq_disable(struct mt7615_dev *dev, u32 mask)
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+void mt7615_mac_cca_stats_reset(struct mt7615_dev *dev);
+void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 1dcd202746ef..12fc12edf78c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -71,6 +71,34 @@
 #define MT_WF_PHY_WF2_RFCTRL0		MT_WF_PHY(0x1900)
 #define MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN	BIT(9)
 
+#define MT_WF_PHY_R0_B0_PHYMUX_5	MT_WF_PHY(0x0614)
+
+#define MT_WF_PHY_R0_B0_PHYCTRL_STS0	MT_WF_PHY(0x020c)
+#define MT_WF_PHYCTRL_STAT_PD_OFDM	GENMASK(31, 16)
+#define MT_WF_PHYCTRL_STAT_PD_CCK	GENMASK(15, 0)
+
+#define MT_WF_PHY_R0_B0_PHYCTRL_STS5	MT_WF_PHY(0x0220)
+#define MT_WF_PHYCTRL_STAT_MDRDY_OFDM	GENMASK(31, 16)
+#define MT_WF_PHYCTRL_STAT_MDRDY_CCK	GENMASK(15, 0)
+
+#define MT_WF_PHY_B0_MIN_PRI_PWR	MT_WF_PHY(0x229c)
+#define MT_WF_PHY_B0_PD_OFDM_MASK	GENMASK(28, 20)
+#define MT_WF_PHY_B0_PD_OFDM(v)		((v) << 20)
+#define MT_WF_PHY_B0_PD_BLK		BIT(19)
+
+#define MT_WF_PHY_B1_MIN_PRI_PWR	MT_WF_PHY(0x084)
+#define MT_WF_PHY_B1_PD_OFDM_MASK	GENMASK(24, 16)
+#define MT_WF_PHY_B1_PD_OFDM(v)		((v) << 16)
+#define MT_WF_PHY_B1_PD_BLK		BIT(25)
+
+#define MT_WF_PHY_B0_RXTD_CCK_PD	MT_WF_PHY(0x2310)
+#define MT_WF_PHY_B0_PD_CCK_MASK	GENMASK(8, 1)
+#define MT_WF_PHY_B0_PD_CCK(v)		((v) << 1)
+
+#define MT_WF_PHY_B1_RXTD_CCK_PD	MT_WF_PHY(0x2314)
+#define MT_WF_PHY_B1_PD_CCK_MASK	GENMASK(31, 24)
+#define MT_WF_PHY_B1_PD_CCK(v)		((v) << 24)
+
 #define MT_WF_CFG_BASE			0x20200
 #define MT_WF_CFG(ofs)			(MT_WF_CFG_BASE + (ofs))
 
@@ -219,6 +247,14 @@
 #define MT_LPON_UTTR0			MT_LPON(0x018)
 #define MT_LPON_UTTR1			MT_LPON(0x01c)
 
+#define MT_WF_MIB_BASE			0x24800
+#define MT_WF_MIB(ofs)			(MT_WF_MIB_BASE + (ofs))
+
+#define MT_MIB_M0_MISC_CR		MT_WF_MIB(0x00c)
+#define MT_MIB_MB_SDR0(n)		MT_WF_MIB(0x100 + ((n) << 4))
+#define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
+#define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
+
 #define MT_EFUSE_BASE			0x81070000
 #define MT_EFUSE_BASE_CTRL		0x000
 #define MT_EFUSE_BASE_CTRL_EMPTY	BIT(30)
-- 
2.21.0

