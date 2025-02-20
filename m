Return-Path: <linux-wireless+bounces-19214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD4CA3DB2E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFFC19C10D6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30491F8EFF;
	Thu, 20 Feb 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWPk34xg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9891F8AE5
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057589; cv=none; b=bqrOLJNHNdPnt0IhCLU4qCWlWw30bbePxWmXWGC6Pj89FBlKzfKZshy8ti+dsWnYrXRbd3MIxQngYCOBK40N0+Sur+MNDK+yTeJkX/ZqBb8wGf4+6rjj98p4KLCnuU3fTE5NfwPMs+FA9gMK4kouzQcj5DTCpVwEMcj3Fo9Ntek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057589; c=relaxed/simple;
	bh=u+iFsMVx5TqWifZdRLJ8I/qERMsgsiauDgynXlT7cr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKpTW4RTfrCnS2Ere+zoXEc+7bEWPtxor13+ja+HsicrtpME5lZXEb5IJqWeZqJicvhhQe+e9OUxhLzZ+i9E/XKuCdB1vvzvaVwP0Oi5u/qvgw8bKpekM3PvPYDHZ/xbGT5itvdouNhoe00YQYwwpcd1eIE6zTXDmMYfzeTTM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWPk34xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD60C4CEE2;
	Thu, 20 Feb 2025 13:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057589;
	bh=u+iFsMVx5TqWifZdRLJ8I/qERMsgsiauDgynXlT7cr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jWPk34xgj+3mQb1Cmnl4ejrnalQGNgEIcgF4UabsQqqNnb6yZ82MpmymifLz6wwHw
	 OYnpOZG1ThNVv3u9sTyi7Gpf91W+GEGrlkZJlJuxZ4mAnZTMsn8wR2BG8cJN1ctNRL
	 hCiv5gs+Kxypy43A7wbD2XuLKiKG13sIYRFAb3PPnKJtvfiJjkgQX6ltM8acANb//l
	 X525tjk9/nHQyOE00FrNztSKy771hkH7KR3s3yuWpBc6WODCheSY5KwCn2y8H3kpbC
	 I2af99bmGMPRzEKk7rmTgPUklW3qOUGY+IKZyXVw6WoqNRrEvzo9UJ/RdwUn6t6+5I
	 7+9VuLu+AnYMA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:19:00 +0100
Subject: [PATCH 14/14] wifi: mt76: mt7996: Rely on mt7996_vif_link and
 mt7996_sta_link in mt7996_mac_twt_teardown_flow signature
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-14-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

This is a preliminary patch to enable MLO for MT7996 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 7 +++----
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 7 +++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0c862cd749b233ae1a6870c536792087109cd46c..f663c177ae066113db78dab905db177f63337676 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2678,10 +2678,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 }
 
 void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
-				  struct mt7996_sta *msta,
+				  struct mt7996_vif_link *link,
+				  struct mt7996_sta_link *msta_link,
 				  u8 flowid)
 {
-	struct mt7996_sta_link *msta_link = &msta->deflink;
 	struct mt7996_twt_flow *flow;
 
 	lockdep_assert_held(&dev->mt76.mutex);
@@ -2693,8 +2693,7 @@ void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
 		return;
 
 	flow = &msta_link->twt.flow[flowid];
-	if (mt7996_mcu_twt_agrt_update(dev, &msta->vif->deflink, flow,
-				       MCU_TWT_AGRT_DELETE))
+	if (mt7996_mcu_twt_agrt_update(dev, link, flow, MCU_TWT_AGRT_DELETE))
 		return;
 
 	list_del_init(&flow->list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index ecfea602cab9d0cdb2c79e682910ce2c5bd1079f..941d48716005c16414221fad9a41c53667dd3f78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1009,7 +1009,8 @@ int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			break;
 		case MT76_STA_EVENT_DISASSOC:
 			for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
-				mt7996_mac_twt_teardown_flow(dev, msta, i);
+				mt7996_mac_twt_teardown_flow(dev, link,
+							     msta_link, i);
 
 			mt7996_mcu_add_sta(dev, link_conf, link_sta, link,
 					   msta_link, CONN_STATE_DISCONNECT,
@@ -1709,10 +1710,12 @@ mt7996_twt_teardown_request(struct ieee80211_hw *hw,
 			    u8 flowid)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link = &msta->deflink;
+	struct mt7996_vif_link *link = &msta->vif->deflink;
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7996_mac_twt_teardown_flow(dev, msta, flowid);
+	mt7996_mac_twt_teardown_flow(dev, link, msta_link, flowid);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 3a8e99b6f474af285838f90b1068380c93a862a1..d576dfb2402cdd076e707cc8d725b42de737bff4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -715,7 +715,8 @@ void mt7996_mac_dump_work(struct work_struct *work);
 void mt7996_mac_sta_rc_work(struct work_struct *work);
 void mt7996_mac_update_stats(struct mt7996_phy *phy);
 void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
-				  struct mt7996_sta *msta,
+				  struct mt7996_vif_link *link,
+				  struct mt7996_sta_link *msta_link,
 				  u8 flowid);
 void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 			      struct ieee80211_sta *sta,

-- 
2.48.1


