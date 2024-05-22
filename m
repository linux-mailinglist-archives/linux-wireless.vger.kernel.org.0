Return-Path: <linux-wireless+bounces-7957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AF28CC19C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 14:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE1E1F239FF
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119AC82490;
	Wed, 22 May 2024 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="sNhUq1Cl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A617C9
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382388; cv=none; b=jaZCceY5dkDPoCjx52uKnuFltHH091CSR3mpQjFKaVSy2jJGOFp90h+8/d9+vcOBTWhpm8Ku00dUdoVtjo76StZbVQFvICmI6tGAqzR2km6f7KiMejryFdfbqZ0hp24w5+AdHbTqIQG6tFPf9tX1dJb45Hqh2e56XT77/d6WoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382388; c=relaxed/simple;
	bh=PcNmDtLm0OTs6YvEx4KwyVWfaTwG5ZHaD9J+f7c1Zfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO+voxLLV/g+sBOY4f2r1VFKBgJJO6+tyAtfyeCbxcEvfjjwlgVe8s2cX1U+bSQiJ/UZMafrkmVss5RKgM40hl5+K+JRPUy5Av/PQa0dsIdN1V4eTi/NEF37Qu0g1Dn6VnylVgpSfsz+FWA0KOjSmntbXK2HcFP5IAvlrAPonyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=sNhUq1Cl; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=p9pw5faQA5Kr51Ea6kc45S+wq2nFZ3W3C66VdxOftuE=; b=sNhUq1Cl1eYvYjBOPdhUb/ZQVs
	GHJYJrFso+dhwhiEZ6Yk1fVPZ88i/+dH1QiOJG/KxSM2KnBWlq25C1/rDd6WQWuEg7f+50nMHlUuV
	oQXrLEp6Q/RrcH2cLlqdzWx+egmK3dQGUWz83oWBZc5mdFRWyVHDcd6d1ZRu+5xLrQnA=;
Received: from p4ff13644.dip0.t-ipconnect.de ([79.241.54.68] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s9l6c-003Yia-1F;
	Wed, 22 May 2024 14:30:06 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC 2/2] mac80211: ensure that only one channel context is active per radio
Date: Wed, 22 May 2024 14:30:05 +0200
Message-ID: <20240522123005.41026-2-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522123005.41026-1-nbd@nbd.name>
References: <20240522123005.41026-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With multi-radio hardware, we need to ensure that a radio is not assigned to
multiple channels at the same time.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h |  2 +
 net/mac80211/chan.c    | 96 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 2bb24aba84fd..0e9b61726067 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -250,6 +250,7 @@ struct ieee80211_chan_req {
  * @min_def: the minimum channel definition currently required.
  * @ap: the channel definition the AP actually is operating as,
  *	for use with (wider bandwidth) OFDMA
+ * @radio_idx: index of the wiphy radio used used for this channel
  * @rx_chains_static: The number of RX chains that must always be
  *	active on the channel to receive MIMO transmissions
  * @rx_chains_dynamic: The number of RX chains that must be enabled
@@ -264,6 +265,7 @@ struct ieee80211_chanctx_conf {
 	struct cfg80211_chan_def min_def;
 	struct cfg80211_chan_def ap;
 
+	int radio_idx;
 	u8 rx_chains_static, rx_chains_dynamic;
 
 	bool radar_enabled;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 380695fdc32f..589041de99c6 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -60,11 +60,24 @@ static int ieee80211_num_chanctx(struct ieee80211_local *local)
 	return num;
 }
 
-static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local)
+static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local,
+					     int radio_idx)
 {
+	struct ieee80211_chanctx *ctx;
+
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	return ieee80211_num_chanctx(local) < ieee80211_max_num_channels(local);
+	if (ieee80211_num_chanctx(local) >= ieee80211_max_num_channels(local))
+		return false;
+
+	if (radio_idx < 0)
+		return true;
+
+	list_for_each_entry(ctx, &local->chanctx_list, list)
+		if (ctx->conf.radio_idx == radio_idx)
+			return false;
+
+	return true;
 }
 
 static struct ieee80211_chanctx *
