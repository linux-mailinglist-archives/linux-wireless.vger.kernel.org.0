Return-Path: <linux-wireless+bounces-23466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0D2AC63DA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 10:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3A84E1E9B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 08:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726C2690F1;
	Wed, 28 May 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2+4A5Z9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BDB267B87
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419870; cv=none; b=PhP4wETsq9ESMBy7vVZMSUcE/FIf2DYzEsHVpLQq8yN78uPk94GqljrEm6Jo0zujzA4kOMt1uudRWYk4tmbjvWBmVeIxNM2Bql8AFTGAJM/y6TjVLjKApw4i2A6ZqajTyOd3p9k0+nCzHrGuCi4ryPYFg6kU41kh/yuhp5ZiyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419870; c=relaxed/simple;
	bh=7QUgyPQ/T3YEWQ1/2Hr5qFcOiLCYY40HXCZ+In2rM/E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jnOfZEAi+r4YAWtGMZazL6T7GR5kNtd3qFOxKL9fuo4wGLfKDyn+f4RgjxcEBDGIwHNtFtTNKx5o+gFnaca1zDlQZ+uOyZd9lrEyOD28Qv9JyB0iG7WWnSD7ga9+JLk8e0DpGm0ZZGR3b2rNvahd2oaNcyFvojGG/f59hiZ+cDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2+4A5Z9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so33315495e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 01:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748419866; x=1749024666; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFycvXrQUkiOkbhte5Aosw13hGKT4ZnQNkWJE4xdYxY=;
        b=G2+4A5Z9oJpo9pzmKLIPI0tQdP/74hpa1KMgJ3nqG57sn+FxSeS/S/YVDlB5rOE6VA
         Aw5gXJWFK+sadwjkSgPRsJwPxXH8tDyL9ykFTqpCA3ngSBMqjjB/P1eDI3hN6UP4wsKP
         oBjSV0J4XBdKvF4TXfplRX8qPQ56a76JDq6z/U+5XtkWq3De+lVh9w4ULo2VhztQEz7G
         JOQJdVNZ68CJjWVTrimCg6oj96Tt8CiJshkaTYWGrBtp2HHE4YoufdVThTVFkCtENzvC
         Pv+syOXnxz1+BiiVF4UTbP/kZLzYXttimjPijf7WidxR1+tZXlkDEBSg/Pj/WfWyjlJ9
         Bf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748419866; x=1749024666;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFycvXrQUkiOkbhte5Aosw13hGKT4ZnQNkWJE4xdYxY=;
        b=fvhDy3f/pln1DqhA3ttIVmA8FqIY/nxGpa4lrwgCsk779G2fZs/8y4dycE9ya6JCI2
         weyD1Jvxa4vqPHugBXHeBPP2dOU3ix4875Lp1/70ZMFCDSawCMOfPEFhk5ynp+yWRUSJ
         XyD7DDEx6xYcY0Wjb8pGZxq/sdhFhNMJroyAy7YNPYN8yHsuNDd83DikzmNpk1+/zTaA
         H4WJC8BgOZzRQ48/T7Fb7Aqg/jffgGHs0z2oFMjen4udi13zBCqH/djPdpjN31QM6rSW
         Q0nwfdVdCdCsuiG5J6BrWJq7n33tjZl7TOOP4mAcP92I3OeCaG3KpoE6xDcPxvwJbEdh
         73mg==
X-Forwarded-Encrypted: i=1; AJvYcCXGWVzbqLZQStbU2ZVpSp6k8W5+nxgPESej4c6bb5GaK1TUFQoY6j/vD0wUQiv+RyL5in/zss9vFIT3Yvcwuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxavD5dzc45BKEKTm7cEwJA/FcqAKFbLs00fg2JWvkYWnZFN6
	+Z4KrnaghqulTl6Sr0Guq8CFKNlvgDbdUpjD47EYQXRn3Sm3eHhPkzdFA1iqc3ZXb08=
X-Gm-Gg: ASbGncs5xgcbKv0p/gaITVGmGq202bt1LWfEZSR8FPuu+6eJqvmg5ComxhO9d5WT3cR
	S0IZGNT8+Fod/IpK1Jlizfnr5A03yMnsf3tgazMpBiLSISADJ4lpTwyc9K1UcpnfzDnQ2WWc6dX
	iWR3EaN/fB06HDTer1GsjndyWyx8gjCWSIBg8Fkg5i+q/zR6qQcnyiEqfUPuxwlbDNrReWnCfhW
	ZYvl+gG+GhPow3dGDCHtGubqSK7hUy4cfTEFk4DabAOdPvtKRGOHyz+/e+DCnThY60WpE89tRxO
	8PyzIacPf91b3PLGUiS3dUbzh+fdYtRDK7oK8hkn8MEMtz0B+PHKBpkf
X-Google-Smtp-Source: AGHT+IHX4I0n+ZPz2LAonQ+C7wF0g3TSvB1a1pGhyeywpD5kz73HeVr28IbZeV7RGlLkbc8tETsEvQ==
X-Received: by 2002:a05:600c:511f:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-44c919e13d2mr163530375e9.10.1748419865922;
        Wed, 28 May 2025 01:11:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450787cc3c5sm9406215e9.31.2025.05.28.01.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:11:05 -0700 (PDT)
Date: Wed, 28 May 2025 11:11:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 next] wifi: rtw89: mcc: prevent shift wrapping in
 rtw89_core_mlsr_switch()
Message-ID: <aDbFFkX09K7FrL9h@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "link_id" value comes from the user via debugfs.  If it's larger
than BITS_PER_LONG then that would result in shift wrapping and
potentially an out of bounds access later.  In fact, we can limit it
to IEEE80211_MLD_MAX_NUM_LINKS (15).

Fortunately, only root can write to debugfs files so the security
impact is minimal.

Fixes: 9dd85e739ce0 ("wifi: rtw89: debug: add mlo_mode dbgfs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Use IEEE80211_MLD_MAX_NUM_LINKS as a limit instead of BITS_PER_LONG.
It's stricter and also more informative.

 drivers/net/wireless/realtek/rtw89/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 49447668cbf3..3604a8e15df0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5239,7 +5239,8 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	if (unlikely(!ieee80211_vif_is_mld(vif)))
 		return -EOPNOTSUPP;
 
-	if (unlikely(!(usable_links & BIT(link_id)))) {
+	if (unlikely(link_id >= IEEE80211_MLD_MAX_NUM_LINKS ||
+		     !(usable_links & BIT(link_id)))) {
 		rtw89_warn(rtwdev, "%s: link id %u is not usable\n", __func__,
 			   link_id);
 		return -ENOLINK;
-- 
2.47.2


