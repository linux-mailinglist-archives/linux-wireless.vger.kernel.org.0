Return-Path: <linux-wireless+bounces-29258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6281C7D63F
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 20:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 647E34E0F2A
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9A22C11C7;
	Sat, 22 Nov 2025 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSJnAQWr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF451D5CE0
	for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763839347; cv=none; b=nNFn0Enuq+n1cJJnTTr37ZTtRXuOG9FRzyMVM73giZdqcDPnBh/LzRQ+7ekHrh9+mUrxO7D4oijoAN8N0pW7Y9MKdSVYBlUGbnZLxdM8jKbox/PNLwX19V0q56kLQKr49KzTepQhtSUjtHfu4zFXG4lA4Yz4BpFxlXi/6J0mpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763839347; c=relaxed/simple;
	bh=yPFRPI11gkvUzahpZJ5ewygPyaOhsbjPxfEIVvchcxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIfotBV2gOMAyEMMa7Ri+KfQpu0hXtsAOfpdSmOytTeuUzn/pCoYqXUgT13182svUaiyORDt1BuAXGROtiWGD5bUNnKD5AgNRhzfndqtdbVcKPeECbsYTHQXknxpxfjbNSaYn7x07DBxSzYWKSGwIXXhSWDMEW584wyuEakBq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSJnAQWr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso5224664a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 22 Nov 2025 11:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763839344; x=1764444144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsiZL/Qk6O/WEddqBqEMO7T7dwTxbekBdxoEPDGEx4U=;
        b=MSJnAQWriVSHWppyAQ9hSUyU3Mril82AKZRzG/VfhrkgM71LRNSMe+SHxpGMmQmasp
         JZqrkb1wkmYosl/ivfsbEnbtJmhnVx//TTFIgO3C6ekpeJXEud6C+q4nv0wYnqY6NjMx
         vCYDyeJHr00wxOPiAed4xB4wMmweY037Auy2Llxcqzs86cQi3EhOBf0a5zNRCIvi9olu
         Urm2ty7tF1VQrnCh3LuNP+drzX9wztywAzi9eBJzz6Yf1KHoBon0hgF3fpW/zabu9n3O
         49L2C0OXFBhzRcL7eXcn+odrj7xdsBpJdu5YjkrpGmBnuAR5Yc9zejv52Gk3RKWtHgqK
         zDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763839344; x=1764444144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wsiZL/Qk6O/WEddqBqEMO7T7dwTxbekBdxoEPDGEx4U=;
        b=Au2XftJhj/EsvLGDXK8h/o7QKODLY9+popoMlVgObvw7sbGdZqPuTeTNm+ZZI2eBQz
         3sroC9RJWJXBqR41Wxdo1chYYwwUYNP48v5baMzjc6pNJQwZv4VDm6oLymVwxcVhxXBE
         G3vYjY53EbPlRHSpa6BMkPHPFy8Z8Qtqlmrogq3GA/pMWd70iN79MRWhVtjEK5AHezVS
         3DT2sVxywnh9Y4gugfuRdha/XlhPTZ3jsQGFo1wR8hvfPY8UevwalRbT78GQuvbHt273
         dVZjILj48uvMaf9i8iVayR4xU0ph/IEV6zGoVq/aTv0fIqCaZvqWOJQqykAB1mqgHWhc
         sTkw==
X-Gm-Message-State: AOJu0Yy0eKlxf1qDE5BEe8K8xU1lDyS+HDUjhALDICy8ue15xC5Za/pc
	P76wSjfUm/YJAfPQfOXbQJUWvVrOQvILmiW/H316Q2TkcsXcwhioIF8z7J3CZDkC
X-Gm-Gg: ASbGncumshvK6553QzwFCgclifOXjpNKo7NoC4uIZuC1c6kEOZ4Ek7qAND/WZ8UvpHh
	/WCze51V/ut6Gh+L4DeiURkM294Rfcwr0VHdMkPwzA7yxGLt9euXqxMDr36O8AxODZgMijRlakO
	Rxyox3F+Eo/GcRJTs3zkFbtySuFNiFHkJXc+K7DIVdNiUnwPIlK3ZCZoMWbN6Io4edrxqvyEO7G
	DifjF9Eth9mF9PHH97D1Ose80ImI9ndnPYHJfAQXOk83L9EYqpmHyPgcWJk59ukRrlhCRxhkwgJ
	sxW+tWqgRukn/71cnDKehLTnhGNtiLsKA5CO7GUeueV2OS7N9yED6nBO8nBEv3Vm+54RMnY5rk5
	YaafJqQLVunpq5xw2/BYUk9d/QE49mqjMlfqPlXGTdwu3w6YYYmZXUVGrfk5R2gB011eGaqJ/eU
	ZfZ4oJ1IKlwDZhBKFajnROfJTykoToG/QfY898ZpuhuFL0ILp9aw4=
X-Google-Smtp-Source: AGHT+IFw7vq76wM3u3+QdtI5KCDxsEKr9r3qk7qc/f6Zbj12xJynaS0xcWIrcy7hXv67N60G++SJFA==
X-Received: by 2002:a05:6402:1e8c:b0:645:d07:8924 with SMTP id 4fb4d7f45d1cf-645550f231bmr6598556a12.16.1763839343756;
        Sat, 22 Nov 2025 11:22:23 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d321sm7517378a12.20.2025.11.22.11.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 11:22:23 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v4 wireless-next 1/4] wifi: cfg80211: fix background CAC
Date: Sat, 22 Nov 2025 20:17:03 +0100
Message-ID: <20251122192204.6866-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122192204.6866-1-janusz.dziedzic@gmail.com>
References: <20251122192204.6866-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix:
- Send CAC_ABORT event when background CAC is canceled
- Cancel CAC done workqueue when radar is detected
- Release background wdev ownership when CAC is aborted or passed
- Clean lower layer background radar state when CAC is aborted or passed
- Prevent sending abort event when radar event is sent

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/mlme.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 46394eb2086f..18f6d41de4e0 100644
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
@@ -1231,6 +1228,12 @@ void cfg80211_background_cac_done_wk(struct work_struct *work)
 
 	rdev = container_of(delayed_work, struct cfg80211_registered_device,
 			    background_cac_done_wk);
+
+	guard(wiphy)(&rdev->wiphy);
+
+	rdev_set_radar_background(rdev, NULL);
+	rdev->background_radar_wdev = NULL;
+
 	cfg80211_background_cac_event(rdev, &rdev->background_radar_chandef,
 				      NL80211_RADAR_CAC_FINISHED);
 }
@@ -1238,11 +1241,16 @@ void cfg80211_background_cac_done_wk(struct work_struct *work)
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


