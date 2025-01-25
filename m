Return-Path: <linux-wireless+bounces-17920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA8A1C00B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 02:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5E17A3A25
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 01:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FDC79EA;
	Sat, 25 Jan 2025 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quartiq.de header.i=@quartiq.de header.b="lZhoI7e7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B84C9D
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737767542; cv=none; b=tiY01xVxGlrx51E9XSrUiXBfAKR13votRIZPIy2IgiPZ4HA8OA18Fd2mLJQDQ749H09riNMDHiORZZ1v7gtqzc2g/nZT0tZi9UsaZ3GxCDEf3PdGl3KBXxeIDkK6ac3INXDw238jd5pcMHdUOh4zdOJNRt62VJ4giepGgQzbAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737767542; c=relaxed/simple;
	bh=ozLolCnTz92HDtrUu4g8dPDIl2523guaGsWNFAy4wgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GxoNkpNy8wlhaiIIAe5dYiL2xBop6E5Tv9W415JCt+3lVGs6JzTaVglUN13/wB+CVGuyF0BHbF+AOnc1jYZeyBZLMKq4eEJrKF2HjtupYOr9fM00XZy+L33bbre8GGI/9HVD2BHnvf1L/edJOp0R+iULft/syEl4JN0ABrJ0/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quartiq.de; spf=pass smtp.mailfrom=quartiq.com; dkim=pass (2048-bit key) header.d=quartiq.de header.i=@quartiq.de header.b=lZhoI7e7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quartiq.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quartiq.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso18986205e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 17:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quartiq.de; s=google; t=1737767538; x=1738372338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwVtXUTYK1ScSLpLTzgFTxDOlPy01peny8w6WcaBsPk=;
        b=lZhoI7e79Zj8l2m1vz/WEpMuDWT97BD4evfAye3/ZXR0++XJnpXWTn2yfdL2AQTJeU
         rsntyDOo4shL+wcytl1lAD2TxuzOx2euJxKRSa80in1R3iOTe2vYVVTVcq7CzBURsc4u
         9M9E9+bebL90BreS8mTf9VyDe0uE/yXDr+0S5AxMQuDDT37n8M2lEciG+oiyRCug7XpJ
         Po5ik56ksE0PqIq4kXAz/nnNJE/OkOfbvqSG0g/vSxGnQLrUH3jS0cEoRRBgHfx0fNeR
         TGym64YgbGyoDBBBzlfTPZiaK2LpcSWUL36C9NxUmo2W28tD6lmoUHFoPO+9xL9RfyVG
         MTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737767538; x=1738372338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwVtXUTYK1ScSLpLTzgFTxDOlPy01peny8w6WcaBsPk=;
        b=CMlZ0UzJo41JEBlPtLljwvOaz4O3bbULYuLPqJIHVL1wMWtnjqQG2VEvpeBptueQwQ
         Jqr55StggmU+5ppTcwky0pqxyPNwJXBiGe5PbSAb9D9tIBnILhTqLGbDz43ewqz9U/xN
         CG6ZrDKGV58YgOs60aau2slkdwOeJzpN0DXOgsqA8TEp1TdTb9LyoOLm791e1upkaz/B
         TtDrLakvhlzZe+BtavEszW9GEFrBseLNJLMplfSKy0Vj2v+2cCB0tPoiHf6DLwz5zEu3
         cYkEDZctFeBRpx8cJNvgz1RzB0bQV/wzEQ+y6vV7QK8be1WRoA17LqDBKkR57A+9wvpx
         Ge/g==
X-Gm-Message-State: AOJu0YxjF8MyjygpZ5Xi0C0upERMHwfhq9siqLHRRI2LEBBiDsLU9k5e
	a6EKlrmAZpsOgAb0PyznArscFNNuJ94R59ML9nv0UVI2dWlJtup+Q2dacydICP/xNJGKmlmG1v2
	S
X-Gm-Gg: ASbGnctIWvWk+susw2/U5Ng5wuHhi6V13+VJ8K5rkB9o9C+RgZNra58MEaUP0H5oQb5
	BKzoJreZdPg141uQt4n0t6Q5u1FxlmPRIk7sxZ5NucUi7B9l2OIoS/9QCvV5CjVAzAwGFBimF4a
	BJDja919YPqnRkVErrDAaqeWRmWDpevRuvib0VpK1fPESiHsCNtperMHf0bnPk2+pmOaCBtzC8Q
	HhUzsbCnmO8htgEYbNKdOfzIzn06IwPhrQ6jtRn9XmwfWDGhxt+UoiFs/l8W0C9o4JMqJVNRpd/
	bmfjY3+cT9c=
X-Google-Smtp-Source: AGHT+IHBfPSLJD8qJkFYWneG6ny2qrpVZnoRj4Y+tzKHv7wmOsWznIRU9MSkQEKvul6Um92wqtpDbg==
X-Received: by 2002:a05:600c:1f86:b0:436:aaf:7eb9 with SMTP id 5b1f17b1804b1-43891439d5fmr267420175e9.20.1737767537997;
        Fri, 24 Jan 2025 17:12:17 -0800 (PST)
