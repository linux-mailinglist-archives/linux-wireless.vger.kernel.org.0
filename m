Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90DC45D6F0
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 10:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347924AbhKYJSr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 04:18:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48596 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353293AbhKYJQr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 04:16:47 -0500
X-UUID: 03d2cd6343af444084a21f82f88f56b8-20211125
X-UUID: 03d2cd6343af444084a21f82f88f56b8-20211125
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 107346812; Thu, 25 Nov 2021 17:13:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 25 Nov 2021 17:13:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Nov 2021 17:13:32 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: update station's airtime and gi from event
Date:   Thu, 25 Nov 2021 17:13:30 +0800
Message-ID: <20211125091330.27770-1-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: MeiChia Chiu <meichia.chiu@mediatek.com>

To avoid race condition in firmware,
if firmware support airtime and gi event,
driver update station's airtime and gi from event.

Reviewed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>

---
 .../net/wireless/mediatek/mt76/mt7915/init.c   |   2 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c    |  35 ++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mcu.c    | 138 ++++++++++++++++++++++++++++++++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h    |  28 ++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mt7915.h |  11 ++++
 5 files changed, 204 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 4b56358d..a5f6d25d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -960,6 +960,8 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
+	dev->fw_ver = mt76_rr(dev, MT_SWDEF(0x7c));
+
 	return mt7915_init_debugfs(&dev->phy);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1041d88f..b2e20251 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1433,7 +1433,8 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		mt7915_txwi_free(dev, txwi, sta, &free_list);
 	}
 
-	mt7915_mac_sta_poll(dev);
+	if (!mt7915_firmware_offload(dev))
+		mt7915_mac_sta_poll(dev);
 
 	if (wake)
 		mt76_set_tx_blocked(&dev->mt76, false);
@@ -2195,27 +2196,41 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 void mt7915_mac_work(struct work_struct *work)
 {
 	struct mt7915_phy *phy;
+	struct mt7915_dev *dev;
 	struct mt76_phy *mphy;
 
 	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
 					       mac_work.work);
 	phy = mphy->priv;
+	dev = phy->dev;
 
-	mutex_lock(&mphy->dev->mutex);
+	if (++phy->stats_work_count == 10) {
+		phy->stats_work_count = 0;
+		mutex_lock(&mphy->dev->mutex);
 
-	mt76_update_survey(mphy);
-	if (++mphy->mac_work_count == 5) {
-		mphy->mac_work_count = 0;
+		mt76_update_survey(mphy);
+		if (++mphy->mac_work_count == 5) {
+			mphy->mac_work_count = 0;
 
-		mt7915_mac_update_stats(phy);
-	}
+			mt7915_mac_update_stats(phy);
+		}
 
-	mutex_unlock(&mphy->dev->mutex);
+		mutex_unlock(&mphy->dev->mutex);
 
-	mt76_tx_status_check(mphy->dev, false);
+		mt76_tx_status_check(mphy->dev, false);
+	}
+
+	if (mt7915_firmware_offload(dev)) {
+		mutex_lock(&mphy->dev->mutex);
+		mt7915_mcu_get_all_sta_stats(phy->dev,
+					     MCU_EXT_EVENT_TXRX_AIR_TIME);
+		mt7915_mcu_get_all_sta_stats(phy->dev,
+					     MCU_EXT_EVENT_PHY_GI_MODE);
+		mutex_unlock(&mphy->dev->mutex);
+	}
 
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
-				     MT7915_WATCHDOG_TIME);
+				     MT7915_WATCHDOG_TIME/10);
 }
 
 static void mt7915_dfs_stop_radar_detector(struct mt7915_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index bfc10117..141ef797 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -510,6 +510,126 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 		   (int)(skb->len - sizeof(*rxd)), data);
 }
 
