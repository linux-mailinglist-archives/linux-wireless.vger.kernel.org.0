Return-Path: <linux-wireless+bounces-27148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA9FB4A498
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE001B20F49
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202624EA81;
	Tue,  9 Sep 2025 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="qN+U+n5K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500F2459D7
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405305; cv=none; b=WnHeTrBXlV476XGE0ksU4WI3/wD7udOJwApKrgw1en/pjj8AW6y4B5Aw8NDkIKPyFLv7UmR7inm/we78inoSplDBpfaLCLAEn6VQQkGdmLtskyOm/ZbwS3ZjR+AXpX5KRsCg6Au61PGv6sQg1iRoPQazptR0GWmZnetIq0NAPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405305; c=relaxed/simple;
	bh=nQ4FNtZurSM7YLE5YRuVEbCfq+H9LiEAAH6jWA8woBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dllD2qOKsmfZozm0sDZCjtjEabw+emDs7GMn65htyNmCtxoqDOyNzRf9XcTEGnrJFks9X5+p7ZJzE2lrkpiecTWt0UMBuK96DkCep/uk2uknoS50vexZVd8Hka5Dc39roKikz4LMwNT8jXwpelQ2eSEF6RI9K3yFjFCShARK66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=qN+U+n5K; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-25634c5ebdeso21338325ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1757405302; x=1758010102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5jCDfmaYq/OGxSmosMnwYk9TIRtcqPKYesfSS/NWvY=;
        b=qN+U+n5K2PaEFmLgG1EvEyuS8kZ9vAAf0Zx++t82Vh9yXa2YL3fpS409Bl/17DCHWE
         3Q1hZ1DDg7R45XJ4p+Pafp3Wn+Z1eoi8tR3a6yoBQbNlHSgpLkovqG4PCR7506E36M6s
         z7Wq++dXwZjgHJO0wzfrUXLQvDoY8rYCCbrWZZJOZw+aOv1cW4kO4dnhT78qNng0HwWV
         anmvQKq5v+q3AgOTebbEHsUPBDBSThhNZ1LxvorkKvW3n3OhHAfjMNdqNYHWFIqJQeeS
         OPb+a+0npH72MUev/el4LesKEn91WnukeulHX8HZfQwzzc46WayzE5gkYUxLwPmKCZGc
         eOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405302; x=1758010102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5jCDfmaYq/OGxSmosMnwYk9TIRtcqPKYesfSS/NWvY=;
        b=uYtvz1tQYEj3k1XA4KfRMKhx27fIjB7Z4o2oTOgPIS9/E0DPigMYgGrfOntu/aONCQ
         zb4yT7aZLk23FoOZAcHJ5XmRjJomlHWa8BxCt/K4pQZRlWF44ktWlSJuxiOBRxA1hHee
         TPYNAdTAxDBgE3GwARyYlRILkuS5QtfgtwdsUqdvxrx3U4VF6+tXtKcXVNq+ydrp9wLe
         rCF+FwHuRcAkzbYNVhVE7CbfVPd3Ep3kooL5sAVWLE8d8RLE1F9NyGqVrLXBpIAwWRbm
         ctu5yQAElST2e35HnBbiMQREnknL8Pm5CsNaPOoYcuign9bRpxvOdblXqAHIurlLFiNh
         6rRQ==
X-Gm-Message-State: AOJu0Yzn2P252D16xTGeHmwtGk/BuSBVrcfRAj6bb8r00FFL7Z1qDBX6
	NluiLg7j1zNFF2rkPXai4UDP7i4iUIyeXHEy5iH3WQ01GiBD2kL4a42k/SZnGLjDEAs=
X-Gm-Gg: ASbGncvc5GmqNntEZnaa0KaFJySCv5thktQJGoSrAEpayEBQUgvmkl5I562SjehPbL9
	UKHziuijZaxtYi7wqgmal+bArMVO66aCcHoSQpaSxlNdmLgT0qM3mjR3SSLnXJMkt4//VU50OBX
	2GLKPhoIjRR40/Wk9omSlBx5yTbv0jxeQXtvLVU5PoryD1WUETbs9fBIWtTkt2RwxMX1309+YUh
	jy4QJ/IeCjZhguzlgnVIvQ2wnZxn0SsHovprBfezCgnu3eXlprbYVp6y8Bt4g3gaKREn/PKNzy0
	8s0wm74FfceeDCuYeh9odlz2J9DrVxOI01hLDpuMvRQsbCRF9ltugmFWo0X5OGRPfQ4G3ea0PNi
	Tjd8+U7uSGHf3GIdYJ75jHW8/Dmi3uVHP0R0ivSZiSoQcWUVyJVnbt3p1Fbmx1Pj3ClOxF0Rpnd
	i0GlDTqmX2BkvllMNJBOncGVh8EiAK7E86fLGWng==
X-Google-Smtp-Source: AGHT+IH1hQkp68eQSaoOCLOD5pT2ZN4yKjrY0HTjjfX/YeaKJQNXjRM61A8ZL3qh7CVSEu8z30KV7w==
X-Received: by 2002:a17:903:1a6b:b0:252:3350:75c with SMTP id d9443c01a7336-252336e8c57mr118833135ad.53.1757405301811;
        Tue, 09 Sep 2025 01:08:21 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28e33d7sm148882995ad.89.2025.09.09.01.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:08:21 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [RFC wireless-next 3/3] wifi: cfg80211: remove ieee80211_s1g_channel_width
Date: Tue,  9 Sep 2025 18:07:50 +1000
Message-ID: <20250909080758.1004956-4-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
References: <20250909080758.1004956-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of proper S1G channel flags, this function is no
longer user. Remove it.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 include/net/cfg80211.h | 10 ----------
 net/wireless/util.c    |  7 -------
 2 files changed, 17 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1dccfaa11e26..668609d6d8ad 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6702,16 +6702,6 @@ ieee80211_channel_to_khz(const struct ieee80211_channel *chan)
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
index 2087d9d8afaf..f26440d18ad3 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -106,13 +106,6 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 }
 EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
 
-enum nl80211_chan_width
-ieee80211_s1g_channel_width(const struct ieee80211_channel *chan)
-{
-	return NL80211_CHAN_WIDTH_20_NOHT;
-}
-EXPORT_SYMBOL(ieee80211_s1g_channel_width);
-
 int ieee80211_freq_khz_to_channel(u32 freq)
 {
 	/* TODO: just handle MHz for now */
-- 
2.43.0


