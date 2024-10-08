Return-Path: <linux-wireless+bounces-13715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4379941FB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B782B259A5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A76199E92;
	Tue,  8 Oct 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="iu1bHZW+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C41C304C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374251; cv=none; b=BK91ZttIFZUmKy9oAkfhCXULodjfb+abPoWM0ZbIbeI4G5raqO6PoreELUlX8vKjxzCKVCdTvCh3VlmwMW+L+LmNjtMMuS3/84bjKmp3k89PFn+dGGtwPBY3Phd8QdZZJ55Ey9V1sNnnTD4j6f79j/roNW838s+6RSXA+mZt5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374251; c=relaxed/simple;
	bh=aeUM8FvkcJXeh2rEzqfiDIyJPOV315gxg9y2Ll80+6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEB6Uza/u/m3LBybYL9/7Z89B7dZ9CLLnY6kV7hIRwq/lJhI/Xk7Om35jcgQV+oapE2B+rMj6Jdh9aHrmkkM+BH6duexyTOa0R1pK4ZyRmKPsfESFYUOPxw2eGUTwJLUpQ2vAdtEmzCFPigTvMARhvDdTLQYXF1jJViNgifv9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=iu1bHZW+; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wdfuZ/s3Yt6/3Pc5yrFI9iwVpSkMn8jgFUdSBK0EWBY=; b=iu1bHZW+iowYosNDSh8jyLLfZu
	Q3wn7kWoLjiGGbQWZSXXw4iIe/plQOdFB3l3QhZZSHwcwtu9fA20WbfZxX5znmnOg6UuDKjS67gzb
	gc5TjqK6TWi0pswCO+G1EhIF9Y4WIjGPnJQx2lcMaWs8OVKOIXzzMUdSDpUDHmYV5qAc=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sy4ZO-006H62-0L;
	Tue, 08 Oct 2024 09:23:46 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v4 03/11] wifi: mac80211: use vif radio mask to limit creating chanctx
Date: Tue,  8 Oct 2024 09:23:36 +0200
Message-ID: <7ca99ea35e60b4cbcbb6e0ea9cb73d5e1134798b.1728372192.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
References: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
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

