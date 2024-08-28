Return-Path: <linux-wireless+bounces-12135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889C96227E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1B31C2340F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFAF15C12A;
	Wed, 28 Aug 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB33wYHC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D215ECD7
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834842; cv=none; b=PzS9iaAmSa572RBxcrWOHMDZ1egHmSTnJXerefjiTHU70wmhp7Hu3O7VUI1ckFCQTSyUvGwFQmiaMhw3u+rsIEB0lEjczfaTOLxplYa1yE+EyHWB2I4mAjMZqQ8B7wyGniNU1PVojLARRv0D9NUiBC1eyTIRnaIofAGLorV8lag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834842; c=relaxed/simple;
	bh=wmRLDRpduhiNlpuFPQRDwwiOT1ZyoUIpd1XanfgOzhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G5wavT36lspDcCyAENXEYWNk3r6EzdMJFK54L7OPuYWcD6XHX9zrN2p8bYV993OTUE3GlG+C8aK5QJRL132j8LxFQ0pBmaHJsEPlNqgHo5BVdWohOO2EgApnam02yqaPYGFCt8Fdgh4xaRdSCyDEc1GNzoRPSumHpycA1sfwYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB33wYHC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-202318c4f45so66766885ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724834840; x=1725439640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNvrJ0FFX/UhGvKltRfjtPKtbIt+nqSVpRXoA9TJ31U=;
        b=LB33wYHCiWr1IZfzPRE4E9SK9VX69qgmBfKQoyCgpk+6Wfw032/+FRFa8cLQ6c2k6P
         DulY+diJcZuJV65/+ARm97Lz/xrb2yruhiQkykLW7HFBNziWBIT6hyFv6OTIvtvNwAX4
         NtOHupbFgEj18baQauhIgA8X1Ht/Orz6Rc9p6EcnFzvgXskR/3PqMcIE/VNYTZCXpuxw
         DIsyRMzQp9eql4krK/0AN6i+bI5c05Xc+G/8lr9iERz1uxE6ez1YkPK9z9g71XK6EO61
         1tgzwYU5lXvkO+ArnX3+Od96GE8Gzva9VSVTDdLJxsQ5ps/4jAeQxcZq20MIz1Ew+aaH
         Zpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724834840; x=1725439640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNvrJ0FFX/UhGvKltRfjtPKtbIt+nqSVpRXoA9TJ31U=;
        b=HpFoD4CRVtviGqyVHmft3j3dML/9V16D7U0EpsKBoq6bpFGE7LcEXjKQIb6GgdoT2k
         UJgwOXCj6meA1bhUsBUpAdix04jksfPSBF83VmgjYESyHFEoQHVziynrz2YmTXyRNAln
         R8oZ3YVkxSg6OLnFYWE0AEU9nrQ8OJg/+P6u0MezjwsDtnkygQYv0drxGIm97gpkKXlV
         9Mj8xirnnkm6zYPaE4QOknzsRDR27wmaz3KF972yTwizoGGyo6qiPtceXZzeW9m0r8/O
         WJwlNPbIgbBGj5Wx46jgfnMi0ez+ad3Iec/vNCDDE1NXUaeyOcQl6CQTfBHZ48GKHRtr
         +Epg==
X-Gm-Message-State: AOJu0YzPKSwonNHjqug9krPU+zK4DPlIDZAheZTJAOFby0HcAQImX78Z
	mxdFFCKZ9QlYFQqyxU9OcwcjR42TonM5pUPfkK10oY96WKtKiLZG
X-Google-Smtp-Source: AGHT+IFvLSsWlCuF9LMW8AR881ZS4ZArFlkxZV1/q9ga1J/4VUVOyAo572YTvGcf2KbvFmEzTiOhKA==
X-Received: by 2002:a17:903:11d1:b0:1fa:9c04:946a with SMTP id d9443c01a7336-204f9a54d61mr14003955ad.1.1724834839594;
        Wed, 28 Aug 2024 01:47:19 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855dbefbsm94652645ad.136.2024.08.28.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:47:19 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 1/4] wireless-regdb: Update regulatory info for Serbia (SR) for 2024
Date: Wed, 28 Aug 2024 16:47:03 +0800
Message-Id: <20240828084706.12257-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Serbia government released radio frequency range on February 5, 2024 [1].
Based on Article 100, paragraph 5 of the Law on Electronic Communications
and Article 17, paragraph 1 and Article 42, paragraph 1 of the Law on
Government.

 * 2400 - 2483.5 MHz
   - 20 dBm
   - EN 302 328
 * 5150 - 5350 MHz
   - 23 dBM (Without TPC)
   - 5250 - 5350 MHz, DFS
   - EN 301 893
 * 5470 - 5725 MHz
   - 27 dBm (Without TPC)
   - 5470 - 5725 MHz, DFS
   - EN 301 893
 * 5925 - 6425 MHz
   - 23 dBm, LPI
   - EN 303 687

[1] https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utvrdjivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
[2] EN 302 328 https://www.etsi.org/deliver/etsi_en/300300_300399/300328/02.02.02_60/en_300328v020202p.pdf
[3] EN 302 066 https://www.etsi.org/deliver/etsi_en/302000_302099/302066/02.02.00_20/en_302066v020200a.pdf
[4] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
[5] EN 303 687 https://www.etsi.org/deliver/etsi_en/303600_303699/303687/01.01.01_60/en_303687v010101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 9a55f6b8cc98..ad8dddc9c800 100644
--- a/db.txt
+++ b/db.txt
@@ -1758,11 +1758,14 @@ country SN: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utvrdjivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
 country SR: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
-	(5490 - 5710 @ 160), (27), DFS
+	(2400 - 2483.5 @ 40), (20)
+	(5150 - 5250 @ 80), (23), AUTO-BW
+	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
+	(5470 - 5725 @ 160), (27), DFS
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source:
 # https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribucion-de-frecuencias-t-0408-2023/
-- 
2.25.1


