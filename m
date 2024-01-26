Return-Path: <linux-wireless+bounces-2534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A383D716
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7902C1C2D1F2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF26312C;
	Fri, 26 Jan 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KRIo7nEg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF901B96E
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260205; cv=none; b=B+fPeB0v7DiO2ugHGOy2bBWIdtwzVau7C40FkAgrBBdEJO2tfrWJLGysG8UDCRSmQWhR8XKA2DGn6XZO0kWBu4ct4gJwFpwsWuzQ/jnUmSFyXWzZnwGpJLTD3th1WL0PW9teD2aQASkuUP+7FpVrgnlSvHLItQ+LDgOj421Mexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260205; c=relaxed/simple;
	bh=TIQVWHy2JeByAOssW+huxkDCGg0L7fL6Pvf8CR29hpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0xB60zYa8vBHr57eJflgbBqWbMSNDwdN6mtwwNjgMfBQewlXPIBYPDBpS24cL3P4TRd1FCJ0xYRI0+gKb4rnCMv/mIlA9NLYFp5GMsLybNhK0hXAiZvtL8/XuriOikDHBR8kKEB24jNkjhQsOygbRWTGcIIc+5caD6MyGg9xx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KRIo7nEg; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a9e2fd44bc2a11eea2298b7352fd921d-20240126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Mxe9YMOLMzMZFhwTa8VmHQ3UMCw1Y/jz7/bPWaSqf7w=;
	b=KRIo7nEgxTlNqe1PUJybsK5fFAI2tYBvpiCFxcD3Fp5TnonnCZXps8vMuRYWP70W7Y6U+n2I9KBWBI1ERbhiJOhse6HL5cXKpEdgVuruDkcDZzFWKifgolYj4f6Q2rUQZyPSlUb+8qykA6vTeL0h40kQZJpG+X1FxlmqXEy3aZs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:f76d6f8f-0aea-4648-8d79-e88da76b4df3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:b974c97f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a9e2fd44bc2a11eea2298b7352fd921d-20240126
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 72412560; Fri, 26 Jan 2024 17:09:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
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
	<linux-mediatek@lists.infradead.org>, Benjamin Lin
	<benjamin-jw.lin@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 12/12] wifi: mt76: mt7996: fix HIF_TXD_V2_1 value
Date: Fri, 26 Jan 2024 17:09:23 +0800
Message-ID: <20240126090923.6357-12-shayne.chen@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-1.565400-8.000000
X-TMASE-MatchedRID: WhX2Z2Jh4guxPzLFhIhLtOqwWVBfMuvosf4f4CxxueRcKZwALwMGs/6g
	KWYq1ITooTxdbGQ8kfwC3W6W/V0xYnEjLiYgp5vhA9lly13c/gH0O7M3lSnTWw5SzgJNSArLGYZ
	yDsDw4jHdy+E+4eJ1r2a39PjWf0NNHxPMjOKY7A8LbigRnpKlKZvjAepGmdoOTKHZx+R6KtXPRO
	JT51I+rEROU9MQMinQGBAxtnogc5AVoqRZnecrH3pFLImwD75PAOE1irTUDeivoYiLu4poEs6yD
	Lli/pujSZrfNhP3sgUBh9AgBSEFrJm+YJspVvj2xkvrHlT8euIlGuy8+eyjlw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.565400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5E2EC1A1DF91FA96178C79B55395F2805A57A6958C40654228BD4E0C9028858B2000:8
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


