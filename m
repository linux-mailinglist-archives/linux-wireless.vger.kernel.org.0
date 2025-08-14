Return-Path: <linux-wireless+bounces-26381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B1B25B39
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 07:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD36560D04
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 05:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF722333B;
	Thu, 14 Aug 2025 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWIP+R9T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6B2222CA;
	Thu, 14 Aug 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150504; cv=none; b=Pw+5IXhAMGx5X5Ylrm47ujhTq0ZzxJgPoVOF1YJ5ojD2N5CPlOK15zDj1vxtUZGOlHoT3ZijASqNo4aOJInLuPZma1EsPWhUo9XHHZTCTohwuFhFxQ/QEnjez2cmMuRW/R5NJ9656LkFXZrfdgj89lM2Gc+gE/T469ZpiQX2jSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150504; c=relaxed/simple;
	bh=+0OzEiu1IwHYZBATpQwNvFeQfWRM20a9bZXzyMJbRNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BgWFA9GdNJ7JIXLyrpFRA54oi35RgmLsse1gIY1/gWLmiycOZmqDii264MPzdI+3ENaIlQVRV1dM3S+SfSb8D1BTmp71XEWRwUrlHBL+dIirX6f+EEyp2xGZ0gfPNpYcqaNYmb0Ju7uCp8g0FORr2FRPLKEWc9KMVd+wNopHd84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWIP+R9T; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce526a25eso552240e87.3;
        Wed, 13 Aug 2025 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755150501; x=1755755301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUNtO4pH/dYIC4p6AKf+kH0mLx/dB4II9+DFQLnph/s=;
        b=OWIP+R9Tu1MDzW2sX1kfo1y0YYCsIBiP6HrZfGBS+D5GFidAsohHzD1VYqdIarg0J7
         O3Ryo3WgRcTiT63RCuews2QYEImZ53s8QeSy1D4/Y0bcNwFN61b8TU+gLDF5NbLsDpRR
         QG59nSF6mvBjesV9SLT+2eIUQHkrFBVSFSp9fF2hqMovqN5T+s3j7jB3O6q5sPcPbkEQ
         wWoJkqRe+HlU+irZmygc1SVVaqATtIIuZWFXNdd9XnvaeGGVc/eOv0gLYj+7qszVmsYr
         Wpcm997SYe+w1EyAf1kXWEzPnw18Kych4Fs/8PSjlH1hfSiV2AhGzxNf6cxvKucTPytt
         np4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755150501; x=1755755301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUNtO4pH/dYIC4p6AKf+kH0mLx/dB4II9+DFQLnph/s=;
        b=xABx4faDVQjQCvoIaXyAK4k2AzCYFBHIaBqZeQqo/VUu5AAtsK2k3iL9bdBp0O5CgU
         tm8ei0ckQ1/8yGQggxlXvhqYj4mG4jDZwplJmAIRzG5xBdez57ackiGVjka/C0CCPRnA
         XNSEAVqxA7wZVaoymPU3w10XCioiJa3qZbP2xY65xOjeDF3/G9jTfKH9PEyZZGrTjRZE
         oaIat4qcEdc3KGc7+5BGeaQxoJ0auzbRg10GLS+1NGJ8uH2W1L6PZMhM3rbWv4nhC0Fj
         a1Tm9362h38UMUj1/STXn5wrxyBkM4Ai1OLLvCPrIuPQ6oM7YQq8eCa7AUkF+fLOjoQ/
         Fdkg==
X-Forwarded-Encrypted: i=1; AJvYcCVi0/FebMx/gMV91Yqokoc6CJnS02AaC41dtftY+QO7VfKuvCKcYTNJLaECXhlR70p0AeNTWZZ/cVBoqVI=@vger.kernel.org, AJvYcCWwnNpYKBmj7NZVCdaZSHoutn+Y2YXl1qQjfuDk70skW234OAF/1APus6CEAQcLDV3khRPHbmywh7Grc5eV+lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6qraKHC1+lG80mHTde6fwxRMiR0ghQo25/whY1lJ2bqfB1xf
	ZteyoDgCv5iHmuA4LMNQaQPWXLVP3dxknfEocY4qZgwyck/OcggsVsd7wbioTwTe
