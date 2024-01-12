Return-Path: <linux-wireless+bounces-1778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ADD82BA15
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 04:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A65D1C23DA9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868561B27C;
	Fri, 12 Jan 2024 03:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="B5TyQob1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038481B27B
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 03:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so3310503a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 19:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1705031018; x=1705635818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZUphtb88aglzBZqJmwFyLLbAYc8eKQv88iywC8J2Uc=;
        b=B5TyQob1onf5/qCy78+YS09Gqg++GpO/2l3S8/DwxtIq3ZeMoVjykIHOsA1K9VX3vp
         fVEabuxKt96Ye3nlVtONJybeP1Ktueu1bjeqAmEolvyg8R2ZDE7AAHetXVTFnDlZ0Ozh
         fsmQctMIa90AkbUEL9UjttWKNS126RrY9uA6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705031018; x=1705635818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZUphtb88aglzBZqJmwFyLLbAYc8eKQv88iywC8J2Uc=;
        b=Rrkaoc6lEwqniIY0SVc/9Ix3LgEq7pvb6uVuoYwZfnt7S/h+aWErfToYMrBoxI4IyI
         Z3+4EkSQk3/poTjMsAQniWKMvKNyjk00fj1KeCEt9Ay8EqZnXBjlDm6FKihgJ53279J3
         F9gVAnaMqYNMH1zrt0VfEnRbr/As7fik4WUL6zmnHejYFWjB5v4oiF2So9r9nqD7zxs7
         JhBcDwwbpXArLbAY9hNDXVmo/efMhLBE2gdm1PWkdkvTWTt60mA/9VHQ7DmXtSc9Ndg4
         RbhsKnRuEANsNsC5PHX3oOixZPeWZunz7xQdthLamVzf8Ee6G9AG6x5TAMbTGMlT/5MP
         vGgw==
X-Gm-Message-State: AOJu0Yz58jwEOsjKExTi7mX+zKTXOS9C0AYOe6em2DXgGdYTjATIJplB
	/PezRBl4gQQyfiLX0s/zLlbiYbs+SsgZIi10hcgdVZbucACJ
X-Google-Smtp-Source: AGHT+IF9nCCeEE6AWGeO//TbQljVlvUyxe4w20gPFeKiQ2CvzQ3ajTYcE2rk+PNi7tExM1T0+ffDXQ==
X-Received: by 2002:a05:6a20:f3aa:b0:19a:4765:ab32 with SMTP id qr42-20020a056a20f3aa00b0019a4765ab32mr268426pzb.72.1705031017865;
        Thu, 11 Jan 2024 19:43:37 -0800 (PST)
Received: from p14s2i.. ([2401:7400:c808:b52:9565:61c2:9ce0:d352])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001cca8a01e68sm1943145pla.278.2024.01.11.19.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 19:43:37 -0800 (PST)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Andrew Yong <me@ndoo.sg>
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for Singapore (SG) for September 2023
Date: Fri, 12 Jan 2024 11:40:44 +0800
Message-ID: <20240112034311.23677-3-me@ndoo.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112034311.23677-2-me@ndoo.sg>
References: <20240112034311.23677-2-me@ndoo.sg>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Update regulatory rules for September 2023 IMDA TS SRD [1]:
   - Enable 5945 - 6425 MHz (Wi-Fi 6E) band per legislation
 - Switch units from dBm to mW to match values listed in legislation
 - Extend (5470 - 5725 @ 160) band to adjacent 5730 MHz to enable Ch 144 similar to US & TW regdomain

[1] https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-consultations/ict-standards/telecommunication-standards/radio-comms/imdatssrd.pdf

Signed-off-by: Andrew Yong <me@ndoo.sg>
---
 db.txt | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/db.txt b/db.txt
