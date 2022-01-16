Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B5E48FCD1
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiAPMoE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiAPMoE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:44:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3CC061574
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 04:44:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49680B80CBB
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 12:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE12AC36AEC;
        Sun, 16 Jan 2022 12:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642337041;
        bh=nAn4feF3xhJJOftXimxES6qkQSnNnyWczAf4JZk6IAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scg/uQ6G4LEcR61Vh82QDGhLM7JPCQssrTyUiuzT9DvRKhznQ97VdXrC/5+P22E8a
         xys+HHbNn08izbXuWoLq7z6+bIIZkw9IF4gSyRg9ZAXRZrLKxYLdGIroNyHcnRBOOY
         G1hjKrx93sxXlbOCx5TvrGbyEHlR4h9oVA924KteTiyxrNK6vgtaYeUiNzbLWCD9lM
         v+t0kortM4ZqwXF6shWR5mV3MKrycOuhdxOQv8p54Y2z7tyi5EFPhY+yrSY1MJPmOf
         R40fgpoHB0c7XEmuZ+GlZJ8ZRHCpbVOzEVOkrrMWmG/Burwo5Hqh3tPEaRtchOcdIq
         SV54e7U7fePDA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 4/5] mt76: connac: move he radiotap parsing in connac module
Date:   Sun, 16 Jan 2022 13:43:17 +0100
Message-Id: <dcd7e4a9f10b1f0c94050453e4de4e1443fbc642.1642336806.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642336806.git.lorenzo@kernel.org>
References: <cover.1642336806.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move HE radiotap parsing code in mt76-connac module since it is shared
between mt7921 and mt7915 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   2 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 168 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.h  |   4 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 175 +----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 182 +-----------------
 5 files changed, 176 insertions(+), 355 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 04fa8706e7f1..c4e898038acc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -242,5 +242,7 @@ void mt76_connac_pm_dequeue_skbs(struct mt76_phy *phy,
 int mt76_connac_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_offset,
 					struct ieee80211_sta *sta,
 					struct ieee80211_vif *vif);
+void mt76_connac_mac_decode_he_radiotap(struct sk_buff *skb,
+					__le32 *rxv, u32 mode);
 
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 78864252b782..fbc5caa02259 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -183,3 +183,171 @@ int mt76_connac_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_offset,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_connac_reverse_frag0_hdr_trans);
+
+static void
+mt76_connac_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
+				      struct ieee80211_radiotap_he *he,
+				      __le32 *rxv)
+{
+	u32 ru_h, ru_l;
+	u8 ru, offs = 0;
+
+	ru_l = FIELD_GET(MT_PRXV_HE_RU_ALLOC_L, le32_to_cpu(rxv[0]));
+	ru_h = FIELD_GET(MT_PRXV_HE_RU_ALLOC_H, le32_to_cpu(rxv[1]));
+	ru = (u8)(ru_l | ru_h << 4);
+
+	status->bw = RATE_INFO_BW_HE_RU;
+
+	switch (ru) {
+	case 0 ... 36:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		offs = ru;
+		break;
+	case 37 ... 52:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		offs = ru - 37;
+		break;
+	case 53 ... 60:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		offs = ru - 53;
+		break;
+	case 61 ... 64:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		offs = ru - 61;
+		break;
+	case 65 ... 66:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		offs = ru - 65;
+		break;
+	case 67:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case 68:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	}
+
+	he->data1 |= HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+	he->data2 |= HE_BITS(DATA2_RU_OFFSET_KNOWN) |
+		     le16_encode_bits(offs,
+				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
+}
+
+#define MU_PREP(f, v)	le16_encode_bits(v, IEEE80211_RADIOTAP_HE_MU_##f)
+static void
+mt76_connac_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static const struct ieee80211_radiotap_he_mu mu_known = {
+		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
+			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_COMP_KNOWN),
+		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN) |
+			  HE_BITS(MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN),
+	};
+	struct ieee80211_radiotap_he_mu *he_mu;
+
+	status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+
+	he_mu = skb_push(skb, sizeof(mu_known));
+	memcpy(he_mu, &mu_known, sizeof(mu_known));
+
+	he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_MCS, status->rate_idx);
+	if (status->he_dcm)
+		he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_DCM, status->he_dcm);
+
+	he_mu->flags2 |= MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status->bw) |
+			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
+				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
+
+	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
+
+	if (status->bw >= RATE_INFO_BW_40) {
+		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
+		he_mu->ru_ch2[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
+	}
+
+	if (status->bw >= RATE_INFO_BW_80) {
+		he_mu->ru_ch1[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
+		he_mu->ru_ch2[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
+	}
+}
+
+void mt76_connac_mac_decode_he_radiotap(struct sk_buff *skb,
+					__le32 *rxv, u32 mode)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static const struct ieee80211_radiotap_he known = {
+		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
+			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
+			 HE_BITS(DATA1_STBC_KNOWN) |
+			 HE_BITS(DATA1_CODING_KNOWN) |
+			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
+			 HE_BITS(DATA1_DOPPLER_KNOWN) |
+			 HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
+			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
+		.data2 = HE_BITS(DATA2_GI_KNOWN) |
+			 HE_BITS(DATA2_TXBF_KNOWN) |
+			 HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
+			 HE_BITS(DATA2_TXOP_KNOWN),
+	};
+	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
+	struct ieee80211_radiotap_he *he;
+
+	status->flag |= RX_FLAG_RADIOTAP_HE;
+
+	he = skb_push(skb, sizeof(known));
+	memcpy(he, &known, sizeof(known));
+
+	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
+		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
+	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
+	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
+		    le16_encode_bits(ltf_size,
+				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
+	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
+		he->data5 |= HE_BITS(DATA5_TXBF);
+	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
+		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
+
+	switch (mode) {
+	case MT_PHY_TYPE_HE_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN);
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_EXT_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN);
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_MU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN);
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
+
+		mt76_connac_mac_decode_he_radiotap_ru(status, he, rxv);
+		mt76_connac_mac_decode_he_mu_radiotap(skb, rxv);
+		break;
+	case MT_PHY_TYPE_HE_TB:
+		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
+			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
+
+		mt76_connac_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mac_decode_he_radiotap);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.h
index 0c73875ba9a6..cf54d3efa020 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.h
@@ -4,6 +4,10 @@
 #ifndef __MT76_CONNAC_MAC_H
 #define __MT76_CONNAC_MAC_H
 
