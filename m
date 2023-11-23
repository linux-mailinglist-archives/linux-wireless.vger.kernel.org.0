Return-Path: <linux-wireless+bounces-19-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F0D7F6909
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70601B20D61
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E5E4EB22;
	Thu, 23 Nov 2023 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MdlFuImg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2AD6C
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5DnOI6dLCGUE3852K1NYX0iYDoBEJM4Od61iQNyZXl0=;
	t=1700778484; x=1701988084; b=MdlFuImgMtwt6l+wJv6oazkJV1FXimnU+o5l5Fg/5wb31iT
	6um/9JpPhRPwbJ9s+3xRfoZEYY3lgpJWMShDtkLFpdgkSK/EjkIdX9/1fkhtITHj4TgSmXoj5XVDe
	3imbRlmImyF4Ls3mmpqG/YHVQ9onj6VYZcdsU2JuFL/mHFb6MEbYL8OmqJm/m/FUv0WDWT5LzKTuG
	qJuD2RHz59ehIyuAjQjP3Iip50ZVmyniZskZHO5wPpjsRGgrLGipYjOBGAp141F+iFqmL//ac0WCv
	mYKdqJJhZXvA+tchk1EYmSLSEppBbSLUQgIY1huEQe+pw7KZhwrjXE14MTv6/isw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IB0-00000001Y53-1krb;
	Thu, 23 Nov 2023 23:28:02 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 13/13] wifi: mac80211: support wider bandwidth OFDMA config
Date: Thu, 23 Nov 2023 23:14:50 +0100
Message-ID: <20231123231437.e13d689aff72.I939d04674f4ff06f39934b1591c8d36a30ce74c2@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123221436.143254-14-johannes@sipsolutions.net>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

EHT requires that stations are able to participate in
wider bandwidth OFDMA, i.e. parse downlink OFDMA and
uplink OFDMA triggers when they're not capable of (or
not connected at) the (wider) bandwidth that the AP
is using. This requires hardware configuration, since
the entity responsible for parsing (possibly hardware)
needs to know the AP bandwidth.

To support this, change the channel request to have
the AP's bandwidth for clients, and track that in the
channel context in mac80211. This means that the same
chandef might need to be split up into two different
contexts, if the APs are different. Interfaces other
than client are not participating in OFDMA the same
way, so they don't request any AP setting.

Note that this doesn't introduce any API to split a
channel context, so that there are cases where this
might lead to a disconnect, e.g. if there are two
client interfaces using the same channel context, e.g.
both 160 MHz connected to different 320 MHz APs, and
one of the APs switches to 160 MHz.

Note also there are possible cases where this can be
optimised, e.g. when using the upper or lower 160 Mhz,
but I haven't been able to really fully understand the
spec and/or hardware limitations.

If, for some reason, there are no hardware limits on
this because the OFDMA (downlink/trigger) parsing is
done in firmware and can take the transmitter into
account, then drivers can set the new flag
IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW on interfaces to
not have them request any AP bandwidth in the channel
context and ignore this issue entirely. The bss_conf
still contains the AP configuration (if any, i.e. EHT)
in the chanreq.

