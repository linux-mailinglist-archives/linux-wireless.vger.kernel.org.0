Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8972E5D6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbjFMOem (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242955AbjFMOeV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02619173E
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 768BA6372B
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843C5C433F0;
        Tue, 13 Jun 2023 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686666856;
        bh=pIyL4thvGkUhVNxaNSlGZVjt6dyrKjZEhHGB6LDdk5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6ImnJG8UNCDdl/5tcFifSNRjfQUhva9EJbWVJoOCNwjss8JnPZ6fWXzaCukMhgxh
         4NWKgWksjUOFEel9Bq0gh2XFdsOGl66abNuTn7zND0mofqwV85kEmFLsG0h5MQ0VDl
         ro7ZqJkKkLxkcBD3I14LdopN9ousmffk4EATdMDxOj1FAtao2p5etkfuTHL39iMq8f
         7bwD9o5myMdpFRRJXbCVNTJlfZTzguqDzfVEJ0YHOEt/fLrIFHLVstAdcBYkuacRxD
         eAAjR7YB3aFKHu9Ij0L70g+ZxYHvvX+lairoXM7xhRdC9gDrLxdOnoW+UjGk3ftxFi
         RkcHC3P8BFzjg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        shayne.chen@mediatek.com, ryder.lee@mediatek.com,
        deren.wu@mediatek.com
Subject: [PATCH v3 15/15] wifi: mt76: connac: add connac3 mac library
Date:   Tue, 13 Jun 2023 16:32:43 +0200
Message-Id: <c4209489fe60ab45e61d3d031b5e1472c2837ca0.1686664917.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686664917.git.lorenzo@kernel.org>
References: <cover.1686664917.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce connac3_mac in mt76_connac library to reuse mac code shared
between WiFi7 chipsets. So far connac3 library contains just radiotap
parsing code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   3 +
 .../wireless/mediatek/mt76/mt76_connac3_mac.c | 182 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 180 +----------------
 4 files changed, 187 insertions(+), 180 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 84c99b7e57f9..d8e8079c8b54 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -27,7 +27,7 @@ mt76x02-lib-y := mt76x02_util.o mt76x02_mac.o mt76x02_mcu.o \
 
 mt76x02-usb-y := mt76x02_usb_mcu.o mt76x02_usb_core.o
 
-mt76-connac-lib-y := mt76_connac_mcu.o mt76_connac_mac.o
+mt76-connac-lib-y := mt76_connac_mcu.o mt76_connac_mac.o mt76_connac3_mac.o
 
 obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 68bdeada1421..fb1357f0a29e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -415,4 +415,7 @@ void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 			    struct list_head *free_list);
 void mt76_connac2_tx_token_put(struct mt76_dev *dev);
 
+/* connac3 */
+void mt76_connac3_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv,
+					 u8 mode);
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
new file mode 100644
index 000000000000..73e9f283d0ae
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include "mt76_connac.h"
+#include "mt76_connac3_mac.h"
+#include "dma.h"
+
+#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
+#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
+						 IEEE80211_RADIOTAP_HE_##f)
+
+static void
+mt76_connac3_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
+				       struct ieee80211_radiotap_he *he,
+				       __le32 *rxv)
+{
+	u32 ru = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC), offs = 0;
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
+mt76_connac3_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32 *rxv)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	static const struct ieee80211_radiotap_he_mu mu_known = {
+		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
+			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
+			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN),
+		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
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
+				 le32_get_bits(rxv[4], MT_CRXV_HE_NUM_USER));
+
+	he_mu->ru_ch1[0] = le32_get_bits(rxv[16], MT_CRXV_HE_RU0) & 0xff;
+
+	if (status->bw >= RATE_INFO_BW_40) {
+		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
+		he_mu->ru_ch2[0] = le32_get_bits(rxv[16], MT_CRXV_HE_RU1) & 0xff;
+	}
+
+	if (status->bw >= RATE_INFO_BW_80) {
+		u32 ru_h, ru_l;
+
+		he_mu->ru_ch1[1] = le32_get_bits(rxv[16], MT_CRXV_HE_RU2) & 0xff;
+
+		ru_l = le32_get_bits(rxv[16], MT_CRXV_HE_RU3_L);
+		ru_h = le32_get_bits(rxv[17], MT_CRXV_HE_RU3_H) & 0x7;
+		he_mu->ru_ch2[1] = (u8)(ru_l | ru_h << 4);
+	}
+}
+
+void mt76_connac3_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv,
+					 u8 mode)
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
+	u32 ltf_size = le32_get_bits(rxv[4], MT_CRXV_HE_LTF_SIZE) + 1;
+	struct ieee80211_radiotap_he *he;
+
+	status->flag |= RX_FLAG_RADIOTAP_HE;
+
+	he = skb_push(skb, sizeof(known));
+	memcpy(he, &known, sizeof(known));
+
+	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[9]) |
+		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[4]);
+	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[13]);
+	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[5]) |
+		    le16_encode_bits(ltf_size,
+				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
+	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
+		he->data5 |= HE_BITS(DATA5_TXBF);
+	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[9]) |
+		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[9]);
+
+	switch (mode) {
+	case MT_PHY_TYPE_HE_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[8]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
+		break;
+	case MT_PHY_TYPE_HE_EXT_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
+		break;
+	case MT_PHY_TYPE_HE_MU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
+		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[8]);
+
+		mt76_connac3_mac_decode_he_radiotap_ru(status, he, rxv);
+		mt76_connac3_mac_decode_he_mu_radiotap(skb, rxv);
+		break;
+	case MT_PHY_TYPE_HE_TB:
+		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
+			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
+
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[13]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[13]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[13]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[13]);
+
+		mt76_connac3_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac3_mac_decode_he_radiotap);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e407fc547e42..ea269e81126b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -13,10 +13,6 @@
 
 #define to_rssi(field, rcpi)	((FIELD_GET(field, rcpi) - 220) / 2)
 
