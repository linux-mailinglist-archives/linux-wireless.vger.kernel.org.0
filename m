Return-Path: <linux-wireless+bounces-32400-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G5xHM/wpmk/agAAu9opvQ
	(envelope-from <linux-wireless+bounces-32400-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:31:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D25231F180B
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5809E310B410
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309F13822B7;
	Tue,  3 Mar 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f679hJxN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A93D75B6
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548010; cv=none; b=UOwGj2KlZbVzlF+NoDbwNI+Oc+P27IMBK88yNDByRqBGEi+3N5QbeoOJBZB86GpijDXKckU75wK8AthBTn9AfuYUPL4zNtu/dZ2Ew0sOF6kE1t1GxFlc05A95akmq6vUwn9QwyVBDhwBrkyJWIzpmcyIMf6/97niVrl5Wbdq4lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548010; c=relaxed/simple;
	bh=uBeMbXYntjg40kSvw3df1GoXmpJMRmf001pZUz8svrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipVq+JWW8CfKOMbUmyJQSnS8Vx2M4BOTkmVbw8kxpSgMuK0yNt+Rk19BiK/ks6RNnSYEy9d/pLt7D8IsbN06QfX3omB2V8rN+52GwQmmaJWcLy8yuiMsVLoLAB4ZgYTe6h6WDcFVCdi9ohLUcVevw5dSiZF8lXO3rs556RjyXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f679hJxN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i1XykijsYSs/dLmRMsAR/319H0ROXv8A2M9Psij5dWQ=;
	t=1772548008; x=1773757608; b=f679hJxNgzfXClmIWqno3gLlULpLAOoVs2bzmZwORPeEemj
	f1HYlTFh9GsHSToEbjxcAqxJaXNXRfRPk60BiHZA0AzVJT+i6ZSlmYt9GJRpxTDFxuEjcbvae7FPf
	QzGaATeuoDd7uB76ck0tXPHpc+A5oPlIO51d/8vkwbitH66s65oaQI4NjLpgBQF5pUHX6edC+yhWe
	ctMLJDRxyqzsXIjzj3oCEpQwOl2nhspyWsqN9cH7pN+srgGfDmc0iRDzRoXhfZrvIvEsWAVyj0sgT
	1F7uZuf4A1lYYzyMJZDmWwL1aRb7zlu2hsZOa0FJ0xtEYun1eNQdJfFMXmhCtavA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQhx-000000079iZ-226i;
	Tue, 03 Mar 2026 15:26:45 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/3] wifi: mac80211: always use full chanctx compatible check
Date: Tue,  3 Mar 2026 15:26:18 +0100
Message-ID: <20260303152641.1a3ff6ead82b.I486f1a94b9a32e0b045815cbbb22679c8cef56e4@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303142641.273071-5-johannes@sipsolutions.net>
References: <20260303142641.273071-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D25231F180B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-32400-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

For NPCA, we need to treat the channel request differently
for AP and other interfaces (APs can share NPCA, under the
assumption that userspace will set them up with the same
BSS color.) This is difficult if we have to check against
a chanreq made up from the chanctx, but this isn't a code
path that needs to be highly optimised, so just always use
the (originally) recheck functionality to check against
all users of the chanctx.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 90 ++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 51 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 4447cf03c41b..2f0c93f3ace6 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * mac80211 - channel management
- * Copyright 2020 - 2025 Intel Corporation
+ * Copyright 2020-2026 Intel Corporation
  */
 
 #include <linux/nl80211.h>
@@ -239,24 +239,45 @@ ieee80211_chanreq_compatible(const struct ieee80211_chan_req *a,
 	return tmp;
 }
 
+/*
+ * When checking for compatible, check against all the links using
+ * the chanctx (except the one passed that might be changing) to
+ * allow changes to the AP's bandwidth for wider bandwidth OFDMA
+ * purposes, which wouldn't be treated as compatible by checking
+ * against the chanctx's oper/ap chandefs.
+ */
 static const struct ieee80211_chan_req *
