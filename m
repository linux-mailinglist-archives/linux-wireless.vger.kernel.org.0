Return-Path: <linux-wireless+bounces-24897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF88AFC03D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1A9423B80
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 01:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5606A1CEAC2;
	Tue,  8 Jul 2025 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0jOBaUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092991F63F9
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939420; cv=none; b=hj835qLcX6rUlrS/H50zPZOzmoiQOrIUVoFno2oLzJgtuoFwNunzbgQCDb3Tmj4+G8KU8A1I4EIJccTi6WG5cc5U3npK8v43H3Z6Kb4kIlS6gu9hefF0XSRDAufFXtKbrkl8bmMgzsANW9PLGoV+WZeAU2fbZS9sqs62+lyrS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939420; c=relaxed/simple;
	bh=gShpwQvGOge6tWBBkMVgFVVta3dPIozIAEjUne2wuqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t5ThDBGE9OlBN651M3dhEamDBbC8qmSh4Bru/q7GF7v0Q2gDJZ/2m5RD/2echDybnznXFsBjFKSLg93eodR5zMMQFzsiAe6xFZVeDOmKbxI3Id7NrQZSsDLNHKnUHeaYToEgdv/4bndApGEYOF9xoB6YtfvHdZi3WR8HMV5ZHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0jOBaUA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso3321874a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751939417; x=1752544217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PdAC96L5hPhEjo/RKW/zIqf6kTbQKsopFGkQP1KBlQE=;
        b=g0jOBaUAXvYduTTZ4QAE3Q5Rb8FsCWPIGLH11ImnckrPOIsQlJecuJ/np+9ppzOV+1
         Wd/0QCOKmY+dtyD7ChKxWBiONGq4AytTi0bnKIv1ZISJfz/E6oUkbYUitW04FN0D7wST
         K1/RipLcGEGNfsqPdMHb8YrFRbjUaW9BcUP76O7aQDXUprrGiStYDI4I7dil9wf1u1Rl
         AKzWTsvY54rEOv9K3N+IuM6fM7oqp1aD85MQd/3Eyp5XY7SrkgJBYNIHPfezemTbBZhU
         QxXz40wbWFwbnT1eQ2kr9DDpCIWY1qpLSYWEOs/JrNxApssHPQVroUVYNEDzYy3nIF7S
         0g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751939417; x=1752544217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PdAC96L5hPhEjo/RKW/zIqf6kTbQKsopFGkQP1KBlQE=;
        b=hhQlnRJ+TT4XftxQMacgy5fngS5w5p+aKffx7mUYk+9IJBFdaqmGwx032kxOv6O2wl
         LrTabRrnKYR3XqpjU1tzRAyyD6bNfzrkkf5qhsRRSV0ntyBeUXnlLTVua936a1gTE2oj
         3yEUrJ949lBmnEgdawgOaa8nJaVInhTJmMBIadXjLCjj1D+FKovWAvLPGhDMuwSfv1jq
         3TggsNUalXqSrZuRwrx1arZcD/uxsMYAkv1bWD+6fYgz9n0djnD6xtDXetTffPMOI1ty
         /GrObT5trRHsAO9koPP4w+Q5UxxDgvnMpEaasDK+iQUlWXrE63d1OBWvuyKOjdb/9Ks3
         teDw==
X-Gm-Message-State: AOJu0YzfSRnhLgTrUhPAgbh+NY0MdmRq/YS0c8oEHsQWyNJcpLsG7Q/l
	d+bftQMdLADyPLoF7Vkg5NrwjPm+g41c252qQhFBsvI13FTwc+9pdU08