X-Gm-Gg: ASbGncs40LTmrfRp5ow5ZzrxTRBZgkUj8xzPxPSzhQgForuQxvtUIjfBj0LBru6E/R9
	laf+K1qDCoT6GdK+ZjstL29XMBEzUBA756j0FTqgfUEtEi8wL7Azo7pEIAb08uaGt82V/FK0SWt
	M4yukoqyYi7Oz1evx0kMZoIw+alUOw3Y27OePnN6q1Qe8JxZR9EaU114dtRtV3U4Ew1gAx+slTw
	9JPY/NgKKxp0fq6UVpriXgfSLKOI4GwAxt7Un84InpqsCwTwZ9VPxKvlHA0s8oTNKdvfaqQ+XXl
	pZUvLHC4aR4Se7oo0wyz42Sy+hjhl43M6TcQHhYrFk49t7YMPh0iFCDLbKiiEm/4Ao0zww2x8gf
	4enXqqPI5U0kE0elNos6LuhuCmGF3Y+iGbAd2eSaPhO1e8lBCdkZmIq8ols+jD4re/FMhNuFGQD
	DL1aCWwRkIHM1T0BQCOaSp
X-Google-Smtp-Source: AGHT+IF0cS6nJeqSR4x3dUlA00S4ZeJZ+cRKVOPAb2WYQETUE7cy0JiKDYv/snz5x7N5TkN5gAYglw==
X-Received: by 2002:a05:6512:420b:b0:55b:9192:319b with SMTP id 2adb3069b0e04-55ce5045d9emr390809e87.53.1755150500391;
        Wed, 13 Aug 2025 22:48:20 -0700 (PDT)
Received: from uuba.fritz.box (2001-14ba-6e-3100-4a6b-e900-eeb1-e216.rev.dnainternet.fi. [2001:14ba:6e:3100:4a6b:e900:eeb1:e216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c987acsm5447456e87.100.2025.08.13.22.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 22:48:19 -0700 (PDT)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	shaul.triebitz@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mikhail Lobanov <m.lobanov@rosa.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 6.12.y] wifi: mac80211: check basic rates validity in sta_link_apply_parameters
Date: Thu, 14 Aug 2025 08:48:04 +0300
Message-ID: <20250814054804.114024-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mikhail Lobanov <m.lobanov@rosa.ru>

[ Upstream commit 16ee3ea8faef8ff042acc15867a6c458c573de61 ]

When userspace sets supported rates for a new station via
NL80211_CMD_NEW_STATION, it might send a list that's empty
or contains only invalid values. Currently, we process these
values in sta_link_apply_parameters() without checking the result of
ieee80211_parse_bitrates(), which can lead to an empty rates bitmap.

A similar issue was addressed for NL80211_CMD_SET_BSS in commit
ce04abc3fcc6 ("wifi: mac80211: check basic rates validity").
This patch applies the same approach in sta_link_apply_parameters()
for NL80211_CMD_NEW_STATION, ensuring there is at least one valid
rate by inspecting the result of ieee80211_parse_bitrates().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: b95eb7f0eee4 ("wifi: cfg80211/mac80211: separate link params from station params")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
Link: https://patch.msgid.link/20250317103139.17625-1-m.lobanov@rosa.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
(cherry picked from commit 16ee3ea8faef8ff042acc15867a6c458c573de61)
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/cfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index cf2b8a05c338..9da17d653238 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1879,12 +1879,12 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	}
 
 	if (params->supported_rates &&
-	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
-					 sband, params->supported_rates,
-					 params->supported_rates_len,
-					 &link_sta->pub->supp_rates[sband->band]);
-	}
+	    params->supported_rates_len &&
+	    !ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
+				      sband, params->supported_rates,
+				      params->supported_rates_len,
+				      &link_sta->pub->supp_rates[sband->band]))
+		return -EINVAL;
 
 	if (params->ht_capa)
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-- 
2.50.0


