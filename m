Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC7A729288
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 10:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbjFIIRb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 04:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbjFIIRa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 04:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E875210E
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 01:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF4561300
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 08:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67679C433D2;
        Fri,  9 Jun 2023 08:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298611;
        bh=s00m92gzFvKQBzb0YszSmUQJY/KJg/gz6KO1maLikOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7R80U7WEHRragptcaGXyYeOvkzJZsHK95wdENWfliItcqRZh5DgNVx7Rpq6nWUob
         hagVEAeTl+ek/iXeq2JW9AoQDw0f1xnxhS+mVjxIDN0vrqfEYjZi23fq/OK64DyuAi
         5dltuogHBrg6NWFmcJVT3oQjP1CRcw1NM36XU9Oag7/N3S11S6ysdMJzIVIFKTA7Bu
         Y0zgi0jErbV8c8HyLsoT9dS0LQowIGJPU5Bv3xKGfFng5XqfJhh9AqQzep+V+Qp2eg
         Yc2MQSeC6GyoX642gZy1vKCuTx137uN8C9aT4L/49WPD4jshK9oGDYSTTXb8hu+jdL
         MLQlNV7wGN0Kg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2 15/15] wifi: mt76: connac: add connac3 mac library
Date:   Fri,  9 Jun 2023 10:15:44 +0200
Message-Id: <b7a029d6dfee8e58c58f483ea9e9e7b3bc8012b9.1686298162.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686298162.git.lorenzo@kernel.org>
References: <cover.1686298162.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce connac3_mac in mt76_connac library to reuse mac code shared
between WiFi7 chipsets.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  19 +
 .../wireless/mediatek/mt76/mt76_connac3_mac.c | 742 +++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac3_mac.h |  18 +
 .../net/wireless/mediatek/mt76/mt7996/init.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 761 +-----------------
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   8 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |   9 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  28 +-
 9 files changed, 807 insertions(+), 784 deletions(-)
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
index 68bdeada1421..20111678537b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -415,4 +415,23 @@ void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 			    struct list_head *free_list);
 void mt76_connac2_tx_token_put(struct mt76_dev *dev);
 
