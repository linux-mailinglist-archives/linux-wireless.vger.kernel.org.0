Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D73ABD9A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhFQUlQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 16:41:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32970 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231225AbhFQUlQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 16:41:16 -0400
X-UUID: 5983c8e0a2e24ae3aa486f1ba4f71bcb-20210618
X-UUID: 5983c8e0a2e24ae3aa486f1ba4f71bcb-20210618
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1414765447; Fri, 18 Jun 2021 04:39:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Jun 2021 04:39:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 04:39:03 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 3/3] mt76: mt7615: add 802.11 encap offload support
Date:   Fri, 18 Jun 2021 04:39:01 +0800
Message-ID: <abacfa39ce92e5b1853183b178e1d829b2d8860d.1623961575.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <177785418cf407808bf3a44760302d0647076990.1623961575.git.ryder.lee@mediatek.com>
References: <177785418cf407808bf3a44760302d0647076990.1623961575.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is currently limited to AP interfaces. 3-address mode STA interface
can either work by adding IEEE80211_OFFLOAD_ENCAP_ENABLED back into
vif->offload_flags, but just note that this breaks 4-address mode.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2 - add a note for station mode limitation
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 189 ++++++++++++------
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |   1 +
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   3 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   4 +-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |   6 +-
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |   3 +
 7 files changed, 141 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 36c9e527bb9a..5cff7a748470 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -398,6 +398,7 @@ mt7615_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, TX_STATUS_NO_AMPDU_LEN);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+	ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 
 	if (is_mt7615(&phy->dev->mt76))
 		hw->max_tx_fragments = MT_TXP_MAX_BUF_NUM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index f43df43512a8..9123a5611b5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -607,24 +607,128 @@ mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
 	return rateval;
 }
 
