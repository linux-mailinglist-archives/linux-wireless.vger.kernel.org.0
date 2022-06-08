Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF11543A76
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 19:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiFHRbO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiFHRbN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 13:31:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736151CF
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 10:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89DC0CE2A89
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 17:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A006BC3411D;
        Wed,  8 Jun 2022 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654709467;
        bh=BuLMZyL09LchjBAqY5cs+FMJZ0GYoWVB4KjPCYos8Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyefMviVodiTq8rUmbu+v5kWHhdEJ8KM7WzGJ3v/XVSmTrPsClWmqukILx63k9lUJ
         SSHNObe43LlZlSVLfdU9qpe+uEvV4ixBhpYxnUVkRgIU00HJNbcJXf43NpEo2RZx0h
         gJuhii4CeOzS65q272Zznz9qdKJVbX61/bFfyGQGbCoXiugzKwsryDDClNmi1mNTs4
         49E8eJV6kGepMGEMx8P00sW8+6D7wBC5G79izQ9iDXE3Ix3Jo3x4tmYXCdtGSwkmgX
         XRaIuEAJ862lPZp8H7uu4u3tkCRaUZ45cMPNp9yVIRNBw2VUx1XAt46/vsHD7hgyJx
         TqFbDMdUBjZ6A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 3/3] mt76: connac: move mt76_connac2_mac_fill_rx_rate in connac module
Date:   Wed,  8 Jun 2022 19:30:31 +0200
Message-Id: <2a947f4f82507060f7edb1a6a8ff92f35219231e.1654709072.git.lorenzo@kernel.org>
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

Rely on mt76_connac2_mac_fill_rx_rate routine in mt7921 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   4 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 105 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 106 +-----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  82 +-------------
 4 files changed, 117 insertions(+), 180 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 27ab1f2355ce..a9927dcf3d6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -258,5 +258,9 @@ void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
 					 __le32 *rxv, u32 mode);
 int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,
 					 struct sk_buff *skb, u16 hdr_offset);
+int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
+				  struct mt76_rx_status *status,
+				  struct ieee80211_supported_band *sband,
+				  __le32 *rxv, u8 *mode);
 
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 6ac1ac3f5480..6aa02ace365b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -784,3 +784,108 @@ int mt76_connac2_reverse_frag0_hdr_trans(struct ieee80211_vif *vif,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_reverse_frag0_hdr_trans);
+
+int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
+				  struct mt76_rx_status *status,
+				  struct ieee80211_supported_band *sband,
+				  __le32 *rxv, u8 *mode)
+{
+	u32 v0, v2;
+	u8 stbc, gi, bw, dcm, nss;
+	int i, idx;
+	bool cck = false;
+
+	v0 = le32_to_cpu(rxv[0]);
+	v2 = le32_to_cpu(rxv[2]);
+
+	idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
+	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+
+	if (!is_mt7915(dev)) {
+		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
+		gi = FIELD_GET(MT_PRXV_HT_SGI, v0);
+		*mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
+		if (is_mt7921(dev))
+			dcm = !!(idx & MT_PRXV_TX_DCM);
+		else
+			dcm = FIELD_GET(MT_PRXV_DCM, v0);
+		bw = FIELD_GET(MT_PRXV_FRAME_MODE, v0);
+	} else {
+		stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
+		gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
+		*mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
+		dcm = !!(idx & GENMASK(3, 0) & MT_PRXV_TX_DCM);
+		bw = FIELD_GET(MT_CRXV_FRAME_MODE, v2);
+	}
+
+	switch (*mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		i = mt76_get_rate(dev, sband, i, cck);
+		break;
+	case MT_PHY_TYPE_HT_GF:
+	case MT_PHY_TYPE_HT:
+		status->encoding = RX_ENC_HT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		if (i > 31)
+			return -EINVAL;
+		break;
+	case MT_PHY_TYPE_VHT:
+		status->nss = nss;
+		status->encoding = RX_ENC_VHT;
+		if (gi)
+			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		if (i > 11)
+			return -EINVAL;
+		break;
+	case MT_PHY_TYPE_HE_MU:
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+		status->nss = nss;
+		status->encoding = RX_ENC_HE;
+		i &= GENMASK(3, 0);
+
+		if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
+			status->he_gi = gi;
+
+		status->he_dcm = dcm;
+		break;
+	default:
+		return -EINVAL;
+	}
+	status->rate_idx = i;
+
+	switch (bw) {
+	case IEEE80211_STA_RX_BW_20:
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		if (*mode & MT_PHY_TYPE_HE_EXT_SU &&
+		    (idx & MT_PRXV_TX_ER_SU_106T)) {
+			status->bw = RATE_INFO_BW_HE_RU;
+			status->he_ru =
+				NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		} else {
+			status->bw = RATE_INFO_BW_40;
+		}
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		status->bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_160:
+		status->bw = RATE_INFO_BW_160;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
+	if (*mode < MT_PHY_TYPE_HE_SU && gi)
+		status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_fill_rx_rate);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 1d83f8790c44..a575a44685b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -214,108 +214,6 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 	rcu_read_unlock();
 }
 
