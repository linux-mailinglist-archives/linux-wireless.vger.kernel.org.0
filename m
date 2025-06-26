Return-Path: <linux-wireless+bounces-24528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82892AE98E8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2F8179166
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0164F1E25FA;
	Thu, 26 Jun 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCt7xWPG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC32294A11
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927621; cv=none; b=Kw8G6V9lsjMKv3PUKx14FhESFidFewsWDwuBuFrKT60TK069VwvqEMhUqg2tulQ4HL6XLE9UW0m3X22H8LR74hWgUzXV+E2ytUIzfokHKMZi2td8gIAQgFT6P9YA7Q5s9cc2xhwk7CZPFrl7Trb0tymBZxbJirlVQrxxxGqjE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927621; c=relaxed/simple;
	bh=yJPFFRrEtfLrU/IrZwIP86F5vsPeQCg7lcvpJ/N8gfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ij+V20zD7tP21oHUBwMjxkMD4+1Tb90ykhkD9s1MKEnnWALL80XFuNk47ouLznv4d731mYe48y2N/99pB5QETCXJbj/i4eF6zEFan+milf0jn7bTqiI4Ye4xsF05L4HHl8MUOF0DqH11/VeVHprcKa0snHoacDbtPgK71wYm0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCt7xWPG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso768623b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 01:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750927619; x=1751532419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XEnTNGf+JVSlAmdexfBtW1ws7OdnxAZZ4hs1eOrDZk4=;
        b=aCt7xWPGkQ5VdWWGg7V4OEvdJCjhGNtOky8TDnN7tgnD0qXYVxDNSdcpLXKcHS19jF
         /w05LNRe76iBUlPoXCL5KpLx3paChi2BJtPM2JaDtMiPrwgZovhITIpSWd8Z06HwEpkW
         nge6cqYLIwadX1SwnA5yIbEFac/nZ9uO2kAozWJL/tCdu+IWgrh3zxdDm94V25wPiem0
         1QSUZ5XwRGBZ0X0+JNXC2XEv4fchptuJdII1N3wQiauYWQFELP7RwTxOoNz6N9MN8IJD
         NsVpyxYAM2+AQylCtvvpjwlSaDMnTPlaoiSDzcezNadEjdiKmaXHEGnd2t55Qn8+LpWT
         wuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927619; x=1751532419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEnTNGf+JVSlAmdexfBtW1ws7OdnxAZZ4hs1eOrDZk4=;
        b=YyLAwPJxaEJpXfjEkweP7wfUEBzksiCy1IQYTokp8kskNqIG91xC1hAtl/uJU/bTxK
         b2qhSJvPTWzDZgWLFTLr4UJIodomY/nXKRo7e1dkI3F5gpfPWW3BD4TWAWQYRvYiDYLl
         PORNHdfku4P6R27/TojOtPLyP6BX3QtPnc3ZJl15ZkW9gfLzn9o1qm63/4Vv2tkJcAtg
         tmVVkpkOUL2UbPo1IGAzNUhXSSSW7n0n7mQdSJITuS37nQX6m0dgMOP4RuQBpvYZUyT3
         myfqLNkM93nRvwCc8N++G1zm6rlnFIJEDJ67xJT6pbYWvg3wvylL0kk2X+YRe89P0j+x
         Epuw==
X-Gm-Message-State: AOJu0YycGsostbd0xyZWP+DZG0sKle8uzIHx0XtPhj71EfLSwVtq5Fwx
	ah8PQYypa7qmIDHYoOJ5wFyUlDf/y3EeTSm4hm46gKBQjZwqcyExVtcy8X9LL4KA
X-Gm-Gg: ASbGncuEfTmZhpfBxsO8+1bz/uhEUUd2rLdR4vp2PlF9RQRZgE5AX6SxITDYuk4Ivld
	QOULwP4UYtRTq9ddOyIMO/4kBSqLqVodrvwKULhyx0dVb22k0VTH74GBm+TLDXO/CDNdaE3ZpU/
	qR6Tvf+glYYXy0NXJaGG/L2MNauaVKPLdI/JnEqH7mslHWvb9bmWpWKg55O5PHs5RIujBAKQQFi
	chUUgNh1pn5xlwnfRyaZxaW62obenRwZVVIMpMkePeZ2qSPD1pHVTvGbrkkL1syrL//LfyaccLC
	BLjuBMV2G17XcmpHahWMer9zQyQ4HYcRtT8rQJGIcoA66Iczk2RbYCjTDfanvo4JAJp3McM8eMI
	fGw==
X-Google-Smtp-Source: AGHT+IFaKe4U9BTTilc6MhCrnwECx8QlNmhSy7EdKRvMtqNnrnzcTaiRuLPbmq6H3pxRnl9//apfig==
X-Received: by 2002:a05:6a00:2d18:b0:748:ecdc:ca0d with SMTP id d2e1a72fcca58-74ad443db09mr9003180b3a.2.1750927619025;
        Thu, 26 Jun 2025 01:46:59 -0700 (PDT)
Received: from glados.lan ([2804:d51:4975:7202:7e03:331b:6be0:eea6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e4068esm6282396b3a.63.2025.06.26.01.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:46:58 -0700 (PDT)
From: Marcos Alano <marcoshalano@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wens@kernel.org,
	wireless-regdb@lists.infradead.org,
	Marcos Alano <marcoshalano@gmail.com>
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
Date: Thu, 26 Jun 2025 05:46:32 -0300
Message-ID: <20250626084632.2389103-1-marcoshalano@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change rules for 6GHz on Brazil removing `NO-IR` and adding
`AUTO-BW` so the 6GHz band can be used.

Add the relevant normatives in comments.

Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
---
 db.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 803f1bc..f74819c 100644
--- a/db.txt
+++ b/db.txt
@@ -321,8 +321,8 @@ country BO: DFS-JP
 
 # Source:
 # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-restrita
-# https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-resolucao-680
-# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-produtos/2017/1139-ato-14448
+# https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-resolucao-772
+# https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnicos-de-gestao-do-espectro/2024/1920-ato-915
 country BR: DFS-FCC
 	(2400 - 2483.5 @ 40), (30)
 	# The next three ranges have been reduced by 3dB, could be increased
@@ -331,7 +331,7 @@ country BR: DFS-FCC
 	(5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
 	(5470 - 5725 @ 160), (27), DFS, AUTO-BW
 	(5725 - 5850 @ 80), (30), AUTO-BW
-	(5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 	# EIRP=40dBm (43dBm peak)
 	(57000 - 71000 @ 2160), (40)
 
-- 
2.49.0


