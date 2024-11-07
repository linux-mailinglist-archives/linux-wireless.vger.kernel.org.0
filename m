Return-Path: <linux-wireless+bounces-15035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 229169BFE47
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 07:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82546B210C5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 06:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C8193071;
	Thu,  7 Nov 2024 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hW5IAWEm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9182192D7E
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960088; cv=none; b=OvchdHjdmJmq3hHTRgb07aMh3/lkL/bKLwmSDWH0hCQcBrIpa2nYsUTiGIgHmPIv04ijSqs+BFYbnX9dulZHCn/g/f8ov6G9997exJU3ascN9aB0z4ks9j89QEfZ61sZuBDqf4PKNTxhpaFDoQvoN1MMuTySdmXexGMYphZNu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960088; c=relaxed/simple;
	bh=dub7f8yi0J+Zs3VHQaIxi3ojM0b6zh6Rvh/s2AvoTzE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TBnTJAkfwy2oVSfq+HnTXMa7U7Fo/AwraFWey3xEA4wBaVuNwv2f4NMrTqHttFBPMKebgB3XEoxShBObulFxHJwvGK5Iy2NnXDKtgq1fSYacRTwHUQyHcF4pMeaVKlSM/xGlaScnwoOpXeSxRcSYnUJmxWeANhZ23B8um3OxZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hW5IAWEm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 942ecbdc9ccf11efbd192953cf12861f-20241107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AI1Yg0EmBpFMmxHSDUGtFYEFGBNXtvmAM+kcA7qGUgg=;
	b=hW5IAWEmalGps4BbzWgcIgFtk8M0xsYMVsb+CWmxB9TP5eulSX0e7MidnAgRA1LZ0bUtpM7TL3uHMNJtx86nfgsPxxSihKsUelVpjDqWLMDE/LB58VU+GAeqM29hSzLAjAQ7BvCa2ns0SphlwYE50jA21LRSu30RqzdU36UVlR4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:b60368a1-4202-42c0-b7d5-64bd3a9116e5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:1615c31b-4f51-4e1d-bb6a-1fd98b6b19d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 942ecbdc9ccf11efbd192953cf12861f-20241107
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1770304744; Thu, 07 Nov 2024 14:14:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Nov 2024 14:14:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Nov 2024 14:14:41 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Leon Yen <leon.yen@mediatek.com>, Ming
 Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH v3] wifi :mt76: mt7921: introduce CSA support
Date: Thu, 7 Nov 2024 14:14:40 +0800
Message-ID: <20241107061440.6545-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Leon Yen <leon.yen@mediatek.com>

Add CSA (Channel Switch Announcement) related implementation
in collaboration with mac80211 to deal with dynamic channel
switching.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
  - update subject format.
v3:
  - modification and adjustment related to mt792x MLO arch.
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 98 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  6 ++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 14 +++
 4 files changed, 119 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 573a2cd7fe45..7e04edac7f1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -338,6 +338,9 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
 	if (phy->chip_cap & MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN)
 		vif->driver_flags |= IEEE80211_VIF_SUPPORTS_CQM_RSSI;
+
+	INIT_WORK(&mvif->csa_work, mt7921_csa_work);
+	timer_setup(&mvif->csa_timer, mt792x_csa_timer, 0);
 out:
 	mt792x_mutex_release(dev);
 
@@ -1341,6 +1344,9 @@ static int
 mt7921_add_chanctx(struct ieee80211_hw *hw,
 		   struct ieee80211_chanctx_conf *ctx)
 {
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	dev->new_ctx = ctx;
 	return 0;
 }
 
@@ -1348,6 +1354,10 @@ static void
 mt7921_remove_chanctx(struct ieee80211_hw *hw,
 		      struct ieee80211_chanctx_conf *ctx)
 {
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	if (dev->new_ctx == ctx)
+		dev->new_ctx = NULL;
 }
 
 static void
@@ -1398,6 +1408,89 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
 	mt7921_abort_roc(mvif->phy, mvif);
 }
 
