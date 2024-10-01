Return-Path: <linux-wireless+bounces-13353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F08D98B48B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 08:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D721C2332A
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 06:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981C1BBBED;
	Tue,  1 Oct 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRAmfdsw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9671BBBC3
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764514; cv=none; b=rbOzCmglwXAwqTnpWaFUuUpYCmpxGsnEa/QHFw5uPgvRKjv5rEg1X9AtLaZlrBt4P17aVapxTM7LJAbx/uX4D6jrhpTfQZg7v6aEENvS+xqRoHXlyzrsS6vWorRMzDppSTJnSEkue/4g9wAqZ8q6EA0Mt50wYAfcEQFVyuZh/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764514; c=relaxed/simple;
	bh=DeWld6d9dQDsqH8Phgpu2309U1V3CizS+tJH9VL54zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YijxUQKihORXw3bEOLyzHsDHbKXzTADg9BDZx8dOmhfxqQ54oF8xmkH4vr36oDFetKo/fA/D7BVz9bq5sDqYTkouzlyZ1b9NU/Yd6OllvcCRpyyYD5H/6LBpHM0yVhCJHrPTBMmBNn/m7y+YvC+A8rgLbVtIDaOmgcrknSkGMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRAmfdsw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ba6b39a78so7716065ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 23:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727764512; x=1728369312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou2UBEoY95HsSQFIFjrO2N/l0x2xL08+3BVXGHJ++L0=;
        b=LRAmfdsw90JjLiAGLkje2s+lMS55R0NIWign3yECp1mKDjLT9CxVDQgVMAtSw2T1/4
         D8gTLMvFel3hkjik62GOREYDOjDvonOjp0e1I7mvcGVEWrrumN+5RD9SHICPRxuXqR5t
         ZlGYkR+pMMvlcyysSJRbaR9Re2bp9guF1WO0aWoowSmTSnKVW/U7QADx5c5UUd3vfXlW
         4pBLj3y8b3OJOkhSIMiAojt9Z6RUpdsUMk9HQshKAU4aliGj2Je/82HebJ2pqd6OGPbq
         pfCDNX6jHVwG+h7xwvGts3nFPI49RL6vuGAMYKqq4WaAq72pHyKE3KspyV9wGx0+MBbS
         fYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727764512; x=1728369312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ou2UBEoY95HsSQFIFjrO2N/l0x2xL08+3BVXGHJ++L0=;
        b=hxCmwRds8U2UI88sxXN3JDUjs4PsBqSbdJ3Mj1wzi85KuHVGOKLvowZR0IYnTCmEEp
         sIrkLCfd0HPrjH659S/LIMWoPawR3ATdKAd5uJwQcmf1YKKMw5U2wA2Cg6VeahrlZUGD
         psf5VrUf0f2YFxcjl6pv1Ska4P1vCNHV7i/urQQSC1V7g9ajXD2XWixnMjczgLIiL5Yx
         i1vWXbS8daDu4iS6GFSXOedu1xFnV02v+TjrrvQaAV+xj5XnRLEiluAbe1wn672rryz9
         HVNQIGqTIOYjgl23BEZO33iIch7juZHdVnNPGSBBOboDxwC17nQQrU3DHFXQ/U9s2lgD
         nhqA==
X-Gm-Message-State: AOJu0YzDbJJyjxV2RCLelym5A+tuOwoxKAyHO1FYHIfV5Nmy2zJX73mP
	usmBb6nQ91ZtAuWuT9CM1JLQL61g/Sw97QOBRgeOPouCpqRXUkY+NvHoJ6Z8
X-Google-Smtp-Source: AGHT+IFHyqrsQCdO8VSAOw0hPJvRNbiXbTDcRmMnvrR4RiZY+PlefWDW6p95WISDErRFlsxHS+EDsw==
X-Received: by 2002:a17:902:e888:b0:20b:7731:e3df with SMTP id d9443c01a7336-20b7731e68cmr91202675ad.43.1727764512159;
        Mon, 30 Sep 2024 23:35:12 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37e20dffsm63934325ad.170.2024.09.30.23.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:35:11 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Pakistan (PK) for 2024
Date: Tue,  1 Oct 2024 14:34:30 +0800
Message-Id: <20241001063430.8347-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The Pakistan Telecommunication Authority released FRAMEWORK FOR WIRELESS
LOCAL AREA NETWORK - 2024 [1]

* 2.40-2.50 GHz
  - 30 dBm EIRP
* 5.725-5.875 GHz
  - 30 dBm EIRP
* 5.925- 6.425 GHz
  - Indoor use Only
    * 23 dBm Maximum mean EIRP
    * Power Spectral Density of WLAN operating under this provision shall
      not exceed 10 dBm/MHz.
  - Outdoor use
    * 14 dBm Maximum mean EIRP
    * Power Spectral Density of WLAN operating under this provision shall:
      - not exceed 1 dBm/MHz.
      - not exceed 10 dBm/MHz for narrowband operations on BWs below 20 MHz

[1] https://www.pta.gov.pk/assets/media/2024-09-23-WLAN-Framework-Final-05-09-2024.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/db.txt b/db.txt
index 956cfd044157..adda839f4cf4 100644
--- a/db.txt
+++ b/db.txt
@@ -1521,17 +1521,14 @@ country PH: DFS-FCC
 	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (24)
 
-country PK: DFS-JP
+country PK:
 	# https://fab.gov.pk/type-approval/
 	# https://pta.gov.pk/media/Pakistan_Table_of_Frequency_Allocations.pdf
 	# https://www.pta.gov.pk/assets/media/iot_srd_regulatory_framework_01-06-2022.pdf
-	(2402 - 2482 @ 40), (100 mW)
-	(5150 - 5270 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
-	(5270 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
-	(5470 - 5610 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
-	(5610 - 5725 @ 80), (200 mW), AUTO-BW
-	(5725 - 5875 @ 80), (1000 mW)
-	(57000 - 66000 @ 2160), (40)
+	# https://www.pta.gov.pk/assets/media/2024-09-23-WLAN-Framework-Final-05-09-2024.pdf
+	(2400 - 2500 @ 40), (30)
+	(5725 - 5875 @ 80), (30)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # PL as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1