TODO:
 - I think we need this only if local supported bandwidth
   is at least 80 MHz? two places to take this into account

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  14 ++++
 net/mac80211/chan.c        | 146 ++++++++++++++++++++++++++++---------
 net/mac80211/ieee80211_i.h |  13 ++++
 net/mac80211/mlme.c        |  62 +++++++++-------
 net/mac80211/trace.h       |  31 +++++++-
 5 files changed, 202 insertions(+), 64 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 3d55fe835405..8d1a30a01c14 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -214,6 +214,8 @@ struct ieee80211_low_level_stats {
  * @IEEE80211_CHANCTX_CHANGE_CHANNEL: switched to another operating channel,
  *	this is used only with channel switching with CSA
  * @IEEE80211_CHANCTX_CHANGE_MIN_WIDTH: The min required channel width changed
+ * @IEEE80211_CHANCTX_CHANGE_AP: The AP channel definition changed, so (wider
+ *	bandwidth) OFDMA settings need to be changed
  */
 enum ieee80211_chanctx_change {
 	IEEE80211_CHANCTX_CHANGE_WIDTH		= BIT(0),
@@ -221,14 +223,18 @@ enum ieee80211_chanctx_change {
 	IEEE80211_CHANCTX_CHANGE_RADAR		= BIT(2),
 	IEEE80211_CHANCTX_CHANGE_CHANNEL	= BIT(3),
 	IEEE80211_CHANCTX_CHANGE_MIN_WIDTH	= BIT(4),
+	IEEE80211_CHANCTX_CHANGE_AP		= BIT(5),
 };
 
 /**
  * struct ieee80211_chan_req - A channel "request"
  * @oper: channel definition to use for operation
+ * @ap: the channel definition of the AP, if any
+ *	(otherwise the chan member is %NULL)
  */
 struct ieee80211_chan_req {
 	struct cfg80211_chan_def oper;
+	struct cfg80211_chan_def ap;
 };
 
 /**
@@ -239,6 +245,8 @@ struct ieee80211_chan_req {
  *
  * @def: the channel definition
  * @min_def: the minimum channel definition currently required.
+ * @ap: the channel definition the AP actually is operating as,
+ *	for use with (wider bandwidth) OFDMA
  * @rx_chains_static: The number of RX chains that must always be
  *	active on the channel to receive MIMO transmissions
  * @rx_chains_dynamic: The number of RX chains that must be enabled
@@ -251,6 +259,7 @@ struct ieee80211_chan_req {
 struct ieee80211_chanctx_conf {
 	struct cfg80211_chan_def def;
 	struct cfg80211_chan_def min_def;
+	struct cfg80211_chan_def ap;
 
 	u8 rx_chains_static, rx_chains_dynamic;
 
@@ -1777,6 +1786,10 @@ struct ieee80211_channel_switch {
  *	this is not pure P2P vif.
  * @IEEE80211_VIF_EML_ACTIVE: The driver indicates that EML operation is
  *      enabled for the interface.
+ * @IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW: Ignore wider bandwidth OFDMA
+ *	operation on this interface and request a channel context without
+ *	the AP definition. Use this e.g. because the device is able to
+ *	handle OFDMA (downlink and trigger for uplink) on a per-AP basis.
  */
 enum ieee80211_vif_flags {
 	IEEE80211_VIF_BEACON_FILTER		= BIT(0),
@@ -1784,6 +1797,7 @@ enum ieee80211_vif_flags {
 	IEEE80211_VIF_SUPPORTS_UAPSD		= BIT(2),
 	IEEE80211_VIF_GET_NOA_UPDATE		= BIT(3),
 	IEEE80211_VIF_EML_ACTIVE	        = BIT(4),
+	IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW	= BIT(5),
 };
 
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 4838fd055694..5ba2db60404f 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -81,22 +81,35 @@ ieee80211_link_get_chanctx(struct ieee80211_link_data *link)
 	return container_of(conf, struct ieee80211_chanctx, conf);
 }
 
+bool ieee80211_chanreq_identical(const struct ieee80211_chan_req *a,
+				 const struct ieee80211_chan_req *b)
+{
+	if (!cfg80211_chandef_identical(&a->oper, &b->oper))
+		return false;
+	if (!a->ap.chan && !b->ap.chan)
+		return true;
+	return cfg80211_chandef_identical(&a->ap, &b->ap);
+}
+
 static const struct ieee80211_chan_req *
 ieee80211_chanreq_compatible(const struct ieee80211_chan_req *a,
-			     const struct ieee80211_chan_req *b)
+			     const struct ieee80211_chan_req *b,
+			     struct ieee80211_chan_req *tmp)
 {
 	const struct cfg80211_chan_def *compat;
 
+	if (a->ap.chan && b->ap.chan &&
+	    !cfg80211_chandef_identical(&a->ap, &b->ap))
+		return NULL;
+
 	compat = cfg80211_chandef_compatible(&a->oper, &b->oper);
+	if (!compat)
+		return NULL;
 
-	if (compat == &a->oper)
-		return a;
-
-	if (compat == &b->oper)
-		return b;
-
-	WARN_ON(compat);
-	return NULL;
+	/* Note: later code assumes this always fills & returns tmp if compat */
+	tmp->oper = *compat;
+	tmp->ap = a->ap.chan ? a->ap : b->ap;
+	return tmp;
 }
 
 static const struct ieee80211_chan_req *
@@ -104,11 +117,19 @@ ieee80211_chanctx_compatible(struct ieee80211_chanctx *ctx,
 			     const struct ieee80211_chan_req *req,
 			     struct ieee80211_chan_req *tmp)
 {
+	const struct ieee80211_chan_req *ret;
+	struct ieee80211_chan_req tmp2;
+
 	*tmp = (struct ieee80211_chan_req){
 		.oper = ctx->conf.def,
+		.ap = ctx->conf.ap,
 	};
 
-	return ieee80211_chanreq_compatible(tmp, req);
+	ret = ieee80211_chanreq_compatible(tmp, req, &tmp2);
+	if (!ret)
+		return NULL;
+	*tmp = *ret;
+	return tmp;
 }
 
 static const struct ieee80211_chan_req *
@@ -117,6 +138,7 @@ ieee80211_chanctx_reserved_chanreq(struct ieee80211_local *local,
 				   const struct ieee80211_chan_req *req)
 {
 	struct ieee80211_link_data *link;
+	struct ieee80211_chan_req tmp;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -124,7 +146,7 @@ ieee80211_chanctx_reserved_chanreq(struct ieee80211_local *local,
 		return NULL;
 
 	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list) {
-		req = ieee80211_chanreq_compatible(&link->reserved, req);
+		req = ieee80211_chanreq_compatible(&link->reserved, req, &tmp);
 		if (!req)
 			break;
 	}
@@ -135,7 +157,8 @@ ieee80211_chanctx_reserved_chanreq(struct ieee80211_local *local,
 static const struct ieee80211_chan_req *
 ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx,
-				       const struct ieee80211_chan_req *compat)
+				       const struct ieee80211_chan_req *compat,
+				       struct ieee80211_chan_req *tmp)
 {
 	struct ieee80211_link_data *link;
 	const struct ieee80211_chan_req *comp_def = compat;
@@ -149,7 +172,7 @@ ieee80211_chanctx_non_reserved_chandef(struct ieee80211_local *local,
 			continue;
 
 		comp_def = ieee80211_chanreq_compatible(&link_conf->chanreq,
-							comp_def);
+							comp_def, tmp);
 		if (!comp_def)
 			break;
 	}
@@ -162,12 +185,14 @@ ieee80211_chanctx_can_reserve(struct ieee80211_local *local,
 			      struct ieee80211_chanctx *ctx,
 			      const struct ieee80211_chan_req *req)
 {
+	struct ieee80211_chan_req tmp;
+
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!ieee80211_chanctx_reserved_chanreq(local, ctx, req))
 		return false;
 
-	if (!ieee80211_chanctx_non_reserved_chandef(local, ctx, req))
+	if (!ieee80211_chanctx_non_reserved_chandef(local, ctx, req, &tmp))
 		return false;
 
 	if (!list_empty(&ctx->reserved_links) &&
@@ -456,7 +481,11 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 				      struct ieee80211_link_data *rsvd_for)
 {
 	const struct cfg80211_chan_def *chandef = &chanreq->oper;
-	u32 changed;
+	struct ieee80211_chan_req ctx_req = {
+		.oper = ctx->conf.def,
+		.ap = ctx->conf.ap,
+	};
+	u32 changed = 0;
 
 	/* expected to handle only 20/40/80/160/320 channel widths */
 	switch (chandef->width) {
@@ -478,21 +507,26 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	 */
 	ieee80211_chan_bw_change(local, old_ctx, true);
 
-	if (cfg80211_chandef_identical(&ctx->conf.def, chandef)) {
+	if (ieee80211_chanreq_identical(&ctx_req, chanreq)) {
 		ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
 		return;
 	}
 
-	WARN_ON(!cfg80211_chandef_compatible(&ctx->conf.def, chandef));
+	WARN_ON(!cfg80211_chandef_compatible(&ctx->conf.def, &chanreq->oper));
 
+	if (!cfg80211_chandef_identical(&ctx->conf.def, &chanreq->oper))
+		changed |= IEEE80211_CHANCTX_CHANGE_WIDTH;
+	if (!cfg80211_chandef_identical(&ctx->conf.ap, &chanreq->ap))
+		changed |= IEEE80211_CHANCTX_CHANGE_AP;
 	ctx->conf.def = *chandef;
+	ctx->conf.ap = chanreq->ap;
 
 	/* check if min chanctx also changed */
-	changed = IEEE80211_CHANCTX_CHANGE_WIDTH |
-		  _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
+	changed |= _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
+
 	drv_change_chanctx(local, ctx, changed);
 
-	/* check is BW wider */
+	/* check if BW is wider */
 	ieee80211_chan_bw_change(local, old_ctx, false);
 }
 
@@ -591,6 +625,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	INIT_LIST_HEAD(&ctx->assigned_links);
 	INIT_LIST_HEAD(&ctx->reserved_links);
 	ctx->conf.def = chanreq->oper;
+	ctx->conf.ap = chanreq->ap;
 	ctx->conf.rx_chains_static = 1;
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
@@ -672,9 +707,9 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 				       struct ieee80211_chanctx *ctx)
 {
 	struct ieee80211_chanctx_conf *conf = &ctx->conf;
-	const struct cfg80211_chan_def *compat = NULL;
+	const struct ieee80211_chan_req *compat = NULL;
 	struct ieee80211_link_data *link;
-	struct ieee80211_chan_req chanreq = {};
+	struct ieee80211_chan_req tmp;
 	struct sta_info *sta;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -691,10 +726,10 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 			continue;
 
 		if (!compat)
-			compat = &link_conf->chanreq.oper;
+			compat = &link_conf->chanreq;
 
-		compat = cfg80211_chandef_compatible(&link_conf->chanreq.oper,
-						     compat);
+		compat = ieee80211_chanreq_compatible(&link_conf->chanreq,
+						      compat, &tmp);
 		if (WARN_ON_ONCE(!compat))
 			return;
 	}
@@ -704,14 +739,18 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 
 	/* TDLS peers can sometimes affect the chandef width */
 	list_for_each_entry(sta, &local->sta_list, list) {
+		struct ieee80211_chan_req tdls_chanreq = {};
 		if (!sta->uploaded ||
 		    !test_sta_flag(sta, WLAN_STA_TDLS_WIDER_BW) ||
 		    !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
 		    !sta->tdls_chandef.chan)
 			continue;
 
-		compat = cfg80211_chandef_compatible(&sta->tdls_chandef,
-						     compat);
+		tdls_chanreq.oper = sta->tdls_chandef;
+
+		/* note this always fills and returns &tmp if compat */
+		compat = ieee80211_chanreq_compatible(&tdls_chanreq,
+						      compat, &tmp);
 		if (WARN_ON_ONCE(!compat))
 			return;
 	}
@@ -719,9 +758,7 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 	if (!compat)
 		return;
 
-	chanreq.oper = *compat;
-
-	ieee80211_change_chanctx(local, ctx, ctx, &chanreq);
+	ieee80211_change_chanctx(local, ctx, ctx, compat);
 }
 
 static void ieee80211_recalc_radar_chanctx(struct ieee80211_local *local,
@@ -1122,6 +1159,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	struct ieee80211_vif_chanctx_switch vif_chsw[1] = {};
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 	const struct ieee80211_chan_req *chanreq;
+	struct ieee80211_chan_req tmp;
 	u64 changed = 0;
 	int err;
 
@@ -1144,7 +1182,8 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 		return -EINVAL;
 
 	chanreq = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
-							 &link->reserved);
+							 &link->reserved,
+							 &tmp);
 	if (WARN_ON(!chanreq))
 		return -EINVAL;
 
