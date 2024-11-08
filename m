Return-Path: <linux-wireless+bounces-15124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A579C140E
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 03:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C052849CE
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 02:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD51DFCB;
	Fri,  8 Nov 2024 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grR3Ei54"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8239FD6;
	Fri,  8 Nov 2024 02:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032927; cv=none; b=DKc6NQdmLrYyvdLxYRvIQ/y+yqqbUf/tUEJ8BvUN9V/8s3VZqTVYNxL0r467MwR4SB4qxpXgapa10w/BovwE6q/rcGy1b7trlXAKQ0eGZzZUBw/xe6IlDtnu7ogoQaRu2MAWcT1c/ZQzvOe66V9PPQF4uD7stsMH+2XS9vQ8qgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032927; c=relaxed/simple;
	bh=hEQygF4m8DjrDBiR5+IO9YBL5x2uHYH3btJu+BhLG0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BseYYQ/GYR2QDi9hLG5UHibiLvbBuV4x9k5zlmreTepm1YbRfzKQVA5djW3QGy8JyKjgbKTINAU9fPB+ZdJ3QXMFoezI2QdGJF5d960YyQkqRcdUoBDglLtQNHh3QSQYvu6YDKaP0hMpLgfMo+yiYDvzVXjjEjC3TO4wWcUkxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grR3Ei54; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e681bc315so1248120b3a.0;
        Thu, 07 Nov 2024 18:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731032926; x=1731637726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRhYlWrr+h7c7N/+/EIXt40Xsz1hnVz9xjst1BA0/tw=;
        b=grR3Ei54VFpAt9n04ZCax2/R/AFIar+ZNbg2fLqpZk0CifgSbwOMiQGqJ4+gLu0fsB
         LcYcJHf0DIsGty+DiC3RgIe7PymlYPYVqAD9wxEoc7aUwVolnTCg8O/1S6Y3nc3KgVj0
         SyfMF0tKhgirY7bYMP8SQp1p5AaCAL+urd/dpzy2MTGFz6/xzAUAN4EvSiK9r0Vws+sq
         ivI3aaM8SvjczCw7V0bQ3mCd5H5NSCADSrzFE2xQxWx4ogsJJOj40A0RErxgvwMOXSZk
         I+srzB8UIHqwXgmnZ+nvytP6JGNkZUqBvU8V3cvDRJ92aVtHiXQRjIZqiR1caNSgoZGt
         uLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731032926; x=1731637726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRhYlWrr+h7c7N/+/EIXt40Xsz1hnVz9xjst1BA0/tw=;
        b=mkRQI1A/CtXM9PHcu0T4aTvXnkJWDir3R6d57SK9rVq9+zSq7dR11idY6TGfOO6d4g
         iGB+vXufivGiwpOZ7XOFsGtwWhFj2NzbE7uiYuCmxYkVonWXi7jHqz75ui9GkR/UwFfs
         nWdnB7UCAyI1TAGK93qR11SHa82e8wt2/JX1YJiXO7lgdH2Fk02gBmlaBRxq3eYja+Iq
         R/UU+3VDrc57xUMM2qNs3LFn6Lewa277rqWx3fQY+zw6aTAnRtlQ0OQsFcs5PR7xIuzL
         RNhVl3GFfIX7iaSfSlNrD46Xi7HdQ3RYUiJqSLZis/pEN8a2VeLUBYbdmr330cX7q0KC
         Dvnw==
X-Forwarded-Encrypted: i=1; AJvYcCUOP7wrjqZ6P3k97RHQeM0bx6tonKpqHjyqE/8+IUCYFV1XfkRmJpC4lPbE++T+gxrQCQgbkB8l7wXCuk0=@vger.kernel.org, AJvYcCUeGUgABaTe2JnAR10dyEHIZcDKCgFMwFWbVqn/Zywn5VLVziRKzddS46yO+d7h2ouTZdmp8xsbXe3gw1Lprow=@vger.kernel.org, AJvYcCXqYAtDhvmMvdUn0jb2u2xYFOBoZe3VTMRfj6Nei3EbWXiHR8jK2bqruvsjPj+YoKfqPzPKoMsF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9FQf5e4UP9unMt2jBc8j0x2iIFrGjdcXXjjVpK1HpxdhL5zEf
	n/Kp3xMKDw3k/eVzUQn8VHvI8qBF61OZG058s+V0y1NJQHyLZ6NO
X-Google-Smtp-Source: AGHT+IEZDoZVjLwxmtQY0g554/k/EBW12ojyO61yIKTJ/8pjxKfSjIeFDjtlfjJkQIVnght6o7lz9A==
X-Received: by 2002:a05:6a00:4b56:b0:71e:7174:3a6 with SMTP id d2e1a72fcca58-72413da856cmr1726998b3a.0.1731032925477;
        Thu, 07 Nov 2024 18:28:45 -0800 (PST)
Received: from sarvesh-ROG-Zephyrus-M15.. ([49.206.113.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a9ad4sm2465304b3a.78.2024.11.07.18.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:28:44 -0800 (PST)
From: Saru2003 <sarvesh20123@gmail.com>
To: johannes@sipsolutions.net
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saru2003 <sarvesh20123@gmail.com>
Subject: [PATCH] Fix: Ensure auth_data and ap_addr are properly set before marking STA as authenticated
Date: Fri,  8 Nov 2024 07:58:28 +0530
Message-ID: <20241108022828.6571-1-sarvesh20123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Saru2003 <sarvesh20123@gmail.com>
---
 net/mac80211/mlme.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 735e78adb0db..a1ca7385dc1b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4247,8 +4247,15 @@ static void ieee80211_auth_challenge(struct ieee80211_sub_if_data *sdata,
 static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	const u8 *ap_addr = ifmgd->auth_data->ap_addr;
+	const u8 *ap_addr;
 	struct sta_info *sta;
+	
+	if (!ifmgd->auth_data || !ifmgd->auth_data->ap_addr) {
+		sdata_info(sdata, "auth_data not set or ap_addr missing\n");
+		return false;
+	}
+
+	ap_addr = ifmgd->auth_data->ap_addr;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -4261,7 +4268,7 @@ static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata)
 	/* move station state to auth */
 	sta = sta_info_get(sdata, ap_addr);
 	if (!sta) {
-		WARN_ONCE(1, "%s: STA %pM not found", sdata->name, ap_addr);
+	        sdata_info(sdata, "STA %pM not found, skipping authentication mark\n", ap_addr);
 		return false;
 	}
 	if (sta_info_move_state(sta, IEEE80211_STA_AUTH)) {
-- 
2.43.0


