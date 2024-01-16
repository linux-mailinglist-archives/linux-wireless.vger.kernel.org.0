Return-Path: <linux-wireless+bounces-1955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA10882E7FD
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 03:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6C4284AA7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 02:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F0E6FB6;
	Tue, 16 Jan 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j38GZNfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D629AB
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d2cbb2d2b41911ee9e680517dc993faa-20240116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rs5pQYtsKDPVyUyAZq52hdzZEfSXXLZ+MVuujaBw8OU=;
	b=j38GZNfmS9goJtb0CezpnXcNl2xuqLX4ctmFAqHQ8wX8ZPK+vmTz9sAP/5UAQCd12fkTRq/t4MPaMICsm7dVKCy9HIuv7AzF/h/6yaREjZFg7AC7b4HEQVooeb2BtrhtnnyoM9RD8S64i4bLIvVWL8/m/aZu+avpZHXEhYsAOlA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a4a8d79f-e020-488d-a407-a8c4711cc9fb,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:964b342f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d2cbb2d2b41911ee9e680517dc993faa-20240116
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 116684859; Tue, 16 Jan 2024 10:49:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Jan 2024 10:49:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Jan 2024 10:49:08 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Leon Yen <leon.yen@mediatek.com>
Subject: [PATCH v2 4/4] wifi: mt76: mt7921: fix the unfinished command of regd_notifier before suspend
Date: Tue, 16 Jan 2024 10:48:57 +0800
Message-ID: <20240116024857.9071-5-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240116024857.9071-1-mingyen.hsieh@mediatek.com>
References: <20240116024857.9071-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Before entering suspend, we need to ensure that all MCU command are
completed. In some cases, such as with regd_notifier, there is a
chance that CLC commands, will be executed before suspend.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
---
v2:
 After "mt7921_regd_update" the "regd_in_progress" should reset to false.

 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 3 +++
 drivers/net/wireless/mediatek/mt76/mt792x.h      | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 48433c6d5e7d..ef0c721d26e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -138,9 +138,14 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	if (pm->suspended)
 		return;
 
+	dev->regd_in_progress = true;
+
 	mt792x_mutex_acquire(dev);
 	mt7921_regd_update(dev);
 	mt792x_mutex_release(dev);
+
+	dev->regd_in_progress = false;
+	wake_up(&dev->wait);
 }
 
 int mt7921_mac_init(struct mt792x_dev *dev)
@@ -261,6 +266,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	spin_lock_init(&dev->pm.wake.lock);
 	mutex_init(&dev->pm.mutex);
 	init_waitqueue_head(&dev->pm.wait);
+	init_waitqueue_head(&dev->wait);
 	if (mt76_is_sdio(&dev->mt76))
 		init_waitqueue_head(&dev->mt76.sdio.wait);
 	spin_lock_init(&dev->pm.txq_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 57903c6e4f11..8b226b731ec9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -409,6 +409,9 @@ static int mt7921_pci_suspend(struct device *device)
 	if (err < 0)
 		goto restore_suspend;
 
+	wait_event_timeout(dev->wait,
+			   !dev->regd_in_progress, 5 * HZ);
+
 	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
 	if (err)
 		goto restore_suspend;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 3c897b34aaa7..a8556de3d480 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -186,6 +186,8 @@ struct mt792x_dev {
 	bool hw_init_done:1;
 	bool fw_assert:1;
 	bool has_eht:1;
+	bool regd_in_progress:1;
+	wait_queue_head_t wait;
 
 	struct work_struct init_work;
 
-- 
2.18.0


