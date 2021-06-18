Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7C83AC908
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 12:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhFRKoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 06:44:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48144 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233742AbhFRKoQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 06:44:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBwq-001YXx-Gd; Fri, 18 Jun 2021 13:42:06 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:30 +0300
Message-Id: <iwlwifi.20210618133832.fc4e24496aa2.Ic40ea947c2f65739ea4b5fe3babd0a544240ced6@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 05/31] mac80211: handle rate control (RC) racing with chanctx definition
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

chanctx represents the current phy configuration and rate scale uses
it for achieving max throughput, so if phy changes bandwidth to narrow
bandwidth, RC should be _first_ updated to avoid using the wider bandwidth
before updating the phy, and vice versa.

We assume in the patch that station interface is always updated before
updating phy context by calling ieee80211_vif_update_chandef.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/chan.c | 108 ++++++++++++++++++++++++++++----------------
 net/mac80211/mlme.c |  89 +-----------------------------------
 2 files changed, 71 insertions(+), 126 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 907bb1f748a1..76fc36a68750 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * mac80211 - channel management
+ * Copyright 2020 - 2021 Intel Corporation
  */
 
 #include <linux/nl80211.h>
@@ -308,8 +309,8 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
  * the max of min required widths of all the interfaces bound to this
  * channel context.
  */
-void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx)
+static u32 _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
+					     struct ieee80211_chanctx *ctx)
 {
 	enum nl80211_chan_width max_bw;
 	struct cfg80211_chan_def min_def;
@@ -326,7 +327,7 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	    ctx->conf.def.width == NL80211_CHAN_WIDTH_16 ||
 	    ctx->conf.radar_enabled) {
 		ctx->conf.min_def = ctx->conf.def;
-		return;
+		return 0;
 	}
 
 	max_bw = ieee80211_get_chanctx_max_required_bw(local, &ctx->conf);
@@ -337,17 +338,21 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 		ieee80211_chandef_downgrade(&min_def);
 
 	if (cfg80211_chandef_identical(&ctx->conf.min_def, &min_def))
-		return;
+		return 0;
 
 	ctx->conf.min_def = min_def;
 	if (!ctx->driver_present)
-		return;
+		return 0;
 
-	drv_change_chanctx(local, ctx, IEEE80211_CHANCTX_CHANGE_MIN_WIDTH);
+	return IEEE80211_CHANCTX_CHANGE_MIN_WIDTH;
 }
 
+/* calling this function is assuming that station vif is updated to
+ * lates changes by calling ieee80211_vif_update_chandef
+ */
 static void ieee80211_chan_bw_change(struct ieee80211_local *local,
-				     struct ieee80211_chanctx *ctx)
+				     struct ieee80211_chanctx *ctx,
+				     bool narrowed)
 {
 	struct sta_info *sta;
 	struct ieee80211_supported_band *sband =
@@ -366,9 +371,16 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 			continue;
 
 		new_sta_bw = ieee80211_sta_cur_vht_bw(sta);
+
+		/* nothing change */
 		if (new_sta_bw == sta->sta.bandwidth)
 			continue;
 
+		/* vif changed to narrow BW and narrow BW for station wasn't
+		 * requested or vise versa */
+		if ((new_sta_bw < sta->sta.bandwidth) == !narrowed)
+			continue;
+
 		sta->sta.bandwidth = new_sta_bw;
 		rate_control_rate_update(local, sband, sta,
 					 IEEE80211_RC_BW_CHANGED);
@@ -376,21 +388,34 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 	rcu_read_unlock();
 }
 
