Return-Path: <linux-wireless+bounces-11538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752E954634
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C777A286592
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869F17622F;
	Fri, 16 Aug 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QWh7q0a1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09590171675
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801828; cv=none; b=DrCwEJ9ZBEEN1uX963oEqXMQN8MU9WbeiqgUHX7jw9OOKAd6TSUxszMmeRUml/zNTE+uUWNiRz21woTa6k03qvQH77ynCZ3ubI2AFH0K8HjjVPwzPccsvTHEqM8/qiLu6mSoUer0iRSMAeCkMJVzRZEhLBglm0YoIeSdFy3uyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801828; c=relaxed/simple;
	bh=RaV3qtCnPstsK7ByE4gMzETLydniKBcYcfBZWjg6vFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+TQyXLzQIVy+kvQ6mdKOrXr5HM0KIK+60JEfCZlth8CIT9BrWEvyddv6wwsyyNg5jeCTW4X0LvrwcMFkjiGrCASZwX44GI+hM8u6UmTiiVUYjXymd8Rq3Qfqr7SuxZWUMlIyjiV/ED3D8DmvaBsR2aoV24QGwjinsYX1aaQfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QWh7q0a1; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eee1501a5bb411ef8593d301e5c8a9c0-20240816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dWW2qUR66Hb1RoBcvM5ryAtigTehJELkTdNzwPDMe+k=;
	b=QWh7q0a1CeIcmiqMNhUigm0XC25qs7X0dgX91akg3I5xSRIzvTFwicEOiJOW68++gHzIXXjhVLCP/6b9QWmR2Q5tFwabl8+efXx8GfCkbtdorjvaCvr+E94rOl+7Nzl9h8nVkuAZvFCG/+X2f0am/mAZFRC0RgdLusUQhCast14=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:794bd816-a2d8-49f6-8a57-c7bbddf13831,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:1ead403f-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eee1501a5bb411ef8593d301e5c8a9c0-20240816
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 300556832; Fri, 16 Aug 2024 17:50:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Aug 2024 02:50:14 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Aug 2024 17:50:14 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 03/12] wifi: mt76: mt7996: fix wmm set of station interface to 3
Date: Fri, 16 Aug 2024 17:46:27 +0800
Message-ID: <20240816094635.2391-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240816094635.2391-1-shayne.chen@mediatek.com>
References: <20240816094635.2391-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

According to connac3 HW design, the WMM index of AP and STA interface
should be 0 and 3, respectively.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f3f78e11a65f..1ab2fb292266 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -206,7 +206,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	mvif->mt76.omac_idx = idx;
 	mvif->phy = phy;
 	mvif->mt76.band_idx = band_idx;
-	mvif->mt76.wmm_idx = vif->type != NL80211_IFTYPE_AP;
+	mvif->mt76.wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
 
 	ret = mt7996_mcu_add_dev_info(phy, vif, true);
 	if (ret)
-- 
2.39.2