X-Gm-Gg: ASbGnctw+1UivRKNTmUylizcP8Pw34qmN6uHL2VKue01ZqnxFfR7IrjTivQ8AOi996B
	W4auPj/N2XvZYDG1YQv+vYCVI3+h6dhh+vkEVD+U9Xt7c644LTEH/JYbHjdZJg6dBo8QtFkHYYD
	uLEWHOMjQdVsiDd4hjcKvwGq7sV49e0n3xCf9IMcPIxf4S4xZ/6or8TJEsAKfhOf7AI0NLJAyZL
	naqkBgPekomWZ84a8am2V5U/pKk0F65faQ2dcMex2KnISKiHtRRa0v2q0EgY4EGiOWi9VxB7+gq
	pNagEi05dzMZ3Unew6UIpGD7WGouRQJVp8GnBhzlsGtlT4f7a9e7hmsznw3KXkkeNanStcB86vs
	51ELJQBTLIIqMJilW0AjfVJz48Jtb/HcWe0lfRms=
X-Google-Smtp-Source: AGHT+IF/z1jnbsLv7tyqMmw/efaMuzaXdewn/ISQLPUxeR3Dl7q+IybBu2CRmR56GD0bE6+DE9TI7Q==
X-Received: by 2002:a17:90b:4cc6:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-31c21dea2ecmr1310057a91.26.1751939416972;
        Mon, 07 Jul 2025 18:50:16 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31c21b8f670sm652519a91.0.2025.07.07.18.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 18:50:16 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v3] wireless-regdb: Update regulatory info for CEPT countries for 6GHz listed by WiFi Alliance
Date: Tue,  8 Jul 2025 09:50:05 +0800
Message-Id: <20250708015005.6470-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
countries including
 - Albania (AL)
 - Andorra (AD)
 - Austria (AT)
 - Belgium (BE)
 - Georgia (GE)
 - Iceland (IS)
 - Liechtenstein (LI)
 - Macedonia, The Former Yugoslav Republic of (MK)
 - Moldova, Republic of (MD)
 - Monaco (MC)
 - Montenegro (ME)
 - Norway (NO)
 - Switzerland (CH)
 - Türky (TR)
 - Ukraine (UA)
Add 6 GHz frequency entry if not being added yet.

The following are skipped as they do not have corresponding entries in
the database yet. Adding an entry just for 6 GHz would cause 2.4 GHz and
5 GHz bands from the world domain to stop working.
 - Faroe Islands (FO)
 - Gibraltar (GI)
 - Isle of Man (IM)
 - San Marino (SM)
 - Holy See (Vatican City State) (VA)

Links of all these countries are to point to ECC/DEC/(20)01 [2] [3], which
decision enters into force on 8 November 2024; preferred date for
implementation of this Decision shall be 8 May 2025.

 * LPI devices
   - 5945-6425 MHz
   - Restricted to indoor use only
   - Maximum mean e.i.r.p.: 23 dBm
   - Maximum mean e.i.r.p. density: 10 dBm/MHz
 * VLP devices
   - 5945-6425 MHz
   - Indoors and outdoors
   - Maximum mean e.i.r.p.: 14 dBm
   - Maximum mean e.i.r.p. density: 1 dBm/MHz

[1] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
[2] https://docdb.cept.org/implementation/16737
[3] https://docdb.cept.org/download/4685

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3:
 - remove non-CEPT countries which WFA lists them, but not listed in [A1]
 - FO, GI and IM, having no database entries yet, are not listed in [A1],
   but they are territory of CEPT countries, so I still keep them in
   commit message.
 - [A1] https://www.cept.org/cept/membership-and-observers
v2:
 - reword for skipped countries
 - add [2][3] links to countries mentioned in commit messages.
   (suggested by ChenYu. Thanks!)
---
 db.txt | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index cff2361237ac..12ac14766a69 100644
--- a/db.txt
+++ b/db.txt
@@ -34,6 +34,9 @@ country 00:
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries: https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country AD: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -41,6 +44,7 @@ country AD: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
@@ -73,6 +77,9 @@ country AI: DFS-ETSI
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country AL: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -80,6 +87,7 @@ country AL: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source:
 # 2.4 GHz https://www.psrc.am/contents/document/4749
