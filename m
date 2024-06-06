Return-Path: <linux-wireless+bounces-8634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F338FF445
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 20:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EFE1F25E0A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE0719925D;
	Thu,  6 Jun 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="n4Yi4l6c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A476199246
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697240; cv=none; b=pnUjCcoyQaI7yUZ0Giacj5IrvTXn6fTmnGc1R6po14SD7QJ8YZ+bk9QsSdHK/KUJC6DPgl43rAcCO+2IxUHyVqjPTBYE/AsJDuu2ItWN09tvGdAxac1CcoRWGZZa5jZvIxF07WNjDkD/PuZzR8aPkViYruTLPl+2cV1CY31EjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697240; c=relaxed/simple;
	bh=ln3vek2S85svm980u94ZDrJ52TlgK9iVti/TN9Jf2xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNroFxaJkzC9GG1MwaH9iFaxFay+1A/Z/apF4na8tQ0NOlCf8ir2LLr1Pc4l2LOySW429REMyHXhZSI5CCFUQINwnKeS0txPytZTuzE4kRo5foBiwH4B4b6E/lTsmb/on6PQjNMLWTS1UnM981LUj/js8RXvp0Pj4aAsyIS0iCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=n4Yi4l6c; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JbXTarPJPaeXGWkb/A7Gha7UAcTJFtyS+ZWKw9xp0MI=; b=n4Yi4l6cWSoob3o3/m3WZ9eT3x
	Z3B0bAf6XloUek+xaTsVV5zz+OcklVh+Gn6D5eSm1Q7x+I2SPYHDz2HOH9oTnsIzCvgcWCiMZvb+O
	hD1kth0j/e6QcVoKR/u4pQvlMM+fp1D6EeKsTCAki1Qsc0/TkEu2BeQ2KHjxrKss2ZHc=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFHW7-008aic-2C;
	Thu, 06 Jun 2024 20:07:15 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v3 6/8] wifi: mac80211: extend ifcomb check functions for multi-radio
Date: Thu,  6 Jun 2024 20:07:11 +0200
Message-ID: <bc603fc671010bb720e75881ef0e22d81ec6e2eb.1717696995.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
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
 net/mac80211/ieee80211_i.h |   6 +-
 net/mac80211/iface.c       |   2 +-
 net/mac80211/util.c        | 131 +++++++++++++++++++++++++++-----------
 6 files changed, 116 insertions(+), 49 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 62119e957cd8..950b7b72f0b8 100644
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
 
@@ -4001,7 +4001,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 
 	/* if reservation is invalid then this will fail */
-	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
+	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0, -1);
 	if (err) {
 		ieee80211_link_unreserve_chanctx(link_data);
 		goto out;
@@ -5199,4 +5199,5 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.del_link_station = ieee80211_del_link_station,
 	.set_hw_timestamp = ieee80211_set_hw_timestamp,
 	.set_ttlm = ieee80211_set_ttlm,
+	.get_radio_mask = ieee80211_get_radio_mask,
 };
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 574ae961a7cf..0e899c07bc2b 100644
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
@@ -1072,7 +1077,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
 	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
-		if (ieee80211_can_create_new_chanctx(local)) {
+		if (ieee80211_can_create_new_chanctx(local, -1)) {
 			new_ctx = ieee80211_new_chanctx(local, chanreq, mode,
 							false);
 			if (IS_ERR(new_ctx))
@@ -1767,7 +1772,7 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	link->radar_required = ret;
 
 	ret = ieee80211_check_combinations(sdata, &chanreq->oper, mode,
-					   radar_detect_width);
+					   radar_detect_width, -1);
 	if (ret < 0)
 		goto out;
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index bf338f3d4dd3..522e964bb186 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1745,7 +1745,7 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 		IEEE80211_CHANCTX_SHARED : IEEE80211_CHANCTX_EXCLUSIVE;
 
 	ret = ieee80211_check_combinations(sdata, &params->chandef, chanmode,
-					   radar_detect_width);
+					   radar_detect_width, -1);
 	if (ret < 0)
 		return ret;
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3fd7b1adbfab..33c783432383 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2038,6 +2038,8 @@ static inline bool ieee80211_sdata_running(struct ieee80211_sub_if_data *sdata)
 {
 	return test_bit(SDATA_STATE_RUNNING, &sdata->state);
 }
