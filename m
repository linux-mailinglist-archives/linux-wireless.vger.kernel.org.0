Return-Path: <linux-wireless+bounces-10369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8E9372B9
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 05:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CCD1C20B7C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7ADF9F8;
	Fri, 19 Jul 2024 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeCkFpf+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57C5680
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359440; cv=none; b=BUDsrvxL3ywQ7TB1ghl1w/y1ma8Knew6sKtVVCJ/hs9bz34I5ub9GKZjd3l2IGJYKBsFYmQyK4U8sPur5b53W0vIMFhElSVQmjJ2EWUIKdXQ/bWwDX1zOw8uxracb8n7ppNlsM3491/YEOXrsCjZBpKx1SR9g6JIIYQBbOz9910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359440; c=relaxed/simple;
	bh=WiTiZwooQgOTPSM6WMB1H/T1kn6DVENlpVJzJrGlZC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NHCzyRNM3ZamdpZ0nwVV43/NgoJmP8UyD4kl6l093kPYaz85/DBseKwZQ7jDIhN0gPHAyxdmb6IuBlhZNVPjsIsTJ6EfzeeOZoR36rpSQnsjq59gu5I2rYSvdVKGoqACFtzQ23FjqBd6N5V19MgM96FEQyn6PorDEmWMIB4dbVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeCkFpf+; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d853e31de8so882398b6e.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721359437; x=1721964237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yY7wbH+WsXnAJXQeGqshr9VN+E3jFFNFoVh2XZMiDZg=;
        b=NeCkFpf+56ssj1x4TJx833VPHUbxBsybIk5Ddmo2sOxNsr9PENXxLSorHXftqna7VW
         JuNbTmgf8Xvtp0LqotwMzaXNeVZbAVb/5vzMRDTOhDexHqFsBOV13ftB7Z7WXZNKNHZ4
         o5asPIvtTZ+nqQBHjr/bJv3iKwuM7pfHsHPONNEC1U0LjRSJR+XqJ0XiphT61c41t5zA
         f3tpMREvxX+xqrdMxpt472kJIlJRE1O6fsCfhDqoVj1XLsADQRJ4aoHgoyJghvPmjVnP
         Bw32VhrITepIAIdUKpd+PmGP+MscYRDS5+Jw8CTjNHl9/uIEfD8IQyzcbudSirpN7DAf
         SHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721359437; x=1721964237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yY7wbH+WsXnAJXQeGqshr9VN+E3jFFNFoVh2XZMiDZg=;
        b=IkVDYjc72emP2yoXe7Zg2oTozkLlpMkbEGocTUREtBO0oSu7mE6y6Hk31zFiEcRJVc
         T9A0Lwu74e54yN71vX0u4EmlP1WfroXgq1bldY5Tyr/CzmaCydk9V+TmdRM3OZYd6WKB
         dAEyxYxOtiT+QpwH8XFKoJG+nLm1CDTZUKyBJzdZ4I2j1hQJP7pA4IwSRIrnooy8FOYE
         SL+WsWscPLEy+TDiU8uh87FDQrRZHlKIDzrjHbXBT4YFipb+5se/mg4GOFmJbmS6ALzL
         XJq3pN0eDx2+ojI+Onb9K0sU7E5yT1K33wEz7Wutvr4c5V20H7JZcfOUUafrHAaHZBai
         V4HQ==
X-Gm-Message-State: AOJu0YxAm3S+jgKtJm6Uef9dxwK7VXt43WodiZphU9GY/bSnxhkVh/Fi
	L2U/440q914dURTk2NPOO9CwJlAuDdVESZrVK9BS2rZnxxWDGrQouGPZhrF+
