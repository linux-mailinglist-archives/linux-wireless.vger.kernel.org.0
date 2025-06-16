Return-Path: <linux-wireless+bounces-24125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1FADA857
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 08:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA257A4C7E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726D1C84A5;
	Mon, 16 Jun 2025 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O/ugijWV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B564D72608;
	Mon, 16 Jun 2025 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750055822; cv=none; b=nDGqrpNo9ymdLoJIl3qtB7oBpdQ3cYQaDb/C7Nr+nJ/mI8ms0pZhERWYCCWZBdjk983g7G/7d95OmCw7rtk7soV+fF+N9q7lTUi08RRfm5xlp3Zb+CRPNN3TapguCdm2jokAGA0FtXd6R+e+w+cb5BxXZDufPNG+Y40USRTMc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750055822; c=relaxed/simple;
	bh=fotn1RaBwZ5vjpqG2SlF2QTXje6hvya/LU1MBtvsGMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n09fUC4rvxCAxWLK8jyvu9sGTjSA+PaA294x9CD+s4kxs33WVbdkJpvLw7SFFxtHIOD3XuQeJaTDQWuzVr7ecZxiIPe/W/ilhSzefrsUFUjjTugtJZgQE8k3kQ3tJFlvuMvAmMSQ7DF+ZnpOx4ZAdj7cqTLb8IT3djomKIKcWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=O/ugijWV; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 49ecd46e4a7c11f0b910cdf5d4d8066a-20250616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wi4kfeydm6LjlXnqhgFk6S0wXYIGS71UkUdZ20kTVvY=;
	b=O/ugijWVoHMMiEuiDbeEw1hLqXobOrCKZRhtdPYVmES46g+2f2cR6pVG/xW7jGn7EmAPhHkh52JfYtfFEezJxi4jmnmczEfu8b+BB3kVS8F2uWBMiKKTGDAjbep9i4/acAA9urLP6HfSLd1e2yCTef8GPHxlHEQ2Yg3vk2Vcwsc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:ab016ff2-14a5-4240-a9c0-0e72210f9a7e,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:09905cf,CLOUDID:5847b958-abad-4ac2-9923-3af0a8a9a079,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 49ecd46e4a7c11f0b910cdf5d4d8066a-20250616
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 344903136; Mon, 16 Jun 2025 14:36:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 16 Jun 2025 14:36:50 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 16 Jun 2025 14:36:50 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, <stable@vger.kernel.org>
Subject: [PATCH] wifi: mt76: mt7925: fix incorrect scan probe IE handling for hw_scan
Date: Mon, 16 Jun 2025 14:36:49 +0800
Message-ID: <20250616063649.1100503-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The IEs should be processed and filled into the command tlv separately
according to each band.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 75 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  5 +-
 3 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 555ef302ae97..506387b4ce13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1540,7 +1540,7 @@ mt7925_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mt792x_mutex_acquire(dev);
 
