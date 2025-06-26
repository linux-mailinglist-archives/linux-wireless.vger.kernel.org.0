Return-Path: <linux-wireless+bounces-24541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B402AAE9CD8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 13:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669CB7AEB1B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12C4C81;
	Thu, 26 Jun 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="beu6ptYY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331C4A0C
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750938707; cv=none; b=Df/56ydAM/nlO644mfnvlfB+zTHnOVkGdCEiZFzkv849QNec2tE2ff5jw62GFXGzsjVf9g+CLtumbb2PW38FP6tgOh5F4bRX72DbDiW32PxurSAR6C8179mir78t6Q8KCk3hp2QMCNsUWlNcvfkgtUhLmjjebYArNM94ramrboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750938707; c=relaxed/simple;
	bh=Ve6a6Lrkul3gsEVdcCateTQ8ZtoVJPZ7DfOgLHeCnvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKhZYUur5O6e8iDKaGH+tuvuXMFBquqiIhQAt25TIMiRZBgbQfHlP4Z3sLJEyNVqoPVQC8vUbmuMv4/xExtO5RIiVP0xaol2HhIvrr38xH9/xAmMkFTC5jRpPC8biyQD+8nrhMAOQ952BRmtdJPN1gLf/Bnfah8gmgggwvmgwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=beu6ptYY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235f9ea8d08so9214885ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 04:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1750938704; x=1751543504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VRce7iZf0gQl/dbG+87qIJ93X+xngK6NT3WTuA0ya+M=;
        b=beu6ptYYGF/H5TxZFpBHHKFccHz4T5qo2pnyRZ/gX+2kDE7a5Idofh/l8hrxJRrycc
         /ybu8W0pw+I22xKlBPubyx4UKQsokgVlOFOsn5LTV04UL0mR5rNuueYuKOno5dPPbkKb
         Bwksc3k9Xtu/PKRV3hhcPdyhlSRyijpJbv6FL1W0VbvIpWZw/Alrx+Ady94oLGM+xexn
         K182+x/buo2veOgwdT2UI7psAF8gPxqvDWdQekQFAnKKwTcu5UD6rChLwbeI81bp0mLs
         X8+cZsCdMPbU2OO8kXNwR3T5Rdn2r8FSyZAYPi0XK8+bVLyp55XgZvhCaWb5HT97UJft
         0UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750938704; x=1751543504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRce7iZf0gQl/dbG+87qIJ93X+xngK6NT3WTuA0ya+M=;
        b=o3BMv4fiAIDYxqtRu31jnkG0fM3X9S3/N3GxMYjvpvMmfdgC3vCfu/lI1BNlMZ01iA
         xACvhKVsadYySCHCFiPaW+Ro4JYgmytdIccOkPT3V1xVRGPM45HZsKnwwWLZZP4KY2m0
         56icsx2i9h0V3ItGCIp0mrnyeV/kdsSPDsqFLaXoa6ukcxNerBmJxpV+Gt3WSYrytRDx
         SER6g/nZ43C6yy69t2kKVfkumM+Hp9iB41YQsGDxFGYwssfAca9XljYts5j0W/nEloqV
         AGDT9i/cruILMmPDwfxOEKPJmlALYpo+DFO/zXUhIZGTJImwgwnl2pE1RMhEuQWKsaMr
         P8eA==
X-Gm-Message-State: AOJu0YyVO/KA80lNENqHkVHEEf/Sigt0UuItd1j7E3j88I1sD0kn9jWr
	H0NXuCDADt4/YwFy5FDvfBqpAPItljrhwNQbOOCUlaof/2gcCwU/Hq/0hOREoIAqdDA=
X-Gm-Gg: ASbGncso2fBvLksMHLB9mdV/dZEBLiMq4nkOFT2GippSscc4Q+2zIT9Dqmo0wvyu/z/
	6VKN/FcwgSz7ftbJ5kaJKEzAnj9Yjvbwmi4xAKzu6sAJD3g3U2t3FoGL53AfCfkZ+PNGJCd/55W
	3h2MC9rgfoA0pYSlpc8AcLCRP4XOW7NexwuQIJ+n0E0DWVK3B0XQCTN5xqjDkzLLpnLPs59Ab3Q
	+sPizrXc9kRgrnwnuUelng5xOVG1jVBLX/oLr809r9z08HTtqnTuyOiadECYv1HWhe5fSYDl6Kg
	ZVhirF4GegvH5HvizLHEmnFHuvtOWqT9d6hmFSkpOriJaXzxB+LO0bSMpQhrqmriLYrekaxNsUG
	S2taPEesVaXrlcA==
X-Google-Smtp-Source: AGHT+IEtuSJshsImoNvbOKQzqMtFFX4A6m6bho3upfszwThtUB/my/yOkvpQ8AZe0aiJl0HBVllxTQ==
X-Received: by 2002:a17:903:1a0d:b0:234:c65f:6c0f with SMTP id d9443c01a7336-23823f7e593mr77825025ad.8.1750938704433;
        Thu, 26 Jun 2025 04:51:44 -0700 (PDT)
Received: from mma-H9MHD44.lan ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d867c0d9sm153533455ad.177.2025.06.26.04.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 04:51:44 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless] wifi: cfg80211: correctly calculate S1G beacon elements offset during beacon validation
Date: Thu, 26 Jun 2025 21:51:18 +1000
Message-ID: <20250626115118.68660-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

S1G beacons contain fixed length optional fields that precede the
variable length elements, ensure we take this into account when
validating the beacon. This particular case was missed in
1e1f706fc2ce ("wifi: cfg80211/mac80211: correctly parse S1G
beacon optional elements").

Fixes: 1d47f1198d58 ("nl80211: correctly validate S1G beacon head")
Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/wireless/nl80211.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 85f139016da2..fc3efab7c67f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -231,14 +231,17 @@ static int validate_beacon_head(const struct nlattr *attr,
 	const struct ieee80211_mgmt *mgmt = (void *)data;
 	unsigned int fixedlen, hdrlen;
 	bool s1g_bcn;
+	const struct ieee80211_ext *ext;
 
 	if (len < offsetofend(typeof(*mgmt), frame_control))
 		goto err;
 
 	s1g_bcn = ieee80211_is_s1g_beacon(mgmt->frame_control);
 	if (s1g_bcn) {
-		fixedlen = offsetof(struct ieee80211_ext,
-				    u.s1g_beacon.variable);
+		ext = (struct ieee80211_ext *)mgmt;
+		fixedlen =
+			offsetof(struct ieee80211_ext, u.s1g_beacon.variable) +
+			ieee80211_s1g_optional_len(ext->frame_control);
 		hdrlen = offsetof(struct ieee80211_ext, u.s1g_beacon);
 	} else {
 		fixedlen = offsetof(struct ieee80211_mgmt,
-- 
2.43.0


