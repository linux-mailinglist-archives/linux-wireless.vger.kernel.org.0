Return-Path: <linux-wireless+bounces-8713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D89009FD
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54809B22A3A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4B19D099;
	Fri,  7 Jun 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="iRIJNS3Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8F19A29F
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776358; cv=none; b=KvEqk094y6tw8uiCmSPYnUnutRABMOlIv6QTR7TQqN5gpRfd6/B784kHrkKkMawCfwLf1Kgc9mdCVjHU8EqdJB1kBGIm4VbdKm54HigH3zIxDD4GB4o86KHkX1ToJP2n4FSMOe5DlyJuZx2W1hXECPcwKPNFuMFzb0fB0MSGfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776358; c=relaxed/simple;
	bh=MenvBUuGv6mTNIhnGCZr9/oPuif9HJ/2MYXD2LQhCKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3tLVeiDGuCCXX1Of5TcOcckFC3qtKS/YdaeoMW4rOC9dKdGAWsItoZRp7HJqbVWg9yVVYNqbrZAKoXsdGaVsrYGdHvahhXEYhuRRE2zPyyTmLdXaY7Cvyp4VOHEX8BXeejH5hDVpPWV5DCpNBKmHXzWmB/D99pLEDq0Oxa1g7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=iRIJNS3Q; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=H9Ks4PmBveZAlHQui94XwD5dy02OUcuU876KxxPP2nc=; b=iRIJNS3QwZkPmdPYgtGmXEm69r
	cr+m1qGTvCgU+0w2Gqt1KVkiMdrzJRyv0T21qostaTyLnnl6GxEYMVPFW9StCVQm6bBFFaElgHc5V
	Q1yi66JZtVM+6wA+VMToIVGeIKilgUJcNFazB1AGmgGnFogyf1uj1whE0/fGmZjQKZxY=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFc6B-008xPc-2s;
	Fri, 07 Jun 2024 18:05:51 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v4 8/9] wifi: mac80211: move code in ieee80211_link_reserve_chanctx to a helper
Date: Fri,  7 Jun 2024 18:05:47 +0200
Message-ID: <88eeb600e1f4c2a838317eb22b4ea51747fd0c91.1717776325.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.0af6292ae793f7b9927ab6583791b58daedc9104.1717776325.git-series.nbd@nbd.name>
References: <cover.0af6292ae793f7b9927ab6583791b58daedc9104.1717776325.git-series.nbd@nbd.name>
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
index 0e899c07bc2b..ac49c2c71d2b 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1060,6 +1060,71 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
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
@@ -1067,7 +1132,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_chanctx *new_ctx, *curr_ctx, *ctx;
+	struct ieee80211_chanctx *new_ctx, *curr_ctx;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1077,76 +1142,14 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
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

