Return-Path: <linux-wireless+bounces-19111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DEA3AFA4
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 03:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5B33AA3C2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 02:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CB191F77;
	Wed, 19 Feb 2025 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPaEdtO2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB79190072
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932501; cv=none; b=PfZmtc6jiRYs2uhBi7B4mgZB2A7BaJkPq/zJTNRSbl3WAUc/o8tQWb0tpM1C8DnrvA073UfWTeHagbW0JyFyIu9339NF0WJI21riMeOr8Itvv7l4YanPBE/yDd1FYYynq1w9oCadZ+pwOKiM6fHGtZQjU/UAojSpvf5eeZ07PZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932501; c=relaxed/simple;
	bh=KGQUDn/i0DWpUePeRq+aFZd0sqg0K4qnxfWViDGnT54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJhFsNQ2b52vssNStbCvdZTU05IpZS9Pt5Il7dDrYguDEf8SjwdcQ51AKuTFMQfkJtoL4eXSNJIkHuAdAs4BaBquAsuLr+d54F2i2uykQJ9W4O8tLxEzi94sqo0bl8oi19ANXu2FIs8Md9x+C2swRROEWzC7ZnWA5GwHXCAm5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPaEdtO2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220ca204d04so85165185ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 18:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739932500; x=1740537300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0inRTGoZFQ//tUsEqbwi2wHbDhawvluZlxJo4e0ovJg=;
        b=OPaEdtO27fAjrA8mtmyI/QWSIDb+DIIr+n85tq1hbSiqXmSD6JqIqTXWbX6ofxs6yN
         Awys6VhgJQ72OQoSj1ISGySiEWQVHzGhExr3/aWeRLKBDrthFjUR3nJx7w1Kd5Y+S6uu
         eMcu6C/Op/zn9m0qZ4Ld3g/44n06dvmrHUhmwr+bAka2pLZ2EVjM3bpxipdkdlVlyPYV
         bcnT7ecjuTPFLjLaI2I9wNbC+jkmcCR3ZwSipxKDHiGAtkfBsXCi8vETa0YUDAOtJ7yf
         P6nVzr6BBEOHhHpAzc+20ncntftAyWyZ2YY6OysmXKpqNCxlJwSzptNjAa8KV1vQXBuC
         CaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932500; x=1740537300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0inRTGoZFQ//tUsEqbwi2wHbDhawvluZlxJo4e0ovJg=;
        b=rhDGllTexD4LSqdYdybQGmLgyUbU6kCt/AK8uunxGIJBgVcsGj7RHPsLniNxqtJsjj
         gVea9F4slF7DmmScKH9tnjlwn9pPv2s6TdOzUbwxUUcj3czkYy9ttsHMHdkJMfNo2I8v
         K8ta08aDYHf1vtjrUsGU1qmiIaIk64WJly/VOff9JDHtZUEeabfLimGxBXERWeluPbM6
         0x8sBXXFqEvktnZovr0DkFBbLsv4PO7NS5kruEt0+JHdys9t4mJPx1e3Mc/I+E/gmagc
         2U8itkWuN9acxgt3TJNHhrpW+TCjC79UkGMbrcJL8vcJnPH2Dgu/j5cZ9sja4+lVrA8m
         8VmQ==
X-Gm-Message-State: AOJu0YxFvbRFmb+DjuUFMvhrQbVz4d912ha0KezpBACMISFw/Ja8SxVh
	/qQ+Mkf8+yFNVKMXDRTCyhjrtcMGo9kzyRj7R/8XfugyTyptPgJz
X-Gm-Gg: ASbGnct2WWFhCci5Kudi4SwB0EXBhiqiyyI9AmIA175TpybCr2CReES0/SoXOoP7j99
	U0iU+lTWM3QH/vjSJEgI1mf1mZ+KYSnIhSiKLGPjJvmdzTuBHU4TPThlChMn9/Eagx3bwLfw6Vf
	BfeFgSMpD1F/aTqhOZeCXTvp3kkZ96aguZQzh47XPUDfXB2XGZLOWfC9dcRv4FxrkdrY8MpLSaK
	UB10ZEF4IypcDg32PFGFq+H6fTXXZBWCT9p0OSc1WG8VUFA2CziJTRc4lQc+WJSQLdlqQafxoHH
	60vQbCOR13+LenfMobDcrA8kP8UvzFxnk+lYGB8seS0GMW5ZQ7fQ9f90sg==
X-Google-Smtp-Source: AGHT+IFF/h8fx9y+WDvR1AB7qCoK+aUW0j2Aqd9Ec2KJIUuJRUzaHZNlcgNE4Kz3pB/aKgNYSEjDZA==
X-Received: by 2002:a17:902:e5c2:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-22170561bdcmr25291345ad.5.1739932499587;
        Tue, 18 Feb 2025 18:34:59 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d536671asm96837625ad.88.2025.02.18.18.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:34:59 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	johannes@sipsolutions.net,
	mobin@mobintestserver.ir
Subject: [PATCH v3 3/3] wireless-regdb: Update frequency range with NO-INDOOR for Oman (OM)
Date: Wed, 19 Feb 2025 10:34:15 +0800
Message-Id: <20250219023415.14229-3-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219023415.14229-1-pkshih@gmail.com>
References: <20250219023415.14229-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The commit f67f40d00919 ("wireless-regdb: Update regulatory info for Oman (OM)")
describes the range 5725-5850 MHz is outdoor use only, and currently we
can use NO-INDOOR flag. Add the entry accordingly.

* 5725-5850 MHz
  - 2 W max. mean EIRP
  - TPC: FWA systems operating in frequency band 5725-5850 MHz shall
         employ TPC with a range of at least 5 dB.
         (28 dBm Is adopted)
  - Outdoor use only
  - DFS

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3:
 - new introduction by v3
---
 db.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/db.txt b/db.txt
index 7fe673111f62..803f1bc5405f 100644
--- a/db.txt
+++ b/db.txt
@@ -1480,6 +1480,7 @@ country OM: DFS-ETSI
 	(5170 - 5250 @ 80), (200 mW), AUTO-BW
 	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
 	(5470 - 5725 @ 160), (27), DFS
+	(5725 - 5850 @ 80), (28), DFS, NO-INDOOR
 	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
-- 
2.25.1