@@ -1202,6 +1241,7 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *old_ctx, *new_ctx;
 	const struct ieee80211_chan_req *chanreq;
+	struct ieee80211_chan_req tmp;
 	int err;
 
 	old_ctx = ieee80211_link_get_chanctx(link);
@@ -1221,7 +1261,8 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 		return -EINVAL;
 
 	chanreq = ieee80211_chanctx_non_reserved_chandef(local, new_ctx,
-							 &link->reserved);
+							 &link->reserved,
+							 &tmp);
 	if (WARN_ON(!chanreq))
 		return -EINVAL;
 
@@ -1759,6 +1800,45 @@ int ieee80211_link_use_reserved_context(struct ieee80211_link_data *link)
 	return 0;
 }
 
+/*
+ * This is similar to ieee80211_chanctx_compatible(), but rechecks
+ * against all the links actually using it (except the one that's
+ * passed, since that one is changing).
+ * This is done in order to allow changes to the AP's bandwidth for
+ * wider bandwidth OFDMA purposes, which wouldn't be treated as
+ * compatible by ieee80211_chanctx_recheck() but is OK if the link
+ * requesting the update is the only one using it.
+ */
+static const struct ieee80211_chan_req *
+ieee80211_chanctx_recheck(struct ieee80211_local *local,
+			  struct ieee80211_link_data *link,
+			  struct ieee80211_chanctx *ctx,
+			  const struct ieee80211_chan_req *req,
+			  struct ieee80211_chan_req *tmp)
+{
+	const struct ieee80211_chan_req *ret = req;
+	struct ieee80211_link_data *iter_link;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	for_each_sdata_link(local, iter_link) {
+		if (iter_link == link)
+			continue;
+
+		if (rcu_access_pointer(link->conf->chanctx_conf) != &ctx->conf)
+			continue;
+
+		ret = ieee80211_chanreq_compatible(ret, &link->conf->chanreq,
+						   tmp);
+	}
+
+	if (!ret)
+		return NULL;
+
+	*tmp = *ret;
+	return tmp;
+}
+
 int ieee80211_link_change_chanreq(struct ieee80211_link_data *link,
 				  const struct ieee80211_chan_req *chanreq,
 				  u64 *changed)
