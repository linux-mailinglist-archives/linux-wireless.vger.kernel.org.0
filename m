Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2031142E746
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 05:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhJODeF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 23:34:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60826 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234202AbhJODeE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 23:34:04 -0400
X-UUID: bb348a77526c435a86ae5c7de0b74eb7-20211015
X-UUID: bb348a77526c435a86ae5c7de0b74eb7-20211015
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1977903550; Fri, 15 Oct 2021 11:31:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 Oct 2021 11:31:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Oct 2021 11:31:56 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7915: enable HE UL MU-MIMO
Date:   Fri, 15 Oct 2021 11:31:44 +0800
Message-ID: <20211015033145.8738-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable HE UL MU-MIMO in sta_rec_muru, which works on both ap and station
mode.

For sending trigger frames, one of the conditions fw uses is to check if
mib rx airtime meets the threshold.
There's a main control of mib rx airtime report register in fw, so we
need to enable the register by mcu cmd instead of directly writing it,
otherwise it will still be disabled by fw.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2: refine mt7915_mcu_sta_muru_tlv()
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 -
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 79 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  1 -
 4 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index a269808..7f76907 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -389,8 +389,6 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	      FIELD_PREP(MT_MDP_RCFR1_RX_DROPPED_MCAST, MT_MDP_TO_HIF);
 	mt76_rmw(dev, MT_MDP_BNRCFR1(band), mask, set);
 
-	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(band), MT_WF_RMAC_MIB_RXTIME_EN);
-
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
 	/* disable rx rate report by default due to hw issues */
 	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 92e4f9d..e4da804 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1520,13 +1520,12 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	struct sta_rec_muru *muru;
 	struct tlv *tlv;
 
-	if (!sta->vht_cap.vht_supported && !sta->he_cap.has_he)
+	if (!sta->vht_cap.vht_supported)
 		return;
 
 	tlv = mt7915_mcu_add_tlv(skb, STA_REC_MURU, sizeof(*muru));
 
 	muru = (struct sta_rec_muru *)tlv;
-	muru->cfg.ofdma_dl_en = true;
 
 	/* A non-AP HE station must support MU beamformee */
 	muru->cfg.mimo_dl_en = (vif->type == NL80211_IFTYPE_STATION &&
@@ -1535,6 +1534,22 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 			       mvif->cap.vht_mu_ebfer ||
 			       mvif->cap.vht_mu_ebfee;
 
+	muru->mimo_dl.vht_mu_bfee =
+		!!(sta->vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+
+	if (!sta->he_cap.has_he)
+		return;
+
+	muru->mimo_dl.partial_bw_dl_mimo =
+		HE_PHY(CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO, elem->phy_cap_info[6]);
+
+	muru->cfg.mimo_ul_en = true;
+	muru->mimo_ul.full_ul_mimo =
+		HE_PHY(CAP2_UL_MU_FULL_MU_MIMO, elem->phy_cap_info[2]);
+	muru->mimo_ul.partial_ul_mimo =
+		HE_PHY(CAP2_UL_MU_PARTIAL_MU_MIMO, elem->phy_cap_info[2]);
+
+	muru->cfg.ofdma_dl_en = true;
 	muru->ofdma_dl.punc_pream_rx =
 		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
 	muru->ofdma_dl.he_20m_in_40m_2g =
@@ -1543,9 +1558,6 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		HE_PHY(CAP8_20MHZ_IN_160MHZ_HE_PPDU, elem->phy_cap_info[8]);
 	muru->ofdma_dl.he_80m_in_160m =
 		HE_PHY(CAP8_80MHZ_IN_160MHZ_HE_PPDU, elem->phy_cap_info[8]);
-	muru->ofdma_dl.lt16_sigb = 0;
-	muru->ofdma_dl.rx_su_comp_sigb = 0;
-	muru->ofdma_dl.rx_su_non_comp_sigb = 0;
 
 	muru->ofdma_ul.t_frame_dur =
 		HE_MAC(CAP1_TF_MAC_PAD_DUR_MASK, elem->mac_cap_info[1]);
@@ -1553,18 +1565,6 @@ mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		HE_MAC(CAP2_MU_CASCADING, elem->mac_cap_info[2]);
 	muru->ofdma_ul.uo_ra =
 		HE_MAC(CAP3_OFDMA_RA, elem->mac_cap_info[3]);
-	muru->ofdma_ul.he_2x996_tone = 0;
-	muru->ofdma_ul.rx_t_frame_11ac = 0;
-
-	muru->mimo_dl.vht_mu_bfee =
-		!!(sta->vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
-	muru->mimo_dl.partial_bw_dl_mimo =
-		HE_PHY(CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO, elem->phy_cap_info[6]);
-
-	muru->mimo_ul.full_ul_mimo =
-		HE_PHY(CAP2_UL_MU_FULL_MU_MIMO, elem->phy_cap_info[2]);
-	muru->mimo_ul.partial_ul_mimo =
-		HE_PHY(CAP2_UL_MU_PARTIAL_MU_MIMO, elem->phy_cap_info[2]);
 }
 
 static void
@@ -2922,6 +2922,47 @@ int mt7915_mcu_set_muru_ctrl(struct mt7915_dev *dev, u32 cmd, u32 val)
 				 sizeof(req), false);
 }
 
+static int
+mt7915_mcu_init_rx_airtime(struct mt7915_dev *dev)
+{
+#define RX_AIRTIME_FEATURE_CTRL		1
+#define RX_AIRTIME_BITWISE_CTRL		2
+#define RX_AIRTIME_CLEAR_EN	1
+	struct {
+		__le16 field;
+		__le16 sub_field;
+		__le32 set_status;
+		__le32 get_status;
+		u8 _rsv[12];
+
+		bool airtime_en;
+		bool mibtime_en;
+		bool earlyend_en;
+		u8 _rsv1[9];
+
+		bool airtime_clear;
+		bool mibtime_clear;
+		u8 _rsv2[98];
+	} __packed req = {
+		.field = cpu_to_le16(RX_AIRTIME_BITWISE_CTRL),
+		.sub_field = cpu_to_le16(RX_AIRTIME_CLEAR_EN),
+		.airtime_clear = true,
+	};
+	int ret;
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RX_AIRTIME_CTRL), &req,
+				sizeof(req), true);
+	if (ret)
+		return ret;
+
+	req.field = cpu_to_le16(RX_AIRTIME_FEATURE_CTRL);
+	req.sub_field = cpu_to_le16(RX_AIRTIME_CLEAR_EN);
+	req.airtime_en = true;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RX_AIRTIME_CTRL), &req,
+				 sizeof(req), true);
+}
+
 int mt7915_mcu_init(struct mt7915_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
@@ -2956,6 +2997,10 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = mt7915_mcu_init_rx_airtime(dev);
+	if (ret)
+		return ret;
+
 	return mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
 				 MCU_WA_PARAM_RED, 0, 0);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index bc9f350..91bf421 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -271,6 +271,7 @@ enum {
 	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
 	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
 	MCU_EXT_CMD_MUAR_UPDATE = 0x48,
+	MCU_EXT_CMD_RX_AIRTIME_CTRL = 0x4a,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
 	MCU_EXT_CMD_GET_MIB_INFO = 0x5a,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 6c487c4..99574ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -364,7 +364,6 @@
 
 #define MT_WF_RMAC_MIB_AIRTIME0(_band)	MT_WF_RMAC(_band, 0x0380)
 #define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
-#define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
 
 /* WFDMA0 */
 #define MT_WFDMA0_BASE			0xd4000
-- 
2.25.1

