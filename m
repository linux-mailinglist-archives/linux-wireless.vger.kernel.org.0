Return-Path: <linux-wireless+bounces-13411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A9498D252
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 13:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A725BB21954
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7F200101;
	Wed,  2 Oct 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ch2xEj+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09CB1E4924
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869522; cv=none; b=ctiir7gkuSyb8OWJcuZCcC3SnwZFtdAdRspTZ00gjUz2EUZIohpJhXF8OqMyX25CbAOa3sNYfIVIbzBUpmkDUkrOE0+MSynpQMTW1Q874v8k/7eFFPn1erwsOP4SBu6Ei90ovVmG2ZKwXov24F9Y+5mYOvd2Rxx8zpjQ0ThzTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869522; c=relaxed/simple;
	bh=aeUM8FvkcJXeh2rEzqfiDIyJPOV315gxg9y2Ll80+6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHV84gvFnWIBElglWH+ucPVDfm7/6nBXV8+pfhzFmMiRAq6c84DsKu8zzgOQuZ8Y5BjV1vaZpqn25aMHCdEvdRjIe97Eubx4MgLf7IR1hF/ppZPODnzwqos4NiUgcmsuq4DHT5+X6WH+Xy/dKjNtIfY1ARMUVFAlvgl4EQr1Ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ch2xEj+g; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wdfuZ/s3Yt6/3Pc5yrFI9iwVpSkMn8jgFUdSBK0EWBY=; b=ch2xEj+gGCScwdl2QNaG5/IE/3
	oSgYB+BYER9Dm5q6lW8KjrAMyc3rvUTrbJNY0ycwrUwo0DM96psOividicyAvIp0SGFRfgCc8t/6o
	viZD3QWchVHo+ioxTyODIl5SmFhC/0JiTW05lVSrCkRGSb3bJp9xOH2ANzhkSo37X0aM=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1svxnC-003vyr-2N;
	Wed, 02 Oct 2024 13:45:18 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 03/11] wifi: mac80211: use vif radio mask to limit chanctx and remain-on-channel
Date: Wed,  2 Oct 2024 13:45:09 +0200
Message-ID: <264dd8d0e80aa8edb3530b6f81b34dd1655a0f12.1727869380.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
References: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
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

