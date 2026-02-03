Return-Path: <linux-wireless+bounces-31507-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEOzLVJGgmlHRQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31507-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 20:02:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E25DE073
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 20:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A0CA3160DC3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D13334D4CB;
	Tue,  3 Feb 2026 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEEhUoEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9926B756
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145055; cv=none; b=QaBt8jAefAv3CrEWQ5GysT+uU8iAt9poNussyKcTCRimOFAsorKx0pQNoB7VLcxg+GYuCIvV3/neXZZBHCMB+ziuX1qHL8vd8ruZYfSio130xlTaEW8WnSaXHAfCGRBUk4WwKe+mZ8W9tSsE+vraDAx4+J1dcOljrMmQBAaP8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145055; c=relaxed/simple;
	bh=Ru6IwYp9TYf6IwxXA6fm4FCfKEc9vpq6/Nyd8KVSftU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pcs0Wd91PP8en0mvxBmoD0NRNvbECHEOkvk5XGXoqCLKYaA3WyABX+expGd2TdQWT1hjowx0TOezMNvIdmjgbkdhesZJC12E+GpCdWbBxaXN0qlNsD05jY4aydbNA3fThC1nukHFJ/NATvRYIEwkP3EgiM8XSl036/tg1Xh7QZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEEhUoEz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480706554beso64969765e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 10:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770145052; x=1770749852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ+jnweoDGkeUIToLfriab5tDVmZNAy+555y5fQdc6o=;
        b=QEEhUoEzvXY+Abal4v+SEJ90UmOwlgiaGaKUfgGrRadXCADedd3iTZEZdmylduQWTR
         Dygc8M3TdoY0YNQyChbh61ZqduDltslP8vxI0vqNSWVBf7ndvDvcTEQbFsjPBdWoNgFT
         JeHaeWuyVNJSoqjWES7C0FrMTS8w21IRzmkS6Qocs1ZEyYLi5K8nX/XzOm5W6r90VPBv
         HR3zUhfpYKwhrHcpnFuGnYUmxCjTz/Gc+I0uBJMuSLKiFA5SKIgNKyY7768nBuIIoWTK
         hIf2vHzsedvSV7cU3Jm6AhHLhTwJtF7V8Z3PTHEOlr7EWBh9VpD9jRmZkLWg6vMa990w
         X+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770145052; x=1770749852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQ+jnweoDGkeUIToLfriab5tDVmZNAy+555y5fQdc6o=;
        b=LXZDjcRva2iHO3gTETvzjrSG88QMgIWyj96rva140+r/34n96pUPUnMOobKp8FuaW8
         o7V9KV+7O3H3pQXbvWz9z3/xF191oHVr8ScnN6lkBAYoklJRhS3qou+m4GuiQYiGDOc1
         Bc8mxA8GtvQiQ8wXezWibrZ/NF4U7ksCL6d7YNl9g8DQVIKXGduW30wvDp4Pu29DXaHr
         C3wwY2eEvCp0N90hJLAwF3HozqdmBjELuxkvALKmBqpGZkFqmGV2Ms4J6LPI2945DgOJ
         9GsPOATf/hUPUxsG4iyvHV6URlfkdnVuGkfOUA1DzdVAy+B5+tO9unhFctn524Ytnp6f
         wmPA==
X-Gm-Message-State: AOJu0YwGiWoBnQP0CLSOA9B4l56R8T3khy9Z1PZPo05N+cRZ1D8hHUyq
	ovYHGtVx6U7/XBGmuBrM1JGYoBUo+0O+67AB8pX25/n7k9+oo0MI7GCzapAFWg==
X-Gm-Gg: AZuq6aI6dCCCWtf6npnlRhVCbZen4M1tYSyeok01UQQTO7tVTt/2ZoobYxApAduezT+
	5qNmdAeWNTUFJJQGUZz6K0hwlrD7U8MX5DKnqr+uPFbGkrjn6RXVn9L2/R87Xp5iVy0OH85Cln4
	xt5bsmc/kYGetd2wjcp2PiwSGeLoSqBqbQbHle1eLb3RHtkTGfMMX9wpUOjWDbEeVbDDUu0Wcui
	sJi/W4liB33gI156nn7Fx9oG15W+Wf1FeIaGgzDuzuytJGehQ0yoNS/A/ZY858UgWg6O2JIGKDY
	vnkh9yogaQVYgu2bJLZlCdhklg/FJDHh3cAdsfsJmv3v1l201xw8nojCM/IgkDFWOzJ6oygRf5l
	G2FUURnMhAUHOmmx5sAyxRhZ982RBrvVrEShrPbO7DrkHmqvkCjpLn5gVPlSPenFH1gGbI7lvtd
	q0qLUiKqgoH4njTz+b5P3KD2vvHW1mWIM90Hkm0Zy/E2BlwKQJ
