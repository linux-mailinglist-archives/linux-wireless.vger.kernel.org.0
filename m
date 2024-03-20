Return-Path: <linux-wireless+bounces-4977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33B1881082
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC731F23AF1
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4813FBBE;
	Wed, 20 Mar 2024 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Fl8G3QP7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907F3FBB2
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932979; cv=none; b=MXhp8VIuSEespuNsIuTtlk4CsuIWipezCL6Aue3F5VD/hJeByKpdTk4eqzTzeZmJHfdxGHwRoukMOcDUid4l/SWDdQdI/74BSrFjPvAw55jwyRSWE7R8z0KOGqD5snTK/c0y2LsQoXDpUeIDtITxRAAthJN2W/qTbOigciE6a/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932979; c=relaxed/simple;
	bh=+j53oCYm9KhKA++JU2qI6mmi/RT3kjI/VHswK5c6OPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgcdWYSuk1RcC7nPUrxKqXyNmTHy8vsMWKRzHWKGlZelbsit9D84vzLFYPZavCLpNBAReuAGCfmI0ww0HZBGaUsZqKaUNHIJI0Cstfy58urd0w7wb4wMuqCroUiIBuzNZZuzcNsTxQLIGjvh6zXUFZXOMjsDrOEpa7Oxrtzpav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Fl8G3QP7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5064aa56e6aa11ee935d6952f98a51a9-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=K+MGvbJYjhy895if8D0sU6axrp3f+KhPZVFX8vDFO74=;
	b=Fl8G3QP7SKNDfmM+koblgjFicKJ7WTtg+7qcPXzyN8kID7RDOychurrr0Cdcz5HygyQJteBvhnff9luIWTv3YrFfnm3Weo2CmnZl92UwxCie1rRUkQZcw0Y1o8fxsXsRzQcfE8Pohx0+CkOR+zlCO9s7OzoufhCEFAlo7kZLm48=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c5190fa3-047e-412e-8ffb-ebd43f67468f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:f3d9b881-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5064aa56e6aa11ee935d6952f98a51a9-20240320
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 520570354; Wed, 20 Mar 2024 19:09:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 19:09:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 19:09:24 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Henry Yen <henry.yen@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 10/10] wifi: mt76: mt7996: add sanity check for NAPI schedule
Date: Wed, 20 Mar 2024 19:09:18 +0800
Message-ID: <20240320110918.3488-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240320110918.3488-1-shayne.chen@mediatek.com>
References: <20240320110918.3488-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.702000-8.000000
X-TMASE-MatchedRID: t43B5J96WnnRf7QIWE0s11Pjo7D4SFg4gQP483M95wG7+NPPxj+R6t/Z
	UmGP9YkbhowmdCKCKbJQvZkUW2KxIxTHZeyG5hlHKaMQ6tw7oDJMkOX0UoduuQqiCYa6w8tvwnA
	mnjhKdO06hUOcTonr9IAy6p60ZV62fJ5/bZ6npdjKayT/BQTiGvSCB5CtNVQm9h6EyZUhUzJM/6
	T6cXS4kA7HGxMqtNz79LqXQCbqlpj98p0nQevxSqjbnW3VwgJ6XTIolEqa8UudEJeX4QSuE6DE4
	wLr4uZ8dATQdtPksR+3/JiWOe6GXXSWgQ2GpXdZbxffl9hhCBw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.702000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	023958FE130D5E334E7896CE6F46781782A9312B444C4D588DFEA1FE25D904B22000:8
X-MTK: N

From: Henry Yen <henry.yen@mediatek.com>

It's observed that host driver might occasionally receive
interrupts from unexpected Rx ring, whose Rx NAPI hasn't been
prepared yet. Under such situation, __napi_poll crash issue
would occur, so we add a sanity check to prevent it.

Without this patch, we might encounter kernel crash issue
especially in WED-on & RRO-on software path.

Signed-off-by: Henry Yen <henry.yen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 304e5fd14803..6de5b7de4ac8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -560,7 +560,7 @@ static void mt7996_irq_tasklet(struct tasklet_struct *t)
 		napi_schedule(&dev->mt76.tx_napi);
 
 	for (i = 0; i < __MT_RXQ_MAX; i++) {
-		if ((intr & MT_INT_RX(i)))
+		if ((intr & MT_INT_RX(i)) && dev->mt76.napi[i].poll)
 			napi_schedule(&dev->mt76.napi[i]);
 	}
 
-- 
2.39.2