-static int
-mt7915_mac_fill_rx_rate(struct mt7915_dev *dev,
-			struct mt76_rx_status *status,
-			struct ieee80211_supported_band *sband,
-			__le32 *rxv, u8 *mode)
-{
-	u32 v0, v2;
-	u8 stbc, gi, bw, dcm, nss;
-	int i, idx;
-	bool cck = false;
-
-	v0 = le32_to_cpu(rxv[0]);
-	v2 = le32_to_cpu(rxv[2]);
-
-	idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
-	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
-
-	if (!is_mt7915(&dev->mt76)) {
-		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
-		gi = FIELD_GET(MT_PRXV_HT_SGI, v0);
-		*mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
-		dcm = FIELD_GET(MT_PRXV_DCM, v0);
-		bw = FIELD_GET(MT_PRXV_FRAME_MODE, v0);
-	} else {
-		stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
-		gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
-		*mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
-		dcm = !!(idx & GENMASK(3, 0) & MT_PRXV_TX_DCM);
-		bw = FIELD_GET(MT_CRXV_FRAME_MODE, v2);
-	}
-
-	switch (*mode) {
-	case MT_PHY_TYPE_CCK:
-		cck = true;
-		fallthrough;
-	case MT_PHY_TYPE_OFDM:
-		i = mt76_get_rate(&dev->mt76, sband, i, cck);
-		break;
-	case MT_PHY_TYPE_HT_GF:
-	case MT_PHY_TYPE_HT:
-		status->encoding = RX_ENC_HT;
-		if (gi)
-			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-		if (i > 31)
-			return -EINVAL;
-		break;
-	case MT_PHY_TYPE_VHT:
-		status->nss = nss;
-		status->encoding = RX_ENC_VHT;
-		if (gi)
-			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-		if (i > 11)
-			return -EINVAL;
-		break;
-	case MT_PHY_TYPE_HE_MU:
-	case MT_PHY_TYPE_HE_SU:
-	case MT_PHY_TYPE_HE_EXT_SU:
-	case MT_PHY_TYPE_HE_TB:
-		status->nss = nss;
-		status->encoding = RX_ENC_HE;
-		i &= GENMASK(3, 0);
-
-		if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
-			status->he_gi = gi;
-
-		status->he_dcm = dcm;
-		break;
-	default:
-		return -EINVAL;
-	}
-	status->rate_idx = i;
-
-	switch (bw) {
-	case IEEE80211_STA_RX_BW_20:
-		break;
-	case IEEE80211_STA_RX_BW_40:
-		if (*mode & MT_PHY_TYPE_HE_EXT_SU &&
-		    (idx & MT_PRXV_TX_ER_SU_106T)) {
-			status->bw = RATE_INFO_BW_HE_RU;
-			status->he_ru =
-				NL80211_RATE_INFO_HE_RU_ALLOC_106;
-		} else {
-			status->bw = RATE_INFO_BW_40;
-		}
-		break;
-	case IEEE80211_STA_RX_BW_80:
-		status->bw = RATE_INFO_BW_80;
-		break;
-	case IEEE80211_STA_RX_BW_160:
-		status->bw = RATE_INFO_BW_160;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
-	if (*mode < MT_PHY_TYPE_HE_SU && gi)
-		status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-
-	return 0;
-}
-
 static int
 mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 {
@@ -508,8 +406,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		}
 
 		if (!is_mt7915(&dev->mt76) || (rxd1 & MT_RXD1_NORMAL_GROUP_5)) {
-			ret = mt7915_mac_fill_rx_rate(dev, status, sband, rxv,
-						      &mode);
+			ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status,
+							    sband, rxv, &mode);
 			if (ret < 0)
 				return ret;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 5b48a725e637..b8fe61355cce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -238,7 +238,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	struct mt7921_sta *msta;
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
-	u32 mode = 0;
+	u8 mode = 0;
 	int i, idx;
 
 	memset(status, 0, sizeof(*status));
@@ -380,9 +380,8 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	/* RXD Group 3 - P-RXV */
 	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
-		u8 stbc, gi;
 		u32 v0, v1;
-		bool cck;
+		int ret;
 
 		rxv = rxd;
 		rxd += 2;
@@ -410,79 +409,10 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 					     status->chain_signal[i]);
 		}
 
