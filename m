Return-Path: <linux-wireless+bounces-28653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F4DC394AC
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 07:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26ADF1A400D7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 06:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFFB2DEA62;
	Thu,  6 Nov 2025 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DMg+l7Vl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354D2DAFD6
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411391; cv=none; b=FuhtcQhQDGR7lGpVHTV9653OuwcGyZr8a1lcHt0/qmo2a8g/vr4J9Tk5ya9udjYidxeR0TRPvTB+T1455FpQ+4XX2WZivd8dNA+NCbvrW8KeyTJplgwm7PRmzhtpMqPEmy1cJSivrk4oQghtV/xBZE/FMRYm/TrPYgkTITdO6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411391; c=relaxed/simple;
	bh=EqAIERvdkUMhhnFzYJ9Gqz3i88iIUnixklNh4mJklDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHN7OeKp2xVtbiNfaoj6gmb8MDlGKo2bpNeBmAG1czClB8BvNZAdzPpD1LEMmfjDvb2pVQWNvjR+h5auRrzQZH74+gl8CtXS1Pt2NQnE/aE1WVxeVmvdPcMcktTWr2XOcQqNqwJmAJeWSk6kKcg+X58egZEPKFxtHLgSTwQfA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DMg+l7Vl; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d6fab90abadb11f08ac0a938fc7cd336-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HlleefOGqDI7WB5rz/eNIviQlaFR9g8Db9YwxCvzqJg=;
	b=DMg+l7VlURFxQRKf1eUyy/vDnkXmFozG3U9rCFEMa3g9pkN/7lx4Luvw9FIOZs6znMNlYEWqt405EteOcPLOxfEXI4OrDoh174JrCmoVcgrVDlE7NsCXIXpHapAPJF4Zs8Z89emvIYVZWnG42ExLNOKMQvgOyjhGy0VpxF7RIjU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b256c5cf-926d-4d35-9f48-dcfd3a5b94c3,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:e26d31e0-3890-4bb9-a90e-2a6a4ecf6c66,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d6fab90abadb11f08ac0a938fc7cd336-20251106
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1093157797; Thu, 06 Nov 2025 14:43:01 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 14:43:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 14:43:00 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 v2 06/12] wifi: mt76: mt7996: fix teardown command for an MLD peer
Date: Thu, 6 Nov 2025 14:41:57 +0800
Message-ID: <20251106064203.1000505-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251106064203.1000505-1-shayne.chen@mediatek.com>
References: <20251106064203.1000505-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

For an MLD peer, we only need to call the teardown command when removing
the last link, and there's no need to call mt7996_mcu_add_sta() for the
earlier links.

Fixes: c1d6dd5d03eb ("wifi: mt76: mt7996: Add mt7996_mcu_teardown_mld_sta rouine")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 5e0b57657e7e..685be98b9f27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1206,13 +1206,13 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 				mt7996_mac_twt_teardown_flow(dev, link,
 							     msta_link, i);
 
-			if (sta->mlo && links == BIT(link_id)) /* last link */
-				mt7996_mcu_teardown_mld_sta(dev, link,
-							    msta_link);
-			else
+			if (!sta->mlo)
 				mt7996_mcu_add_sta(dev, link_conf, link_sta,
 						   link, msta_link,
 						   CONN_STATE_DISCONNECT, false);
+			else if (sta->mlo && links == BIT(link_id)) /* last link */
+				mt7996_mcu_teardown_mld_sta(dev, link,
+							    msta_link);
 			msta_link->wcid.sta_disabled = 1;
 			msta_link->wcid.sta = 0;
 			links = links & ~BIT(link_id);
-- 
2.51.0


