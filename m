Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB3F2F5A3F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 06:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbhANFVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 00:21:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39570 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbhANFVa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 00:21:30 -0500
X-UUID: 236f86e96eeb4b21a83b8583870be22b-20210114
X-UUID: 236f86e96eeb4b21a83b8583870be22b-20210114
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1625701946; Thu, 14 Jan 2021 13:15:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 Jan 2021 13:15:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Jan 2021 13:15:33 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] mt76: mt7915: add implicit Tx beamforming support
Date:   Thu, 14 Jan 2021 13:15:31 +0800
Message-ID: <f82e0175465a5e29e0446f8b3ba1ded484b418ba.1610594238.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <b72ecf59938ed6adce6b49239e4e9d3658ca49d4.1610594238.git.ryder.lee@mediatek.com>
References: <b72ecf59938ed6adce6b49239e4e9d3658ca49d4.1610594238.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add ht/vht implicit Tx beamforming support and enable it via debugfs.

Tested-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v2: 
- use -EBUSY as the return value.
- adjust flow.
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  28 +++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   8 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 108 +++++++++---------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   1 +
 4 files changed, 87 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 7d810fbf2862..77dcd71e49a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -6,6 +6,32 @@
 
 /** global debugfs **/
 
+static int
+mt7915_implicit_txbf_set(void *data, u64 val)
+{
+	struct mt7915_dev *dev = data;
+
+	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
+		return -EBUSY;
+
+	dev->ibf = !!val;
+
+	return mt7915_mcu_set_txbf_type(dev);
+}
+
+static int
+mt7915_implicit_txbf_get(void *data, u64 *val)
+{
+	struct mt7915_dev *dev = data;
+
+	*val = dev->ibf;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7915_implicit_txbf_get,
+			 mt7915_implicit_txbf_set, "%lld\n");
+
 /* test knob of system layer 1/2 error recovery */
 static int mt7915_ser_trigger_set(void *data, u64 val)
 {
@@ -355,6 +381,8 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 				    mt7915_queues_acq);
 	debugfs_create_file("tx_stats", 0400, dir, dev, &fops_tx_stats);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
