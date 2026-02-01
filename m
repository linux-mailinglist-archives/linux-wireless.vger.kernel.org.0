Return-Path: <linux-wireless+bounces-31428-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEwANfZ8f2nMrwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31428-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:19:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB7DC66A1
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 540DA3001CED
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Feb 2026 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD06248F5C;
	Sun,  1 Feb 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxxKevQF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A4242D91
	for <linux-wireless@vger.kernel.org>; Sun,  1 Feb 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962735; cv=none; b=eNgPd9kTB3AuXh2uWUjvHSrjuCX8YyzZGBZGWGQlDef2eYbrPM1PE5qxvyJoUBZkcc2gHHAJXqfSPh48OoWxrHuRwCmK0sm0mTlr2+3mR3baUUO1zKtEbllnJWyH8b6pQ0qFMdovqVrRUgd8eV87YhwkfS1y+vUANR38qIA961M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962735; c=relaxed/simple;
	bh=Ru6IwYp9TYf6IwxXA6fm4FCfKEc9vpq6/Nyd8KVSftU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEHtsrSACVO9YvLbUwVoLeGxBpVU+Y89+5xMcATGtXhJ4wG3ZionoikzVXD7YRkp9e8zxtlwV0Y+oZsvdgzl6edNCzP4YYtuESqlekTl+536Ay61ZXVxuaq6kzM2D16pBY5FGE0lVU4cJEKNxd8Kl/lQy99rfxwG4cZWcOmTUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxxKevQF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso14639155e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769962732; x=1770567532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ+jnweoDGkeUIToLfriab5tDVmZNAy+555y5fQdc6o=;
        b=UxxKevQFqDDKSN8XtxGjgae7hlkLrEhEuTkNExYGXbl0hPy406b8Pnaha4EUPwbL5b
         P3cGDI/B3ruL006xilTLYjSpprsdm58+Gg2p6Hh9+Y0Xjg/6TEfW/Uhp2LcUk4iJ4sMq
         Do7az9usu/EZFVXysSYpRgmP5JjkO/WehvVPE86gOqnCdVFIhxppYrvTwgCISWId7P4J
         tXLc/LkWW4lOHgSO1ndAMoaeyOLba/kPZsI2azfMhW5rkcnFEHhihz4OoAjxfPygW6e8
         b/ND+Bqs1V7vbA6qO4iIiCYQlJT0hEEJwRzE8pD3lUVayS5OaK6IZo47hqzsHyaqIDDQ
         M9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769962732; x=1770567532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQ+jnweoDGkeUIToLfriab5tDVmZNAy+555y5fQdc6o=;
        b=eXmxUYSEvCkjdwL9tz92pj7K2aTFauMynERHKI2XE6Q0LXqti9hQVQi4rsZZ5N+Uz+
         nwMvEYMFLWH3TeLR0bskQsK9lbZhGH9Kn11cZv/wG40iL432G5g09f19q/2xTACGE8OO
         bF98R1QVPD5Oq2i3lFGqi4iXYZ82nW1nxoZNRePnlbJ6bJgK9FHNEW2oycxYpp3QCuQW
         7TrDmE632Zo7Scya5wMwmtoSpCJLJBgl/wQZuuT5YlJLJ1bh2rb6QqUDrDbxsopg6VFe
         uZnxGeTDJrNx2l5vjwmqHeMFQKFHcw/UIKWdCZcWFTIJ/4JhyjHg5uAoondMuVsWSIp+
         V0Og==
X-Gm-Message-State: AOJu0YwyYJI3MsFP/k+MZijh8JdwnAw4QKE4o8xpmzDSu3yxlDzDk1AT
	I3QrxknRTdgbnctya6i1YK2D6/1clim2GricKl43ev5MuCuh/XT91rjymPHe/g==
X-Gm-Gg: AZuq6aLxzapBRAmsvsPvZp0qgUfNhaJNvgmR/8YwKiARjL0zUgR3QbLrhi9/YsZXtcZ
	/uLp2Xxq9QR+J6H9iLrXhLvUJRsStSAfml837B4/wWvFdJTcCAo24NJwRWbhVsBpw42Mw+ijwCz
	iqc4i1H/qw8AoiixH0zOOSmtuWr3cXxcjf4vjJB/hMU6SqHQUoWnHxHR3Y5NCGvRfvHjAaxwbCD
	H3whMEskTvpCPv6wja1wdZ0vPmbR7ujFL2Rv6gUbqAue48jkjN7QaMZ2XYWlinFLTm7y26sHOtJ
	DkwcS91ANDqC5J5RGlLYqbrMtF6SftWeWWDEatWGLtw0pHsuCMZCfzxAANmLzZ/KmsCFBTu7geU
	cWrnrV2hvz5qZsard9vAO1qZCIzM7hezqXSQ3hYimWBH+fPDziho5o2T5CplKdghBeywK7GOUaY
	rcOOUoQOQG+V1X/iv8LGMfIkad1iLFCMtSRKsqCGAXu2Wlz9ZK
X-Received: by 2002:a05:600c:1da8:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-482db498227mr106761135e9.26.1769962732345;
        Sun, 01 Feb 2026 08:18:52 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce93sm36368545f8f.24.2026.02.01.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 08:18:51 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v6 wireless-next 1/4] wifi: cfg80211: fix background CAC
Date: Sun,  1 Feb 2026 17:15:39 +0100
Message-ID: <20260201161836.16506-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
References: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31428-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBB7DC66A1
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


