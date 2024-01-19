Return-Path: <linux-wireless+bounces-2235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE72832609
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E61C22B54
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729A22318;
	Fri, 19 Jan 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I/LwDJas"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593471E89A
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705654665; cv=none; b=nXwmHOWxj/XAMTfXG/K74hl59NgWLINTtg7+BXtB8+HEywc1TTSjD0pud4LfXZrDcukTRRfMrq9BUJOm5ngkeca05KzZmwGmgq+fgzEXviwS+7r1GnAZj9ojlG8ZRx7KvFqoutDEQ+LJec6Wjn2rlp91knA7boaS7YFgCCZ+6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705654665; c=relaxed/simple;
	bh=TIQVWHy2JeByAOssW+huxkDCGg0L7fL6Pvf8CR29hpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAOBAFMEdKnMCo+6z0reaCrXu8xNory/pnTUmZUcXxkdqYYmgq1Tf4VHLlq3or7PuaiSLOkgg56kp54XCP0tyNBwpZU6oNl2VXscT+T8i85yL9Ckdj0R5x1mrtmpSsnPKcMNDdq/6ZKKrhcumxMWlBVOS2dMM+78IK9R8Xln+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=I/LwDJas; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cba82724b6a811eea2298b7352fd921d-20240119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Mxe9YMOLMzMZFhwTa8VmHQ3UMCw1Y/jz7/bPWaSqf7w=;
	b=I/LwDJasM0riZBGPLvqjtrmVHiKP5EyHVFWvyybJGdc+FR9BHDBt1xrQn4U58gX8PjrrR1E8Hb5tMPGiHQQpQORvVgDfx7IT4oDgCb+QsOpnxE97UX5eZ3VhNXzfKvxGDUlI+6JNVcA3vEOzSk8yCDQho4NYuZ2oDiqda/0HYFQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:7e1e4312-4c60-4181-90b6-8eeadb421a2d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:1e7b6e8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cba82724b6a811eea2298b7352fd921d-20240119
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 499192073; Fri, 19 Jan 2024 16:57:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Jan 2024 16:57:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Jan 2024 16:57:37 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Benjamin Lin
	<benjamin-jw.lin@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 12/12] wifi: mt76: mt7996: fix HIF_TXD_V2_1 value
Date: Fri, 19 Jan 2024 16:57:08 +0800
Message-ID: <20240119085708.23592-12-shayne.chen@mediatek.com>
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
X-MTK: N

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

Sync the value of HIF_TXD_V2_1 with firmware to let it correctly fill
TXD values for HW path.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 5ae56b10f2b9..283df84f1b43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -493,7 +493,7 @@ static void mt7996_mac_init_basic_rates(struct mt7996_dev *dev)
 
 void mt7996_mac_init(struct mt7996_dev *dev)
 {
-#define HIF_TXD_V2_1	4
+#define HIF_TXD_V2_1	0x21
 	int i;
 
 	mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
-- 
2.39.2


