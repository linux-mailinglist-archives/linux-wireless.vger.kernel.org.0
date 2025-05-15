Return-Path: <linux-wireless+bounces-22972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE54AB7C55
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E41B65CDE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 03:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D95296710;
	Thu, 15 May 2025 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gm2d30Kw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1A1A2396
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 03:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279976; cv=none; b=BXpzlqXi9HZptYpTqyhlTRtuVGCIJUIuG3pUYxjo/C9eErtgS2CqtlhrI0yrJJ4dQaXWjlHSGsG5RkOCcutKYpoFsTMJE6Y75g8Sn+UOpQA8hqGjza2gtijHmEMp2oDEl62cNN4FUCvssaA3tAcIfAqDeGNYWBs3qjm2NGMK+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279976; c=relaxed/simple;
	bh=eMaSbxRHT7sRaat2c8aKInbGnCca/U8s6xfNZ79xXss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoK+ckW7cn/PKuOPkyNIGDYlmibbGs5NYR8G1rNGSU2U5UUbiEcS2BWRx0HVCj2Gt3roH/5W+T0OsHoE8Jo38naDI7R1HgCZZqWyQMgM4keDi27EkBsHT4f49rVuHDVNrOJ2eP1ReFv7NyStk8R+dZ3cs2+GlvalGjRmpq2PpNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gm2d30Kw; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 41c6cc66313d11f0813e4fe1310efc19-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ahqVB/novhOH9WPxx6JgqGkGBvhwvp7jmdh5ETAPdCM=;
	b=gm2d30KwAwyxNDFnbbT3LsbxAKVs8BYDNLOVa0t8frc5sSdUZSBg2jG+9vxcNxSneRttMv66KC7arbETAE3QXFvw3XbIZyRqGUgZnY2Hg6dHLUJMaCN3UdZoJDW5cb6FcXVnuj0ZuhrestRMwfXO7XYZxyGFV12bsFas+1mBM7Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:2726ee72-ea8c-4a6e-aa4a-15075c4ec49c,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:feef053e-da74-431d-a7be-5e6761de3b64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 41c6cc66313d11f0813e4fe1310efc19-20250515
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 922981204; Thu, 15 May 2025 11:32:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 11:32:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 11:32:39 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH mt76-next 7/9] wifi: mt76: mt7996: fix RX buffer size of MCU event
Date: Thu, 15 May 2025 11:29:50 +0800
Message-ID: <20250515032952.1653494-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515032952.1653494-1-shayne.chen@mediatek.com>
References: <20250515032952.1653494-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Some management frames are first processed by the firmware and then
passed to the driver through the MCU event rings. In CONNAC3, event rings
do not support scatter-gather and have a size limitation of 2048 bytes.
If a packet sized between 1728 and 2048 bytes arrives from an event ring,
the ring will hang because the driver attempts to use scatter-gather to
process it.

To fix this, include the size of struct skb_shared_info in the MCU RX
buffer size to prevent scatter-gather from being used for event skb in
mt76_dma_rx_fill_buf().

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index fe8cc1d3f738..c8bef0b2a144 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -531,7 +531,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU],
 			       MT_RXQ_ID(MT_RXQ_MCU),
 			       MT7996_RX_MCU_RING_SIZE,
-			       MT_RX_BUF_SIZE,
+			       MT7996_RX_MCU_BUF_SIZE,
 			       MT_RXQ_RING_BASE(MT_RXQ_MCU));
 	if (ret)
 		return ret;
@@ -540,7 +540,7 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
 			       MT_RXQ_ID(MT_RXQ_MCU_WA),
 			       MT7996_RX_MCU_RING_SIZE_WA,
-			       MT_RX_BUF_SIZE,
+			       MT7996_RX_MCU_BUF_SIZE,
 			       MT_RXQ_RING_BASE(MT_RXQ_MCU_WA));
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index c75189a02316..1ad6bc046f7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -29,6 +29,9 @@
 #define MT7996_RX_RING_SIZE		1536
 #define MT7996_RX_MCU_RING_SIZE		512
 #define MT7996_RX_MCU_RING_SIZE_WA	1024
+/* scatter-gather of mcu event is not supported in connac3 */
+#define MT7996_RX_MCU_BUF_SIZE		(2048 + \
+					 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
 #define MT7996_DEVICE_ID		0x7990
 #define MT7996_DEVICE_ID_2		0x7991
-- 
2.39.2


