Return-Path: <linux-wireless+bounces-28335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2542C132DF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 07:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02E35E23E6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 06:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD142C21E1;
	Tue, 28 Oct 2025 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="cx0i1lSN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166552C17A3
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632934; cv=none; b=Q+VkFDvo6xJyAMWHsf/jON5f0+6oOPoDe0JPWme8wa97b3rioSnzKEXixLtSkFcGDQwwmugymwY5yiUkCZz8rF+3SekArNjuEcXb5c8gVu8Pa1Xjuu0/LDiRC337okzNlN82rNVWOEIfZ4YzEvgC7EJlqTza5NzeLmnviAjNClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632934; c=relaxed/simple;
	bh=E+Wf7u0x+/17U+NiieuV5frgrCB1kWN/5KGPBvPsMfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Axyn/NPmj1Icu4WK1ovj5U59K2WyXJAzdYMG4coUN1gbd4+7poxF2IZfBUavssn2yNXU7GcmMSvdRPZokltm9NRkxFLnKfqc8hi1rU912VTGNPJvKcAZo/bY1gkBqZ2UPeS6IpORr4vYZIeua/z8RAYwiuaJn3ycrLHuQGSpDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg; spf=pass smtp.mailfrom=ndoo.sg; dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b=cx0i1lSN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b63e5da0fdeso543632a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 23:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1761632932; x=1762237732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir73evyIRDVF112L404qeqtUBiO/cfljmivHcH0fmV0=;
        b=cx0i1lSNFmVHJ93qwsFDjp7A2czvGgDNOmlxYK0uYZ+XOcKBQV+BvtKVCjGBHZpjct
         Hqy7N8/T/tjWHbQTWQyXissnheclS6MFmMKeBgnml8qgpRQhswOb64jwdPqKwOqVPoOC
         AGJ9anUYzaQ8AyNybwNLELJlmkkfSXwa529O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632932; x=1762237732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ir73evyIRDVF112L404qeqtUBiO/cfljmivHcH0fmV0=;
        b=xNJaZExPiBN7bc0YqRVv0UAsQMY1Saov8LpbqBYfiWhxlE92bx5SEZfcN7oKZ6JMao
         jb0PhJQ3uMHAPdo4r3S6RAoyE+9s9XodUaS98IuOnP0oDURzmMF4fz6CkfJRkbPD32EJ
         wSnRCFTgG3l5JvDKbUXqjWOvjzdIOaIcoN43d0fTVaeKPUOi/tGGemyQ60Fqmtp2wQOq
         q/76K4skuBgtx/C7dCAsopeEpBGMI5jgG/S+8q+zIqpvGTrGB3yGsD5pbgMqJpWNmc+E
         auCKyqXjm6wz0FsctleIFNKC33qsYd88JY/BQIJQanLtFwQUVy/LOSv6I76kevwOPxWi
         kcqQ==
X-Gm-Message-State: AOJu0YzuB/rBUGFFP5qu343uIjt04SSjCa6EK8I5zGU4Lg4SrKWc/B8j
	uE3gT+/KDChkDMHDoQ+DAUmr97qtpK3toBql2+nTxSJphDnIWupQHJ+6Hh74vzQhI/yEwiK4W+U
	trpE=
X-Gm-Gg: ASbGnctpS4+3xA12Ega3tSjl38sRBKfyXcPZbYVZb0Aosiv13aLHNu5scEoab+1k/4J
	smLEwcaWyLgHpzANDw1npF++KzTJUKPC2sS0sXOamEpz2KcxYZzCofRYkx869uv7Ubjs/6DI/h2
	9yggfifK5iHL7UzsPqPMKmG0h0FvkFSPcdOrMQccZ3NbO7TUOHHtv33kWkPv6cnDRgGqt7XxqMQ
	f9x906hMTs1GeMTboOKi2ayEXEVMZ59F1ouY/TIJxk0Q+yoEB4REHIRM2/lzzQRMjs1TWK8WWcG
	PZWqMF5y93fRT0LXkfsZqdlSlH4pg4wkbvoxZ6/LqQrZp1Iw9ip6rYC2FtRv1a0wxgrwZmIqZc4
	xXI2WXsfpd8/yHOy0BJ7y6KVIcj3IJ0+odgNjt0kbxQidPaXOe4FWRxADdHWb4hO5eYqK1HiLn1
	N8g5UJrbcrW7R7fukGINsg08DutSi999EAmjIdZiPw3AtMlEeiSmMicTCBQzXCPJEzXdUASwg+t
	LqPo3MtEPLdL2W/
