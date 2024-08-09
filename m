Return-Path: <linux-wireless+bounces-11151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFD394C79A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 02:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF76C2863FA
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 00:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84FF8F54;
	Fri,  9 Aug 2024 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWAObLuo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20114539A
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163313; cv=none; b=XGgOo9VbJXGHX6lW4gpaeYfxy3CYStI0YfNWXcwcu+J/xZMiX+eYw+jh3J4XSU7RhqhJwX2d9hO42hVWQcSmU0PmJ8eiSVyDGbiTzQFQ41ThWGjIpjBXhV3lA8eUy5c1mhBx7KXQiSWIPPnlkZlcoIVR4Fh+sIsGcCQY5EyL+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163313; c=relaxed/simple;
	bh=yiwqSDTZE+R2c/o1K7pmQmGULXoTr6Vzp3hgUwYjCsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Syw9urYwbj5JnTY4J3leDIhxTg8nWUFw88TK4MiGDL3iupS11Bfc84TPO3fj+rmy4/cXFKHDAj4v7TDh180I77ESWyGpKB/dzsypG2IM8JK8lsKub/jOZZYQtaeRkRebYM8FehK+bXIv42iE0X/8HBA5rPc4YEIM/gVML8zsG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWAObLuo; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-264545214efso872779fac.3
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2024 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723163310; x=1723768110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YzlRvCQVx0Xld0KqHCtDqjYlvosGEB3wkhhOhLSdv9w=;
        b=VWAObLuom1/bYJCdX0sw7e/miQzIeWecEfEIeG90yqSjiZeBSf5skY3MGNT/JxKPPV
         q0sDDr1xjfdfgWg1UEDE+X/pYK7/NVLc6WG2AbpRmcsXM37i86rKDjgg7HzKjUAzgJUp
         m+ZtOfD7q8Kd14iufUCNhKqr2hWEUtNHutZnKpnixVSFWPdySgx8mR9o/7DwgemRyTMm
         V8Y5pC6pIpeeelIgt33z/4m4Ld97yjCtHU9WL7IKvYX5RKaYhHmQAMJqXSJNR2US046V
         HBl/wU5HOgrWEOdp1YgMguEQ78A7yYKf5Qq+i/kQNhvfvBh0SS/eTxoK021a67sxSNAW
         vqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723163310; x=1723768110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzlRvCQVx0Xld0KqHCtDqjYlvosGEB3wkhhOhLSdv9w=;
        b=I1OValxd6a3HCwiFDoCXtmnkF6Bg+pwyJ/g8Z803zmFqHtK07aDyxCDCzULqrKO74h
         hWEnyUyzBXf69bpZyzNxkJ3uHTBHLx5nhMfsU2vN5JL17gYNZMUkGDsU4vA0lffmtAmI
         vztJdeAdtW2t1rL7J4PzgAcB86NzxAlVMvODcOKt+hA3Kwh5+uQHic9cJH0IKbEdPcF8
         1JnezZeXFJdXCXFmkuyN13mBiUmH+BH0/4DWablQN1pPR4nIgJOErBHNm3ewkuWdxXvt
         lp4zBRl9TnbRYrn8w2uFlNX8SpbbH115K2v57bdjBvKs+zBvwm6Yu3yZfjhGKikRQOlY
         KYHQ==
X-Gm-Message-State: AOJu0YwM4FMmSmt1vZVftvs5cXCCB+rxp3vH3ff+UomF3xB7fdpc3FIy
	aOinYzFZ4kFu5tTuuumt5PNzUV9BWHySs5cFly80WY93/LBZXdEGotyBEo8R
X-Google-Smtp-Source: AGHT+IGcHYFoJs0jHolIw/LdY8hC0bzdYBJvTR8Dblz63GqPmlw8chtmmzkFCO9e0mxRTEnWF8DhPg==
X-Received: by 2002:a05:6870:d88b:b0:25d:ff1b:3793 with SMTP id 586e51a60fabf-2692b7ab784mr3791754fac.35.1723163309867;
        Thu, 08 Aug 2024 17:28:29 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710cb238315sm1668261b3a.86.2024.08.08.17.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:28:29 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Guatemala (GT) for 2020
Date: Fri,  9 Aug 2024 08:28:10 +0800
Message-Id: <20240809002810.4140-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Superintendence of Telecommunications of Guatemala released NATIONAL TABLE
OF ATTRIBUTION OF FREQUENCIES RADIO ELECTRICS on 2020 [1] on page [2].

* GTM-30
  - 2,400.0 - 2,483.5 MHz, 500 mW (26.99 dBm)

* GTM-45
  indoor operation
  - 5,150 - 5,350 MHz, 200 mW (23.01 dBm)
  - 5,470 - 5,725 MHz, 250 mW (23.98 dBm)
  - 5,725 - 5,850 MHz, 500 mW (26.99 dBm)

* GTM-51
  indoor environments
  - 5,925 - 6,425  200 mW (23.01 dBm)
  - 6,425 - 6,525  200 mW (23.01 dBm)
  - 6,525 - 6,875  150 mW (21.76 dBm)
  - 6,875 - 7,125  150 mW (21.76 dBm)

* GTM-40
  used mainly inside buildings
  - 57 - 66 GHz 20 mW (13.1 dBm)

[1] https://sit.gob.gt/download/9685/tabla-nacional-de-atribucion-de-frecuencias/01WRXSS3QHSADNOSHDZ5HIWXE4TFFW3YIU/4.%20Tabla%20Nacional%20Atribuci%C3%B3n%20Frecuencias%20(Pies%20de%20P%C3%A1gina)
[2] https://sit.gob.gt/gerencia-de-frecuencias/frecuencias/tabla-nacional-de-atribucion-de-frecuencias/

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - add AUTO-BW to 6 GHz band
---
 db.txt | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index e46beae64ca4..e952d0a10d72 100644
--- a/db.txt
+++ b/db.txt
@@ -779,11 +779,18 @@ country GR: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-country GT: DFS-FCC
-	(2402 - 2472 @ 40), (30)
-	(5170 - 5250 @ 80), (17), AUTO-BW
-	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
-	(5735 - 5835 @ 80), (30)
+# Source:
+# https://sit.gob.gt/download/9685/tabla-nacional-de-atribucion-de-frecuencias/01WRXSS3QHSADNOSHDZ5HIWXE4TFFW3YIU/4.%20Tabla%20Nacional%20Atribuci%C3%B3n%20Frecuencias%20(Pies%20de%20P%C3%A1gina)
+country GT:
+	(2400 - 2483.5 @ 40), (500 mW)
+	(5150 - 5350 @ 80), (200 mW), NO-OUTDOOR
+	(5470 - 5725 @ 160), (250 mW), NO-OUTDOOR
+	(5725 - 5850 @ 160), (500 mW), NO-OUTDOOR
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR, AUTO-BW
+	(6425 - 6525 @ 320), (200 mW), NO-OUTDOOR, AUTO-BW
+	(6525 - 6875 @ 320), (150 mW), NO-OUTDOOR, AUTO-BW
+	(6875 - 7125 @ 320), (150 mW), NO-OUTDOOR, AUTO-BW
+	(57000 - 66000 @ 2160), (20 mW), NO-OUTDOOR
 
 country GU: DFS-FCC
 	(2402 - 2472 @ 40), (30)
-- 
2.25.1


