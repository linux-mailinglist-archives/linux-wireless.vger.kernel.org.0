Return-Path: <linux-wireless+bounces-10357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8213934E8C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 15:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B5E281E06
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D50B14373E;
	Thu, 18 Jul 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IqtNgQxM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297614036D
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310587; cv=none; b=pEUg479JAtk63321H8ioYkAiGA9t5bZNGsYRQpaxgFRTvAvW99QwjiOdLvIRnI17vhnaPOHetL7eGCJmrVJJWav2hjIC3Wg+wuj6n1uEUiYvtBgxuk2A8vD1csZf+JhNND6PoZs6VkcOEIKS7taO1S4y7w6ZmqFxZ6B+8i+28Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310587; c=relaxed/simple;
	bh=S3r5+b3NOkhfjX4Qv2F50tyfra2qqJwAsVClDbya6LA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4iN0AzipwuusRoF6/1OIvzdfYQmcWObgjsI+7QXnkoHbgC7NBfGtQxBPIqSxYCbD3u5lVs5bYq9ImzZI1dqtfr55lyp3VMMDUhgbJvjm9P8lHD70lL9m448kq+G+3D+2O34XUkEddC/Tg8r+pOtzNciQchJCZ9UqIAXo9GlUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IqtNgQxM; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8dd1bb7a450c11ef87684b57767b52b1-20240718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=77DH8cGiyDVFUNLQZ2NQCtWvQsztffxtl4L3TNrSCBM=;
	b=IqtNgQxMXUgldajOsFDLnz2WiUU6Z+EEzokxwj825XiAfD/Ns3Gh8bcqvNgtMrcsoiMCQBdDgbmKadzYbVhvGFirO5KBBF4pqDBFV9qtgTz+MA/wBHQ9yWPKb3gGc6SkfAKcHK7DJXbyB6Vb5ysclKqrNGTEMBKuUbQWOYuvLLM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:c559e1e5-0e32-439d-ae06-409ad331fdc0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:178f9d0d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8dd1bb7a450c11ef87684b57767b52b1-20240718
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 81805637; Thu, 18 Jul 2024 21:49:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 Jul 2024 21:49:31 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 Jul 2024 21:49:30 +0800
From: Quan Zhou <quan.zhou@mediatek.com>
To: Quan Zhou <quan.zhou@mediatek.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, KM Lin <km.lin@mediatek.com>, Posh Sun
	<posh.sun@mediatek.com>, Shengxi Xu <shengxi.xu@mediatek.com>, Eric-SY Chang
	<Eric-SY.Chang@mediatek.com>, CH Yeh <ch.yeh@mediatek.com>, Robin Chiu
	<robin.chiu@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: [PATCH] wifi: mt76: mt7921: fix a potential scan no APs
Date: Thu, 18 Jul 2024 21:49:09 +0800
Message-ID: <1ac1ae779db86d4012199a24ea2ca74050ed4af6.1721300411.git.quan.zhou@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

In multi-channel scenarios, the granted channel must be aborted before
station remove. Otherwise, the firmware will be put into a wrong state,
resulting in have chance to make subsequence scan no APs.
With this patch, the granted channel will be always aborted before
station remove.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 2e6268cb06c0..84d6881eb4c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -359,9 +359,9 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		ieee80211_iterate_active_interfaces(mt76_hw(dev),
-						    IEEE80211_IFACE_ITER_RESUME_ALL,
-						    mt7921_roc_iter, (void *)phy);
+		ieee80211_iterate_interfaces(mt76_hw(dev),
+					     IEEE80211_IFACE_ITER_RESUME_ALL,
+					     mt7921_roc_iter, (void *)phy);
 }
 EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
 
@@ -861,6 +861,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
+	mt7921_roc_abort_sync(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-- 
2.18.0


