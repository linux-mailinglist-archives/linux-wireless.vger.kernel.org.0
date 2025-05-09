Return-Path: <linux-wireless+bounces-22766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBC2AB0D33
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053EB1BC3A86
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167BA26FA5F;
	Fri,  9 May 2025 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hzNkfv1M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E17270EBD;
	Fri,  9 May 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779724; cv=none; b=sxwTS8nKF2nH4NKVF2YdrLu6BQ5WCwGR2HHnMQHLTwYkds7ze36z9BZP70a4Ii0H8bu3c12FNg0GY6ZsYU83579ooChsL2sAmGFrGPLEg9Rvr8BHlmGKwzuF9yN+gq6N9apakgI4NwKn2y4NW49PqlFMSLesUm+0YkbSbZitTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779724; c=relaxed/simple;
	bh=UvRJaADQeexzHO6XRUbmIZdBNzwZG0ITKjQHHHN91wc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FBAYFR6x6abg7Tbj7ojpA9foGa4KdlBrFvg0Z0/dsaQq/K6LsC0yLth0ZX3f7CB7QAyr4paKIbpJwzZwJucaBv0GHGKIwZ0hf9RMBhkpwIunGDACsiUFweRvNFbKipQjMl5DBbr0DWvlFHBGOcqC7MVwxBjBv58HbOyY+fAkPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hzNkfv1M; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 87a360e62cb011f082f7f7ac98dee637-20250509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2QBZdqUD0wmXVQHDoMG3Kt28wCUDOmMZ3X3RH175Sj0=;
	b=hzNkfv1MDhn9IBklXR8EqXdt0aRqgeSl78sVjO/Kc3gaVEFBfwcyASQlkHsYH3/Bg6ouCoSXTHUZYMnpBq5QeO7QHWlQssEyKZ3BRw/HrZQnK5lJ2JuowQmC+mcvrXKMgD8dPK7G0CAEe01CmThtpod33u2NRhK6V26ILiFgwRI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:c1b4c1d6-a82f-4798-a55e-12e1f329df88,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:f9c75751-76c0-4e62-bb75-246dfb0889c6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 87a360e62cb011f082f7f7ac98dee637-20250509
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 687543649; Fri, 09 May 2025 16:35:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 9 May 2025 16:35:13 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 9 May 2025 16:35:13 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	<stable@vger.kernel.org>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: fix host interrupt register initialization
Date: Fri, 9 May 2025 16:35:12 +0800
Message-ID: <20250509083512.455095-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Michael Lo <michael.lo@mediatek.com>

ensure proper interrupt handling and aligns with the hardware spec by
updating the register offset for MT_WFDMA0_HOST_INT_ENA.

Cc: stable@vger.kernel.org
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 3 ---
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c7b5dc1dbb34..2e20ecc71207 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -490,9 +490,6 @@ static int mt7925_pci_suspend(struct device *device)
 
 	/* disable interrupt */
 	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
-	mt76_wr(dev, MT_WFDMA0_HOST_INT_DIS,
-		dev->irq_map->tx.all_complete_mask |
-		MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
 
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 985794a40c1a..547489092c29 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -28,7 +28,7 @@
 #define MT_MDP_TO_HIF			0
 #define MT_MDP_TO_WM			1
 
-#define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x228)
+#define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x204)
 #define MT_WFDMA0_HOST_INT_DIS		MT_WFDMA0(0x22c)
 #define HOST_RX_DONE_INT_ENA4		BIT(12)
 #define HOST_RX_DONE_INT_ENA5		BIT(13)
-- 
2.34.1


