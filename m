Return-Path: <linux-wireless+bounces-32092-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFGdBUUEnGlG/AMAu9opvQ
	(envelope-from <linux-wireless+bounces-32092-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 08:39:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E711B172C3C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 08:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE93E303183B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 07:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1F03491E1;
	Mon, 23 Feb 2026 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NjQSoMn+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534811713
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832347; cv=none; b=Z7hDSC3Lrwri1BJ4EGCyLYMxVrTr+asYR905JCF0kGP440B2xznRboOSNDZGX2o4tISGWOojk88yFcggJyoRTw+Z0zDIL38E+sP6tPJ79mmpQCh2Khi9oSHEWHKZQ7gEkHBWVc2uUehhQnwkFVUp2LsLO/XxFZacDYCE8Ox0sHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832347; c=relaxed/simple;
	bh=4fFLWDoAKjyKrWEKLmxn3Q7BUj6y8xPK3h5KhJa2a18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuBFdu2jgzh5pEwCXcdra0mDDNyZQD/Vaa1d9u10zbagdpt2Z57w62qFdXgyAOmHsYJusbY0p+GxPtjcfHrVMtQYxpQ8EDr6bBTGcVfdo/AXkke/KdUH5Kt7jIdL0MwNiqd1W6iOiPfKlPA4evzttvbD4+SGXy4EJupr2aQTttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NjQSoMn+; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b7bb7638108a11f1b7fc4fdb8733b2bc-20260223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pUKoLkg3FdnL3mKOxcRqz3TLH9uvKR/C6S+tscgyo7w=;
	b=NjQSoMn+CSxtrUrjUHIb0d8IosOq7pQwcBlZB34/1LP2AE48pFTTAH/TqMHfrQcnXBtJNC4XNfB6BXPN/q2NhNyniAqkgIkzVqz8vokPHwUAL/5sCOL4YlFgD0dgSun6tyQT1lM4w7SsG197XqgNbL9iYtTkIRE1SMOHMi08lxE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:d44d3d71-056c-4b31-a5e3-bab01828d8fd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:19e8e2e9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b7bb7638108a11f1b7fc4fdb8733b2bc-20260223
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 460549703; Mon, 23 Feb 2026 15:38:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 23 Feb 2026 15:38:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 23 Feb 2026 15:38:59 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <jb.tsai@mediatek.com>
Subject: [PATCH 3/5] wifi: mt76: mt7921: refactor regulatory notifier flow
Date: Mon, 23 Feb 2026 15:38:52 +0800
Message-ID: <20260223073854.2464232-3-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260223073854.2464232-1-jb.tsai@mediatek.com>
References: <20260223073854.2464232-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32092-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:mid,mediatek.com:dkim,mediatek.com:email]
X-Rspamd-Queue-Id: E711B172C3C
X-Rspamd-Action: no action

Rename mt7921_regd_update() to mt7921_mcu_regd_update() to centralize
regd updates with error handling.

Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/regd.c  | 45 +++++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/regd.h  |  3 +-
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index a173a61f2b49..3fdf55c056a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -545,7 +545,7 @@ static int mt7921_pci_resume(struct device *device)
 	if (err < 0)
 		goto failed;
 
-	mt7921_regd_update(dev);
+	mt7921_mcu_regd_update(dev, mdev->alpha2, dev->country_ie_env);
 	err = mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_ON_LED);
 failed:
 	pm->suspended = false;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
index 70440ab8ba82..f795ee2eb446 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.c
@@ -72,18 +72,43 @@ mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 	}
 }
 
-void mt7921_regd_update(struct mt792x_dev *dev)
+int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
+			   enum environment_cap country_ie_env)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	struct ieee80211_hw *hw = mdev->hw;
 	struct wiphy *wiphy = hw->wiphy;
+	int ret = 0;
+
+	dev->regd_in_progress = true;
+
+	mt792x_mutex_acquire(dev);
+	if (!dev->regd_change)
+		goto err;
+
+	ret = mt7921_mcu_set_clc(dev, alpha2, country_ie_env);
+	if (ret < 0)
+		goto err;
 
-	mt7921_mcu_set_clc(dev, mdev->alpha2, dev->country_ie_env);
 	mt7921_regd_channel_update(wiphy, dev);
-	mt76_connac_mcu_set_channel_domain(hw->priv);
-	mt7921_set_tx_sar_pwr(hw, NULL);
+
+	ret = mt76_connac_mcu_set_channel_domain(hw->priv);
+	if (ret < 0)
+		goto err;
+
+	ret = mt7921_set_tx_sar_pwr(hw, NULL);
+	if (ret < 0)
+		goto err;
+
+err:
+	mt792x_mutex_release(dev);
+	dev->regd_change = false;
+	dev->regd_in_progress = false;
+	wake_up(&dev->wait);
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(mt7921_regd_update);
+EXPORT_SYMBOL_GPL(mt7921_mcu_regd_update);
 
 void mt7921_regd_notifier(struct wiphy *wiphy,
 			  struct regulatory_request *request)
@@ -106,12 +131,6 @@ void mt7921_regd_notifier(struct wiphy *wiphy,
 	if (pm->suspended)
 		return;
 
-	dev->regd_in_progress = true;
-
-	mt792x_mutex_acquire(dev);
-	mt7921_regd_update(dev);
-	mt792x_mutex_release(dev);
-
-	dev->regd_in_progress = false;
-	wake_up(&dev->wait);
+	mt7921_mcu_regd_update(dev, request->alpha2,
+			       request->country_ie_env);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
index 74bc2fdd532c..da5bd4450312 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regd.h
@@ -6,7 +6,8 @@
 
 #include "mt7921.h"
 
-void mt7921_regd_update(struct mt792x_dev *dev);
+int mt7921_mcu_regd_update(struct mt792x_dev *dev, u8 *alpha2,
+			   enum environment_cap country_ie_env);
 void mt7921_regd_notifier(struct wiphy *wiphy,
 			  struct regulatory_request *request);
 bool mt7921_regd_clc_supported(struct mt792x_dev *dev);
-- 
2.45.2


