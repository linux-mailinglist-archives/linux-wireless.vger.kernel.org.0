Return-Path: <linux-wireless+bounces-12324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7F96819D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 10:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3AECB210DF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA920185B60;
	Mon,  2 Sep 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISHlk5P8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297B18594C
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265405; cv=none; b=A/TPoZUGrk0euV7PUjdXs36zuZ7n1cvSFyKjzQtfHk/iOCAE7CEoI5TFO5AtLIObQFs3TpTY4pIlr0rEfeYvp5zg6Bm077cthb92tVYMIS0NrJH8A2zOyi+zqdqGtrMM/YUI3sS2tS+MGTIIh0D8AzJ3hy488SjHPQSyTBayMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265405; c=relaxed/simple;
	bh=qPIxeZEOD4dovDhrHC2sY6UFMp5RJ3kC3B5qL6swqeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JbXPbvPHuPAdCpWIAlVJVCqeNZDTj+u94JFTjt/FSbWztSymDMQRMyOScKNIm1UhPgApDa7QY9xr/iNxQ6vDtILPno+ow/ZMsWeIK3mJy3BqTGM4YMABqDneO3VCxxZa0fYRqTI9w3YB+MFy1Amwn+TzCBmikZV0Pyy/ETAa15c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISHlk5P8; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3dd25b2c3f2so1355337b6e.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2024 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725265403; x=1725870203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdcgNy/o5HaA0dNb1Mq41hwwT7Whz7ZvE8dYWjbJhcc=;
        b=ISHlk5P8We4lEby1EuvPY7HLZ/i4f/C5cDtPXRwymjUR8AqO6/FTCGQTXzFwilwY1R
         Rd0l5U+uc58q+PMcTaX2+uwEPhfwC/CXgRMBy+CBWlJ53AzBQJcjdn0lkr5iBBzrCjAD
         pV8++VEmIpvR9pxosLApYOyhejJGSp0w48BGMEFXwthWFYIbhZQ+P1ncQquTYmTa99AY
         EDtkQoG48/7ilu18PbzBnhpFHaPymmkvKuMq9hO9OgKoIZ7cIbjsPJNX//2TTEfSDvHO
         2Dj4na9eLmkSM/qk2Di8lI40eaN06tOR4ovsakI5eAgGat5ib/5brSlekRVJQWbHe7lc
         jiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265403; x=1725870203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdcgNy/o5HaA0dNb1Mq41hwwT7Whz7ZvE8dYWjbJhcc=;
        b=K0ZH9qwt11gXvijEAT2Ad+ogyHMc2qxZ1ZMB2R9KTygruGsm4c4HRvKP/dODu3lHu8
         RfNFLgifKIMw1BsI7PB5PqwlBEbjc4smoB/K5RcGQlp8kHB8lSAeBDUEwwvWrQmFBgfu
         6Q54sols5XXZdq9ltBZwuuOhEH9plIlWU8o48NB4BGYf8P1Fynm133fGXfFDqAqjcfT2
         vfPdG2ceM5rzF4ta4pwMbFazmtrMWtN9snHfX74QsMlEWb8VYasZ2ZP9uDVZNoh2N7QY
         KRLE6hAZFyMTRTuGivpd91jR2/PYque+E/bkh9HAS2PA3X7pkj09YfGZJluc02aDpEB2
         u1Xg==
X-Gm-Message-State: AOJu0Yx+wl91CUE+hxOb4ShYUNe/tzyMCWWgB32G/Oh9/TO+B8hVns65
	gVuGrjcUQcthTicCQLVb92sSeVf+TMm7ykeRHP7S8rdmLU+asOF4
X-Google-Smtp-Source: AGHT+IEaegdkvxPeksVsQC66jSMAyaxY+Du2j9PUZaikz3YoAa+uyUth7OA9UCrnlq5zZL1GCiwICg==
X-Received: by 2002:a05:6808:11cd:b0:3de:1428:10c7 with SMTP id 5614622812f47-3df05e350e5mr16322756b6e.37.1725265402963;
        Mon, 02 Sep 2024 01:23:22 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e56d8827sm6376370b3a.161.2024.09.02.01.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:23:22 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2 2/4] wireless-regdb: Update regulatory info for Kuwait (KW) for 2022
Date: Mon,  2 Sep 2024 16:23:02 +0800
Message-Id: <20240902082304.52326-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902082304.52326-1-pkshih@gmail.com>
References: <20240902082304.52326-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Kuwait, CITRA (Communication & Information Technology Regulatory Authority)
released Regulations for Wi-Fi service on 2022 [1] via page [2].

 * 2400 - 2483.5 MHz
   - upper limit 100 mW; 10 mW/MHz (adopt 100 mW)
 * 5150 - 5250 MHz
   - upper limit 200 mW; 10 mW/MHz (adopt 200 mW)
 * 5250 - 5350 MHz
   - upper limit 100 mW; 10 mW/MHz
   - DFS
   - TPC is mandatory requirement.
     * Drop limit 3 dBm by EN 302 502. (adopt 100 mW - 3 dBm = 17 dBm)
 * 5470 - 5725 MHz
   - upper limit 500 mW; 50 mW/MHz
   - DFS
   - TPC is mandatory requirement.
     * Drop limit 3 dBm by EN 302 502. (adopt 500 mW - 3 dBm = 24 dBm)
 * 5725 - 5825 MHz
   - upper limit 500 mW; 50 mW/MHz
   - DFS
   - TPC is mandatory requirement.
     * EN 302 502 doesn't give a separate limit.
     * To keep this range, leverage EN 302 502 to drop limit 3 dBm.
       (adopt 500 mW - 3 dBm = 24 dBm)
 * 5925 - 6425 MHz
   - 200 mW
   - indoor only

[1] https://citra.gov.kw/sites/ar/Lists/CITRALaws/Attachments/14/%D8%A7%D9%84%D9%84%D8%A7%D8%A6%D8%AD%D8%A9%20%D8%A7%D9%84%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9%20%D9%84%D8%AE%D8%AF%D9%85%D8%A9%20%D8%A7%D9%84%D9%88%D8%A7%D9%8A%20%D9%81%D8%A7%D9%8A.pdf
[2] https://citra.gov.kw/sites/ar/Pages/CITRALaws.aspx

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - drop limit 3 dBm for 5250 - 5350 MHz, 5470 - 5725 MHz, and
    5725 - 5825 MHz
    (Note: EN 302 502 doesn't give a separate limit for 5.8 GHz. In order
     to keep frequency range of 5725 - 5825 MHz, leverage the limit from
     EN 301 893.)
---
 db.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index ad8dddc9c800..b1dca98f11cf 100644
--- a/db.txt
+++ b/db.txt
@@ -1050,10 +1050,14 @@ country KR: DFS-JP
 	# 60 GHz band channels 1-4
 	(57000 - 66000 @ 2160), (43)
 
+# Source:
+# https://citra.gov.kw/sites/ar/Lists/CITRALaws/Attachments/14/%D8%A7%D9%84%D9%84%D8%A7%D8%A6%D8%AD%D8%A9%20%D8%A7%D9%84%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9%20%D9%84%D8%AE%D8%AF%D9%85%D8%A9%20%D8%A7%D9%84%D9%88%D8%A7%D9%8A%20%D9%81%D8%A7%D9%8A.pdf
 country KW: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5170 - 5250 @ 80), (200 mW), AUTO-BW
+	(5250 - 5350 @ 80), (17), DFS, AUTO-BW
+	(5470 - 5825 @ 160), (24), DFS
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
 country KY: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


