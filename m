Return-Path: <linux-wireless+bounces-2530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7776583D714
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B557B1F23A1C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1A125C3;
	Fri, 26 Jan 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OTBiLRr8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064D6310D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260199; cv=none; b=HmyWcMnboSYxMffLGx3xrLbNpSbn24swI0sBnxlhh14572Y+AWcjDLqo113VD7RM74WxY7CTYcXekL1gZGzC5gjvf1o0VqAq0ji3ovre98cQQotI4VHNVcoRIkMukBI4t2EomwN/8pBrpKd8PTbh2h5GL9is1J8KefZeix2X7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260199; c=relaxed/simple;
	bh=oRyqXoM8YZHfXOuzS8BiI1xnzhAbJKa4p3TDnqR0/kE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWEgBtekiPrm16c4T50wJIOCw5mJnf8Eed6z90B664hWSCM7VFoKz2rmnEyFCDut2ZF5vwLFr3x6W/fwM1C574tIk/wVgRejfKQ2/huR9OhRVAv4HWrYkuQTMGF2L7poTBlXOfxbFdKFo4H7Ov+CB6WqzoLHTy/07CaLI7WtzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OTBiLRr8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a9a3e438bc2a11ee9e680517dc993faa-20240126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BJ0SqrDpCqnZYAflAHsK8+u/jhmOLqrfhMsxL0zC1AQ=;
	b=OTBiLRr8gGNOwKMYahJhDKvNq/FSxW3Yzf7i66BvzcGKS63KeI0FBi/r/maLlmI/GMnIt33ruRsjZE58p405TU6jq1U+alwU+PhumRX7pdhskOwySDaH/PZuNR+jJxDH8pirvdtKMbFE7Hir+jJnRvthGqIXmgHXX0SomFbSeok=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:efe2b1b4-2579-43bd-a18c-b5cc8fbd8eca,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:7e74c97f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a9a3e438bc2a11ee9e680517dc993faa-20240126
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 290733679; Fri, 26 Jan 2024 17:09:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 Jan 2024 17:09:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 Jan 2024 17:09:50 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 09/12] wifi: mt76: mt7996: remove TXS queue setting
Date: Fri, 26 Jan 2024 17:09:20 +0800
Message-ID: <20240126090923.6357-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240126090923.6357-1-shayne.chen@mediatek.com>
References: <20240126090923.6357-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

DMA queue settings of TXS will be initialized by the firmware.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 1a1a60744272..5ae56b10f2b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -507,11 +507,6 @@ void mt7996_mac_init(struct mt7996_dev *dev)
 		mt76_rmw_field(dev, i, MT_LED_GPIO_SEL_MASK, 4);
 	}
 
-	/* txs report queue */
-	mt76_rmw_field(dev, MT_DMA_TCRF1(0), MT_DMA_TCRF1_QIDX, 0);
-	mt76_rmw_field(dev, MT_DMA_TCRF1(1), MT_DMA_TCRF1_QIDX, 6);
-	mt76_rmw_field(dev, MT_DMA_TCRF1(2), MT_DMA_TCRF1_QIDX, 0);
-
 	/* rro module init */
 	if (is_mt7996(&dev->mt76))
 		mt7996_mcu_set_rro(dev, UNI_RRO_SET_PLATFORM_TYPE, 2);
-- 
2.39.2