+/* connac3 */
+void mt76_connac3_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
+void mt76_connac3_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv,
+					 u8 mode);
+int mt76_connac3_mac_fill_rx_rate(struct mt76_dev *dev,
+				  struct mt76_rx_status *status,
+				  struct ieee80211_supported_band *sband,
+				  __le32 *rxv, u8 *mode);
+void mt76_connac3_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
+				 struct sk_buff *skb, struct mt76_wcid *wcid,
+				 struct ieee80211_key_conf *key, int pid,
+				 enum mt76_txq_id qid, u32 changed);
+void mt76_connac3_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
+			    struct ieee80211_sta *sta,
+			    struct list_head *free_list);
+void mt76_connac3_mac_add_txs(struct mt76_dev *dev, void *data,
+			      u32 max_wtbl_size);
+void mt76_connac3_tx_token_put(struct mt76_dev *dev);
+
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
new file mode 100644
index 000000000000..4b745bb74ca0
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
@@ -0,0 +1,742 @@
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
+void mt76_connac3_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+{
+	struct mt76_wcid *wcid;
+	u16 fc, tid;
+	u32 val;
+
+	if (!sta ||
+	    !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
+		return;
+
+	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
+	if (tid >= 6) /* skip VO queue */
+		return;
+
+	val = le32_to_cpu(txwi[2]);
+	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
+	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
+		return;
+
+	wcid = (struct mt76_wcid *)sta->drv_priv;
+	if (!test_and_set_bit(tid, &wcid->ampdu_state))
+		ieee80211_start_tx_ba_session(sta, tid, 0);
+}
+EXPORT_SYMBOL_GPL(mt76_connac3_tx_check_aggr);
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
+
+int mt76_connac3_mac_fill_rx_rate(struct mt76_dev *dev,
+				  struct mt76_rx_status *status,
+				  struct ieee80211_supported_band *sband,
+				  __le32 *rxv, u8 *mode)
+{
+	u8 stbc, gi, bw, dcm, nss;
+	bool cck = false;
+	u32 v0, v2;
+	int i, idx;
+
+	v0 = le32_to_cpu(rxv[0]);
+	v2 = le32_to_cpu(rxv[2]);
+
+	idx = FIELD_GET(MT_PRXV_TX_RATE, v0);
+	i = idx;
+	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+
+	stbc = FIELD_GET(MT_PRXV_HT_STBC, v2);
+	gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v2);
+	*mode = FIELD_GET(MT_PRXV_TX_MODE, v2);
+	dcm = FIELD_GET(MT_PRXV_DCM, v2);
+	bw = FIELD_GET(MT_PRXV_FRAME_MODE, v2);
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
+	case MT_PHY_TYPE_EHT_SU:
+	case MT_PHY_TYPE_EHT_TRIG:
+	case MT_PHY_TYPE_EHT_MU:
+		status->nss = nss;
+		status->encoding = RX_ENC_EHT;
+		i &= GENMASK(3, 0);
+
+		if (gi <= NL80211_RATE_INFO_EHT_GI_3_2)
+			status->eht.gi = gi;
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
+	case IEEE80211_STA_RX_BW_320:
+		status->bw = RATE_INFO_BW_320;
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
+EXPORT_SYMBOL_GPL(mt76_connac3_mac_fill_rx_rate);
+
+static void
+mt76_connac3_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
+				 struct mt76_wcid *wcid)
+{
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	u8 fc_type, fc_stype;
+	u16 ethertype;
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
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	ethertype = get_unaligned_be16(&skb->data[12]);
+	if (ethertype >= ETH_P_802_3_MIN)
+		val |= MT_TXD1_ETH_802_3;
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = IEEE80211_FTYPE_DATA >> 2;
+	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+}
+
+static void
+mt76_connac3_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
+				  struct sk_buff *skb,
+				  struct ieee80211_key_conf *key)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	__le16 fc = hdr->frame_control;
+	u8 fc_type, fc_stype;
+	u32 val;
+
+	if (ieee80211_is_action(fc) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
+	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ)
+		tid = MT_TX_ADDBA;
+	else if (ieee80211_is_mgmt(hdr->frame_control))
+		tid = MT_TX_NORMAL;
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
+	      FIELD_PREP(MT_TXD1_HDR_INFO,
+			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	if (!ieee80211_is_data(fc) || multicast ||
+	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
+		val |= MT_TXD1_FIXED_RATE;
+
+	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+		val |= MT_TXD1_BIP;
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
+	}
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
+	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+
+	txwi[3] |= cpu_to_le32(FIELD_PREP(MT_TXD3_BCM, multicast));
+	if (ieee80211_is_beacon(fc)) {
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
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
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_HW_AMSDU);
+	}
+}
+
+void mt76_connac3_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
+				 struct sk_buff *skb, struct mt76_wcid *wcid,
+				 struct ieee80211_key_conf *key, int pid,
+				 enum mt76_txq_id qid, u32 changed)
+{
+	u32 val, sz_txd = mt76_is_mmio(dev) ? MT_TXD_SIZE : MT_SDIO_TXD_SIZE;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	struct mt76_vif *mvif;
+	u16 tx_count = 15;
+	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
+				    BSS_CHANGED_BEACON_ENABLED));
+	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
+					 BSS_CHANGED_FILS_DISCOVERY));
+
+	mvif = vif ? (struct mt76_vif *)vif->drv_priv : NULL;
+	if (mvif) {
+		omac_idx = mvif->omac_idx;
+		wmm_idx = mvif->wmm_idx;
+		band_idx = mvif->band_idx;
+	}
+
+	if (inband_disc) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_ALTX0;
+	} else if (beacon) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_BCN0;
+	} else if (qid >= MT_TXQ_PSD) {
+		p_fmt = mt76_is_mmio(dev) ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
+		q_idx = MT_LMAC_ALTX0;
+	} else {
+		p_fmt = mt76_is_mmio(dev) ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
+		q_idx = wmm_idx * MT76_CONNAC_MAX_WMM_SETS +
+			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
+	}
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
+	txwi[0] = cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
+	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
+
+	if (band_idx)
+		val |= FIELD_PREP(MT_TXD1_TGID, band_idx);
+
+	txwi[1] = cpu_to_le32(val);
+	txwi[2] = 0;
+
+	val = MT_TXD3_SW_POWER_MGMT |
+	      FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
+	if (key)
+		val |= MT_TXD3_PROTECT_FRAME;
+	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		val |= MT_TXD3_NO_ACK;
+	if (wcid->amsdu)
+		val |= MT_TXD3_HW_AMSDU;
+
+	txwi[3] = cpu_to_le32(val);
+	txwi[4] = 0;
+
+	val = FIELD_PREP(MT_TXD5_PID, pid);
+	if (pid >= MT_PACKET_ID_FIRST)
+		val |= MT_TXD5_TX_STATUS_HOST;
+	txwi[5] = cpu_to_le32(val);
+
+	val = MT_TXD6_DIS_MAT | MT_TXD6_DAS |
+	      FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
+	txwi[6] = cpu_to_le32(val);
+	txwi[7] = 0;
+
+	if (is_8023)
+		mt76_connac3_mac_write_txwi_8023(txwi, skb, wcid);
+	else
+		mt76_connac3_mac_write_txwi_80211(dev, txwi, skb, key);
+
+	if (txwi[1] & cpu_to_le32(MT_TXD1_FIXED_RATE)) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		bool mcast = ieee80211_is_data(hdr->frame_control) &&
+			     is_multicast_ether_addr(hdr->addr1);
+		u8 idx = MT76_CONNAC3_BASIC_RATES_TBL;
+
+		if (mvif) {
+			if (mcast && mvif->mcast_rates_idx)
+				idx = mvif->mcast_rates_idx;
+			else if (beacon && mvif->beacon_rates_idx)
+				idx = mvif->beacon_rates_idx;
+			else
+				idx = mvif->basic_rates_idx;
+		}
+
+		txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_TX_RATE, idx));
+		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_connac3_mac_write_txwi);
+
+void mt76_connac3_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
+			    struct ieee80211_sta *sta,
+			    struct list_head *free_list)
+{
+	__le32 *txwi;
+	u16 wcid_idx;
+
+	mt76_connac_txp_skb_unmap(dev, t);
+	if (!t->skb)
+		goto out;
+
+	txwi = (__le32 *)mt76_get_txwi_ptr(dev, t);
+	if (sta) {
+		struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+
+		wcid_idx = wcid->idx;
+		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+			mt76_connac3_tx_check_aggr(sta, txwi);
+	} else {
+		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+	}
+
+	__mt76_tx_complete_skb(dev, wcid_idx, t->skb, free_list);
+out:
+	t->skb = NULL;
+	mt76_put_txwi(dev, t);
+}
+EXPORT_SYMBOL_GPL(mt76_connac3_txwi_free);
+
+static bool
+mt76_connac3_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
+			     int pid, __le32 *txs_data)
+{
+	struct mt76_sta_stats *stats = &wcid->stats;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_tx_info *info;
+	u32 txrate, txs, mode, stbc;
+	struct rate_info rate = {};
+	struct sk_buff_head list;
+	struct mt76_phy *mphy;
+	struct sk_buff *skb;
+	bool cck = false;
+
+	mt76_tx_status_lock(dev, &list);
+	skb = mt76_tx_status_skb_get(dev, wcid, pid, &list);
+	if (!skb)
+		goto out_no_skb;
+
+	txs = le32_to_cpu(txs_data[0]);
+
+	info = IEEE80211_SKB_CB(skb);
+	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
+	info->status.ampdu_len = 1;
+	info->status.ampdu_ack_len = !!(info->flags &
+					IEEE80211_TX_STAT_ACK);
+	info->status.rates[0].idx = -1;
+
+	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
+
+	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
+	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
+	stbc = le32_get_bits(txs_data[3], MT_TXS3_RATE_STBC);
+
+	if (stbc && rate.nss > 1)
+		rate.nss >>= 1;
+
+	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
+		stats->tx_nss[rate.nss - 1]++;
+	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
+		stats->tx_mcs[rate.mcs]++;
+
+	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
+	switch (mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		mphy = mt76_dev_phy(dev, wcid->phy_idx);
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
+			sband = &mphy->sband_6g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
+		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		if (rate.mcs > 31)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_MCS;
+		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
+			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		if (rate.mcs > 9)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		if (rate.mcs > 11)
+			goto out;
+
+		rate.he_gi = wcid->rate.he_gi;
+		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
+		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		break;
+	case MT_PHY_TYPE_EHT_SU:
+	case MT_PHY_TYPE_EHT_TRIG:
+	case MT_PHY_TYPE_EHT_MU:
+		if (rate.mcs > 13)
+			goto out;
+
+		rate.eht_gi = wcid->rate.eht_gi;
+		rate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		break;
+	default:
+		goto out;
+	}
+
+	stats->tx_mode[mode]++;
+
+	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_320:
+		rate.bw = RATE_INFO_BW_320;
+		stats->tx_bw[4]++;
+		break;
+	case IEEE80211_STA_RX_BW_160:
+		rate.bw = RATE_INFO_BW_160;
+		stats->tx_bw[3]++;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate.bw = RATE_INFO_BW_80;
+		stats->tx_bw[2]++;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate.bw = RATE_INFO_BW_40;
+		stats->tx_bw[1]++;
+		break;
+	default:
+		rate.bw = RATE_INFO_BW_20;
+		stats->tx_bw[0]++;
+		break;
+	}
+	wcid->rate = rate;
+
+out:
+	mt76_tx_status_skb_done(dev, skb, &list);
+
+out_no_skb:
+	mt76_tx_status_unlock(dev, &list);
+
+	return !!skb;
+}
+
+void mt76_connac3_mac_add_txs(struct mt76_dev *dev, void *data,
+			      u32 max_wtbl_size)
+{
+	struct mt76_wcid *wcid;
+	__le32 *txs_data = data;
+	u16 wcidx;
+	u8 pid;
+
+	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
+		return;
+
+	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
+
+	if (pid < MT_PACKET_ID_FIRST)
+		return;
+
+	if (wcidx >= max_wtbl_size)
+		return;
+
+	rcu_read_lock();
+
+	wcid = rcu_dereference(dev->wcid[wcidx]);
+	if (!wcid)
+		goto out;
+
+	mt76_connac3_mac_add_txs_skb(dev, wcid, pid, txs_data);
+	if (!wcid->sta)
+		goto out;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (list_empty(&wcid->poll_list))
+		list_add_tail(&wcid->poll_list, &dev->sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+out:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(mt76_connac3_mac_add_txs);
+
+void mt76_connac3_tx_token_put(struct mt76_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->token_lock);
+	idr_for_each_entry(&dev->token, txwi, id) {
+		mt76_connac3_txwi_free(dev, txwi, NULL, NULL);
+		dev->token_count--;
+	}
+	spin_unlock_bh(&dev->token_lock);
+	idr_destroy(&dev->token);
+}
+EXPORT_SYMBOL_GPL(mt76_connac3_tx_token_put);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 6663a0b46541..bcc1d976b2b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -4,6 +4,24 @@
 #ifndef __MT76_CONNAC3_MAC_H
 #define __MT76_CONNAC3_MAC_H
 
+/* NOTE: used to map mt76_rates. idx may change if firmware expands table */
+#define MT76_CONNAC3_BASIC_RATES_TBL	11
+#define MT76_CONNAC3_BEACON_RATES_TBL	25
+
+enum {
+	MT_CTX0,
+	MT_HIF0 = 0x0,
+
+	MT_LMAC_AC00 = 0x0,
+	MT_LMAC_AC01,
+	MT_LMAC_AC02,
+	MT_LMAC_AC03,
+	MT_LMAC_ALTX0 = 0x10,
+	MT_LMAC_BMC0,
+	MT_LMAC_BCN0,
+	MT_LMAC_PSMP0,
+};
+
 #define MT_CT_PARSE_LEN			72
 #define MT_CT_DMA_BUF_NUM		2
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 8f3536dbe2bb..b4a2ae00d7e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -262,7 +262,7 @@ static void mt7996_mac_init_basic_rates(struct mt7996_dev *dev)
 
 	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++) {
 		u16 rate = mt76_rates[i].hw_value;
-		u16 idx = MT7996_BASIC_RATES_TBL + i;
+		u16 idx = MT76_CONNAC3_BASIC_RATES_TBL + i;
 
 		rate = FIELD_PREP(MT_TX_RATE_MODE, rate >> 8) |
 		       FIELD_PREP(MT_TX_RATE_IDX, rate & GENMASK(7, 0));
@@ -903,7 +903,7 @@ void mt7996_unregister_device(struct mt7996_dev *dev)
 	mt7996_coredump_unregister(dev);
 	mt76_unregister_device(&dev->mt76);
 	mt7996_mcu_exit(dev);
-	mt7996_tx_token_put(dev);
+	mt76_connac3_tx_token_put(&dev->mt76);
 	mt7996_dma_cleanup(dev);
 	tasklet_disable(&dev->mt76.irq_tasklet);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e407fc547e42..2ad2d8994edf 100644
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
@@ -517,114 +339,6 @@ static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 	return 0;
 }
 
