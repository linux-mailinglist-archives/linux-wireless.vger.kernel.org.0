Return-Path: <linux-wireless+bounces-9714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A24491D06D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003B0281D0D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18199446AB;
	Sun, 30 Jun 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="iCOZ7cvp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F173D575
	for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719733867; cv=none; b=k8dNJ+9m/7Dd0lV8xcSdE5saFm4mrYzgIqqcqPo2ROqggD6GxidPhHjmICJYAQcywm45Mv4OvSlVMoPfMwv5DXDsgsN5efARAAv7dnS775quHHLQIcZNaO3hOSkaj2j//mw07yIwmLTef4HfCS0OOm6l661F1pF8SMwpV4zPw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719733867; c=relaxed/simple;
	bh=koAI6te1uKC8LHz/l/QNRkVkIeuV5kGsso6snevHqOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AC41stb4vlRvBYPWr9MRgLirAujiVY5T08EDoCYSp1EBbOIy9IcoBL0uMNZJGxOnSwbC6htgCnnHXTzRYbgzh+5PGAkbWj0Nly0glZLmZP3aCqZ49Y0xXO3NBJqX8kVXVfv6PkU72U+UYeJnd9RUiGfx8K3iI2aNbLrZ30E0vz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=iCOZ7cvp; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=B727tQC93LPex1Gn4KMsOr3W+Dt9dN6PmbRgNBVVoSA=; b=iCOZ7cvpjso2BuzGv1X7ph6XMS
	Nb4AFXurLE8NubTGJPSTkyxOE7TVksIsmMIfij99TMvtIC247NrKIBImA5MidZ53wSXIFNIVX7kPI
	1I+dBFtW87Dni2mGFox8gilBG9d59C1IWpKzXIuNiaKn43WM1qhf5a5K3pwkBj95xoHk=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sNpKq-000sh7-2F;
	Sun, 30 Jun 2024 09:50:56 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v2 08/10] wifi: mac80211: move code in ieee80211_link_reserve_chanctx to a helper
Date: Sun, 30 Jun 2024 09:50:51 +0200
Message-ID: <826bf0cfa75e8ad29a2dd9ca2836554ef07ebccd.1719733819.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
References: <cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduces indentation in preparation for further changes

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/chan.c | 141 ++++++++++++++++++++++-----------------------
 1 file changed, 72 insertions(+), 69 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 12bad02da561..9aa3b9e25228 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1089,6 +1089,71 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 	return 0;
 }
 
