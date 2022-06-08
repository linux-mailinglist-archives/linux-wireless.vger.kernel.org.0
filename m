Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB28543A74
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiFHRbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiFHRbI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 13:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F225E
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 10:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED6FD61B39
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 17:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0058C3411D;
        Wed,  8 Jun 2022 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654709464;
        bh=x0+mxRosk5DQk+T5jAKidRYIG4qiaJNmqrIjwOg8r9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOnoS1Kkv14XQZLXkzcoVFR5qgoG7Ng37ld0e4rO+JCrC0J3RLKELU4B5bvyBOwhT
         87BbyyZze0zqRQvH6qUGjfg0UED8sGYtjYF8idyTuwTNeP3wAMxUGqpWkQSCNQbTVq
         hzbSYKcLOBUZ0WAWFnpBvc/NIp3gJizBd+sWth+jzrh25jWhUL/Az2KnDF7Rrul7DH
         O8k4eYJKFyU3P86IWSgTq4zloJnJSMW1z7MT1H6gZ2VRLYmspqlLc6D2iTqZsuCu/2
         8AEEXXrUxWjROenh3E11tOoYHfkd+r8j1QTp0eHiecqkEt0xCm0RreM6VHYq6Bp+XE
         TkRYSdTqxq6UA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 1/3] mt76: connac: move HE radiotap parsing in connac module
Date:   Wed,  8 Jun 2022 19:30:29 +0200
Message-Id: <7dfc09b781d775002b8e33eaf8b19689afca905b.1654709072.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654709072.git.lorenzo@kernel.org>
References: <cover.1654709072.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HE radiotap parsing code is shared between connac2 devices.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   3 +
 .../wireless/mediatek/mt76/mt76_connac2_mac.h |  56 ++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 187 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 180 +----------------
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  52 -----
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 187 +-----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  52 -----
 7 files changed, 251 insertions(+), 466 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 6b8d6c5d621a..c06a320b53bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -253,5 +253,8 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 				  int pid, __le32 *txs_data,
 				  struct mt76_sta_stats *stats);
+void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
+					 struct sk_buff *skb,
+					 __le32 *rxv, u32 mode);
 
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index c9d9c8475a38..f2de2f6d04a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -164,4 +164,60 @@ enum {
 
 #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
 
+/* P-RXV DW0 */
+#define MT_PRXV_TX_RATE			GENMASK(6, 0)
+#define MT_PRXV_TX_DCM			BIT(4)
+#define MT_PRXV_TX_ER_SU_106T		BIT(5)
+#define MT_PRXV_NSTS			GENMASK(9, 7)
+#define MT_PRXV_TXBF			BIT(10)
+#define MT_PRXV_HT_AD_CODE		BIT(11)
+#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
+
+#define MT_PRXV_FRAME_MODE		GENMASK(14, 12)
+#define MT_PRXV_HT_SGI			GENMASK(16, 15)
+#define MT_PRXV_HT_STBC			GENMASK(23, 22)
+#define MT_PRXV_TX_MODE			GENMASK(27, 24)
+#define MT_PRXV_DCM			BIT(17)
+#define MT_PRXV_NUM_RX			BIT(20, 18)
+
+/* P-RXV DW1 */
+#define MT_PRXV_RCPI3			GENMASK(31, 24)
+#define MT_PRXV_RCPI2			GENMASK(23, 16)
+#define MT_PRXV_RCPI1			GENMASK(15, 8)
+#define MT_PRXV_RCPI0			GENMASK(7, 0)
+#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
+
+/* C-RXV */
+#define MT_CRXV_HT_STBC			GENMASK(1, 0)
+#define MT_CRXV_TX_MODE			GENMASK(7, 4)
+#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
+#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
+#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
+#define MT_CRXV_HE_UPLINK		BIT(31)
+
+#define MT_CRXV_HE_RU0			GENMASK(7, 0)
+#define MT_CRXV_HE_RU1			GENMASK(15, 8)
+#define MT_CRXV_HE_RU2			GENMASK(23, 16)
+#define MT_CRXV_HE_RU3			GENMASK(31, 24)
+
+#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
+
+#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
+#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
+#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
+#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
+
+#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
+#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
+#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
+#define MT_CRXV_HE_DOPPLER		BIT(16)
+
+#define MT_CRXV_SNR		GENMASK(18, 13)
+#define MT_CRXV_FOE_LO		GENMASK(31, 19)
+#define MT_CRXV_FOE_HI		GENMASK(6, 0)
+#define MT_CRXV_FOE_SHIFT	13
+
 #endif /* __MT76_CONNAC2_MAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 3f2680b8c2c2..08cd2e1d8625 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -4,6 +4,10 @@
 #include "mt76_connac.h"
 #include "mt76_connac2_mac.h"
 
+#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
+#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
+						 IEEE80211_RADIOTAP_HE_##f)
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 {
 	struct mt76_dev *dev = phy->dev;
@@ -521,3 +525,186 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	return !!skb;
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_add_txs_skb);
+
+static void
+mt76_connac2_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
+				       struct ieee80211_radiotap_he *he,
+				       __le32 *rxv)
+{
+	u32 ru_h, ru_l;
+	u8 ru, offs = 0;
+
+	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
+	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
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
+static void
+mt76_connac2_mac_decode_he_mu_radiotap(struct mt76_dev *dev, struct sk_buff *skb,
+				       __le32 *rxv)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static struct ieee80211_radiotap_he_mu mu_known = {
+		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
+			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN),
+		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
+	};
+	struct ieee80211_radiotap_he_mu *he_mu;
+
+	if (is_mt7921(dev)) {
+		mu_known.flags1 |= HE_BITS(MU_FLAGS1_SIG_B_COMP_KNOWN);
+		mu_known.flags2 |= HE_BITS(MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN);
+	}
+
+	status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+
+	he_mu = skb_push(skb, sizeof(mu_known));
+	memcpy(he_mu, &mu_known, sizeof(mu_known));
+
+#define MU_PREP(f, v)	le16_encode_bits(v, IEEE80211_RADIOTAP_HE_MU_##f)
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
+		he_mu->ru_ch2[0] =
+			le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
+	}
+
+	if (status->bw >= RATE_INFO_BW_80) {
+		he_mu->ru_ch1[1] =
+			le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
+		he_mu->ru_ch2[1] =
+			le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
+	}
+}
+
+void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
+					 struct sk_buff *skb,
+					 __le32 *rxv, u32 mode)
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
+			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_EXT_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_MU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[7]);
+
+		mt76_connac2_mac_decode_he_radiotap_ru(status, he, rxv);
+		mt76_connac2_mac_decode_he_mu_radiotap(dev, skb, rxv);
+		break;
+	case MT_PHY_TYPE_HE_TB:
+		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
+			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
+
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
+
+		mt76_connac2_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_decode_he_radiotap);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 428c4fd9a0a6..27b2a9edb317 100644
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
@@ -218,178 +214,6 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
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
-	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
-	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
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
-mt7915_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
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
-			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
-			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
-			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		break;
-	case MT_PHY_TYPE_HE_EXT_SU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN) |
-			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
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
-		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
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
 /* The HW does not translate the mac header to 802.3 for mesh point */
 static int mt7915_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
