Return-Path: <linux-wireless+bounces-16126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A640D9EA61C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 04:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258CE281045
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65061C147;
	Tue, 10 Dec 2024 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G83uoqxF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97298F6D
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799653; cv=none; b=r8w6bQ5IODBCpjrDCY5nFG6Az7B3ADQhrTmMFsf3Gu66fsBQrwwCdv9B7MpDbk1xgB3gRT5HaGNVodIp1Ou0y16lZIREzcTAOBA4BMVrpXHI4GvSfFOvfWJRVF3d4FEl6rJeEbi1bImMUG0dFVp/gWnNMwrAHTDlUx+ID2YvNGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799653; c=relaxed/simple;
	bh=NJlJFR66tb0oF994DUVMQGpErwPzabgsEgBHQAqoNEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t110Qsx7dlb+yJOe4vED/lJa6Yg8Sy7N0MgjURY5nDkru3n+1NL0F7JKtlqqV/mCnONS6JJlW0bXTgAaxmML0cuHbr1C1QhJllMHDK4r+HdOGtQTjJ9fzQhqoAyyHc3yQwA3wUEjk+4B45/5pFLIHSJ5qmy6wz3TiCkYSDWwERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G83uoqxF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725aa5c597cso3756485b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 19:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733799651; x=1734404451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuF4KpktRoMjj2LgIzDS0P7FgH2EXyHF2Fregf7Z3v8=;
        b=G83uoqxFJ4UiZBZNmRpT81ysYsERgO4pjNEeYPQho55G2LFTRPP7BwPOOOEMBNK1np
         /+bFC/fPG5iwg+Jfeg0mENE2lWOfM+ee6mtA8wZ4+g2JjJc/Gb9ct/yFKLwgdQd5zkTu
         aCh0Kqmxyglvc5Ejm8isBuZeA3vDV2pT4HfAk3PTA3Xo1QYvQLHFsZp+VTaRyxRxFA8R
         QmRr7JGYS23DahJpAufBO/SgDLm+w+A6HR2qH29pOinNNW8/uj5B2czTvgjT1Eg5BUMN
         E7D0AuKBTv35HE/M87/9hvwQGeTiWF8RtqzvmFOupfjfreO/YZKHvvFSEZSB8HwOJx79
         9znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733799651; x=1734404451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuF4KpktRoMjj2LgIzDS0P7FgH2EXyHF2Fregf7Z3v8=;
        b=nht1n42Z6hLidJ/DfSi7OHfgvlK8ebYACLSXci37LhrkgW+aer4ks6zEpPZgARdbpV
         uE2sngwcwDZRerYpCEdWQNPSXyKnKyy3FKZnX8GaoDmdFKMRPIxGnbRBqCJP6/P+kpGJ
         AB3GBAw1e57nOOaklaqvmIHtsKeYEM6IXd37GDKc/1iGJzT2oNY/ZQxR163amIdVeygM
         yvhv9mNoDerqfjpov7LG0RgSPBGBljeoQBrQfGx4yR3MBq6ejYEP8KJ2a8XBnPoYB7RK
         4q6yytJ7msOVgp5bAzMu4wXhGo55dcl0tLpWE7xeT9Z/ykaRcMPTUHaweec7zQ41INxw
         xs9w==
X-Gm-Message-State: AOJu0YxqpEwVQ1Nb3lnwmkHJ6AzPGoUk5HxCmT2ddTKX6l3/RlkO/hRh
	7tW/t6mfj+enSqoUWMel9UR0jh+G+7FpvXwLwfBnWXnRFa/jUCYyGzj2YECM
X-Gm-Gg: ASbGncuvZ0uE3IcsnELz2ffj52MMXoc9gluBuye2yFIMcr0jkDJrDQ1yWeaG8wYs+cw
	fn1M1v3LagpdNO31YR1Ireq2+j2nzty6DC4cY+nwo/OM1EUIIlZRPoxtjY8+ODHUVz+0rdmMIBt
	17f8FQcf0o3vrBcNe8K8XelcXOyc9qvtzskOSBtE5rovujerkDapvnt4aTRTLlMnqJ8bUa/MzDt
	YN5Zg47TzkJAS6FlsIB3J9mP/oqGf6nzEuQ262BmtSb7O0rFF4xfakF+DOCcmJF8yG0DJoXLC9r
	KuZIA6QJX7dbaGz+5Mrj
X-Google-Smtp-Source: AGHT+IEBvEnR+R0mttxHfe0ZTZil1rWtAnX5H72IFzLjxPlNGuvhgYO8YxBZUPBMPLbHrp3Zz2p9gw==
X-Received: by 2002:a05:6a00:b91:b0:725:b347:c3cc with SMTP id d2e1a72fcca58-7273cba78b1mr3966391b3a.23.1733799650593;
        Mon, 09 Dec 2024 19:00:50 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725eab24e05sm3062234b3a.133.2024.12.09.19.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 19:00:50 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Cayman Islands (KY) for 2024
Date: Tue, 10 Dec 2024 11:00:37 +0800
Message-Id: <20241210030037.6380-1-pkshih@gmail.com>
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
 db.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index 24195fcac004..37597f9add41 100644
--- a/db.txt
+++ b/db.txt
@@ -1066,12 +1066,15 @@ country KW: DFS-ETSI
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
+	(5470 - 5725 @ 160), (250 mW), DFS, AUTO-BW
+	(5725 - 5875 @ 80), (1000 mW), AUTO-BW
+	(5925 - 6425 @ 320), (12), NO-OUTDOOR
+	(57000 - 71000 @ 2160), (40)
 
 # Source:
 # http://adilet.zan.kz/rus/docs/V1500010730
-- 
2.25.1