-ieee80211_chanctx_compatible(struct ieee80211_chanctx *ctx,
+_ieee80211_chanctx_compatible(struct ieee80211_local *local,
+			      struct ieee80211_link_data *skip_link,
+			      struct ieee80211_chanctx *ctx,
+			      const struct ieee80211_chan_req *req,
+			      struct ieee80211_chan_req *tmp)
+{
+	const struct ieee80211_chan_req *ret = req;
+	struct ieee80211_chanctx_user_iter iter;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	for_each_chanctx_user_all(local, ctx, &iter) {
+		if (iter.link && iter.link == skip_link)
+			continue;
+
+		ret = ieee80211_chanreq_compatible(ret, iter.chanreq, tmp);
+		if (!ret)
+			return NULL;
+	}
+
+	*tmp = *ret;
+	return tmp;
+}
+
+static const struct ieee80211_chan_req *
+ieee80211_chanctx_compatible(struct ieee80211_local *local,
+			     struct ieee80211_chanctx *ctx,
 			     const struct ieee80211_chan_req *req,
 			     struct ieee80211_chan_req *tmp)
 {
-	const struct ieee80211_chan_req *ret;
-	struct ieee80211_chan_req tmp2;
-
-	*tmp = (struct ieee80211_chan_req){
-		.oper = ctx->conf.def,
-		.ap = ctx->conf.ap,
-	};
-
-	ret = ieee80211_chanreq_compatible(tmp, req, &tmp2);
-	if (!ret)
-		return NULL;
-	*tmp = *ret;
-	return tmp;
+	return _ieee80211_chanctx_compatible(local, NULL, ctx, req, tmp);
 }
 
 static const struct ieee80211_chan_req *
@@ -756,7 +777,8 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 		if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE)
 			continue;
 
-		compat = ieee80211_chanctx_compatible(ctx, chanreq, &tmp);
+		compat = ieee80211_chanctx_compatible(local, ctx, chanreq,
+						      &tmp);
 		if (!compat)
 			continue;
 
@@ -2128,40 +2150,6 @@ int ieee80211_link_use_reserved_context(struct ieee80211_link_data *link)
 	return 0;
 }
 
-/*
- * This is similar to ieee80211_chanctx_compatible(), but rechecks
- * against all the links actually using it (except the one that's
- * passed, since that one is changing).
- * This is done in order to allow changes to the AP's bandwidth for
- * wider bandwidth OFDMA purposes, which wouldn't be treated as
- * compatible by ieee80211_chanctx_recheck() but is OK if the link
- * requesting the update is the only one using it.
- */
-static const struct ieee80211_chan_req *
-ieee80211_chanctx_recheck(struct ieee80211_local *local,
-			  struct ieee80211_link_data *skip_link,
-			  struct ieee80211_chanctx *ctx,
-			  const struct ieee80211_chan_req *req,
-			  struct ieee80211_chan_req *tmp)
-{
-	const struct ieee80211_chan_req *ret = req;
-	struct ieee80211_chanctx_user_iter iter;
-
-	lockdep_assert_wiphy(local->hw.wiphy);
-
-	for_each_chanctx_user_all(local, ctx, &iter) {
-		if (iter.link == skip_link)
-			continue;
-
-		ret = ieee80211_chanreq_compatible(ret, iter.chanreq, tmp);
-		if (!ret)
-			return NULL;
-	}
-
-	*tmp = *ret;
-	return tmp;
-}
-
 int ieee80211_link_change_chanreq(struct ieee80211_link_data *link,
 				  const struct ieee80211_chan_req *chanreq,
 				  u64 *changed)
@@ -2198,7 +2186,7 @@ int ieee80211_link_change_chanreq(struct ieee80211_link_data *link,
 
 	ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
-	compat = ieee80211_chanctx_recheck(local, link, ctx, chanreq, &tmp);
+	compat = _ieee80211_chanctx_compatible(local, link, ctx, chanreq, &tmp);
 	if (!compat)
 		return -EINVAL;
 
-- 
2.53.0