+int ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev,
+			     u32 *mask);
 
 /* link handling */
 void ieee80211_link_setup(struct ieee80211_link_data *link);
@@ -2620,8 +2622,8 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 				 const struct cfg80211_chan_def *chandef,
 				 enum ieee80211_chanctx_mode chanmode,
-				 u8 radar_detect);
-int ieee80211_max_num_channels(struct ieee80211_local *local);
+				 u8 radar_detect, int radio_idx);
+int ieee80211_max_num_channels(struct ieee80211_local *local, int radio_idx);
 void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx);
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index d1a49ee4a194..5dc85f9409cd 100644
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
index 927f752a0209..9a7b70b1553c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3928,13 +3928,96 @@ static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
 	return radar_detect;
 }
 
+static u32
+__ieee80211_get_radio_mask(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx_conf *conf;
+	struct ieee80211_link_data *link;
+	u32 mask = 0;
+
+	for_each_sdata_link(local, link) {
+		conf = rcu_dereference(link->conf->chanctx_conf);
+		if (!conf || conf->radio_idx < 0)
+			continue;
+
+		mask |= BIT(conf->radio_idx);
+	}
+
+	return mask;
+}
+
+int ieee80211_get_radio_mask(struct wiphy *wiphy, struct net_device *dev,
+			     u32 *mask)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+
+	*mask = __ieee80211_get_radio_mask(sdata);
+
+	return 0;
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
+			     struct ieee80211_sub_if_data *sdata,
+			     int radio_idx)
+{
+	struct ieee80211_sub_if_data *sdata_iter;
+	struct ieee80211_chanctx *ctx;
+
+	list_for_each_entry(ctx, &local->chanctx_list, list) {
+		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
+			continue;
+
+		if (radio_idx >= 0 && ctx->conf.radio_idx != radio_idx)
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
+	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
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
+		if (!ieee80211_sdata_uses_radio(sdata_iter, radio_idx))
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
@@ -3977,6 +4060,8 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 	if (iftype != NL80211_IFTYPE_UNSPECIFIED)
 		params.iftype_num[iftype] = 1;
 
+	ieee80211_fill_ifcomb_params(local, &params, shared ? chandef : NULL,
+				     sdata, radio_idx);
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
 			continue;
@@ -3986,28 +4071,9 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
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
 
@@ -4024,28 +4090,21 @@ ieee80211_iter_max_chans(const struct ieee80211_iface_combination *c,
 					  c->num_different_channels);
 }
 
-int ieee80211_max_num_channels(struct ieee80211_local *local)
+int ieee80211_max_num_channels(struct ieee80211_local *local, int radio_idx)
 {
-	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_chanctx *ctx;
+	struct wiphy *wiphy = local->hw.wiphy;
 	u32 max_num_different_channels = 1;
 	int err;
 	struct iface_combination_params params = {0};
 
-	lockdep_assert_wiphy(local->hw.wiphy);
-
-	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
-			continue;
-
-		params.num_different_channels++;
+	if (radio_idx >= wiphy->n_radio)
+		return -EINVAL;
+	else if (radio_idx >= 0)
+		params.radio = &wiphy->radio[radio_idx];
 
-		params.radar_detect |=
-			ieee80211_chanctx_radar_detect(local, ctx);
-	}
+	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry_rcu(sdata, &local->interfaces, list)
-		params.iftype_num[sdata->wdev.iftype]++;
+	ieee80211_fill_ifcomb_params(local, &params, NULL, NULL, radio_idx);
 
 	err = cfg80211_iter_combinations(local->hw.wiphy, &params,
 					 ieee80211_iter_max_chans,
-- 
git-series 0.9.1

