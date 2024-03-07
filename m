Return-Path: <linux-wireless+bounces-4449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69861874B37
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 10:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CBC283C00
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790E384FAA;
	Thu,  7 Mar 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cDL8lAj6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679DF839FE
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804806; cv=none; b=X5QF9utS1nkQWYqs5yDFkhQOEFhG7HkqdUU3pkkHqy3RKu2PqiQuoiz5DGNnqWtfGkkcQq9Sy9yi3UcCxw5qJo68ONVPtJOB5y+W2L4E7ZzhEwkTaxnBkAA1BpvIaCTFe9vH4ez5y8DlbA3OfvjzO7elkJnAH/BggWvMHN3DsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804806; c=relaxed/simple;
	bh=aE0P/I9MimmZDXK7fECRVNPlLjLg8jwfVYsyDHGXnBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KEEM3QYj7AEyfrkWRWm+rM2Vrn9/2uFEa4np4DHpNLG8QjF+mxWZskS0VSTDVipIWlgn7wMMIUy1/dJ6poNtqjDF0VTejrF4VPzPp+e2rJvpxZamTr5MuMN4Z4Q3z2KfHXBaIzcLPTWc6E6LqBljl0805a9f6xAKKuRRVUBF0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cDL8lAj6; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9777d15edc6711eeb8927bc1f75efef4-20240307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cDwewr94viCP0HwMbysx6bAqUHjnkE31vXLiSH3xJjU=;
	b=cDL8lAj6M1wA/54a5xV24ra5uZN6OGf/24TUlBpS3pCrH446/ALLu1gNluJtiotlj5aOYzGNZ28PPMo+mVN93aGBk94RN8VeY80MZiiOF0ns6074XQj8NEYyA/b2CUWKX2I8Ndt8LWvNzn6Y5nNbTIUHqV880SrAZdyXNIAkoB4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:eff87113-86af-404a-8575-9108d1d3dd07,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:29082190-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9777d15edc6711eeb8927bc1f75efef4-20240307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1102334042; Thu, 07 Mar 2024 17:46:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Mar 2024 17:46:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Mar 2024 17:46:35 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Leon Yen <leon.yen@mediatek.com>, "Ming
 Yen Hsieh" <MingYen.Hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921s: fix potential hung tasks during chip recovery
Date: Thu, 7 Mar 2024 17:46:32 +0800
Message-ID: <20240307094632.21638-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.482200-8.000000
X-TMASE-MatchedRID: BF/mp1RsF79X3cGZowF380hEDfw/93BugQP483M95wFh2fnHe1cil3pt
	C95MCcU350LRIq48WpLvKOYqns9K5YdO+dHJdtOqH5YQyOg71ZZUENBIMyKD0Z6fSoF3Lt+MIA6
	D0Tft3i8SOLmgpsr0im5D1dJNZVNGYf4+ATMa0GuHZXNSWjgdU273ma3jsPM2ta3+iMLLdN8glz
	H/IwfDMcIXl3iP70Q4bmFMcyfDfoAoeQN21jrIqUZakoam9+aeMVx/3ZYby7/uxO+ZKScKRqPFj
	JEFr+olwXCBO/GKkVr3FLeZXNZS4KBkcgGnJ4WmW0jeEK7aWWMHt/b3mOdz0U+DGfGDEvNRwOxN
	ZGMpQrh+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.482200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 77BCF30B649236999228776849688CE98C0BA8729BAB87AB2E8F4A171FC22AF32000:8

From: Leon Yen <leon.yen@mediatek.com>

During chip recovery (e.g. chip reset), there is a possible situation that
kernel worker reset_work is holding the lock and waiting for kernel thread
stat_worker to be parked, while stat_worker is waiting for the release of
the same lock.
It causes a deadlock resulting in the dumping of hung tasks messages and
possible rebooting of the device.

This patch prevents the execution of stat_worker during the chip recovery.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  | 2 --
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c | 2 --
 drivers/net/wireless/mediatek/mt76/sdio.c            | 3 ++-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 867e14f6b93a..73e42ef42983 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -663,6 +663,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	int i, ret;
 
 	dev_dbg(dev->mt76.dev, "chip reset\n");
+	set_bit(MT76_RESET, &dev->mphy.state);
 	dev->hw_full_reset = true;
 	ieee80211_stop_queues(hw);
 
@@ -691,6 +692,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	}
 
 	dev->hw_full_reset = false;
+	clear_bit(MT76_RESET, &dev->mphy.state);
 	pm->suspended = false;
 	ieee80211_wake_queues(hw);
 	ieee80211_iterate_active_interfaces(hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index c866144ff061..031ba9aaa4e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -64,7 +64,6 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 	mt76_wr(dev, dev->irq_map->host_irq_enable, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
 
-	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
@@ -115,7 +114,6 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 
 	err = __mt7921_start(&dev->phy);
 out:
-	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	local_bh_disable();
 	napi_enable(&dev->mt76.tx_napi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 389eb0903807..1f77cf71ca70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -98,7 +98,6 @@ int mt7921s_mac_reset(struct mt792x_dev *dev)
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 	mt76_txq_schedule_all(&dev->mphy);
 	mt76_worker_disable(&dev->mt76.tx_worker);
-	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
@@ -135,7 +134,6 @@ int mt7921s_mac_reset(struct mt792x_dev *dev)
 
 	err = __mt7921_start(&dev->phy);
 out:
-	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
 
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 3e88798df017..a4ed00eebc48 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -499,7 +499,8 @@ static void mt76s_tx_status_data(struct mt76_worker *worker)
 	dev = container_of(sdio, struct mt76_dev, sdio);
 
 	while (true) {
-		if (test_bit(MT76_REMOVED, &dev->phy.state))
+		if (test_bit(MT76_RESET, &dev->phy.state) ||
+		    test_bit(MT76_REMOVED, &dev->phy.state))
 			break;
 
 		if (!dev->drv->tx_status_data(dev, &update))
-- 
2.18.0


