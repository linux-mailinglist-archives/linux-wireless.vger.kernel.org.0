Return-Path: <linux-wireless+bounces-26600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80FB3506B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 02:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FCD3B3A06
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871961E51FA;
	Tue, 26 Aug 2025 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ALbSh1wP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E618253355
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168959; cv=none; b=qWgOV57udFUWjcr1BWZVG8hX7OnVJzEQ8jIns0hY/cfqfsOnAiOjeaA44AiYlxkkdWzoY0tJwicFDeEoEZgbmbN4jxg9ZKyDLWdHz8Ld19pcqUHcBETuu83B+6P8KGzibI66J34K61Gwm2ooGjB+IlLPgDxHqnc4f/v2ci0P99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168959; c=relaxed/simple;
	bh=OCN70bHDBV8cGIOwE+S1zjgmmo62Su2gKoLrfKvw994=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4755CZkraEGLRw9TKHwmK6KIQqJq5HxSI8pvR1vN4JkphwhDZKqgc+bm/KWOpyiJMnOA3Pke4JZXwrWzDrQsTmF+cgKtWD//KtJTZ1yU4Y/AWnL0xvlxb6RDoE1wTHbb0Y2HkDCCyGaUTtAOC/UX5C1qi4WXH25mKEaLVMS0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ALbSh1wP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-771e4378263so1298825b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1756168957; x=1756773757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFHNv/IFnNiJH0GMVK6BxV/ZFN+wKdQbSCU9eXdcYbk=;
        b=ALbSh1wP9iVUwT2zRqLBP0QuK00HvXsrm+/mu4maA77WtnZx9RMt64lT1hnIMdfVXQ
         aVpMX0YRLZ/hG4qMD7rDwml0htDS3w6QQCCvWorFhRAzHCcab7AbHSYRbzK+PcAOXOCY
         YertLDwmrES7z8ZPOJjkLPIW2A8wzTvtATQjBjljyrjeyfMbbTi728+01qxpWZlWquAI
         zzJr1Izmz0P6aa8hSKuVPzR+vEyD6qsIX7SJyziyITK/6d2K5CMPGbWD/5sSsQr6rFyW
         sLTdJu+ICGm4jldYrjpZWjwzZv1swJwzpKJf2IzWK+kxSF0hYH2IwojF8hWDUd3k2Oh6
         cGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168957; x=1756773757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFHNv/IFnNiJH0GMVK6BxV/ZFN+wKdQbSCU9eXdcYbk=;
        b=qdAXl559k0AxzHPOM0KsSG120tthIUgPeplJgD4jDSl21XvYkZoYQudmqV8W1Ne2Rg
         s0ENyv0FHyrDEVwteYlOEfVOhMiR9wGYoJpIlXvs8tN9fN1nIbDFwwBwTbDRfbq16VgN
         VVWQ8dLXWT7u8bLcBHhHvVLoSiwOabfx2bv6RAeJn64u03kw+Z6CyjjyO4d6RXJcdUoJ
         ptO9A/iSkH6ZKd7VltpVhZd9YHhoLQfXVh4m0DLlBZ3KBuaPpSaNRpBNW/XBjhBjMtOa
         6e/uvLC7sDbNy/RRwvgfvGJQdaKU+nXYuLMaJy5eJ5UobS0/NNntqmgiztUuukpUJ7dB
         LlSQ==
X-Gm-Message-State: AOJu0YydzuzAOB95mQm68PO7EqAbnJQKYlw8D9BfQ83tZgZ8yfU3tXlL
	kAZsbaD9EgGWM05xrcqyXwiGL9Jyr0F/dzYkDBYKMr/ogVuwmW7Qwv0ND8YkuOWJfk4=
