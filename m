Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D967236A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjARQdu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjARQdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:33:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B511EAF
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:31:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80E58618B9
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 16:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89558C433EF;
        Wed, 18 Jan 2023 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674059472;
        bh=UHPyKaEU9hYTCTl+5YNdIzzcpOwF2OU5bwbKVkpIF6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=imIr4XBrAgAjGKW3UZWPAS5HNtfilQikscM4/crlJ6z0mKHkI7Up5X/fxb5JXxsHn
         r2MA4r+pyUIUsSZJBfLxdqcVPWGI44USsTubkVXFswkgiBNRYU7waiFq37gZz6jdJS
         AHQqkdAnJyGcNECg8z6ApCxzSgksM1yqIpW7baQRal4gkglntBWzK3KFc2VqjtLNHN
         Br60RF7PCeBV/z3HTDWvJc2YR93LZGfWLGKRu5Ip0MG5y3aCm9DC7+BjrWatt0HuOA
         d+FX7/VjSjVZ4AREa63ibWwOtYbh0zvK4iZddSz40WR73f/1AJ9RMG7MnlEngGP/UM
         7IotBpBC0hh0g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 4/4] wifi: mt76: mt7996: rely on mt76_connac2_mac_decode_he_radiotap
Date:   Wed, 18 Jan 2023 17:30:41 +0100
Message-Id: <b6311f14077cc7933519b7e5cbb4b1259ee1d92e.1674059222.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674059222.git.lorenzo@kernel.org>
References: <cover.1674059222.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on connac library for radiotap parsing and drop the following routines:
- mt7996_mac_decode_he_radiotap
- mt7996_mac_decode_he_mu_radiotap
- mt7996_mac_decode_he_radiotap_ru

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 179 +-----------------
 2 files changed, 4 insertions(+), 178 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index aed4ee95fb2e..614df85ef66e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -823,6 +823,7 @@ void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
 			 HE_BITS(DATA2_TXOP_KNOWN),
 	};
 	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
+	u32 txbf_mask = is_mt7996(dev) ? BIT(11) : BIT(10);
 	struct ieee80211_radiotap_he *he;
 
 	status->flag |= RX_FLAG_RADIOTAP_HE;
@@ -836,7 +837,7 @@ void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
 	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
 		    le16_encode_bits(ltf_size,
 				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
-	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
+	if (le32_to_cpu(rxv[0]) & txbf_mask)
 		he->data5 |= HE_BITS(DATA5_TXBF);
 	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
 		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 56400331e74e..6f5fe47f8a30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -12,10 +12,6 @@
 
 #define to_rssi(field, rcpi)	((FIELD_GET(field, rcpi) - 220) / 2)
 
-#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
-#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
-						 IEEE80211_RADIOTAP_HE_##f)
-
 static const struct mt7996_dfs_radar_spec etsi_radar_specs = {
 	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
 	.radar_pattern = {
@@ -248,178 +244,6 @@ void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 		mt76_clear(dev, addr, BIT(5));
 }
 
-static void
-mt7996_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
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
-mt7996_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
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
-mt7996_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv, u8 mode)
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
-		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
-		mt7996_mac_decode_he_mu_radiotap(skb, rxv);
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
-		mt7996_mac_decode_he_radiotap_ru(status, he, rxv);
-		break;
-	default:
-		break;
-	}
-}
-
 /* The HW does not translate the mac header to 802.3 for mesh point */
 static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 {
@@ -843,7 +667,8 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
-		mt7996_mac_decode_he_radiotap(skb, rxv, mode);
+		mt76_connac2_mac_decode_he_radiotap(&dev->mt76, skb, rxv,
+						    mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
-- 
2.39.0