+	debugfs_create_file("implicit_txbf", 0600, dir, dev,
+			    &fops_implicit_txbf);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
 	/* test knobs */
 	debugfs_create_file("radar_trigger", 0200, dir, dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 255ccd7e3d27..cb501c5dc1cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -169,18 +169,12 @@ static int mt7915_txbf_init(struct mt7915_dev *dev)
 {
 	int ret;
 
-	/*
-	 * TODO: DBDC & check whether iBF phase calibration data has
-	 * been stored in eeprom offset 0x651~0x7b8, then write down
-	 * 0x1111 into 0x651 and 0x651 to trigger iBF.
-	 */
-
 	/* trigger sounding packets */
 	ret = mt7915_mcu_set_txbf_sounding(dev);
 	if (ret)
 		return ret;
 
-	/* enable iBF & eBF */
+	/* enable eBF */
 	return mt7915_mcu_set_txbf_type(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c79f3937f6ae..fca34322ed58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1729,6 +1729,7 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 static void
 mt7915_mcu_sta_sounding_rate(struct sta_rec_bf *bf)
 {
+	bf->bf_cap = MT_EBF;
 	bf->sounding_phy = MT_PHY_TYPE_OFDM;
 	bf->ndp_rate = 0;				/* mcs0 */
 	bf->ndpa_rate = MT7915_CFEND_RATE_DEFAULT;	/* ofdm 24m */
@@ -1736,13 +1737,14 @@ mt7915_mcu_sta_sounding_rate(struct sta_rec_bf *bf)
 }
 
 static void
-mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct sta_rec_bf *bf)
+mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
+		       struct sta_rec_bf *bf)
 {
 	struct ieee80211_mcs_info *mcs = &sta->ht_cap.mcs;
 	u8 n = 0;
 
 	bf->tx_mode = MT_PHY_TYPE_HT;
-	bf->bf_cap |= MT_IBF;
+	bf->bf_cap = MT_IBF;
 
 	if (mcs->tx_params & IEEE80211_HT_MCS_TX_RX_DIFF &&
 	    (mcs->tx_params & IEEE80211_HT_MCS_TX_DEFINED))
@@ -1755,43 +1757,46 @@ mt7915_mcu_sta_bfer_ht(struct ieee80211_sta *sta, struct sta_rec_bf *bf)
 	else if (mcs->rx_mask[1])
 		n = 1;
 
+	bf->nr = hweight8(phy->chainmask) - 1;
 	bf->nc = min_t(u8, bf->nr, n);
-	bf->ibf_ncol = bf->nc;
-
-	if (sta->bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->nc)
-		bf->ibf_timeout = 0x48;
+	bf->ibf_ncol = n;
 }
 
 static void
 mt7915_mcu_sta_bfer_vht(struct ieee80211_sta *sta, struct mt7915_phy *phy,
-			struct sta_rec_bf *bf)
+			struct sta_rec_bf *bf, bool explicit)
 {
 	struct ieee80211_sta_vht_cap *pc = &sta->vht_cap;
 	struct ieee80211_sta_vht_cap *vc = &phy->mt76->sband_5g.sband.vht_cap;
-	u8 bfee_nr, bfer_nr, n, tx_ant = hweight8(phy->chainmask) - 1;
-	u16 mcs_map;
+	u16 mcs_map = le16_to_cpu(pc->vht_mcs.rx_mcs_map);
+	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
+	u8 tx_ant = hweight8(phy->chainmask) - 1;
 
 	bf->tx_mode = MT_PHY_TYPE_VHT;
-	bf->bf_cap |= MT_EBF;
 
-	mt7915_mcu_sta_sounding_rate(bf);
+	if (explicit) {
+		u8 bfee_nr, bfer_nr;
 
-	bfee_nr = FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
-			    pc->cap);
-	bfer_nr = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
-			    vc->cap);
-	mcs_map = le16_to_cpu(pc->vht_mcs.rx_mcs_map);
+		mt7915_mcu_sta_sounding_rate(bf);
+		bfee_nr = FIELD_GET(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK,
+				    pc->cap);
+		bfer_nr = FIELD_GET(IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK,
+				    vc->cap);
+		bf->nr = min_t(u8, min_t(u8, bfer_nr, bfee_nr), tx_ant);
+		bf->nc = min_t(u8, nss_mcs, bf->nr);
+		bf->ibf_ncol = bf->nc;
 
-	n = min_t(u8, bfer_nr, bfee_nr);
-	bf->nr = min_t(u8, n, tx_ant);
-	n = mt7915_mcu_get_sta_nss(mcs_map);
-
-	bf->nc = min_t(u8, n, bf->nr);
-	bf->ibf_ncol = bf->nc;
+		if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
+			bf->nr = 1;
+	} else {
+		bf->bf_cap = MT_IBF;
+		bf->nr = tx_ant;
+		bf->nc = min_t(u8, nss_mcs, bf->nr);
+		bf->ibf_ncol = nss_mcs;
 
-	/* force nr from 4 to 2 */
-	if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
-		bf->nr = 1;
+		if (sta->bandwidth == IEEE80211_STA_RX_BW_160)
+			bf->ibf_nrow = 1;
+	}
 }
 
 static void
@@ -1800,19 +1805,14 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 {
 	struct ieee80211_sta_he_cap *pc = &sta->he_cap;
 	struct ieee80211_he_cap_elem *pe = &pc->he_cap_elem;
-	const struct ieee80211_he_cap_elem *ve;
-	const struct ieee80211_sta_he_cap *vc;
-	u8 bfee_nr, bfer_nr, nss_mcs;
-	u16 mcs_map;
-
-	vc = mt7915_get_he_phy_cap(phy, vif);
-	ve = &vc->he_cap_elem;
+	const struct ieee80211_sta_he_cap *vc = mt7915_get_he_phy_cap(phy, vif);
+	const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
+	u16 mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.rx_mcs_80);
+	u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
+	u8 bfee_nr, bfer_nr;
 
 	bf->tx_mode = MT_PHY_TYPE_HE_SU;
-	bf->bf_cap |= MT_EBF;
-
 	mt7915_mcu_sta_sounding_rate(bf);
