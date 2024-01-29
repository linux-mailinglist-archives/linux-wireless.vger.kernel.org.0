Return-Path: <linux-wireless+bounces-2699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF3C8412DE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B22892F2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6DD4205B;
	Mon, 29 Jan 2024 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KYAOVvMP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781742E858
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554657; cv=none; b=W2DSaB0opBzIZsXIWZcS9jheIda7VAzkFf1o2gn15GTO46k2EbKRxxlB/7VZB5JOKcqMHzuxfoCDCyuCbaNnoZcIJkX9RLCqoHMnORDi7aLsDOjxf4AxmLU8Mo1VcCEey8c/ER1SlIkGyjqyoP7u3CesHkNlQKN7Z6mWD4xB4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554657; c=relaxed/simple;
	bh=mAyj1AnNstZWlAxNnE5am/IrIUiVpnWniUBuAWVylsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBrfUxe0VTs12+TiHPJJ0HiBddAsNoz0SloUim+2GcpytP8uYalr6hBWR8W7fqLhZmvF/a2aMfxFrHvLgzFZMV04Soz/1+wgzwSr5qgXujRSARQ58v36jOHjvAuJ57u5iDahirMW7NuE2FVf0J68EU5MkSNJnG6kbqTHH/Y0M3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KYAOVvMP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=gHmm+L/NtYoI6llvdohEa2VSDLteuz/GJ6OK5SJXHro=; t=1706554655; x=1707764255; 
	b=KYAOVvMP9mWQd8Va5Zg4Z0OBFnErlkXG3SyM8AjFkbiGs6rsfleNvn5ZOVFs1/XLTlfN29fJ6yP
	84BTBWN5CVjHxDTY3z7/nGqTB1Y4PlIqc82X4KnEkF3/At87tM1CF7WW/diuUeGdEHS20f7hWvEen
	cP16HXyIUC1t+KOcxFSfLruX80n1/hs2RDOHcNPDG7Q+YY/euc4kpdMq/UamEVzfVS7pTnuxmYiR/
	1+wN8w2BA1Nv8EHvG0kywqnLS+aXU+jpxRS77XZVsOzdWv1juRnZFhRd6kq5AW8/ckp1V+eGcQcsM
	9+bKbaxy8TRgKFjhYpVdJc1Knh4x3r2GVhig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWp2-00000004zqv-0QWR;
	Mon, 29 Jan 2024 19:57:32 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix unsolicited broadcast probe config
Date: Mon, 29 Jan 2024 19:57:30 +0100
Message-ID: <20240129195729.965b0740bf80.I6bc6f5236863f686c17d689be541b1dd2633c417@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's a bug in ieee80211_set_unsol_bcast_probe_resp(), it tries
to return BSS_CHANGED_UNSOL_BCAST_PROBE_RESP (which has the value
1<<31) in an int, which makes it negative and considered an error.
Fix this by passing the changed flags to set separately.

Fixes: 3b1c256eb4ae ("wifi: mac80211: fixes in FILS discovery updates")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 321698012e12..327682995c92 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -987,7 +987,8 @@ static int
 ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 				     struct cfg80211_unsol_bcast_probe_resp *params,
 				     struct ieee80211_link_data *link,
-				     struct ieee80211_bss_conf *link_conf)
+				     struct ieee80211_bss_conf *link_conf,
+				     u64 *changed)
 {
 	struct unsol_bcast_probe_resp_data *new, *old = NULL;
 
@@ -1011,7 +1012,8 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 		RCU_INIT_POINTER(link->u.ap.unsol_bcast_probe_resp, NULL);
 	}
 
-	return BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
+	*changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
+	return 0;
 }
 
 static int ieee80211_set_ftm_responder_params(
@@ -1450,10 +1452,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
 						   &params->unsol_bcast_probe_resp,
-						   link, link_conf);
+						   link, link_conf, &changed);
 	if (err < 0)
 		goto error;
-	changed |= err;
 
 	err = drv_start_ap(sdata->local, sdata, link_conf);
 	if (err) {
@@ -1525,10 +1526,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 
 	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
 						   &params->unsol_bcast_probe_resp,
-						   link, link_conf);
+						   link, link_conf, &changed);
 	if (err < 0)
 		return err;
-	changed |= err;
 
 	if (beacon->he_bss_color_valid &&
 	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
-- 
2.43.0