X-Google-Smtp-Source: AGHT+IFJxX8dbn9deSbvTilaAlPRSX+BzW0Gn0JjLe4Y80ky/h7FRDvc3DHdUrd7z40uJT7ngAG+hA==
X-Received: by 2002:a05:6808:2184:b0:3da:b3b3:17f with SMTP id 5614622812f47-3dad521ddc9mr7989074b6e.25.1721359437525;
        Thu, 18 Jul 2024 20:23:57 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff59fd9csm279160b3a.173.2024.07.18.20.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 20:23:57 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2 1/5] wireless-regdb: Update regulatory info for New Zealand (NZ) for 2022
Date: Fri, 19 Jul 2024 11:23:22 +0800
Message-Id: <20240719032326.7353-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Radiocommunications Regulations (General User Radio Licence for Short Range
Devices) Notice 2022 listed spectrum:

2400.0000 - 2483.5000
  * e.i.r.p. 6 dBW (36 dBm)

5150.0000 - 5350.0000
 * the maximum power is 0 dBW (1 W) e.i.r.p. and
   the maximum permitted power spectral density is -13 dBW/MHz
   (17 dBm/Hz, 50 mW/MHz) e.i.r.p.
 * 5250 - 5350 MHz, If Transmitter Power Control is not used, then the
   maximum power (e.i.r.p.) value shall be reduced by 3 dB.

5470.0000 - 5725.0000
 * 5470 - 5725 MHz, The maximum power is 0 dBW (1 W) e.i.r.p. and the
   maximum permitted power spectral density is -13 dBW/MHz (50 mW/MHz)
   e.i.r.p. If Transmitter Power Control is not used, then the maximum
   power (e.i.r.p.) value must be reduced by 3 dB.
 * Then 27 dBm is adopted (0 dBW - minus 3 dB due to lack of TPC)

5725.0000 - 5875.0000
 * e.i.r.p. 6 dBW (36 dBm)

5925.0000 - 6425.0000
 * the maximum power is -6 dBW (24 dBm, 250 mW ) e.i.r.p. and
   the maximum permitted power spectral density is -19 dBW/MHz
   (11 dBm/MHz, 12.6 mW/MHz) e.i.r.p. for low power devices.
   Only be used indoors.
 * the maximum power is -16 dBW (14 dBm, 25 mW ) e.i.r.p. and
   the maximum permitted power spectral density is -29 dBW/MHz
   (1 dBm/MHz, 1.26 mW/MHz) e.i.r.p. for very low power devices.
   Very Low Power applications.

57000.0000 - 71000.0000
 * for devices transmitting at 10 dBW e.i.r.p or less,
   the power spectral density must not exceed -7 dBW/MHz e.i.r.p. and
   the maximum transmit power must not exceed -3 dBW at the antenna port
   or ports.
 * for devices transmitting greater than 10 dBW e.i.r.p., the power
   spectral density shall not exceed 8 dBW/MHz e.i.r.p and antennas with
   a gain greater than 30 dBi shall be used.

[1] https://gazette.govt.nz/notice/id/2022-go3100

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - correct 2400 - 2483.5 to 6dBW
  - correct 5470 - 5730 to 27dBm
  - correct 5725 - 5875 to 6dBW
---
 db.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 7a1221f1699d..5cada55b51eb 100644
--- a/db.txt
+++ b/db.txt
@@ -1416,12 +1416,16 @@ country NP: DFS-JP
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5735 - 5835 @ 80), (20)
 
+# Source:
+# https://gazette.govt.nz/notice/id/2022-go3100
 country NZ: DFS-ETSI
-	(2402 - 2482 @ 40), (30)
-	(5170 - 5250 @ 80), (17), AUTO-BW
-	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
-	(5490 - 5730 @ 160), (24), DFS
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (36)
+	(5150 - 5250 @ 80), (30), AUTO-BW
+	(5250 - 5350 @ 80), (27), DFS, AUTO-BW
+	(5470 - 5730 @ 160), (27), DFS
+	(5725 - 5875 @ 80), (36)
+	(5925 - 6425 @ 320), (24), NO-OUTDOOR
+	(57000 - 71000 @ 2160), (40)
 
 country OM: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


