Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA443A3478
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 22:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFJUFc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 16:05:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59373 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229963AbhFJUFb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 16:05:31 -0400
X-UUID: 8d015d0e8218410b8310744efefab0ee-20210611
X-UUID: 8d015d0e8218410b8310744efefab0ee-20210611
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 884057279; Fri, 11 Jun 2021 04:03:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Jun 2021 04:03:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Jun 2021 04:03:30 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: improve MU stability
Date:   Fri, 11 Jun 2021 04:03:26 +0800
Message-ID: <fbd21e7653abd3432f82d011deee682c39c235c6.1623355065.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Adjust starec flow since VHT MU group is only updated by starec_vht
  follows starec_bf settings.
- Drop unnecessary MU BF checks.

TX MPDU PER (Status = Success):
                                           TOT_MPDU_CNT  FAIL_MPDU_CNT  TX_PER
WCID Rate
1      VHT_BW80_2SS_MCS7_LGI_LDPC_MUBF              114              0   0.00%
       VHT_BW80_2SS_MCS7_LGI_LDPC_MUBF_MU            64              0   0.00%
       VHT_BW80_2SS_MCS7_SGI_LDPC_MUBF              128              0   0.00%
       VHT_BW80_2SS_MCS7_SGI_LDPC_MUBF_MU           745              0   0.00%
       VHT_BW80_2SS_MCS8_LGI_LDPC_MUBF_MU           856              0   0.00%
       VHT_BW80_2SS_MCS8_SGI_LDPC_MUBF_MU          1430              4   0.28%
       VHT_BW80_2SS_MCS9_LGI_LDPC_MUBF_MU          5220             31   0.59%
       VHT_BW80_2SS_MCS9_LGI_LDPC_iBF                59              0   0.00%
       VHT_BW80_2SS_MCS9_SGI_LDPC_MUBF               64              2   3.12%
       VHT_BW80_2SS_MCS9_SGI_LDPC_MUBF_MU         22132             76   0.34%
       VHT_BW80_2SS_MCS9_SGI_LDPC_iBF              2866              1   0.03%
2      VHT_BW80_2SS_MCS7_LGI_LDPC_MUBF_MU          3781              5   0.13%
       VHT_BW80_2SS_MCS7_SGI_LDPC_MUBF_MU           735              0   0.00%
       VHT_BW80_2SS_MCS8_LGI_LDPC_MUBF_MU          1270            365  28.74%
       VHT_BW80_2SS_MCS8_SGI_LDPC_MUBF_MU          3420             57   1.67%
       VHT_BW80_2SS_MCS9_LGI_LDPC_MUBF              128              0   0.00%
       VHT_BW80_2SS_MCS9_LGI_LDPC_MUBF_MU            64              0   0.00%
       VHT_BW80_2SS_MCS9_SGI_LDPC_MUBF              191              0   0.00%
       VHT_BW80_2SS_MCS9_SGI_LDPC_MUBF_MU         18833            320   1.70%
       VHT_BW80_2SS_MCS9_SGI_LDPC_iBF              6040              0   0.00%
287    OFDM 6M

Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2 - add test result and a missing tag.
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

