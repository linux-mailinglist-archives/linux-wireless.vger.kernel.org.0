Return-Path: <linux-wireless+bounces-9782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B772F91E20E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 16:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6873028976F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3CE167290;
	Mon,  1 Jul 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="sMuFr6Xe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755F1662E3
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843220; cv=none; b=DWprsLq8Ds8Wg8KGd6PpSVnEnDTfCYRXho5p7DFOKqwQ3r1fbWjWwVkLUc+h1sZYPujFP8FjRfOvZ9i6PPfBJB0Caqhz50cFS8FSfSzEG9nEykI4KrtRoDI3DEE1CJ+1z8aRlz82YscO/DVAtwoVCNyqx1KhmusIgzDgOPfsUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843220; c=relaxed/simple;
	bh=fnGLKBAV4cRm4tXZMPheBM713/sARXettbO0Cu6XL1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UY5s9XVpJZxMIMk0WIkyi93MHLmMmzdNQiS8WuN9gELbetNey72PfMWkRMkAVpto4RjO7YDrm9yKFU2pjycuwhN9wAapZWdp1vxNTqJZ0Nm6EAcF5pSNV6Kyczx7WHaORtG3JNAG/3aRwfBnw4SalX6wzlVhss/h+MT7Tc72meo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=sMuFr6Xe; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WOsMgrHvSu5wMN5m+AycX1LxX904d6YRzoAH7WF7uuE=; b=sMuFr6XeYuAXuElAVHcYMCSBaf
	QTikjiiuqR07VIyiB/IK1D51e7q2OYSuB/Bcky2hEr8v9mdIC/fc3GMcifxxZP+TSzrQ+aawOe8fi
	DO2sdcx05LCZqToND61t9l1TZnjlADx39+BlE4O/GOil9lKaKcY/koGzWTilGCcamSKI=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sOHma-001Qfu-1A;
	Mon, 01 Jul 2024 16:13:28 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v3 07/10] wifi: mac80211: extend ifcomb check functions for multi-radio
Date: Mon,  1 Jul 2024 16:13:22 +0200
Message-ID: <15d63cd77aad2d2eef503676a3f3fbabe78d5828.1719843147.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
References: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for counting global and per-radio max/current number of
channels, as well as checking radio-specific interface combinations.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/cfg.c         |   7 +-
 net/mac80211/chan.c        |  17 +++--
 net/mac80211/ibss.c        |   2 +-
 net/mac80211/ieee80211_i.h |   5 +-
 net/mac80211/iface.c       |   2 +-
 net/mac80211/util.c        | 126 ++++++++++++++++++++++++++------------
 6 files changed, 108 insertions(+), 51 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 3d49b3ee3a2b..85cb71de370f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -263,7 +263,7 @@ static int ieee80211_start_p2p_device(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
+	ret = ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
 	if (ret < 0)
 		return ret;
 
@@ -285,7 +285,7 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
+	ret = ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
 	if (ret < 0)
 		return ret;
 
@@ -4008,7 +4008,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 
 	/* if reservation is invalid then this will fail */
-	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
+	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0, -1);
 	if (err) {
 		ieee80211_link_unreserve_chanctx(link_data);
 		goto out;
@@ -5203,4 +5203,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.del_link_station = ieee80211_del_link_station,
 	.set_hw_timestamp = ieee80211_set_hw_timestamp,
 	.set_ttlm = ieee80211_set_ttlm,
+	.get_radio_mask = ieee80211_get_radio_mask,
 };
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 6c4d02cb07bb..12bad02da561 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -47,24 +47,29 @@ int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 	       ieee80211_chanctx_num_reserved(local, ctx);
 }
 
-static int ieee80211_num_chanctx(struct ieee80211_local *local)
+static int ieee80211_num_chanctx(struct ieee80211_local *local, int radio_idx)
 {
 	struct ieee80211_chanctx *ctx;
 	int num = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(ctx, &local->chanctx_list, list)
+	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		if (radio_idx >= 0 && ctx->conf.radio_idx != radio_idx)
+			continue;
 		num++;
+	}
 
 	return num;
 }
 
-static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local)
+static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local,
+					     int radio_idx)
 {
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	return ieee80211_num_chanctx(local) < ieee80211_max_num_channels(local);
+	return ieee80211_num_chanctx(local, radio_idx) <
+	       ieee80211_max_num_channels(local, radio_idx);
 }
 
 static struct ieee80211_chanctx *
@@ -1101,7 +1106,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
 	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
-		if (ieee80211_can_create_new_chanctx(local)) {
+		if (ieee80211_can_create_new_chanctx(local, -1)) {
 			new_ctx = ieee80211_new_chanctx(local, chanreq, mode,
 							false);
 			if (IS_ERR(new_ctx))
@@ -1822,7 +1827,7 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	link->radar_required = ret;
 
 	ret = ieee80211_check_combinations(sdata, &chanreq->oper, mode,
-					   radar_detect_width);
+					   radar_detect_width, -1);
 	if (ret < 0)
 		goto out;
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 7db4c3ee7e6d..3f74bbceeca5 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1746,7 +1746,7 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 		IEEE80211_CHANCTX_SHARED : IEEE80211_CHANCTX_EXCLUSIVE;
 
 	ret = ieee80211_check_combinations(sdata, &params->chandef, chanmode,
-					   radar_detect_width);
+					   radar_detect_width, -1);
 	if (ret < 0)
 		return ret;
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6349552e62a8..a3485e4c6132 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2640,8 +2640,9 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 				 const struct cfg80211_chan_def *chandef,
 				 enum ieee80211_chanctx_mode chanmode,
