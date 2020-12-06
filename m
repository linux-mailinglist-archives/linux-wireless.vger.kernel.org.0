Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F142D0503
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 13:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgLFM5b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 07:57:31 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34974 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbgLFM5b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 07:57:31 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kltZ5-003AHZ-O5; Sun, 06 Dec 2020 14:55:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 14:54:50 +0200
Message-Id: <iwlwifi.20201206145305.600d967fe3c9.I48305f25cfcc9c032c77c51396e9e9b882748a86@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206125450.564941-1-luca@coelho.fi>
References: <20201206125450.564941-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/11] mac80211: Update rate control on channel change
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

A channel change or a channel bandwidth change can impact the
rate control logic. However, the rate control logic was not updated
before/after such a change, which might result in unexpected
behavior.

Fix this by updating the stations rate control logic when the
corresponding channel context changes.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/chan.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index c42574f2d48c..907bb1f748a1 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -9,6 +9,7 @@
 #include <net/cfg80211.h>
 #include "ieee80211_i.h"
 #include "driver-ops.h"
+#include "rate.h"
 
 static int ieee80211_chanctx_num_assigned(struct ieee80211_local *local,
 					  struct ieee80211_chanctx *ctx)
@@ -345,10 +346,42 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	drv_change_chanctx(local, ctx, IEEE80211_CHANCTX_CHANGE_MIN_WIDTH);
 }
 
+static void ieee80211_chan_bw_change(struct ieee80211_local *local,
+				     struct ieee80211_chanctx *ctx)
+{
+	struct sta_info *sta;
+	struct ieee80211_supported_band *sband =
+		local->hw.wiphy->bands[ctx->conf.def.chan->band];
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sta, &local->sta_list,
+				list) {
+		enum ieee80211_sta_rx_bandwidth new_sta_bw;
+
+		if (!ieee80211_sdata_running(sta->sdata))
+			continue;
+
+		if (rcu_access_pointer(sta->sdata->vif.chanctx_conf) !=
+		    &ctx->conf)
+			continue;
+
+		new_sta_bw = ieee80211_sta_cur_vht_bw(sta);
+		if (new_sta_bw == sta->sta.bandwidth)
+			continue;
+
+		sta->sta.bandwidth = new_sta_bw;
+		rate_control_rate_update(local, sband, sta,
+					 IEEE80211_RC_BW_CHANGED);
+	}
+	rcu_read_unlock();
+}
+
 static void ieee80211_change_chanctx(struct ieee80211_local *local,
 				     struct ieee80211_chanctx *ctx,
 				     const struct cfg80211_chan_def *chandef)
 {
+	enum nl80211_chan_width width;
+
 	if (cfg80211_chandef_identical(&ctx->conf.def, chandef)) {
 		ieee80211_recalc_chanctx_min_def(local, ctx);
 		return;
@@ -356,7 +389,25 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 
 	WARN_ON(!cfg80211_chandef_compatible(&ctx->conf.def, chandef));
 
+	width = ctx->conf.def.width;
 	ctx->conf.def = *chandef;
+
+	/* expected to handle only 20/40/80/160 channel widths */
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	case NL80211_CHAN_WIDTH_40:
+	case NL80211_CHAN_WIDTH_80:
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	if (chandef->width < width)
+		ieee80211_chan_bw_change(local, ctx);
+
 	drv_change_chanctx(local, ctx, IEEE80211_CHANCTX_CHANGE_WIDTH);
 	ieee80211_recalc_chanctx_min_def(local, ctx);
 
@@ -364,6 +415,9 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 		local->_oper_chandef = *chandef;
 		ieee80211_hw_config(local, 0);
 	}
+
+	if (chandef->width > width)
+		ieee80211_chan_bw_change(local, ctx);
 }
 
 static struct ieee80211_chanctx *
@@ -1053,8 +1107,14 @@ ieee80211_vif_use_reserved_reassign(struct ieee80211_sub_if_data *sdata)
 	if (WARN_ON(!chandef))
 		return -EINVAL;
 
+	if (old_ctx->conf.def.width > new_ctx->conf.def.width)
+		ieee80211_chan_bw_change(local, new_ctx);
+
 	ieee80211_change_chanctx(local, new_ctx, chandef);
 
+	if (old_ctx->conf.def.width < new_ctx->conf.def.width)
+		ieee80211_chan_bw_change(local, new_ctx);
+
 	vif_chsw[0].vif = &sdata->vif;
 	vif_chsw[0].old_ctx = &old_ctx->conf;
 	vif_chsw[0].new_ctx = &new_ctx->conf;
@@ -1445,6 +1505,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ieee80211_recalc_smps_chanctx(local, ctx);
 		ieee80211_recalc_radar_chanctx(local, ctx);
 		ieee80211_recalc_chanctx_min_def(local, ctx);
+		ieee80211_chan_bw_change(local, ctx);
 
 		list_for_each_entry_safe(sdata, sdata_tmp, &ctx->reserved_vifs,
 					 reserved_chanctx_list) {
-- 
2.29.2