-static int
-mt7996_mac_fill_rx_rate(struct mt7996_dev *dev,
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
-	idx = FIELD_GET(MT_PRXV_TX_RATE, v0);
-	i = idx;
-	nss = FIELD_GET(MT_PRXV_NSTS, v0) + 1;
-
-	stbc = FIELD_GET(MT_PRXV_HT_STBC, v2);
-	gi = FIELD_GET(MT_PRXV_HT_SHORT_GI, v2);
-	*mode = FIELD_GET(MT_PRXV_TX_MODE, v2);
-	dcm = FIELD_GET(MT_PRXV_DCM, v2);
-	bw = FIELD_GET(MT_PRXV_FRAME_MODE, v2);
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
-	case MT_PHY_TYPE_EHT_SU:
-	case MT_PHY_TYPE_EHT_TRIG:
-	case MT_PHY_TYPE_EHT_MU:
-		status->nss = nss;
-		status->encoding = RX_ENC_EHT;
-		i &= GENMASK(3, 0);
-
-		if (gi <= NL80211_RATE_INFO_EHT_GI_3_2)
-			status->eht.gi = gi;
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
-	case IEEE80211_STA_RX_BW_320:
-		status->bw = RATE_INFO_BW_320;
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
 mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 {
@@ -814,7 +528,8 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 				return -EINVAL;
 		}
 
-		ret = mt7996_mac_fill_rx_rate(dev, status, sband, rxv, &mode);
+		ret = mt76_connac3_mac_fill_rx_rate(&dev->mt76, status, sband,
+						    rxv, &mode);
 		if (ret < 0)
 			return ret;
 	}