@@ -638,7 +651,8 @@ ieee80211_chanctx_radar_required(struct ieee80211_local *local,
 static struct ieee80211_chanctx *
 ieee80211_alloc_chanctx(struct ieee80211_local *local,
 			const struct ieee80211_chan_req *chanreq,
-			enum ieee80211_chanctx_mode mode)
+			enum ieee80211_chanctx_mode mode,
+			int radio_idx)
 {
 	struct ieee80211_chanctx *ctx;
 
@@ -656,6 +670,7 @@ ieee80211_alloc_chanctx(struct ieee80211_local *local,
 	ctx->conf.rx_chains_dynamic = 1;
 	ctx->mode = mode;
 	ctx->conf.radar_enabled = false;
+	ctx->conf.radio_idx = radio_idx;
 	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL);
 
 	return ctx;
@@ -689,14 +704,14 @@ static struct ieee80211_chanctx *
 ieee80211_new_chanctx(struct ieee80211_local *local,
 		      const struct ieee80211_chan_req *chanreq,
 		      enum ieee80211_chanctx_mode mode,
-		      bool assign_on_failure)
+		      bool assign_on_failure, int radio_idx)
 {
 	struct ieee80211_chanctx *ctx;
 	int err;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	ctx = ieee80211_alloc_chanctx(local, chanreq, mode);
+	ctx = ieee80211_alloc_chanctx(local, chanreq, mode, radio_idx);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -1053,6 +1068,51 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 	return 0;
 }
 
+static bool
+ieee80211_get_radio_freq_match(const struct wiphy_radio *radio,
+			       const struct ieee80211_chan_req *chanreq)
+{
+	const struct wiphy_radio_freq_range *r;
+	u32 freq;
+	int i;
+
+	if (!radio->n_freq_range)
+		return true;
+
+	freq = ieee80211_channel_to_khz(chanreq->oper.chan);
+	for (i = 0; i < radio->n_freq_range; i++) {
+		r = &radio->freq_range[i];
+		if (freq >= r->start_freq && freq <= r->end_freq)
+			return true;
+	}
+
+	return false;
+}
+
+static int
+ieee80211_get_chanreq_radio(struct ieee80211_local *local,
+			    const struct ieee80211_chan_req *chanreq)
+{
+	struct wiphy *wiphy = local->hw.wiphy;
+	const struct wiphy_radio *radio;
+	u32 band_mask;
+	int i;
+
+	band_mask = BIT(chanreq->oper.chan->band);
+	for (i = 0; i < wiphy->n_radio; i++) {
+		radio = &wiphy->radio[i];
+		if (!(radio->band_mask & band_mask))
+			continue;
+
+		if (!ieee80211_get_radio_freq_match(radio, chanreq))
+			continue;
+
+		return i;
+	}
+
+	return -1;
+}
+
 int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 				   const struct ieee80211_chan_req *chanreq,
 				   enum ieee80211_chanctx_mode mode,
@@ -1061,6 +1121,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *new_ctx, *curr_ctx, *ctx;
+	int radio_idx;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1070,9 +1131,10 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
 	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
-		if (ieee80211_can_create_new_chanctx(local)) {
+		radio_idx = ieee80211_get_chanreq_radio(local, chanreq);
+		if (ieee80211_can_create_new_chanctx(local, radio_idx)) {
 			new_ctx = ieee80211_new_chanctx(local, chanreq, mode,
-							false);
+							false, radio_idx);
 			if (IS_ERR(new_ctx))
 				return PTR_ERR(new_ctx);
 		} else {
@@ -1111,6 +1173,9 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 					if (!list_empty(&ctx->reserved_links))
 						continue;
 
+					if (ctx->conf.radio_idx != radio_idx)
+						continue;
+
 					curr_ctx = ctx;
 					break;
 				}
@@ -1126,7 +1191,8 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 			    !list_empty(&curr_ctx->reserved_links))
 				return -EBUSY;
 
-			new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode);
+			new_ctx = ieee80211_alloc_chanctx(local, chanreq, mode,
+							  radio_idx);
 			if (!new_ctx)
 				return -ENOMEM;
 
@@ -1745,6 +1811,7 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	struct ieee80211_chanctx *ctx;
 	u8 radar_detect_width = 0;
 	bool reserved = false;
+	int radio_idx;
 	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1773,11 +1840,18 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	ctx = ieee80211_find_chanctx(local, link, chanreq, mode);
 	/* Note: context is now reserved */
-	if (ctx)
+	if (ctx) {
 		reserved = true;
-	else
+	} else {
+		radio_idx = ieee80211_get_chanreq_radio(local, chanreq);
+		if (ieee80211_can_create_new_chanctx(local, radio_idx)) {
+			ret = -EBUSY;
+			goto out;
+		}
+
 		ctx = ieee80211_new_chanctx(local, chanreq, mode,
-					    assign_on_failure);
+					    assign_on_failure, radio_idx);
+	}
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
 		goto out;
-- 
2.44.0


