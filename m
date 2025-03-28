Return-Path: <linux-wireless+bounces-20916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E9A743A4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DDA3AE9C4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B51211479;
	Fri, 28 Mar 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cH54Iq3I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E541C5F26
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141246; cv=none; b=Uf2PHe3Hq2fXFZx+Ua4eOx8PwdjF7qtR8VXnXzmOMQkAewtMw6Wktog1v9zLlAz+59omtiYuWkdMJaT2oeGJlWFVYykx4izJ7gkwfDNbIoXcnBqNZGanI4BpHJMV63ZoFkEXyQsbNVqYPC2vDAArcvTS4vCaKCxzfGpz9zbc0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141246; c=relaxed/simple;
	bh=Q4VE8t9ItThyTfL+1ygTkvtqunsr4b/clJWK7KAeL4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvgZlRkiz9GvOAGd5NNHF/2S3vriuebGwc7KK8VRpAjHnHWblL0Nz5RZMM/d7iCNZqKTXkfM/hfVWQfarLbOEE475akUQqevLSrfyUR5dZ6AGVlRHW0zkCmQypXYH1yOeGCk0p7DidG/kZDftYfYNDeRzGrYmTSk3OX3krchYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cH54Iq3I; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0b3acf4a0b9911f08eb9c36241bbb6fb-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/XYDXQmYMM1V6OMW8HHQUaP1GeieP5ZalW9lwYFoSIs=;
	b=cH54Iq3I+jdhwVExSOr3jEYvVTcsA/64d2mJqr03vq4Z40nbYLk3v3+K+xpZo/EwS73seKSpmSQul7HjK2RhrfA9B16cCeVzLcrRwm/14f33LxVqdafX4gczReBHKEWF9VXvOZPs3mTnQigSQGqFyXWNw9CQiSSlCKOieBUdKAs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:518e6083-7d32-420e-b0c7-e201364c7f5a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:0b9c67a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0b3acf4a0b9911f08eb9c36241bbb6fb-20250328
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 436127430; Fri, 28 Mar 2025 13:53:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 28 Mar 2025 13:53:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 28 Mar 2025 13:53:58 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 10/10] wifi: mt76: mt7996: add PCI device id for mt7990
Date: Fri, 28 Mar 2025 13:50:58 +0800
Message-ID: <20250328055058.1648755-11-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328055058.1648755-1-shayne.chen@mediatek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Add PCI device IDs to enable support for mt7990 chipsets.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 05248339a17b..19e99bc1c6c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -18,12 +18,14 @@ static u32 hif_idx;
 static const struct pci_device_id mt7996_pci_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7996_DEVICE_ID) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7992_DEVICE_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7990_DEVICE_ID) },
 	{ },
 };
 
 static const struct pci_device_id mt7996_hif_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7996_DEVICE_ID_2) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7992_DEVICE_ID_2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7990_DEVICE_ID_2) },
 	{ },
 };
 
@@ -64,7 +66,8 @@ static struct mt7996_hif *mt7996_pci_init_hif2(struct pci_dev *pdev)
 	hif_idx++;
 
 	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7996_DEVICE_ID_2, NULL) &&
-	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7992_DEVICE_ID_2, NULL))
+	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7992_DEVICE_ID_2, NULL) &&
+	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7990_DEVICE_ID_2, NULL))
 		return NULL;
 
 	writel(hif_idx | MT_PCIE_RECOG_ID_SEM,
@@ -122,7 +125,8 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 	mt76_pci_disable_aspm(pdev);
 
 	if (id->device == MT7996_DEVICE_ID_2 ||
-	    id->device == MT7992_DEVICE_ID_2)
+	    id->device == MT7992_DEVICE_ID_2 ||
+	    id->device == MT7990_DEVICE_ID_2)
 		return mt7996_pci_hif2_probe(pdev);
 
 	dev = mt7996_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
-- 
2.39.2


