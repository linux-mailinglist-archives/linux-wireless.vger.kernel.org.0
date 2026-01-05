Return-Path: <linux-wireless+bounces-30356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D6CF340C
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 12:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 684B13033F97
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0EB328B4E;
	Mon,  5 Jan 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="HEmrTu/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D3132AAC4
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612403; cv=none; b=lw+6Z+dgHNY4s1ecTWGOFGWpecce5BhSwoaJir0mjnvgf7dhNJQzFNSUKOYIKuvW3mxK8n32pA8/DwQMJp/CcrS7n4UGTim097i1CeJrSkstLqLLh1Na0rHe02uTRBMOYdWcg62w9hEAtds14WqeZ1IDvyhCsMNTbzT+2MKjFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612403; c=relaxed/simple;
	bh=3b1hvWYW5tNW2vcrFdzau/5oMH1pdI4aId+IE68Lxi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtF4z9hbiopp+V4Xl4FB9Ymo9d/WVTFpcc3vl6Gy6og/w/pVxh7MSVydGUec74z5qIV6JvIfXROigqia+e58cbS6EqZ4cW1xxZQPbaYRw3pppzmsZnpVxek84JNYJwXZY8P81QlCOcFzZRBVDaKzShf8YiVlxBoo/dxljdiLI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=HEmrTu/o; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260105111630d82f392e7300020701
        for <linux-wireless@vger.kernel.org>;
        Mon, 05 Jan 2026 12:16:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=09yIlnVbkbaWQta4+eo7OcKsHkPXnjtb/uQFXaz99WI=;
 b=HEmrTu/owLpmFdXw0vZHh1cat6BNoldSoIBzwSHnlLDBAtKEjf+Tu/83jW/XalsMbaNXjk
 kQO16B6j+mbrJRld39cpmbKohOCaOqwZuEwC5vPVVP8eNGrJZIIhSoLZtQDk5dTdLak0c16L
 d+HJvmi1LTw2ms0IRWWHv5I8tGifFAcq/RDuzGMaO6w+1/bMZjRnrLvJTQec4B8K+d8sNRiG
 3YaNktf7IzD3ShsTHFT824TDt3zF3cCINMjAc2MyedX0hBT/eKjhxFXzI6FB1XXzv+BREUc5
 O/HJ34ldJJuTVsTl+urNRfiaSgZ2qoCxRTIn5bzz5KlLldxt8fCNmxTg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Fietkau <nbd@nbd.name>,
	Quan Zhou <quan.zhou@mediatek.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6.12 2/3] wifi: mt76: mt7925: fix CLC command timeout when suspend/resume
Date: Mon,  5 Jan 2026 12:16:27 +0100
Message-ID: <95428f78ab30c93a150999e430f07e7047d95adb.1767611788.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1767611788.git.jan.kiszka@siemens.com>
References: <cover.1767611788.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Quan Zhou <quan.zhou@mediatek.com>

[ Upstream commit a0f721b8d986b62b4de316444f2b2e356d17e3b5 ]

When enter suspend/resume while in a connected state, the upper layer
will trigger disconnection before entering suspend, and at the same time,
it will trigger regd_notifier() and update CLC, causing the CLC event to
not be received due to suspend, resulting in a command timeout.

Therefore, the update of CLC is postponed until resume, to ensure data
consistency and avoid the occurrence of command timeout.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Link: https://patch.msgid.link/bab00a2805d0533fd8beaa059222659858a9dcb5.1735910455.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  | 20 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  3 +++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index 3f48ae80aed4..105ba5d0934c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -59,6 +59,18 @@ static int mt7925_thermal_init(struct mt792x_phy *phy)
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
@@ -66,6 +78,7 @@ mt7925_regd_notifier(struct wiphy *wiphy,
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_connac_pm *pm = &dev->pm;
 
 	/* allow world regdom at the first boot only */
 	if (!memcmp(req->alpha2, "00", 2) &&
@@ -81,11 +94,12 @@ mt7925_regd_notifier(struct wiphy *wiphy,
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
index c83b8a210498..76f31abe9146 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -218,6 +218,7 @@ int mt7925_mcu_chip_config(struct mt792x_dev *dev, const char *cmd);
 int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
 
+void mt7925_regd_update(struct mt792x_dev *dev);
 int mt7925_mac_init(struct mt792x_dev *dev);
 int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index b4cc5607e0d6..ccb663bd9f52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -554,11 +554,14 @@ static int mt7925_pci_resume(struct device *device)
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
2.51.0


