Return-Path: <linux-wireless+bounces-28619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E758CC3644D
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300D2624470
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB3314B8E;
	Wed,  5 Nov 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aKtvbjI/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5232E696
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355081; cv=none; b=ApSBZPJ0SPSx/IYWNZFy65OwWvS0sw0lhVw82UG5azQc4eZ+RCZ9+xhFpQI4Gfoees+Z7PVn8O1ZMjLbu487i9widUHES1beCcGI1JQR9nPGwhlcmmqLel/4BosBqzW8or4R5IZ/w8qKq9A+bW+2EqBtWLGfz6aSRsr0JtJ+bEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355081; c=relaxed/simple;
	bh=WtuX84Mt5LU0jWZaU/oNskorJlAPNtdkVzNW8QUKK4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYRfOwJRL/02ySUZ00FZ2saKvlyHECWJW7q+NelpDaLMUbOrOqLLDyldpkL5JZ4Ekr0K69hYvFdaB2qqlj7W5G7JRlX0Wc7qtMe1YdSWqxd4aMEz7inLXW1R4li3WmGuADSXRwQ0Mxfsa7NOWTYPnYXvjPau4OUXjWL/BYL916I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aKtvbjI/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9YQyIq8QIHeGV6gzUsuf/HlPM3L8m1Xru9HEvGF885Q=;
	t=1762355079; x=1763564679; b=aKtvbjI/T1HV8o+JVLVB9dRWWacclurqHE8NrQcbodRfRZ3
	8JoujMIwTE0AR17qV7UYkEsB+gRc+7bMHoNyhUSBZlNFpl3rXQhPLkSkRw4gNdi0lJqXq8bBQuAHN
	b1nAz0/zv8lMcUhPJEApeqNFPsLv+sRZ5bEd2k+4ZZeo+F6PA9NW0Lg3zLSHsASwrExjfBfftR5vF
	e+nCQ6vVxzR4q7/ZUsLAWnmmiTHWbmrXQejdLd/OsPg7lNwGpDkRTYQTKwTg3X6999W/RoMlKKDDe
	RvJC8B5trZmIu6FOzGkX9zluOQMhntk/4NGASvtAwAN8BCluiCHqnpT6cZih2T7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGf3t-0000000FGVb-0VP3;
	Wed, 05 Nov 2025 16:04:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 3/4] wifi: mac80211: simplify ieee80211_recalc_chanctx_min_def() API
Date: Wed,  5 Nov 2025 16:03:44 +0100
Message-ID: <20251105160431.33408844c392.I4f52298861780c17a27cd229609e8a3e29c8d740@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105150431.49595-6-johannes@sipsolutions.net>
References: <20251105150431.49595-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

ieee80211_recalc_chanctx_min_def() is used outside the chandef
code, but then should/is always used with NULL/false for the
two last arguments. Remove them, and create another level of
indirection for use inside the file.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        | 46 ++++++++++++++++++++++----------------
 net/mac80211/he.c          |  6 ++---
 net/mac80211/ieee80211_i.h |  4 +---
 net/mac80211/util.c        |  2 +-
 4 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index b73b5a0f6e60..e4f765d1e879 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -410,10 +410,10 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
  * channel context.
  */
 static u32
-_ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-				  struct ieee80211_chanctx *ctx,
-				  struct ieee80211_link_data *rsvd_for,
-				  bool check_reserved)
+__ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
+				   struct ieee80211_chanctx *ctx,
+				   struct ieee80211_link_data *rsvd_for,
+				   bool check_reserved)
 {
 	enum nl80211_chan_width max_bw;
 	struct cfg80211_chan_def min_def;
@@ -518,13 +518,14 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
  * the max of min required widths of all the interfaces bound to this
  * channel context.
  */
-void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx,
-				      struct ieee80211_link_data *rsvd_for,
-				      bool check_reserved)
+static void
+_ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
+				  struct ieee80211_chanctx *ctx,
+				  struct ieee80211_link_data *rsvd_for,
+				  bool check_reserved)
 {
-	u32 changed = _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for,
-							check_reserved);
+	u32 changed = __ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for,
+							 check_reserved);
 
 	if (!changed)
 		return;
@@ -538,6 +539,12 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	ieee80211_chan_bw_change(local, ctx, false, false);
 }
 
+void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
+				      struct ieee80211_chanctx *ctx)
+{
+	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
+}
+
 static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
 				      struct ieee80211_chanctx *old_ctx,
@@ -572,7 +579,7 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	ieee80211_chan_bw_change(local, old_ctx, false, true);
 
 	if (ieee80211_chanreq_identical(&ctx_req, chanreq)) {
-		ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for, false);
+		_ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for, false);
 		return;
 	}
 
@@ -593,7 +600,8 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	ctx->conf.ap = chanreq->ap;
 
 	/* check if min chanctx also changed */