@@ -882,7 +597,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 	}
 
 	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
-		mt7996_mac_decode_he_radiotap(skb, rxv, mode);
+		mt76_connac3_mac_decode_he_radiotap(skb, rxv, mode);
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
@@ -895,210 +610,6 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 	return 0;
 }
 
-static void
-mt7996_mac_write_txwi_8023(struct mt7996_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid)
-{
-	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-	u8 fc_type, fc_stype;
-	u16 ethertype;
-	bool wmm = false;
-	u32 val;
-
-	if (wcid->sta) {
-		struct ieee80211_sta *sta;
-
-		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
-		wmm = sta->wme;
-	}
-
-	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
-	      FIELD_PREP(MT_TXD1_TID, tid);
-
-	ethertype = get_unaligned_be16(&skb->data[12]);
-	if (ethertype >= ETH_P_802_3_MIN)
-		val |= MT_TXD1_ETH_802_3;
-
-	txwi[1] |= cpu_to_le32(val);
-
-	fc_type = IEEE80211_FTYPE_DATA >> 2;
-	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
-
-	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
-
-	txwi[2] |= cpu_to_le32(val);
-}
-
-static void
-mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
-			    struct sk_buff *skb, struct ieee80211_key_conf *key)
-{
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	bool multicast = is_multicast_ether_addr(hdr->addr1);
-	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
-	__le16 fc = hdr->frame_control;
-	u8 fc_type, fc_stype;
-	u32 val;
-
-	if (ieee80211_is_action(fc) &&
-	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
-	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ)
-		tid = MT_TX_ADDBA;
-	else if (ieee80211_is_mgmt(hdr->frame_control))
-		tid = MT_TX_NORMAL;
-
-	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
-	      FIELD_PREP(MT_TXD1_HDR_INFO,
-			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
-	      FIELD_PREP(MT_TXD1_TID, tid);
-
-	if (!ieee80211_is_data(fc) || multicast ||
-	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
-		val |= MT_TXD1_FIXED_RATE;
-
-	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
-	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
-		val |= MT_TXD1_BIP;
-		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
-	}
-
-	txwi[1] |= cpu_to_le32(val);
-
-	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
-	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
-
-	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
-	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
-
-	txwi[2] |= cpu_to_le32(val);
-
-	txwi[3] |= cpu_to_le32(FIELD_PREP(MT_TXD3_BCM, multicast));
-	if (ieee80211_is_beacon(fc)) {
-		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
-		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
-	}
-
-	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
-		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
-
-		if (ieee80211_is_back_req(hdr->frame_control)) {
-			struct ieee80211_bar *bar;
-
-			bar = (struct ieee80211_bar *)skb->data;
-			seqno = le16_to_cpu(bar->start_seq_num);
-		}
-
-		val = MT_TXD3_SN_VALID |
-		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
-		txwi[3] |= cpu_to_le32(val);
-		txwi[3] &= ~cpu_to_le32(MT_TXD3_HW_AMSDU);
-	}
-}
-
-void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid,
-			   struct ieee80211_key_conf *key, int pid,
-			   enum mt76_txq_id qid, u32 changed)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_vif *vif = info->control.vif;
-	u8 band_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
-	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
-	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
-	struct mt76_vif *mvif;
-	u16 tx_count = 15;
-	u32 val;
-	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
-				    BSS_CHANGED_BEACON_ENABLED));
-	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
-					 BSS_CHANGED_FILS_DISCOVERY));
-
-	mvif = vif ? (struct mt76_vif *)vif->drv_priv : NULL;
-	if (mvif) {
-		omac_idx = mvif->omac_idx;
-		wmm_idx = mvif->wmm_idx;
-		band_idx = mvif->band_idx;
-	}
-
-	if (inband_disc) {
-		p_fmt = MT_TX_TYPE_FW;
-		q_idx = MT_LMAC_ALTX0;
-	} else if (beacon) {
-		p_fmt = MT_TX_TYPE_FW;
-		q_idx = MT_LMAC_BCN0;
-	} else if (qid >= MT_TXQ_PSD) {
-		p_fmt = MT_TX_TYPE_CT;
-		q_idx = MT_LMAC_ALTX0;
-	} else {
-		p_fmt = MT_TX_TYPE_CT;
-		q_idx = wmm_idx * MT7996_MAX_WMM_SETS +
-			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
-	}
-
-	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
-	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
-	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
-	txwi[0] = cpu_to_le32(val);
-
-	val = FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
-	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
-
-	if (band_idx)
-		val |= FIELD_PREP(MT_TXD1_TGID, band_idx);
-
-	txwi[1] = cpu_to_le32(val);
-	txwi[2] = 0;
-
-	val = MT_TXD3_SW_POWER_MGMT |
-	      FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
-	if (key)
-		val |= MT_TXD3_PROTECT_FRAME;
-	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
-		val |= MT_TXD3_NO_ACK;
-	if (wcid->amsdu)
-		val |= MT_TXD3_HW_AMSDU;
-
-	txwi[3] = cpu_to_le32(val);
-	txwi[4] = 0;
-
-	val = FIELD_PREP(MT_TXD5_PID, pid);
-	if (pid >= MT_PACKET_ID_FIRST)
-		val |= MT_TXD5_TX_STATUS_HOST;
-	txwi[5] = cpu_to_le32(val);
-
-	val = MT_TXD6_DIS_MAT | MT_TXD6_DAS |
-	      FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
-	txwi[6] = cpu_to_le32(val);
-	txwi[7] = 0;
-
-	if (is_8023)
-		mt7996_mac_write_txwi_8023(dev, txwi, skb, wcid);
-	else
-		mt7996_mac_write_txwi_80211(dev, txwi, skb, key);
-
-	if (txwi[1] & cpu_to_le32(MT_TXD1_FIXED_RATE)) {
-		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-		bool mcast = ieee80211_is_data(hdr->frame_control) &&
-			     is_multicast_ether_addr(hdr->addr1);
-		u8 idx = MT7996_BASIC_RATES_TBL;
-
-		if (mvif) {
-			if (mcast && mvif->mcast_rates_idx)
-				idx = mvif->mcast_rates_idx;
-			else if (beacon && mvif->beacon_rates_idx)
-				idx = mvif->beacon_rates_idx;
-			else
-				idx = mvif->basic_rates_idx;
-		}
-
-		txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_TX_RATE, idx));
-		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
-	}
-}
-
 int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
