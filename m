Return-Path: <linux-wireless+bounces-17047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A44A009F5
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC2218846EF
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD91CC8AD;
	Fri,  3 Jan 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j+64qWbK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20B158553
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911365; cv=none; b=DTAcYqfPfBaW6383onIGUfor9KwvBpg+KQmK1Pfam8Gg6TwTfbfLCYbRUG6xqHWUmV8WtKg/koEx8kcW/bc+FM2KPeg5ZPdo8L78pC2UwEc0WgbH93UZ+NPFZ5dcfFEMS6sQtg5AUmXqqVy6L9cjzIQ/p/9phBGp45JLTEW5RJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911365; c=relaxed/simple;
	bh=r3j+j4GKWYnoJZdBp6n7amyr9HDE0yqNqsGi75Py3p0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R2DNJ5xV147sJRFXVB9CDj1dcNkeYgPCRRJEvL8LiC7eRJ6ou5QWyM1HIUqB+EbGVH/k+8ORXxCDU/aLZ1Zn2rKkwFK3ogekL6myUjN+u/U5IAfas7cLytgR0awj9iVHs1fQmCFtOvvpRUifJXukXfCBnABkmby8RjTbaxkclgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=j+64qWbK; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a971543ac9d711ef99858b75a2457dd9-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AGPGvDHbpAwdRmyIJMz22n/2IZGZe9b81RunQ2EKrU8=;
	b=j+64qWbKob8uE4uA7S9ua+yqkY/afnHFMnrYHp+03+lyl22zmTj/HH0IfnLRzFZJBTIBaJ7l7Gctr9TNsSnSNk+sWjNxxbOszyT5JsStZo2TFffAi1XQSKiLAvx6Ha95CsDvoKBtOaJbV2N2MG3a3yrCk7Ap92iiniaeyrFJEy0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:364ab611-db0d-48bb-9bf3-86ca49389fc5,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:8afe9d25-8650-4337-bf57-045b64170f0c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a971543ac9d711ef99858b75a2457dd9-20250103
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 155058519; Fri, 03 Jan 2025 21:35:56 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 21:35:55 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 21:35:54 +0800
From: Quan Zhou <quan.zhou@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Shengxi Xu
	<shengxi.xu@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Quan Zhou <quan.zhou@mediatek.com>
Subject: [patch] wifi: mt76: mt7925: fix the unfinished command of regd_notifier before suspend
Date: Fri, 3 Jan 2025 21:35:59 +0800
Message-ID: <3af7b4e5bf7437832b016e32743657d1d55b1f9d.1735910288.git.quan.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Before entering suspend, we need to ensure that all MCU command are
completed. In some cases, such as with regd_notifier, there is a
chance that CLC commands, will be executed before suspend.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index ddc654b9ea5e..34b6adc5ea0e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -79,11 +79,14 @@ mt7925_regd_notifier(struct wiphy *wiphy,
 	mdev->region = req->dfs_region;
 	dev->country_ie_env = req->country_ie_env;
 
+	dev->regd_in_progress = true;
 	mt792x_mutex_acquire(dev);
 	mt7925_mcu_set_clc(dev, req->alpha2, req->country_ie_env);
 	mt7925_mcu_set_channel_domain(hw->priv);
 	mt7925_set_tx_sar_pwr(hw, NULL);
 	mt792x_mutex_release(dev);
+	dev->regd_in_progress = false;
+	wake_up(&dev->wait);
 }
 
 static void mt7925_mac_init_basic_rates(struct mt792x_dev *dev)
@@ -226,6 +229,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
 	init_waitqueue_head(&dev->pm.wait);
+	init_waitqueue_head(&dev->wait);
 	spin_lock_init(&dev->pm.txq_lock);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt792x_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7925_scan_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 9aec675450f2..4986aaccc753 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -455,6 +455,9 @@ static int mt7925_pci_suspend(struct device *device)
 	if (err < 0)
 		goto restore_suspend;
 
+	wait_event_timeout(dev->wait,
+			   !dev->regd_in_progress, 5 * HZ);
+
 	/* always enable deep sleep during suspend to reduce
 	 * power consumption
 	 */
-- 
2.46.0


