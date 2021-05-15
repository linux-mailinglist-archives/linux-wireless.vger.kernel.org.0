Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D623815B2
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 06:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhEOESx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 00:18:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43086 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229441AbhEOESx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 00:18:53 -0400
X-UUID: 78f1531a17784f6ca4c35f6766356356-20210515
X-UUID: 78f1531a17784f6ca4c35f6766356356-20210515
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 841513972; Sat, 15 May 2021 12:17:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 15 May 2021 12:17:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 15 May 2021 12:17:31 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: use mt7915_mcu_get_mib_info() to get survey data
Date:   Sat, 15 May 2021 12:17:29 +0800
Message-ID: <ef62ca7747c88194539c9e567acb53c9c9cd729f.1621052118.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware functions (SCS, MU ...) also require read-clear phy counters,
hence firmware prepares a global task to read shared fields out to a
shared pool to avoid concurrency. Switch to event format accordingly.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 -
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 38 +++------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 46 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 14 ++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 20 +-------
 6 files changed, 69 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index d8cc65231146..0887e165d5e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -201,7 +201,6 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_MCAST, MT_MDP_TO_HIF);
 	mt76_rmw(dev, MT_MDP_BNRCFR1(band), mask, set);
 
-	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
 
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 45f9b16b7d21..92fac8383976 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1316,14 +1316,10 @@ void mt7915_mac_reset_counters(struct mt7915_phy *phy)
 	memset(&dev->mt76.aggr_stats[i], 0, sizeof(dev->mt76.aggr_stats) / 2);
 
 	/* reset airtime counters */
-	mt76_rr(dev, MT_MIB_SDR9(ext_phy));
-	mt76_rr(dev, MT_MIB_SDR36(ext_phy));
-	mt76_rr(dev, MT_MIB_SDR37(ext_phy));
-
-	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(ext_phy),
-		 MT_WF_RMAC_MIB_RXTIME_CLR);
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(ext_phy),
 		 MT_WF_RMAC_MIB_RXTIME_CLR);
+
+	mt7915_mcu_get_chan_mib_info(phy, true);
 }
 
 void mt7915_mac_set_timing(struct mt7915_phy *phy)
@@ -1420,20 +1416,11 @@ mt7915_phy_get_nf(struct mt7915_phy *phy, int idx)
 static void
 mt7915_phy_update_channel(struct mt76_phy *mphy, int idx)
 {
-	struct mt7915_dev *dev = container_of(mphy->dev, struct mt7915_dev, mt76);
 	struct mt7915_phy *phy = (struct mt7915_phy *)mphy->priv;
-	struct mt76_channel_state *state;
-	u64 busy_time, tx_time, rx_time, obss_time;
+	struct mt76_channel_state *state = mphy->chan_state;
 	int nf;
 
-	busy_time = mt76_get_field(dev, MT_MIB_SDR9(idx),
-				   MT_MIB_SDR9_BUSY_MASK);
-	tx_time = mt76_get_field(dev, MT_MIB_SDR36(idx),
-				 MT_MIB_SDR36_TXTIME_MASK);
-	rx_time = mt76_get_field(dev, MT_MIB_SDR37(idx),
-				 MT_MIB_SDR37_RXTIME_MASK);
-	obss_time = mt76_get_field(dev, MT_WF_RMAC_MIB_AIRTIME14(idx),
-				   MT_MIB_OBSSTIME_MASK);
+	mt7915_mcu_get_chan_mib_info(phy, false);
 
 	nf = mt7915_phy_get_nf(phy, idx);
 	if (!phy->noise)
@@ -1441,27 +1428,14 @@ mt7915_phy_update_channel(struct mt76_phy *mphy, int idx)
 	else if (nf)
 		phy->noise += nf - (phy->noise >> 4);
 
-	state = mphy->chan_state;
-	state->cc_busy += busy_time;
-	state->cc_tx += tx_time;
-	state->cc_rx += rx_time + obss_time;
-	state->cc_bss_rx += rx_time;
 	state->noise = -(phy->noise >> 4);
 }
 
 void mt7915_update_channel(struct mt76_dev *mdev)
 {
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-
 	mt7915_phy_update_channel(&mdev->phy, 0);
 	if (mdev->phy2)
 		mt7915_phy_update_channel(mdev->phy2, 1);
-
-	/* reset obss airtime */
-	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
-	if (mdev->phy2)
-		mt76_set(dev, MT_WF_RMAC_MIB_TIME0(1),
-			 MT_WF_RMAC_MIB_RXTIME_CLR);
 }
 
 static bool
@@ -1671,7 +1645,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 }
 
 static void
-mt7915_mac_update_mib_stats(struct mt7915_phy *phy)
+mt7915_mac_update_stats(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
@@ -1780,7 +1754,7 @@ void mt7915_mac_work(struct work_struct *work)
 	if (++mphy->mac_work_count == 5) {
 		mphy->mac_work_count = 0;
 
-		mt7915_mac_update_mib_stats(phy);
+		mt7915_mac_update_stats(phy);
 	}
 
 	if (++phy->sta_work_count == 10) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b3f14ff67c5a..85e399550ee4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3469,6 +3469,52 @@ int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy)
 	return 0;
 }
 