@@ -1138,8 +649,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
-	mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
-			      pid, qid, 0);
+	mt76_connac3_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, key,
+				    pid, qid, 0);
 
 	txp = (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
@@ -1178,62 +689,6 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return 0;
 }
 
-static void
-mt7996_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
-{
-	struct mt7996_sta *msta;
-	u16 fc, tid;
-	u32 val;
-
-	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
-		return;
-
-	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
-	if (tid >= 6) /* skip VO queue */
-		return;
-
-	val = le32_to_cpu(txwi[2]);
-	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
-	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
-	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
-		return;
-
-	msta = (struct mt7996_sta *)sta->drv_priv;
-	if (!test_and_set_bit(tid, &msta->wcid.ampdu_state))
-		ieee80211_start_tx_ba_session(sta, tid, 0);
-}
-
-static void
-mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
-		 struct ieee80211_sta *sta, struct list_head *free_list)
-{
-	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_wcid *wcid;
-	__le32 *txwi;
-	u16 wcid_idx;
-
-	mt76_connac_txp_skb_unmap(mdev, t);
-	if (!t->skb)
-		goto out;
-
-	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
-	if (sta) {
-		wcid = (struct mt76_wcid *)sta->drv_priv;
-		wcid_idx = wcid->idx;
-
-		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-			mt7996_tx_check_aggr(sta, txwi);
-	} else {
-		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-	}
-
-	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
-
-out:
-	t->skb = NULL;
-	mt76_put_txwi(mdev, t);
-}
-
 static void
 mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 {
@@ -1308,7 +763,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			if (!txwi)
 				continue;
 
-			mt7996_txwi_free(dev, txwi, sta, &free_list);
+			mt76_connac3_txwi_free(mdev, txwi, sta, &free_list);
 		}
 	}
 