@@ -1795,7 +1875,7 @@ int ieee80211_link_change_chanreq(struct ieee80211_link_data *link,
 
 	ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
-	compat = ieee80211_chanctx_compatible(ctx, chanreq, &tmp);
+	compat = ieee80211_chanctx_recheck(local, link, ctx, chanreq, &tmp);
 	if (!compat)
 		return -EINVAL;
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9632c4398860..b97b64ef958c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2526,6 +2526,19 @@ bool ieee80211_chandef_s1g_oper(const struct ieee80211_s1g_oper_ie *oper,
 				struct cfg80211_chan_def *chandef);
 void ieee80211_chandef_downgrade(struct cfg80211_chan_def *chandef,
 				 struct ieee80211_conn_settings *conn);
+static inline void
+ieee80211_chanreq_downgrade(struct ieee80211_chan_req *chanreq,
+			    struct ieee80211_conn_settings *conn)
+{
+	ieee80211_chandef_downgrade(&chanreq->oper, conn);
+	if (WARN_ON(!conn))
+		return;
+	if (conn->mode < IEEE80211_CONN_MODE_EHT)
+		chanreq->ap.chan = NULL;
+}
+
+bool ieee80211_chanreq_identical(const struct ieee80211_chan_req *a,
+				 const struct ieee80211_chan_req *b);
 
 int __must_check
 ieee80211_link_use_channel(struct ieee80211_link_data *link,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 27c43e97ab62..5b21168e878a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -687,7 +687,7 @@ static struct ieee802_11_elems *
 ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_conn_settings *conn,
 			      struct cfg80211_bss *cbss, int link_id,
-			      struct cfg80211_chan_def *chandef)
+			      struct ieee80211_chan_req *chanreq)
 {
 	const struct cfg80211_bss_ies *ies = rcu_dereference(cbss->ies);
 	struct ieee80211_bss *bss = (void *)cbss->priv;
@@ -774,25 +774,31 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	}
 
 	conn->mode = ap_mode;
