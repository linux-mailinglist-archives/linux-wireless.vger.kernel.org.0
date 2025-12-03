Return-Path: <linux-wireless+bounces-29472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC08C9ED29
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 12:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16600347CE0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 11:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F762F362B;
	Wed,  3 Dec 2025 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFrm2sag"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AE2F291D
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764760495; cv=none; b=Y9KftFkBGHTHML/XF2YqbglCQy1//uVdLtao6OA57vrm+Zv8vhZnlJgN7Tg/KknQhgqYPElB0sI3oMMxYlGKCzXa1MrSMNMbLczn2EQhr+9SRe6AY4qgZQun5uQPnrmhjnq6fAqxi9Cw9hnknWlmzaAWSONbhF19b0DoSFdaJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764760495; c=relaxed/simple;
	bh=FVTaTUHkj0hCiF/8oDz0IRLJk2VFfDYMXcQ5TgtXHuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aD/0RHYW3f82uPJNSaaCRPFNVIMqLYqT1+IE6ZvFZ3ddsl4l14a5qV/ayhRYHjWQ+1k7TJmmJ+gHWkIa8lmGnLUo99TDJhRuEIZQFWA9reO4GJo6Xkqfdi+gVspViLo8yQ3XD3Gx8wnV4Eqnw2As65+2nNUy8FeE7hObbRyL8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFrm2sag; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso5614895e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 03:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764760491; x=1765365291; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQuU8GXO4td5lpFMJSEuUSNKl2naOb+LA1iRC4+QgDE=;
        b=kFrm2sagbDxhNjqHenQQgXdwOYRol2V95Ma+rx8SCQzHc99psuBEwzuACRECl/sLno
         hTqt/p0bolW+OY9i3PqVGG56Kl56WufaDzGuw7aIoDVBez6BFH4VoGP/6poWeMv76LXS
         /VYYwmx5GZm7e5aTZ4bD/wCTvoSrdVkx8M+91eNmqhBs6jcNOXYnnyWBUFuzSu4/9e67
         1wugbaTd8T+/KLARBOP9GUyOies7G7jPdFAoDqEyxGnmKH3isvO7MrfSRm6Sbj0B/oQC
         nXVa2ceYrxmzPhfFmcIr2YXd9/20+s1H5Jsw22LnrzuvtRL+GerDzzMDo5LCC6vfecDZ
         gAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764760491; x=1765365291;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQuU8GXO4td5lpFMJSEuUSNKl2naOb+LA1iRC4+QgDE=;
        b=Vd08RNX7Bxy0vcclYcRJlw/BecN0FOqOl+XuwwH6qhDfbudCn8HI/x+Z63c6t/w/eS
         lD4YH54P7iiZ6yRk1GlOgz8gciYKi1vXddh/YaCAMMEFLm6OQPsLgNKQtfuhjJq7Tgm+
         Nrn/h8DRbZE90PgjwIeeUqVk2R+h+9DKNhoj5m3OjXw1898KDEoRiQ7zIa/E7H4y2MZs
         XD9V/gmY6snpXmpiWowLNlM0T51OlegGkMSFPGuxf/u1Ekd1EyInBCX7KrE3i8kFZocm
         9rsXbftzUAwjkvAJ9FbcnNw/oHvIToSokVUHljR5deLXzDAH6xJYZlGqDypbYsVnS5uN
         pihQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM1R9P9ufS1VWAkMcrLOoOZysA9RtpJa4+u9N21KLTmNavb80vhU63PsTjoKxvfVZs6run6Kq0MahC1pUZGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wei9FUQy5jQd1hQszN8bHY8PugKVTZKVhTqySDKFeLXvtNtA
	BYwYLPfTS/fWsaaW4Y6PksGowcDbT1+gFmJpbtIEWgV/Ex6KlVkukEDW6KI6RHvIHj0=
X-Gm-Gg: ASbGncv6boZap2ovovXQAsQaQKj+SO1OWU+rlU51XTduBnjelEj1OWa5qVLUwLFgqIC
	K31dJAXt4+HNI1lcVrsKJqnvkp09vmME1v6SaXDizrCiv2bgr9G2csDxry+gL9WtSpeLRFYyY0I
	Dhi69+4j8ccMj6XYQiaIPmSAItqTCA07/b99RrKgdnwRB+m9oVR25BfkI6bDNXI+W3yUpMRRrON
	ZxC4Wy76OmzX4myOXljTr18uic9aM8DKgcCm/QdM52QwCetZdS3y/dV41K1ZT9NcTA5X5x7AXkZ
	YvxJK/DEoD469RfLMzgG1dn4r9UDHfjwhH2LsgzOF4DbmmgVhslFlAUbNzciDFP4Tdg2nFzGGPy
	LOrpqNLML9XZJhLhIXD1Za5gERcFMIQKKKMg2X90xqsIrfLYdc+IYRlEfeKf1fUDeCHmPN+1FzP
	6Og49hFRXGkrP7u9i7
X-Google-Smtp-Source: AGHT+IFvxMW0hrVy7sS2LWr2Mu2vPFg5Y67EUhHisjMmxypFuUsGFVIcK/2jhTXExouZzHZBW8uIaw==
X-Received: by 2002:a05:600c:4fcc:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-4792aeed1b5mr21815965e9.5.1764760491023;
        Wed, 03 Dec 2025 03:14:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4792a79ed9asm41687785e9.6.2025.12.03.03.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:14:50 -0800 (PST)
Date: Wed, 3 Dec 2025 14:14:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: qgeniecore@qualcomm.com
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: sme: store capped length in
 __cfg80211_connect_result()
Message-ID: <aTAbp5RleyH_lnZE@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The QGenie AI code review tool says we should store the capped length to
wdev->u.client.ssid_len.  The AI is correct.

Fixes: 62b635dcd69c ("wifi: cfg80211: sme: cap SSID length in __cfg80211_connect_result()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/wireless/sme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 3a028ff287fb..4e629ca305bc 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -910,7 +910,7 @@ void __cfg80211_connect_result(struct net_device *dev,
 
 			ssid_len = min(ssid->datalen, IEEE80211_MAX_SSID_LEN);
 			memcpy(wdev->u.client.ssid, ssid->data, ssid_len);
-			wdev->u.client.ssid_len = ssid->datalen;
+			wdev->u.client.ssid_len = ssid_len;
 			break;
 		}
 		rcu_read_unlock();
-- 
2.51.0