-				 u8 radar_detect);
-int ieee80211_max_num_channels(struct ieee80211_local *local);
+				 u8 radar_detect, int radio_idx);
+int ieee80211_max_num_channels(struct ieee80211_local *local, int radio_idx);
+u32 ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev);
 void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx);
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6d969d9f1ac9..adf907e15d70 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -397,7 +397,7 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	return ieee80211_check_combinations(sdata, NULL, 0, 0);
+	return ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
 }
 
 static int ieee80211_check_queues(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27f0db2e9796..ff61a5d1c689 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3932,19 +3932,99 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 	return radar_detect;
 }
 
+static u32
+__ieee80211_get_radio_mask(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_bss_conf *link_conf;
+	struct ieee80211_chanctx_conf *conf;
+	unsigned int link_id;
+	u32 mask = 0;
+
+	for_each_vif_active_link(&sdata->vif, link_conf, link_id) {
+		conf = sdata_dereference(link_conf->chanctx_conf, sdata);
+		if (!conf || conf->radio_idx < 0)
+			continue;
+
+		mask |= BIT(conf->radio_idx);
+	}
+
+	return mask;
+}
+
+u32 ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+
+	return __ieee80211_get_radio_mask(sdata);
+}
+
+static bool
+ieee80211_sdata_uses_radio(struct ieee80211_sub_if_data *sdata, int radio_idx)
+{
+	if (radio_idx < 0)
+		return true;
+
+	return __ieee80211_get_radio_mask(sdata) & BIT(radio_idx);
+}
+
+static void
+ieee80211_fill_ifcomb_params(struct ieee80211_local *local,
+			     struct iface_combination_params *params,
+			     const struct cfg80211_chan_def *chandef,
+			     struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_sub_if_data *sdata_iter;
+	struct ieee80211_chanctx *ctx;
+
+	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
+			continue;
+
+		if (params->radio_idx >= 0 &&
+		    ctx->conf.radio_idx != params->radio_idx)
+			continue;
+
+		if (chandef &&
+		    cfg80211_chandef_compatible(chandef, &ctx->conf.def))
+			continue;
+
+		params->num_different_channels++;
+
+		params->radar_detect |=
+			ieee80211_chanctx_radar_detect(local, ctx);
+	}
+
+	list_for_each_entry(sdata_iter, &local->interfaces, list) {
+		struct wireless_dev *wdev_iter;
+
+		wdev_iter = &sdata_iter->wdev;
+
+		if (sdata_iter == sdata ||
+		    !ieee80211_sdata_running(sdata_iter) ||
+		    cfg80211_iftype_allowed(local->hw.wiphy,
+					    wdev_iter->iftype, 0, 1))
+			continue;
+
+		if (!ieee80211_sdata_uses_radio(sdata_iter, params->radio_idx))
+			continue;
+
+		params->iftype_num[wdev_iter->iftype]++;
+	}
+}
+
 int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 				 const struct cfg80211_chan_def *chandef,
 				 enum ieee80211_chanctx_mode chanmode,
-				 u8 radar_detect)
+				 u8 radar_detect, int radio_idx)
 {
+	bool shared = chanmode == IEEE80211_CHANCTX_SHARED;
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_sub_if_data *sdata_iter;
 	enum nl80211_iftype iftype = sdata->wdev.iftype;
 	struct ieee80211_chanctx *ctx;
 	int total = 1;
 	struct iface_combination_params params = {
 		.radar_detect = radar_detect,
-		.radio_idx = -1,
+		.radio_idx = radio_idx,
 	};
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -3982,6 +4062,8 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 	if (iftype != NL80211_IFTYPE_UNSPECIFIED)
 		params.iftype_num[iftype] = 1;
 
+	ieee80211_fill_ifcomb_params(local, &params, shared ? chandef : NULL,
+				     sdata);
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
 			continue;
@@ -3991,28 +4073,9 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 			params.num_different_channels++;
 			continue;
 		}
-		if (chandef && chanmode == IEEE80211_CHANCTX_SHARED &&
-		    cfg80211_chandef_compatible(chandef,
-						&ctx->conf.def))
-			continue;
 		params.num_different_channels++;
 	}
 
-	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
-		struct wireless_dev *wdev_iter;
-
-		wdev_iter = &sdata_iter->wdev;
-
-		if (sdata_iter == sdata ||
-		    !ieee80211_sdata_running(sdata_iter) ||
-		    cfg80211_iftype_allowed(local->hw.wiphy,
-					    wdev_iter->iftype, 0, 1))
-			continue;
-
-		params.iftype_num[wdev_iter->iftype]++;
-		total++;
-	}
-
 	if (total == 1 && !params.radar_detect)
 		return 0;
 
@@ -4029,30 +4092,17 @@ ieee80211_iter_max_chans(const struct ieee80211_iface_combination *c,
 					  c->num_different_channels);
 }
 
-int ieee80211_max_num_channels(struct ieee80211_local *local)
+int ieee80211_max_num_channels(struct ieee80211_local *local, int radio_idx)
 {
-	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_chanctx *ctx;
 	u32 max_num_different_channels = 1;
 	int err;
 	struct iface_combination_params params = {
-		.radio_idx = -1,
+		.radio_idx = radio_idx,
 	};
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
-			continue;
-
-		params.num_different_channels++;
-
-		params.radar_detect |=
-			ieee80211_chanctx_radar_detect(local, ctx);
-	}
-
-	list_for_each_entry_rcu(sdata, &local->interfaces, list)
-		params.iftype_num[sdata->wdev.iftype]++;
+	ieee80211_fill_ifcomb_params(local, &params, NULL, NULL);
 
 	err = cfg80211_iter_combinations(local->hw.wiphy, &params,
 					 ieee80211_iter_max_chans,
-- 
git-series 0.9.1

