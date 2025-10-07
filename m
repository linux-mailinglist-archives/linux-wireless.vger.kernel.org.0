Return-Path: <linux-wireless+bounces-27866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60735BC2EB1
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 01:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4348D19A07E2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8817F4A23;
	Tue,  7 Oct 2025 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFcnKzkP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF72C9D
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878303; cv=none; b=Le4e2cOpV4tCBSIJvA3StRmy43wvtI+LEISH1veMaoQYXmtJffLeBttvuzsqxqR0t09Eo6r0+E3u8Xv2JjslGlhD/6sjoLpleFmnFb1Ic2cDAekUKP1uErVsM3fgxBlWr1Dln6S9WrQpltHXamXDDPDeOJodhJ7CHnVbsNqf+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878303; c=relaxed/simple;
	bh=rfBiSupUkgpYT7D6/wSMlkh3EDRkRCguaZumtXVjJ5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4FNasS1kw5L6u3JQRi4CbqsSJQk5UX6SuPeiShZeSvYjbkdDvrJUGg3TcwShLzP0/j6jlC8xHGoe50C528lDdQDOxBuDr+Dk1yT+IcdqWOs6m3h4KTp75UQ3YeuABCv7RRX3J5IYcuncRBQaUj1IW2aroDGscJSCww/E0bRM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFcnKzkP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781997d195aso4486092b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759878301; x=1760483101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iErhUlP9LkaGfTWDLHYRh3GvBloCr7rImgT7YEPmvUY=;
        b=gFcnKzkP5Hsa2CgaEyEJXxs1uctGfCQYIS7MHuGqMje00QipMXeyBa8uOQY7w5ngpc
         V7P8ijCBAZwtefl0UEXPwgRx00XzMnbkbVH1iXu17R+0o2GHxgJNmSti2kwwA0SowxgP
         zC8lT5r6Wmf25DyShlENq0Lcahsz17iOYwt7kgDkR4hhaTqI0uO7qdYSGzYmEVgl3d5c
         lW8H0xVzrFNh3+3v6s/DllXGw6pERx+T9YQV9+N0HFUDPjkX2WkPLDkd0QjCbMyF90US
         yyF0pIg0QVApvLkRm95AFTphBYWIO/HNYFQevuVnh1qsG2oPWhQ1mYZZrM32oKd9vC1v
         QGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759878301; x=1760483101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iErhUlP9LkaGfTWDLHYRh3GvBloCr7rImgT7YEPmvUY=;
        b=Vu+Wn8vmC1WVTWmS7DCMLDIXtLX+cDpU/ecmYWytIXNW262Ux6ha3Z3sYpKQ2ZoGCk
         znr5NHlkPNyEAM7Qfz4zAvtL7ZpMql59CL4puFon9kUADa6YnKWuzOg9hiueTpCkiEcm
         lbKdWEFXTzcC3lfTRaW3LQxnRulcuoxKDS/hImfQSB9Qz24HsBLOZB2dzXtk0oOBV9yC
         90XShQKRKvtUS0C4k+1QCnbepre2ixlVuKU9OUKiU5S74fm0WnV6OdHAaoxhjHC8b6GU
         YrHMrfjPwEUVuTawT+1eXu8x12Ue/UFR5PkPpumu9mi4nTiQI63k0A9SiMS3h5JZZg8R
         tsJA==
X-Gm-Message-State: AOJu0YyGfcfjHbDkwu6UTaNUS9LuMMX9kyr1cpgwo4ifuiXQtZRAnCJq
	zvxwlvBBAqkW8u/pnqA1+/q8+EYpWNhgh40sXGObCYIpjPNSlNXHfTv4hazFSyH/
X-Gm-Gg: ASbGncsDWm/Zoa/3YCZTNueRgfP5GHLT0FXBH0xniBZCUqhw+tSWMgDdrAMdKp+xG0g
	P86sILkGywMJWCXIAPQIxXywYoP58yyF7Tc5UPhp8UvtB09tXg5V6potRS8g2VAPbco0v8Q6Bl6
	xmKzW3G2+IoODKMndDqH9SuoqKJEUbbR99/dDMc1nW7/1EkMvScFwtgd86yX7pQTJsiYQiAvOe6
	PaJKBQp/3/wLjF1vTaH0vBH1c0JKmPUeR7vraLO9/HYlY9S3VXp84LbE1AoXSWI2IJQ5P4rV4PN
	kB8veGhrWrtxbwOEVwQSq00n1882PjPZg3lqgCxIYxvg/SvxFsZy73Q5iByfcyK8Z7NV5DG5O55
	w08foumSjOR3jf1Lg7hF65/5+2364I6aK+P60QH9TmQxaONIMyccnvue1ELSWuoJc+95VEps=