+static void
+mt7915_mcu_get_sta_airtime(struct mt7915_dev *dev, struct sk_buff *skb)
+{
+	struct mt7915_mcu_sta_stat *at = (struct mt7915_mcu_sta_stat *)skb->data;
+	int idx;
+
+	for (idx = 0; idx < le16_to_cpu(at->sta_num); idx++) {
+		static const u8 ac_to_tid[] = {
+			[IEEE80211_AC_BE] = 0,
+			[IEEE80211_AC_BK] = 1,
+			[IEEE80211_AC_VI] = 4,
+			[IEEE80211_AC_VO] = 6
+		};
+		struct ieee80211_sta *sta;
+		struct mt7915_sta *msta;
+		struct mt76_wcid *wcid;
+		int i;
+		bool clear = false;
+		u16 w_idx;
+		u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
+
+		w_idx = le16_to_cpu(at->airtime[idx].wlan_id);
+		wcid = rcu_dereference(dev->mt76.wcid[w_idx]);
+		sta = wcid_to_sta(wcid);
+		if (!sta)
+			continue;
+
+		msta = container_of(wcid, struct mt7915_sta, wcid);
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u32 tx_last = msta->airtime_ac[i];
+			u32 rx_last = msta->airtime_ac[i + 4];
+
+			msta->airtime_ac[i] =
+				le32_to_cpu(at->airtime[idx].tx_time[i]);
+			msta->airtime_ac[i + 4] =
+				le32_to_cpu(at->airtime[idx].rx_time[i]);
+
+			tx_time[i] = msta->airtime_ac[i] - tx_last;
+			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+
+			if ((tx_last | rx_last) & BIT(30))
+				clear = true;
+		}
+
+		if (clear)
+			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u8 q = mt7915_lmac_mapping(dev, i);
+			u32 tx_cur = tx_time[q];
+			u32 rx_cur = rx_time[q];
+			u8 tid = ac_to_tid[i];
+
+			if (!tx_cur && !rx_cur)
+				continue;
+
+			ieee80211_sta_register_airtime(sta, tid, tx_cur,
+				rx_cur);
+		}
+	}
+}
+
+static void
+mt7915_mcu_get_sta_gi(struct mt7915_dev *dev, struct sk_buff *skb)
+{
+	struct mt7915_mcu_sta_stat *mgi = (struct mt7915_mcu_sta_stat *)skb->data;
+	int idx;
+
+	for (idx = 0; idx < le16_to_cpu(mgi->sta_num); idx++) {
+		struct ieee80211_sta *sta;
+		struct mt7915_sta *msta;
+		struct mt76_wcid *wcid;
+		struct rate_info *rate;
+		u8 val;
+		u16 w_idx;
+
+		w_idx = le16_to_cpu(mgi->gi[idx].wlan_id);
+		wcid = rcu_dereference(dev->mt76.wcid[w_idx]);
+		sta = wcid_to_sta(wcid);
+
+		if (!sta)
+			continue;
+
+		msta = container_of(wcid, struct mt7915_sta, wcid);
+		rate = &msta->wcid.rate;
+		val = mgi->gi[idx].gimode;
+
+		if (rate->flags & RATE_INFO_FLAGS_HE_MCS)
+			rate->he_gi = val;
+		else if (rate->flags &
+			(RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
+			if (val)
+				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+			else
+				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+		}
+	}
+}
+
+static void
+mt7915_mcu_rx_sta_stats(struct mt7915_dev *dev, struct sk_buff *skb)
+{
+	u8 type;
+
+	skb_pull(skb, sizeof(struct mt7915_mcu_rxd));
+	type = *(skb->data);
+
+	switch (type) {
+	case MCU_EXT_EVENT_TXRX_AIR_TIME:
+		mt7915_mcu_get_sta_airtime(dev, skb);
+		break;
+	case MCU_EXT_EVENT_PHY_GI_MODE:
+		mt7915_mcu_get_sta_gi(dev, skb);
+		break;
+	default:
+		break;
+	}
+}
+
 static void
 mt7915_mcu_cca_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -542,6 +662,9 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 				IEEE80211_IFACE_ITER_RESUME_ALL,
 				mt7915_mcu_cca_finish, dev);
 		break;
+	case MCU_EXT_EVENT_GET_ALL_STA_STATS:
+		mt7915_mcu_rx_sta_stats(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -571,6 +694,7 @@ void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
 	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
 	    rxd->ext_eid == MCU_EXT_EVENT_BCC_NOTIFY ||
+	    rxd->ext_eid == MCU_EXT_EVENT_GET_ALL_STA_STATS ||
 	    !rxd->seq)
 		mt7915_mcu_rx_unsolicited_event(dev, skb);
 	else
