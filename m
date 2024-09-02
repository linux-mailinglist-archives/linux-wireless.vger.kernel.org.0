Return-Path: <linux-wireless+bounces-12323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61AC96819C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B9E281215
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013811581F8;
	Mon,  2 Sep 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFs4uFSw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896C152E12
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265404; cv=none; b=j6T42SlZaVZ5GHzjPH00EjgeG6MlaJPn0jBvtDWuf0DIXq4jGl33wo3CTXKIWMd3WaVaccqdcCvS8P8knge0XuyA0oB2UwWxSNj2ZG/si1eFF7I1V2mRdDo64LU9I3gmxJerpulmy4yvcUXixecsG0vfNE663MbhfBedzuiL/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265404; c=relaxed/simple;
	bh=ItxWuRKx8FOUQux1ovaMle5Fh+ZWuPqoz/udPBmJN5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QjmwAjI3FK0OuhvQ9fl90e9fvu15Ov7kdnGEArDikY1iXxWKoFsjQX/9NMmFpFgj6fcbpoVI5om0Lh3uNpIdibkF9cex7vY8Y2fcJvQ4y7zwrQ/H21u/fqFhgY1apHgG+RfYeDs8EeT1fGZfw/Nic/SO7k/X85ffm+YoivI5W3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFs4uFSw; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710a1bb9ecdso399190a34.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2024 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725265402; x=1725870202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84j4YMkhuQUAVc1wW3fOXD/EApkWAkLNT4JxFhRqqb4=;
        b=cFs4uFSw5FoJRkcw+fasUbnziICrxsYW4OfCMHN3RvPBeladBdv7X6Qb53KX9U0EPB
         1XCC3pSFfs+HdkxEWc+mdwtMfJInwWwm5yHQSRn8jsHMOKtbVyynd84kAWBEwWGG6l/u
         yGQisWtKT79GgdKbmWAlXn/uhbH/a9NwffP5Oy32nFK8jPUI95AzYAnHYKqyen2xv5XQ
         jAV3AdhqCZGiM3oBSbJPGAwY02zCrkyIfxXuufMVZIfNK+kdTd6sEdzTBnFVeckjse5n
         sOzWhpj0q9dwCZARlo9ry2MGPL0wlAwmVrgNzPMT9fvwDzh/zpvEF+qA3YExY0vnDPXt
         teCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265402; x=1725870202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84j4YMkhuQUAVc1wW3fOXD/EApkWAkLNT4JxFhRqqb4=;
        b=jS46o+g24wwXDBosmMDw+yIr/mRLaR1i+Crs+RLEIZv9TA599gAqXPMd8M8Yo4k1oC
         1uIpJCV+UbJnwgPK5qgvg4mU0u/6KHIGnGqmn37X64uAwki/PhN7lC5sqz8tTEU5T/rD
         SgMW+YHKP1LQB84/eLHSLMDASI39vPqdHMxbLZRXbebs0LTX6IKFdlmIMvu1Cw07Qpbo
         0j1d2se6TAjH93+8Ay0agxpvf0TrolNed32SLMDXsw4Oi9teALeA/cM9VZTQQrMPaocI
         e2W2vQ1QiFbKK8Ma4BtJz3R2010dUlZJYKn11vM3F07yqiSXGHzDoxYcNBz9dVXBgkCt
         16gg==
X-Gm-Message-State: AOJu0Ywz6BunAPJAddSLUUy67WcR294rZUSozscD4QRbMiZEBal+JKdG
	FrXuy516SoTUMJtcMjtf5q1cap8tEnNSNlQhM5qdVchi7TqSj38N
X-Google-Smtp-Source: AGHT+IEFwMd5epcXDZ+7M9zkHUkM5fgXkEJmRe1kLMRfUEkn61o/GYQXg2YkStsHT759VfTReL3SLg==
X-Received: by 2002:a05:6359:4585:b0:1ac:f577:db25 with SMTP id e5c5f4694b2df-1b7ef5fd4b4mr971764555d.6.1725265401452;
        Mon, 02 Sep 2024 01:23:21 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e56d8827sm6376370b3a.161.2024.09.02.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:23:21 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2 1/4] wireless-regdb: Update regulatory info for Serbia (SR) for 2024
Date: Mon,  2 Sep 2024 16:23:01 +0800
Message-Id: <20240902082304.52326-1-pkshih@gmail.com>
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
   - reference [1] page 114-115, section 2400 MHz - 2450 MHz, 8th row
     * EN 302 328
       - 20 dBm
 * 5150 - 5350 MHz
   - reference [1] page 120-121, section 5150 MHz - 5250 MHz, 8th row
     reference [1] page 121,     section 5250 MHz - 5255 MHz, 8th row
     reference [1] page 121,     section 5255 MHz - 5350 MHz, 8th row
     * EN 301 893
       - 23 dBM (Without TPC)
       - 5250 - 5350 MHz, DFS
 * 5470 - 5725 MHz
   - reference [1] page 122,     section 5470 MHz - 5570 MHz, 8th row
     reference [1] page 122,     section 5570 MHz - 5650 MHz, 6th row
     reference [1] page 123,     section 5650 MHz - 5725 MHz, 8th row
     * EN 301 893
       - 27 dBm (Without TPC)
       - 5470 - 5725 MHz, DFS
 * 5925 - 6425 MHz
   - reference [1] page 124,     section 5925 MHz - 6700 MHz, 6th row
     * EN 303 687
       - 23 dBm, LPI

[1] https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utvrdjivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
[2] EN 302 328 https://www.etsi.org/deliver/etsi_en/300300_300399/300328/02.02.02_60/en_300328v020202p.pdf
[3] EN 302 066 https://www.etsi.org/deliver/etsi_en/302000_302099/302066/02.02.00_20/en_302066v020200a.pdf
[4] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
[5] EN 303 687 https://www.etsi.org/deliver/etsi_en/303600_303699/303687/01.01.01_60/en_303687v010101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - update commit message: list page/section/row for reference
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


