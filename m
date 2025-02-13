Return-Path: <linux-wireless+bounces-18869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A676A33483
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 02:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B022216415C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 01:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687DE3597D;
	Thu, 13 Feb 2025 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXXHce4F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584E2B2CF
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409556; cv=none; b=GWQO84sP+NX6SR9sKLWHK9Z0nKjDWldqXajF6ToJ0mnKra/wyvfNTuf785GGKSWVE69Ltu4+JjDJuFB1V5wbICR+AXFbqWgorHoadKYRCZUubBhPfmIxIIVYQzvvHPVv+sMq3jBM9J7pSWKt299/ZmFydrJBeOyJ6w++wfxIdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409556; c=relaxed/simple;
	bh=+8LZ8A/CZN+lB9T35L3UsllCxQsKIXR5etyePsy8+ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VmMQdhVlpaQP4UzqHmvrWyJ4WYIh4rTU4jDQmgFfFg1/WT1e9YrT15G2XaS0mOp+2fVozNWBbiIS2P/ESW9v8PZL6v6gIQ1d51PpfDw3HqmMi08cbxYnqfKRBG9GB5s9OuLZ9cbi/cYqRkYXEPZ9mk5RRdHq2P8LC9Sc3TwIk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXXHce4F; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c4159f87so3863445ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 17:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739409554; x=1740014354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRWOyFzKSFOHOMVQ8j1lY1vPHUzUEqfRNVTVbm0T0C4=;
        b=cXXHce4FDIPUQo8yEtNOnG0OGkBjjVpRGqhueg59St04Z4H4cKx5eor621giFb2a+D
         uTe2B6Rah3soolt3RILV27bI7DFOQGK0scebIilqpZ5evEgApsssNU85S/ole8HgKN5n
         Ldea0q7uAHdEikrn3XzhOwABy0cUK95KH9zc6fM1DLLJtJyWn6DzxlCqAfWLgE00dwri
         eCC/ujR8lylyMEb1B9yxpcK19YLEgBlqujznnddMSoTEvisvNNrWRXpoREJsPHM54uBN
         ZAnlL2WSoANiaN35UPUO0VhH8EwxJa8G5Niyw5DiHzQwPfbPLYcCv+8KOBv1ZeTs2t7X
         sH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409554; x=1740014354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRWOyFzKSFOHOMVQ8j1lY1vPHUzUEqfRNVTVbm0T0C4=;
        b=TkhpXAlXlXI6YAs7vbBvm0Ml/nM0jLt7lnOPW4G5NWeR8XXVDBr1+S4b4jii27lwNC
         kd8IuuDelPsu61rgCep4o/s1eIi0Ki1jFbIAeMvoEfjbw+LIUYRvNyB60lyox1xXjAKz
         Zt4JDuA3+1EhEy0hdFSL4ZQOHAlnFKLxj8S9yAjEvwAQRTb+ODPbHwJC8ODr92DC7aCF
         LREgqy6V2wWR27IOjaUiJVEB+2KbCvezmOpyIGqSLLC5K2TXr+tpmtvUNbXj5kQd7l2e
         EVo4NP8RDGkHE6sePlAfr54ZVDi9dLq7Ul7N5cUDFVAwAd9RkRmvSJ8OFFJEVofj/QsZ
         Tzzg==
X-Gm-Message-State: AOJu0YyJq5BigCZd8bQ36IlmTRuAZgCaZOIE2lFFFphCCTYhIzFR4TSH
	6hiKXhRjXKuoH5LcDSn22djsMcsrWP8qeH9Y6jV4Ap/VGgEStI+MQRimSl6P
X-Gm-Gg: ASbGncvex+sGtrayPQYZbtoEd2sFfP3KBP5nnfGPkM2y4DPOzM/P0mUGdNLNpYVj6Bn
	AjBDrJd0CiHRpN5FPh5rFS/AydRodVqFohTYkb2RhTJ2tsJibPcSBS9G3d1GyjwZiQvLhGhCxwc
	97K3S2gjvJrNnG6c4Sov5Y4K4Tx/rfD2i94Z8yCjDvfMHHyQ4VeYcxsV32X4Ci9KUMYJVK5dCFW
	1xhwivB5DhaYpQRGLnrv2cD5ATDej9AQayply1EdyLwQl1Ozg0pZjuaEJJDitif+iTP8kM3vwLd
	o5WdrimeL7/Rw0NH7q7PWalf8WjdU4hINrD55oJI0HQ3fGu9i8pHm1k6/Q==