@@ -1325,186 +780,6 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 	}
 }
 
-static bool
-mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
-		       int pid, __le32 *txs_data)
-{
-	struct mt76_sta_stats *stats = &wcid->stats;
-	struct ieee80211_supported_band *sband;
-	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_phy *mphy;
-	struct ieee80211_tx_info *info;
-	struct sk_buff_head list;
-	struct rate_info rate = {};
-	struct sk_buff *skb;
-	bool cck = false;
-	u32 txrate, txs, mode, stbc;
-
-	mt76_tx_status_lock(mdev, &list);
-	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
-	if (!skb)
-		goto out_no_skb;
-
-	txs = le32_to_cpu(txs_data[0]);
-
-	info = IEEE80211_SKB_CB(skb);
-	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
-		info->flags |= IEEE80211_TX_STAT_ACK;
-
-	info->status.ampdu_len = 1;
-	info->status.ampdu_ack_len = !!(info->flags &
-					IEEE80211_TX_STAT_ACK);
-
-	info->status.rates[0].idx = -1;
-
-	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
-
-	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
-	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
-	stbc = le32_get_bits(txs_data[3], MT_TXS3_RATE_STBC);
-
-	if (stbc && rate.nss > 1)
-		rate.nss >>= 1;
-
-	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
-		stats->tx_nss[rate.nss - 1]++;
-	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
-		stats->tx_mcs[rate.mcs]++;
-
-	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
-	switch (mode) {
-	case MT_PHY_TYPE_CCK:
-		cck = true;
-		fallthrough;
-	case MT_PHY_TYPE_OFDM:
-		mphy = mt76_dev_phy(mdev, wcid->phy_idx);
-
-		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
-			sband = &mphy->sband_5g.sband;
-		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
-			sband = &mphy->sband_6g.sband;
-		else
-			sband = &mphy->sband_2g.sband;
-
-		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
-		rate.legacy = sband->bitrates[rate.mcs].bitrate;
-		break;
-	case MT_PHY_TYPE_HT:
-	case MT_PHY_TYPE_HT_GF:
-		if (rate.mcs > 31)
-			goto out;
-
-		rate.flags = RATE_INFO_FLAGS_MCS;
-		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
-			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case MT_PHY_TYPE_VHT:
-		if (rate.mcs > 9)
-			goto out;
-
-		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
-		break;
-	case MT_PHY_TYPE_HE_SU:
-	case MT_PHY_TYPE_HE_EXT_SU:
-	case MT_PHY_TYPE_HE_TB:
-	case MT_PHY_TYPE_HE_MU:
-		if (rate.mcs > 11)
-			goto out;
-
-		rate.he_gi = wcid->rate.he_gi;
-		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
-		rate.flags = RATE_INFO_FLAGS_HE_MCS;
-		break;
-	case MT_PHY_TYPE_EHT_SU:
-	case MT_PHY_TYPE_EHT_TRIG:
-	case MT_PHY_TYPE_EHT_MU:
-		if (rate.mcs > 13)
-			goto out;
-
-		rate.eht_gi = wcid->rate.eht_gi;
-		rate.flags = RATE_INFO_FLAGS_EHT_MCS;
-		break;
-	default:
-		goto out;
-	}
-
-	stats->tx_mode[mode]++;
-
-	switch (FIELD_GET(MT_TXS0_BW, txs)) {
-	case IEEE80211_STA_RX_BW_320:
-		rate.bw = RATE_INFO_BW_320;
-		stats->tx_bw[4]++;
-		break;
-	case IEEE80211_STA_RX_BW_160:
-		rate.bw = RATE_INFO_BW_160;
-		stats->tx_bw[3]++;
-		break;
-	case IEEE80211_STA_RX_BW_80:
-		rate.bw = RATE_INFO_BW_80;
-		stats->tx_bw[2]++;
-		break;
-	case IEEE80211_STA_RX_BW_40:
-		rate.bw = RATE_INFO_BW_40;
-		stats->tx_bw[1]++;
-		break;
-	default:
-		rate.bw = RATE_INFO_BW_20;
-		stats->tx_bw[0]++;
-		break;
-	}
-	wcid->rate = rate;
-
-out:
-	mt76_tx_status_skb_done(mdev, skb, &list);
-
-out_no_skb:
-	mt76_tx_status_unlock(mdev, &list);
-
-	return !!skb;
-}
-
-static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
-{
-	struct mt7996_sta *msta = NULL;
-	struct mt76_wcid *wcid;
-	__le32 *txs_data = data;
-	u16 wcidx;
-	u8 pid;
-
-	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
-		return;
-
-	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
-	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
-
-	if (pid < MT_PACKET_ID_FIRST)
-		return;
-
-	if (wcidx >= mt7996_wtbl_size(dev))
-		return;
-
-	rcu_read_lock();
-
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
-	if (!wcid)
-		goto out;
-
-	msta = container_of(wcid, struct mt7996_sta, wcid);
-
-	mt7996_mac_add_txs_skb(dev, wcid, pid, txs_data);
-
-	if (!wcid->sta)
-		goto out;
-
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->wcid.poll_list))
-		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
-
-out:
-	rcu_read_unlock();
-}
-
 bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len)
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
@@ -1527,7 +802,8 @@ bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len)
 		return false;
 	case PKT_TYPE_TXS:
 		for (rxd += 4; rxd + 8 <= end; rxd += 8)
