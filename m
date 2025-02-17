Return-Path: <linux-wireless+bounces-19058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0E5A37CED
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 09:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030CC3B0EFC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 08:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E31A3152;
	Mon, 17 Feb 2025 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CKcLsElR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840C19ABC2
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780260; cv=none; b=JkBZ6vdTvElQor9cmlA5r+HgG9oj81C48hEkU5Q06qx5HUslwZ+b33KiIkzsiuZYyU48xjY/L6AUalXw/Uh6pm8h/xhIYEyjExFF2S01T2C0gZ006CfMXilJvYkbpV7FqG8EulfNIJMTRYdNP5z3BtZUt/3eags0nNksZRIOByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780260; c=relaxed/simple;
	bh=bF0a/IkpMyhveh/0YJtcjCGRAW3EzNu18BCkrIKXgDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oR29oj5S4cZRu5b1EczBTW5KQiU2RegyQUx0ESvlO+LLSbw2AQ06QrCE643FofOLs/kkpjv3wjKynT70KXJw4JPnXPeSK+lugbpTAuZuqlyzDj7VRrlWj0G6crh+t1KehTaOr/mWDCh4N4M/yNoKERLGxGpgdoGS3d9tlqad2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CKcLsElR; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a2f0e8c0ed0711ef8eb9c36241bbb6fb-20250217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9fPO9d8tYshbXLSHxcUn0DWQk7YnJL564Z+u2kxwoI0=;
	b=CKcLsElRYJ9hxawIgWdhOUnsWm/tR5ytxi6+mpsTZWbpvYMzz+vW6cQLkQRAImEMDJfpNK8SSr8JxNqvD6IYXCXNmuObTHzjLhN3zj84ps82ObyZuho2KYL5Ou1OL/Rc+Sc9BGrHuuNxTB1HuoHLkmWFxY8OPtvPVsUU8c1a8pk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:59a48b1a-d7af-437d-86f6-f0caa8119a1c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:4fffdf24-96bd-4ac5-8f2e-15aa1ef9defa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a2f0e8c0ed0711ef8eb9c36241bbb6fb-20250217
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1300824870; Mon, 17 Feb 2025 16:17:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 17 Feb 2025 16:17:31 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 17 Feb 2025 16:17:31 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: introduce MLO capability control
Date: Mon, 17 Feb 2025 16:17:29 +0800
Message-ID: <20250217081729.1840930-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

This patch introduces MLO capability control for the MT792x Wi-Fi driver.
It removes the unused `MT792x_CHIP_CAP_MLO_EVT_EN` flag and introduces new
capability flags `MT792x_CHIP_CAP_MLO_EN` and `MT792x_CHIP_CAP_MLO_EML_EN`
to enable MLO and EML features based on firmware capabilities.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 10 ++++++++--
 drivers/net/wireless/mediatek/mt76/mt792x.h      |  3 ++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 98daf80ac131..ad47a4b153da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -251,7 +251,7 @@ int mt7925_init_mlo_caps(struct mt792x_phy *phy)
 		},
 	};
 
-	if (!(phy->chip_cap & MT792x_CHIP_CAP_MLO_EVT_EN))
+	if (!(phy->chip_cap & MT792x_CHIP_CAP_MLO_EN))
 		return 0;
 
 	ext_capab[0].eml_capabilities = phy->eml_cap;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 15815ad84713..5f40c3c1ffa1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2559,6 +2559,7 @@ mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 	struct ieee80211_vif *vif = link_conf->vif;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
+	struct mt792x_phy *phy = mvif->phy;
 	struct bss_mld_tlv *mld;
 	struct tlv *tlv;
 	bool is_mld;
@@ -2574,8 +2575,13 @@ mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 	mld->group_mld_id = is_mld ? mvif->bss_conf.mt76.idx : 0xff;
 	mld->own_mld_id = mconf->mt76.idx + 32;
 	mld->remap_idx = 0xff;
-	mld->eml_enable = !!(link_conf->vif->cfg.eml_cap &
-			     IEEE80211_EML_CAP_EMLSR_SUPP);
+
+	if (phy->chip_cap & MT792x_CHIP_CAP_MLO_EML_EN) {
+		mld->eml_enable = !!(link_conf->vif->cfg.eml_cap &
+				     IEEE80211_EML_CAP_EMLSR_SUPP);
+	} else {
+		mld->eml_enable = 0;
+	}
 
 	memcpy(mld->mac_addr, vif->addr, ETH_ALEN);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 32ed01a96bf7..454c6f523cc2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -27,8 +27,9 @@
 
 #define MT792x_CHIP_CAP_CLC_EVT_EN BIT(0)
 #define MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN BIT(1)
-#define MT792x_CHIP_CAP_MLO_EVT_EN BIT(2)
 #define MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN BIT(3)
+#define MT792x_CHIP_CAP_MLO_EN BIT(8)
+#define MT792x_CHIP_CAP_MLO_EML_EN BIT(9)
 
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
 #define MT792x_BASIC_RATES_TBL	11
-- 
2.45.2