-	*chandef = ap_chandef;
+	chanreq->oper = ap_chandef;
 
-	while (!cfg80211_chandef_usable(sdata->local->hw.wiphy, chandef,
+	/* wider-bandwidth OFDMA is only done in EHT */
+	if (conn->mode >= IEEE80211_CONN_MODE_EHT)
+		chanreq->ap = ap_chandef;
+	else
+		chanreq->ap.chan = NULL;
+
+	while (!cfg80211_chandef_usable(sdata->local->hw.wiphy, &chanreq->oper,
 					IEEE80211_CHAN_DISABLED)) {
-		if (WARN_ON(chandef->width == NL80211_CHAN_WIDTH_20_NOHT)) {
+		if (WARN_ON(chanreq->oper.width == NL80211_CHAN_WIDTH_20_NOHT)) {
 			ret = -EINVAL;
 			goto free;
 		}
 
-		ieee80211_chandef_downgrade(chandef, conn);
+		ieee80211_chanreq_downgrade(chanreq, conn);
 	}
 
 	if (conn->mode >= IEEE80211_CONN_MODE_HE &&
-	    !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
+	    !cfg80211_chandef_usable(sdata->wdev.wiphy, &chanreq->oper,
 				     IEEE80211_CHAN_NO_HE))
 		conn->mode = IEEE80211_CONN_MODE_VHT;
 
 	if (conn->mode >= IEEE80211_CONN_MODE_EHT &&
-	    !cfg80211_chandef_usable(sdata->wdev.wiphy, chandef,
+	    !cfg80211_chandef_usable(sdata->wdev.wiphy, &chanreq->oper,
 				     IEEE80211_CHAN_NO_EHT)) {
 		conn->mode = IEEE80211_CONN_MODE_HE;
 		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
@@ -800,7 +806,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 				       IEEE80211_CONN_BW_LIMIT_160);
 	}
 
-	if (chandef->width != ap_chandef.width || ap_mode != conn->mode)
+	if (chanreq->oper.width != ap_chandef.width || ap_mode != conn->mode)
 		sdata_info(sdata,
 			   "regulatory prevented using AP config, downgraded\n");
 
@@ -863,7 +869,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			 ieee80211_conn_mode_str(conn->mode),
 			 20 * (1 << conn->bw_limit));
 
-	if (WARN_ON_ONCE(!cfg80211_chandef_valid(chandef))) {
+	if (WARN_ON_ONCE(!cfg80211_chandef_valid(&chanreq->oper))) {
 		ret = -EINVAL;
 		goto free;
 	}
@@ -903,7 +909,6 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chan_req chanreq = {};
-	struct cfg80211_chan_def ap_chandef;
 	enum ieee80211_conn_mode ap_mode;
 	u32 vht_cap_info = 0;
 	u16 ht_opmode;
@@ -918,7 +923,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 
 	ap_mode = ieee80211_determine_ap_chan(sdata, channel, vht_cap_info,
 					      elems, true, &link->u.mgd.conn,
-					      &ap_chandef);
+					      &chanreq.ap);
 
 	/* W/A for some tests, make that == again? */
 	if (ap_mode > link->u.mgd.conn.mode) {
@@ -929,6 +934,10 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		return -EINVAL;
 	}
 
+	chanreq.oper = chanreq.ap;
+	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT)
+		chanreq.ap.chan = NULL;
+
 	/*
 	 * if HT operation mode changed store the new one -
 	 * this may be applicable even if channel is identical
@@ -949,25 +958,25 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	 * won't do us any good -- we couldn't use it with the AP.
 	 */
 	while (link->u.mgd.conn.bw_limit <
-			ieee80211_min_bw_limit_from_chandef(&ap_chandef))
-		ieee80211_chandef_downgrade(&ap_chandef, NULL);
+			ieee80211_min_bw_limit_from_chandef(&chanreq.oper))
+		ieee80211_chandef_downgrade(&chanreq.oper, NULL);
 