@@ -489,7 +313,7 @@ mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
 
 	if (!is_mt7915(&dev->mt76)) {
 		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
-		gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v0);
+		gi = FIELD_GET(MT_PRXV_HT_SGI, v0);
 		*mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
 		dcm = FIELD_GET(MT_PRXV_DCM, v0);
 		bw = FIELD_GET(MT_PRXV_FRAME_MODE, v0);
@@ -832,7 +656,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
-		mt7915_mac_decode_he_radiotap(skb, rxv, mode);
+		mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index f581ae27375b..611bf23b2eb0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -116,58 +116,6 @@ enum rx_pkt_type {
 
 #define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
 
-/* P-RXV */
-#define MT_PRXV_TX_RATE			GENMASK(6, 0)
-#define MT_PRXV_TX_DCM			BIT(4)
-#define MT_PRXV_TX_ER_SU_106T		BIT(5)
-#define MT_PRXV_NSTS			GENMASK(9, 7)
-#define MT_PRXV_TXBF			BIT(10)
-#define MT_PRXV_HT_AD_CODE		BIT(11)
-#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
-#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
-#define MT_PRXV_RCPI3			GENMASK(31, 24)
-#define MT_PRXV_RCPI2			GENMASK(23, 16)
-#define MT_PRXV_RCPI1			GENMASK(15, 8)
-#define MT_PRXV_RCPI0			GENMASK(7, 0)
-#define MT_PRXV_HT_SHORT_GI		GENMASK(16, 15)
-#define MT_PRXV_HT_STBC			GENMASK(23, 22)
-#define MT_PRXV_TX_MODE			GENMASK(27, 24)
-#define MT_PRXV_FRAME_MODE		GENMASK(14, 12)
-#define MT_PRXV_DCM			BIT(17)
-#define MT_PRXV_NUM_RX			BIT(20, 18)
-
-/* C-RXV */
-#define MT_CRXV_HT_STBC			GENMASK(1, 0)
-#define MT_CRXV_TX_MODE			GENMASK(7, 4)
-#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
-#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
-#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
-#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
-#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
-#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
-#define MT_CRXV_HE_UPLINK		BIT(31)
-#define MT_CRXV_HE_RU0			GENMASK(7, 0)
-#define MT_CRXV_HE_RU1			GENMASK(15, 8)
-#define MT_CRXV_HE_RU2			GENMASK(23, 16)
-#define MT_CRXV_HE_RU3			GENMASK(31, 24)
-
-#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
-
-#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
-#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
-#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
-#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
-
-#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
-#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
-#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
-#define MT_CRXV_HE_DOPPLER		BIT(16)
-
-#define MT_CRXV_SNR		GENMASK(18, 13)
-#define MT_CRXV_FOE_LO		GENMASK(31, 19)
-#define MT_CRXV_FOE_HI		GENMASK(6, 0)
-#define MT_CRXV_FOE_SHIFT	13
-
 enum tx_port_idx {
 	MT_TX_PORT_IDX_LMAC,
 	MT_TX_PORT_IDX_MCU
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index ccaf4d539852..4c2f62696b56 100644
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
@@ -168,183 +164,6 @@ void mt7921_mac_sta_poll(struct mt7921_dev *dev)
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
-	ru_l = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC_L);
-	ru_h = le32_get_bits(rxv[1], MT_PRXV_HE_RU_ALLOC_H);
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
-	he_mu->ru_ch1[0] = le32_get_bits(rxv[3], MT_CRXV_HE_RU0);
-
-	if (status->bw >= RATE_INFO_BW_40) {
-		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
-		he_mu->ru_ch2[0] =
-			le32_get_bits(rxv[3], MT_CRXV_HE_RU1);
-	}
-
-	if (status->bw >= RATE_INFO_BW_80) {
-		he_mu->ru_ch1[1] =
-			le32_get_bits(rxv[3], MT_CRXV_HE_RU2);
-		he_mu->ru_ch2[1] =
-			le32_get_bits(rxv[3], MT_CRXV_HE_RU3);
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
-			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
-			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
-			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
-		break;
-	case MT_PHY_TYPE_HE_EXT_SU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN) |
-			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
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
@@ -672,8 +491,8 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 					     status->chain_signal[i]);
 		}
 
