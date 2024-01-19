Return-Path: <linux-wireless+bounces-2233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C295832607
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80AE285811
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD3E200DE;
	Fri, 19 Jan 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="npcHudFY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC661E897
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654664; cv=none; b=updZkskTiriw2SzJQMHgQhwrS4OWId6Y0VdXnT1opTVXuVzoFiyXwgTscfFBv0+R4+/qDSPy7brWX0I5E/1Odo02kqdr1vTvIGaUpXZGbg7F5rWgl+kVeTODSp8CMFHtQ+wyJbUXmUu+c6/T5ooTtyXay+PzCdVH9JcXHcJ+9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654664; c=relaxed/simple;
	bh=oRyqXoM8YZHfXOuzS8BiI1xnzhAbJKa4p3TDnqR0/kE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxDO1BvU9sTbX6Osz+0WQWCRRuPzbvYXM/J6hl/Tq6JCFLaseY/y4W9ckZY+xxaa/xqLHHAuZZ+bCz7QcyCztNrtmXHlwwPRSQP3xWj5Awr4INPMceLoyCnDbxVjmtP+9sPulEXvPzGTwVmm2Ue4E9UB9N6yRCsCLd1xcjUFyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=npcHudFY; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cb3ab342b6a811ee9e680517dc993faa-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BJ0SqrDpCqnZYAflAHsK8+u/jhmOLqrfhMsxL0zC1AQ=;
	b=npcHudFYw+JE4i0RWvde+MOewi+MdD3Vnj0foq3HmNRDdagtBcNoFHHRNfq6wZokUaNN34XEPz/WzYpb6p4wVXs4UWaMgbAkiNEK3u4oB2mt6VxFNKG557fCasDaijkj4nT+9Hxt+4BjqjYGNFjE+OBgcFcE9sqgkVQTfnGi0hY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:ff33b61d-ac9f-49e7-a2ec-27d8af6f0b65,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:35bd582f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cb3ab342b6a811ee9e680517dc993faa-20240119
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 346368108; Fri, 19 Jan 2024 16:57:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jan 2024 16:57:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jan 2024 16:57:36 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 09/12] wifi: mt76: mt7996: remove TXS queue setting
Date: Fri, 19 Jan 2024 16:57:05 +0800
Message-ID: <20240119085708.23592-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240119085708.23592-1-shayne.chen@mediatek.com>
References: <20240119085708.23592-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.136400-8.000000
X-TMASE-MatchedRID: K2+WBV866GAVAKRaMHqjDp7tR0mnRAg1WDLajM22ETb/mpvOG+QCxGb6
	PphVtfZgsNV8m2Omj9WAMuqetGVetnyef22ep6XYymsk/wUE4hoLG5FW/oUH2X6+otVvpGvg79N
	tqUTGm/7Z+SNyTS8g/rGUvZLrN57u
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.136400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 11DBD51384D9160F3FEEA72E6DEC9BE9DDF368A630A91AFC1F9B93F66A3F8F082000:8
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