-static void ieee80211_change_chanctx(struct ieee80211_local *local,
-				     struct ieee80211_chanctx *ctx,
-				     const struct cfg80211_chan_def *chandef)
+/*
+ * recalc the min required chan width of the channel context, which is
+ * the max of min required widths of all the interfaces bound to this
+ * channel context.
+ */
+void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
+				      struct ieee80211_chanctx *ctx)
 {
-	enum nl80211_chan_width width;
+	u32 changed = _ieee80211_recalc_chanctx_min_def(local, ctx);
 
-	if (cfg80211_chandef_identical(&ctx->conf.def, chandef)) {
-		ieee80211_recalc_chanctx_min_def(local, ctx);
+	if (!changed)
 		return;
-	}
 
-	WARN_ON(!cfg80211_chandef_compatible(&ctx->conf.def, chandef));
+	/* check is BW narrowed */
+	ieee80211_chan_bw_change(local, ctx, true);
 
-	width = ctx->conf.def.width;
-	ctx->conf.def = *chandef;
+	drv_change_chanctx(local, ctx, changed);
+
+	/* check is BW wider */
+	ieee80211_chan_bw_change(local, ctx, false);
+}
+
+static void ieee80211_change_chanctx(struct ieee80211_local *local,
+				     struct ieee80211_chanctx *ctx,
+				     struct ieee80211_chanctx *old_ctx,
+				     const struct cfg80211_chan_def *chandef)
+{
+	u32 changed;
 
 	/* expected to handle only 20/40/80/160 channel widths */
 	switch (chandef->width) {
@@ -405,19 +430,33 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 		WARN_ON(1);
 	}
 
-	if (chandef->width < width)
-		ieee80211_chan_bw_change(local, ctx);
+	/* Check maybe BW narrowed - we do this _before_ calling recalc_chanctx_min_def
+	 * due to maybe not returning from it, e.g in case new context was added
+	 * first time with all parameters up to date.
+	 */
+	ieee80211_chan_bw_change(local, old_ctx, true);
+
+	if (cfg80211_chandef_identical(&ctx->conf.def, chandef)) {
+		ieee80211_recalc_chanctx_min_def(local, ctx);
+		return;
+	}
 
-	drv_change_chanctx(local, ctx, IEEE80211_CHANCTX_CHANGE_WIDTH);
-	ieee80211_recalc_chanctx_min_def(local, ctx);
+	WARN_ON(!cfg80211_chandef_compatible(&ctx->conf.def, chandef));
+
+	ctx->conf.def = *chandef;
+
+	/* check if min chanctx also changed */
+	changed = IEEE80211_CHANCTX_CHANGE_WIDTH |
+		  _ieee80211_recalc_chanctx_min_def(local, ctx);
+	drv_change_chanctx(local, ctx, changed);
 
 	if (!local->use_chanctx) {
 		local->_oper_chandef = *chandef;
 		ieee80211_hw_config(local, 0);
 	}
 
-	if (chandef->width > width)
-		ieee80211_chan_bw_change(local, ctx);
+	/* check is BW wider */
+	ieee80211_chan_bw_change(local, old_ctx, false);
 }
 
 static struct ieee80211_chanctx *
@@ -450,7 +489,7 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 		if (!compat)
 			continue;
 
-		ieee80211_change_chanctx(local, ctx, compat);
+		ieee80211_change_chanctx(local, ctx, ctx, compat);
 
 		return ctx;
 	}
@@ -679,7 +718,7 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 	if (!compat)
 		return;
 
-	ieee80211_change_chanctx(local, ctx, compat);
+	ieee80211_change_chanctx(local, ctx, ctx, compat);
 }
 
 static void ieee80211_recalc_radar_chanctx(struct ieee80211_local *local,
@@ -1107,13 +1146,12 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 	if (WARN_ON(!chandef))
 		return -EINVAL;
 
-	if (old_ctx->conf.def.width > new_ctx->conf.def.width)
-		ieee80211_chan_bw_change(local, new_ctx);
+	if (sdata->vif.bss_conf.chandef.width != sdata->reserved_chandef.width)
+		changed = BSS_CHANGED_BANDWIDTH;
 
-	ieee80211_change_chanctx(local, new_ctx, chandef);
+	ieee80211_vif_update_chandef(sdata, &sdata->reserved_chandef);
 
-	if (old_ctx->conf.def.width < new_ctx->conf.def.width)
-		ieee80211_chan_bw_change(local, new_ctx);
+	ieee80211_change_chanctx(local, new_ctx, old_ctx, chandef);
 
 	vif_chsw[0].vif = &sdata->vif;
 	vif_chsw[0].old_ctx = &old_ctx->conf;
@@ -1142,14 +1180,9 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
 		ieee80211_free_chanctx(local, old_ctx);
 
-	if (sdata->vif.bss_conf.chandef.width != sdata->reserved_chandef.width)
-		changed = BSS_CHANGED_BANDWIDTH;
-
-	ieee80211_vif_update_chandef(sdata, &sdata->reserved_chandef);
-
+	ieee80211_recalc_chanctx_min_def(local, new_ctx);
 	ieee80211_recalc_smps_chanctx(local, new_ctx);
 	ieee80211_recalc_radar_chanctx(local, new_ctx);
-	ieee80211_recalc_chanctx_min_def(local, new_ctx);
 
 	if (changed)
 		ieee80211_bss_info_change_notify(sdata, changed);
@@ -1188,7 +1221,7 @@ ieee80211_vif_use_reserved_assign(struct ieee80211_sub_if_data *sdata)
 	if (WARN_ON(!chandef))
 		return -EINVAL;
 
-	ieee80211_change_chanctx(local, new_ctx, chandef);
+	ieee80211_change_chanctx(local, new_ctx, new_ctx, chandef);
 
 	list_del(&sdata->reserved_chanctx_list);
 	sdata->reserved_chanctx = NULL;
@@ -1505,7 +1538,6 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ieee80211_recalc_smps_chanctx(local, ctx);
 		ieee80211_recalc_radar_chanctx(local, ctx);
 		ieee80211_recalc_chanctx_min_def(local, ctx);
-		ieee80211_chan_bw_change(local, ctx);
 
 		list_for_each_entry_safe(sdata, sdata_tmp, &ctx->reserved_vifs,
 					 reserved_chanctx_list) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 310cfd02fda4..fe7120f3b2ba 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -371,7 +371,6 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_chan_def chandef;
 	u16 ht_opmode;
 	u32 flags;
-	enum ieee80211_sta_rx_bandwidth new_sta_bw;
 	u32 vht_cap_info = 0;
 	int ret;
 
@@ -450,35 +449,8 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 	}
 