-	err = mt7925_mcu_sched_scan_req(mphy, vif, req);
+	err = mt7925_mcu_sched_scan_req(mphy, vif, req, ies);
 	if (err < 0)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index ef1d42af96f7..9993d47e643c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -192,6 +192,7 @@ mt7925_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			       bool suspend, struct cfg80211_wowlan *wowlan)
 {
 	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct ieee80211_scan_ies ies = {};
 	struct mt76_dev *dev = phy->dev;
 	struct {
 		struct {
@@ -227,7 +228,7 @@ mt7925_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		req.wow_ctrl_tlv.trigger |= (UNI_WOW_DETECT_TYPE_DISCONNECT |
 					     UNI_WOW_DETECT_TYPE_BCN_LOST);
 	if (wowlan->nd_config) {
-		mt7925_mcu_sched_scan_req(phy, vif, wowlan->nd_config);
+		mt7925_mcu_sched_scan_req(phy, vif, wowlan->nd_config, &ies);
 		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_SCH_SCAN_HIT;
 		mt7925_mcu_sched_scan_enable(phy, vif, suspend);
 	}
@@ -3085,6 +3086,54 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
 	return err;
 }
 
+static void
+mt7925_mcu_build_scan_ie_tlv(struct mt76_dev *mdev,
+			     struct sk_buff *skb,
+			     struct ieee80211_scan_ies *scan_ies)
+{
+	u32 max_len = sizeof(struct scan_ie_tlv) + MT76_CONNAC_SCAN_IE_LEN;
+	struct scan_ie_tlv *ie;
+	enum nl80211_band i;
+	struct tlv *tlv;
+	const u8 *ies;
+	u16 ies_len;
+
+	for (i = 0; i <= NL80211_BAND_6GHZ; i++) {
+		if (i == NL80211_BAND_60GHZ)
+			continue;
+
+		ies = scan_ies->ies[i];
+		ies_len = scan_ies->len[i];
+
+		if (!ies || !ies_len)
+			continue;
+
+		if (ies_len > max_len)
+			return;
+
+		tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_IE,
+					      sizeof(*ie) + ies_len);
+		ie = (struct scan_ie_tlv *)tlv;
+
+		memcpy(ie->ies, ies, ies_len);
+		ie->ies_len = cpu_to_le16(ies_len);
+
+		switch (i) {
+		case NL80211_BAND_2GHZ:
+			ie->band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			ie->band = 3;
+			break;
+		default:
+			ie->band = 2;
+			break;
+		}
+
+		max_len -= (sizeof(*ie) + ies_len);
+	}
+}
+
 int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req)
 {
@@ -3110,7 +3159,8 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 
 	max_len = sizeof(*hdr) + sizeof(*req) + sizeof(*ssid) +
 		  sizeof(*bssid) * MT7925_RNR_SCAN_MAX_BSSIDS +
-		  sizeof(*chan_info) + sizeof(*misc) + sizeof(*ie);
+		  sizeof(*chan_info) + sizeof(*misc) + sizeof(*ie) +
+		  MT76_CONNAC_SCAN_IE_LEN;
 
 	skb = mt76_mcu_msg_alloc(mdev, NULL, max_len);
 	if (!skb)
@@ -3192,13 +3242,6 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	}
 	chan_info->channel_type = sreq->n_channels ? 4 : 0;
 
-	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_IE, sizeof(*ie));
-	ie = (struct scan_ie_tlv *)tlv;
-	if (sreq->ie_len > 0) {
-		memcpy(ie->ies, sreq->ie, sreq->ie_len);
-		ie->ies_len = cpu_to_le16(sreq->ie_len);
-	}
-
 	req->scan_func |= SCAN_FUNC_SPLIT_SCAN;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_MISC, sizeof(*misc));
@@ -3209,6 +3252,9 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		req->scan_func |= SCAN_FUNC_RANDOM_MAC;
 	}
 
+	/* Append scan probe IEs as the last tlv */
+	mt7925_mcu_build_scan_ie_tlv(mdev, skb, &scan_req->ies);
+
 	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
 				    true);
 	if (err < 0)
@@ -3220,7 +3266,8 @@ EXPORT_SYMBOL_GPL(mt7925_mcu_hw_scan);
 
 int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 			      struct ieee80211_vif *vif,
-			      struct cfg80211_sched_scan_request *sreq)
+			      struct cfg80211_sched_scan_request *sreq,
+			      struct ieee80211_scan_ies *ies)
 {
 	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct ieee80211_channel **scan_list = sreq->channels;
@@ -3308,12 +3355,8 @@ int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 	}
 	chan_info->channel_type = sreq->n_channels ? 4 : 0;
 
-	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_IE, sizeof(*ie));
-	ie = (struct scan_ie_tlv *)tlv;
-	if (sreq->ie_len > 0) {
-		memcpy(ie->ies, sreq->ie, sreq->ie_len);
-		ie->ies_len = cpu_to_le16(sreq->ie_len);
-	}
+	/* Append scan probe IEs as the last tlv */
+	mt7925_mcu_build_scan_ie_tlv(mdev, skb, ies);
 
 	return mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
 				     true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 3dddadb7457b..c34b28769782 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -269,7 +269,7 @@ struct scan_ie_tlv {
 	__le16 ies_len;
 	u8 band;
 	u8 pad;
-	u8 ies[MT76_CONNAC_SCAN_IE_LEN];
+	u8 ies[];
 };
 
 struct scan_misc_tlv {
@@ -674,7 +674,8 @@ int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
 			      struct ieee80211_vif *vif);
 int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 			      struct ieee80211_vif *vif,
-			      struct cfg80211_sched_scan_request *sreq);
+			      struct cfg80211_sched_scan_request *sreq,
+			      struct ieee80211_scan_ies *ies);
 int mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
 				 struct ieee80211_vif *vif,
 				 bool enable);
-- 
2.34.1