X-Google-Smtp-Source: AGHT+IGKPUZcH3wpBBQ4WcYbADX7gLEdRxi1mFofpl7lids9ns5f4RVp7JNyeHDMn8AquBZTDloDbA==
X-Received: by 2002:a05:6a00:1385:b0:7a2:861d:bfb with SMTP id d2e1a72fcca58-7a441c3be6bmr1656542b3a.7.1761632931968;
        Mon, 27 Oct 2025 23:28:51 -0700 (PDT)
Received: from localhost.localdomain ([121.120.74.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414015724sm10360781b3a.14.2025.10.27.23.28.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:28:51 -0700 (PDT)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Andrew Yong <me@ndoo.sg>
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Malaysia (MY) for 2024
Date: Tue, 28 Oct 2025 14:28:41 +0800
Message-ID: <20251028062841.49216-2-me@ndoo.sg>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028062841.49216-1-me@ndoo.sg>
References: <20251028062841.49216-1-me@ndoo.sg>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malaysia Communications and Multimedia Commission announced CLASS ASSIGNMENT NO. 1 OF 2024[1].

With reference to class assignments on page 10, and Power Spectral Density (PSD) limits on page 20, update the following rules:

2400-2500 MHz: Align previous 2402-2482 MHz rule to class assignment
5150-5250 MHz:
  1. Align previous 5170-5250 MHz rule to class assignment
  2. Mark as NO-OUTDOOR
5250-5350 MHz:
  1. Align previous 5250-5330 MHz rule to class assignment
  2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calculated at 20 MHz channel width
  3. Mark as NO-OUTDOOR
5470-5650 MHz:
  1. Align previous 5490-5650 MHz rule to class assignment
  2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calculated at 20 MHz channel width
5725-5875 MHz: Align previous 5735-5835 MHz rule to class assignment
5925-6425 MHz: Increase EIRP from 200 mW to 250 mW (remains within PSD limit of 12.5 mW/MHz)

[1] https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-No-1-of-2024.pdf

Signed-off-by: Andrew Yong <me@ndoo.sg>
---
 db.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/db.txt b/db.txt
index 1d17271..3df9c41 100644
--- a/db.txt
+++ b/db.txt
@@ -1450,14 +1450,16 @@ country MX: DFS-FCC
 	(5925 - 6425 @ 320), (12), NO-OUTDOOR
 
 # Source:
-# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf
+# https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-No-1-of-2024.pdf
 country MY: DFS-FCC
-	(2402 - 2482 @ 40), (500 mW)
-	(5170 - 5250 @ 80), (1000 mW), AUTO-BW
-	(5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW
-	(5490 - 5650 @ 160), (1000 mW), DFS
-	(5735 - 5835 @ 80), (1000 mW)
-	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
+	(2400 - 2500 @ 40), (500 mW)
+	(5150 - 5250 @ 80), (1000 mW), AUTO-BW, NO-OUTDOOR
+	# 5250 - 5350 MHz regulatory limit is 1000 mW, but 200 mW reaches the PSD limit of 10 mW / MHz at 20 MHz channel width
+	(5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, NO-OUTDOOR
+	# 5470 - 5650 MHz regulatory limit is 1000 mW, but 200 mW reaches the PSD limit of 10 mW / MHz at 20 MHz channel width
+	(5470 - 5650 @ 160), (200 mW), DFS
+	(5725 - 5875 @ 80), (1000 mW)
+	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
 
 # Source:
 # https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
-- 
2.50.1 (Apple Git-155)