X-Received: by 2002:a05:600c:8b30:b0:47e:e5c5:f3a3 with SMTP id 5b1f17b1804b1-4830e96fa39mr8882075e9.24.1770145052437;
        Tue, 03 Feb 2026 10:57:32 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830eac4d11sm7773425e9.3.2026.02.03.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:57:32 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH wireless-next 1/4] wifi: cfg80211: fix background CAC
Date: Tue,  3 Feb 2026 19:53:46 +0100
Message-ID: <20260203185717.103810-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
References: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31507-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79E25DE073
X-Rspamd-Action: no action

Fix:
- Send CAC_ABORT event when background CAC is canceled
- Cancel CAC done workqueue when radar is detected
- Release background wdev ownership when CAC is aborted or passed
- Clean lower layer background radar state when CAC is aborted or passed
- Prevent sending abort event when radar event is sent

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/mlme.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 3fc175f9f868..212178d04efa 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1115,8 +1115,10 @@ void __cfg80211_radar_event(struct wiphy *wiphy,
 	 */
 	cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAVAILABLE);
 
-	if (offchan)
+	if (offchan) {
+		cancel_delayed_work(&rdev->background_cac_done_wk);
 		queue_work(cfg80211_wq, &rdev->background_cac_abort_wk);
+	}
 
 	cfg80211_sched_dfs_chan_update(rdev);
 
@@ -1187,21 +1189,16 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	if (!cfg80211_chandef_valid(chandef))
 		return;
 
-	if (!rdev->background_radar_wdev)
-		return;
-
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
 		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
 		memcpy(&rdev->cac_done_chandef, chandef, sizeof(*chandef));
 		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
 		cfg80211_sched_dfs_chan_update(rdev);
-		wdev = rdev->background_radar_wdev;
 		break;
 	case NL80211_RADAR_CAC_ABORTED:
 		if (!cancel_delayed_work(&rdev->background_cac_done_wk))
 			return;
-		wdev = rdev->background_radar_wdev;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
 		break;
@@ -1213,17 +1210,6 @@ __cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
 	nl80211_radar_notify(rdev, chandef, event, netdev, GFP_KERNEL);
 }
 
-static void
-cfg80211_background_cac_event(struct cfg80211_registered_device *rdev,
-			      const struct cfg80211_chan_def *chandef,
-			      enum nl80211_radar_event event)
-{
-	guard(wiphy)(&rdev->wiphy);
-
-	__cfg80211_background_cac_event(rdev, rdev->background_radar_wdev,
-					chandef, event);
-}
-
 void cfg80211_background_cac_done_wk(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
@@ -1231,18 +1217,30 @@ void cfg80211_background_cac_done_wk(struct work_struct *work)
 
 	rdev = container_of(delayed_work, struct cfg80211_registered_device,
 			    background_cac_done_wk);
-	cfg80211_background_cac_event(rdev, &rdev->background_radar_chandef,
-				      NL80211_RADAR_CAC_FINISHED);
+
+	guard(wiphy)(&rdev->wiphy);
+
+	rdev_set_radar_background(rdev, NULL);
+	rdev->background_radar_wdev = NULL;
+
+	__cfg80211_background_cac_event(rdev, rdev->background_radar_wdev,
+					&rdev->background_radar_chandef,
+					NL80211_RADAR_CAC_FINISHED);
 }
 
 void cfg80211_background_cac_abort_wk(struct work_struct *work)
 {
 	struct cfg80211_registered_device *rdev;
+	struct wireless_dev *wdev;
 
 	rdev = container_of(work, struct cfg80211_registered_device,
 			    background_cac_abort_wk);
-	cfg80211_background_cac_event(rdev, &rdev->background_radar_chandef,
-				      NL80211_RADAR_CAC_ABORTED);
+
+	guard(wiphy)(&rdev->wiphy);
+
+	wdev = rdev->background_radar_wdev;
+	if (wdev)
+		cfg80211_stop_background_radar_detection(wdev);
 }
 
 void cfg80211_background_cac_abort(struct wiphy *wiphy)
-- 
2.43.0


