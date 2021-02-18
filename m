Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF431E3F6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Feb 2021 02:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBRBfg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Feb 2021 20:35:36 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33960 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229996AbhBRBfe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Feb 2021 20:35:34 -0500
X-UUID: 2ce6bc10cdcf438bbda8d2db126691f1-20210218
X-UUID: 2ce6bc10cdcf438bbda8d2db126691f1-20210218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 409016905; Thu, 18 Feb 2021 09:34:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Feb 2021 09:34:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Feb 2021 09:34:44 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/3] mt76: mt7615: add support for rx decapsulation offload
Date:   Thu, 18 Feb 2021 09:34:40 +0800
Message-ID: <c6ac1912b1c4844cdade7798098084e6ac26c835.1613603857.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <b7883f5ee09d13f7cbdf5ab1d5fef61ebc79dcc4.1613603857.git.ryder.lee@mediatek.com>
References: <b7883f5ee09d13f7cbdf5ab1d5fef61ebc79dcc4.1613603857.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For AP and Client mode, the hardware can pass received packets
as 802.3 frames that can be passed to the network stack as-is.

Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  5 ++-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 44 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  5 +++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 17 +++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 39 ++++++++++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  4 ++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 19 ++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  6 ++-
 9 files changed, 127 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index fd38737a27bd..88a2ee7e7143 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -118,7 +118,8 @@ mt7615_mac_init(struct mt7615_dev *dev)
 
 	mt76_wr(dev, MT_DMA_DCR0,
 		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072) |
-		MT_DMA_DCR0_RX_VEC_DROP | MT_DMA_DCR0_DAMSDU_EN);
+		MT_DMA_DCR0_RX_VEC_DROP | MT_DMA_DCR0_DAMSDU_EN |
+		MT_DMA_DCR0_RX_HDR_TRANS_EN);
 	/* disable TDLS filtering */
 	mt76_clear(dev, MT_WF_PFCR, MT_WF_PFCR_TDLS_EN);
 	mt76_set(dev, MT_WF_MIB_SCR0, MT_MIB_SCR0_AGG_CNT_RANGE_EN);
@@ -128,6 +129,7 @@ mt7615_mac_init(struct mt7615_dev *dev)
 	} else {
 		mt7615_init_mac_chain(dev, 1);
 	}
+	mt7615_mcu_set_rx_hdr_trans_blacklist(dev);
 }
 
 static void
@@ -360,6 +362,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 
 	if (is_mt7615(&phy->dev->mt76))
 		hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 340beff0e121..f2dd56674acb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -236,10 +236,12 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
 	__le32 rxd12 = rxd[12];
-	bool unicast, remove_pad, insert_ccmp_hdr = false;
+	bool unicast, hdr_trans, remove_pad, insert_ccmp_hdr = false;
 	int phy_idx;
 	int i, idx;
-	u8 chfreq, amsdu_info;
+	u8 chfreq, amsdu_info, qos_ctl = 0;
+	u16 seq_ctrl = 0;
+	__le16 fc = 0;
 
 	memset(status, 0, sizeof(*status));
 
@@ -260,6 +262,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	unicast = (rxd1 & MT_RXD1_NORMAL_ADDR_TYPE) == MT_RXD1_NORMAL_U2M;
 	idx = FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
+	hdr_trans = rxd1 & MT_RXD1_NORMAL_HDR_TRANS;
 	status->wcid = mt7615_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
