Return-Path: <linux-wireless+bounces-3197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7673584B06B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC521C2469F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567612C520;
	Tue,  6 Feb 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EL6lZ8AI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B112C532
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209631; cv=none; b=bErdoyw2uupF9XJL83xdY/1cmC5NI2XWGLKSP2k/Uf9DNHYxcqsdFySyhyM52GQDr4Lj9IVGVDDOvKn1KIeZoidAlcP1+29cp1RZIdDuM0MHRa5RtRT5SyRe8j3t89S8VqA759NwFTNGSEm49yhkG5FKDz8vVmSbK6+2etYQkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209631; c=relaxed/simple;
	bh=nF0vHs1u1XNe11TYXsJKMg0JcFZKgOo2EPUROiXoeG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1WGlwe5Tnf4uQ74w7TcLY7iyGJHzPQJ1iRBYe1+ld27aCAwfYxRPRHaQc065fVp+oHbto1EExDhHFop2Z8YrOZWXr8NwHA9FyOOjtwLBzoI2GmdU9UFRilweYos5W/gbSoWRLkn1edvYb0OkmzY4743WkZdwJzv9VYG2gjbRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EL6lZ8AI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3754cebec4cd11eea2298b7352fd921d-20240206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aadV3qycQ2zIemzQfNQNbq63rNVJaRGiMpsq3ArPnzY=;
	b=EL6lZ8AIZbOxu9SFXiLH9mZc7XFmfGS/44MEewhrzrXQbYQGirMhbs8zpu3BzZOxk5Zg+vMTu5PICH5UZfmmVISbM/FvBgysfEiCeRX+JODOVBuQioA9LGpd2i63jXvp40qd7KFoulBZm+D+fU7l7BUpNRpUJfuCnqpz3xmdv8Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:51750c88-2bae-47ba-9269-1b3d2279e2d7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ea1f2d80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3754cebec4cd11eea2298b7352fd921d-20240206
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2092859305; Tue, 06 Feb 2024 16:53:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Feb 2024 16:53:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Feb 2024 16:53:35 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Leon Yen <leon.yen@mediatek.com>, "Ming
 Yen Hsieh" <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix a potential association failure upon resuming
Date: Tue, 6 Feb 2024 16:53:04 +0800
Message-ID: <20240206085304.13059-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.982900-8.000000
X-TMASE-MatchedRID: JTtOfOXMBZ/hsdkaHFW0p5D6BbDN9+jO5E5u1OdPWsRiZCTkFQiKcHB4
	4IkzjfYyThbvLLI8RvN+8BOKv4EeDPG1o2o1y09iW7gz/Gbgpl5dymZBcuGGRKvM+zzl/BSTJHP
	cG8qtn93ol7bd/DKRXL4tP830vR4ABtky+F8qrL0VglQa/gMvfH0tCKdnhB589yM15V5aWpj6C0
	ePs7A07SAJgyd9wrc87TzujMRsp7oIWCvobE4tX/M6vSWGp6OTvfbxEwoNo5smCUe0i7/IXA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.982900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0D3FCD2444564D59DAA1D7B81B1BA67D7B4580E4B6B24CD06A078B5F384CC38F2000:8

From: Leon Yen <leon.yen@mediatek.com>

In multi-channel scenarios, the granted channel must be aborted before
suspending. Otherwise, the firmware will be put into a wrong state,
resulting in an association failure after resuming.
With this patch, the granted channel will be aborted before suspending
if necessary.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   | 13 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0645417e0582..e56eed010b47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -325,6 +325,19 @@ static void mt7921_roc_iter(void *priv, u8 *mac,
 	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
 }
 
+void mt7921_roc_abort_sync(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	del_timer_sync(&phy->roc_timer);
+	cancel_work_sync(&phy->roc_work);
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+		ieee80211_iterate_active_interfaces(mt76_hw(dev),
+						    IEEE80211_IFACE_ITER_RESUME_ALL,
+						    mt7921_roc_iter, (void *)phy);
+}
+EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
+
 void mt7921_roc_work(struct work_struct *work)
 {
 	struct mt792x_phy *phy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 1cb21133992b..3016636d18c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -322,4 +322,5 @@ int mt7921_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 		       enum mt7921_roc_req type, u8 token_id);
 int mt7921_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			 u8 token_id);
+void mt7921_roc_abort_sync(struct mt792x_dev *dev);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index fabd24726f3e..2c2602d7b910 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -406,6 +406,8 @@ static int mt7921_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt7921_roc_abort_sync(dev);
+
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
 		goto restore_suspend;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 7591e54d2897..4b8d4c19a3e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -216,6 +216,8 @@ static int mt7921s_suspend(struct device *__dev)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt7921_roc_abort_sync(dev);
+
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
 		goto restore_suspend;
-- 
2.18.0