-	if (cfg80211_chandef_identical(&ap_chandef, &link->conf->chanreq.oper))
+	if (ieee80211_chanreq_identical(&chanreq, &link->conf->chanreq))
 		return 0;
 
 	/* W/A for some tests - remove it again? */
-	if (ap_chandef.width == NL80211_CHAN_WIDTH_20_NOHT &&
+	if (chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT &&
 	    link->u.mgd.conn.mode > IEEE80211_CONN_MODE_LEGACY)
-		ap_chandef.width = NL80211_CHAN_WIDTH_20;
+		chanreq.oper.width = NL80211_CHAN_WIDTH_20;
 
 	link_info(link,
-		  "AP %pM changed bandwidth, new config is %d.%03d MHz, width %d (%d.%03d/%d MHz)\n",
-		  link->u.mgd.bssid, ap_chandef.chan->center_freq,
-		  ap_chandef.chan->freq_offset, ap_chandef.width,
-		  ap_chandef.center_freq1, ap_chandef.freq1_offset,
-		  ap_chandef.center_freq2);
+		  "AP %pM changed bandwidth, new used config is %d.%03d MHz, width %d (%d.%03d/%d MHz)\n",
+		  link->u.mgd.bssid, chanreq.oper.chan->center_freq,
+		  chanreq.oper.chan->freq_offset, chanreq.oper.width,
+		  chanreq.oper.center_freq1, chanreq.oper.freq1_offset,
+		  chanreq.oper.center_freq2);
 
