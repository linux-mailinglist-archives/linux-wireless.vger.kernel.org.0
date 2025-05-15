Return-Path: <linux-wireless+bounces-22966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9EAB7C4E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5A73BA4A8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 03:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D734E2A1AA;
	Thu, 15 May 2025 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r4cROpUf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3026ACC
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279954; cv=none; b=YcJInPw3GauzuvPrnC/RVHPUoU60Wx+WiTc0iy4SeV+jnuyjVRPDiYwRKYt+ONzojK6LxCP1dQCo197bO9p7Unw4Fv/N5W/yabb3rAcA7Ckolu2OrvXrShtPIMdb5t2X0DwSZvdhG/fKcPNZCOLx0rj39buJRaYdc0x8+1mzl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279954; c=relaxed/simple;
	bh=g4tml8U+yY4KFwCWnfcZcnAO35D37/RG4P0ZmE0KozQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxGmrTVe0akLDS9MiRxJmJfzgBfGYA3eJQQiicB7PhOkXnY4zsTNq7hxIa2r/k95db3RRPro9gvbL/VjudjqoTOzHfslG3MUBdy12cvUXvbIRa3gIxddrkP4cIVnhlqM2KBTXKI9Ct3KBP1gI/z+TnZfVTNeD5w+KJ4lNTRFMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r4cROpUf; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 38bd60a8313d11f082f7f7ac98dee637-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3K/f5mhODlHnxjiEqczjt+u+aWnUiRKgE22cEWh8NEA=;
	b=r4cROpUffZLMYXfAupD1VDgIYW9pnsdoaotLYhMmIFsFWSmrRSyuVSvs+CMISWa7cjZLdf6mtaIsBYQrRjopZgXRW+FV6El2HFMpcYQwx4723lcuxB9/SnE3PrN+lodWmNp9TRunf0SlPgU/YAs+1DtHfQSQw0oO+kG30Q7UvUw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:69c66235-d226-4ef2-b262-227cdee96667,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:3eabbe97-7410-4084-8094-24619d975b02,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 38bd60a8313d11f082f7f7ac98dee637-20250515
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 887132071; Thu, 15 May 2025 11:32:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 11:32:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 11:32:24 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Howard Hsu
	<howard-yh.hsu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next 2/9] wifi: mt76: mt7996: fix beamformee SS field
Date: Thu, 15 May 2025 11:29:45 +0800
Message-ID: <20250515032952.1653494-2-shayne.chen@mediatek.com>
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

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Fix the beamformee SS field for the mt7996, mt7992 and mt7990 chipsets.
For the mt7992, this value shall be set to 0x4, while the others shall
be set to 0x3.

Fixes: 5b20557593d4 ("wifi: mt76: connac: adjust phy capabilities based on band constraints")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index b77fa94df8c7..5c545293f294 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1121,12 +1121,12 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 
 	c = IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE;
 
-	if (is_mt7996(phy->mt76->dev))
-		c |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4 |
-		     (IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4 * non_2g);
-	else
+	if (is_mt7992(phy->mt76->dev))
 		c |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_5 |
 		     (IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_5 * non_2g);
+	else
+		c |= IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4 |
+		     (IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4 * non_2g);
 
 	elem->phy_cap_info[4] |= c;
 
-- 
2.39.2