+static void
+mt7615_mac_write_txwi_8023(struct mt7615_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid)
+{
+
+	bool is_mmio = mt76_is_mmio(&dev->mt76);
+	u8 fc_type, fc_stype;
+	bool wmm = false;
+	u32 val;
+
+	if (wcid->sta) {
+		struct ieee80211_sta *sta;
+
+		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+		wmm = sta->wme;
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3);
+	if (be16_to_cpu(skb->protocol) >= ETH_P_802_3_MIN)
+		val |= MT_TXD1_ETH_802_3;
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = IEEE80211_FTYPE_DATA >> 2;
+	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+	txwi[2] |= cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	txwi[7] |= cpu_to_le32(val);
+
+	if (!is_mmio) {
+		val = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
+		      FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
+		txwi[8] |= cpu_to_le32(val);
+	}
+}
+
+static void
+mt7615_mac_write_txwi_80211(struct mt7615_dev *dev, __le32 *txwi,
+			    struct sk_buff *skb, struct ieee80211_key_conf *key)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	bool is_mmio = mt76_is_mmio(&dev->mt76);
+	__le16 fc = hdr->frame_control;
+	u8 fc_type, fc_stype;
+	u32 val;
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
+	      FIELD_PREP(MT_TXD1_HDR_INFO,
+			 ieee80211_get_hdrlen_from_skb(skb) / 2);
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
+	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
+	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
+
+	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+		val |= MT_TXD2_BIP;
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
+	}
+
+	txwi[2] |= cpu_to_le32(val);
+
+	if (ieee80211_is_beacon(fc)) {
+		val = MT_TXD5_TX_STATUS_HOST | MT_TXD5_SW_POWER_MGMT |
+		      MT_TXD5_PID;
+		txwi[5] &= ~cpu_to_le32(val);
+		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
+	}
+
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
+
+		if (ieee80211_is_back_req(hdr->frame_control)) {
+			struct ieee80211_bar *bar;
+
+			bar = (struct ieee80211_bar *)skb->data;
+			seqno = le16_to_cpu(bar->start_seq_num);
+		}
+
+		val = MT_TXD3_SN_VALID |
+		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
+		txwi[3] |= cpu_to_le32(val);
+	}
+
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	txwi[7] |= cpu_to_le32(val);
+
+	if (!is_mmio) {
+		val = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
+		      FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
+		txwi[8] |= cpu_to_le32(val);
+	}
+}
+
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
 			  struct ieee80211_key_conf *key, bool beacon)
 {
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
+	struct ieee80211_hw *hw = mt76_hw(dev);
 	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
-	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	struct ieee80211_vif *vif = info->control.vif;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	bool is_mmio = mt76_is_mmio(&dev->mt76);
 	u32 val, sz_txd = is_mmio ? MT_TXD_SIZE : MT_USB_TXD_SIZE;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	struct mt76_phy *mphy = &dev->mphy;
-	__le16 fc = hdr->frame_control;
 	int tx_count = 8;
-	u16 seqno = 0;
 
 	if (vif) {
 		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
@@ -642,9 +746,6 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	if (ext_phy && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
-	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
-	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
-
 	if (beacon) {
 		p_fmt = MT_TX_TYPE_FW;
 		q_idx = ext_phy ? MT_LMAC_BCN1 : MT_LMAC_BCN0;
@@ -664,37 +765,20 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 
 	val = MT_TXD1_LONG_FORMAT |
 	      FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
-	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
-	      FIELD_PREP(MT_TXD1_HDR_INFO,
-			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
 	      FIELD_PREP(MT_TXD1_TID,
 			 skb->priority & IEEE80211_QOS_CTL_TID_MASK) |
 	      FIELD_PREP(MT_TXD1_PKT_FMT, p_fmt) |
 	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
 	txwi[1] = cpu_to_le32(val);
 
-	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
-	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
-	if (key) {
-		if (multicast && ieee80211_is_robust_mgmt_frame(skb) &&
-		    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
-			val |= MT_TXD2_BIP;
-			txwi[3] = 0;
-		} else {
-			txwi[3] = cpu_to_le32(MT_TXD3_PROTECT_FRAME);
-		}
-	} else {
-		txwi[3] = 0;
-	}
-	txwi[2] = cpu_to_le32(val);
+	txwi[2] = 0;
+	txwi[4] = 0;
+	txwi[6] = 0;
+	txwi[7] = cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX, 0x18));
 
 	if (!(info->flags & IEEE80211_TX_CTL_AMPDU))
 		txwi[2] |= cpu_to_le32(MT_TXD2_BA_DISABLE);
 
-	txwi[4] = 0;
-	txwi[6] = 0;
-
 	if (rate->idx >= 0 && rate->count &&
 	    !(info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE)) {
 		bool stbc = info->flags & IEEE80211_TX_CTL_STBC;
@@ -722,45 +806,24 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 		tx_count = rate->count;
 	}
 
-	if (!ieee80211_is_beacon(fc)) {
-		struct ieee80211_hw *hw = mt76_hw(dev);
-
-		val = MT_TXD5_TX_STATUS_HOST | FIELD_PREP(MT_TXD5_PID, pid);
-		if (!ieee80211_hw_check(hw, SUPPORTS_PS))
-			val |= MT_TXD5_SW_POWER_MGMT;
-		txwi[5] = cpu_to_le32(val);
-	} else {
-		txwi[5] = 0;
-		/* use maximum tx count for beacons */
-		tx_count = 0x1f;
-	}
-
 	val = FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
-	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
-		seqno = le16_to_cpu(hdr->seq_ctrl);
+	if (key)
+		val |= MT_TXD3_PROTECT_FRAME;
+	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		val |= MT_TXD3_NO_ACK;
 
-		if (ieee80211_is_back_req(hdr->frame_control)) {
-			struct ieee80211_bar *bar;
+	txwi[3] = cpu_to_le32(val);
 
-			bar = (struct ieee80211_bar *)skb->data;
-			seqno = le16_to_cpu(bar->start_seq_num);
-		}
-
-		val |= MT_TXD3_SN_VALID |
-		       FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
-	}
+	val = MT_TXD5_TX_STATUS_HOST | FIELD_PREP(MT_TXD5_PID, pid);
+	if (!ieee80211_hw_check(hw, SUPPORTS_PS))
+		val |= MT_TXD5_SW_POWER_MGMT;
 
-	txwi[3] |= cpu_to_le32(val);
+	txwi[5] = cpu_to_le32(val);
 
-	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
-		txwi[3] |= cpu_to_le32(MT_TXD3_NO_ACK);
-
-	txwi[7] = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
-		  FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype) |
-		  FIELD_PREP(MT_TXD7_SPE_IDX, 0x18);
-	if (!is_mmio)
-		txwi[8] = FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
-			  FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
+	if (is_8023)
+		mt7615_mac_write_txwi_8023(dev, txwi, skb, wcid);
+	else
+		mt7615_mac_write_txwi_80211(dev, txwi, skb, key);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 46f283eb8d0f..0b6d0b41ad83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -186,6 +186,7 @@ enum tx_phy_bandwidth {
 #define MT_TXD1_LONG_FORMAT		BIT(15)
 #define MT_TXD1_HDR_FORMAT		GENMASK(14, 13)
 #define MT_TXD1_HDR_INFO		GENMASK(12, 8)
+#define MT_TXD1_ETH_802_3		BIT(12)
 #define MT_TXD1_WLAN_IDX		GENMASK(7, 0)
 
 #define MT_TXD2_FIX_RATE		BIT(31)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 7c9a55c57578..30e9c189edb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -240,6 +240,9 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ret = mt7615_mcu_add_dev_info(phy, vif, true);
+
+	if (vif->type != NL80211_IFTYPE_AP)
+		vif->offload_flags = 0;
 out:
 	mt7615_mutex_release(dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index cf4a4f2637d5..6cf2ed680097 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1041,11 +1041,11 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (enable) {
 		mt76_connac_mcu_wtbl_generic_tlv(&dev->mt76, wskb, vif, sta,
 						 NULL, wtbl_hdr);
+		mt76_connac_mcu_wtbl_hdr_trans_tlv(wskb, vif, &msta->wcid,
+						   NULL, wtbl_hdr);
 		if (sta)
 			mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, wskb, sta,
 						    NULL, wtbl_hdr);
-		mt76_connac_mcu_wtbl_hdr_trans_tlv(wskb, vif, &msta->wcid,
-						   NULL, wtbl_hdr);
 	}
 
 	cmd = enable ? MCU_EXT_CMD_WTBL_UPDATE : MCU_EXT_CMD_STA_REC_UPDATE;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index cc278d8cb888..f8cc3561dd0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -112,7 +112,8 @@ mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
 	if (!key)
 		txp->flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
 
-	if (ieee80211_is_mgmt(hdr->frame_control))
+	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
+	    ieee80211_is_mgmt(hdr->frame_control))
 		txp->flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
 
 	if (vif) {
@@ -139,6 +140,9 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct mt7615_sta *msta;
 	void *txp;
 
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
 	msta = wcid ? container_of(wcid, struct mt7615_sta, wcid) : NULL;
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 996d48cca18a..fcbaee21bd4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -197,6 +197,9 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct mt7615_sta *msta;
 	int pad;
 
+	if (unlikely(skb->len <= ETH_HLEN))
+		return -EINVAL;
+
 	msta = wcid ? container_of(wcid, struct mt7615_sta, wcid) : NULL;
 	if ((info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) &&
 	    msta && !msta->rate_probe) {
-- 
2.18.0