@@ -120,6 +128,9 @@ country AS: DFS-FCC
 # Harmonized CEPT countries (February 2021): https://docdb.cept.org/download/25c41779-cd6e/Rec7003e.pdf
 # AT: https://www.rtr.at/TKP/was_wir_tun/telekommunikation/spectrum/bands/1997_bmvit-info-052010en.pdf
 # AT: acceptance https://www.ris.bka.gv.at/Dokumente/BgblAuth/BGBLA_2014_II_63/BGBLA_2014_II_63.pdfsig
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country AT: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -220,6 +231,9 @@ country BD: DFS-JP
 # BE: https://www.ibpt.be/public/files/en/21761/B03-02_2.1_EN.pdf
 # BE: https://www.ibpt.be/public/files/en/21762/B03-03_2.1_EN.pdf
 # BE: https://www.ibpt.be/public/files/en/22165/B01-28_3.1_EN.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country BE: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -391,6 +405,9 @@ country CF: DFS-FCC
 # CH: https://www.ofcomnet.ch/api/rir/1010/04
 # CH: https://www.ofcomnet.ch/api/rir/1008/12
 # CH: https://www.ofcomnet.ch/#/fatTable
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country CH: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -738,10 +755,15 @@ country GD: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country GE: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (18), AUTO-BW
 	(5250 - 5330 @ 80), (18), DFS, AUTO-BW
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
@@ -957,7 +979,9 @@ country IR: DFS-ETSI
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
 # IS: https://www.pfs.is/library/Skrar/Tidnir-og-taekni/MHZ_21022019.pdf
-# CEPT ECC Decision (20)01 for 6GHz: https://docdb.cept.org/download/1448
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country IS: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1128,8 +1152,10 @@ country LC: DFS-ETSI
 # LI: https://www.ofcomnet.ch/api/rir/1010/04
 # LI: https://www.ofcomnet.ch/api/rir/1008/12
 # LI: https://www.ofcomnet.ch/#/fatTable
-# CEPT ECC Decision (20)01 for 6GHz: https://docdb.cept.org/download/1448
 # LI: https://www.ofcomnet.ch/api/rir/1010/11
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country LI: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1227,6 +1253,9 @@ country MA: DFS-ETSI
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country MC: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1234,6 +1263,7 @@ country MC: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source:
 # http://www.cnfr.md/index.php?pag=sec&id=117&l=en
@@ -1243,6 +1273,9 @@ country MC: DFS-ETSI
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
 # https://www.legis.md/cautare/downloadpdf/134846
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country MD: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1259,6 +1292,9 @@ country MD: DFS-ETSI
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country ME: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1266,6 +1302,7 @@ country ME: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 country MF: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
@@ -1285,6 +1322,9 @@ country MH: DFS-FCC
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country MK: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1292,6 +1332,7 @@ country MK: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
@@ -1455,6 +1496,9 @@ country NL: DFS-ETSI
 # NO: https://eng.nkom.no/technical/temporary-licenses/mobile-videolink/wireless-cameras-mobile-video-links/_attachment/9947
 # NO: http://www.lovdata.no/dokument/SF/forskrift/2012-01-19-77
 # In addition to EU NO can use 5725–5795 MHz and 5815–5850 bands with limit of 4 W EIRP (with DFS and TPC)
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country NO: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1865,6 +1909,9 @@ country TN: DFS-ETSI
 # Source:
 # Technical Criteria for Radio Devices and Systems Excluded from Frequency Allocation, Sept 9, 2022
 # https://www.btk.gov.tr/uploads/pages/ftm-teknik-olcutler-ek-5.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country TR: DFS-ETSI
 	(2400 - 2483.5 @ 40), (20)
 	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1921,12 +1968,16 @@ country TZ: DFS-ETSI
 # 2.4 GHz band channels can be used outdoors when some requirements are met.
 # 5 GHz band channels must be used only indoors in some cases. They are neither
 # permitted nor denied outdoors in others.
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country UA: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW), NO-OUTDOOR
 	(5150 - 5250 @ 80), (100 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5470 - 5725 @ 160), (100 mW), DFS, NO-OUTDOOR, wmmrule=ETSI
 	(5725 - 5850 @ 80), (100 mW), NO-OUTDOOR
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40 mW), NO-OUTDOOR
 
-- 
2.25.1