X-Google-Smtp-Source: AGHT+IGvAJ9A+Bqbg5BqXp6J9ZCiCr+iUd2CSt5143mGGYGW2sQJ3GfysgqIB8fpu0ckb75FsUeAAA==
X-Received: by 2002:a05:6a00:23d4:b0:77f:2978:30b0 with SMTP id d2e1a72fcca58-793859f338fmr1257512b3a.11.1759878300849;
        Tue, 07 Oct 2025 16:05:00 -0700 (PDT)
Received: from localhost (2403-5806-8049--d1d.ip6.aussiebb.net. [2403:5806:8049::d1d])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-78b01fb0548sm16843453b3a.27.2025.10.07.16.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 16:05:00 -0700 (PDT)
From: Richard Huynh <voxlympha@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Richard Huynh <voxlympha@gmail.com>
Subject: [PATCH] wireless-regdb: Update regulatory info for Australia (AU) for 2025
Date: Wed,  8 Oct 2025 10:04:50 +1100
Message-ID: <20251007230450.69998-1-voxlympha@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of October 1 2025, a new class licence is in effect[1]
Update the link and references in the comments to it

Additionally for the lower part of 6Ghz spectrum:
- Allow for EHT-320 as it complies with PSD limits
- Expand the upper range up to 6585 as permitted in new licence

[1] https://www.legislation.gov.au/Details/F2025L01047

Signed-off-by: Richard Huynh <voxlympha@gmail.com>
---
 db.txt | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/db.txt b/db.txt
index 16bcb32..93d709e 100644
--- a/db.txt
+++ b/db.txt
@@ -145,43 +145,44 @@ country AT: DFS-ETSI
 
 # Source:
 # 'Item' in the comments below refers to each numbered rule found at:
-# https://www.legislation.gov.au/Details/F2023C00524
+# https://www.legislation.gov.au/Details/F2025L01047 within Table 8
+# except for 5850-5875 which is found in Table 1.
 # Both DFS-ETSI and DFS-FCC are acceptable per AS/NZS 4268 Appendix B.
 # The EIRP for DFS bands can be increased by 3dB if TPC is implemented.
 # In order to allow 80MHz operation between 5650-5730MHz the upper boundary
 # of this more restrictive band has been shifted up by 5MHz from 5725MHz.
 country AU: DFS-ETSI
-	# Item 58
+	# Item 1
 	(915 - 920 @ 4), (1000 mW)
 	(920 - 928 @ 8), (1000 mW)
 
-	# Item 59
+	# Item 3
 	(2400 - 2483.5 @ 40), (4000 mW)
 
-	# Item 61
+	# Item 10
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
 
-	# Item 62 (200 mW allowed if TPC is used)
+	# Item 11 (200 mW allowed if TPC is used)
 	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
 
-	# Item 63(a) (1000 mW with TPC)
+	# Item 12(a) (1000 mW with TPC)
 	(5470 - 5600 @ 80), (500 mW), DFS
 
-	# Item 63(b) (1000 mW with TPC)
+	# Item 12(b) (1000 mW with TPC)
 	# The end is 5725 but we borrow 5 MHz from the following less restrictive band
 	# so we can get an 80 MHz channel.
 	(5650 - 5730 @ 80), (500 mW), DFS
 
-	# Item 60
+	# Item 9
 	(5730 - 5850 @ 80), (4000 mW), AUTO-BW
 
-	# Item 22
+	# Item 22 of Table 1
 	(5850 - 5875 @ 20), (25 mW), AUTO-BW
 
-	# Item 63AA (25 mW if outdoors)
-	(5925 - 6425 @ 160), (250 mW), NO-OUTDOOR
+	# Item 13 (25 mW if outdoors)
+	(5925 - 6585 @ 320), (250 mW), NO-OUTDOOR
 
-	# Item 65
+	# Item 18
 	(57000 - 71000 @ 2160), (20000 mW), NO-OUTDOOR
 
 country AW: DFS-ETSI
-- 
2.51.0