X-Gm-Gg: ASbGncuEfmBSUCVX0p3TukFe/2KSjymLSVb65436Zy8PsBKJUmgaTGlAvQLMmvfXEH4
	lTIF0Y2B+Kga8aBNgZwfUjC7y8U/4gOOOxir28f9r7RlZsNVJlwPeFss4jqbcOLGw8ak1VL31ZZ
	hUq1aUhovJqOFDMUQKKtWWsNDvpGjLBEvsAMsyN3SXL9DR4280/+rlxhA9kxCoMZaiYhp5fEAp9
	cMp2vqXYDZFAHbG4Jrx0YjWZ9JkBofOXJlRgLerQ80vEO8fBeskK1K0V9znL5+PcspQOxSt+n4v
	kZ4WChRWOs/f7BhnTIE7tjgl76LJxWcdA2uQkjdu4pW1QsrOa9lmVsGdyOf2Dqg1ylnyuFGyEe8
	wPVODQDYbemMfsyN8Oa0zccdF4zDVrJ9dDrRIXQiii+oa/q1QN+61hXYhVPgbppMNontVFODhK4
	vbIM1fiU6oUe7NYx2TLCoWDGEQnG4=
X-Google-Smtp-Source: AGHT+IHQQMwNOYvdw11PvPvRVpEhRBN2VbFgVLbCx25r3VtlXU2Hx7vi4CpD+66pUQ4GORGDz7t51Q==
X-Received: by 2002:a05:6a00:2e92:b0:770:cde2:d18a with SMTP id d2e1a72fcca58-770cde2d2famr7354035b3a.12.1756168956783;
        Mon, 25 Aug 2025 17:42:36 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb4742sm8825475b3a.5.2025.08.25.17.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 17:42:36 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH wireless v2] wifi: mac80211: increase scan_ies_len for S1G
Date: Tue, 26 Aug 2025 10:42:29 +1000
Message-ID: <20250826004229.16372-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the S1G capability element is not taken into account
for the scan_ies_len, which leads to a buffer length validation
failure in ieee80211_prep_hw_scan() and subsequent WARN in
__ieee80211_start_scan(). This prevents hw scanning from functioning.
To fix ensure we accommodate for the S1G capability length.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202508251233.r1IFboEm-lkp@intel.com/
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
v1 -> v2: initialise supp_s1g

Again, targetted wireless.. but not really sure if this qualifies
as a "bug"... I gave my reasoning in the reply to the first patch:

https://lore.kernel.org/linux-wireless/3j7kkqznavkxt23iopacl626xkppzcitiactxz43axqorucrvu@6gaixffy7zaj/
---
 net/mac80211/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 9c8f18b258a6..3ae6104e5cb2 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1111,7 +1111,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	int result, i;
 	enum nl80211_band band;
 	int channels, max_bitrates;
-	bool supp_ht, supp_vht, supp_he, supp_eht;
+	bool supp_ht, supp_vht, supp_he, supp_eht, supp_s1g;
 	struct cfg80211_chan_def dflt_chandef = {};
 
 	if (ieee80211_hw_check(hw, QUEUE_CONTROL) &&
@@ -1227,6 +1227,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	supp_vht = false;
 	supp_he = false;
 	supp_eht = false;
+	supp_s1g = false;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		const struct ieee80211_sband_iftype_data *iftd;
 		struct ieee80211_supported_band *sband;
@@ -1274,6 +1275,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			max_bitrates = sband->n_bitrates;
 		supp_ht = supp_ht || sband->ht_cap.ht_supported;
 		supp_vht = supp_vht || sband->vht_cap.vht_supported;
+		supp_s1g = supp_s1g || sband->s1g_cap.s1g;
 
 		for_each_sband_iftype_data(sband, i, iftd) {
 			u8 he_40_mhz_cap;
@@ -1406,6 +1408,9 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		local->scan_ies_len +=
 			2 + sizeof(struct ieee80211_vht_cap);
 
+	if (supp_s1g)
+		local->scan_ies_len += 2 + sizeof(struct ieee80211_s1g_cap);
+
 	/*
 	 * HE cap element is variable in size - set len to allow max size */
 	if (supp_he) {
-- 
2.43.0


