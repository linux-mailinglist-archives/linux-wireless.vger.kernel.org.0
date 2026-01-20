Return-Path: <linux-wireless+bounces-30986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CCD3BDD5
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 04:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4457346276
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 03:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13205315D31;
	Tue, 20 Jan 2026 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="B9QhcBjj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997B315D30
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768878697; cv=none; b=EE0fH0ESgh2eV47Z8j/l3i/B81HvtKrVCJ8g467bP7E/fua10hrlZAnaTV5nhnJVhAektcaZhXMkVf7EbqvRgFWVWAO/tp4ry0UF3JYh5Bz94jxg0/d7KWV5cLHfyXxSZhicvecZ5MkMmNatMh0hYEghtfyiGfXa793Xfx7Epa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768878697; c=relaxed/simple;
	bh=fhxNJe5cDk3skA9vRFoxMhUrZfG00xmZ7IERuww6CSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPe2JCb/whfrdYiuEBaTHSvhSnO3ukAQbissswly3B1tZlKu54eOu8DUCzWY4P1KIA7P0GNvbsIO78IRU4b4EHHndDIXK+KawXu4zjNErucLZQoKqlN5at+6ZxXm5u5gLeqt6Zw3h9hwB7FGrCZ6DMN84eQkMHryMT0odyQY5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=B9QhcBjj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d5c365ceso37029885ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 19:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1768878694; x=1769483494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6fqkha7IOTzQEtFp7qvVsJq1D00pDa+fSD2mZp7ICA=;
        b=B9QhcBjjs3l1N6vD4sEkSkdZt5IWTnnWUpJzrDmbpV/8ZnmkOGqEQbvnF2EHy/R7Li
         qIqFDfOg85+taHJZuUcs4d9kmU89W6zrvfJPqQ9CCFfs5teKatIkmxhMngwIwNfQtswD
         prAEeb/yRrR5KbqZNvV6rpGMwmrGaNd8CUxR6sbUPZkgva+jEGgnSxkGzras2DhccyCH
         LCs+KxVvEx3p1N96YeQQuQ1X+8bDgnaZqlshPwLGCO/CIn9YaOPggPoostQ2IBbm83Gu
         RrTwKXCTuc8TIc5mgdmTOzwD70m2eYNPAksh6Q01SLgkKfEvLtfA/NUS0PLuXm9pIy3B
         d7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768878694; x=1769483494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6fqkha7IOTzQEtFp7qvVsJq1D00pDa+fSD2mZp7ICA=;
        b=eaMWR5jvOkzxPZOO5u/xWWkkSs0KVCPH9LKQWszUVvXRoZILwpxiVY8MfbWA2fHTmE
         2gPtqBz/MeYvVnpIAn9lPof0qGp8Gs5AxI30/QNjI4R2JYwschslVr4ufieyxw2Wzt99
         /giEl0BCAJMoaRCc5YYIjiUJHOfpD6noR3Bp0wdFnIoBZgwDRBGD8u1pA04mnDEHcIpT
         rjOYcK8oz8qvohGQ523Fte1ZzbRaLehB2LCzTJVMlOSOmvMpdqBsU2AGFlfwqUIR52GU
         BmwcsAJrH8S7s+XW66bEkmUjc1X4Vj5HHATzgbnYr0qp/IHD93tu0K+VzM6JelK6il5w
         0WBg==
X-Gm-Message-State: AOJu0Yw2xSoKXyGZt+JsLzjqoH971VSNHnDEhvnu3DuCUoa/00x7O6qC
	SdYXYm8pV13D+IBze4xPd0sg0joMdWiM7/QXE9rXsdvTFKM6dDdVx6oua8ys0zLFGznXOcQR0Xo
	BsGDS
X-Gm-Gg: AZuq6aIX4EOMs90U3a1W4MUwOIC5pGuaeX/riKeOnUubmXaqbD1U8gRrKPUAyg8t4yj
	x3CpNSK8JrmLEc1F2fm+NPNpPd6WIVXeZzjB+TepDU9lAvrg6jimUVs3iSshSCR12qAJdNoGzIW
	aM5Bi+TBfec8vl6sGiobVxYPiwXCYsEYx0GKI3GofTOuNYIkh1UeeW2qbKnVLEjYNfunDKx4+ZI
	EAdzL+Yf1qXUrspNbPAmNmbteQKau3gW7uRiVj0MBFyDQfHqumTsYxmZC9DbG7ses5vZz/vQf5I
	qq8UxG4yZpiryCN7zFZF4vz54SWApVKou3jZxdXP4C4SGqCx8RMfVZHzb4aQfL1FRCDO8mW/lCK
	IWjiRxqGcKuB+eFmlslpMZWXCaD8Pv8yS4BjmUmWhuaeFPXqWfmyWslYTdHJT9+olq6JfOfbVRq
	rwUTEVXvp9PmCeh5RwLZ0dzmhHEgZsocm8wKEp8gZ8N/8a/FDJ2B5IceNUBuoZVqfT/RFbEVeIf
	whta3ILz/RFB5MLPZk=
X-Received: by 2002:a17:903:186:b0:2a0:8963:c147 with SMTP id d9443c01a7336-2a718949960mr128822295ad.45.1768878694285;
        Mon, 19 Jan 2026 19:11:34 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fc503sm106660815ad.75.2026.01.19.19.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:11:33 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless] wifi: mac80211: don't perform DA check on S1G beacon
Date: Tue, 20 Jan 2026 14:11:21 +1100
Message-ID: <20260120031122.309942-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S1G beacons don't contain the DA field as per IEEE80211-2024 9.3.4.3,
so the DA broadcast check reads the SA address of the S1G beacon which
will subsequently lead to the beacon being dropped. As a result, passive
scanning is not possible. Fix this by only performing the check on
non-S1G beacons to allow S1G long beacons to be processed during a
passive scan.

Fixes: ddf82e752f8a ("wifi: mac80211: Allow beacons to update BSS table regardless of scan")
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 5ef315ed3b0f..4823c8d45639 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -347,8 +347,13 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 						 mgmt->da))
 			return;
 	} else {
-		/* Beacons are expected only with broadcast address */
-		if (!is_broadcast_ether_addr(mgmt->da))
+		/*
+		 * Non-S1G beacons are expected only with broadcast address.
+		 * S1G beacons only carry the SA so no DA check is required
+		 * nor possible.
+		 */
+		if (!ieee80211_is_s1g_beacon(mgmt->frame_control) &&
+		    !is_broadcast_ether_addr(mgmt->da))
 			return;
 	}
 
-- 
2.43.0


