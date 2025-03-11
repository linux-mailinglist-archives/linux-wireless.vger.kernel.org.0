Return-Path: <linux-wireless+bounces-20193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707CCA5CC9A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37973B8D19
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDA7263885;
	Tue, 11 Mar 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYcGBZpQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E7262D3E
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715150; cv=none; b=Oab0YfpUqfVLNNu11PGhklfXu9jml9jOrHUt+N8bvKQCGU5GKRoH7mb1rYVMGM5+ZK9fPbyMPV2DQe81q9b3R85J5CPllfFoNiT1tCU1s0haBKLw3ct336+Xs0kPlBsqw5m9MUrOw4W4ZxgiOQXUtgTdkktSEFM35nqvcAtH2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715150; c=relaxed/simple;
	bh=JIhU6JAVFL/APQj30jcuDhgBR6k5qvCBmItYlZMcFKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUHS8YuNh4dJ03abv63J8RnBDY2SOLrwLxL3uBpdcTWDEGxVhEnOe43aTcr/t46j9fn7zWeJfdZcLHYayQTDB2lt9uQy6E1hP46BzS2IO63x8807scAmK2Bi0AVN3LV2OFa10OOWsA8Z33QcRS1r1lWBv3muNrXj6aL24BjhcU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYcGBZpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43210C4CEEA;
	Tue, 11 Mar 2025 17:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715150;
	bh=JIhU6JAVFL/APQj30jcuDhgBR6k5qvCBmItYlZMcFKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HYcGBZpQ8Wjl+SydLan7w9Kx9t/CN5dObhPKM4VAT69WmSPv8Q4Zhl7Pgu70SHEmZ
	 RuIiIQNLHpEFiJmyBjvi7DJ9/lo2PHdKqd22cW9KHn+wNjpIWMk7STjhrRKzzuvNqX
	 7sXobGglfDYN9uoEX/VXXhiqAV3o/PIrj3cc5Xw6qjv2VQ9J6ZP3c1LQ3PZTeJ9/A8
	 RlAKWIIEp/enJdRSGr+d+KK21ft1LJWXPUeVlbU8vbk5Px/5hFbr2lavrYn6qXDas+
	 yztZGR2IBYcaYQU/bwYuQJ47pVSMQ7DRpb57jN2IgObsVJV5A46+iMD2nsjSk716EI
	 Qcj4p59QLnu6Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:12 +0100
Subject: [PATCH v2 13/13] wifi: mt76: mt7996: Rely on mt7996_vif_link and
 mt7996_sta_link in mt7996_mac_twt_teardown_flow signature
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-13-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

This is a preliminary patch to enable MLO for MT7996 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 7 +++----
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 7 +++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 3 ++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 4a7f6fd9025297f0ffa8ea7e91efd34164a26196..7ddd4b0cadf5d1983379a93ba56da461748ca60e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2691,10 +2691,10 @@ void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
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
@@ -2706,8 +2706,7 @@ void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
 		return;
 
 	flow = &msta_link->twt.flow[flowid];
-	if (mt7996_mcu_twt_agrt_update(dev, &msta->vif->deflink, flow,
-				       MCU_TWT_AGRT_DELETE))
+	if (mt7996_mcu_twt_agrt_update(dev, link, flow, MCU_TWT_AGRT_DELETE))
 		return;
 
 	list_del_init(&flow->list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 5ab4f08dba06fdf95ee4e6bc0261749016f07e6a..11ad95e05b94857c95375cdf877518e7ee89f08e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1062,7 +1062,8 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			break;
 		case MT76_STA_EVENT_DISASSOC:
 			for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
-				mt7996_mac_twt_teardown_flow(dev, msta, i);
+				mt7996_mac_twt_teardown_flow(dev, link,
+							     msta_link, i);
 
 			mt7996_mcu_add_sta(dev, link_conf, link_sta, link,
 					   msta_link, CONN_STATE_DISCONNECT,
@@ -1804,10 +1805,12 @@ mt7996_twt_teardown_request(struct ieee80211_hw *hw,
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
index 962022c7eec9fd82ebba8e0d5aa6b6eae769ee32..84b9ff707d56501d212932a9fa6a3037259a1077 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -709,7 +709,8 @@ void mt7996_mac_dump_work(struct work_struct *work);
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