Received: from grouch.rj.joerdens.org ([2001:9e8:ae5:cb00:8562:3ae4:3d74:b0c3])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-438bd54c098sm44359985e9.31.2025.01.24.17.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 17:12:17 -0800 (PST)
From: =?UTF-8?q?Robert=20J=C3=B6rdens?= <rj@quartiq.de>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	=?UTF-8?q?Robert=20J=C3=B6rdens?= <rj@quartiq.de>
Subject: [PATCH] wireless-regdb: Permit 320 MHz bandwidth in 6 GHz band in ETSI/CEPT
Date: Sat, 25 Jan 2025 02:12:10 +0100
Message-ID: <20250125011210.56371-1-rj@quartiq.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This increases the allowed bandwidth from 160 to 320 MHz for the
5945-6425 MHz band to support 802.11be (Wi-Fi 7) EHT-320 for the
ETSI/CEPT harmonized countries (EU + CH/LI/NO and TR).

Previously the bandwidth limit was set to 160 MHz to match 802.11ax
(including the 6 GHz extension called Wi-Fi 6e). This limit is not
supported by the current regulatory documents and should be relaxed to
320 MHz.

The 802.11be (Wi-Fi 7) standard defines EHT-OFDMA for a 320 MHz
bandwidth. Devices (both AP and STA) supporting and using this are
widely available now. The "6 GHz" band starting at 5945 MHz is the prime
target for these wide channels. In the ETSI/CEPT harmonized countries
the 5945-6425 MHz range has been allocated to WLAN. It can contain one
320 MHz channel centered at channel 31 (6105 MHz) and one overlapping
channel at centered at 63 (6265 MHz).

Note that the supporting documents quoted currently do not have an upper
bandwidth limit:

EU: https://eur-lex.europa.eu/legal-content/EN/TXT/PDF/?uri=CELEX:32021D1067&from=EN
    and https://docdb.cept.org/download/4577

Adoption by e.g.
DE: https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/MobilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf

CH and LI: https://www.ofcomnet.ch/api/rir/1010/11 (note the explicit empty bandwidth limit)
NO: https://lovdata.no/dokument/SF/forskrift/2012-01-19-77
TR: https://www.btk.gov.tr/uploads/pages/ftm-teknik-olcutler-ek-5.pdf

Note also that the EC mandate to the CEPT to investigate the upper
6425-7125 MHz band for future use explicitly confirms that there is now
(2024-12) one non-overlapping 320 MHz channel for 802.11be available in
the existing "mid-band" (i.e. 2.4, 5, and 6 GHz) allocations:
https://cept.org/files/6813/Mandate%20to%20CEPT%20upper%206%20GHz%20band.pdf
(page 3).

The 160 MHz limits for the 5 GHz and 2.4 GHz bands can remain since there
is no possible configuration for a 320 MHz channel there.

Signed-off-by: Robert Jördens <rj@quartiq.de>
---
 db.txt | 60 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/db.txt b/db.txt
index e282e3b..2badb01 100644
--- a/db.txt
+++ b/db.txt
@@ -125,7 +125,7 @@ country AT: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -225,7 +225,7 @@ country BE: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -276,7 +276,7 @@ country BG: DFS-ETSI
 	# I.43 of the List, BDS EN 300 440-2, BDS EN 300 440-1
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	# II.H03 of the List, BDS EN 302 567-2
 	(57000 - 66000 @ 2160), (40)
@@ -396,7 +396,7 @@ country CH: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# https://www.ofcomnet.ch/api/rir/1010/11
-	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (200 mW), NO-OUTDOOR, wmmrule=ETSI
 	# https://www.ofcomnet.ch/api/rir/1010/07
 	(57000 - 71000 @ 2160), (40)
 
@@ -487,7 +487,7 @@ country CY: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -507,7 +507,7 @@ country CZ: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -551,7 +551,7 @@ country DE: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -572,7 +572,7 @@ country DK: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -624,7 +624,7 @@ country EE: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -650,7 +650,7 @@ country ES: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -674,7 +674,7 @@ country FI: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -700,7 +700,7 @@ country FR: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E low power indoor
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-6 (ETSI EN 302 567 v2.2.1)
 	(57000 - 71000 @ 2160), (40)
 
@@ -778,7 +778,7 @@ country GR: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -847,7 +847,7 @@ country HR: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -875,7 +875,7 @@ country HU: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -901,7 +901,7 @@ country IE: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -967,7 +967,7 @@ country IT: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1153,7 +1153,7 @@ country LT: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1172,7 +1172,7 @@ country LU: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1191,7 +1191,7 @@ country LV: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1333,7 +1333,7 @@ country MT: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1424,7 +1424,7 @@ country NL: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1444,7 +1444,7 @@ country NO: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# WiFi 6E
-	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (200 mW), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 71000 @ 2160), (40)
 
@@ -1549,7 +1549,7 @@ country PL: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1581,7 +1581,7 @@ country PT: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1631,7 +1631,7 @@ country RO: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1693,7 +1693,7 @@ country SE: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1738,7 +1738,7 @@ country SI: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1759,7 +1759,7 @@ country SK: DFS-ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
 	# 6 GHz band
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
@@ -1847,7 +1847,7 @@ country TR: DFS-ETSI
 	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5250 - 5330 @ 80), (20), DFS, NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5470 - 5725 @ 160), (27), DFS, wmmrule=ETSI
-	(5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=ETSI
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=ETSI
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
-- 
2.45.2


