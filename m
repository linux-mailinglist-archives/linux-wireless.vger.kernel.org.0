Return-Path: <linux-wireless+bounces-10003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364F9281AD
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 08:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26B71F21ED4
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 06:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8C11C6A0;
	Fri,  5 Jul 2024 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH/XJ4Y/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8633C7
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159595; cv=none; b=ILfq0BYBdOptUN9cra7gsmClpSA5vLJZ6eB3b9xGBcjHMcmLrgOawc4aSHVInCouz1kYcNx+LjfawjllP9D5nVKF/LljG4QcrhVU2+B8Q62CaylG7aQFQURwAezfN1W74Wxr0fHmwrKOjUeTT7kKdukMoKwlGHUpCDMwJL1WZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159595; c=relaxed/simple;
	bh=bUgY03L6zivIYSVVkaDUpCnn1+Cd/vYQ41f7mx7r1kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6UIxZT22hyqp4hLWYD2esQXMH/8ZpuopLDBM5Id92ZfLwNRsuSa7wRc0sGymk1tf3BpsylEUawOibYROiXbyeElNRAp02xbpCd+ivDY629dgEyisBeGJn1gJ+8OelL/hFyZR1f4e2WDMiLn/j0x534ADvYPfnYPcIVaZk3MZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH/XJ4Y/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb1c69e936so7482085ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jul 2024 23:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720159593; x=1720764393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHkxc0UKIg+vQfu04qs07gwLBIHrophB65CpAiITplA=;
        b=PH/XJ4Y/Y6N5oKqhFu1C/kt/uL46tTepGipu8PF3EmULmu5jbhOnLOPDABHSWeRtKr
         mZA28I8/f9t0D2+D9TstUie8u6eF3ce1W5GAoxEKFyYH853/WROmOdPZUQK/juWq7TeL
         7shJsHiOF3UQiAivL/or747DdivCseG19qkATzR5Dxq6lvrOfGw/1RO+eh7//p6Xffuu
         DUu5b4PEsrRKK67p+L/f/JaLsuNpNta5lcXGE0OJ2LQyd6uzeSsVbmhUNu4CZ3ai+PJm
         25neBC6VcUngGLrQhrNI1PrBVjBNZPAJjju84a9UTvHmu5/Q2SMsSLZQmy9KmXwHjaPc
         /BEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159593; x=1720764393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHkxc0UKIg+vQfu04qs07gwLBIHrophB65CpAiITplA=;
        b=em2kc2NK+B303j5KGZD8kQgGYmq0eO5hB7zUIBlH0XoMwly8zGbLphOElQ6w6DvIhY
         wtEZQxpciw9ZSNV0uMOHHw84q1BWgK7OURGTs0oEgMNxsvKaDN6heGD2lXsJnx4SUJci
         yiaaRcXD25dMX8pzj4e2jZ/voRBWl5I7+gfaDhR9QwjqKWqVElfDuH2Ll5GES0DZ8CB6
         WoWt/cwttLm0G3SG4tWO4gX3uyuDpq2DZD0tgHtMXy+2sX/XKwpjef8Xzhqez1CDQ6Sv
         v39TqtQrL6rVPL7rKXucjUgfP89RGp5jsclAwSuNey/g+QQsMlVTHTDLe49k0Drs4yQh
         YlEg==
X-Gm-Message-State: AOJu0YzUjLhgjIWohYsssuqSjA2YeEOUJg9mpoHcZBW6xdZ2YPBiJ/pE
	m/+PvnTcVqGue3vj8t2T3+Sw5CrlVLpRyvk0fxIOlYUX8ypHfxMI
X-Google-Smtp-Source: AGHT+IGUEfRbMM1P1JnslcYuGQ2IKRZxvb2JOOAYjY26JLj9NHw+cWDWBqVR/WxUvX73df9mV9bErg==
X-Received: by 2002:a17:902:f54f:b0:1fa:2760:c3d0 with SMTP id d9443c01a7336-1fb33edf8a7mr28601615ad.51.1720159592258;
        Thu, 04 Jul 2024 23:06:32 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fb4e7c31afsm4644645ad.2.2024.07.04.23.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:06:31 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 1/5] wireless-regdb: Update regulatory info for New Zealand (NZ) for 2022
Date: Fri,  5 Jul 2024 14:06:09 +0800
Message-Id: <20240705060613.28909-1-pkshih@gmail.com>
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
  * e.i.r.p. 0 dBW (1 W)

5150.0000 - 5350.0000
 * the maximum power is 0 dBW (1 W) e.i.r.p. and
   the maximum permitted power spectral density is -13 dBW/MHz
   (17 dBm/Hz, 50 mW/MHz) e.i.r.p.
 * 5250 - 5350 MHz, If Transmitter Power Control is not used, then the
   maximum power (e.i.r.p.) value shall be reduced by 3 dB.

5470.0000 - 5725.0000
 * 5470 - 5725 MHz, transmitter peak power must not exceed -6 dBW (250 mW)
   If Transmitter Power Control is not used, then the maximum power
   (e.i.r.p.) value must be reduced by 3 dB.

5725.0000 - 5850.0000
 * 5725 - 5850 MHz, the transmitter peak power must not exceed 0 dBW (1 W)
   and the power spectral density must not exceed 17 dBm/MHz.

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
 db.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index d7592c299c62..266ba2d48731 100644
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
+	(2400 - 2483.5 @ 40), (30)
+	(5150 - 5250 @ 80), (30), AUTO-BW
+	(5250 - 5350 @ 80), (27), DFS, AUTO-BW
+	(5470 - 5730 @ 160), (21), DFS
+	(5725 - 5850 @ 80), (30)
+	(5925 - 6425 @ 320), (24), NO-OUTDOOR
+	(57000 - 71000 @ 2160), (40)
 
 country OM: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