X-Google-Smtp-Source: AGHT+IFIRnd39ca+lAtFvOZdDbCy+iYEi5E6BqgS7zjr3biciAn1U8N2hTZqmvFLeV0LuS7yhjJI8w==
X-Received: by 2002:a05:6a00:4394:b0:724:bf30:147d with SMTP id d2e1a72fcca58-7323c13efc1mr1848732b3a.11.1739409553635;
        Wed, 12 Feb 2025 17:19:13 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568a66sm92477b3a.44.2025.02.12.17.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:19:13 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Cayman Islands (KY) for 2024
Date: Thu, 13 Feb 2025 09:18:27 +0800
Message-Id: <20250213011827.4528-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Utility Regulation and Competition Office, Cayman Islands, released
Operating Parameters for Wireless Data Transmission (including WiFi)
Services On 18th November 2024 [1].

Both FCC and EU reference are permitted. Adopt FCC reference.

* 2400 - 2483.5 MHz
  - Part 15.247
    * 1 Watt
      For systems using digital modulation in the 902 - 928 MHz,
      2400-2483.5 MHz, and 5725 - 5850 MHz bands: 1 Watt.

* 5150 - 5350 MHz
  - Part 15.407
    * 250 mW
      For client devices in the 5.15-5.25 GHz band, the maximum conducted
      output power over the frequency band of operation shall not exceed
      250 mW provided the maximum antenna gain does not exceed 6 dBi.
      In addition, the maximum power spectral density shall not exceed
      11 dBm in any 1 megahertz band.

      For the 5.25-5.35 GHz and 5.47-5.725 GHz bands, the maximum conducted
      output power over the frequency bands of operation shall not exceed
      the lesser of 250 mW or 11 dBm + 10 log B, where B is the 26 dB
      emission bandwidth in megahertz. In addition, the maximum power
      spectral density shall not exceed 11 dBm in any 1 megahertz band.
    * DFS: 5.25-5.35 GHz

* 5470 - 5725 MHz
  - Part 15.407
    * 250 mW
      For the 5.25-5.35 GHz and 5.47-5.725 GHz bands, the maximum conducted
      output power over the frequency bands of operation shall not exceed
      the lesser of 250 mW or 11 dBm + 10 log B, where B is the 26 dB
      emission bandwidth in megahertz. In addition, the maximum power
      spectral density shall not exceed 11 dBm in any 1 megahertz band.
    * DFS: 5.47-5.725 GHz

* 5725 - 5875
  - Part 15.407
    * 1 W
      For the band 5.725-5.85 GHz, the maximum conducted output power over
      the frequency band of operation shall not exceed 1 W.

* 5925 - 6425 MHz
  - Part 15.407 (but no description; reference [2])
    * -1 / MHz (12 dBm is adopted)
      Accordingly, the Commission concludes that the appropriate maximum
      power spectral density for low power indoor client devices in this
      band is 6 dB below the limit for access points (or -1 dBm/MHz based
      on the adopted PSD limit).
    * NO-OUTDOOR

* 57 - 71 GHz
  - Part 15.255 (but no power value; reference [3])
    * 40 dBm
      The average power of any emission shall not exceed 40 dBm and the
      peak power of any emission shall not exceed 43 dBm.

[1] https://www.ofreg.ky/viewPDF/documents/2024-11-19-16-28-50-OfReg-WiFi-Permitted-Parameters-V2.pdf
[2] https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-use-of-the-6-ghz-band
[3] https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - extend "5470 - 5725" to "5470 - 5730" (+5MHz)
  - drop AUTO-BW from "5470 - 5725" and "5725 - 5875"
---
 db.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 4603324b4920..d56ad32d31c9 100644
--- a/db.txt
+++ b/db.txt
@@ -1069,12 +1069,15 @@ country KW: DFS-ETSI
 	(5470 - 5825 @ 160), (24), DFS
 	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
+# Source: https://www.ofreg.ky/viewPDF/documents/2024-11-19-16-28-50-OfReg-WiFi-Permitted-Parameters-V2.pdf
 country KY: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (24), AUTO-BW
-	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
-	(5490 - 5730 @ 160), (24), DFS
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (1000 mW)
+	(5150 - 5250 @ 80), (250 mW), AUTO-BW
+	(5250 - 5350 @ 80), (250 mW), DFS, AUTO-BW
+	(5470 - 5730 @ 160), (250 mW), DFS
+	(5725 - 5875 @ 80), (1000 mW)
+	(5925 - 6425 @ 320), (12), NO-OUTDOOR
+	(57000 - 71000 @ 2160), (40)
 
 # Source:
 # http://adilet.zan.kz/rus/docs/V1500010730
-- 
2.25.1


