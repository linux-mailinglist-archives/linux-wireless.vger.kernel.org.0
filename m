Return-Path: <linux-wireless+bounces-26757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D7B39D7E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 14:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE9B174458
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC130F7FF;
	Thu, 28 Aug 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Yfe+R8iz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0BD30FC1D
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384827; cv=none; b=WFPje+whfRhmU4kUf5J5hAl8Z87y0bierO6kE7nHpYMKFC2xtiPev1bSMhurkwQqujJi4DlBvoJS2Tld9e88oO1FSeu3TF9BOVnZtajfQSIubWfqMvvdQqG7cl4xo9Ow9/nZcYu/xGPdfvIov2rPlO6GsquGRKe0DOhwN24vCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384827; c=relaxed/simple;
	bh=gitZwA9Rdi0mZYFEncSCbKq4GcOxNdWWGBBc2X3Ejp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bpqv6ioBK7mxfY5m4/seLdAeBz9F3cOIATqNU9BNH5U+PZUIndNsoLQM2QmxPI74JJpDKcvcVtNRTowN/9YkgSoOAU3unkFY/c7Ump0LMVsccaMQbcP0UHnsL689dNk1W3sP2iBlMU+JOagNZ+HG9fbdMNj83Q6AuWKAN7frb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Yfe+R8iz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 23534404840c11f0bd5779446731db89-20250828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=m2xtex3FijByy/xNVP17j+I3+wkiVmNm0DOFRB7Mm1g=;
	b=Yfe+R8izLOnhmeWYWdqXd6EOjADnas9jd8/SJRhrD+VXMu64lpcUzbB1Sej9J+fE5eDpybBVj0RZl6Mgkg8AhCqNUEkSNnzVSOIt49bKfjQEouUcfN6/oiUQLQKrFnCK95c12ABWd+pVYliQZ8lS7FtMPB4kSxoeGGiIzo0tEnU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:63a07ef8-c656-433f-8bcc-dccca383f17e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:c066f56b-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 23534404840c11f0bd5779446731db89-20250828
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1884910126; Thu, 28 Aug 2025 20:40:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 28 Aug 2025 20:40:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 28 Aug 2025 20:40:04 +0800
From: Quan Zhou <quan.zhou@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Shengxi Xu
	<shengxi.xu@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Quan Zhou <quan.zhou@mediatek.com>
Subject: [patch] wifi: mt76: mt7921: Add 160MHz beamformee capability for mt7922 device
Date: Thu, 28 Aug 2025 20:39:42 +0800
Message-ID: <ae637afaffed387018fdc43709470ef65898ff0b.1756383627.git.quan.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Enable 160MHz beamformee support on mt7922 by updating HE capability
element configuration. Previously, only 160MHz channel width was set,
but beamformee for 160MHz was not properly advertised. This patch
adds BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4 capability to allow devices
to utilize 160MHz BW for beamforming.

Tested by connecting to 160MHz-bandwidth beamforming AP and verified
HE capability.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 40954e64c7fc..8818fb1916ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -135,6 +135,8 @@ mt7921_init_he_caps(struct mt792x_phy *phy, enum nl80211_band band,
 			if (is_mt7922(phy->mt76->dev)) {
 				he_cap_elem->phy_cap_info[0] |=
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+				he_cap_elem->phy_cap_info[4] |=
+					IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_4;
 				he_cap_elem->phy_cap_info[8] |=
 					IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
 					IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
-- 
2.46.0