+static int mt7921_switch_vif_chanctx(struct ieee80211_hw *hw,
+				     struct ieee80211_vif_chanctx_switch *vifs,
+				     int n_vifs,
+				     enum ieee80211_chanctx_switch_mode mode)
+{
+	return mt792x_assign_vif_chanctx(hw, vifs->vif, vifs->link_conf,
+					 vifs->new_ctx);
+}
+
+void mt7921_csa_work(struct work_struct *work)
+{
+	struct mt792x_vif *mvif;
+	struct mt792x_dev *dev;
+	struct ieee80211_vif *vif;
+	int ret;
+
+	mvif = (struct mt792x_vif *)container_of(work, struct mt792x_vif,
+						csa_work);
+	dev = mvif->phy->dev;
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	mt792x_mutex_acquire(dev);
+	ret = mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->bss_conf.mt76,
+					    dev->new_ctx);
+	mt792x_mutex_release(dev);
+
+	ieee80211_chswitch_done(vif, !ret, 0);
+}
+
+static int mt7921_pre_channel_switch(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_channel_switch *chsw)
+{
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
+		return -EOPNOTSUPP;
+
+	/* Avoid beacon loss due to the CAC(Channel Availability Check) time
+	 * of the AP.
+	 */
+	if (!cfg80211_chandef_usable(hw->wiphy, &chsw->chandef,
+				     IEEE80211_CHAN_RADAR))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void mt7921_channel_switch(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_channel_switch *chsw)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	u16 beacon_interval = vif->bss_conf.beacon_int;
+
+	mvif->csa_timer.expires = TU_TO_EXP_TIME(beacon_interval * chsw->count);
+	add_timer(&mvif->csa_timer);
+}
+
+static void mt7921_abort_channel_switch(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+	del_timer_sync(&mvif->csa_timer);
+	cancel_work_sync(&mvif->csa_work);
+}
+
+static void mt7921_channel_switch_rx_beacon(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    struct ieee80211_channel_switch *chsw)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	u16 beacon_interval = vif->bss_conf.beacon_int;
+
+	if (cfg80211_chandef_identical(&chsw->chandef,
+				       &dev->new_ctx->def) &&
+				       chsw->count) {
+		mod_timer(&mvif->csa_timer,
+			  TU_TO_EXP_TIME(beacon_interval * chsw->count));
+	}
+}
+
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt792x_tx,
 	.start = mt7921_start,
@@ -1457,6 +1550,11 @@ const struct ieee80211_ops mt7921_ops = {
 	.unassign_vif_chanctx = mt792x_unassign_vif_chanctx,
 	.mgd_prepare_tx = mt7921_mgd_prepare_tx,
 	.mgd_complete_tx = mt7921_mgd_complete_tx,
+	.switch_vif_chanctx = mt7921_switch_vif_chanctx,
+	.pre_channel_switch = mt7921_pre_channel_switch,
+	.channel_switch = mt7921_channel_switch,
+	.abort_channel_switch = mt7921_abort_channel_switch,
+	.channel_switch_rx_beacon = mt7921_channel_switch_rx_beacon,
 };
 EXPORT_SYMBOL_GPL(mt7921_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 16c89815c0b8..e5f83fd3cc5d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -273,6 +273,7 @@ int mt7921_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
 void mt7921_roc_work(struct work_struct *work);
+void mt7921_csa_work(struct work_struct *work);
 int mt7921_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif);
 void mt7921_coredump_work(struct work_struct *work);
 int mt7921_get_txpwr_info(struct mt792x_dev *dev, struct mt7921_txpwr *txpwr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index ab12616ec2b8..041b3d5232b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -133,6 +133,9 @@ struct mt792x_vif {
 	struct mt792x_phy *phy;
 	u16 valid_links;
 	u8 deflink_id;
+
+	struct work_struct csa_work;
+	struct timer_list csa_timer;
 };
 
 struct mt792x_phy {
@@ -235,6 +238,8 @@ struct mt792x_dev {
 	enum environment_cap country_ie_env;
 	u32 backup_l1;
 	u32 backup_l2;
+
+	struct ieee80211_chanctx_conf *new_ctx;
 };
 
 static inline struct mt792x_bss_conf *
@@ -364,6 +369,7 @@ void mt792x_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    u64 timestamp);
 void mt792x_tx_worker(struct mt76_worker *w);
 void mt792x_roc_timer(struct timer_list *timer);
+void mt792x_csa_timer(struct timer_list *timer);
 void mt792x_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  u32 queues, bool drop);
 int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 042aa8d1b6e7..66a864086021 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -288,6 +288,14 @@ void mt792x_roc_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL_GPL(mt792x_roc_timer);
 
+void mt792x_csa_timer(struct timer_list *timer)
+{
+	struct mt792x_vif *mvif = from_timer(mvif, timer, csa_timer);
+
+	ieee80211_queue_work(mvif->phy->mt76->hw, &mvif->csa_work);
+}
+EXPORT_SYMBOL_GPL(mt792x_csa_timer);
+
 void mt792x_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  u32 queues, bool drop)
 {
@@ -329,6 +337,11 @@ void mt792x_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mctx->bss_conf = NULL;
 	mvif->bss_conf.mt76.ctx = NULL;
 	mutex_unlock(&dev->mt76.mutex);
+
+	if (vif->bss_conf.csa_active) {
+		del_timer_sync(&mvif->csa_timer);
+		cancel_work_sync(&mvif->csa_work);
+	}
 }
 EXPORT_SYMBOL_GPL(mt792x_unassign_vif_chanctx);
 
@@ -651,6 +664,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	ieee80211_hw_set(hw, CONNECTION_MONITOR);
+	ieee80211_hw_set(hw, CHANCTX_STA_CSA);
 
 	if (dev->pm.enable)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
-- 
2.45.2


