Return-Path: <linux-wireless+bounces-20536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F4AA68617
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 08:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056518803DE
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5D250C00;
	Wed, 19 Mar 2025 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="khhGAp13"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CE20897A
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370295; cv=none; b=GpHYWht+RdFa4BoB8FKYdul+Iqld6lYJk3R9IjykxtoX+Gu4GxAIo09lvKVB/mb7Bzd9EEOD+E/FhMk+9OxKrr60X133lvUwm6rt5z2pJxOqNaDeTtLu0NeB2Zv+2gKNeLNFMPZ2266zbj1JeMes/FPR5G3VV8MqWldzrHfK0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370295; c=relaxed/simple;
	bh=TzlVAQRsoU1sn4hb6Zz/DkV7w5ERmhcS+83cZx+2jEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr7OrR/7lnqeWOwtSd82BYFLPN0Rlnxjb/3xbb3mhJGY5sqWxmKy4nbkkTMnWsX1QCYSHRTo1ipz52amTi7hZZMH3j3X7RoXW4u1Tz2hAOf3NLgo3k1epbZfTNMzHFU1XZTapTY4NJGUQR4Zu4QFNNg0dvm2uDSONFknkVjAwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=khhGAp13; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0926e39c049611f0aae1fd9735fae912-20250319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wn9Y9We8zr+xcn2DywuhPD4tlkGGZjxM4p444Wcp2ok=;
	b=khhGAp13wOftmjmpkTUNyPuRwQSEN7uR1SGx+xtHt9fQRYBFu9QLqYIzuxqH8bwGu3zAVJK8vQRzePPYxosmW5T5wVeLrMpoAmp9OJJCzRq5RIVM3vvOy4vlvaEoxZBQIqc9244Bve0xMuRS/sVgmTYanCcf5sGyao3xjfiLUWU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:bdfcce71-9572-4bbd-83b6-3e4d57a1a6a6,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:97be59e1-3561-4519-9a12-e2c881788b70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0926e39c049611f0aae1fd9735fae912-20250319
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 490171514; Wed, 19 Mar 2025 15:44:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 19 Mar 2025 15:44:48 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 19 Mar 2025 15:44:48 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7925: add RNR scan support for 6GHz
Date: Wed, 19 Mar 2025 15:44:26 +0800
Message-ID: <20250319074426.3782102-2-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250319074426.3782102-1-mingyen.hsieh@mediatek.com>
References: <20250319074426.3782102-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Enhance the mt7925 to include RNR scan support. It adds
the necessary RNR information to the scan command.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 35 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 17 +++++----
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 243adace8799..7e24c4aa1e61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3042,6 +3042,7 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct mt76_dev *mdev = phy->dev;
 	struct mt76_connac_mcu_scan_channel *chan;
 	struct sk_buff *skb;
+	u32 short_ssid[MT7925_RNR_SCAN_MAX_BSSIDS] = {0};
 
 	struct scan_hdr_tlv *hdr;
 	struct scan_req_tlv *req;
@@ -3054,8 +3055,8 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	int max_len;
 
 	max_len = sizeof(*hdr) + sizeof(*req) + sizeof(*ssid) +
-				sizeof(*bssid) + sizeof(*chan_info) +
-				sizeof(*misc) + sizeof(*ie);
+		  sizeof(*bssid) * MT7925_RNR_SCAN_MAX_BSSIDS +
+		  sizeof(*chan_info) + sizeof(*misc) + sizeof(*ie);
 
 	skb = mt76_mcu_msg_alloc(mdev, NULL, max_len);
 	if (!skb)
@@ -3078,7 +3079,11 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	for (i = 0; i < sreq->n_ssids; i++) {
 		if (!sreq->ssids[i].ssid_len)
 			continue;
+		if (i > MT7925_RNR_SCAN_MAX_BSSIDS)
+			break;
 
+		short_ssid[i] = ~crc32_le(~0, sreq->ssids[i].ssid,
+				sreq->ssids[i].ssid_len);
 		ssid->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
 		memcpy(ssid->ssids[i].ssid, sreq->ssids[i].ssid,
 		       sreq->ssids[i].ssid_len);
@@ -3087,6 +3092,32 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	ssid->ssid_type = n_ssids ? BIT(2) : BIT(0);
 	ssid->ssids_num = n_ssids;
 
+	if (sreq->n_6ghz_params) {
+		u8 j;
+
+		mt76_connac_mcu_build_rnr_scan_param(mdev, sreq);
+
+		for (j = 0; j < mdev->rnr.bssid_num; j++) {
+			if (j > MT7925_RNR_SCAN_MAX_BSSIDS)
+				break;
+
+			tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSSID,
+						      sizeof(*bssid));
+			bssid = (struct scan_bssid_tlv *)tlv;
+
+			memcpy(bssid->bssid, mdev->rnr.bssid[j], ETH_ALEN);
+			bssid->match_ch = mdev->rnr.channel[j];
+			bssid->match_ssid_ind = MT7925_RNR_SCAN_MAX_BSSIDS;
+			bssid->match_short_ssid_ind = MT7925_RNR_SCAN_MAX_BSSIDS;
+		}
+		req->scan_func |= SCAN_FUNC_RNR_SCAN;
+	} else {
+		tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSSID, sizeof(*bssid));
+		bssid = (struct scan_bssid_tlv *)tlv;
+
+		memcpy(bssid->bssid, sreq->bssid, ETH_ALEN);
+	}
+
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSSID, sizeof(*bssid));
 	bssid = (struct scan_bssid_tlv *)tlv;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 0419aa922e17..96809c2fdff9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -196,6 +196,7 @@ enum {
 	UNI_SNIFFER_CONFIG,
 };
 
+#define MT7925_RNR_SCAN_MAX_BSSIDS	10
 struct scan_hdr_tlv {
 	/* fixed field */
 	u8 seq_num;
@@ -223,7 +224,7 @@ struct scan_req_tlv {
 	__le16 timeout_value;
 	__le16 probe_delay_time;
 	__le32 func_mask_ext;
-};
+} __packed;
 
 struct scan_ssid_tlv {
 	__le16 tag;
@@ -235,9 +236,10 @@ struct scan_ssid_tlv {
 		       * BIT(2) + ssid_type_ext BIT(0) specified SSID only
 		       */
 	u8 ssids_num;
-	u8 pad[2];
-	struct mt76_connac_mcu_scan_ssid ssids[4];
-};
+	u8 is_short_ssid;
+	u8 pad;
+	struct mt76_connac_mcu_scan_ssid ssids[MT7925_RNR_SCAN_MAX_BSSIDS];
+} __packed;
 
 struct scan_bssid_tlv {
 	__le16 tag;
@@ -247,8 +249,9 @@ struct scan_bssid_tlv {
 	u8 match_ch;
 	u8 match_ssid_ind;
 	u8 rcpi;
-	u8 pad[3];
-};
+	u8 match_short_ssid_ind;
+	u8 pad[2];
+} __packed;
 
 struct scan_chan_info_tlv {
 	__le16 tag;
@@ -264,7 +267,7 @@ struct scan_chan_info_tlv {
 	u8 channels_num; /* valid when channel_type is 4 */
 	u8 pad[2];
 	struct mt76_connac_mcu_scan_channel channels[64];
-};
+} __packed;
 
 struct scan_ie_tlv {
 	__le16 tag;
-- 
2.34.1


