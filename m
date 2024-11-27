Return-Path: <linux-wireless+bounces-15762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A779DA9FE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 15:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82BB0B21C5D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813F1FF7B0;
	Wed, 27 Nov 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZYl3n3N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33581FF7AD;
	Wed, 27 Nov 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718350; cv=none; b=Sdpk1c7Z6CgFji5mSlNX1/mDNTafVFYntGnuQjYq7zEqf7eVztevyGOGIH2Jsri1+daEIphQ+pCr8EqIrGA6Pm9G3k8nCcmxm7MCI3la1Gir720G2RRQT0HR5jrENJruwJZwXyeXi+sFnuTkahVk/hDF+6/mN1f5wAmrEYbYLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718350; c=relaxed/simple;
	bh=mDQqoxIO5PKh0RoG54oJcz1aIJI+TYXjqYyt/RdxkJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CR1S48xunYDClB2RiWbg5+au9tn4e8R5waV+rFnt33jOMGKQtftaJQGoCWnN63LZdfcxi8soownAOeKId6/xXgOh5qfpz53ysYLbRDUIpxPLMLcddGVgGdWorUjbiDWjBI5yivrDSQ13q9A6dfbC+rKH3oR5Vs31JokLWyudNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZYl3n3N; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-723f37dd76cso6707038b3a.0;
        Wed, 27 Nov 2024 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732718348; x=1733323148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTFIHkewMEaROQgyzcIc2iMfdAKBZdNTPyDszGdNlRo=;
        b=EZYl3n3NXUsEgIuhf3OBJrfZukQh9MVx3RplmCbwHI+Gh0b+JCPGZavBaENyH/prZG
         CwryBcMkBd0qr4xnLjEDZvv9oCNhxmSnzRY8qIOT6wEmQ4H++cmvFmixKqkc81eoFjGu
         R+zQX8Stty7uzGVNif6PW6AQw/OmP7N9FYIHcZqH3Jzf+3fyPjpyQ7V9OhKdaE9e5DTI
         AlbK1aVZ9gh1s/O+C5c+24GNJuLqauLL3oIDFFND3n7wOCXkQ6fbcm0BA7yXCPWNJnin
         l7tmvFUxg2cSvYEh0Fd5A2ADQY6Iwjb48cMGPwWXvaiBMEjKmJFiPNV69rEeQjL0ST1P
         iVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732718348; x=1733323148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTFIHkewMEaROQgyzcIc2iMfdAKBZdNTPyDszGdNlRo=;
        b=LOWSy9Z8cfXtIBmUXxJCgBGHFGnC1l8FUOVYDZGZ57A++FOOOap4b4wWws4Idp/MHN
         HyIRkKY56t5JK9nfj1xVml1ctFhhDOBBzhyfjlotldtJlNi3ELRptJcqxxjAaV4uZFO0
         R/TAzoW+HH6kmzl4PzzopGW39an34OwPZDmHyk8KLacxrgywbpQ/HBigzNzSyz4o9V2i
         w1cl2q5WLwcPViZ2xK9A4meUbybGicvrX2vHqw/JYKK64uZtyR4T7DtU20+5DrJhHSeX
         +ptirDcuML4lt8z/byklDKE4FfHNlne8U9v9x7zbBDtqNOH6EN0JNewbKYJ+z3E1OT2y
         56pA==
X-Forwarded-Encrypted: i=1; AJvYcCUnqfxoEZRy+1+BW9d9NcH0gaJuBCN4LEdHZyGDpKXvEER1AZnb4a8CyoOrfws+so4zrEeH5dKyMOs0XHo=@vger.kernel.org, AJvYcCWfLaP9i1L1Uc5YJW5sw2amipBBJYva9m+XB1HGiEyq83EMFVSTPWkkyFrvnCksBCi4VpuM3pQaRsWVIbqXLgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWK9AW2gSdyKnB+u0desCSD28KZh+GxuAMtHN9B9r1dDDglUlQ
	+5Y0IB2jjz+6sWArHaooEBjc47KpyzQMPMX5DwdXxnGVOMwc3dNC