+int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch)
+{
+	/* strict order */
+	static const enum mt7915_chan_mib_offs offs[] = {
+		MIB_BUSY_TIME, MIB_TX_TIME, MIB_RX_TIME, MIB_OBSS_AIRTIME
+	};
+	struct mt76_channel_state *state = phy->mt76->chan_state;
+	struct mt76_channel_state *state_ts = &phy->state_ts;
+	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_mcu_mib *res, req[4];
+	struct sk_buff *skb;
+	int i, ret;
+
+	for (i = 0; i < 4; i++) {
+		req[i].band = cpu_to_le32(phy != &dev->phy);
+		req[i].offs = cpu_to_le32(offs[i]);
+	}
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(GET_MIB_INFO),
+					req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7915_mcu_mib *)(skb->data + 20);
+
+	if (chan_switch)
+		goto out;
+
+#define __res_u64(s) le64_to_cpu(res[s].data)
+	state->cc_busy += __res_u64(0) - state_ts->cc_busy;
+	state->cc_tx += __res_u64(1) - state_ts->cc_tx;
+	state->cc_bss_rx += __res_u64(2) - state_ts->cc_bss_rx;
+	state->cc_rx += __res_u64(2) + __res_u64(3) - state_ts->cc_rx;
+
+out:
+	state_ts->cc_busy = __res_u64(0);
+	state_ts->cc_tx = __res_u64(1);
+	state_ts->cc_bss_rx = __res_u64(2);
+	state_ts->cc_rx = __res_u64(2) + __res_u64(3);
+#undef __res_u64
+
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
 int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 42582a66e42d..04ae9ce3315c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -193,6 +193,19 @@ struct mt7915_mcu_phy_rx_info {
 #define MT_RA_RATE_DCM_EN		BIT(4)
 #define MT_RA_RATE_BW			GENMASK(14, 13)
 
+struct mt7915_mcu_mib {
+	__le32 band;
+	__le32 offs;
+	__le64 data;
+} __packed;
+
+enum mt7915_chan_mib_offs {
+	MIB_BUSY_TIME = 14,
+	MIB_TX_TIME = 81,
+	MIB_RX_TIME,
+	MIB_OBSS_AIRTIME = 86
+};
+
 struct edca {
 	u8 queue;
 	u8 set;
@@ -277,6 +290,7 @@ enum {
 	MCU_EXT_CMD_MUAR_UPDATE = 0x48,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
+	MCU_EXT_CMD_GET_MIB_INFO = 0x5a,
 	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
 	MCU_EXT_CMD_SET_SER_TRIGGER = 0x81,
 	MCU_EXT_CMD_SCS_CTRL = 0x82,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 4ea8972d4e2f..d41a344575b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -141,6 +141,7 @@ struct mt7915_phy {
 	u32 ampdu_ref;
 
 	struct mib_stats mib;
+	struct mt76_channel_state state_ts;
 	struct list_head stats_list;
 
 	u8 sta_work_count;
@@ -352,6 +353,7 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 			    const struct mt7915_dfs_pattern *pattern);
 int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev);
 int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy);
+int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch);
 int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index);
 int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx);
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index f039806f9d9b..4436b98196be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -132,20 +132,9 @@
 #define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
 #define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(15, 0)
 
-#define MT_MIB_SDR9(_band)		MT_WF_MIB(_band, 0x02c)
-#define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
-
-#define MT_MIB_SDR16(_band)		MT_WF_MIB(_band, 0x048)
-#define MT_MIB_SDR16_BUSY_MASK		GENMASK(23, 0)
-
 #define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
 #define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
 
-#define MT_MIB_SDR36(_band)		MT_WF_MIB(_band, 0x098)
-#define MT_MIB_SDR36_TXTIME_MASK	GENMASK(23, 0)
-#define MT_MIB_SDR37(_band)		MT_WF_MIB(_band, 0x09c)
-#define MT_MIB_SDR37_RXTIME_MASK	GENMASK(23, 0)
-
 #define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
 #define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
 #define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
@@ -158,9 +147,6 @@
 #define MT_MIB_BA_MISS_COUNT_MASK	GENMASK(15, 0)
 #define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(31, 16)
 
-#define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x108 + ((n) << 4))
-#define MT_MIB_FRAME_RETRIES_COUNT_MASK	GENMASK(15, 0)
-
 #define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x0a8 + ((n) << 2))
 #define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x164 + ((n) << 2))
 #define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x4b8 + ((n) << 2))
@@ -263,14 +249,10 @@
 #define MT_WF_RFCR1_DROP_CFEND		BIT(7)
 #define MT_WF_RFCR1_DROP_CFACK		BIT(8)
 
-#define MT_WF_RMAC_MIB_TIME0(_band)	MT_WF_RMAC(_band, 0x03c4)
+#define MT_WF_RMAC_MIB_AIRTIME0(_band)	MT_WF_RMAC(_band, 0x0380)
 #define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
 #define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
 
-#define MT_WF_RMAC_MIB_AIRTIME14(_band)	MT_WF_RMAC(_band, 0x03b8)
-#define MT_MIB_OBSSTIME_MASK		GENMASK(23, 0)
-#define MT_WF_RMAC_MIB_AIRTIME0(_band)	MT_WF_RMAC(_band, 0x0380)
-
 /* WFDMA0 */
 #define MT_WFDMA0_BASE			0xd4000
 #define MT_WFDMA0(ofs)			(MT_WFDMA0_BASE + (ofs))
-- 
2.18.0

