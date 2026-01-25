Return-Path: <linux-wireless+bounces-31144-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB9kCwA/dmmXOAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31144-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B22B78153D
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0889E300103B
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA632572F;
	Sun, 25 Jan 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1IDkEQ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3751AD24
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357050; cv=none; b=U9MevOT99pp7QgPsMgvKVd6BtxgvCFmSHpC2fdewg1Qw1WUn5PFozvmXmKi5Zx2p59yxb8Q27XenuH4xnsq5QmYOquzP/3apmqIJkLnpgO+cCk+0jlkLRH5UUAb3EeCY0rPnQlX9t6OsRsVrmQo7Yv6LqiQtdxbkVTYHwI1fiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357050; c=relaxed/simple;
	bh=Ru6IwYp9TYf6IwxXA6fm4FCfKEc9vpq6/Nyd8KVSftU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pbqx2G6CIFcWhlNwzGOpK6P0wcu7tDUf7A1ZbtpQC9b0KES8jPXSt5KXIXbwIvvG/Uqq06dQM2C9gwIENNpKEfhIUvqOSsl+RQ7X772J9TozCRVEgD16XqO+plYFqrFkDIxHyIcV6xECWOuDU938xa/BEPUWMrGxjRNpjzxsLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1IDkEQ0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8863db032dso363289766b.0
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 08:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769357047; x=1769961847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ+jnweoDGkeUIToLfriab5tDVmZNAy+555y5fQdc6o=;
        b=L1IDkEQ0flyvY/PAuKvt4POXpcfNvFn8f89rTyE39u4rd5BYhNd4tXNP99ObZqkP0O
         FsGOEtECDPrPPJiDfihHWRLfSsmdPEzYk4C1a51SertzQ0YF5BF/eUwQYDdhkhjjtCDX
         vKZIxjwNfuqGe3QX1fL/TST23914cFdqxJG+nwHgltcy2JymfhO73ru0hCd4jtIHx7fA
         F9/QZyHnvRB1boS47VTa+xPXTjIOGjuqrqg3VxNRpqdwIjdN2YzsCat4a9bn+OWWPs9t
         TuxLvRiyMAzJqQJrlbzRTGSsb4yXZz8KE9zoM3MW4LOsr1rz1NmTYCmOm7wkoUCMOKlB
         UtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769357047; x=1769961847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQ+jnweoDGkeUIToLfriab5tDVmZNAy+555y5fQdc6o=;
        b=X5xfAKAa9xYuFE/mrhmUuVbffjBs43aub2+ZoCTCNumzJxP5l/5ttacT/3y5qGOk+Q
         z+X0g5X7Yv/CoFzYiLw3Cd0oykYtRYOFKtDjzKmxA/nxZmpFcLj2RbgoqZ1FTt8BLNbY
         LWYoDigFjXadIXZi8D2oC5uPbo6ktz8yYVAZXcXMCtrpCpEtmAhsANy2gS6VrQvpu9GN
         4jOP1Nr93QPD3aBHOnNYsWfAMvcIZZDWX/XLzzKG2fk6WO137fonaxNuqb0U9udZRyvh
         VESAPKSXxeV3EZe4qr+zGlMoDWYRret/RzWnm5MF7WjJbqRn+ghE9y9y4JApsNo18BhI
         z5fQ==
X-Gm-Message-State: AOJu0YyE1lm00Z8UTiPHpYraBh/CkaTDGdkxqUbCOUJbh8OpvsDejRaY
	K+pydW3Ljq+LwK3doZV7xZxWJT598cqcIwyHOf8tQujsmlImle44/iNoDD3rpg==
X-Gm-Gg: AZuq6aKcekrJ/kY/CXjqDt3BAvt7zMqOcadS80InaMEGJ7/OCe5/Mcc9olSRJ+f09JC
	eicLsjKa0NxX5KntmcnbBsfvDsyGMcvOfQARSUSEGCmu+wJEP1tugnCpyUwcfYhsRYaI6/bgNQ5
	2uE0XEjAQMdVR8PPiDd9I4VkGIf2DumHsZKlr6h1FV6dfeyV9TfT+7vezRQ9BNAL6d0/vwLdU+P
	Ynl1kQfawgUj+rE4V3h0FBZzOobPnsHWDAyv1ygu9C+4dgS+e/SpgD33Iql1wTgMh6nPV/HIdzr
	bZPoz00wWvHaKz0XF/UoaclHvrH53oCcL7bBw4r1VPjQ6zVtqugxLp+h0pJ9fv7/czPzX7OgraX
	w9ym563FVYf3UXJhB6ei3Isg7ixYIC2RNEliOp0pfvLCXRpIA+GBfP6ThneoTkUdme/NPQmTbKW
	oQoa+gEeDgMYA2PzA1/rNze1NGLw1/gy5liJIFX4c7rNvZUqSH
X-Received: by 2002:a17:907:96a5:b0:b88:6542:86a0 with SMTP id a640c23a62f3a-b8d4f71d3abmr139689166b.54.1769357046830;
        Sun, 25 Jan 2026 08:04:06 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b886a249e69sm408330466b.6.2026.01.25.08.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 08:04:06 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v5 wireless-next 1/4] wifi: cfg80211: fix background CAC
Date: Sun, 25 Jan 2026 17:00:29 +0100
Message-ID: <20260125160353.34102-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
References: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31144-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B22B78153D
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