@@ -295,6 +298,13 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 
 	rxd += 4;
 	if (rxd0 & MT_RXD0_NORMAL_GROUP_4) {
+		u32 v0 = le32_to_cpu(rxd[0]);
+		u32 v2 = le32_to_cpu(rxd[2]);
+
+		fc = cpu_to_le16(FIELD_GET(MT_RXD4_FRAME_CONTROL, v0));
+		qos_ctl = FIELD_GET(MT_RXD6_QOS_CTL, v2);
+		seq_ctrl = FIELD_GET(MT_RXD6_SEQ_CTRL, v2);
+
 		rxd += 4;
 		if ((u8 *)rxd - skb->data >= skb->len)
 			return -EINVAL;
@@ -458,25 +468,37 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (status->amsdu) {
 		status->first_amsdu = amsdu_info == MT_RXD1_FIRST_AMSDU_FRAME;
 		status->last_amsdu = amsdu_info == MT_RXD1_LAST_AMSDU_FRAME;
-		memmove(skb->data + 2, skb->data,
-			ieee80211_get_hdrlen_from_skb(skb));
-		skb_pull(skb, 2);
+		if (!hdr_trans) {
+			memmove(skb->data + 2, skb->data,
+				ieee80211_get_hdrlen_from_skb(skb));
+			skb_pull(skb, 2);
+		}
 	}
 
-	if (insert_ccmp_hdr) {
+	if (insert_ccmp_hdr && !hdr_trans) {
 		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
 
 		mt76_insert_ccmp_hdr(skb, key_id);
 	}
 
-	hdr = (struct ieee80211_hdr *)skb->data;
-	if (!status->wcid || !ieee80211_is_data_qos(hdr->frame_control))
+	if (!hdr_trans) {
+		hdr = (struct ieee80211_hdr *)skb->data;
+		fc = hdr->frame_control;
+		if (ieee80211_is_data_qos(fc)) {
+			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
+			qos_ctl = *ieee80211_get_qos_ctl(hdr);
+		}
+	} else {
+		status->flag |= RX_FLAG_8023;
+	}
+
+	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
 
 	status->aggr = unicast &&
-		       !ieee80211_is_qos_nullfunc(hdr->frame_control);
-	status->qos_ctl = *ieee80211_get_qos_ctl(hdr);
-	status->seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
+		       !ieee80211_is_qos_nullfunc(fc);
+	status->qos_ctl = qos_ctl;
+	status->seqno = IEEE80211_SEQ_TO_SN(seq_ctrl);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index ed009d085a53..6bf9da040196 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -81,6 +81,11 @@ enum rx_pkt_type {
 #define MT_RXD3_NORMAL_TSF_COMPARE_LOSS	BIT(8)
 #define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
 
+#define MT_RXD4_FRAME_CONTROL		GENMASK(15, 0)
+
+#define MT_RXD6_SEQ_CTRL		GENMASK(15, 0)
+#define MT_RXD6_QOS_CTL			GENMASK(31, 16)
+
 #define MT_RXV1_ACID_DET_H		BIT(31)
 #define MT_RXV1_ACID_DET_L		BIT(30)
 #define MT_RXV1_VHTA2_B8_B3		GENMASK(29, 24)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 1aa6928f88fc..1cf40f85eb55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1087,6 +1087,22 @@ static int mt7615_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static void mt7615_sta_set_decap_offload(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 bool enabled)
+{
+	struct mt7615_dev *dev = mt7615_hw_dev(hw);
+	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+
+	if (enabled)
+		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+	else
+		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
+
+	mt7615_mcu_sta_update_hdr_trans(dev, vif, sta);
+}
+
 #ifdef CONFIG_PM
 static int mt7615_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
@@ -1187,6 +1203,7 @@ const struct ieee80211_ops mt7615_ops = {
 	.sta_remove = mt7615_sta_remove,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt7615_set_key,
+	.sta_set_decap_offload = mt7615_sta_set_decap_offload,
 	.ampdu_action = mt7615_ampdu_action,
 	.set_rts_threshold = mt7615_set_rts_threshold,
 	.wake_tx_queue = mt7615_wake_tx_queue,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 4ecbd5406e2a..393ce09d3956 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1097,6 +1097,25 @@ static const struct mt7615_mcu_ops sta_update_ops = {
 	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
 };
 
+int mt7615_mcu_sta_update_hdr_trans(struct mt7615_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta)
+{
+	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct sk_buff *skb = NULL;
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
+						  WTBL_SET, NULL, &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
+				     true);
+}
+
 static int
 mt7615_mcu_uni_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 {
@@ -2500,6 +2519,26 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
 	return ret;
 }
 
+int mt7615_mcu_set_rx_hdr_trans_blacklist(struct mt7615_dev *dev)
+{
+	struct {
+		u8 operation;
+		u8 count;
+		u8 _rsv[2];
+		u8 index;
+		u8 enable;
+		__le16 etype;
+	} req = {
+		.operation = 1,
+		.count = 1,
+		.enable = 1,
+		.etype = cpu_to_le16(ETH_P_PAE),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RX_HDR_TRANS,
+				 &req, sizeof(req), false);
+}
+
 int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			  bool enable)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 491841bc6291..3c509b9a2cae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -524,6 +524,10 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt7615_mac_work(struct work_struct *work);
 void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
+int mt7615_mcu_sta_update_hdr_trans(struct mt7615_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta);
+int mt7615_mcu_set_rx_hdr_trans_blacklist(struct mt7615_dev *dev);
 int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val);
 int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
 			    const struct mt7615_dfs_pulse *pulse);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 4ebffe52cb8e..1fd7f183629e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -370,6 +370,7 @@ enum mt7615_reg_base {
 #define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 2)
 #define MT_DMA_DCR0_DAMSDU_EN		BIT(16)
 #define MT_DMA_DCR0_RX_VEC_DROP		BIT(17)
+#define MT_DMA_DCR0_RX_HDR_TRANS_EN	BIT(19)
 
 #define MT_DMA_RCFR0(_band)		MT_WF_DMA(0x070 + (_band) * 0x40)
 #define MT_DMA_RCFR0_MCU_RX_MGMT	BIT(2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index ac8d6ad76054..2127ef39072d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -392,6 +392,25 @@ mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
 	uapsd->max_sp = sta->max_sp;
 }
 
+void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					void *sta_wtbl, void *wtbl_tlv)
+{
+	struct mt76_wcid *wcid;
+	struct wtbl_hdr_trans *htr;
+	struct tlv *tlv;
+
+	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_HDR_TRANS,
+					     sizeof(*htr),
+					     wtbl_tlv, sta_wtbl);
+	htr = (struct wtbl_hdr_trans *)tlv;
+
+	wcid = (struct mt76_wcid *)sta->drv_priv;
+	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_hdr_trans_tlv);
+
 void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 				      struct sk_buff *skb,
 				      struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 9c26b90655a7..2a48c477aba1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -210,7 +210,7 @@ struct wtbl_hdr_trans {
 	__le16 len;
 	u8 to_ds;
 	u8 from_ds;
-	u8 disable_rx_trans;
+	u8 no_rx_trans;
 	u8 rsv;
 } __packed;
 
@@ -914,6 +914,10 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta, void *sta_wtbl,
 				      void *wtbl_tlv);
+void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					void *sta_wtbl, void *wtbl_tlv);
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
 			     struct ieee80211_vif *vif);
-- 
2.18.0

