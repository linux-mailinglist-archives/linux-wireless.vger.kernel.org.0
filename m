Return-Path: <linux-wireless+bounces-27665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4BDBA270E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 07:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD9156079A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Sep 2025 05:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575621C9EA;
	Fri, 26 Sep 2025 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sK9Uuuiw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8641FCFEF
	for <linux-wireless@vger.kernel.org>; Fri, 26 Sep 2025 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758864896; cv=none; b=ZXGFQ7A/jp7EMX294+Wk358I0WIfzKsCyiFzH/xj2sDWfgjM6AeU45M/9imBuHQE/v25W5TqR0zsGEqMOKVnmUhgkik6ZO30JKTSjBGu6FGntfWh/AbyIU7UeGRSlWQIf7Er9Snd7lpOVUU7NeVSItRBhN5aBBN+Rs8hJ4onsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758864896; c=relaxed/simple;
	bh=u8M2kAWIz77+xvOpXmDhaV+IUO5mcab/RNhkYtwkkEc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LXWHkl/W1kHHGEuCObLDKYUITaBW+J3OPW6tN9Ok2bxd1E0Ls0Ch97w5uiPKkeJZgHLkY2KA2XDOfw3aTpZgMvsXCyLPSKD7LuGIV3vbiC2vxuFu5Jetlc7I7AsfzXGvNZes3g89kyJ1jbP+6qrfdVxFQtXDDMFEljmQBRO5nfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sK9Uuuiw; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 852c3a2e9a9a11f0b33aeb1e7f16c2b6-20250926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GjiETwtrb/SDq5RmJmJt7QuB7m5UvZZd5ahRKxKwBVQ=;
	b=sK9Uuuiwopk6uaTSQGyuwNjrw5PYSaHyklV3p+ZG/gojNUeSgAj9XsPwg0XIJnrwqcp5XoIQxsSJBxTd+rA2iE2qXbppJX7cjUtev0m/Kc37uoBgGtdfqX3qO86L90THWRWzoWTq0df0IW9ttV8+9+UdxC4T6y935w/jU9nS10g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ba868d29-c038-446c-8d73-81f96c494cb0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:01c2b5f8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 852c3a2e9a9a11f0b33aeb1e7f16c2b6-20250926
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 514014623; Fri, 26 Sep 2025 13:34:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Sep 2025 13:34:48 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Sep 2025 13:34:48 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Leon Yen <leon.yen@mediatek.com>, Ming
 Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: introduce CSA support in non-MLO mode
Date: Fri, 26 Sep 2025 13:34:47 +0800
Message-ID: <20250926053447.4036650-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Leon Yen <leon.yen@mediatek.com>

