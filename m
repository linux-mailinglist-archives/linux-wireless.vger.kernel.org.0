Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4CD3A337C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhFJSqJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 14:46:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47541 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230184AbhFJSqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 14:46:06 -0400
X-UUID: 9475c62db03f4524b1f5873970cc526b-20210611
X-UUID: 9475c62db03f4524b1f5873970cc526b-20210611
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1948788747; Fri, 11 Jun 2021 02:44:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Jun 2021 02:43:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Jun 2021 02:43:53 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH 4/4] mt76: mt7915: improve MU stability
Date:   Fri, 11 Jun 2021 02:43:47 +0800
Message-ID: <61c73b3c279e10ee848d74611631282b43039671.1623347029.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <245a3745aea487793e40fbf82172c5367649bab3.1623347029.git.ryder.lee@mediatek.com>
References: <245a3745aea487793e40fbf82172c5367649bab3.1623347029.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Adjust starec flow since VHT MU group is only updated by starec_vht
  follows starec_bf settings.
- Drop unnecessary MU BF checks.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 12 ++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 98 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  5 +
 3 files changed, 64 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index c6e9a7038311..64048243e34b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -148,6 +148,9 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 {
 	struct mt7915_dev *dev = s->private;
 	bool ext_phy = phy != &dev->phy;
+	static const char * const bw[] = {
+		"BW20", "BW40", "BW80", "BW160"
+	};
 	int cnt;
 
 	if (!phy)
@@ -165,11 +168,16 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 	seq_puts(s, "Tx Beamformer Rx feedback statistics: ");
 
 	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CNT(ext_phy));
-	seq_printf(s, "All: %ld, HE: %ld, VHT: %ld, HT: %ld\n",
+	seq_printf(s, "All: %ld, HE: %ld, VHT: %ld, HT: %ld, ",
 		   FIELD_GET(MT_ETBF_RX_FB_ALL, cnt),
 		   FIELD_GET(MT_ETBF_RX_FB_HE, cnt),
 		   FIELD_GET(MT_ETBF_RX_FB_VHT, cnt),
 		   FIELD_GET(MT_ETBF_RX_FB_HT, cnt));
+	cnt = mt76_rr(dev, MT_ETBF_RX_FB_CONT(ext_phy));
+	seq_printf(s, "%s, NC: %ld, NR: %ld\n",
+		   bw[FIELD_GET(MT_ETBF_RX_FB_BW, cnt)],
+		   FIELD_GET(MT_ETBF_RX_FB_NC, cnt),
+		   FIELD_GET(MT_ETBF_RX_FB_NR, cnt));
 
 	/* Tx Beamformee Rx NDPA & Tx feedback report */
 	cnt = mt76_rr(dev, MT_ETBF_TX_NDP_BFRP(ext_phy));
@@ -205,7 +213,7 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 	mt7915_txbf_stat_read_phy(mt7915_ext_phy(dev), file);
 
 	/* Tx amsdu info */
-	seq_puts(file, "Tx MSDU stat:\n");
+	seq_puts(file, "Tx MSDU statistics:\n");
 	for (i = 0, n = 0; i < ARRAY_SIZE(stat); i++) {
 		stat[i] = mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
 		n += stat[i];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ca633c1bb8c7..b565024404cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1685,27 +1685,18 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 		HE_PHY(CAP2_UL_MU_PARTIAL_MU_MIMO, elem->phy_cap_info[2]);
 }
 
-static int
-mt7915_mcu_add_mu(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-		  struct ieee80211_sta *sta)
+static void
+mt7915_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 {
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct sk_buff *skb;
-	int len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_muru);
-
-	if (!sta->vht_cap.vht_supported && !sta->he_cap.has_he)
-		return 0;
+	struct sta_rec_vht *vht;
+	struct tlv *tlv;
 
-	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
+	tlv = mt7915_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
 
-	/* starec muru */
-	mt7915_mcu_sta_muru_tlv(skb, sta);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
+	vht = (struct sta_rec_vht *)tlv;
+	vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
+	vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
+	vht->vht_tx_mcs_map = sta->vht_cap.vht_mcs.tx_mcs_map;
 }
 
 static void
@@ -1757,17 +1748,6 @@ mt7915_mcu_sta_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 			mt7915_mcu_sta_amsdu_tlv(skb, sta);
 	}
 