-#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
-#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
-						 IEEE80211_RADIOTAP_HE_##f)
-
 static const struct mt7996_dfs_radar_spec etsi_radar_specs = {
 	.pulse_th = { 110, -10, -80, 40, 5200, 128, 5200 },
 	.radar_pattern = {
@@ -263,180 +259,6 @@ void mt7996_mac_set_fixed_rate_table(struct mt7996_dev *dev,
 	mt76_wr(dev, MT_WTBL_ITCR, ctrl);
 }
 
-static void
-mt7996_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
-				 struct ieee80211_radiotap_he *he,
-				 __le32 *rxv)
-{
-	u32 ru, offs = 0;
-
-	ru = le32_get_bits(rxv[0], MT_PRXV_HE_RU_ALLOC);
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
-				 le32_get_bits(rxv[4], MT_CRXV_HE_NUM_USER));
-
-	he_mu->ru_ch1[0] = le32_get_bits(rxv[16], MT_CRXV_HE_RU0) & 0xff;
-
-	if (status->bw >= RATE_INFO_BW_40) {
-		he_mu->flags1 |= HE_BITS(MU_FLAGS1_CH2_RU_KNOWN);
-		he_mu->ru_ch2[0] = le32_get_bits(rxv[16], MT_CRXV_HE_RU1) & 0xff;
-	}
-
-	if (status->bw >= RATE_INFO_BW_80) {
-		u32 ru_h, ru_l;
-
-		he_mu->ru_ch1[1] = le32_get_bits(rxv[16], MT_CRXV_HE_RU2) & 0xff;
-
-		ru_l = le32_get_bits(rxv[16], MT_CRXV_HE_RU3_L);
-		ru_h = le32_get_bits(rxv[17], MT_CRXV_HE_RU3_H) & 0x7;
-		he_mu->ru_ch2[1] = (u8)(ru_l | ru_h << 4);
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
-	u32 ltf_size = le32_get_bits(rxv[4], MT_CRXV_HE_LTF_SIZE) + 1;
-
-	status->flag |= RX_FLAG_RADIOTAP_HE;
-
-	he = skb_push(skb, sizeof(known));
-	memcpy(he, &known, sizeof(known));
-
-	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[9]) |
-		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[4]);
-	he->data4 = HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[13]);
-	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[5]) |
-		    le16_encode_bits(ltf_size,
-				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
-	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
-		he->data5 |= HE_BITS(DATA5_TXBF);
-	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[9]) |
-		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[9]);
-
-	switch (mode) {
-	case MT_PHY_TYPE_HE_SU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN) |
-			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
-			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[8]) |
-			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
-		break;
-	case MT_PHY_TYPE_HE_EXT_SU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN) |
-			     HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
-		break;
-	case MT_PHY_TYPE_HE_MU:
-		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
-			     HE_BITS(DATA1_UL_DL_KNOWN);
-
-		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[5]);
-		he->data4 |= HE_PREP(DATA4_MU_STA_ID, MU_AID, rxv[8]);
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
-		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[13]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[13]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[13]) |
-			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[13]);
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
@@ -882,7 +704,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
-		mt7996_mac_decode_he_radiotap(skb, rxv, mode);
+		mt76_connac3_mac_decode_he_radiotap(skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
-- 
2.40.1