Add CSA (Channel Switch Announcement) related implementation
in collaboration with mac80211 to deal with dynamic channel
switching.

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 139 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |   1 +
 .../net/wireless/mediatek/mt76/mt792x_core.c  |   5 +-
 3 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 8ba27bc6a1ac..a2a94e5fbf04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -241,6 +241,7 @@ int mt7925_init_mlo_caps(struct mt792x_phy *phy)
 {
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
 	static const u8 ext_capa_sta[] = {
+		[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
 		[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 		[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	};
@@ -434,6 +435,9 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	if (phy->chip_cap & MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN)
 		vif->driver_flags |= IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 
+	INIT_WORK(&mvif->csa_work, mt7925_csa_work);
+	timer_setup(&mvif->csa_timer, mt792x_csa_timer, 0);
+
 out:
 	mt792x_mutex_release(dev);
 
@@ -1758,6 +1762,10 @@ static int
 mt7925_add_chanctx(struct ieee80211_hw *hw,
 		   struct ieee80211_chanctx_conf *ctx)
 {
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	dev->new_ctx = ctx;
+
 	return 0;
 }
 
@@ -1765,6 +1773,11 @@ static void
 mt7925_remove_chanctx(struct ieee80211_hw *hw,
 		      struct ieee80211_chanctx_conf *ctx)
 {
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	if (dev->new_ctx == ctx)
+		dev->new_ctx = NULL;
+
 }
 
 static void
@@ -2153,6 +2166,11 @@ static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mctx->bss_conf = NULL;
 	mconf->mt76.ctx = NULL;
 	mutex_unlock(&dev->mt76.mutex);
+
+	if (link_conf->csa_active) {
+		timer_delete_sync(&mvif->csa_timer);
+		cancel_work_sync(&mvif->csa_work);
+	}
 }
 
 static void mt7925_rfkill_poll(struct ieee80211_hw *hw)
@@ -2167,6 +2185,121 @@ static void mt7925_rfkill_poll(struct ieee80211_hw *hw)
 	wiphy_rfkill_set_hw_state(hw->wiphy, ret == 0);
 }
 
+static int mt7925_switch_vif_chanctx(struct ieee80211_hw *hw,
+				     struct ieee80211_vif_chanctx_switch *vifs,
+				     int n_vifs,
+				     enum ieee80211_chanctx_switch_mode mode)
+{
+	return mt7925_assign_vif_chanctx(hw, vifs->vif, vifs->link_conf,
+					 vifs->new_ctx);
+}
+
+void mt7925_csa_work(struct work_struct *work)
+{
+	struct mt792x_vif *mvif;
+	struct mt792x_dev *dev;
+	struct ieee80211_vif *vif;
+	struct ieee80211_bss_conf *link_conf;
+	struct mt792x_bss_conf *mconf;
+	u8 link_id, roc_rtype;
+	int ret = 0;
+
+	mvif = (struct mt792x_vif *)container_of(work, struct mt792x_vif,
+						csa_work);
+	dev = mvif->phy->dev;
+	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
+
+	if (ieee80211_vif_is_mld(vif))
+		return;
+
+	if (!dev->new_ctx)
+		return;
+
+	link_id = 0;
+	mconf = &mvif->bss_conf;
+	link_conf = &vif->bss_conf;
+	roc_rtype = MT7925_ROC_REQ_JOIN;
+
+	mt792x_mutex_acquire(dev);
+	ret = mt7925_set_roc(mvif->phy, mconf, dev->new_ctx->def.chan,
+			     4000, roc_rtype);
+	mt792x_mutex_release(dev);
+	if (!ret) {
+		mt792x_mutex_acquire(dev);
+		ret = mt7925_mcu_set_chctx(mvif->phy->mt76, &mconf->mt76, link_conf,
+					   dev->new_ctx);
+		mt792x_mutex_release(dev);
+
+		mt7925_abort_roc(mvif->phy, mconf);
+	}
+
+	ieee80211_chswitch_done(vif, !ret, link_id);
+}
+
+static int mt7925_pre_channel_switch(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_channel_switch *chsw)
+{
+	if (ieee80211_vif_is_mld(vif))
+		return -EOPNOTSUPP;
+
+	if (vif->type != NL80211_IFTYPE_STATION || !vif->cfg.assoc)
+		return -EOPNOTSUPP;
+
+	if (!cfg80211_chandef_usable(hw->wiphy, &chsw->chandef,
+				     IEEE80211_CHAN_DISABLED))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void mt7925_channel_switch(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_channel_switch *chsw)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	u16 beacon_interval;
+
+	if (ieee80211_vif_is_mld(vif))
+		return;
+
+	beacon_interval = vif->bss_conf.beacon_int;
+
+	mvif->csa_timer.expires = TU_TO_EXP_TIME(beacon_interval * chsw->count);
+	add_timer(&mvif->csa_timer);
+}
+
+static void mt7925_abort_channel_switch(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link_conf)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+	timer_delete_sync(&mvif->csa_timer);
+	cancel_work_sync(&mvif->csa_work);
+}
+
+static void mt7925_channel_switch_rx_beacon(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif,
+					    struct ieee80211_channel_switch *chsw)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	u16 beacon_interval;
+
+	if (ieee80211_vif_is_mld(vif))
+		return;
+
+	beacon_interval = vif->bss_conf.beacon_int;
+
+	if (cfg80211_chandef_identical(&chsw->chandef,
+				       &dev->new_ctx->def) &&
+				       chsw->count) {
+		mod_timer(&mvif->csa_timer,
+			  TU_TO_EXP_TIME(beacon_interval * chsw->count));
+	}
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
@@ -2230,6 +2363,12 @@ const struct ieee80211_ops mt7925_ops = {
 	.change_vif_links = mt7925_change_vif_links,
 	.change_sta_links = mt7925_change_sta_links,
 	.rfkill_poll = mt7925_rfkill_poll,
+
+	.switch_vif_chanctx = mt7925_switch_vif_chanctx,
+	.pre_channel_switch = mt7925_pre_channel_switch,
+	.channel_switch = mt7925_channel_switch,
+	.abort_channel_switch = mt7925_abort_channel_switch,
+	.channel_switch_rx_beacon = mt7925_channel_switch_rx_beacon,
 };
 EXPORT_SYMBOL_GPL(mt7925_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index b8ccdc0e2772..ac1e381eff40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -300,6 +300,7 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 void mt7925_mlo_pm_work(struct work_struct *work);
 void mt7925_scan_work(struct work_struct *work);
 void mt7925_roc_work(struct work_struct *work);
+void mt7925_csa_work(struct work_struct *work);
 int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 			  struct ieee80211_bss_conf *link_conf);
 void mt7925_coredump_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 0c090288d7b8..65cff5302a5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -691,9 +691,8 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
 
-	if (is_mt7921(&dev->mt76)) {
-		ieee80211_hw_set(hw, CHANCTX_STA_CSA);
-	}
+	ieee80211_hw_set(hw, CHANCTX_STA_CSA);
+
 
 	if (dev->pm.enable)
 		ieee80211_hw_set(hw, CONNECTION_MONITOR);
-- 
2.34.1