-		stbc = FIELD_GET(MT_PRXV_STBC, v0);
-		gi = FIELD_GET(MT_PRXV_SGI, v0);
+		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
+		gi = FIELD_GET(MT_PRXV_HT_SGI, v0);
 		cck = false;
 
 		idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
@@ -796,7 +615,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	mt7921_mac_assoc_rssi(dev, skb);
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
-		mt7921_mac_decode_he_radiotap(skb, rxv, mode);
+		mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 556e687bd235..6e31ae7d39d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -113,58 +113,6 @@ enum rx_pkt_type {
 
 #define MT_RXD9_HT_CONTROL		GENMASK(31, 0)
 
-/* P-RXV DW0 */
-#define MT_PRXV_TX_RATE			GENMASK(6, 0)
-#define MT_PRXV_TX_DCM			BIT(4)
-#define MT_PRXV_TX_ER_SU_106T		BIT(5)
-#define MT_PRXV_NSTS			GENMASK(9, 7)
-#define MT_PRXV_TXBF			BIT(10)
-#define MT_PRXV_HT_AD_CODE		BIT(11)
-#define MT_PRXV_FRAME_MODE		GENMASK(14, 12)
-#define MT_PRXV_SGI			GENMASK(16, 15)
-#define MT_PRXV_STBC			GENMASK(23, 22)
-#define MT_PRXV_TX_MODE			GENMASK(27, 24)
-#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
-
-/* P-RXV DW1 */
-#define MT_PRXV_RCPI3			GENMASK(31, 24)
-#define MT_PRXV_RCPI2			GENMASK(23, 16)
-#define MT_PRXV_RCPI1			GENMASK(15, 8)
-#define MT_PRXV_RCPI0			GENMASK(7, 0)
-#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
-
-/* C-RXV */
-#define MT_CRXV_HT_STBC			GENMASK(1, 0)
-#define MT_CRXV_TX_MODE			GENMASK(7, 4)
-#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
-#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
-#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
-#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
-#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
-#define MT_CRXV_HE_NUM_USER		GENMASK(30, 24)
-#define MT_CRXV_HE_UPLINK		BIT(31)
-
-#define MT_CRXV_HE_RU0			GENMASK(7, 0)
-#define MT_CRXV_HE_RU1			GENMASK(15, 8)
-#define MT_CRXV_HE_RU2			GENMASK(23, 16)
-#define MT_CRXV_HE_RU3			GENMASK(31, 24)
-#define MT_CRXV_HE_MU_AID		GENMASK(30, 20)
-
-#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
-#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
-#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
-#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
-
-#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
-#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
-#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
-#define MT_CRXV_HE_DOPPLER		BIT(16)
-
-#define MT_CRXV_SNR		GENMASK(18, 13)
-#define MT_CRXV_FOE_LO		GENMASK(31, 19)
-#define MT_CRXV_FOE_HI		GENMASK(6, 0)
-#define MT_CRXV_FOE_SHIFT	13
-
 enum tx_port_idx {
 	MT_TX_PORT_IDX_LMAC,
 	MT_TX_PORT_IDX_MCU
-- 
2.35.3