-
 	bf->trigger_su = HE_PHY(CAP6_TRIG_SU_BEAMFORMER_FB,
 				pe->phy_cap_info[6]);
 	bf->trigger_mu = HE_PHY(CAP6_TRIG_MU_BEAMFORMER_FB,
@@ -1821,10 +1821,6 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 			 ve->phy_cap_info[5]);
 	bfee_nr = HE_PHY(CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK,
 			 pe->phy_cap_info[4]);
-
-	mcs_map = le16_to_cpu(pc->he_mcs_nss_supp.tx_mcs_80);
-	nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
-
 	bf->nr = min_t(u8, bfer_nr, bfee_nr);
 	bf->nc = min_t(u8, nss_mcs, bf->nr);
 	bf->ibf_ncol = bf->nc;
@@ -1863,7 +1859,7 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
 static void
 mt7915_mcu_sta_bfer_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 			struct ieee80211_vif *vif, struct mt7915_phy *phy,
-			bool enable)
+			bool enable, bool explicit)
 {
 	struct sta_rec_bf *bf;
 	struct tlv *tlv;
@@ -1885,19 +1881,29 @@ mt7915_mcu_sta_bfer_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		return;
 	}
 
+	/* he: eBF only, in accordance with spec
+	 * vht: support eBF and iBF
+	 * ht: iBF only, since mac80211 lacks of eBF support
+	 */
+	if (sta->he_cap.has_he && explicit)
+		mt7915_mcu_sta_bfer_he(sta, vif, phy, bf);
+	else if (sta->vht_cap.vht_supported)
+		mt7915_mcu_sta_bfer_vht(sta, phy, bf, explicit);
+	else if (sta->ht_cap.ht_supported)
+		mt7915_mcu_sta_bfer_ht(sta, phy, bf);
+	else
+		return;
+
 	bf->bw = sta->bandwidth;
 	bf->ibf_dbw = sta->bandwidth;
 	bf->ibf_nrow = tx_ant;
-	bf->ibf_timeout = 0x18;
 
-	if (sta->he_cap.has_he)
-		mt7915_mcu_sta_bfer_he(sta, vif, phy, bf);
-	else if (sta->vht_cap.vht_supported)
-		mt7915_mcu_sta_bfer_vht(sta, phy, bf);
-	else if (sta->ht_cap.ht_supported)
-		mt7915_mcu_sta_bfer_ht(sta, bf);
+	if (!explicit && sta->bandwidth <= IEEE80211_STA_RX_BW_40 && !bf->nc)
+		bf->ibf_timeout = 0x48;
+	else
+		bf->ibf_timeout = 0x18;
 
-	if (bf->bf_cap & MT_EBF && bf->nr != tx_ant)
+	if (explicit && bf->nr != tx_ant)
 		bf->mem_20m = matrix[tx_ant][bf->nc];
 	else
 		bf->mem_20m = matrix[bf->nr][bf->nc];
@@ -1995,14 +2001,14 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	/* must keep each tag independent */
 
 	/* starec bf */
-	if (ebf) {
+	if (ebf || dev->ibf) {
 		len = sizeof(struct sta_req_hdr) + sizeof(struct sta_rec_bf);
 
 		skb = mt7915_mcu_alloc_sta_req(dev, mvif, msta, len);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
-		mt7915_mcu_sta_bfer_tlv(skb, sta, vif, phy, enable);
+		mt7915_mcu_sta_bfer_tlv(skb, sta, vif, phy, enable, ebf);
 
 		r = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 					  MCU_EXT_CMD_STA_REC_UPDATE, true);
@@ -3435,7 +3441,7 @@ int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev)
 	} __packed req = {
 		.action = MT_BF_TYPE_UPDATE,
 		.ebf = true,
-		.ibf = false,
+		.ibf = dev->ibf,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXBF_ACTION, &req,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index df7ac2cf052f..63ad1f8199f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -191,6 +191,7 @@ struct mt7915_dev {
 	bool dbdc_support;
 	bool flash_mode;
 	bool fw_debug;
+	bool ibf;
 };
 
 enum {
-- 
2.18.0

