Return-Path: <linux-wireless+bounces-26555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1068BB30EBC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 08:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D465E67EE
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 06:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F02E2833;
	Fri, 22 Aug 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="vkB4LW6e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC1289378
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843635; cv=none; b=H/NED5rZAIZtFbeMZp7kIIODdCyQ0xePV41fPtCEXjxcAowpokpy3BzFCUjfOYB8ZoBw+zzH2P8v3eioOW1fTU6h6sX5CHPyQRKkLHaySZwDxNuyeF4rl1pYndALA7r/jJYyE3QCfOBTE4jFUdUfMAtugeaAyJZ0RpJgC5Tbofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843635; c=relaxed/simple;
	bh=c74G+vAKpb93guTMwviyWeA7Ao1FPUob5QghxZOr8N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxBaSTwkP02U7Mmg0cZIH8BabjWcEQC4bqd0IchevBMPuFwJJc2h5p2w6bv15tKrA+juNv/8L6lNhag189/FUg1y+3CcUdSm5Ed6iT5I2Jzkq82KWaHom3n1rWUA1FfmwT9+lRzPG+jnp16NAnlmmmHLQV9j3u7W2vu0MejTXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=vkB4LW6e; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2461864f7f8so11226865ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1755843632; x=1756448432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gl50YzfGup4iTTK7GgVvZZFfWzEGPGfTo/BGu4hHvog=;
        b=vkB4LW6e4ADDULVsWdoj/lgOTl2SrcUZ4YBjzDoUjcmDWQVs5jWDq21rJsgltn+t3A
         5z6f4Hm1fC8eVn/yDqfuaRI/m7lF7tTJWT7pSB8AZRJ5wNAlWpbd73uLAUDO7edyF7zF
         bqjBq7tkwRzvVlS1EWNlWFqCoN8YgEwuOYkNF02/dJ/dlOlwp9UkmmKdhkOd5JmEYnGX
         YXFpY1arT9POkz18cWLic7NPMbqZlGovsRvgKFDI89EAoPuLSQO9lY2/yfJOKiQzQHnx
         uV9X3xBbaqkQJK2VSIYoF9mOdXk3vELbMW8G+l3WyNQkeTH9JZy+ft3JieX3LHn01sDZ
         y3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843632; x=1756448432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gl50YzfGup4iTTK7GgVvZZFfWzEGPGfTo/BGu4hHvog=;
        b=FOVdmHdquUUvapxCBzfxeTWalNnq4UbMqTt0iwxkuwKAqje+CSAdj1CLjVffve18FM
         GlEdtHSxGuOKp3Sc+WO8KEy862c1OFSuXjvDfv2JiYoH6gl1vVTIifooe9Y9MS8857aU
         NfiMAQ7vt0M8OxEGXfJ6P0AcIBckMqrAtJpBf3NvkoYi491DfSD3WbmqQ+wAba+L1k9x
         aT0nshAZ1cgzr65lg8/aVTvdToHUD+eO96yG3MWYTftWji08Tch4NyhtPkx39wBjMbU3
         65E0jOQsiCmrrud5cSuFt0IVlzgBhY4qHjnFLX0Fm4FLOJSzJdD3Db3vh1zu8xXChcd7
         VJTg==
X-Gm-Message-State: AOJu0Yz6KY7xmXLsx062U2OyG1XpgEHKAnjGIQDmd9AtOz1G1D/b5qhi
	EbBI09qQXA9o3apc4EajmcnHDgDc5/Lz/XaoBt54u9n4o/CIuGQUq7qXwz0nX132Wxr6P5w7767
	2y5Gx
X-Gm-Gg: ASbGnctK5Z/zosmvWuKFLUOSCq4d801EDqCYX0E0OdvA51BoN5fm+y/4xyMu/qpGwJX
	gG/xIrIXBTCkVKsOu/GNXtXpJvDOzXgj7s2ATY9r49g3REmIh3WSiE+1raMbSN0+DK0RA5aqxgJ
	hgA8iaLPZHQtfMJfHqE0sI7sQszi0zBWYCnb4ekkjiUNn6JyF6klWBl8wq9xjLPQj1FFmwuI4RP
	GdUuqgNFE+UN/4E6xS/Zf+j9vDy69x2F7PU6TW2VqtB7w1onwcN+EqHx9wnuNNCBryZdw7MukA3
	dreFvndqttul4AL3nklgKQYUEMyyQwqaYwLGcs8e5JM2hZrqqxKBsVG9je4dol3jND+lavsAnwS
	+FUWH5Fb6KM7Lknh2AbMKZxsfMQkfbH2ii7t5WVzkN9lx1EeyJvDhTuH9e6NrTj25U2pPRepSmH
	DYWrd/HI1dbJiOTkRR8vRl4jM9SlKcZc7rj23Pyg==
X-Google-Smtp-Source: AGHT+IG5ZRpQl/cwVJjGPRJIErBJmEsYKsovxjPyzE1mnYUHdpqgHtWVB0BvoaVub1p5as271ZC7xg==
X-Received: by 2002:a17:902:720a:b0:246:61c:a67c with SMTP id d9443c01a7336-2462efd6233mr21015785ad.59.1755843632342;
        Thu, 21 Aug 2025 23:20:32 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4cce65sm73005245ad.74.2025.08.21.23.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:20:31 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless] wifi: mac80211: increase scan_ies_len for S1G
Date: Fri, 22 Aug 2025 16:20:20 +1000
Message-ID: <20250822062020.904196-1-lachlan.hodges@morsemicro.com>
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
__ieee80211_start_scan(), prevent hw scanning from functioning.
To fix ensure we accommodate for the S1G capability length.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---

The bot will complain about no Fixes: line, but I think it is
technically a bug since it will WARN.. ultimately depends
what you think.

---
 net/mac80211/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 9c8f18b258a6..384937fb19d6 100644
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
@@ -1274,6 +1274,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			max_bitrates = sband->n_bitrates;
 		supp_ht = supp_ht || sband->ht_cap.ht_supported;
 		supp_vht = supp_vht || sband->vht_cap.vht_supported;
+		supp_s1g = supp_s1g || sband->s1g_cap.s1g;
 
 		for_each_sband_iftype_data(sband, i, iftd) {
 			u8 he_40_mhz_cap;
@@ -1406,6 +1407,9 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
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


