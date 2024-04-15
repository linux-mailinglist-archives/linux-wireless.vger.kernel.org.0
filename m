Return-Path: <linux-wireless+bounces-6323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF208A50F4
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 15:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D9C1C21D92
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E987603A;
	Mon, 15 Apr 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XmQe0uas"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D95128828
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186237; cv=none; b=bgHksrnT1HKLKELC22JKbGHAUM6LyRaSGL9WIEaTv/s3IF/xdaRpR394DYzakVz4e5ot34QmyPma3X+sSiQrLNcA91wQht2uUC9NoHm91mqDQQUl5uvzPjKFMXViiCVIkRr71cZtAHyJOhZO7uvnJ6aVvCd/39u72yg/q+8vAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186237; c=relaxed/simple;
	bh=XfmNsSw/Ml09+oEaJtrOu+01PAalDhb1mp3jbRBDvRU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R0ca2gfgApvnaR116XnhND/nPkmi0q5G5D5wyWQs/0BpQUQV4+HWdbp4JyJzMDIEvPng9/SNUOCiSRiTvcM8iThPKb+abQhY331uOt9kLJdkfsHqA61JY0c5E+GeWnQBmQdLn7HCkoSeO9jadMiWl765H6Ihb7P2UmxeBjVecgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XmQe0uas; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 970da290fb2811ee935d6952f98a51a9-20240415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cO+Nz6pWljWFlGjF8bOfXSxVNHA9wkQKw71vbqy+eKA=;
	b=XmQe0uas4BSjRAZFKJ647ecisdnLWWlSAjHPWxpIHQW6sIrVItmLuJd4Iv3sb3+1+R6EL5pVsgqMljVwZuPd5DeohVs1tcOTnF94iHXi2eG1FF7botXkT655DF4130ohDjit3R6h6GHEdZVVuocGL19oaSQpIBXf8Ibdc6vyLLs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6bb45bcc-c48a-443e-8d11-2e188af27a6b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:75ab3286-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 970da290fb2811ee935d6952f98a51a9-20240415
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 117503837; Mon, 15 Apr 2024 21:03:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 Apr 2024 21:03:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 Apr 2024 21:03:44 +0800
From: Deren Wu <deren.wu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Soul Huang <Soul.Huang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Leon Yen
	<Leon.Yen@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Quan Zhou
	<quan.zhou@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Deren Wu
	<deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: add EHT radiotap support in monitor mode
Date: Mon, 15 Apr 2024 21:03:42 +0800
Message-ID: <5553c30b820a299afce84a611562c21fbab6bb32.1713186083.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add IEEE80211_RADIOTAP_EHT and IEEE80211_RADIOTAP_EHT_USIG radiotap
to fill in EHT information, such as MCS, NSS, GI and bandwidth.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  2 +
 .../wireless/mediatek/mt76/mt76_connac3_mac.c | 85 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac3_mac.h | 22 +++++
 .../net/wireless/mediatek/mt76/mt7925/mac.c   | 15 +++-
 4 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 91987bdf239d..445d0f0ab779 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -451,4 +451,6 @@ void mt76_connac2_tx_token_put(struct mt76_dev *dev);
 /* connac3 */
 void mt76_connac3_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv,
 					 u8 mode);
+void mt76_connac3_mac_decode_eht_radiotap(struct sk_buff *skb, __le32 *rxv,
+					  u8 mode);
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
index 73e9f283d0ae..92ad1ecf6c9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
@@ -6,8 +6,11 @@
 #include "dma.h"
 
 #define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
+#define EHT_BITS(f)		cpu_to_le32(IEEE80211_RADIOTAP_EHT_##f)
 #define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
 						 IEEE80211_RADIOTAP_HE_##f)
+#define EHT_PREP(f, m, v)	le32_encode_bits(le32_get_bits(v, MT_CRXV_EHT_##m),\
+						 IEEE80211_RADIOTAP_EHT_##f)
 
 static void
 mt76_connac3_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
@@ -180,3 +183,85 @@ void mt76_connac3_mac_decode_he_radiotap(struct sk_buff *skb, __le32 *rxv,
 	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac3_mac_decode_he_radiotap);
