Return-Path: <linux-wireless+bounces-26435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEDBB2AD5B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 17:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1522A169739
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC7326D54;
	Mon, 18 Aug 2025 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaNTqPlM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBC322A1C;
	Mon, 18 Aug 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532264; cv=none; b=Izay2ZPwtR6IVJA4variPKgwJ3acT9uYCS3HAabdxATTvgxBa9UBzgbD17kvWaAyUnnRI+dUugJ10toK5u3B/CEseOqihTm2KHYhAVto5Le3/Xct+yVhuFLgFNzTjRM7ozjfB9pv8uKywDCPwWzpPDQO83vbud9e8AzF0MJhHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532264; c=relaxed/simple;
	bh=Mo2LccUagUe1xUANazkGwfXyyJJ+Z1hgR0dGeVhngFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTQSYfc0zgkMpP9vKMQBrv54TFe3/zbJrRo/j/llcdNJthWXZGRLGnJjPKCUZwfAG33hEe5bAf0koI6xdMjYU/xMAxlDXyUWnp7SZbYHYdI8jV8d1JIu3x4DXaVGeDLUJ8M32ywvow86RM1rgGwW+LqLVZwvfSLhB5KiTxXx1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaNTqPlM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce510f4f6so4539480e87.1;
        Mon, 18 Aug 2025 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755532260; x=1756137060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k1k2jfv+LptyryYuraaPe3v8D77u/BoWc5hlQC6Q2Ag=;
        b=EaNTqPlM36xRlt6qQN+3pQhxoWzSgTKtIjFeV81zD9PKcOhJ7RkAlQYX1dEZzX6d11
         wxS1gZ/XpWnijMqmODDcLKsktqPFZGXTCd6PsvD8U41TDrqcdjc58gnXq2SQJJ5L7jKZ
         NxJ9UP7VJrZfpW7EZXI7DbhbWdR+3K06qd3PRulXnXWpbPonfh8o00FUVFZUt5+TRbIi
         FT1kVT7KO7ZXoSavEhbF1n+EM573KfUpp31F+bYKVIm8mOzxzfkybeTGELyho/ds1gA3
         7fH+MccRHVPSfRLEuXdsXfnUcmEo1Rzej7afgrm8Ww9yRK3+gnh7rBK9ulOBUKrxvFmj
         2agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755532260; x=1756137060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1k2jfv+LptyryYuraaPe3v8D77u/BoWc5hlQC6Q2Ag=;
        b=htz6P+/0PjCbJVlL9G9Dn/uxxC2BeITY9bC+U0dXG9lj9BgoTMC203TwWwxLuC2Lkh
         HHsFikpGD4VB0H0eMOoRKYQJ6URhWOcZIgjyj5HSYwzB/+Y3y8TSG6nQat2a9bENLMAd
         YqQDWwLy2JT6XzyzPrKfZOnIVyAmu45vSw/2xoNt+X57PeqOANe5HdzdDdtkEluXcbdW
         B3Y4kgbAX+T3v8HM6BZQDXg6x8stcx4ARDAxhOyYRpkA29mWsNfsXPgJspm1ZQOYaUtZ
         oGK+EIfdhL+fMBoKgV9euyFNMWRht9r1RL4Ob4EHZCD0LrYsWP6/oRraGvFEYUt8kJiH
         vI9w==
X-Forwarded-Encrypted: i=1; AJvYcCUK5VuCoUi34Zg2OF8piFcedZskia25Wcdn804UkpzDaXDlfwuhh0XHkJNqueKGSmMq1CBfW1xExJj5MpXuHEc=@vger.kernel.org, AJvYcCUoN4KXdu/xVetFZYBUl935p0vAVRZ0KNDOyoLVFf7rDSdXyxWY4uZGCPeIgrQffmVET3fkkDpUhguEwmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytO0jjdFaUxVwwZ/fzvU71dTaJNqFFizXrXQiXDREk2x0xPPa/
	+scr+12rHWUu9qZe9TPFZL3boiE/AIPyM06whJb38kaRQXZYmFc86I1o2iS3wXFH6ac=
X-Gm-Gg: ASbGncv0twwlFWKmblaZNMztO1N1nfiR7ttQ50b0AP7/RNFI1c0jdBUX+n0bZr+cajW
	kSJk5T4TGmyCzbtzMJ7pPnbmX3KCNHzduuT+nOEe12H7jDaST3jb9LQ+p2E3v0Dhstc35SMuMJ8
	3e3OucIiYLNVVFODKrtYTtKl2xbykfjaFNmTLHOrtRajYgRtu/mRntNUEW3XjKPCLesPsLZwAqD
	IheRoF9x08jllgqMj2qEd1CsifppSsfunrVjigNHWQ73aPzZMPvdV5XSFvNMdQK2YitO9f5JWIj
	bMw+a64nJJf9oB3jBDlZn6BZ97XJW4c+G0V0DTz2VZ9qZbEWZiG1spE45UwQqLKdQCkz8rdjoHh
	Qvv2Pkoh2NERwgucHc6kSe4lwsBj4p2HC54L4Nq53sKZNDOC3LUhBk0B0Ki0yAGMn5s/US6lz9i
	xJkdPSba0UoDKOlRxwhghF
X-Google-Smtp-Source: AGHT+IF2Q8OElm4cF5e0qgh7ApeOge1RophMUMtEOTLBCEvVf0lwzkkV7zD+z/l9V5F/VLsyU+R4Tw==
X-Received: by 2002:ac2:4c4d:0:b0:55b:8a00:c703 with SMTP id 2adb3069b0e04-55ceeaa196cmr3551845e87.10.1755532260104;
        Mon, 18 Aug 2025 08:51:00 -0700 (PDT)
Received: from uuba.fritz.box (2001-14ba-6e-3100-8b77-edd5-be95-580d.rev.dnainternet.fi. [2001:14ba:6e:3100:8b77:edd5:be95:580d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef45a007sm1710155e87.159.2025.08.18.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 08:50:59 -0700 (PDT)
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
Subject: [PATCH 6.6.y] wifi: mac80211: check basic rates validity in sta_link_apply_parameters
Date: Mon, 18 Aug 2025 18:50:38 +0300
Message-ID: <20250818155039.8529-1-hannelotta@gmail.com>
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

[ Summary of conflict resolutions:
  - The function ieee80211_parse_bitrates() takes channel width as
    its first parameter, and the chandef struct has been refactored
    in kernel version 6.9, in commit
    6092077ad09ce880c61735c314060f0bd79ae4aa so that the width is
    contained in chanreq.oper.width. In kernel version 6.6 the
    width parameter is defined directly in the chandef struct. ]

Fixes: b95eb7f0eee4 ("wifi: cfg80211/mac80211: separate link params from station params")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
Link: https://patch.msgid.link/20250317103139.17625-1-m.lobanov@rosa.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/cfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 3ff7f38394a6..1addfba4b285 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1847,12 +1847,12 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 	}
 
 	if (params->supported_rates &&
-	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(link->conf->chandef.width,
-					 sband, params->supported_rates,
-					 params->supported_rates_len,
-					 &link_sta->pub->supp_rates[sband->band]);
-	}
+	    params->supported_rates_len &&
+	    !ieee80211_parse_bitrates(link->conf->chandef.width,
+				      sband, params->supported_rates,
+				      params->supported_rates_len,
+				      &link_sta->pub->supp_rates[sband->band]))
+		return -EINVAL;
 
 	if (params->ht_capa)
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-- 
2.50.0


