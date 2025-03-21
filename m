Return-Path: <linux-wireless+bounces-20623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B4A6B2AD
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 02:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49333BA434
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031E1DED56;
	Fri, 21 Mar 2025 01:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P/4TwNBv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806701DE88A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521121; cv=none; b=tss8UaqvJH45rDH5xzPA9AOfeycoyISHVpqJL+CV+ZaY2YzXdSSzS92plx+A05tSI423wwg9WsugNPvYPo9ZiBzB0PMtsv9GvQrkJfjW91omWEfzh4aC2cHXBNMPDMAubRothdfEvmiVZDVdtGLYEyrzJt57VoYsLfsEAr5jx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521121; c=relaxed/simple;
	bh=tPDUyk559OueJHQCQHSk0kek3wNXzQPcycbBEtLZ7lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMX9JKbTD/HiHUANAgv18yQXS37L1jhK2/4GOJP5arkZyWBNOrczZIXg9JyRVfqAxV3ZkH7YYeb6Q3TJDcgws1734C7iGUfSaKPmujeuI9veLhL7KmDRD4tgkwJmfIX28th9DmngR8LJrZL1me8gSsbteqN1Iy7++Hv88YKy7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=P/4TwNBv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 32ac964805f511f0aae1fd9735fae912-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Oc3LOqQsO5ffU4e68W6QtCi7n5O2ITNAy/DuvZQSEoM=;
	b=P/4TwNBvt6Q/94EdJLjgAifqXU0oefdCoR9rKB4h8XIe6+b5vcwiDrzwJklD5xk4NQdZXRjH9QueFBLtXDzjChCOX2K49j6Z5TDuhNSvz7sYpWu9ymB/G8Ov/D93cYl7tZG987PWpmSL2A7YeqPrBsp7EMeILxaVqvf2GnLz7h0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:583259ff-c705-40a0-8c15-427ed21e84ea,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:fd46e3fd-c03c-4d2b-a585-04cfa9287728,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 32ac964805f511f0aae1fd9735fae912-20250321
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1768169157; Fri, 21 Mar 2025 09:38:32 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 09:38:31 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 09:38:31 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH v2 2/2] wifi: mt76: mt7925: add RNR scan support for 6GHz
Date: Fri, 21 Mar 2025 09:38:29 +0800
Message-ID: <20250321013829.3598-2-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321013829.3598-1-mingyen.hsieh@mediatek.com>
References: <20250321013829.3598-1-mingyen.hsieh@mediatek.com>
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
v2:
  - use '= {}' to replace the '= {0}' for short_ssid array.
  - align with the open paranthesis for crc32_le.
  - use ether_addr_copy() to replace the memcpy of bssid.
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 36 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 17 +++++----
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 243adace8799..22686faca1af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3042,6 +3042,7 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct mt76_dev *mdev = phy->dev;
 	struct mt76_connac_mcu_scan_channel *chan;
 	struct sk_buff *skb;
+	u32 short_ssid[MT7925_RNR_SCAN_MAX_BSSIDS] = {};
 
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
+					  sreq->ssids[i].ssid_len);
 		ssid->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
 		memcpy(ssid->ssids[i].ssid, sreq->ssids[i].ssid,
 		       sreq->ssids[i].ssid_len);
@@ -3087,10 +3092,31 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	ssid->ssid_type = n_ssids ? BIT(2) : BIT(0);
 	ssid->ssids_num = n_ssids;
 
-	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSSID, sizeof(*bssid));
-	bssid = (struct scan_bssid_tlv *)tlv;
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
 
-	memcpy(bssid->bssid, sreq->bssid, ETH_ALEN);
+			ether_addr_copy(bssid->bssid, mdev->rnr.bssid[j]);
+			bssid->match_ch = mdev->rnr.channel[j];
+			bssid->match_ssid_ind = MT7925_RNR_SCAN_MAX_BSSIDS;
+			bssid->match_short_ssid_ind = MT7925_RNR_SCAN_MAX_BSSIDS;
+		}
+		req->scan_func |= SCAN_FUNC_RNR_SCAN;
+	} else {
+		tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSSID, sizeof(*bssid));
+		bssid = (struct scan_bssid_tlv *)tlv;
+
+		ether_addr_copy(bssid->bssid, sreq->bssid);
+	}
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_CHANNEL, sizeof(*chan_info));
 	chan_info = (struct scan_chan_info_tlv *)tlv;
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


