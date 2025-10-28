Return-Path: <linux-wireless+bounces-28334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC92C132DC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 07:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA8588019
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 06:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAA2C0293;
	Tue, 28 Oct 2025 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="G6zIuY7k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4D2C159D
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632929; cv=none; b=gpFvFwo6gz+2182KVYKL9tSYvSz2mLLwEqidbyrlniKiKPHgaeeAJUiapMALUvRMyL8yQAuyJU9KgyZd8MubkYjHlYxuN1uf3/kjrHQwlvzU5DRnSDnKWzuXRVHJ23lvKcpxParFAC8f347xnNyEyRHqdt6L7LSwpNb5OGqNCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632929; c=relaxed/simple;
	bh=E+Wf7u0x+/17U+NiieuV5frgrCB1kWN/5KGPBvPsMfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWLcw06olcYGTjYjMfU/+UG+nFSNvHQEO/S4w9j7Rm1OVJoYkgOjdeMvH83ca+WseTEz7d+M45pto3KtBntMRZdKoBfxHMx3WnloKfKgVZhW70ZmUlD7Ri6UppmUPAxmAQ33hRc5qG9g5KNW0FBpM/FE13bguxwE68DOrmmbyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg; spf=pass smtp.mailfrom=ndoo.sg; dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b=G6zIuY7k; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a27f2469b8so426023b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1761632926; x=1762237726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ir73evyIRDVF112L404qeqtUBiO/cfljmivHcH0fmV0=;
        b=G6zIuY7kgckuJWEI8UAVOOeqW5atEGsJDYBCu/sUon7PXYZT13KVrpaSwXpEOwSkpW
         z7/VD1RxJIPacyb/QMaAg3zbwR4ZixdmkMy+stJ5l2GPCbgH50OXQqkNTNAXv92xj86C
         88VEGoSN2QTEyVcy+j0uGW7Bf8auSSx+ofVXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632926; x=1762237726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ir73evyIRDVF112L404qeqtUBiO/cfljmivHcH0fmV0=;
        b=ZBB5AHJPCju6a/2Bz3skZtx9GVTjVw2PXYoT8TbZ2BWpsdSzexQUK410cadFeB17gm
         Pl2HjjS1U8FwPU6z6+cSFU3TcHOk9wMd1JDghYFDfFK8avqumSq2KCgGG5vkzULTSVlB
         hocimZ2f3lQPyTT8D5Kqo7wJz5S5xdUkxmvBVpayN7pfqWlPSFqj1YS3sr+Olgid8HrN
         G22tQG2hvu9lKyP3V+2ft2Vd3LK31WdWuTCpZzneRwTE1RmshkX9FDC56rF3d1cTcDIu
         SOKls5NlqshjQWxqBjjLaca5RCi6+HnB65jvsswIC8/T7DYgpuuH97cu5HudfyB+t8WN
         G9Qg==
X-Gm-Message-State: AOJu0YxUUHhs5dAFaSY22l7J/e/uDISmFanFhU/JWp3VvQeGHBWofhei
	MHoQ1sEz70BzQJ4OkEMLbX7E612+YHMiTzrZUhWHIdBw8CE3kpF1hqMGZfr3uRJNDpkxJ8uGoC8
	DUKA=
X-Gm-Gg: ASbGncvvR6jlP086fOHxPdRd4TjFiNAtHAabFSZWU4soVtQVQn+99Nq2wk89b+vpgjO
	jfOhJqjhNbzjSzN+2Vvd5UUMrXsoz2PdBnBnVfmoy2+pIzmJK5Qu6qzc9SdNfI9HjjRVckutu4S
	7q4wJrBUbUnw0O3w4bLyRVemjJCwl+nuLvDB0kf6405Q83r3C8yKzZoJcCZWWSx7ozsOgfsEf2a
	E0Z1BG43KyIU8jr/w81ZC4/o+6HfV5wBYTNrTtUHLTRmi7noDarFz47qvVjAVy45n+KhhpbTpOI
	VZqLS4W9xOPZZ5pVUkhP+qpIYONr5TioJ8HoCgTDjrN4tXPVQHGADO88/cFWOr66XenYiUiFWDz
	8rwc3isB48rtbj6QDY79onMsusZ7NN9DmtA/g/DeZisFKr+InrQKMEX7Zbu8JyUNHP5CskT2Mq0
	dTkQF+HO2muFdZ82L6xdSJ3egpYXx8Dd0KedKv01Wru5MqV4U7wv8ANnApZ7tJj45d5J4rfQte4
	+Ovuw==
X-Google-Smtp-Source: AGHT+IFFeA3qpztAaG/RGooLaSJ+Yx7ATRVfl20wYEUuwleA0W9QGBSiaRvJg1lDAC7uQwfNpZujIA==
X-Received: by 2002:a05:6a00:2d8a:b0:7a2:855f:f88b with SMTP id d2e1a72fcca58-7a441c208edmr1702138b3a.3.1761632926412;
        Mon, 27 Oct 2025 23:28:46 -0700 (PDT)
Received: from localhost.localdomain ([121.120.74.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414015724sm10360781b3a.14.2025.10.27.23.28.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:28:46 -0700 (PDT)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Andrew Yong <me@ndoo.sg>
Subject: [PATCH] wireless-regdb: Update regulatory info for Malaysia (MY) for 2024
Date: Tue, 28 Oct 2025 14:28:40 +0800
Message-ID: <20251028062841.49216-1-me@ndoo.sg>
X-Mailer: git-send-email 2.50.1
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


