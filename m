Return-Path: <linux-wireless+bounces-9832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F19923C89
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 13:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43641F21CB9
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8415CD60;
	Tue,  2 Jul 2024 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="K+gt4X6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200615B12D
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920172; cv=none; b=C/6IQBj+mXItP/pzzu2XftgNPgKUoMFwRKfKW9inFMTZ6RBrly5yP6nQIbUfV6W6wLgy3g9ox/CHtQk+MtRkBD9H7BeXrcyi++kNy/tzZDE+BqtDFU/Cq5jSALtwzXtHoXQub6xe/xTFGvqRE2mlM1nXWsQQHe6gWaZImBdMc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920172; c=relaxed/simple;
	bh=m5fOfmaL4P5ZvIlvt1E9zjnKlngEhac9MjwaJ6sjtBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTI3zXFA5Ii2IPxZJt0+4Fx6T1lmdGVaIWVaQb/Wmz5Khg3b7Wc//1dcS5h7a8p5V0eD//qSkB9Z6WVugj4PuP7D5DvWWjlIwQ+j+EVfmva5tiKvZLU6VFeljFtKiViNphoEqtaT+2MLKkMGAimfZbB7aRVC581Ch+uvP0Dico4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=K+gt4X6M; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fftS+K84L8nIjshhrNW3mFUzxBeeo1mJn4mMKCfM9i4=; b=K+gt4X6M2624aBOe7cUPINGC0V
	e1Bneilk9UbnH0mDiLn5PvPqb2ikIc16nJCor7zSr/HcVWjeZj5EA8f6mUeyx3S3qxilDV+OStGAI
	r3GaqqHtQjp//jUOU/3WYWi+c7fYG68mPHF6zbgW0WVlp2TxAIil4MPHn4mYi2SO8f/M=;
Received: from p54ae9766.dip0.t-ipconnect.de ([84.174.151.102] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sObns-001lDm-2l;
	Tue, 02 Jul 2024 13:36:08 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v4 09/10] wifi: mac80211: add wiphy radio assignment and validation
Date: Tue,  2 Jul 2024 13:36:04 +0200
Message-ID: <d0ff63d395747536746ed65c35b8e1fd7681cf16.1719919832.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.39da4d3b01ce5545ac85da8cab3179f7c7a351a8.1719919832.git-series.nbd@nbd.name>
References: <cover.39da4d3b01ce5545ac85da8cab3179f7c7a351a8.1719919832.git-series.nbd@nbd.name>
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

