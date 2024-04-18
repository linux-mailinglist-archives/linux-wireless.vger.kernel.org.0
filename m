Return-Path: <linux-wireless+bounces-6518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CFF8A96BA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 11:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6531F21191
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097A15B555;
	Thu, 18 Apr 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UozJv7/A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9647D3F4
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433949; cv=none; b=WE7AL5tLh8X/NySn4fv1QpvXHqGhLUac9Qa0yGP3n532MTnPssl/aOMw1vp117y0/ToFh4BYz0HuibU0fs/CJTK9XraU8Zs3sD6I6ojCP7T+mf61PRZzGAv2WxZUkykeeIpeq146VOSHkgR+noBbg62EM5Y2sBUG2Riqo6GLJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433949; c=relaxed/simple;
	bh=MGqDm7cEQtVMPiIluCZ1f+2BDUCC3L535CNKEMd1HdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCtumsIHws2XXacJfE1csnqslM/qY6sB49pHvmZMcbGRiMVhnZfU2U+YCvDAeCyYIawH5CY5ZwcLUZm+zkTXo7ij7p4z3ZsMgvCQZ7bdjeAJ4KwFKfg2Op7/tgFtTFmq0ini0sxKTFJwiwMARoQkefxPPMH3furYMYLy8VyqdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UozJv7/A; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lVYYvRN8hZ2D3mejaFz5xMJsV70q9KWlkis0OVyKy5Q=;
	t=1713433948; x=1714643548; b=UozJv7/AHVsY2KKr9zQjmfpMRpcDoQgKVbLUMQ42uP5hcQ8
	mNqBeAV+ojrYWFgpMvA7Lo3F2fPWy7j+krI2O3HOxrKAEU8hXvR5nucypxQrea5/mrKG0d7e1b5Ab
	MX07WJq/o6YaFkXoLAvN6cBScsJ9vm+qxCwnLnXn5mgr6/HpcaUtgAM6ZMz97ww3WbH6i6hUFenHu
	8HKOYtXOnJaGjk8ERSmOSA0s0ehL3S05rX86kylni3lCqewcUqV078GENg6BOuITDsp7F9R+hqHtg
	k4LOoEe7awSFt40PaKV7efcpWXQI91WHP5bfsArQQIdw4L1bHWVFYQroKmJdiZ8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxORM-0000000CM0y-47MX;
	Thu, 18 Apr 2024 11:52:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 3/3] wifi: mac80211: keep mac80211 consistent on link activation failure
Date: Thu, 18 Apr 2024 11:52:21 +0200
Message-ID: <20240418115219.1129e89f4b55.I6299678353e50e88b55c99b0bce15c64b52c2804@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418115219.94ea84c8ee1e.I0b247dbc0cd937ae6367bc0fc7e8d156b5d5f9b1@changeid>
References: <20240418115219.94ea84c8ee1e.I0b247dbc0cd937ae6367bc0fc7e8d156b5d5f9b1@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

In the unlikely event that link_use_channel fails while activating a
link, mac80211 would go into a bad state. Unfortunately, we cannot
completely avoid failures from drivers in this case.

