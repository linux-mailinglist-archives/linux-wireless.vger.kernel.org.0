Return-Path: <linux-wireless+bounces-10109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8190692B245
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2197BB21C70
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AED154434;
	Tue,  9 Jul 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="iFIWzC70"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEE152E0D
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514327; cv=none; b=PQ97ND74aBhRSzKMHEV1YpZwPNvg2UjbJWqQmuCK20q3V9y47bF1GL3XF4EQwx2YieFXcSFXDsk5jfKlfK2O2udb+ZxRwXz2Dgm7YeAOuR0l4e4e4Z2LIlGKQnqOPUUOZKkV5/FDQmn367v8s683IHCYpOS1nnSAjHPp+W5CJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514327; c=relaxed/simple;
	bh=m5fOfmaL4P5ZvIlvt1E9zjnKlngEhac9MjwaJ6sjtBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdixMDnngnR2XvNPVHqZG/YXKR+oesUj8lZFMpagiyr878ILgeeO22p/8rDraQoag/zxN9NpD+a3ZhSZs10HJhSoCqESBHZUvUdPAdBJlImlak5cRNDvBIdV4OhsbfZQrY3zaHtgdNuGev3u29uGD6+S6GQRRq3d/skW1on6LQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=iFIWzC70; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fftS+K84L8nIjshhrNW3mFUzxBeeo1mJn4mMKCfM9i4=; b=iFIWzC703HikBcgnEOL8oM1K/N
	EJWmsCfaCpLGvEJWrP7Y93SSOysC6xshk5mPfbj5JVaXt29xjQ1IweZbEgPHGcoZIGt4fhYOazpJH
	EYyzll8trFbT4WTzx6qsUbqGPWHspWI3mm4Ar35diNCouWHF7qRG5rRYf5dDD7z6VZVw=;
Received: from p54ae937c.dip0.t-ipconnect.de ([84.174.147.124] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sR6N0-004Ln4-0M;
	Tue, 09 Jul 2024 10:38:42 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v5 09/10] wifi: mac80211: add wiphy radio assignment and validation
Date: Tue,  9 Jul 2024 10:38:37 +0200
Message-ID: <1d3e9ba70a30ce18aaff337f0a76d7aeb311bafb.1720514221.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.8f108602e7f90e91332f131cc9fa115a669a2bf4.1720514221.git-series.nbd@nbd.name>
References: <cover.8f108602e7f90e91332f131cc9fa115a669a2bf4.1720514221.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate number of channels and interface combinations per radio.
Assign each channel context to a radio.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/chan.c | 52 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 9aa3b9e25228..e8567723e94d 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -714,14 +714,15 @@ static struct ieee80211_chanctx *
 ieee80211_new_chanctx(struct ieee80211_local *local,
 		      const struct ieee80211_chan_req *chanreq,
 		      enum ieee80211_chanctx_mode mode,
-		      bool assign_on_failure)
+		      bool assign_on_failure,
+		      int radio_idx)
 {
 	struct ieee80211_chanctx *ctx;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	ctx = ieee80211_alloc_chanctx(local, chanreq, mode, -1);
+	ctx = ieee80211_alloc_chanctx(local, chanreq, mode, radio_idx);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -1096,6 +1097,8 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 			  struct ieee80211_chanctx *curr_ctx)
 {
 	struct ieee80211_chanctx *new_ctx, *ctx;
+	struct wiphy *wiphy = local->hw.wiphy;
+	const struct wiphy_radio *radio;
 
 	if (!curr_ctx || (curr_ctx->replace_state ==
 			  IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
@@ -1125,6 +1128,12 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 			if (!list_empty(&ctx->reserved_links))
 				continue;
 
+			if (ctx->conf.radio_idx >= 0) {
+				radio = &wiphy->radio[ctx->conf.radio_idx];
+				if (!cfg80211_radio_chandef_valid(radio, &chanreq->oper))
+					continue;
+			}
+
 			curr_ctx = ctx;
 			break;
 		}
@@ -1154,6 +1163,34 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 	return new_ctx;
 }
 
+static bool
+ieee80211_find_available_radio(struct ieee80211_local *local,
+			       const struct ieee80211_chan_req *chanreq,
+			       int *radio_idx)
+{
+	struct wiphy *wiphy = local->hw.wiphy;
+	const struct wiphy_radio *radio;
+	int i;
+
+	*radio_idx = -1;
+	if (!wiphy->n_radio)
+		return true;
+
+	for (i = 0; i < wiphy->n_radio; i++) {
+		radio = &wiphy->radio[i];
+		if (!cfg80211_radio_chandef_valid(radio, &chanreq->oper))
+			continue;
+
+		if (!ieee80211_can_create_new_chanctx(local, i))
+			continue;
+
+		*radio_idx = i;
+		return true;
+	}
+
+	return false;
+}
+
 int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 				   const struct ieee80211_chan_req *chanreq,
 				   enum ieee80211_chanctx_mode mode,
@@ -1162,6 +1199,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *new_ctx, *curr_ctx;
+	int radio_idx;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1171,9 +1209,10 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
 	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
-		if (ieee80211_can_create_new_chanctx(local, -1))
+		if (ieee80211_can_create_new_chanctx(local, -1) &&
+		    ieee80211_find_available_radio(local, chanreq, &radio_idx))
 			new_ctx = ieee80211_new_chanctx(local, chanreq, mode,
-							false);
+							false, radio_idx);
 		else
 			new_ctx = ieee80211_replace_chanctx(local, chanreq,
 							    mode, curr_ctx);
@@ -1810,6 +1849,7 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	struct ieee80211_chanctx *ctx;
 	u8 radar_detect_width = 0;
 	bool reserved = false;
+	int radio_idx;
 	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1840,9 +1880,11 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	/* Note: context is now reserved */
 	if (ctx)
 		reserved = true;
+	else if (!ieee80211_find_available_radio(local, chanreq, &radio_idx))
+		ctx = ERR_PTR(-EBUSY);
 	else
 		ctx = ieee80211_new_chanctx(local, chanreq, mode,
-					    assign_on_failure);
+					    assign_on_failure, radio_idx);
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
 		goto out;
-- 
git-series 0.9.1