+
+static void *
+mt76_connac3_mac_radiotap_push_tlv(struct sk_buff *skb, u16 type, u16 len)
+{
+	struct ieee80211_radiotap_tlv *tlv;
+
+	tlv = skb_push(skb, sizeof(*tlv) + len);
+	tlv->type = cpu_to_le16(type);
+	tlv->len = cpu_to_le16(len);
+	memset(tlv->data, 0, len);
+
+	return tlv->data;
+}
+
+void mt76_connac3_mac_decode_eht_radiotap(struct sk_buff *skb, __le32 *rxv,
+					  u8 mode)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct ieee80211_radiotap_eht_usig *usig;
+	struct ieee80211_radiotap_eht *eht;
+	u32 ltf_size = le32_get_bits(rxv[4], MT_CRXV_HE_LTF_SIZE) + 1;
+	u8 bw = FIELD_GET(MT_PRXV_FRAME_MODE, le32_to_cpu(rxv[2]));
+
+	if (WARN_ONCE(skb_mac_header(skb) != skb->data,
+		      "Should push tlv at the top of mac hdr"))
+		return;
+
+	eht = mt76_connac3_mac_radiotap_push_tlv(skb, IEEE80211_RADIOTAP_EHT,
+						 sizeof(*eht) + sizeof(u32));
+	usig = mt76_connac3_mac_radiotap_push_tlv(skb, IEEE80211_RADIOTAP_EHT_USIG,
+						  sizeof(*usig));
+
+	status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
+
+	eht->known |= EHT_BITS(KNOWN_SPATIAL_REUSE) |
+		      EHT_BITS(KNOWN_GI) |
+		      EHT_BITS(KNOWN_EHT_LTF) |
+		      EHT_BITS(KNOWN_LDPC_EXTRA_SYM_OM) |
+		      EHT_BITS(KNOWN_PE_DISAMBIGUITY_OM) |
+		      EHT_BITS(KNOWN_NSS_S);
+
+	eht->data[0] |=
+		EHT_PREP(DATA0_SPATIAL_REUSE, SR_MASK, rxv[13]) |
+		cpu_to_le32(FIELD_PREP(IEEE80211_RADIOTAP_EHT_DATA0_GI, status->eht.gi) |
+			    FIELD_PREP(IEEE80211_RADIOTAP_EHT_DATA0_LTF, ltf_size)) |
+		EHT_PREP(DATA0_PE_DISAMBIGUITY_OM, PE_DISAMBIG, rxv[5]) |
+		EHT_PREP(DATA0_LDPC_EXTRA_SYM_OM, LDPC_EXT_SYM, rxv[4]);
+
+	eht->data[7] |= le32_encode_bits(status->nss, IEEE80211_RADIOTAP_EHT_DATA7_NSS_S);
+
+	eht->user_info[0] |=
+		EHT_BITS(USER_INFO_MCS_KNOWN) |
+		EHT_BITS(USER_INFO_CODING_KNOWN) |
+		EHT_BITS(USER_INFO_NSS_KNOWN_O) |
+		EHT_BITS(USER_INFO_BEAMFORMING_KNOWN_O) |
+		EHT_BITS(USER_INFO_DATA_FOR_USER) |
+		le32_encode_bits(status->rate_idx, IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
+		le32_encode_bits(status->nss, IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O);
+
+	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
+		eht->user_info[0] |= EHT_BITS(USER_INFO_BEAMFORMING_O);
+
+	if (le32_to_cpu(rxv[0]) & MT_PRXV_HT_AD_CODE)
+		eht->user_info[0] |= EHT_BITS(USER_INFO_CODING);
+
+	if (mode == MT_PHY_TYPE_EHT_MU)
+		eht->user_info[0] |= EHT_BITS(USER_INFO_STA_ID_KNOWN) |
+				     EHT_PREP(USER_INFO_STA_ID, MU_AID, rxv[8]);
+
+	usig->common |=
+		EHT_BITS(USIG_COMMON_PHY_VER_KNOWN) |
+		EHT_BITS(USIG_COMMON_BW_KNOWN) |
+		EHT_BITS(USIG_COMMON_UL_DL_KNOWN) |
+		EHT_BITS(USIG_COMMON_BSS_COLOR_KNOWN) |
+		EHT_BITS(USIG_COMMON_TXOP_KNOWN) |
+		le32_encode_bits(0, IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER) |
+		le32_encode_bits(bw, IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW) |
+		EHT_PREP(USIG_COMMON_UL_DL, UPLINK, rxv[5]) |
+		EHT_PREP(USIG_COMMON_BSS_COLOR, BSS_COLOR, rxv[9]) |
+		EHT_PREP(USIG_COMMON_TXOP, TXOP_DUR, rxv[9]);
+}
+EXPORT_SYMBOL_GPL(mt76_connac3_mac_decode_eht_radiotap);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 83dcd964bfd0..353e66069840 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -142,6 +142,28 @@ enum {
 #define MT_CRXV_HE_RU3_L		GENMASK(31, 27)
 #define MT_CRXV_HE_RU3_H		GENMASK(3, 0)
 
+#define MT_CRXV_EHT_NUM_USER		GENMASK(26, 20)
+#define MT_CRXV_EHT_LTF_SIZE		GENMASK(28, 27)
+#define MT_CRXV_EHT_LDPC_EXT_SYM	BIT(30)
+#define MT_CRXV_EHT_PE_DISAMBIG		BIT(1)
+#define MT_CRXV_EHT_UPLINK		BIT(2)
+#define MT_CRXV_EHT_MU_AID		GENMASK(27, 17)
+#define MT_CRXV_EHT_BEAM_CHNG		BIT(29)
+#define MT_CRXV_EHT_DOPPLER		BIT(0)
+#define MT_CRXV_EHT_BSS_COLOR		GENMASK(15, 10)
+#define MT_CRXV_EHT_TXOP_DUR		GENMASK(23, 17)
+#define MT_CRXV_EHT_SR_MASK		GENMASK(11, 8)
+#define MT_CRXV_EHT_SR1_MASK		GENMASK(15, 12)
+#define MT_CRXV_EHT_SR2_MASK		GENMASK(19, 16)
+#define MT_CRXV_EHT_SR3_MASK		GENMASK(23, 20)
+#define MT_CRXV_EHT_RU0			GENMASK(8, 0)
+#define MT_CRXV_EHT_RU1			GENMASK(17, 9)
+#define MT_CRXV_EHT_RU2			GENMASK(26, 18)
+#define MT_CRXV_EHT_RU3_L		GENMASK(31, 27)
+#define MT_CRXV_EHT_RU3_H		GENMASK(3, 0)
+#define MT_CRXV_EHT_SIG_MCS		GENMASK(19, 18)
+#define MT_CRXV_EHT_LTF_SYM		GENMASK(22, 20)
+
 enum tx_header_format {
 	MT_HDR_FORMAT_802_3,
 	MT_HDR_FORMAT_CMD,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 1b9fbd9a140d..c2460ef4993d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -590,14 +590,25 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 			seq_ctrl = le16_to_cpu(hdr->seq_ctrl);
 			qos_ctl = *ieee80211_get_qos_ctl(hdr);
 		}
+		skb_set_mac_header(skb, (unsigned char *)hdr - skb->data);
 	} else {
 		status->flag |= RX_FLAG_8023;
 	}
 
 	mt792x_mac_assoc_rssi(dev, skb);
 
-	if (rxv && mode >= MT_PHY_TYPE_HE_SU && !(status->flag & RX_FLAG_8023))
-		mt76_connac3_mac_decode_he_radiotap(skb, rxv, mode);
+	if (rxv && !(status->flag & RX_FLAG_8023)) {
+		switch (status->encoding) {
+		case RX_ENC_EHT:
+			mt76_connac3_mac_decode_eht_radiotap(skb, rxv, mode);
+			break;
+		case RX_ENC_HE:
+			mt76_connac3_mac_decode_he_radiotap(skb, rxv, mode);
+			break;
+		default:
+			break;
+		}
+	}
 
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
-- 
2.18.0


