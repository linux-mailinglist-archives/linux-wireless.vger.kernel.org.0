Return-Path: <linux-wireless+bounces-28996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAC1C60996
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 18:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 865DA4E3F4E
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 17:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B93F304BB5;
	Sat, 15 Nov 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1BV05HH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F9303C93
	for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763228574; cv=none; b=G+pjyp9bJJIOAMs2kxi3+MQrtKL42/+mzCxuNj456yiFvF9e/WCxbINRYS7eGaFWvyaVNojxtVlRLFSVA8EjeWDCOikkNMWKstPzc7GxMoYlCxtSQOTG5NnXbKeNFpB7djDdA5hFOuGjxN2e4EDbq7OCvsoD8Ow5jcOhRtuxIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763228574; c=relaxed/simple;
	bh=xs31JPs3t5uCllxxyeegl+DrDjNKrIER2uvtKKVlFlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIPDU7gBWRTD85Yk3UmDqHQ2U2MwO5OEjRR6MWK/Yykv3oy8SxLuXKt7dpqn3JwK9tamKiOHNZcuQ7e9/xzYxQiBpPFaidrP7P7P1ePEZ17ad6c/xAP1ZK4BNCX3ovjy2aSsrDFQsUXvkSuYtPikjDpt0SEZt9BRE/mylt/8bI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1BV05HH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so4388101a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763228571; x=1763833371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DW3ZdVHlUqb4ASH7GqgbJDWdBZTUYkxW0jKmYbuUSA=;
        b=g1BV05HH9bJhL9Og1r1KDa/Y0G1PE7FDfo8cNQ/7WJDIVvW7ENyt2mH5LErTK860e7
         8dyWVltp44OHzXqq8tQQKbNeYfS51T5Hdj46OLucfnMHqAgcz9etrHFOMlAIy4M/FKPG
         WXihaibgRI5NqkaGccplJ+EUxlT+H57ZY5uY5EhFMIw7Skbk7JRr/Bfam3X6eLi30o7D
         gMWd5r3eSv01nEKjLVQU2M00Uli6YrxfjngaYmT6bTEfjfr7H2RXqfmBMX+E1H06JMtS
         dp+XpMGKQdqAopy1JRrip0REPWBRwXosLU/eYAA12pnvz/JtybzHhN+xKZK5UkkZJVKW
         v8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763228571; x=1763833371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DW3ZdVHlUqb4ASH7GqgbJDWdBZTUYkxW0jKmYbuUSA=;
        b=pvl4gdBSD/xZKfBVWrDmEToXZJnDcIukxtY/Vv0j93AUkRSeMB8YTk9gim/iNUqzlK
         ZDvqLrTqcVrRpLtXo+Sh/QhNbskkxo3ta2JltLPemy+g4TWq+qI4dq+sBQma+OaQXKiu
         akbZHxgMmuwWCR3y7WY+JNQjSStIZQiWFTX5brXgS/SynE8Dy7t0D7X07gEZZpZZP6aG
         lzLG1/NqqLeVBaxR5L+cACuLVVjBe0xKlyxHSbnAP8pZPnnGS7Qc5Teba2qS5jy06zli
         XwsfMdPeM5Wq0lZ3sCdFqRxiwLouKWkjGn6PkUwAUKje+Qc0ME11/dyDlJ/MTFyRsWtF
         Y/ew==
X-Gm-Message-State: AOJu0YwZ+HFtVGou1VmJKhx0ILXI4tXtEXf7jIKbWcuIVCpHkNLS10vG
	cLV47TVMHL6NCpYGtDmGTZUSiQCmY4g9M6gNZo0Euyzfv6hYIemq4WhYmPbC7A==
X-Gm-Gg: ASbGncvJBv4qJ9ma1udpLu5JNQodM3pCDKYxfV9Fqkmi3ZiIdqHDvj30e1LKBzVFWAa
	Wr9yj4QUq1lSfY98umY38VF+We+M9DJwN9ZqNCUHtB/spJrvjV4DEsoUGbeVknGs1en+Y6H5PGI
	veuWT9MoTEL7Nb6x2+3vzKD3kP5c9iQXyAct9o7VkxM6NWyMsxd67tVBA+gp/e3Oo4aucgDRsvi
	ocx1dxvZ3MeslJpqL436CZhHS8tg+Vfr0nP3MEPUxudKFAm0DL9ro10ePgDxoPhR+8pA1DlLiB8
	tzAnzv/Rh7iucePa4KIo2xi/qZJ8ric7civ6mr10j4RoqtmhnI5RqeSRKJ3sQsTprXmjfTeaQiF
	TgJqyHKWvQgx9hzINf4t9x6/czAvYzlnd5g4IpZh0KYs/O5skLrY4zEXcF1/HepOp+y2NZmS0DL
	3RnOrNehtbBKqefbzjRxOXuY7mGD4rMM3Nq1ux2DQ20qtOWmtNhqZQrvhpnZdQVg==
X-Google-Smtp-Source: AGHT+IEwRFJqt3VMgv+ZXX4vhImnl18jKvWNRjuuyXZF3w/3Uoi731ZgphojDWRKPDmcKFhqkbL3kw==
X-Received: by 2002:a17:907:94cf:b0:b3e:e16a:8cdb with SMTP id a640c23a62f3a-b73678085ecmr740521866b.12.1763228570812;
        Sat, 15 Nov 2025 09:42:50 -0800 (PST)
Received: from hp.lan (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd8099asm664941666b.43.2025.11.15.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:42:50 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v3 wireless-next 1/4] wifi: cfg80211: fix background CAC cancellation
Date: Sat, 15 Nov 2025 18:33:19 +0100
Message-ID: <20251115174230.20504-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
References: <20251115174230.20504-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes missing CAC_ABORTED event when background
radar is canceled.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 net/wireless/mlme.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 46394eb2086f..8f947115369f 100644
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
@@ -1231,6 +1228,10 @@ void cfg80211_background_cac_done_wk(struct work_struct *work)
 
 	rdev = container_of(delayed_work, struct cfg80211_registered_device,
 			    background_cac_done_wk);
+
+	rdev_set_radar_background(rdev, NULL);
+	rdev->background_radar_wdev = NULL; /* Release offchain ownership */
+
 	cfg80211_background_cac_event(rdev, &rdev->background_radar_chandef,
 				      NL80211_RADAR_CAC_FINISHED);
 }
@@ -1238,11 +1239,14 @@ void cfg80211_background_cac_done_wk(struct work_struct *work)
 void cfg80211_background_cac_abort_wk(struct work_struct *work)
 {
 	struct cfg80211_registered_device *rdev;
+	struct wireless_dev *wdev;
 
 	rdev = container_of(work, struct cfg80211_registered_device,
 			    background_cac_abort_wk);
-	cfg80211_background_cac_event(rdev, &rdev->background_radar_chandef,
-				      NL80211_RADAR_CAC_ABORTED);
+
+	wdev = rdev->background_radar_wdev;
+	if (wdev)
+		cfg80211_stop_background_radar_detection(wdev);
 }
 
 void cfg80211_background_cac_abort(struct wiphy *wiphy)
-- 
2.43.0


