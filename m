Return-Path: <linux-wireless+bounces-17049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375CA009F9
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 14:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E911882492
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD051465A1;
	Fri,  3 Jan 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g2KfMZtD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA413AD0
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911594; cv=none; b=ktXOo6KUh10tZwWAxMyJlHSlZtVNIADduq7STLFz0Hf2UtQBzbQfYSinl6qWxKv7LtZOKMLrqRxNs+/qt+E8ocPoQADxxwdftDCsDA4a88d8SRuL9UjJkotp+z7Z4rPep5yyDBQ1Wh701Q238TLjjvjQBF7ASX5wX6vAL1qsuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911594; c=relaxed/simple;
	bh=HARpecmXLLi7qs8ZJp7tefQ4Zi5W7LXU5pYSdpYpWZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P8sPZPZWLvakwiXeSpUYkI+LY/kMs3pWdu8+yuf1fSoBaY33pdMUPhlPWVk7ugZq1Rn+y6PVSuI1wwd4+ozcA3nhW+MRbVIXyu8V7giWADXS4j7qjUtk4qM/2n32ZUWg0QmmRIEFVrcNva6qq8hrvjKb4jtPvRFe5hX65LVGm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=g2KfMZtD; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ee115bac9d811efbd192953cf12861f-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lYjCkavYzsokTj2iHqDvr+T2BegazsYLCbZfj29M/84=;
	b=g2KfMZtDOr9MBWRXD9cCY4RfP+8vZjinJHd2SVgsBksqZQspxoJXOPd4KF9wlnk476lY3lEL25GPYDyy8l8EgeF+w5xI+2ppBdBH5bWXXanHEBuq+pprAMu8Ma4tSvZK7bW/tSxWIeqFZS5hQ6Ebl6JALpTHTMqyYjkMppQyWY0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:f33a4fdd-af24-4ba1-8bdd-43c5984056c9,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:21059e25-8650-4337-bf57-045b64170f0c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2ee115bac9d811efbd192953cf12861f-20250103
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 99547430; Fri, 03 Jan 2025 21:39:40 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 21:39:39 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 21:39:38 +0800
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
Subject: [patch] wifi: mt76: mt7925: fix CLC command timeout when suspend/resume
Date: Fri, 3 Jan 2025 21:39:43 +0800
Message-ID: <bab00a2805d0533fd8beaa059222659858a9dcb5.1735910455.git.quan.zhou@mediatek.com>
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

When enter suspend/resume while in a connected state, the upper layer
will trigger disconnection before entering suspend, and at the same time,
it will trigger regd_notifier() and update CLC, causing the CLC event to
not be received due to suspend, resulting in a command timeout.

Therefore, the update of CLC is postponed until resume, to ensure data
consistency and avoid the occurrence of command timeout.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 20 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  3 +++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 34b6adc5ea0e..f6f8ab38d5aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -57,6 +57,18 @@ static int mt7925_thermal_init(struct mt792x_phy *phy)
 						       mt7925_hwmon_groups);
 	return PTR_ERR_OR_ZERO(hwmon);
 }
+
+void mt7925_regd_update(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_hw *hw = mdev->hw;
+
+	mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
+	mt7925_mcu_set_channel_domain(hw->priv);
+	mt7925_set_tx_sar_pwr(hw, NULL);
+}
+EXPORT_SYMBOL_GPL(mt7925_regd_update);
+
 static void
 mt7925_regd_notifier(struct wiphy *wiphy,
 		     struct regulatory_request *req)
@@ -64,6 +76,7 @@ mt7925_regd_notifier(struct wiphy *wiphy,
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_connac_pm *pm = &dev->pm;
 
 	/* allow world regdom at the first boot only */
 	if (!memcmp(req->alpha2, "00", 2) &&
@@ -79,11 +92,12 @@ mt7925_regd_notifier(struct wiphy *wiphy,
 	mdev->region = req->dfs_region;
 	dev->country_ie_env = req->country_ie_env;
 
+	if (pm->suspended)
+		return;
+
 	dev->regd_in_progress = true;
 	mt792x_mutex_acquire(dev);
-	mt7925_mcu_set_clc(dev, req->alpha2, req->country_ie_env);
-	mt7925_mcu_set_channel_domain(hw->priv);
-	mt7925_set_tx_sar_pwr(hw, NULL);
+	mt7925_regd_update(dev);
 	mt792x_mutex_release(dev);
 	dev->regd_in_progress = false;
 	wake_up(&dev->wait);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index df3c705d1cb3..a7325ec13c70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -215,6 +215,7 @@ int mt7925_mcu_chip_config(struct mt792x_dev *dev, const char *cmd);
 int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
 
+void mt7925_regd_update(struct mt792x_dev *dev);
 int mt7925_mac_init(struct mt792x_dev *dev);
 int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 4986aaccc753..5c9282b76522 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -557,11 +557,14 @@ static int mt7925_pci_resume(struct device *device)
 	local_bh_enable();
 
 	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+	if (err < 0)
+		goto failed;
 
 	/* restore previous ds setting */
 	if (!pm->ds_enable)
 		mt7925_mcu_set_deep_sleep(dev, false);
 
+	mt7925_regd_update(dev);
 failed:
 	pm->suspended = false;
 
-- 
2.46.0