-	switch (chandef.width) {
-	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_20:
-		new_sta_bw = IEEE80211_STA_RX_BW_20;
-		break;
-	case NL80211_CHAN_WIDTH_40:
-		new_sta_bw = IEEE80211_STA_RX_BW_40;
-		break;
-	case NL80211_CHAN_WIDTH_80:
-		new_sta_bw = IEEE80211_STA_RX_BW_80;
-		break;
-	case NL80211_CHAN_WIDTH_80P80:
-	case NL80211_CHAN_WIDTH_160:
-		new_sta_bw = IEEE80211_STA_RX_BW_160;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (new_sta_bw > sta->cur_max_bandwidth)
-		new_sta_bw = sta->cur_max_bandwidth;
-
-	if (new_sta_bw < sta->sta.bandwidth) {
-		sta->sta.bandwidth = new_sta_bw;
-		rate_control_rate_update(local, sband, sta,
-					 IEEE80211_RC_BW_CHANGED);
-	}
-
 	ret = ieee80211_vif_change_bandwidth(sdata, &chandef, changed);
+
 	if (ret) {
 		sdata_info(sdata,
 			   "AP %pM changed bandwidth to incompatible one - disconnect\n",
@@ -486,12 +458,6 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 		return ret;
 	}
 
-	if (new_sta_bw > sta->sta.bandwidth) {
-		sta->sta.bandwidth = new_sta_bw;
-		rate_control_rate_update(local, sband, sta,
-					 IEEE80211_RC_BW_CHANGED);
-	}
-
 	return 0;
 }
 
@@ -1183,10 +1149,6 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 	 */
 
 	if (sdata->reserved_chanctx) {
-		struct ieee80211_supported_band *sband = NULL;
-		struct sta_info *mgd_sta = NULL;
-		enum ieee80211_sta_rx_bandwidth bw = IEEE80211_STA_RX_BW_20;
-
 		/*
 		 * with multi-vif csa driver may call ieee80211_csa_finish()
 		 * many times while waiting for other interfaces to use their
@@ -1195,48 +1157,6 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 		if (sdata->reserved_ready)
 			goto out;
 
-		if (sdata->vif.bss_conf.chandef.width !=
-		    sdata->csa_chandef.width) {
-			/*
-			 * For managed interface, we need to also update the AP
-			 * station bandwidth and align the rate scale algorithm
-			 * on the bandwidth change. Here we only consider the
-			 * bandwidth of the new channel definition (as channel
-			 * switch flow does not have the full HT/VHT/HE
-			 * information), assuming that if additional changes are
-			 * required they would be done as part of the processing
-			 * of the next beacon from the AP.
-			 */
-			switch (sdata->csa_chandef.width) {
-			case NL80211_CHAN_WIDTH_20_NOHT:
-			case NL80211_CHAN_WIDTH_20:
-			default:
-				bw = IEEE80211_STA_RX_BW_20;
-				break;
-			case NL80211_CHAN_WIDTH_40:
-				bw = IEEE80211_STA_RX_BW_40;
-				break;
-			case NL80211_CHAN_WIDTH_80:
-				bw = IEEE80211_STA_RX_BW_80;
-				break;
-			case NL80211_CHAN_WIDTH_80P80:
-			case NL80211_CHAN_WIDTH_160:
-				bw = IEEE80211_STA_RX_BW_160;
-				break;
-			}
-
-			mgd_sta = sta_info_get(sdata, ifmgd->bssid);
-			sband =
-				local->hw.wiphy->bands[sdata->csa_chandef.chan->band];
-		}
-
-		if (sdata->vif.bss_conf.chandef.width >
-		    sdata->csa_chandef.width) {
-			mgd_sta->sta.bandwidth = bw;
-			rate_control_rate_update(local, sband, mgd_sta,
-						 IEEE80211_RC_BW_CHANGED);
-		}
-
 		ret = ieee80211_vif_use_reserved_context(sdata);
 		if (ret) {
 			sdata_info(sdata,
@@ -1247,13 +1167,6 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 			goto out;
 		}
 
-		if (sdata->vif.bss_conf.chandef.width <
-		    sdata->csa_chandef.width) {
-			mgd_sta->sta.bandwidth = bw;
-			rate_control_rate_update(local, sband, mgd_sta,
-						 IEEE80211_RC_BW_CHANGED);
-		}
-
 		goto out;
 	}
 
-- 
2.32.0

