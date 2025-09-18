Return-Path: <linux-wireless+bounces-27455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2650B82FE6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090153A6B46
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 05:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BDE28B4E1;
	Thu, 18 Sep 2025 05:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Fa6Ir7vr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB69248883
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172783; cv=none; b=KwY5/uA0kWMq0tVRhGYfTLnDZSOS7ow7haJ2ioR+2USas+WgNWYvSyPMfB9yIFgFmizeKX1rcob9J7gw9PYSQ+qDEgKhHuGlpY3o4we1dWyM4u2kG6/Bo4W/Ko9UVTyCqJREdWqwGQuZN7v4nApOKl3M0iSyDaJpctCdENMBvZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172783; c=relaxed/simple;
	bh=a+5ZQ7b1UblwfF0xA2WA7hKP6Q4ggXKHjIqkna3Q0eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVY2Px2kI3+jcnUKpw823gKIMbQ8hbJfSmKmBSaO6a/VnB7GyBpB0IUDGJ5PeGmpPHUvM3VZNQnoiP60lL904vP2ifVHmrY5aGtBsOCdiph/+G5qpyr+Gd94aZvcugPFhOdwc2oYIXLsgRbOKjedXlgb41TD2nr8Q/peK09ykaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Fa6Ir7vr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-267dff524d1so3761735ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 22:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1758172781; x=1758777581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O39nYyF7u1kbkdg5ynQgPE9wKLyUN6MY0Pbj4r4KNzA=;
        b=Fa6Ir7vr3wfgY1WganWyZO2/NZS+OZOrQZgamyDeeMgJUgq9M2TFTG9hwE/egiLs8U
         4+h/Oy6Ddxc9T0LYC7svqlZrXF2PxX87eHrz35D9euKqJ4JvTf5VUHjdD8BUxXjQ7oLz
         YPdvEDbI3NzeTPO4eBfMnMzXAhf1UucKWAW2JeF9UMeI5jsJmOSdQRk9BGAVDBWDtcH+
         CV02EVRB6Rp2OszjBhfCD63m+sV/T2/jqfN2rD4g7Eymdi7SomsnIVu/eeO9ILVZkVdB
         ZAvjtJS1VutqteetmrZBJfoP1Vgx6HTuIYiso2vQZN+nNFg6Km3Dzob7iXslglY8M36i
         rnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172781; x=1758777581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O39nYyF7u1kbkdg5ynQgPE9wKLyUN6MY0Pbj4r4KNzA=;
        b=tM6jIEUW4X68eyLTauEsESBEtHKswyVlGDyhiGXiDQnK3KrVKJ5MIcyxEIIs6KZ4Le
         v8v9svBdgBxF/PHZqAm6kqhLuXfjjYYHNHsrYE7v/mfHqsp6zFlO9LWTVsnEeLBokkz1
         yVN5XUirn+ap+cu3l5kgoy1NnHpqoZh444bUzML0Vg6y+iWU5w7GMnw59h1nCfVJbiqb
         R4V+Olir6X3xAeHfo7C/Fqld/cB+VWuFc9MVO4uikASp8iS+8bT3JroP84fOYF8O3vN+
         u1fOk+XKOcjUc5mhldxyRLZmeJfov5NovUYgyoqjkiguifbUMaBanfLmvOsLaQVQlgXW
         cweg==
X-Gm-Message-State: AOJu0Yy7p6s6+1xz6zvjgWF5i8Sr4PQ10RQ/xY3yT0nq5J77D0YWd0uN
	D6PHygFWpbUwGRTm5VcrIRsPspdE31z653neZlYOmwVxvqNZgtYTcymUws/WujB2hXc/p5o4Jcv
	wLMhYwss=
