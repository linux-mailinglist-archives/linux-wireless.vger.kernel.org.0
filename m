Return-Path: <linux-wireless+bounces-17051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD08A00A1B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 14:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D73B7A1D58
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1461F9437;
	Fri,  3 Jan 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gNT8YQVP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FF51E00B4
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912434; cv=none; b=VhHkRMCtdhd2+Xy0GFXJI/9iDYapjrodH8TiZhmL8yY7zibyxYxsbV0u71no5WajAr4Kez/vCbzuxaFBKgoGzAUMmpv3YgtR4dg41QiBO82fWXc/27kEs43hQU8HKKhMjCa+BPGUFrP2cgWdJW9pCf4nWE6ZUfHfGVIvJvEg5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912434; c=relaxed/simple;
	bh=MtumvU3IGjSYSvq+mYmQlcprfvd+PMn3yvKPOb3Ub5E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=htfCNBOTC0VBKj4ZgB4wwWxWpBRobkFffHcfSdadQKhOLHbYYymt7VI9ydjychft2DQiKciAp0egSqwiLcCmNr2A5+nQmJx/RwiM+pF4TCvYgBziMOPt3Rq51pLwzhrEz/hfc1eeJrLBoRb5vsmwvYQWlW4P+qSySIcphDD8a+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gNT8YQVP; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2752afd2c9da11efbd192953cf12861f-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2cyeQ4ZYLPr4O58xO9lMsv4lI1QFC2xoa4iYSJ0krQI=;
	b=gNT8YQVPUlodWmsg6AejfUlemIYv65UsMZ0YOYIBiwrNu3eMu1f90gIONI6k+wMqAO9MoT6pSdNeSsMBTBtk8O0f1Jha3nsW5CLRW4GRpFgJGMNEQzqzAOL6A14AXNZr1X8lFLE9K3Dc3xG3rRzK56wGI0i4/Ojf/MXNyXfbs4Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:aad9fed9-31de-4479-ae74-2adf1859286f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:85a14a19-ec44-4348-86ee-ebcff634972b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2752afd2c9da11efbd192953cf12861f-20250103
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1153927359; Fri, 03 Jan 2025 21:53:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 21:53:45 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 21:53:44 +0800
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
Subject: [patch] wifi: mt76: mt7925e: fix too long of wifi resume time
Date: Fri, 3 Jan 2025 21:53:50 +0800
Message-ID: <f075d43d87a5eefa5869baf755e9986edf735860.1735910836.git.quan.zhou@mediatek.com>
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

The mt7925e takes a long time to resume in platform resume
scenarios. This is due to the mt7925 reconfiguring the tx
power for each wifi channel during resume. By streamlining
the process and removing redundant power configurations,
the resume time for the mt7925 can be shortened.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/init.c |  5 +++++
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 10 +++++++---
 drivers/net/wireless/mediatek/mt76/mt792x.h      |  2 ++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index f6f8ab38d5aa..f41ca4248497 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -63,9 +63,13 @@ void mt7925_regd_update(struct mt792x_dev *dev)
 	struct mt76_dev *mdev = &dev->mt76;
 	struct ieee80211_hw *hw = mdev->hw;
 
+	if (!dev->regd_change)
+		return;
+
 	mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
 	mt7925_mcu_set_channel_domain(hw->priv);
 	mt7925_set_tx_sar_pwr(hw, NULL);
+	dev->regd_change = false;
 }
 EXPORT_SYMBOL_GPL(mt7925_regd_update);
 
@@ -91,6 +95,7 @@ mt7925_regd_notifier(struct wiphy *wiphy,
 	memcpy(mdev->alpha2, req->alpha2, 2);
 	mdev->region = req->dfs_region;
 	dev->country_ie_env = req->country_ie_env;
+	dev->regd_change = true;
 
 	if (pm->suspended)
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 187770537a1a..f8977e6601d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1300,6 +1300,7 @@ void mt7925_mac_reset_work(struct work_struct *work)
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
+	dev->sar_inited = false;
 
 	for (i = 0; i < 10; i++) {
 		mutex_lock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a6944de712cc..7ef101ecf824 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -310,6 +310,7 @@ void mt7925_set_stream_he_eht_caps(struct mt792x_phy *phy)
 int __mt7925_start(struct mt792x_phy *phy)
 {
 	struct mt76_phy *mphy = phy->mt76;
+	struct mt792x_dev *dev = phy->dev;
 	int err;
 
 	err = mt7925_mcu_set_channel_domain(mphy);
@@ -320,9 +321,12 @@ int __mt7925_start(struct mt792x_phy *phy)
 	if (err)
 		return err;
 
-	err = mt7925_set_tx_sar_pwr(mphy->hw, NULL);
-	if (err)
-		return err;
+	if (!dev->sar_inited) {
+		err = mt7925_set_tx_sar_pwr(mphy->hw, NULL);
+		if (err)
+			return err;
+		dev->sar_inited = true;
+	}
 
 	mt792x_mac_reset_counters(phy);
 	set_bit(MT76_STATE_RUNNING, &mphy->state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 1b612d123d9f..af687fe239b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -224,6 +224,8 @@ struct mt792x_dev {
 	bool aspm_supported:1;
 	bool hif_idle:1;
 	bool hif_resumed:1;
+	bool sar_inited:1;
+	bool regd_change:1;
 	wait_queue_head_t wait;
 
 	struct work_struct init_work;
-- 
2.46.0