+#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
+#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
+						 IEEE80211_RADIOTAP_HE_##f)
+
 #define MT_CT_PARSE_LEN			72
 #define MT_CT_DMA_BUF_NUM		2
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 121ac5b59107..b130bebfdda7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -10,10 +10,6 @@
 
 #define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
 
-#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
-#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
-						 IEEE80211_RADIOTAP_HE_##f)
-
 static const struct mt7915_dfs_radar_spec etsi_radar_specs = {
 	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
 	.radar_pattern = {
@@ -218,175 +214,6 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 	rcu_read_unlock();
 }
 
-static void
-mt7915_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
-				 struct ieee80211_radiotap_he *he,
-				 __le32 *rxv)
-{
-	u32 ru_h, ru_l;
-	u8 ru, offs = 0;
-
-	ru_l = FIELD_GET(MT_PRXV_HE_RU_ALLOC_L, le32_to_cpu(rxv[0]));
-	ru_h = FIELD_GET(MT_PRXV_HE_RU_ALLOC_H, le32_to_cpu(rxv[1]));
-	ru = (u8)(ru_l | ru_h << 4);
-
-	status->bw = RATE_INFO_BW_HE_RU;
-
-	switch (ru) {
-	case 0 ... 36:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
-		offs = ru;
-		break;
-	case 37 ... 52:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
-		offs = ru - 37;
-		break;
-	case 53 ... 60:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
-		offs = ru - 53;
-		break;
-	case 61 ... 64:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
-		offs = ru - 61;
-		break;
-	case 65 ... 66:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
-		offs = ru - 65;
-		break;
-	case 67:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
-		break;
-	case 68:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
-		break;
-	}
-
-	he->data1 |= HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
-	he->data2 |= HE_BITS(DATA2_RU_OFFSET_KNOWN) |
-		     le16_encode_bits(offs,
-				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
-}
-
-static void
-mt7915_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
-{
-	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	static const struct ieee80211_radiotap_he_mu mu_known = {
-		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
-			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
-			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
-			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN),
-		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
-	};
-	struct ieee80211_radiotap_he_mu *he_mu = NULL;
-
-	status->flag |= RX_FLAG_RADIOTAP_HE_MU;
-
-	he_mu = skb_push(skb, sizeof(mu_known));
-	memcpy(he_mu, &mu_known, sizeof(mu_known));
-
-#define MU_PREP(f, v)	le16_encode_bits(v, IEEE80211_RADIOTAP_HE_MU_##f)
-
-	he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_MCS, status->rate_idx);
-	if (status->he_dcm)
-		he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_DCM, status->he_dcm);
-
-	he_mu->flags2 |= MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status->bw) |
-			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
-				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
-
-	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
-
-	if (status->bw >= RATE_INFO_BW_40) {
-		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
-		he_mu->ru_ch2[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
-	}
-
-	if (status->bw >= RATE_INFO_BW_80) {
-		he_mu->ru_ch1[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
-		he_mu->ru_ch2[1] = le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
-	}
-}
-
-static void
-mt7915_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u32 mode)
-{
-	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	static const struct ieee80211_radiotap_he known = {
-		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
-			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
-			 HE_BITS(DATA1_STBC_KNOWN) |
-			 HE_BITS(DATA1_CODING_KNOWN) |
-			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
-			 HE_BITS(DATA1_DOPPLER_KNOWN) |
-			 HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
-			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
-		.data2 = HE_BITS(DATA2_GI_KNOWN) |
-			 HE_BITS(DATA2_TXBF_KNOWN) |
-			 HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
-			 HE_BITS(DATA2_TXOP_KNOWN),
-	};
-	struct ieee80211_radiotap_he *he = NULL;
-	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
-
-	status->flag |= RX_FLAG_RADIOTAP_HE;
-
-	he = skb_push(skb, sizeof(known));
-	memcpy(he, &known, sizeof(known));
-
-	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
-		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
-	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
-	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
-		    le16_encode_bits(ltf_size,
-				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
-	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
-		he->data5 |= HE_BITS(DATA5_TXBF);
-	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
-		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
-
-	switch (mode) {
-	case MT_PHY_TYPE_HE_SU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN) |
-			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
-			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		break;
-	case MT_PHY_TYPE_HE_EXT_SU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		break;
-	case MT_PHY_TYPE_HE_MU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
-
-		mt7915_mac_decode_he_radiotap_ru(status, he, rxv);
-		mt7915_mac_decode_he_mu_radiotap(skb, rxv);
-		break;
-	case MT_PHY_TYPE_HE_TB:
-		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
-			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
-			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
-			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
-
-		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
-
-		mt7915_mac_decode_he_radiotap_ru(status, he, rxv);
-		break;
-	default:
-		break;
-	}
-}
-
 static int
 mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 			struct mt76_rx_status *status,
