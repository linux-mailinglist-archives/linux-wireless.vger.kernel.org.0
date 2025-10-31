Return-Path: <linux-wireless+bounces-28440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D659C24025
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 10:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5274F189DBC4
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFC732E6AB;
	Fri, 31 Oct 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M2SLMDbO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30032E69E
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901454; cv=none; b=Or9UO/fCaTMqNloIJwN+V/1+auVxiJytd+waF95KKcrldL4YqsDB8nx5TMSsEWqldvqWJtExzyV7bfHYUrLY6ylKTY36IgmW8y3NYZm1OKRHWlQMHyMvS6DbSKhjnNjyOIciDUs4bVrtX8eqkuo+y02PXi1qMcutShoGZeO/JYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901454; c=relaxed/simple;
	bh=LX9MSD/0yIcRzre6PaQshQpgLsunRXsO3HY3qn67PIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0FZHVnayGbo3w14BgpwYsBxPjpSaFQSo4zXAwelvuUfxkw+BH9zQkaAm4mjtYhr6JIedt6yJWb9+7vFYNd336Bkgfae0vlM+/rOh4SNoGM2DgS8KYU+ICWejPgkEIlm+rDKMoNXbKjkyF/FOaxoN2B4EfMrKOKMT2ca5pR8fjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=M2SLMDbO; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8e626e9cb63811f0ae1e63ff8927bad3-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uHKm1A+bMRYvDR5HosL+njjaPpB1qTXJ15tBVQlea+4=;
	b=M2SLMDbOqKMjQ2ClskmNBi74yeCrcH6y4i5lWne3GBdVLkOjC8wxH4BsZJXxtpOVayvFmlxJfH28vBniQfFcKdfz/y+UCOLz35RX3srXyZZOBRvD7FGcel6yI1uQ3sp8mj/GT8U2Rt/lH+eex3TZ13hdE40PWS1dEYxSPinctgM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2dbeaa65-9abf-471c-96e4-f998d77c3329,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:565e7726-cfd6-4a1d-a1a8-72ac3fdb69c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e626e9cb63811f0ae1e63ff8927bad3-20251031
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 745007083; Fri, 31 Oct 2025 17:04:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 17:04:05 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 17:04:05 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 3/6] wifi: mt76: mt7925: refactor regulatory notifier flow
Date: Fri, 31 Oct 2025 17:03:49 +0800
Message-ID: <20251031090352.1400079-4-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
References: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Rename mt7925_regd_update() to mt7925_mcu_regd_update() to centralize
regd updates with error handling.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7925/regd.c  | 49 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7925/regd.h  |  4 +-
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c10f14386571..96bd3eb21133 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 
 #include "mt7925.h"
+#include "regd.h"
 #include "mac.h"
 #include "mcu.h"
 #include "regd.h"
@@ -585,7 +586,7 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	if (!pm->ds_enable)
 		mt7925_mcu_set_deep_sleep(dev, false);
 
-	mt7925_regd_update(dev);
+	mt7925_mcu_regd_update(dev, mdev->alpha2, dev->country_ie_env);
 failed:
 	pm->suspended = false;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
index 9e7b468a8228..b36c6a6f5da6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
@@ -111,29 +111,49 @@ mt7925_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 	}
 }
 
-void mt7925_regd_update(struct mt792x_dev *dev)
+int mt7925_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
+			   enum environment_cap country_ie_env)
 {
-	struct mt76_dev *mdev = &dev->mt76;
-	struct ieee80211_hw *hw = mdev->hw;
+	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct wiphy *wiphy = hw->wiphy;
+	int ret = 0;
+
+	dev->regd_in_progress = true;
 
+	mt792x_mutex_acquire(dev);
 	if (!dev->regd_change)
-		return;
+		goto err;
+
+	ret = mt7925_mcu_set_clc(dev, alpha2, country_ie_env);
+	if (ret < 0)
+		goto err;
 
-	mt7925_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
 	mt7925_regd_channel_update(wiphy, dev);
-	mt7925_mcu_set_channel_domain(hw->priv);
-	mt7925_set_tx_sar_pwr(hw, NULL);
+
+	ret = mt7925_mcu_set_channel_domain(hw->priv);
+	if (ret < 0)
+		goto err;
+
+	ret = mt7925_set_tx_sar_pwr(hw, NULL);
+	if (ret < 0)
+		goto err;
+
+err:
+	mt792x_mutex_release(dev);
 	dev->regd_change = false;
+	dev->regd_in_progress = false;
+	wake_up(&dev->wait);
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(mt7925_regd_update);
+EXPORT_SYMBOL_GPL(mt7925_mcu_regd_update);
 
 void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_dev *mdev = &dev->mt76;
 
 	/* allow world regdom at the first boot only */
 	if (!memcmp(req->alpha2, "00", 2) &&
@@ -148,15 +168,14 @@ void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req)
 	memcpy(mdev->alpha2, req->alpha2, 2);
 	mdev->region = req->dfs_region;
 	dev->country_ie_env = req->country_ie_env;
+
 	dev->regd_change = true;
 
 	if (pm->suspended)
+		/* postpone the mcu update to resume */
 		return;
 
-	dev->regd_in_progress = true;
-	mt792x_mutex_acquire(dev);
-	mt7925_regd_update(dev);
-	mt792x_mutex_release(dev);
-	dev->regd_in_progress = false;
-	wake_up(&dev->wait);
+	mt7925_mcu_regd_update(dev, req->alpha2,
+			       req->country_ie_env);
+	return;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.h b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
index 5977e068c1c6..edcda72b12b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.h
@@ -6,8 +6,10 @@
 
 #include "mt7925.h"
 
+int mt7925_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
+			   enum environment_cap country_ie_env);
+
 void mt7925_regd_be_ctrl(struct mt792x_dev *dev, u8 *alpha2);
-void mt7925_regd_update(struct mt792x_dev *dev);
 void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req);
 bool mt7925_regd_clc_supported(struct mt792x_dev *dev);
 
-- 
2.34.1


