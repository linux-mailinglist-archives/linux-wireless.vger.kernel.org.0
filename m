Return-Path: <linux-wireless+bounces-13453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDCC98EC8F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 11:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9A41C21AB0
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7E61482E3;
	Thu,  3 Oct 2024 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFr+roai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D828370
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949560; cv=none; b=LOmb6QNYfm7iJ0lWSwpB5pqpDwQ1Ia4o3ImpiWWdKvvObk1znQVU33EbYEgk5wXfA001UScwQsnhDasNHbjI+kYqaQoL58VPEBuYTKHBsi/10r/ZVR72gme+FSLWhxxySjRuDES0J30nC9XmUyKUffoZ6gnpBIvvSZwdYZKDTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949560; c=relaxed/simple;
	bh=BylYCAH0fv09xWMkDD7odYLGc1OPrhoO3SG/i46GqlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzfayYMIoSPzIK30DMkufJ2GM18qD3UVO9ltPF82ga2pyn4tP0A65cOByEGzIaG/6w5B6QQ6EGEl+HDkzQxrrlyeoUwo4UgPKXLLL/B7/E0fNnGA9uMeUa7HoMgb+/XxY597gBi574Tkbuqq0/Vxiu+MZyTj0+LqM38v1BGcO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFr+roai; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso10308941fa.0
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2024 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727949557; x=1728554357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWsz53iBGX99pmQw5SgRnNJfEjqLHVT4c03IxnNMQbg=;
        b=FFr+roaipmSrWO7VQCiEzYPW+hiSGsuOO1bPqUJoBgLAgSd2hfcZAc1d+Re2f4MvEe
         A54f9m9P+y10hSTjntbsk4WJ6z43CR5uZmy78p55tBkgjPJbAndMaz/G3AAb0LpQhcNI
         Kuf2c3nkk9HwH2H+lHcp7YEEnJzYNnRcM87SaCBboFo6KQbngM+xTMgOqzehZp0AEAAK
         3InE2g1Jh1pT4KctZ4PiGpwHngDO9i4BuMawvmfmUa1tZl5BGn2ySlpkX3f/etyRgpLg
         e+UD0RWYNnRSrxKr9eJjWUYhOYp41m96UbDONwf7aDZJFA4BSMNxgfqcHTHGyIMsFvq9
         x6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949557; x=1728554357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWsz53iBGX99pmQw5SgRnNJfEjqLHVT4c03IxnNMQbg=;
        b=TIpJBPSwhRnu8yeJIrbE4W56V1g65LxnZb+kVe5JRxe5wgMTTo1avNIGLnlTeKV0Qp
         cebQJZWq1X0PM1LqQiPMS1HujihgYj3um2oms/QcB570unmWjZ2QdZdkhGkZoueYIQc2
         TrLW0B2JlZQLEFzSZssFznQA7CslNSETqgK7f2aDCmKBWEdPazkZSdVvCzhAkDTE3Do+
         v7thsfWoRvgqFNfTqNPheSL5BAf/aa5gsSOm4Q/VsCBfJsGx+uZ53EBGp3FTREUxjssJ
         tOGCfs3qLBE6L+9bl1DaiUNbma9uVMlhw2IU3h6WTqE0QuT19YFLvXY28LDuKRVyJZFW
         pcUA==
X-Gm-Message-State: AOJu0Yyow/BgV2A5ELXUvNsY6oLfuFd+N2r/dIjnsddJ7oUDpp6tp4mn
	cKsL7PW1krR4chM4yn4jU3Zv0jkk69QyWyzFuNIMGH/8m95Vxoor
X-Google-Smtp-Source: AGHT+IFWOEoZle1HADhbPQOQ04wsbG1CKANHluToo9Jb4bXrdVoBq9KpM6jScQfKLPANsjgd9bIfKw==
X-Received: by 2002:a05:651c:150a:b0:2fa:cf5b:1ea7 with SMTP id 38308e7fff4ca-2fae0ffccd0mr37339481fa.6.1727949556638;
        Thu, 03 Oct 2024 02:59:16 -0700 (PDT)
Received: from localhost.localdomain ([5.180.242.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecc11187sm1789531fa.55.2024.10.03.02.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 02:59:15 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: nl80211: remove redundant null pointer check in coalescing
Date: Thu,  3 Oct 2024 12:59:12 +0300
Message-ID: <20241003095912.218465-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'cfg80211_free_coalesce', '&coalesce->rules[i]' is a pointer
to VLA member of 'struct cfg80211_coalesce' and should never be NULL,
so redundant check may be dropped.

I think this is correct, but I haven't tested it seriously.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 net/wireless/nl80211.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9ab777e0bd4d..b71fa8beea1f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14061,8 +14061,6 @@ void cfg80211_free_coalesce(struct cfg80211_coalesce *coalesce)
 
 	for (i = 0; i < coalesce->n_rules; i++) {
 		rule = &coalesce->rules[i];
-		if (!rule)
-			continue;
 		for (j = 0; j < rule->n_patterns; j++)
 			kfree(rule->patterns[j].mask);
 		kfree(rule->patterns);
-- 
2.43.5