@@ -2993,6 +3117,20 @@ int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level)
 				 sizeof(data), false);
 }
 
+int mt7915_mcu_get_all_sta_stats(struct mt7915_dev *dev, u8 event)
+{
+
+	struct {
+		u8 event_type;
+		u8 res[3];
+	} req = {
+		.event_type = event
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(GET_ALL_STA_STATS),
+		&req, sizeof(req), false);
+}
+
 static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 4636b7dc..a1149224 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -44,6 +44,7 @@ enum {
 	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
 	MCU_EXT_EVENT_BCC_NOTIFY = 0x75,
+	MCU_EXT_EVENT_GET_ALL_STA_STATS = 0xb5,
 };
 
 enum {
@@ -53,6 +54,14 @@ enum {
 	MCU_ATE_CLEAN_TXQUEUE = 0x1c,
 };
 
+enum {
+	MCU_EXT_EVENT_ALL_TX_RX_RATE = 0x1,
+	MCU_EXT_EVENT_TX_STAT_PER_WCID = 0x2,
+	MCU_EXT_EVENT_RX_STAT = 0x03,
+	MCU_EXT_EVENT_TXRX_AIR_TIME = 0x05,
+	MCU_EXT_EVENT_PHY_GI_MODE = 0x07,
+};
+
 struct mt7915_mcu_rxd {
 	__le32 rxd[6];
 
@@ -206,6 +215,24 @@ struct mt7915_mcu_tx {
 	struct edca edca[IEEE80211_NUM_ACS];
 } __packed;
 
+struct mt7915_mcu_sta_stat {
+	u8 event_id;
+	u8 more_event;
+	__le16 sta_num;
+	union {
+		struct {
+			__le16 wlan_id;
+			__le32 tx_time[4];
+			__le32 rx_time[4];
+		} airtime[0];
+		struct {
+			__le16 wlan_id;
+			u8 gimode;
+			u8 rsv;
+		} gi[0];
+	}
+};
+
 #define WMM_AIFS_SET		BIT(0)
 #define WMM_CW_MIN_SET		BIT(1)
 #define WMM_CW_MAX_SET		BIT(2)
@@ -292,6 +319,7 @@ enum {
 	MCU_EXT_CMD_GROUP_PRE_CAL_INFO = 0xab,
 	MCU_EXT_CMD_DPD_PRE_CAL_INFO = 0xac,
 	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
+	MCU_EXT_CMD_GET_ALL_STA_STATS = 0xb5,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c6c846d1..dea83e82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -47,6 +47,8 @@
 #define MT7915_MAX_TWT_AGRT		16
 #define MT7915_MAX_STA_TWT_AGRT		8
 
+#define MT7915_FIRMWARE_V1		0
+
 struct mt7915_vif;
 struct mt7915_sta;
 struct mt7915_dfs_pulse;
@@ -228,6 +230,8 @@ struct mt7915_phy {
 	struct mib_stats mib;
 	struct mt76_channel_state state_ts;
 
+	u8 stats_work_count;
+
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
 		u32 *reg_backup;
@@ -276,6 +280,7 @@ struct mt7915_dev {
 	bool ibf;
 	u8 fw_debug_wm;
 	u8 fw_debug_wa;
+	u8 fw_ver;
 
 	void *cal;
 
@@ -457,6 +462,7 @@ int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev, enum mt7915_rdd_cmd cmd,
 int mt7915_mcu_wa_cmd(struct mt7915_dev *dev, int cmd, u32 a1, u32 a2, u32 a3);
 int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 type, u8 ctrl);
 int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level);
+int mt7915_mcu_get_all_sta_stats(struct mt7915_dev *dev, u8 event);
 void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb);
 void mt7915_mcu_exit(struct mt7915_dev *dev);
 
@@ -486,6 +492,11 @@ static inline void mt7915_irq_disable(struct mt7915_dev *dev, u32 mask)
 		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+static inline bool mt7915_firmware_offload(struct mt7915_dev *dev)
+{
+	return dev->fw_ver == MT7915_FIRMWARE_V1;
+}
+
 u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid, u8 dw);
 bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask);
 void mt7915_mac_reset_counters(struct mt7915_phy *phy);
-- 
2.29.2