However, what we can do is to just continue internally anyway and assume
the driver is going to trigger a recovery flow from its side. Doing that
means that we at least have a consistent state in mac80211 allowing such
a recovery flow to succeed.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        | 35 +++++++++++++++++++++++------------
 net/mac80211/ieee80211_i.h | 12 +++++++++++-
 net/mac80211/link.c        | 21 ++++++++++++++++++---
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 2c338014ded5..dedf11eeb43c 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -688,7 +688,8 @@ static int ieee80211_add_chanctx(struct ieee80211_local *local,
 static struct ieee80211_chanctx *
 ieee80211_new_chanctx(struct ieee80211_local *local,
 		      const struct ieee80211_chan_req *chanreq,
-		      enum ieee80211_chanctx_mode mode)
+		      enum ieee80211_chanctx_mode mode,
+		      bool assign_on_failure)
 {
 	struct ieee80211_chanctx *ctx;
 	int err;
@@ -700,10 +701,12 @@ ieee80211_new_chanctx(struct ieee80211_local *local,
 		return ERR_PTR(-ENOMEM);
 
 	err = ieee80211_add_chanctx(local, ctx);
-	if (err) {
+	if (!assign_on_failure && err) {
 		kfree(ctx);
 		return ERR_PTR(err);
 	}
+	/* We ignored a driver error, see _ieee80211_set_active_links */
+	WARN_ON_ONCE(err && !local->in_reconfig);
 
 	list_add_rcu(&ctx->list, &local->chanctx_list);
 	return ctx;
@@ -809,7 +812,8 @@ static void ieee80211_recalc_radar_chanctx(struct ieee80211_local *local,
 }
 
 static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
-					 struct ieee80211_chanctx *new_ctx)
+					 struct ieee80211_chanctx *new_ctx,
+					 bool assign_on_failure)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
@@ -836,7 +840,11 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 		ieee80211_recalc_chanctx_min_def(local, new_ctx, link);
 
 		ret = drv_assign_vif_chanctx(local, sdata, link->conf, new_ctx);
-		if (!ret) {
+		if (assign_on_failure || !ret) {
+			/* Need to continue, see _ieee80211_set_active_links */
+			WARN_ON_ONCE(ret && !local->in_reconfig);
+			ret = 0;
+
 			/* succeeded, so commit it to the data structures */
 			conf = &new_ctx->conf;
 			list_add(&link->assigned_chanctx_list,
@@ -1046,7 +1054,8 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
 		if (ieee80211_can_create_new_chanctx(local)) {
-			new_ctx = ieee80211_new_chanctx(local, chanreq, mode);
+			new_ctx = ieee80211_new_chanctx(local, chanreq, mode,
+							false);
 			if (IS_ERR(new_ctx))
 				return PTR_ERR(new_ctx);
 		} else {
@@ -1302,7 +1311,7 @@ ieee80211_link_use_reserved_assign(struct ieee80211_link_data *link)
 	list_del(&link->reserved_chanctx_list);
 	link->reserved_chanctx = NULL;
 
-	err = ieee80211_assign_link_chanctx(link, new_ctx);
+	err = ieee80211_assign_link_chanctx(link, new_ctx, false);
 	if (err) {
 		if (ieee80211_chanctx_refcount(local, new_ctx) == 0)
 			ieee80211_free_chanctx(local, new_ctx, false);
@@ -1698,7 +1707,7 @@ void __ieee80211_link_release_channel(struct ieee80211_link_data *link,
 		ieee80211_link_unreserve_chanctx(link);
 	}
 
-	ieee80211_assign_link_chanctx(link, NULL);
+	ieee80211_assign_link_chanctx(link, NULL, false);
 	if (ieee80211_chanctx_refcount(local, ctx) == 0)
 		ieee80211_free_chanctx(local, ctx, skip_idle_recalc);
 
@@ -1709,9 +1718,10 @@ void __ieee80211_link_release_channel(struct ieee80211_link_data *link,
 		ieee80211_vif_use_reserved_switch(local);
 }
 
-int ieee80211_link_use_channel(struct ieee80211_link_data *link,
-			       const struct ieee80211_chan_req *chanreq,
-			       enum ieee80211_chanctx_mode mode)
+int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
+				const struct ieee80211_chan_req *chanreq,
+				enum ieee80211_chanctx_mode mode,
+				bool assign_on_failure)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
@@ -1749,7 +1759,8 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (ctx)
 		reserved = true;
 	else
-		ctx = ieee80211_new_chanctx(local, chanreq, mode);
+		ctx = ieee80211_new_chanctx(local, chanreq, mode,
+					    assign_on_failure);
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
 		goto out;
@@ -1757,7 +1768,7 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	ieee80211_link_update_chanreq(link, chanreq);
 
-	ret = ieee80211_assign_link_chanctx(link, ctx);
+	ret = ieee80211_assign_link_chanctx(link, ctx, assign_on_failure);
 
 	if (reserved) {
 		/* remove reservation */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 81a9c5b7642d..317164219e02 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2553,9 +2553,19 @@ bool ieee80211_chanreq_identical(const struct ieee80211_chan_req *a,
 				 const struct ieee80211_chan_req *b);
 
 int __must_check
+_ieee80211_link_use_channel(struct ieee80211_link_data *link,
+			    const struct ieee80211_chan_req *req,
+			    enum ieee80211_chanctx_mode mode,
+			    bool assign_on_failure);
+
+static inline int __must_check
 ieee80211_link_use_channel(struct ieee80211_link_data *link,
 			   const struct ieee80211_chan_req *req,
-			   enum ieee80211_chanctx_mode mode);
+			   enum ieee80211_chanctx_mode mode)
+{
+	return _ieee80211_link_use_channel(link, req, mode, false);
+}
+
 int __must_check
 ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 			       const struct ieee80211_chan_req *req,
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 43f9672fc7f1..af0321408a97 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -404,9 +404,24 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 
 		link = sdata_dereference(sdata->link[link_id], sdata);
 
-		ret = ieee80211_link_use_channel(link,
-						 &link->conf->chanreq,
-						 IEEE80211_CHANCTX_SHARED);
+		/*
+		 * This call really should not fail. Unfortunately, it appears
+		 * that this may happen occasionally with some drivers. Should
+		 * it happen, we are stuck in a bad place as going backwards is
+		 * not really feasible.
+		 *
+		 * So lets just tell link_use_channel that it must not fail to
+		 * assign the channel context (from mac80211's perspective) and
+		 * assume the driver is going to trigger a recovery flow if it
+		 * had a failure.
+		 * That really is not great nor guaranteed to work. But at least
+		 * the internal mac80211 state remains consistent and there is
+		 * a chance that we can recover.
+		 */
+		ret = _ieee80211_link_use_channel(link,
+						  &link->conf->chanreq,
+						  IEEE80211_CHANCTX_SHARED,
+						  true);
 		WARN_ON_ONCE(ret);
 
 		ieee80211_mgd_set_link_qos_params(link);
-- 
2.44.0