+static struct ieee80211_chanctx *
+ieee80211_replace_chanctx(struct ieee80211_local *local,
+			  const struct ieee80211_chan_req *chanreq,
+			  enum ieee80211_chanctx_mode mode,
+			  struct ieee80211_chanctx *curr_ctx)
+{
+	struct ieee80211_chanctx *new_ctx, *ctx;
+
+	if (!curr_ctx || (curr_ctx->replace_state ==
+			  IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
+	    !list_empty(&curr_ctx->reserved_links)) {
+		/*
+		 * Another link already requested this context for a
+		 * reservation. Find another one hoping all links assigned
+		 * to it will also switch soon enough.
+		 *
+		 * TODO: This needs a little more work as some cases
+		 * (more than 2 chanctx capable devices) may fail which could
+		 * otherwise succeed provided some channel context juggling was
+		 * performed.
+		 *
+		 * Consider ctx1..3, link1..6, each ctx has 2 links. link1 and
+		 * link2 from ctx1 request new different chandefs starting 2
+		 * in-place reserations with ctx4 and ctx5 replacing ctx1 and
+		 * ctx2 respectively. Next link5 and link6 from ctx3 reserve
+		 * ctx4. If link3 and link4 remain on ctx2 as they are then this
+		 * fails unless `replace_ctx` from ctx5 is replaced with ctx3.
+		 */
+		list_for_each_entry(ctx, &local->chanctx_list, list) {
+			if (ctx->replace_state !=
+			    IEEE80211_CHANCTX_REPLACE_NONE)
+				continue;
+
+			if (!list_empty(&ctx->reserved_links))
+				continue;
+
+			curr_ctx = ctx;
+			break;
+		}
+	}
+
+	/*
+	 * If that's true then all available contexts already have reservations
+	 * and cannot be used.
+	 */
+	if (!curr_ctx || (curr_ctx->replace_state ==
+			  IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
+	    !list_empty(&curr_ctx->reserved_links))
+		return ERR_PTR(-EBUSY);
+
+	new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode, -1);
+	if (!new_ctx)
+		return ERR_PTR(-ENOMEM);
+
+	new_ctx->replace_ctx = curr_ctx;
+	new_ctx->replace_state = IEEE80211_CHANCTX_REPLACES_OTHER;
+
+	curr_ctx->replace_ctx = new_ctx;
+	curr_ctx->replace_state = IEEE80211_CHANCTX_WILL_BE_REPLACED;
+
+	list_add_rcu(&new_ctx->list, &local->chanctx_list);
+
+	return new_ctx;
+}
+
 int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 				   const struct ieee80211_chan_req *chanreq,
 				   enum ieee80211_chanctx_mode mode,
@@ -1096,7 +1161,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_chanctx *new_ctx, *curr_ctx, *ctx;
+	struct ieee80211_chanctx *new_ctx, *curr_ctx;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1106,76 +1171,14 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
 	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
-		if (ieee80211_can_create_new_chanctx(local, -1)) {
+		if (ieee80211_can_create_new_chanctx(local, -1))
 			new_ctx = ieee80211_new_chanctx(local, chanreq, mode,
 							false);
-			if (IS_ERR(new_ctx))
-				return PTR_ERR(new_ctx);
-		} else {
-			if (!curr_ctx ||
-			    (curr_ctx->replace_state ==
-			     IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
-			    !list_empty(&curr_ctx->reserved_links)) {
-				/*
-				 * Another link already requested this context
-				 * for a reservation. Find another one hoping
-				 * all links assigned to it will also switch
-				 * soon enough.
-				 *
-				 * TODO: This needs a little more work as some
-				 * cases (more than 2 chanctx capable devices)
-				 * may fail which could otherwise succeed
-				 * provided some channel context juggling was
-				 * performed.
-				 *
-				 * Consider ctx1..3, link1..6, each ctx has 2
-				 * links. link1 and link2 from ctx1 request new
-				 * different chandefs starting 2 in-place
-				 * reserations with ctx4 and ctx5 replacing
-				 * ctx1 and ctx2 respectively. Next link5 and
-				 * link6 from ctx3 reserve ctx4. If link3 and
-				 * link4 remain on ctx2 as they are then this
-				 * fails unless `replace_ctx` from ctx5 is
-				 * replaced with ctx3.
-				 */
-				list_for_each_entry(ctx, &local->chanctx_list,
-						    list) {
-					if (ctx->replace_state !=
-					    IEEE80211_CHANCTX_REPLACE_NONE)
-						continue;
-
-					if (!list_empty(&ctx->reserved_links))
-						continue;
-
-					curr_ctx = ctx;
-					break;
-				}
-			}
-
-			/*
-			 * If that's true then all available contexts already
-			 * have reservations and cannot be used.
-			 */
-			if (!curr_ctx ||
-			    (curr_ctx->replace_state ==
-			     IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
-			    !list_empty(&curr_ctx->reserved_links))
-				return -EBUSY;
-
-			new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode, -1);
-			if (!new_ctx)
-				return -ENOMEM;
-
-			new_ctx->replace_ctx = curr_ctx;
-			new_ctx->replace_state =
-					IEEE80211_CHANCTX_REPLACES_OTHER;
-
-			curr_ctx->replace_ctx = new_ctx;
-			curr_ctx->replace_state =
-					IEEE80211_CHANCTX_WILL_BE_REPLACED;
-
-			list_add_rcu(&new_ctx->list, &local->chanctx_list);
-		}
+		else
+			new_ctx = ieee80211_replace_chanctx(local, chanreq,
+							    mode, curr_ctx);
+		if (IS_ERR(new_ctx))
+			return PTR_ERR(new_ctx);
 	}
 
 	list_add(&link->reserved_chanctx_list, &new_ctx->reserved_links);
-- 
git-series 0.9.1

