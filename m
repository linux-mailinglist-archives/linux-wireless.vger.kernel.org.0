Return-Path: <linux-wireless+bounces-20375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3AA60D83
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 10:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B298813E2
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA84157A5C;
	Fri, 14 Mar 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cDcTFHob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B6D1A8401
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945090; cv=none; b=no0bDfu/16l2X4KlTMZ2qbmUEJPOcQzIJuKzF4hXoyVAuAVpwckHe2nVj1moVJ5Wgj1QBu42LBpePCOITsjGuGcjWngf3BSynC6MmqlJ3P9rKy3sYk8XskIWbhQGY+cLvg32ZgZpHIqwewXZx/gSZRrSeSu2sXM5Zw9+JoKjjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945090; c=relaxed/simple;
	bh=bQQbwlVjvTSdz6VKAmyKRQ1Igf3jE3exD3gF8Kq+Vjw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bU64b+cuXC7Evqb1zZk2Efj7TiSKlDeT4LZVms6NxSK3AJTWo3jFEjdDHpGUrdcgQo3/PwXztVpjotiZhmNazpF0nWI1IAVBVqmtebADwuTYgtf9dbvIiZ8UMflASWAZ2Gxuxj6u8f/1CEcjyprFpm3v8QwwlJQ7zdu+Ba8rXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cDcTFHob; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0580f64200b811f0aae1fd9735fae912-20250314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pT4Y4e7aLl3+3ZM1qlwcE/maNrW32eLdx9IF4cMnNpM=;
	b=cDcTFHobCox1OJbG/lXpi7+SwlFBI+DXbo5gVC2BM3OyRGcCqiwDFlB+Nt3GCSGWhURBcgVpYJgLZ9GXFArjOeAJSlEcCzinRFd1ABa7HNKnaai8rZ/wa+lV4alC3tyO+unRj+mllrN+95GPe1bX80eUi3OSCaqGbk9xjonIhQM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:457852f7-e006-4322-beff-3ee4e7dd124c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:c9821b4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0580f64200b811f0aae1fd9735fae912-20250314
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 344479273; Fri, 14 Mar 2025 17:38:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 17:38:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 17:38:00 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<MingYen.Hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: update MLO cleanup flow during disconnection
Date: Fri, 14 Mar 2025 17:37:51 +0800
Message-ID: <20250314093751.2860504-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>

Refine the disconnection cleanup process for MLO. It introduces a dedicated
function to handle device removal, ensuring proper resource cleanup for both
BSS and device information.

Fixes: 21e40c17361e ("wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure")
Signed-off-by: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 30 +---------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 56 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  2 +
 3 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 191b378fc44b..748cbb19ba76 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1245,40 +1245,14 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
-	struct {
-		struct {
-			u8 omac_idx;
-			u8 band_idx;
-			__le16 pad;
-		} __packed hdr;
-		struct req_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 active;
-			u8 link_idx; /* hw link idx */
-			u8 omac_addr[ETH_ALEN];
-		} __packed tlv;
-	} dev_req = {
-		.hdr = {
-			.omac_idx = 0,
-			.band_idx = 0,
-		},
-		.tlv = {
-			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
-			.len = cpu_to_le16(sizeof(struct req_tlv)),
-			.active = true,
-		},
-	};
 	unsigned long rem;
 
 	rem = ieee80211_vif_is_mld(vif) ? msta->valid_links : BIT(0);
 
 	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
 
-	/* recovery omac address for the legacy interface */
-	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
-	mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
-			  &dev_req, sizeof(dev_req), true);
+	if (ieee80211_vif_is_mld(vif))
+		mt7925_mcu_del_dev(mdev, vif);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 698003582829..03f6da4d829d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2907,6 +2907,62 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
+void mt7925_mcu_del_dev(struct mt76_dev *mdev,
+			struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 link_idx; /* hw link idx */
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = true,
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_bss_basic_tlv basic;
+	} basic_req = {
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_basic_tlv)),
+			.active = true,
+			.conn_state = 1,
+		},
+	};
+
+	dev_req.hdr.omac_idx = mvif->omac_idx;
+	dev_req.hdr.band_idx = mvif->band_idx;
+
+	basic_req.hdr.bss_idx = mvif->idx;
+	basic_req.basic.omac_idx = mvif->omac_idx;
+	basic_req.basic.band_idx = mvif->band_idx;
+	basic_req.basic.link_idx = mvif->link_idx;
+
+	mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE),
+			  &basic_req, sizeof(basic_req), true);
+
+	/* recovery omac address for the legacy interface */
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+	mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
+			  &dev_req, sizeof(dev_req), true);
+}
+
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_bss_conf *link_conf,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 463c7e4ab806..a2613ae4d4c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -631,6 +631,8 @@ int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 int mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
 				 struct ieee80211_vif *vif,
 				 bool enable);
+void mt7925_mcu_del_dev(struct mt76_dev *mdev,
+			struct ieee80211_vif *vif);
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_bss_conf *link_conf,
-- 
2.34.1


