Return-Path: <linux-wireless+bounces-8871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CF990528F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE211F217A4
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881BE171070;
	Wed, 12 Jun 2024 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N2BG2/lU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D3F170835
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195667; cv=none; b=c/9HQDFVtkhs62FKMrMDW0mFQbZBC70e7j0Z8wArmLURXnoBON5zqxOfdEQ0q0+HWpPz5GoZ/tUVvh7X+MZWvoyaEkY2x4Q2ouXmeVB/3/mQXUQCuGBNxW7HaQ5woQghi7Ov5i96MUkQWmOU/ZmFZfhe3jXxdvsIgFAX9YS7muY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195667; c=relaxed/simple;
	bh=ViPg+b77dY/b7ADHoGyE5QHAzkhi4MrEt//yHLk/xqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9qJKvpHipxl6ARWIcl1a5tiPGvt9pGPJj4+PLJfGJheX353Che4IAGwnq0bAGq/pIAGz+XxBgIL5cqi3RpoZzDUKb+n3HpB3dXj3oK/fw49bkpCztQbjEIJW78/w/XznDNdNYnxesS4DUjipsOw1OeYM6q4Vrw3r25HOJrV7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N2BG2/lU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XqbOh2EGOBkOOEQRUxV6dA7QNGUI8SulRh/n39nQ1Ig=;
	t=1718195666; x=1719405266; b=N2BG2/lUMltj6GHCZoj0cuabQwdB2Q834cy/SgtouenmGl2
	YBU1q1rr8gzD6+F6ULmiSSQJDvrttKvcEwMCLraMtbR18rrMYwkr+0Z4VDaaLhB7v3dVxZ1edxs8q
	+lM23uky5noftG3QTSvj2S5TNYKnqCLX3zs1UYhN0xMG0wV4+8UASNPMASsEcycLqxNPJS5B7wfFg
	M7wdA8vOEYVq4UXs4oiSsrWD0mVgYt2o+UrTsp/F2Mnw8zkAPlEb7PbDJSqHcZ1TVgUKMj7wXGXx4
	IS0CnefYKMwLPLc9V4eXIOjxwK+mc9P2xQIT0pLJCWIb7DnVZxbgcOb1hhl/z5Mg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHNBG-0000000AGkC-462a;
	Wed, 12 Jun 2024 14:34:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 3/4] wifi: mac80211: make ieee80211_chan_bw_change() able to use reserved
Date: Wed, 12 Jun 2024 14:32:05 +0200
Message-ID: <20240612143418.1a08cf83b8cb.Ie567bb272eb25ce487651088f13ad041f549651c@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612123418.37295-6-johannes@sipsolutions.net>
References: <20240612123418.37295-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Make ieee80211_chan_bw_change() able to use the reserved chanreq
(really the chandef part of it) for the calculations, so it can
be used _without_ applying the changes first. Remove the comment
that indicates this is required, since it no longer is. However,
this capability only gets used later.

Also, this is not ideal, we really should not different so much
between reserved and non-reserved usage, to simplify. That's a
further cleanup later though.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index ec16d7676088..a42ab3179d99 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -396,12 +396,9 @@ _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	return IEEE80211_CHANCTX_CHANGE_MIN_WIDTH;
 }
 
-/* calling this function is assuming that station vif is updated to
- * lates changes by calling ieee80211_link_update_chanreq
- */
 static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 				     struct ieee80211_chanctx *ctx,
-				     bool narrowed)
+				     bool reserved, bool narrowed)
 {
 	struct sta_info *sta;
 	struct ieee80211_supported_band *sband =
@@ -418,13 +415,17 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 			continue;
 
 		for (link_id = 0; link_id < ARRAY_SIZE(sta->sdata->link); link_id++) {
-			struct ieee80211_bss_conf *link_conf =
-				rcu_dereference(sdata->vif.link_conf[link_id]);
+			struct ieee80211_link_data *link =
+				rcu_dereference(sdata->link[link_id]);
+			struct ieee80211_bss_conf *link_conf;
+			struct cfg80211_chan_def *new_chandef;
 			struct link_sta_info *link_sta;
 
-			if (!link_conf)
+			if (!link)
 				continue;
 
+			link_conf = link->conf;
+
 			if (rcu_access_pointer(link_conf->chanctx_conf) != &ctx->conf)
 				continue;
 
@@ -432,7 +433,13 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 			if (!link_sta)
 				continue;
 
-			new_sta_bw = ieee80211_sta_cur_vht_bw(link_sta);
+			if (reserved)
+				new_chandef = &link->reserved.oper;
+			else
+				new_chandef = &link_conf->chanreq.oper;
+
+			new_sta_bw = _ieee80211_sta_cur_vht_bw(link_sta,
+							       new_chandef);
 
 			/* nothing change */
 			if (new_sta_bw == link_sta->pub->bandwidth)
@@ -466,12 +473,12 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 		return;
 
 	/* check is BW narrowed */
-	ieee80211_chan_bw_change(local, ctx, true);
+	ieee80211_chan_bw_change(local, ctx, false, true);
 
 	drv_change_chanctx(local, ctx, changed);
 
 	/* check is BW wider */
-	ieee80211_chan_bw_change(local, ctx, false);
+	ieee80211_chan_bw_change(local, ctx, false, false);
 }
 
 static void _ieee80211_change_chanctx(struct ieee80211_local *local,
@@ -505,7 +512,7 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	 * due to maybe not returning from it, e.g in case new context was added
 	 * first time with all parameters up to date.
 	 */
-	ieee80211_chan_bw_change(local, old_ctx, true);
+	ieee80211_chan_bw_change(local, old_ctx, false, true);
 
 	if (ieee80211_chanreq_identical(&ctx_req, chanreq)) {
 		ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for);
@@ -536,7 +543,7 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	drv_change_chanctx(local, ctx, changed);
 
 	/* check if BW is wider */
-	ieee80211_chan_bw_change(local, old_ctx, false);
+	ieee80211_chan_bw_change(local, old_ctx, false, false);
 }
 
 static void ieee80211_change_chanctx(struct ieee80211_local *local,
-- 
2.45.2