X-Gm-Gg: ASbGncsEW2UaaYG34lEZysKuQ9mb7u9VhAvOO6vMZjyY4eMPf0Bth5jfGa9L92fSojR
	K/Llznvp2ZKTr7ABBcWZlZTGMqnTw2qowVBmPwWBy9Qt1jxbjnPYzRdZ4N5mNOF1A7aWSD8Y4Bh
	tgfiyDyoha1PWl4X2+ykCuPmncWz9UIK3NMW/B2LaRlWjhZIrhFhknOpJlNCCrYoXe+DtaCMIzz
	w3Z8ehPzxjexpk6Sc35dUy6wn92Nv6C0uPT85d+dRA81iSV99C/XuPYjpyhx9vwV0DFbeBiUGwc
	UU7gJH2/sHD8rSVJH728uQ+iCd0KosyZ20JbQBXOPzdfautg/rXy77HsJMo6vRMlKxRIr5T0pOQ
	uHCQeL0tQEM5yp9KjPExY03cidaun2TBdTvYkmyx0vh7qByUOcZkwSsP2tz4lm9qTotF/MF+ORr
	qPa0yf3LeFHNyA3nJ934X4zRVzDnwTPDZCzNW8jpNuSxHjLrvl6SQc7LUV
X-Google-Smtp-Source: AGHT+IFRjFXSq8zOZM+tMMgH6HqCSJdxwTJtzSeYdd1o3jPjnnOCB9rONhT77rWyI+73ceT8jtV75w==
X-Received: by 2002:a17:903:990:b0:24c:829a:ee4a with SMTP id d9443c01a7336-268121944femr78693075ad.17.1758172781137;
        Wed, 17 Sep 2025 22:19:41 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698035cd39sm12624465ad.146.2025.09.17.22.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:19:40 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v2 3/3] wifi: cfg80211: remove ieee80211_s1g_channel_width
Date: Thu, 18 Sep 2025 15:19:13 +1000
Message-ID: <20250918051913.500781-4-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
References: <20250918051913.500781-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of proper S1G channel flags, this function is no
longer used. Remove it.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---

v1 -> v2:

1. Remove the function entirely at once

---
 include/net/cfg80211.h | 10 ----------
 net/wireless/util.c    | 27 ---------------------------
 2 files changed, 37 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d25a4ee5dc6e..6b85c0b3579f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6714,16 +6714,6 @@ ieee80211_channel_to_khz(const struct ieee80211_channel *chan)
 	return MHZ_TO_KHZ(chan->center_freq) + chan->freq_offset;
 }
 
-/**
- * ieee80211_s1g_channel_width - get allowed channel width from @chan
- *
- * Only allowed for band NL80211_BAND_S1GHZ
- * @chan: channel
- * Return: The allowed channel width for this center_freq
- */
-enum nl80211_chan_width
-ieee80211_s1g_channel_width(const struct ieee80211_channel *chan);
-
 /**
  * ieee80211_channel_to_freq_khz - convert channel number to frequency
  * @chan: channel number
diff --git a/net/wireless/util.c b/net/wireless/util.c
index d12d49134c88..f26440d18ad3 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -106,33 +106,6 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 }
 EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
 
-enum nl80211_chan_width
-ieee80211_s1g_channel_width(const struct ieee80211_channel *chan)
-{
-	if (WARN_ON(!chan || chan->band != NL80211_BAND_S1GHZ))
-		return NL80211_CHAN_WIDTH_20_NOHT;
-
-	/*S1G defines a single allowed channel width per channel.
-	 * Extract that width here.
-	 */
-	if (chan->flags & IEEE80211_CHAN_1MHZ)
-		return NL80211_CHAN_WIDTH_1;
-	else if (chan->flags & IEEE80211_CHAN_2MHZ)
-		return NL80211_CHAN_WIDTH_2;
-	else if (chan->flags & IEEE80211_CHAN_4MHZ)
-		return NL80211_CHAN_WIDTH_4;
-	else if (chan->flags & IEEE80211_CHAN_8MHZ)
-		return NL80211_CHAN_WIDTH_8;
-	else if (chan->flags & IEEE80211_CHAN_16MHZ)
-		return NL80211_CHAN_WIDTH_16;
-
-	pr_err("unknown channel width for channel at %dKHz?\n",
-	       ieee80211_channel_to_khz(chan));
-
-	return NL80211_CHAN_WIDTH_1;
-}
-EXPORT_SYMBOL(ieee80211_s1g_channel_width);
-
 int ieee80211_freq_khz_to_channel(u32 freq)
 {
 	/* TODO: just handle MHz for now */
-- 
2.43.0