index 01e7338..15b439d 100644
--- a/db.txt
+++ b/db.txt
@@ -1586,25 +1586,31 @@ country SE: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-# https://www.imda.gov.sg/-/media/Imda/Files/Regulation-Licensing-and-Consultations/ICT-Standards/Telecommunication-Standards/Radio-Comms/IMDATSSRD.pdf
-# IMDA TS SRD, Issue 1 Revision 1, April 2019, subsequently "IMDA TS SRD"
-# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 (25); ANSI C63.10-2013 and FCC Part 15 Section 15.247 or EN 300 328
-# 5150 - 5350 MHz: IMDA TS SRD, Table 1 (29); FCC Part 15 Section 15.407 (1) 5.15-5.25 GHz (2) 5.25-5.35 GHz; EN 301 893
-# 5470 - 5725 MHz: IMDA TS SRD, Table 1 (30); FCC Part 15 Section 15.407 (2) 5.47-5.725 GHz; EN 301 893
-# 5725 - 5850 MHz: IMDA TS SRD, Table 1 (27); FCC Part 15 Section 15.247; FCC Part 15 Section 15.407 (3) 5.725-5.85 GHz
-# 57000 - 66000 MHz: IMDA TS SRD, Table 1 (31); ETSI EN 302 567
-# Note: 27dBm for 5470-5725MHz bands is 3dBm reduction per FCC Part 15 Section 15.407 (2) 5.47-5.725 GHz; EN 301 893 as referenced by IMDA TS SRD
+# https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-consultations/ict-standards/telecommunication-standards/radio-comms/imdatssrd.pdf
+# IMDA TS SRD, Issue 1 Revision 3, Sep 2023, subsequently "IMDA TS SRD"
+# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 Sub-band 32e
+# 5150 - 5350 MHz: IMDA TS SRD, Table 1 Sub-band 33a
+# 5470 - 5725 MHz: IMDA TS SRD, Table 1 Sub-band 34
+# 5725 - 5850 MHz: IMDA TS SRD, Table 1 Sub-band 35
+# 5945 - 6425 MHz: IMDA TS SRD, Table 1 Sub-band 45b
+# 57000 - 66000 MHz: IMDA TS SRD, Table 1 Sub-band 40
+# Note: 500mW for 5470-5725MHz bands per FCC Part 15 Section 15.407 (2) 5.47-5.725 GHz as referenced by IMDA TS SRD
 #  AU and BG regulatory domains use the same interpretation of cited FCC and ETSI standards
-# Note: The transmit power for 5250-5350MHz bands can be raised by 3dBm when TPC is implemented: IMDA TS SRD Table 1 (29)
-# Note: The transmit power for 5470-5725MHz bands can be raised by 3dBm when TPC is implemented: IMDA TS SRD Table 1 (30)
+# Note: The transmit power for 5250-5350MHz bands can be raised (by 3dBm) to 200mW when TPC is implemented: IMDA TS SRD, Table 1 Sub-band 33a
+# Note: The transmit power for 5470-5725MHz bands can be raised (by 3dBm) to 1000mW when TPC is implemented: IMDA TS SRD Table 1 Sub-band 34
 
 country SG: DFS-FCC
-	(2400 - 2483.5 @ 40), (23)
-	(5150 - 5250 @ 80), (23), AUTO-BW
-	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
-	(5470 - 5725 @ 160), (27), DFS
-	(5725 - 5850 @ 80), (30)
-	(57000 - 66000 @ 2160), (40)
+	(2400 - 2483.5 @ 40), (200 mW)
+	(5150 - 5250 @ 80), (200 mW), AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW
+        # This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
+        # Since 5725 ~ 5730 MHz belongs to the next range which has looser
+        # requirements, we can extend the range by 5 MHz to make the kernel
+        # happy and be able to use channel 144.
+	(5470 - 5730 @ 160), (500 mW), DFS
+	(5725 - 5850 @ 80), (1000 mW)
+	(5945 - 6425 @ 320), (250 mW), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (10000 mW)
 
 # SI as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.43.0


