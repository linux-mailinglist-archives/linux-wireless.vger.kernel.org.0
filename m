Return-Path: <linux-wireless+bounces-10371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CB9372BB
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 05:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACCA1F21BB4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 03:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1221373;
	Fri, 19 Jul 2024 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhdixpDV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3A18C36
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359443; cv=none; b=DEY0/hgi6YOVSXKhUZLCoI+T27gK722EX0oBWx/zGASdOyIpnu/eJDiFJQAoZtsasXteW51pdTg82n6sInivNy7uCSp4c9NMTUeOsoLOAwX3W+qe2VBLWIPondNJigSPKlGdF6J9SXS8DsMLtD3rmTa+2LWgkWCQbRvibX111+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359443; c=relaxed/simple;
	bh=qcdnDfkpvxauVmtznJvkpmndce0/FB8LO5n6/HUQ8rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZnUBtjtETgmmRdcGLnuO/xSN+rrrq2pn6feZKJj8SFsNH2Zs81VcKoHXayqywRU4cVFUM8y2c6mRTAr4VGEgUjsC6Br1U3pe58AgBLN24te9+/xsb8oLuVv0j6WWndX/b4ezCfoGscSViXUk1riBIeNNXpWaM2as4NCl9ghus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhdixpDV; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3cabac56b38so931531b6e.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 20:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721359441; x=1721964241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOB5L+4P12y/gtLQ+IRtAPkliKJSy/BYtMjXT7c6v1g=;
        b=OhdixpDVPyykBK5fnGq+3X3fnUHJ9yB/yEFzR60BNpYKK0qFOoRYpwEMbtDauTtkCI
         WFqyqsIO89qSqm1zh1MWkrM+GA4fNc5Z8E0+1k+VZxFiGVjBzuGDTOlgObIOUuFpl5CY
         CIeNdiwbkl6C+8eSQUIH2TEixXonjRJKQI2X6XTIoVbUebE219CX0tMvk6lGqHkbD9P8
         oh8xq7DgcS5JC6yhRyyLmaHsBMBFfL/9986JI2ZAA20tR4Og92qRYQZSO5VzamdccVY2
         tf8E08Bk6TzoIyV2gKMHEELwfBrjfkvxaJS49wDq0gvJVKvkBtyhCAtQ0XQv8y04wpGT
         0lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721359441; x=1721964241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOB5L+4P12y/gtLQ+IRtAPkliKJSy/BYtMjXT7c6v1g=;
        b=I8m79OlQq/zP8VfYZ+TIaSq2q1gSRlQ8NLKmAPFa5z7D6sc5w0dpTq53UYK7pI1QPq
         tQcKCf3iMcQ0MW6twWyDxyAvJSTG8m0g1e0i1DAlmTYg8r7o4XOK+i1G8bN68lxlJ0Qd
         eY89FyP61bPrroFPFB55yt1gjR69f8w1xkTSTFvcce0JEj8MkwYCQORrPc5uSNufiHKI
         u1So09l3jDXDKU0H10W8rVUNd2oIxrNQk31vgrfnmC4+USYRGtPF8K+V9WI2bT+OQpUq
         eYypT96t+JoSs3qyKGAvehAh9mq+TWkN3RoeHuImgwysr9CcL3noVUzM6SRvqot+R01D
         B5vA==
X-Gm-Message-State: AOJu0Yz6bKIZYN0PQCnxeKCn16u46WKtJYVBgyWwK/bI6P8dzd8/VGvi
	ggZnB9iOxpowCXwEEBiACk55LFtSd7o8N+4iumdkerF8E/0kd2n44WljcJBY
X-Google-Smtp-Source: AGHT+IE6VqxdC/ZJ64XKk2UliGMq04mqrmW3jQ/nDLxkar3Sz7SlW33VVmW12GTj1HqS68EfPirYZA==
X-Received: by 2002:a05:6808:1441:b0:3d9:29c1:be41 with SMTP id 5614622812f47-3dad1f3f4e6mr8888148b6e.10.1721359440622;
        Thu, 18 Jul 2024 20:24:00 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff59fd9csm279160b3a.173.2024.07.18.20.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 20:23:59 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2 3/5] wireless-regdb: Update regulatory info for El Salvador (SV) on 6GHz
Date: Fri, 19 Jul 2024 11:23:24 +0800
Message-Id: <20240719032326.7353-3-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719032326.7353-1-pkshih@gmail.com>
References: <20240719032326.7353-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The General Superintendency of Electricity and Telecommunications Makes
Knowledge to the General issued resolution No. T-0408-2023.

Free use within the entire band for WLAN (WiFi) application, from
5925 MHz to 7125 MHz, must have following technical and operation
conditions:
 - access point
   * P.I.R.E 30 dBm
   * spectral density of P.I.R.E. 5 dBm/Mhz
 - client
   * P.I.R.E 24 dBm
   * spectral density of P.I.R.E. -1 dBm/Mhz
 - Indoor use only permitted

With minimum bandwidth 20MHz and PSD -1 dBm/MHz, 12 dBm is adopted.

[1] https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribucion-de-frecuencias-t-0408-2023/

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - explain how induce how we induce 12 dBm from PSD -1 dBm/MHz in commit
    message
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 1e0a14b8670f..31a051f242e5 100644
--- a/db.txt
+++ b/db.txt
@@ -1736,11 +1736,14 @@ country SR: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# Source:
+# https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribucion-de-frecuencias-t-0408-2023/
 country SV: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 20), (17)
 	(5250 - 5330 @ 20), (23), DFS
 	(5735 - 5835 @ 20), (30)
+	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
 country SY:
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


