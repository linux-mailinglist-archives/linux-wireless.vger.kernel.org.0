Return-Path: <linux-wireless+bounces-22974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE685AB7C5B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA964C68AB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 03:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3FD26ACC;
	Thu, 15 May 2025 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ROzWTW4R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643A1C5D53
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280385; cv=none; b=o7OzSm7/cGEet+wfO1uQzwVQEUTMkPudoijO6+AXQRbYS3sbO/4vROcoEONHiREtaOfEbkuPm+56DlFPcHP48ueHVG0nUHwpLyCQ3vxpVzV1EJm11kDxGBOrnAeGKi1FlkaetgFYWRxVTM+WBU5QRQI3SIw28cK+gkQ7YjBaPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280385; c=relaxed/simple;
	bh=8rNPCz1CYSaoWiu0XANCt9X+eVaZ8f7dMUDW1M6i+k4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L0RpcQJmUQMFLBhQ7shAklTwqsVeqb1XnRxNcsnEbpOV0mLAri5o3OCQQwHZK9bwj1IMkDBPcTcNTRUyv+mAuEB9g/3A1/GppzvVbQqf8DZP6cy/VLoXCXSxA9ei4A6x/B0/8jrFnksrrhC8SfOG4p/6kN85IY9oG9m5ZeYBvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ROzWTW4R; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 38e0bbba313e11f0813e4fe1310efc19-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ck8E0kmNPsQLnL9s9n5lfaUDgq87CH2pQ5H2DVdTpco=;
	b=ROzWTW4RzrTP8Ip5r6VhAd7RE/27ib5WqaXo+C6xDOBcFaBFWjvg2TRsxJo6R8vvDCOGtbQ0UPpn0HHR3QQpsqFIOfL4Vq8V+Khi3g+RbRdzUT3iFfYf5Cr3Ej0HzD7ite7cdfqlpHtZq9MIWhKVP/GYaPb7GuwsjTp4j2ycxhs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:54cb0e6c-36ed-4f8e-a272-120d9ee42974,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:c90d01c0-eade-4d5b-9f81-31d7b5452436,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 38e0bbba313e11f0813e4fe1310efc19-20250515
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 831273323; Thu, 15 May 2025 11:39:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 11:32:15 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 11:32:15 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next 1/9] wifi: mt76: remove capability of partial bandwidth UL MU-MIMO
Date: Thu, 15 May 2025 11:29:44 +0800
Message-ID: <20250515032952.1653494-1-shayne.chen@mediatek.com>
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

From: Howard Hsu <howard-yh.hsu@mediatek.com>

The firmware only supports full bandwidth UL MU-MIMO, so remove the
partial bandwidth capability from HE PHY CAP.

Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 57d5be94624b..be9527dd0269 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -925,8 +925,7 @@ mt7915_set_stream_he_txbf_caps(struct mt7915_phy *phy,
 
 	c = IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US;
 	if (!is_mt7915(&dev->mt76))
-		c |= IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
-		     IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+		c |= IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
 	elem->phy_cap_info[2] |= c;
 
 	c = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index ff835a6f77ce..b77fa94df8c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1116,8 +1116,7 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 	elem->phy_cap_info[7] &= ~IEEE80211_HE_PHY_CAP7_MAX_NC_MASK;
 
 	c = IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
-	    IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
-	    IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+	    IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
 	elem->phy_cap_info[2] |= c;
 
 	c = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE;
-- 
2.39.2


