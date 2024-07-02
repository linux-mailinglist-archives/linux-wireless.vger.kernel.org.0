Return-Path: <linux-wireless+bounces-9812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3D591EF71
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 08:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612051C23FE8
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 06:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BDF12F5B8;
	Tue,  2 Jul 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuzkUF/Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA412C460
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903079; cv=none; b=p4UAjUzOVTe/AFz0AGm7Kh4QaRcyIPKTZKwBJYDfnIvbM/8NHy8NQc4SKFYeQwwHAGCKuH1KOiTST19H8d4B7nn2uQemqvAgFlXMUVyWerrtE96+PIPqo725Gb9t8eJcvNTfvZmTeM7uZR1vKaUns1Bx7MnS/HwDFGACcZL/v54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903079; c=relaxed/simple;
	bh=CWRrZBVJ3hdVXz6GFxz0TiZyyq+oF+gsSfXaWg4D8KA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2YZy2MWuTJv+1JvNAVlHpdy8qENb5bHVZHDBVG/bdz4TdxFeJaaeGH+k9kdxvB/nRpu6YKGtNw17T4li6pP9NM8VfnnX2tXdqJcVIZN8lE2/OY/ifFWFpd754C1F78ufRoh9blomn1duDcitcNeyr4TY8oRPaZFHlII6WVG1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuzkUF/Z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7226821ad86so2302019a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719903077; x=1720507877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBd7dAll2Nu6iHiXQeAYznrI7xAx5uSUGnwOAPgGmxA=;
        b=SuzkUF/ZIt/taPT52/48AbX34ga6c4DR2wrPUWq40DbwUfedZoRLhaKY6gssStIWTE
         3oj+8U802IUqA/KXmB6qjZAofqRcdeTHqOqFrUxYpjrTYqMYQMU/aDaN62YPyyuWFeDK
         InnRSx1jRcinicKBaIj3vBZIx09tsxqbdptOJKS5Dr8+XUDwfpMVDlSHno54Pb81N7+M
         wODZjWoZg3i00ua+MejySEqw225h12T4tBuykT+dK+WFgjG8/k9mP2pcbjnEf/bUkevC
         MmiOsxc3UAr2ibtA3WmgFtz0A7Qvj6du262Ep6gM+z8t0z1z3CnIrPa+Yh1IB2R5YM5D
         Z5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903077; x=1720507877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBd7dAll2Nu6iHiXQeAYznrI7xAx5uSUGnwOAPgGmxA=;
        b=AcUibnN8P/JT+/Q+RpnhvTv68NdKWLtZmXIjOzdJotv6B6hrjMWP8N7r7sO59eOTWo
         sqlz+H688CE5FVGNW+utA37n5neQizYeFOJqWY7wUFfL3e/3FwLar7/cqaRTYB0YLuEm
         kFlUtCt1+gKh+Rt3B90gjautGYShs82XXIAW/jIYdTSP2MLjHV+JbUtVfXwxM2fMRZvU
         ZLMEdJ8dIm97r07kNyIyQhk5wJsvAFkFnwk5GLL9kqEN8Ull81oLA97YS71lqQTeJHaM
         ANVTCQRZnqI3NGb2BaGFkCgHLEOzbMtvrTWNEsU9Hep/HsnojgYaP25+/nInwlwDSLE5
         o6Ug==
X-Gm-Message-State: AOJu0YwcM1De28c9VSOwvG20RZjyaQ7R1FLx174sEsCzphsb1dVLKNn/
	UY3fnaZpVvxE2YLhulM5PBxKzbfjtbV4nFkrzxvM3Iim0pcRUQyTjFmg7oQg
X-Google-Smtp-Source: AGHT+IFLIAIHWHA84fGAeTOfeYMuOWLMLrMvqzCelIg008rhM5G4SC9dftZnSAjJyxiiyL9rMk1kOQ==
X-Received: by 2002:a05:6a21:998b:b0:1be:c733:ab4d with SMTP id adf61e73a8af0-1bef61408f0mr8401821637.26.1719903076701;
        Mon, 01 Jul 2024 23:51:16 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc5e7sm7976490a91.36.2024.07.01.23.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:51:16 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v3 1/3] wireless-regdb: Update regulatory info for Jordan (JO) for 2022
Date: Tue,  2 Jul 2024 14:50:58 +0800
Message-Id: <20240702065100.13644-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The Hashemite Kingdom of Jordan, Telecommunications Regulatory Authority
issued pursuant to the provisions of Articles (12A) and (22) of the
Telecommunications Law No. 31 of 1995, as amended. [1]

The effective radiated power (EIRP) of devices used in local radio computer
networks must not exceed the following values:

 - 2400-2483.5 MHz: 100 milliwatts (20 dBm)
 - 5150-5350 MHz: 200 milliwatts (23 dBm), (ETSI: 5250-5350 DFS)
 - 5470-5725 MHz: 1 watt (30 dBm), (ETSI: 27 dBm, indoor only, DFS)
 - 5725-5875 MHz: 200 mW (23 dBm), (ETSI: indoor only)
 - 5925-6425 MHz:
   * 25 milliwatts (14 dBm) (for outdoor and portable devices)
   * 200 milliwatts (23 dBm) (for devices operated indoors only)
 - 57-71 GHz: 10 W (40 dBm)

Follow ETSI EN 301 893 [2], which specifies reduced power limit of
20 and 27 dBm for the range 5150-5350 and 5470-5725 respectively for
devices that don't implement TPC; and classifies the 5470 - 5725 MHz and
5725 - 5875 MHz ranges as indoor use only; and DFS is required for bands
5250 - 5350 Mhz and 5470 - 5725 Mhz. (Add these rules followed rules of
[1] with "ETSI:" annotation)

[1] https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20GHz.pdf
[2] https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3:
  - DFS-ETSI
  - split frequency 5250 - 5350 as an individual range for DFS
v2:
  - Follow ETSI EN 301 893
  - add 57-71 GHz
---
 db.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 61c46186919e..4d2ebe46172d 100644
--- a/db.txt
+++ b/db.txt
@@ -957,10 +957,17 @@ country JM: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
-country JO: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23)
-	(5735 - 5835 @ 80), (23)
+# Source:
+# https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20GHz.pdf
+# ETSI EN 301 893: https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
+country JO: DFS-ETSI
+	(2400 - 2483.5 @ 40), (20)
+	(5150 - 5250 @ 80), (23), AUTO-BW
+	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
+	(5470 - 5725 @ 80), (27), DFS, NO-OUTDOOR
+	(5725 - 5875 @ 80), (23), NO-OUTDOOR
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
+	(57000 - 71000 @ 2160), (40)
 
 # Source:
 # https://www.soumu.go.jp/main_content/000635492.pdf
-- 
2.25.1