-		stbc = FIELD_GET(MT_PRXV_HT_STBC, v0);
-		gi = FIELD_GET(MT_PRXV_HT_SGI, v0);
-		cck = false;
-
-		idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
-		mode = FIELD_GET(MT_PRXV_TX_MODE, v0);
-
-		switch (mode) {
-		case MT_PHY_TYPE_CCK:
-			cck = true;
-			fallthrough;
-		case MT_PHY_TYPE_OFDM:
-			i = mt76_get_rate(&dev->mt76, sband, i, cck);
-			break;
-		case MT_PHY_TYPE_HT_GF:
-		case MT_PHY_TYPE_HT:
-			status->encoding = RX_ENC_HT;
-			if (i > 31)
-				return -EINVAL;
-			break;
-		case MT_PHY_TYPE_VHT:
-			status->nss =
-				FIELD_GET(MT_PRXV_NSTS, v0) + 1;
-			status->encoding = RX_ENC_VHT;
-			if (i > 11)
-				return -EINVAL;
-			break;
-		case MT_PHY_TYPE_HE_MU:
-		case MT_PHY_TYPE_HE_SU:
-		case MT_PHY_TYPE_HE_EXT_SU:
-		case MT_PHY_TYPE_HE_TB:
-			status->nss =
-				FIELD_GET(MT_PRXV_NSTS, v0) + 1;
-			status->encoding = RX_ENC_HE;
-			i &= GENMASK(3, 0);
-
-			if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
-				status->he_gi = gi;
-
-			status->he_dcm = !!(idx & MT_PRXV_TX_DCM);
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		status->rate_idx = i;
-
-		switch (FIELD_GET(MT_PRXV_FRAME_MODE, v0)) {
-		case IEEE80211_STA_RX_BW_20:
-			break;
-		case IEEE80211_STA_RX_BW_40:
-			if (mode & MT_PHY_TYPE_HE_EXT_SU &&
-			    (idx & MT_PRXV_TX_ER_SU_106T)) {
-				status->bw = RATE_INFO_BW_HE_RU;
-				status->he_ru =
-					NL80211_RATE_INFO_HE_RU_ALLOC_106;
-			} else {
-				status->bw = RATE_INFO_BW_40;
-			}
-			break;
-		case IEEE80211_STA_RX_BW_80:
-			status->bw = RATE_INFO_BW_80;
-			break;
-		case IEEE80211_STA_RX_BW_160:
-			status->bw = RATE_INFO_BW_160;
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
-		if (mode < MT_PHY_TYPE_HE_SU && gi)
-			status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		ret = mt76_connac2_mac_fill_rx_rate(&dev->mt76, status, sband,
+						    rxv, &mode);
+		if (ret < 0)
+			return ret;
 
 		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
 			rxd += 18;
-- 
2.35.3

