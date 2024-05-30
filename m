Return-Path: <linux-wireless+bounces-8308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF5A8D476A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCEB1C21111
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF856F2F4;
	Thu, 30 May 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YYiCj0Lt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569955887
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058715; cv=none; b=Gqpi1JwaDEuCoDjDfgOwcqhY8UW36IsOPnxvlfkgU47lyck7NEzU00D8d9bYyggus0wNqx4Vo/aacpGFyPw+ZE3Kpzcpk7Y+O1sxw6ngYvH8Y20SL4B9lq76YYckX5uOu87RkIqKrkSZ0Uy7b8QdjBfDzxeLx/ZhilaQWVT9YTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058715; c=relaxed/simple;
	bh=eSIoBfN9KD/raGDx3nQaqs5eTQFWX8c5cGTJt5/lT58=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OwEEluUacEe2b9nYxK+Bi0ARk2w0C0au3GGxJyu9J0ubuCQHwJDPrYpJwTWRg1PBi0whWV22mYh2Idpo0klaCXGTdsSsYAqNB7SK8fSL6ly+pELPUAuCSm6NjyXRG1DEmQNs26wOr71q3af5mbtpe9maN1z46rtPpNgT3E0fj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YYiCj0Lt; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e66398e41e6011efbfff99f2466cf0b4-20240530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oQcOVF+O655yruhPTVMERnaIwgJZSDJ5JXbzSnvNbU8=;
	b=YYiCj0LtprZ8ilhR6TXtCbLFhEx8BBpG/FBOpyt9fwxAeB9MaKTddKCGIA2XBTiQQPiaT0wyXrkHiV3a5hEEXXwGQWN4M4N6xdcCFVtkySGz2PDQonSwSNFDP/EDS6IayhCrE+UtLMgPJpQJoePLq7neRvlIoIovyjTFz68tzDo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:efdd89df-1b4e-4b12-997f-fb134025598c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:341a0188-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e66398e41e6011efbfff99f2466cf0b4-20240530
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 47687398; Thu, 30 May 2024 16:45:00 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 30 May 2024 01:44:59 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 30 May 2024 16:44:58 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Leon Yen <leon.yen@mediatek.com>, Ming
 Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7921: introduce CSA support
Date: Thu, 30 May 2024 16:44:55 +0800
Message-ID: <20240530084455.4290-1-mingyen.hsieh@mediatek.com>
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
v2: update subject format
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 98 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  6 ++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 14 +++
 4 files changed, 119 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3e3ad3518d85..22689bae9a3c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -337,6 +337,9 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
 	if (phy->chip_cap & MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN)
 		vif->driver_flags |= IEEE80211_VIF_SUPPORTS_CQM_RSSI;
+
+	INIT_WORK(&mvif->csa_work, mt7921_csa_work);
+	timer_setup(&mvif->csa_timer, mt792x_csa_timer, 0);
 out:
 	mt792x_mutex_release(dev);
 
@@ -1337,6 +1340,9 @@ static int
 mt7921_add_chanctx(struct ieee80211_hw *hw,
 		   struct ieee80211_chanctx_conf *ctx)
 {
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	dev->new_ctx = ctx;
 	return 0;
 }
 
@@ -1344,6 +1350,10 @@ static void
 mt7921_remove_chanctx(struct ieee80211_hw *hw,
 		      struct ieee80211_chanctx_conf *ctx)
 {
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	if (dev->new_ctx == ctx)
+		dev->new_ctx = NULL;
 }
 
 static void mt7921_ctx_iter(void *priv, u8 *mac,
@@ -1399,6 +1409,89 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
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
+	ret = mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76,
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
@@ -1458,6 +1551,11 @@ const struct ieee80211_ops mt7921_ops = {
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
index 6c5392c5d207..b85e76e50657 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -272,6 +272,7 @@ int mt7921_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
 void mt7921_roc_work(struct work_struct *work);
+void mt7921_csa_work(struct work_struct *work);
 int mt7921_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif);
 void mt7921_coredump_work(struct work_struct *work);
 int mt7921_get_txpwr_info(struct mt792x_dev *dev, struct mt7921_txpwr *txpwr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 20578497a405..d4b84c7eca59 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -109,6 +109,9 @@ struct mt792x_vif {
 	struct ewma_rssi rssi;
 
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+
+	struct work_struct csa_work;
+	struct timer_list csa_timer;
 };
 
 struct mt792x_phy {
@@ -209,6 +212,8 @@ struct mt792x_dev {
 	enum environment_cap country_ie_env;
 	u32 backup_l1;
 	u32 backup_l2;
+
+	struct ieee80211_chanctx_conf *new_ctx;
 };
 
 static inline struct mt792x_dev *
@@ -278,6 +283,7 @@ void mt792x_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    u64 timestamp);
 void mt792x_tx_worker(struct mt76_worker *w);
 void mt792x_roc_timer(struct timer_list *timer);
+void mt792x_csa_timer(struct timer_list *timer);
 void mt792x_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  u32 queues, bool drop);
 int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index a405af8d9052..2c95bc2aac0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -246,6 +246,14 @@ void mt792x_roc_timer(struct timer_list *timer)
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
@@ -283,6 +291,11 @@ void mt792x_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&dev->mt76.mutex);
 	mvif->mt76.ctx = NULL;
 	mutex_unlock(&dev->mt76.mutex);
+
+	if (vif->bss_conf.csa_active) {
+		del_timer_sync(&mvif->csa_timer);
+		cancel_work_sync(&mvif->csa_work);
+	}
 }
 EXPORT_SYMBOL_GPL(mt792x_unassign_vif_chanctx);
 
@@ -603,6 +616,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
 	ieee80211_hw_set(hw, CONNECTION_MONITOR);
+	ieee80211_hw_set(hw, CHANCTX_STA_CSA);
 
 	if (dev->pm.enable)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
-- 
2.18.0