-			mt7996_mac_add_txs(dev, rxd);
+			mt76_connac3_mac_add_txs(mdev, rxd,
+						 mt7996_wtbl_size(dev));
 		return false;
 	case PKT_TYPE_RX_FW_MONITOR:
 		mt7996_debugfs_rx_fw_monitor(dev, data, len);
@@ -1564,7 +840,8 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 		break;
 	case PKT_TYPE_TXS:
 		for (rxd += 4; rxd + 8 <= end; rxd += 8)
-			mt7996_mac_add_txs(dev, rxd);
+			mt76_connac3_mac_add_txs(mdev, rxd,
+						 mt7996_wtbl_size(dev));
 		dev_kfree_skb(skb);
 		break;
 	case PKT_TYPE_RX_FW_MONITOR:
@@ -1771,20 +1048,6 @@ mt7996_update_beacons(struct mt7996_dev *dev)
 					    mt7996_update_vif_beacon, phy3->hw);
 }
 
-void mt7996_tx_token_put(struct mt7996_dev *dev)
-{
-	struct mt76_txwi_cache *txwi;
-	int id;
-
-	spin_lock_bh(&dev->mt76.token_lock);
-	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7996_txwi_free(dev, txwi, NULL, NULL);
-		dev->mt76.token_count--;
-	}
-	spin_unlock_bh(&dev->mt76.token_lock);
-	idr_destroy(&dev->mt76.token);
-}
-
 static int
 mt7996_mac_restart(struct mt7996_dev *dev)
 {
@@ -1834,7 +1097,7 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 	napi_disable(&dev->mt76.tx_napi);
 
 	/* token reinit */
-	mt7996_tx_token_put(dev);
+	mt76_connac3_tx_token_put(&dev->mt76);
 	idr_init(&dev->mt76.token);
 
 	mt7996_dma_reset(dev, true);
@@ -2042,7 +1305,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	if (mt7996_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
 		mt7996_dma_reset(dev, false);
 
-		mt7996_tx_token_put(dev);
+		mt76_connac3_tx_token_put(&dev->mt76);
 		idr_init(&dev->mt76.token);
 
 		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ee9e409b8eb9..6aef12e5dfe4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -221,9 +221,9 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 	if (phy->mt76->chandef.chan->band != NL80211_BAND_2GHZ)
-		mvif->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL + 4;
+		mvif->mt76.basic_rates_idx = MT76_CONNAC3_BASIC_RATES_TBL + 4;
 	else
-		mvif->mt76.basic_rates_idx = MT7996_BASIC_RATES_TBL;
+		mvif->mt76.basic_rates_idx = MT76_CONNAC3_BASIC_RATES_TBL;
 
 	mt7996_init_bitrate_mask(vif);
 
@@ -518,7 +518,7 @@ mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
 		/* must odd index */
-		idx = MT7996_BEACON_RATES_TBL + 2 * (mvif->idx % 20);
+		idx = MT76_CONNAC3_BEACON_RATES_TBL + 2 * (mvif->idx % 20);
 		mt7996_mac_set_fixed_rate_table(dev, idx, rate);
 		return idx;
 	}
@@ -526,7 +526,7 @@ mt7996_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	idx = FIELD_GET(MT_TX_RATE_IDX, rate);
 	for (i = 0; i < ARRAY_SIZE(mt76_rates); i++)
 		if ((mt76_rates[i].hw_value & GENMASK(7, 0)) == idx)
-			return MT7996_BASIC_RATES_TBL + i;
+			return MT76_CONNAC3_BASIC_RATES_TBL + i;
 
 	return mvif->basic_rates_idx;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 6cc87835263a..d0ba58c58760 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1912,8 +1912,8 @@ mt7996_mcu_beacon_cont(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	buf = (u8 *)bcn + sizeof(*bcn) - MAX_BEACON_SIZE;
-	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0,
-			      BSS_CHANGED_BEACON);
+	mt76_connac3_mac_write_txwi(&dev->mt76, (__le32 *)buf, skb, wcid, NULL,
+				    0, 0, BSS_CHANGED_BEACON);
 
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
@@ -2024,7 +2024,8 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 
 	buf = (u8 *)tlv + sizeof(*discov) - MAX_INBAND_FRAME_SIZE;
 
-	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0, changed);
+	mt76_connac3_mac_write_txwi(&dev->mt76, (__le32 *)buf, skb, wcid,
+				    NULL, 0, 0, changed);
 
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 
@@ -2575,7 +2576,7 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif)
 
 		e = (struct edca *)tlv;
 		e->set = WMM_PARAM_SET;