@@ -770,7 +597,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
-		mt7915_mac_decode_he_radiotap(skb, rxv, mode);
+		mt76_connac_mac_decode_he_radiotap(skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 74ebd518b8f4..491eaa67be52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -9,10 +9,6 @@
 #include "mac.h"
 #include "mcu.h"
 
-#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
-#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
-						 IEEE80211_RADIOTAP_HE_##f)
-
 static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
 					    u16 idx, bool unicast)
 {
@@ -168,182 +164,6 @@ void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_poll);
 
-static void
-mt7921_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
-				 struct ieee80211_radiotap_he *he,
-				 __le32 *rxv)
-{
-	u32 ru_h, ru_l;
-	u8 ru, offs = 0;
-
-	ru_l = FIELD_GET(MT_PRXV_HE_RU_ALLOC_L, le32_to_cpu(rxv[0]));
-	ru_h = FIELD_GET(MT_PRXV_HE_RU_ALLOC_H, le32_to_cpu(rxv[1]));
-	ru = (u8)(ru_l | ru_h << 4);
-
-	status->bw = RATE_INFO_BW_HE_RU;
-
-	switch (ru) {
-	case 0 ... 36:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
-		offs = ru;
-		break;
-	case 37 ... 52:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
-		offs = ru - 37;
-		break;
-	case 53 ... 60:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
-		offs = ru - 53;
-		break;
-	case 61 ... 64:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
-		offs = ru - 61;
-		break;
-	case 65 ... 66:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
-		offs = ru - 65;
-		break;
-	case 67:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
-		break;
-	case 68:
-		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
-		break;
-	}
-
-	he->data1 |= HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
-	he->data2 |= HE_BITS(DATA2_RU_OFFSET_KNOWN) |
-		     le16_encode_bits(offs,
-				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
-}
-
-static void
-mt7921_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
-{
-	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	static const struct ieee80211_radiotap_he_mu mu_known = {
-		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
-			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
-			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
-			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN) |
-			  HE_BITS(MU_FLAGS1_SIG_B_COMP_KNOWN),
-		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN) |
-			  HE_BITS(MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN),
-	};
-	struct ieee80211_radiotap_he_mu *he_mu;
-
-	status->flag |= RX_FLAG_RADIOTAP_HE_MU;
-
-	he_mu = skb_push(skb, sizeof(mu_known));
-	memcpy(he_mu, &mu_known, sizeof(mu_known));
-
-#define MU_PREP(f, v)	le16_encode_bits(v, IEEE80211_RADIOTAP_HE_MU_##f)
-
-	he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_MCS, status->rate_idx);
-	if (status->he_dcm)
-		he_mu->flags1 |= MU_PREP(FLAGS1_SIG_B_DCM, status->he_dcm);
-
-	he_mu->flags2 |= MU_PREP(FLAGS2_BW_FROM_SIG_A_BW, status->bw) |
-			 MU_PREP(FLAGS2_SIG_B_SYMS_USERS,
-				 le32_get_bits(rxv[2], MT_CRXV_HE_NUM_USER));
-
-	he_mu->ru_ch1[0] = FIELD_GET(MT_CRXV_HE_RU0, le32_to_cpu(rxv[3]));
-
-	if (status->bw >= RATE_INFO_BW_40) {
-		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
-		he_mu->ru_ch2[0] =
-			FIELD_GET(MT_CRXV_HE_RU1, le32_to_cpu(rxv[3]));
-	}
-
-	if (status->bw >= RATE_INFO_BW_80) {
-		he_mu->ru_ch1[1] =
-			FIELD_GET(MT_CRXV_HE_RU2, le32_to_cpu(rxv[3]));
-		he_mu->ru_ch2[1] =
-			FIELD_GET(MT_CRXV_HE_RU3, le32_to_cpu(rxv[3]));
-	}
-}
-
-static void
-mt7921_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u32 mode)
-{
-	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	static const struct ieee80211_radiotap_he known = {
-		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
-			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
-			 HE_BITS(DATA1_STBC_KNOWN) |
-			 HE_BITS(DATA1_CODING_KNOWN) |
-			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
-			 HE_BITS(DATA1_DOPPLER_KNOWN) |
-			 HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
-			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
-		.data2 = HE_BITS(DATA2_GI_KNOWN) |
-			 HE_BITS(DATA2_TXBF_KNOWN) |
-			 HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
-			 HE_BITS(DATA2_TXOP_KNOWN),
-	};
-	struct ieee80211_radiotap_he *he = NULL;
-	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
-
-	status->flag |= RX_FLAG_RADIOTAP_HE;
-
-	he = skb_push(skb, sizeof(known));
-	memcpy(he, &known, sizeof(known));
-
-	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
-		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
-	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
-	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
-		    le16_encode_bits(ltf_size,
-				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
-	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
-		he->data5 |= HE_BITS(DATA5_TXBF);
-	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
-		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
-
-	switch (mode) {
-	case MT_PHY_TYPE_HE_SU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN) |
-			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
-			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		he->data4 |= HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
-		break;
-	case MT_PHY_TYPE_HE_EXT_SU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		break;
-	case MT_PHY_TYPE_HE_MU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
-
-		mt7921_mac_decode_he_radiotap_ru(status, he, rxv);
-		mt7921_mac_decode_he_mu_radiotap(skb, rxv);
-		break;
-	case MT_PHY_TYPE_HE_TB:
-		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
-			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
-			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
-			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
-
-		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
-
-		mt7921_mac_decode_he_radiotap_ru(status, he, rxv);
-		break;
-	default:
-		break;
-	}
-}
-
 static void
 mt7921_get_status_freq_info(struct mt7921_dev *dev, struct mt76_phy *mphy,
 			    struct mt76_rx_status *status, u8 chfreq)
@@ -730,7 +550,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	mt7921_mac_assoc_rssi(dev, skb);
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
-		mt7921_mac_decode_he_radiotap(skb, rxv, mode);
+		mt76_connac_mac_decode_he_radiotap(skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
-- 
2.34.1

