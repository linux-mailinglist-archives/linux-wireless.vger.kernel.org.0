Return-Path: <linux-wireless+bounces-28563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82051C34E34
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 10:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10EAF4FE46D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31BC30ACEA;
	Wed,  5 Nov 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z8KFrIy8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F430276A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335099; cv=none; b=NYO2WMalKlogiKW6t+jqfBsim3xSc85rhE/nYu+vesOI9AO4gE54PlZI1JL6K/h/WhGX5fmBgv6OjFmQ/BM5r3Fw3hxNx/rIdBEnLx4hDqsJLnG4fTxzWYyqlMRCdxRlJIHuomqnxt5jNX4sRKEKcF5FNnyEMhzQOn9A218zHN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335099; c=relaxed/simple;
	bh=j231RBczGYd+jG0Hqp3O/44PP6/KKhFDz2r4m03AiUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuE1AjkvwgA0iuyon9NDZ05PVNLK4sRGPzdIhzM3gPSnASyiTmr6MRHvkLzenQEqCDnZ4XvFxJx/1ZgOdqexngNScSojyHkbfP9DSlhQQ3FNHOlPXkPcrJQEOB+nF1ZEZvC+nNK+aS1NzsGKv7BZ09CAe3Lvk4CKeBmBS6mEiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Z8KFrIy8; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3660bddeba2a11f0b33aeb1e7f16c2b6-20251105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nIpLSysPm7kVFkPKaLEgh58So/Wz0cCH+wJpZ7kNnmg=;
	b=Z8KFrIy8Toj7lq24Vilkc0dDuNKHHpVDMP6yZNocK9vWpTve3g7os0wIrGJhn5HfS+OWSzonhoC0S9GITA0zSMQnk7lhCpmnW261t9mQJaVQH4Qu2/GFmTcWGgjWp28HPsLOqFlSZeCNZJ1M8Mn4+1HgLLlXdHv8IguwtBVoTLE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5da43c32-547a-4ad7-9eda-8397650a5e18,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:afbaef7c-f9d7-466d-a1f7-15b5fcad2ce6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3660bddeba2a11f0b33aeb1e7f16c2b6-20251105
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 976961817; Wed, 05 Nov 2025 17:31:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 5 Nov 2025 17:31:30 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 5 Nov 2025 17:31:29 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76 06/12] wifi: mt76: mt7996: fix teardown command for an MLD peer
Date: Wed, 5 Nov 2025 17:30:54 +0800
Message-ID: <20251105093100.541408-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251105093100.541408-1-shayne.chen@mediatek.com>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
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