-	/* starec vht */
-	if (sta->vht_cap.vht_supported) {
-		struct sta_rec_vht *vht;
-
-		tlv = mt7915_mcu_add_tlv(skb, STA_REC_VHT, sizeof(*vht));
-		vht = (struct sta_rec_vht *)tlv;
-		vht->vht_cap = cpu_to_le32(sta->vht_cap.cap);
-		vht->vht_rx_mcs_map = sta->vht_cap.vht_mcs.rx_mcs_map;
-		vht->vht_tx_mcs_map = sta->vht_cap.vht_mcs.tx_mcs_map;
-	}
-
 	/* starec he */
 	if (sta->he_cap.has_he)
 		mt7915_mcu_sta_he_tlv(skb, sta);
@@ -2157,26 +2137,21 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		vc = mt7915_get_he_phy_cap(phy, vif);
 		ve = &vc->he_cap_elem;
 
-		ebfee = !!((HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]) ||
-			    HE_PHY(CAP4_MU_BEAMFORMER, pe->phy_cap_info[4])) &&
+		ebfee = !!(HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]) &&
 			   HE_PHY(CAP4_SU_BEAMFORMEE, ve->phy_cap_info[4]));
-		ebf = !!((HE_PHY(CAP3_SU_BEAMFORMER, ve->phy_cap_info[3]) ||
-			  HE_PHY(CAP4_MU_BEAMFORMER, ve->phy_cap_info[4])) &&
+		ebf = !!(HE_PHY(CAP3_SU_BEAMFORMER, ve->phy_cap_info[3]) &&
 			 HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]));
 	} else if (sta->vht_cap.vht_supported) {
 		struct ieee80211_sta_vht_cap *pc;
 		struct ieee80211_sta_vht_cap *vc;
-		u32 cr, ce;
 
 		pc = &sta->vht_cap;
 		vc = &phy->mt76->sband_5g.sband.vht_cap;
-		cr = IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
-		     IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE;
-		ce = IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
-		     IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
 
-		ebfee = !!((pc->cap & cr) && (vc->cap & ce));
-		ebf = !!((vc->cap & cr) && (pc->cap & ce));
+		ebfee = !!((pc->cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) &&
+			   (vc->cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
+		ebf = !!((vc->cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE) &&
+			 (pc->cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
 	}
 
 	/* must keep each tag independent */
@@ -2379,31 +2354,56 @@ mt7915_mcu_add_group(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				 sizeof(req), true);
 }
 
-int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta, bool enable)
+static int
+mt7915_mcu_add_mu(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+		  struct ieee80211_sta *sta)
 {
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct sk_buff *skb;
 	int ret;
 
-	if (!sta)
+	if (!sta->vht_cap.vht_supported && !sta->he_cap.has_he)
 		return 0;
 
-	/* must keep the order */
 	ret = mt7915_mcu_add_group(dev, vif, sta);
 	if (ret)
 		return ret;
 
+	skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta,
+				       MT7915_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	/* wait until TxBF and MU ready to update stare vht */
+
+	/* starec muru */
+	mt7915_mcu_sta_muru_tlv(skb, sta);
+	/* starec vht */
+	mt7915_mcu_sta_vht_tlv(skb, sta);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
+}
+
+int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, bool enable)
+{
+	int ret;
+
+	if (!sta)
+		return 0;
+
+	/* must keep the order */
 	ret = mt7915_mcu_add_txbf(dev, vif, sta, enable);
-	if (ret)
+	if (ret || !enable)
 		return ret;
 
 	ret = mt7915_mcu_add_mu(dev, vif, sta);
 	if (ret)
 		return ret;
 
-	if (enable)
-		return mt7915_mcu_add_rate_ctrl(dev, vif, sta);
-
-	return 0;
+	return mt7915_mcu_add_rate_ctrl(dev, vif, sta);
 }
 
 int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 56c33eaa9d79..a213b5cb82f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -99,6 +99,11 @@
 #define MT_ETBF_TX_FB_CPL		GENMASK(31, 16)
 #define MT_ETBF_TX_FB_TRI		GENMASK(15, 0)
 
+#define MT_ETBF_RX_FB_CONT(_band)	MT_WF_ETBF(_band, 0x068)
+#define MT_ETBF_RX_FB_BW		GENMASK(7, 6)
+#define MT_ETBF_RX_FB_NC		GENMASK(5, 3)
+#define MT_ETBF_RX_FB_NR		GENMASK(2, 0)
+
 #define MT_ETBF_TX_APP_CNT(_band)	MT_WF_ETBF(_band, 0x0f0)
 #define MT_ETBF_TX_IBF_CNT		GENMASK(31, 16)
 #define MT_ETBF_TX_EBF_CNT		GENMASK(15, 0)
-- 
2.18.0

