Return-Path: <linux-wireless+bounces-28444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DBCC2403D
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 10:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6404189BE9F
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A6632ED57;
	Fri, 31 Oct 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WTSqKpic"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6A32ED50
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901462; cv=none; b=lexwcz7A1LRNMsHsHlleCmIalc1+8E9rPmkVDFbZ5L9okRHuwe5f2bU88iQQyZy5EX1hvDT3wTGUAt3inLVm9FQL7IBVztPdApNDFujx26hwvhHK3LMCoEy5XOSJGrYqsSzyg2VuEoauhxlVHuyPBUgZy244s/fmaAYhfWYGNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901462; c=relaxed/simple;
	bh=rq2/OoMT7ysP+t5hQApf/70HOmI8gPJ1g+QG4rjzHPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nw7I1o3Qx+YSugvDkJ8h9PVQRBEoZVC/PbDTB41Dl9Bmi60SgaKgXx15aOuCekIGlHhXG3fxB2mHyJKfWBkQmWbjozYcr46pN2bOjxC9Y76HvsJLwXSVN+7U0RbeTOZefolLv+hhmWQ8d8XPCCu1dknZ1IxsvCsEKOETruCWHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WTSqKpic; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e7c40b0b63811f0b33aeb1e7f16c2b6-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UVR2Scq/9GM22BDLY2SnnA5vPchtACGhKdIGuNj9/y0=;
	b=WTSqKpics2Usu1MGKmzJ4WoptYImQszYRlrTX68XCJQRWs7cr8UnYm7dniklYYEWd12Q4FjAKOnrsdWqhDaiAOit4BvjEeOKFvzpFzGu0DR/cLvRMAUfDBNIhKmo/guYhkNCA2boy65dKtevNdhCQKn6IcnlOrxsL+72DOA9D4I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:85ebefd5-45bc-49ba-be11-9dfcd3c05c5c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:e3acc518-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e7c40b0b63811f0b33aeb1e7f16c2b6-20251031
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1089040581; Fri, 31 Oct 2025 17:04:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 17:04:05 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 17:04:05 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 4/6] wifi: mt76: mt7925: improve EHT capability control in regulatory flow
Date: Fri, 31 Oct 2025 17:03:50 +0800
Message-ID: <20251031090352.1400079-5-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
References: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
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

Move EHT flag handling into mt7925_regd_channel_update() to ensure
correct channel capability reporting.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c   |  2 --
 .../net/wireless/mediatek/mt76/mt7925/regd.c   | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index f9993f191448..92d7a6eb4179 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1376,8 +1376,6 @@ void mt7925_scan_work(struct work_struct *work)
 				if (!is_valid_alpha2(evt->alpha2))
 					break;
 
-				mt7925_regd_be_ctrl(phy->dev, evt->alpha2);
-
 				if (mdev->alpha2[0] != '0' && mdev->alpha2[1] != '0')
 					break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
index b36c6a6f5da6..12d8aac16e34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
@@ -83,6 +83,17 @@ mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 			dev->phy.clc_chan_conf &= ~MT7925_UNII_6G_IS_VALID;
 	}
 
+	sband = wiphy->bands[NL80211_BAND_2GHZ];
+	if (!sband)
+		return;
+
+	for (i = 0; i < sband->n_channels; i++) {
+		ch = &sband->channels[i];
+
+		if (!dev->has_eht)
+			ch->flags |= IEEE80211_CHAN_NO_EHT;
+	}
+
 	sband = wiphy->bands[NL80211_BAND_5GHZ];
 	if (!sband)
 		return;
@@ -93,6 +104,9 @@ mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 		/* UNII-4 */
 		if (IS_UNII_INVALID(0, 5845, 5925, ch->center_freq))
 			ch->flags |= IEEE80211_CHAN_DISABLED;
+
+		if (!dev->has_eht)
+			ch->flags |= IEEE80211_CHAN_NO_EHT;
 	}
 
 	sband = wiphy->bands[NL80211_BAND_6GHZ];
@@ -108,6 +122,9 @@ mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 		    IS_UNII_INVALID(3, 6525, 6875, ch->center_freq) ||
 		    IS_UNII_INVALID(4, 6875, 7125, ch->center_freq))
 			ch->flags |= IEEE80211_CHAN_DISABLED;
+
+		if (!dev->has_eht)
+			ch->flags |= IEEE80211_CHAN_NO_EHT;
 	}
 }
 
@@ -128,6 +145,7 @@ int mt7925_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
 	if (ret < 0)
 		goto err;
 
+	mt7925_regd_be_ctrl(dev, alpha2);
 	mt7925_regd_channel_update(wiphy, dev);
 
 	ret = mt7925_mcu_set_channel_domain(hw->priv);
-- 
2.34.1


