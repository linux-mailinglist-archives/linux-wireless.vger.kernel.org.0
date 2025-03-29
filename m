Return-Path: <linux-wireless+bounces-20951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4BFA7570A
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 16:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C0716F122
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Mar 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A0B1DE3BD;
	Sat, 29 Mar 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ar6kEr2p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849941DDC2D
	for <linux-wireless@vger.kernel.org>; Sat, 29 Mar 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743263271; cv=none; b=hbhAxTSglh8ip8NfBDuUs1M1y+bgSt7JbHGmriScnovX+5dK3e+0BjdkrtIXyUwoRy3tynoyjiX8rTMeLPoO5kypo6AaHN9TPLxOs4+wRbh1dig7eJm2+ljo6+y0v5GQ0lARAivy6O9jE2Tcj7Ph/2jwtT4cdOp3RTP9lbbtwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743263271; c=relaxed/simple;
	bh=Q4VE8t9ItThyTfL+1ygTkvtqunsr4b/clJWK7KAeL4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiPfcBlq3bIO8mzH/rpHntNVFRtdqGTb41TTpltBpOP78nObVwCd5DUgQwQa6rV5gkYMuW7Vf650UjL145CqwS9u+K/D0JdhTGMu0XMk0FmUH+AZSXs8zjRl1yMtuTpsjw2mZcmD0ru+/ujMuawip/Xg+Mavq20DSsgzXcZKowk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ar6kEr2p; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 253322680cb511f08eb9c36241bbb6fb-20250329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/XYDXQmYMM1V6OMW8HHQUaP1GeieP5ZalW9lwYFoSIs=;
	b=Ar6kEr2pdWlaK4BKbUo8mOriCaobB9bID/oCAjpSalBU5Goivsvy9pv/btbhYhchg9Hb5IHfhPnQtdi1y3pjqaARtg2flACpxc7G2JrQrleYQvE5bdQ45FdvPFnn5U2IeuEauZ3U4k3xgRCbyN7om6wcI5d4RhtGasV0A76wpbo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:797ce2f5-2886-4a07-9070-b5a6deae9389,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:dcf9b64a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 253322680cb511f08eb9c36241bbb6fb-20250329
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 144544797; Sat, 29 Mar 2025 23:47:40 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sat, 29 Mar 2025 23:47:38 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sat, 29 Mar 2025 23:47:38 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH mt76-next v2 10/10] wifi: mt76: mt7996: add PCI device id for mt7990
Date: Sat, 29 Mar 2025 23:47:30 +0800
Message-ID: <20250329154731.2113551-11-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250329154731.2113551-1-shayne.chen@mediatek.com>
References: <20250329154731.2113551-1-shayne.chen@mediatek.com>
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