-	if (!cfg80211_chandef_valid(&ap_chandef)) {
+	if (!cfg80211_chandef_valid(&chanreq.oper)) {
 		sdata_info(sdata,
 			   "AP %pM changed caps/bw in a way we can't support - disconnect\n",
 			   link->u.mgd.bssid);
@@ -990,7 +999,6 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	 * bandwidth changes where a this could happen, but those cases are
 	 * less common and wouldn't completely prevent using the AP.
 	 */
-	chanreq.oper = ap_chandef;
 
 	ret = ieee80211_link_change_chanreq(link, &chanreq, changed);
 	if (ret) {
@@ -2104,8 +2112,8 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 		return;
 	}
 
-	if (!cfg80211_chandef_identical(&link->conf->chanreq.oper,
-					&link->csa_chanreq.oper)) {
+	if (!ieee80211_chanreq_identical(&link->conf->chanreq,
+					 &link->csa_chanreq)) {
 		sdata_info(sdata,
 			   "failed to finalize channel switch, disconnecting\n");
 		wiphy_work_queue(sdata->local->hw.wiphy,
@@ -5115,7 +5123,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	rcu_read_lock();
 	elems = ieee80211_determine_chan_mode(sdata, conn, cbss, link_id,
-					      &chanreq.oper);
+					      &chanreq);
 
 	if (IS_ERR(elems)) {
 		rcu_read_unlock();
@@ -5180,7 +5188,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		return ret;
 
 	while (ret && chanreq.oper.width != NL80211_CHAN_WIDTH_20_NOHT) {
-		ieee80211_chandef_downgrade(&chanreq.oper, conn);
+		ieee80211_chanreq_downgrade(&chanreq, conn);
 
 		ret = ieee80211_link_use_channel(link, &chanreq,
 						 IEEE80211_CHANCTX_SHARED);
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index f8b29a1f84c3..9e91ba6a7937 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -50,7 +50,7 @@
 			__entry->center_freq1 = (c) ? (c)->center_freq1 : 0;		\
 			__entry->freq1_offset = (c) ? (c)->freq1_offset : 0;		\
 			__entry->center_freq2 = (c) ? (c)->center_freq2 : 0;
-#define CHANDEF_PR_FMT	" control:%d.%03d MHz width:%d center: %d.%03d/%d MHz"
+#define CHANDEF_PR_FMT	" chandef(%d.%03d MHz,width:%d,center: %d.%03d/%d MHz)"
 #define CHANDEF_PR_ARG	__entry->control_freq, __entry->freq_offset, __entry->chan_width, \
 			__entry->center_freq1, __entry->freq1_offset, __entry->center_freq2
 
@@ -69,22 +69,45 @@
 			__entry->min_center_freq1 = (c)->center_freq1;			\
 			__entry->min_freq1_offset = (c)->freq1_offset;			\
 			__entry->min_center_freq2 = (c)->center_freq2;
-#define MIN_CHANDEF_PR_FMT	" min_control:%d.%03d MHz min_width:%d min_center: %d.%03d/%d MHz"
+#define MIN_CHANDEF_PR_FMT	" mindef(%d.%03d MHz,width:%d,center: %d.%03d/%d MHz)"
 #define MIN_CHANDEF_PR_ARG	__entry->min_control_freq, __entry->min_freq_offset,	\
 			__entry->min_chan_width,					\
 			__entry->min_center_freq1, __entry->min_freq1_offset,		\
 			__entry->min_center_freq2
 
+#define AP_CHANDEF_ENTRY								\
+			__field(u32, ap_control_freq)					\
+			__field(u32, ap_freq_offset)					\
+			__field(u32, ap_chan_width)					\
+			__field(u32, ap_center_freq1)					\
+			__field(u32, ap_freq1_offset)					\
+			__field(u32, ap_center_freq2)
+
+#define AP_CHANDEF_ASSIGN(c)								\
+			__entry->ap_control_freq = (c)->chan ? (c)->chan->center_freq : 0;\
+			__entry->ap_freq_offset = (c)->chan ? (c)->chan->freq_offset : 0;\
+			__entry->ap_chan_width = (c)->chan ? (c)->width : 0;		\
+			__entry->ap_center_freq1 = (c)->chan ? (c)->center_freq1 : 0;	\
+			__entry->ap_freq1_offset = (c)->chan ? (c)->freq1_offset : 0;	\
+			__entry->ap_center_freq2 = (c)->chan ? (c)->center_freq2 : 0;
+#define AP_CHANDEF_PR_FMT	" ap(%d.%03d MHz,width:%d,center: %d.%03d/%d MHz)"
+#define AP_CHANDEF_PR_ARG	__entry->ap_control_freq, __entry->ap_freq_offset,	\
+			__entry->ap_chan_width,						\
+			__entry->ap_center_freq1, __entry->ap_freq1_offset,		\
+			__entry->ap_center_freq2
+
 #define CHANCTX_ENTRY	CHANDEF_ENTRY							\
 			MIN_CHANDEF_ENTRY						\
+			AP_CHANDEF_ENTRY						\
 			__field(u8, rx_chains_static)					\
 			__field(u8, rx_chains_dynamic)
 #define CHANCTX_ASSIGN	CHANDEF_ASSIGN(&ctx->conf.def)					\
 			MIN_CHANDEF_ASSIGN(&ctx->conf.min_def)				\
+			AP_CHANDEF_ASSIGN(&ctx->conf.ap)				\
 			__entry->rx_chains_static = ctx->conf.rx_chains_static;		\
 			__entry->rx_chains_dynamic = ctx->conf.rx_chains_dynamic
-#define CHANCTX_PR_FMT	CHANDEF_PR_FMT MIN_CHANDEF_PR_FMT " chains:%d/%d"
-#define CHANCTX_PR_ARG	CHANDEF_PR_ARG,	MIN_CHANDEF_PR_ARG,				\
+#define CHANCTX_PR_FMT	CHANDEF_PR_FMT MIN_CHANDEF_PR_FMT AP_CHANDEF_PR_FMT " chains:%d/%d"
+#define CHANCTX_PR_ARG	CHANDEF_PR_ARG,	MIN_CHANDEF_PR_ARG, AP_CHANDEF_PR_ARG,		\
 			__entry->rx_chains_static, __entry->rx_chains_dynamic
 
 #define KEY_ENTRY	__field(u32, cipher)						\
-- 
2.42.0