-	changed |= _ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for, false);
+	changed |= __ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for,
+						      false);
 
 	ieee80211_add_wbrf(local, &ctx->conf.def);
 
@@ -732,7 +740,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->conf.radar_enabled = false;
 	ctx->conf.radio_idx = radio_idx;
 	ctx->radar_detected = false;
-	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
+	__ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
 
 	return ctx;
 }
@@ -925,7 +933,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 
 	if (new_ctx) {
 		/* recalc considering the link we'll use it for now */
-		ieee80211_recalc_chanctx_min_def(local, new_ctx, link, false);
+		_ieee80211_recalc_chanctx_min_def(local, new_ctx, link, false);
 
 		ret = drv_assign_vif_chanctx(local, sdata, link->conf, new_ctx);
 		if (assign_on_failure || !ret) {
@@ -946,12 +954,12 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 		ieee80211_recalc_chanctx_chantype(local, curr_ctx);
 		ieee80211_recalc_smps_chanctx(local, curr_ctx);
 		ieee80211_recalc_radar_chanctx(local, curr_ctx);
-		ieee80211_recalc_chanctx_min_def(local, curr_ctx, NULL, false);
+		ieee80211_recalc_chanctx_min_def(local, curr_ctx);
 	}
 
 	if (new_ctx && ieee80211_chanctx_num_assigned(local, new_ctx) > 0) {
 		ieee80211_recalc_txpower(link, false);
-		ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL, false);
+		ieee80211_recalc_chanctx_min_def(local, new_ctx);
 	}
 
 	if (conf) {
@@ -1414,7 +1422,7 @@ ieee80211_link_use_reserved_reassign(struct ieee80211_link_data *link)
 	if (ieee80211_chanctx_refcount(local, old_ctx) == 0)
 		ieee80211_free_chanctx(local, old_ctx, false);
 
-	ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL, false);
+	ieee80211_recalc_chanctx_min_def(local, new_ctx);
 	ieee80211_recalc_smps_chanctx(local, new_ctx);
 	ieee80211_recalc_radar_chanctx(local, new_ctx);
 
@@ -1709,7 +1717,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 						 true, true);
 		}
 
-		ieee80211_recalc_chanctx_min_def(local, ctx, NULL, true);
+		_ieee80211_recalc_chanctx_min_def(local, ctx, NULL, true);
 	}
 
 	/*
@@ -1781,7 +1789,7 @@ static int ieee80211_vif_use_reserved_switch(struct ieee80211_local *local)
 		ieee80211_recalc_chanctx_chantype(local, ctx);
 		ieee80211_recalc_smps_chanctx(local, ctx);
 		ieee80211_recalc_radar_chanctx(local, ctx);
-		ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
+		ieee80211_recalc_chanctx_min_def(local, ctx);
 
 		for_each_sdata_link(local, link) {
 			if (link->reserved_chanctx != ctx)
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 5792ef77e986..f7b05e59374c 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,7 +3,7 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 - 2024 Intel Corporation
+ * Copyright(c) 2019-2025 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -313,7 +313,7 @@ bool ieee80211_prepare_rx_omi_bw(struct ieee80211_link_sta *pub_link_sta,
 		ieee80211_link_sta_rc_update_omi(link, link_sta);
 	} else {
 		link_sta->rx_omi_bw_rx = bw;
-		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL, false);
+		ieee80211_recalc_chanctx_min_def(local, chanctx);
 	}
 
 	link_sta->rx_omi_bw_staging = bw;
@@ -359,7 +359,7 @@ void ieee80211_finalize_rx_omi_bw(struct ieee80211_link_sta *pub_link_sta)
 		/* channel context in finalize only when narrowing bandwidth */
 		WARN_ON(link_sta->rx_omi_bw_rx < link_sta->rx_omi_bw_staging);
 		link_sta->rx_omi_bw_rx = link_sta->rx_omi_bw_staging;
-		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL, false);
+		ieee80211_recalc_chanctx_min_def(local, chanctx);
 	}
 
 	trace_api_return_void(local);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3381e6d6cfd7..751ac32c2b55 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2768,9 +2768,7 @@ int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 				   struct ieee80211_chanctx *chanctx);
 void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
-				      struct ieee80211_chanctx *ctx,
-				      struct ieee80211_link_data *rsvd_for,
-				      bool check_reserved);
+				      struct ieee80211_chanctx *ctx);
 bool ieee80211_is_radar_required(struct ieee80211_local *local,
 				 struct cfg80211_scan_request *req);
 bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 324d84d11cab..1a128f7aae82 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2347,7 +2347,7 @@ void ieee80211_recalc_min_chandef(struct ieee80211_sub_if_data *sdata,
 
 		chanctx = container_of(chanctx_conf, struct ieee80211_chanctx,
 				       conf);
-		ieee80211_recalc_chanctx_min_def(local, chanctx, NULL, false);
+		ieee80211_recalc_chanctx_min_def(local, chanctx);
 	}
 }
 
-- 
2.51.1