-		e->queue = ac + mvif->mt76.wmm_idx * MT7996_MAX_WMM_SETS;
+		e->queue = ac + mvif->mt76.wmm_idx * MT76_CONNAC_MAX_WMM_SETS;
 		e->aifs = q->aifs;
 		e->txop = cpu_to_le16(q->txop);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index c8e8a04a561e..1de85e0a8b32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -12,7 +12,6 @@
 #include "regs.h"
 
 #define MT7996_MAX_INTERFACES		19	/* per-band */
-#define MT7996_MAX_WMM_SETS		4
 #define MT7996_WTBL_RESERVED		(mt7996_wtbl_size(dev) - 1)
 #define MT7996_WTBL_STA			(MT7996_WTBL_RESERVED - \
 					 mt7996_max_interface_num(dev))
@@ -43,10 +42,6 @@
 #define MT7996_MAX_STA_TWT_AGRT		8
 #define MT7996_MAX_QUEUE		(__MT_RXQ_MAX +	__MT_MCUQ_MAX + 3)
 
-/* NOTE: used to map mt76_rates. idx may change if firmware expands table */
-#define MT7996_BASIC_RATES_TBL		11
-#define MT7996_BEACON_RATES_TBL		25
-
 struct mt7996_vif;
 struct mt7996_sta;
 struct mt7996_dfs_pulse;
@@ -300,20 +295,6 @@ enum {
 	__MT_WFDMA_MAX,
 };
 
-enum {
-	MT_CTX0,
-	MT_HIF0 = 0x0,
-
-	MT_LMAC_AC00 = 0x0,
-	MT_LMAC_AC01,
-	MT_LMAC_AC02,
-	MT_LMAC_AC03,
-	MT_LMAC_ALTX0 = 0x10,
-	MT_LMAC_BMC0,
-	MT_LMAC_BCN0,
-	MT_LMAC_PSMP0,
-};
-
 enum {
 	MT_RX_SEL0,
 	MT_RX_SEL1,
@@ -505,10 +486,10 @@ void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 			      struct ieee80211_vif *vif, bool enable);
 void mt7996_mac_set_fixed_rate_table(struct mt7996_dev *dev,
 				     u8 tbl_idx, u16 rate_idx);
-void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid,
-			   struct ieee80211_key_conf *key, int pid,
-			   enum mt76_txq_id qid, u32 changed);
+void mt76_connac3_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
+				 struct sk_buff *skb, struct mt76_wcid *wcid,
+				 struct ieee80211_key_conf *key, int pid,
+				 enum mt76_txq_id qid, u32 changed);
 void mt7996_mac_set_timing(struct mt7996_phy *phy);
 int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
@@ -529,7 +510,6 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
-void mt7996_tx_token_put(struct mt7996_dev *dev);
 void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
 bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len);
-- 
2.40.1

