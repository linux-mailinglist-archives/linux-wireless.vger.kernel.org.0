Return-Path: <linux-wireless+bounces-26889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2FBB3DB10
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B941687CF
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301072264B7;
	Mon,  1 Sep 2025 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kJZFpHwN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399726C39F
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711931; cv=none; b=r01Poh874WzrhHykJRbXgmYI3hBy3992u5LhtGfPedzXEYNPrLP+u/6Ej7ppYF664DbONVzd8qNbdoeSvsHA8DGTg0Xs5/g2AlUr64CFpT4BEAkpyNadVocYKyaS1M6Z58Ex2L4fCCODfHaK8MfRJ9QdsyjbHZBzo9pM6CecACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711931; c=relaxed/simple;
	bh=Zy9Qt1iTy3d6QCq7OrU5x+D3hYROjzS/HIWqP/0dVkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s6OkhZsJSDfYvgHsZ8K2PtjcbeOON20qmZluohFEsP1REXIl5LxlIM99xx2bg09C0XHw8TagGl97RBUHmmKtiGGMXA5Ir86X0x++NiCV4uJZzHzOgAz2cwg6rSkW2WXMxYD8rTLYK7Id20GBmJH3lyeTKSZkgFM45BLY0AtbcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kJZFpHwN; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c0af0e8a870511f0b33aeb1e7f16c2b6-20250901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nkCIubutJycJl/A+gBZ1Ci2tKUm1/PnTAAjLguTK4SE=;
	b=kJZFpHwNSL1B5/QKD2OtlYbTAQtZm4xNtPleXxIZQZKiAIoXtTOBF3HpVm+La74sV2H8Vsoc/PykDuVG4Whhoz7LoV5+wTpsl0RHnIiVB0Ctntgs73njffVgpqeu11ihTEuhySPkzQ0KttVqh3vV2c7tsTdWmsQghbekKDcJfR0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:ab044c9a-67d8-4e1f-a544-34cc6a120c9b,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:f1326cf,CLOUDID:53764d84-5317-4626-9d82-238d715c253f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c0af0e8a870511f0b33aeb1e7f16c2b6-20250901
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 437045553; Mon, 01 Sep 2025 15:32:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 1 Sep 2025 15:32:01 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 1 Sep 2025 15:32:01 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Jack Kao <jack.kao@mediatek.com>, Ming
 Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: add pci restore for hibernate
Date: Mon, 1 Sep 2025 15:32:00 +0800
Message-ID: <20250901073200.230033-1-mingyen.hsieh@mediatek.com>
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

From: Jack Kao <jack.kao@mediatek.com>

Due to hibernation causing a power off and power on,
this modification adds mt7925_pci_restore callback function for kernel.
When hibernation resumes, it calls mt7925_pci_restore to reset the device,
allowing it to return to the state it was in before the power off.

Signed-off-by: Jack Kao <jack.kao@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/pci.c   | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 387d56893ecb..b5a6eaa6c11a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -541,7 +541,7 @@ static int mt7925_pci_suspend(struct device *device)
 	return err;
 }
 
-static int mt7925_pci_resume(struct device *device)
+static int _mt7925_pci_resume(struct device *device, bool restore)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
@@ -581,6 +581,9 @@ static int mt7925_pci_resume(struct device *device)
 	napi_schedule(&mdev->tx_napi);
 	local_bh_enable();
 
+	if (restore)
+		goto failed;
+
 	mt76_connac_mcu_set_hif_suspend(mdev, false, false);
 	ret = wait_event_timeout(dev->wait,
 				 dev->hif_resumed, 3 * HZ);
@@ -597,7 +600,7 @@ static int mt7925_pci_resume(struct device *device)
 failed:
 	pm->suspended = false;
 
-	if (err < 0)
+	if (err < 0 || restore)
 		mt792x_reset(&dev->mt76);
 
 	return err;
@@ -608,7 +611,24 @@ static void mt7925_pci_shutdown(struct pci_dev *pdev)
 	mt7925_pci_remove(pdev);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(mt7925_pm_ops, mt7925_pci_suspend, mt7925_pci_resume);
+static int mt7925_pci_resume(struct device *device)
+{
+	return _mt7925_pci_resume(device, false);
+}
+
+static int mt7925_pci_restore(struct device *device)
+{
+	return _mt7925_pci_resume(device, true);
+}
+
+static const struct dev_pm_ops mt7925_pm_ops = {
+	.suspend = pm_sleep_ptr(mt7925_pci_suspend),
+	.resume  = pm_sleep_ptr(mt7925_pci_resume),
+	.freeze = pm_sleep_ptr(mt7925_pci_suspend),
+	.thaw = pm_sleep_ptr(mt7925_pci_resume),
+	.poweroff = pm_sleep_ptr(mt7925_pci_suspend),
+	.restore = pm_sleep_ptr(mt7925_pci_restore),
+};
 
 static struct pci_driver mt7925_pci_driver = {
 	.name		= KBUILD_MODNAME,
-- 
2.34.1