X-Gm-Gg: ASbGncup0nd/fXQ0uF/T8cmyFHDqAml/66k3tT9VhPJ/2LoJ7dM/m5aw1P9TSfyJhgq
	iFMGGO3f7GwinSyLr3VIp5VPSRhTlA/axTkF50zJ8NeXdsM5l34auaXrI1eKiM+HWajG1qEJ2RG
	WLoqcKB10Nfdz+TsI5a9Ng8v/2KjXj/5s2PC0Nln/J6i9kPHM4Pc4QlfbZUmyAszSghxBrapO52
	YPCY5SDnZifGVuns2Ofe5hmlpla4RPsLUuTJD8bGVRieM6V6ipJy8cYYoY=
X-Google-Smtp-Source: AGHT+IEXUD2cpVkmiuKSnu34vZ5p7LGeLXhOUINW5LByyCy0AAGXpoRkp3T+IjRRZa6bkvRWJ0H7oQ==
X-Received: by 2002:a05:6a00:b81:b0:724:fac6:35f2 with SMTP id d2e1a72fcca58-725300107f4mr3650429b3a.9.1732718347283;
        Wed, 27 Nov 2024 06:39:07 -0800 (PST)
Received: from localhost.localdomain ([223.72.121.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de456472sm10283606b3a.14.2024.11.27.06.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:39:06 -0800 (PST)
From: Baichuan Qi <zghbqbc@gmail.com>
To: markus.elfring@web.de
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zghbqbc@gmail.com
Subject: [PATCH v5] wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe()
Date: Wed, 27 Nov 2024 22:38:04 +0800
Message-Id: <20241127143804.30075-1-zghbqbc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <30b208e0-55a2-400f-9638-1765e7ed3bfa@web.de>
References: <30b208e0-55a2-400f-9638-1765e7ed3bfa@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of `ath11k_ce_rx_post_pipe()` checks for
NON-NULL of either `dest_ring` or `status_ring` using an OR (||).
Both rings, especially `dest_ring`, should be ensured to be
NON-NULL in this function.

If only one of the rings is valid, such as `dest_ring` is NULL
and `status_ring` is NON-NULL, the OR (||) check would not stop
`ath11k_ce_rx_post_pipe()`, the subsequent call to
`ath11k_ce_rx_buf_enqueue_pipe()` will access the NULL pointer,
resulting in a driver crash.

Fix the NON-NULL check by changing the OR (||) to AND (&&),
and return an error code `-EIO` to indicate
`ath11k_ce_rx_post_pipe()` is stopped with an NULL pointer 
error, ensuring that the function only proceeds when both 
`dest_ring` and `status_ring` are NON-NULL.

Link: https://lore.kernel.org/ath11k/a9ccc947-20b2-4322-84e5-c96aaa604e63@web.de
Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Baichuan Qi <zghbqbc@gmail.com>
---
V4 -> V5: add err code in NULL check
V3 -> V4: reorder describe info
V2 -> V3: add Link URL to mailing list archives
V1 -> V2: rewrite commit message and fix tag

 drivers/net/wireless/ath/ath11k/ce.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index e66e86bdec20..223dab928453 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -324,8 +324,10 @@ static int ath11k_ce_rx_post_pipe(struct ath11k_ce_pipe *pipe)
 	dma_addr_t paddr;
 	int ret = 0;
 
-	if (!(pipe->dest_ring || pipe->status_ring))
-		return 0;
+	if (!(pipe->dest_ring && pipe->status_ring)) {
+		ret = -EIO;
+		return ret;
+	}
 
 	spin_lock_bh(&ab->ce.ce_lock);
 	while (pipe->rx_buf_needed) {
-- 
2.34.1


