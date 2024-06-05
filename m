Return-Path: <linux-wireless+bounces-8578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC08FD5F7
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF801C218EC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98619D880;
	Wed,  5 Jun 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="SKcAzGo2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CFF61FFE
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613171; cv=none; b=NNoTWUGyCWF7/l+zd6fOdHup4nmGJ2LZ/32oPDzARTU3rHjHNg4f4I9XQXYvwBezdSWnJLALQ6xi2q1aJ7i8IdfecF1xi9t1qL6iltR6+fTDp8jLcFgnR0U426F6dqUPQsQA2pkRhKrgqCtAe9x6L/0gt6bywaAmTyWrrZ/p/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613171; c=relaxed/simple;
	bh=McF07gt4AhplTEq707os0MqhSpdMbwYAjYrRCK08ThU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR97pl9ea5DqNWRcN7yeKZw7Wni6QYPMnsqABwZ8HzqiLjnTPieMNYrJSMFeNA/JX0bTyw5XNo1gf8xPMAi+1DbHFAlrHqkTmDmV2ucrlx9dCGsd53ZY60HPiua+YW+WvRlD+IfwInp52DzmUtlfpq8M2BoTD4fmM83huEJTKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=SKcAzGo2; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rmZIy0qpabGlPgxqphOmYu7ybMcD+XW/n7nuwdYBhtc=; b=SKcAzGo2BaMq4EK79/5A1Z4GRh
	ioWmnjPgpiEEV00CDhNLWdGZWUWdb/q+dA1IvDWA9wpk7O4iwokQycske3MtQgezW9gKS+ksBC9Ru
	mJ3AUrTD3U16zbAOhe5TJ9xnbFTQTqhDTG/AmomnvyM26QbZ2eufooomsk+od5NNm4b0=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sEvQB-008Gwq-0Q;
	Wed, 05 Jun 2024 20:31:39 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v2 7/7] wifi: mac80211: add wiphy radio assignment and validation
Date: Wed,  5 Jun 2024 20:31:30 +0200
Message-ID: <1c285c1bf3b8ba989641e0913f938c09a8c4135c.1717611760.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
References: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
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
 net/mac80211/chan.c | 70 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index ac49c2c71d2b..257ee3b1100b 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -696,14 +696,15 @@ static struct ieee80211_chanctx *
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
 
@@ -1060,6 +1061,24 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 	return 0;
 }
 
+static bool
+ieee80211_radio_freq_match(const struct wiphy_radio *radio,
+			   const struct ieee80211_chan_req *chanreq)
+{
+	const struct wiphy_radio_freq_range *r;
+	u32 freq;
+	int i;
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
 static struct ieee80211_chanctx *
 ieee80211_replace_chanctx(struct ieee80211_local *local,
 			  const struct ieee80211_chan_req *chanreq,
@@ -1067,6 +1086,8 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 			  struct ieee80211_chanctx *curr_ctx)
 {
 	struct ieee80211_chanctx *new_ctx, *ctx;
+	struct wiphy *wiphy = local->hw.wiphy;
+	const struct wiphy_radio *radio;
 
 	if (!curr_ctx || (curr_ctx->replace_state ==
 			  IEEE80211_CHANCTX_WILL_BE_REPLACED) ||
@@ -1096,6 +1117,12 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 			if (!list_empty(&ctx->reserved_links))
 				continue;
 
+			if (ctx->conf.radio_idx >= 0) {
+					radio = &wiphy->radio[ctx->conf.radio_idx];
+					if (!ieee80211_radio_freq_match(radio, chanreq))
+							continue;
+			}
+
 			curr_ctx = ctx;
 			break;
 		}
@@ -1125,6 +1152,34 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
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
+		if (!ieee80211_radio_freq_match(radio, chanreq))
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
@@ -1133,6 +1188,7 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *new_ctx, *curr_ctx;
+	int radio_idx;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1142,9 +1198,10 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 
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
@@ -1755,6 +1812,7 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	struct ieee80211_chanctx *ctx;
 	u8 radar_detect_width = 0;
 	bool reserved = false;
+	int radio_idx;
 	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1785,9 +1843,11 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
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

