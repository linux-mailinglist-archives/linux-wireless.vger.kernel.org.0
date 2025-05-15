Return-Path: <linux-wireless+bounces-22969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C03AB7C52
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6721B65C90
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 03:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B430F2957C2;
	Thu, 15 May 2025 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WL6mXQS3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13D291144
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279970; cv=none; b=YtV2G+mazWAZIs7eFnylXiAfycwVdof2xk9/dGhYiIaVtpAWOR88ZMTcpJDZ6SqGnQhLq1zwOhJagMEW+iFFbYYy0JBScCO7rUoBKVVfcGrUrIOPgvK8f2Ebp9i8N0ljmKsWbt5VxZftkCgz9xSIpXH7wzHTF/fQCh8Qu4Y2PxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279970; c=relaxed/simple;
	bh=f3Z/AW52TFrordPsUGi5u/sTYnNe3ThmKZTtWzuZqrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2aOjS+PtUhDjd5ooBC4PWQ7MGdXyfAoBSuWHqmdjOmTaaXIGkQC5k803+WdEQ1NNPjkxxubT1Xirs9adxlhIaJqAU+sAYsNBZkmtIPFoVfIxyAcCuuvMXtWBNJ0I6788Z614vezVHlx6AQVGc34G1cOG5DmGfTBC5uJapnMwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WL6mXQS3; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 41724236313d11f082f7f7ac98dee637-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hhzOnWNQUrGBWcXNK3dZjOdfeVg68JVfRSkvjXYMkho=;
	b=WL6mXQS3uW9Kf1uUSzFxPYuxNDCjIcxlwA6LyCZaQAms3r+/u0OOqSLcb1+vJFrK9jM2oeDp2KHJvQOmYWQ5os3pXu86UU5DGJjoJDEUKqwZRp5yeOVHXqJFqk1zoUCPuV12ilBh3izvn/7lnmlO0Tuk4mmr7afyEXXaYMcqTw8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:17ceff0e-3d3c-4adc-adb7-a3f1574958a0,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:faef053e-da74-431d-a7be-5e6761de3b64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 41724236313d11f082f7f7ac98dee637-20250515
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 80395500; Thu, 15 May 2025 11:32:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 11:32:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 11:32:39 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next 3/9] wifi: mt76: mt7996: set EHT max ampdu length capability
Date: Thu, 15 May 2025 11:29:46 +0800
Message-ID: <20250515032952.1653494-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515032952.1653494-1-shayne.chen@mediatek.com>
References: <20250515032952.1653494-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Set the max AMPDU length in the EHT MAC CAP. Without this patch, the
peer station cannot obtain the correct capability, which prevents
achieving peak throughput on the 2 GHz band.

Fixes: 1816ad9381e0 ("wifi: mt76: mt7996: add max mpdu len capability")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5c545293f294..213c7bcd4ade 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1326,6 +1326,9 @@ mt7996_init_eht_caps(struct mt7996_phy *phy, enum nl80211_band band,
 		u8_encode_bits(IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454,
 			       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 
+	eht_cap_elem->mac_cap_info[1] |=
+		IEEE80211_EHT_MAC_CAP1_MAX_AMPDU_LEN_MASK;
+
 	eht_cap_elem->phy_cap_info[0] =
 		IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
 		IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
-- 
2.39.2


