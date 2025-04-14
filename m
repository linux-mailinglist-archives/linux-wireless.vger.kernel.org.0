Return-Path: <linux-wireless+bounces-21480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3EBA8754E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 03:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FB216F80D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672CC189F57;
	Mon, 14 Apr 2025 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A/v1c6XT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C854670
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744594806; cv=none; b=fdOmYNpMrhv157j4JL4CCAw5w9AJOo2TY43JCrsmUirCscHAjxSL41BKe81xTvUL7FaxKGN6/ghhfktPYeUve/LN3LXi7a29OFnokx31ZiiOXSlIx5ZofO3vJccWPWF74ZFqTmRIh8L9Fn4WVca+/qKu2gU8+K2BUEpN72jDS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744594806; c=relaxed/simple;
	bh=+iE9O2RNjTJMi3DFWz+e6H/duEVpIgGWlGnN3zviaTg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWtoI61M9R33a6s5ZZinbQLB8ZdcHFJoz1vPDf+yqSkuROrVduRZC8krReAdFZavtoJOV9ifiwsyWzAx7AaU1eQZOQkFhyuColI2w+mUzjveAnJ1NADN4od8gj+0Wp+HyVqhSExG4GEzuWfGRpRu5q7ecstPjKied2JKnC0+HJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=A/v1c6XT; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5f9cc6c018d111f0aae1fd9735fae912-20250414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zQJiN28fwUgubuHePtoHyZEwChoQ1+xaiRmHGpEGKKU=;
	b=A/v1c6XTnZuiHoFPkk4aDv1VwB3YoVDLqWtG945Jwv4X/KoFII/RIYvwJvI6St1mA0GIVdVTl6D8SkswH+ldWWbaPnyy2+7J4hzvzG43y4F6IAY63MSSeb+kbLyKaMSeOIDtIqaQU7JInODdQE+LB7KZfxaxXuxcjFpCDh1dndM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:834cac41-6aca-4950-a99f-7d3dd0a61ac3,IP:0,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-30
X-CID-META: VersionHash:0ef645f,CLOUDID:cf7f8f8d-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:2,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5f9cc6c018d111f0aae1fd9735fae912-20250414
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 324859104; Mon, 14 Apr 2025 09:39:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 14 Apr 2025 09:39:56 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 14 Apr 2025 09:39:56 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 1/3] wifi: mt76: mt7925: prevent multiple scan commands
Date: Mon, 14 Apr 2025 09:39:52 +0800
Message-ID: <20250414013954.1151774-1-mingyen.hsieh@mediatek.com>
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

Add a check to ensure only one scan command is active at a time
by testing the MT76_HW_SCANNING state.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 71d721ded9c1..8909d76f4795 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2791,6 +2791,9 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct tlv *tlv;
 	int max_len;
 
+	if (test_bit(MT76_HW_SCANNING, &phy->state))
+		return -EBUSY;
+
 	max_len = sizeof(*hdr) + sizeof(*req) + sizeof(*ssid) +
 		  sizeof(*bssid) * MT7925_RNR_SCAN_MAX_BSSIDS +
 		  sizeof(*chan_info) + sizeof(*misc) + sizeof(*ie);
-- 
2.34.1


