Return-Path: <linux-wireless+bounces-13532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14D8991086
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FFC1F25F74
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E3F1D90A8;
	Fri,  4 Oct 2024 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mL4reFbB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C11D8A04
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073333; cv=none; b=OeJ80MXyvMgQG1Z5jT4PZuAXVA6h2mEw/dcbF6R5gKTu7TnMAZHHg6KmH+UQzryS3fiogCXdOlC+jyvfcEKmdI88WqofY1HInpIMjMv+j5H1hZ4gN+sa1n57iQHt2oduqxQeDOersgvvNTjh7054KEsqyh0mZEcacF8ObPrzVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073333; c=relaxed/simple;
	bh=aeUM8FvkcJXeh2rEzqfiDIyJPOV315gxg9y2Ll80+6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcuwhovyT87IgMiT5pxCC9GImSvbwmb/E5hQRnZs5lcNIKKPP+eiORZvUcKxsyOsgYIeu0WCEX72XeQgc5wc9+jiZo7G2ciMTplStGa3eA/EwCkYPdwCu92ag8BtxOcFiOENGz+zs8YGm0b2d95jQT154FxkBJjKsph7+Rv4yHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mL4reFbB; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wdfuZ/s3Yt6/3Pc5yrFI9iwVpSkMn8jgFUdSBK0EWBY=; b=mL4reFbBTMtADB/KFOrEDGtJpe
	Q9BEzckJ8HcIyU0L74reQGOWHzj/1Bruh+PTAW8bRdKTUtbC9NdlyegEgKtr9ehyI6sCdUQ3b35P3
	YLD+xsKj8e1xbku+GagoUntP9TQ0qRz18lK+PWWkzcJfdT8b8c/0A1aJBG+HNOfhHLr0=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swooM-004jVl-2P;
	Fri, 04 Oct 2024 22:22:02 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v3 03/11] wifi: mac80211: use vif radio mask to limit creating chanctx
Date: Fri,  4 Oct 2024 22:21:53 +0200
Message-ID: <7ca99ea35e60b4cbcbb6e0ea9cb73d5e1134798b.1728063865.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
References: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject frequencies not supported by any radio that the vif is allowed to use.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/chan.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index cca6d14084d2..fbc3b28953a6 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1169,7 +1169,7 @@ ieee80211_replace_chanctx(struct ieee80211_local *local,
 static bool
 ieee80211_find_available_radio(struct ieee80211_local *local,
 			       const struct ieee80211_chan_req *chanreq,
-			       int *radio_idx)
+			       u32 radio_mask, int *radio_idx)
 {
 	struct wiphy *wiphy = local->hw.wiphy;
 	const struct wiphy_radio *radio;
@@ -1180,6 +1180,9 @@ ieee80211_find_available_radio(struct ieee80211_local *local,
 		return true;
 
 	for (i = 0; i < wiphy->n_radio; i++) {
+		if (!(radio_mask & BIT(i)))
+			continue;
+
 		radio = &wiphy->radio[i];
 		if (!cfg80211_radio_chandef_valid(radio, &chanreq->oper))
 			continue;
@@ -1213,7 +1216,9 @@ int ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 	new_ctx = ieee80211_find_reservation_chanctx(local, chanreq, mode);
 	if (!new_ctx) {
 		if (ieee80211_can_create_new_chanctx(local, -1) &&
-		    ieee80211_find_available_radio(local, chanreq, &radio_idx))
+		    ieee80211_find_available_radio(local, chanreq,
+						   sdata->wdev.radio_mask,
+						   &radio_idx))
 			new_ctx = ieee80211_new_chanctx(local, chanreq, mode,
 							false, radio_idx);
 		else
@@ -1883,7 +1888,9 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	/* Note: context is now reserved */
 	if (ctx)
 		reserved = true;
-	else if (!ieee80211_find_available_radio(local, chanreq, &radio_idx))
+	else if (!ieee80211_find_available_radio(local, chanreq,
+						 sdata->wdev.radio_mask,
+						 &radio_idx))
 		ctx = ERR_PTR(-EBUSY);
 	else
 		ctx = ieee80211_new_chanctx(local, chanreq, mode,
-- 
git-series 0.9.1

