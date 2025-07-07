Return-Path: <linux-wireless+bounces-24869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86642AFAA9A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 06:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B403BAF09
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 04:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077CF25DB1E;
	Mon,  7 Jul 2025 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP89+wXZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF725D54F
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751862961; cv=none; b=cyS4hMx8/wDQ5CNtUBYYL2Wpd4QVXU3MZq23B4zaVYdfMc8yKaV+3QZOb59Qs2q0W83YY0vuJY+E3ZiVy6VDXUX2FVTQKFfx8UEof7Db9bTGQpYAY67/NzZLOa03O4c7Xd0rzBsrtGcn2JKZRBYBiGeEPdo05aItiy17ylayF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751862961; c=relaxed/simple;
	bh=O78n4syA6z/RECkY+ICNyMWLp+7O4zJr3yYwrEnF/lU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QRZJwIWMV7RVskBJHj+rO/QvKD30KFB+JFV+nmk4L4ybunypcyJBR3fGXeBJWFHleSKJ/z9GkAkbui4C+LlPKm5L6xTaF81zVQUjQFp4reJLCLKOQIZuZ0JF7FcYZn8aXbVRGxkIjEV8yZ9QLf61J0vfCVYGL7hL4Y8M1y4u4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP89+wXZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b271f3ae786so1918055a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jul 2025 21:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751862959; x=1752467759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohtq7g5R1VXhHqfKXAcKsUruCLq4bxY77nlB5kZruNc=;
        b=OP89+wXZgQVgAiWo/vV3n5wu4r6O2Vy56U6jMWt7GV7ebpMic7W8metdyogww+VOJG
         fTwx+QftRNGt4JNqvt0/p3UJUyg3054cSCETHphK2G5LkDGSvhV/XGQcnNq7WzCbXOfE
         PHDhI1Vf5me5OLpLcVs8mH+1Em+xyngBHBAv6Bcba0yyUEE2DhvBxEfIvPZtMKJTH3AT
         5uALlF4o6Hi9ah7CIHkEwEt6oX8083AZDj/ruj8gEb7c9AQRkmshnCSFtLlFpDHNZHq6
         /VYCnFwDSvfO2cNd9F8hM18mr2nDZiuAmSSE2b7/WwJNfoG3i62/9OGr9MDOYgeDRX6q
         1DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751862959; x=1752467759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ohtq7g5R1VXhHqfKXAcKsUruCLq4bxY77nlB5kZruNc=;
        b=bNV2re7d3Iqn2QVQAPapGWZZ1yM0PhXlgbgn0gEBDr8yR6KQSt58bdLZfGlQGxzxPI
         xWq3cjybEInYHNkjdgv86UfwkS5vDBm7ayHkLv8ld0HeJXentcCi7FGhhzdkFHAfMaea
         g9F4o0EBJOpdydXxbiBh5YVnlM+G/OuImZBxk15euBt44BITGGS02JYMRpDW6NyLw0oU
         GqeVX9AiIg2AE7lrvW2NQO5K4g4YMSJ8bEaTZVp4Ca3OvwVAxt1FQJaSDCut+A36CzI9
         QK5//JfVG2uQAnCF7oVuKfaBBts2ym51MJfzjD+DsxYQezFLEGNV4+DEZAYjkiQf0BZN
         UN4g==
X-Gm-Message-State: AOJu0YxfoHp14c2adHz0Qsax0ASuE7z17v9SBYCvUrMpaY+/fDVcfcn9
	MIWS+vJAdyoj7a57UDNQmZiR0YAGSUdcvL4ufsps0GNKqSpl7BHh8jduIRtB9w==
X-Gm-Gg: ASbGncsfydGKrWtRbFi2WUodZB3HG2KoU1xHkAwdEaDHXYjfIhLIUp2BfPR7lq2AuHD
	pvEv8lJmu+tON/36bKQtt9mL1fBT7m1UhrAHGszUMVsU9no6vihpw+smZ4+BZr6w5m3zkhnTuc5
	QwpZhUh2iFfC9FZZFTChN/YvvXQyokoFjSJbsJ8ACmPh2pZyhAh71XvJA10vpi+iN7y9d0XPvhK
	tMJFWClDYXTNKzJs4QZ2BQTA/PXOzbwnoKKlxWCbn75ujrAbm9uYxwhyhUE/2c4fU1ql/ZeN2VB
	HQ+meyR1Y4KR79ohJx+xcgbxaCiYMkRdae7OphxH+6OirKGtUEyMQ41KI3ap7Aoglm0b5E8S+Tu
	3Xu7aLPk1h+FoOYFO9b/g/4W04jNl79xLVHTg
X-Google-Smtp-Source: AGHT+IGy3WnZIevcAIEpAeGGGIgtPWxrK+s3EP/0XR7KwH6oy/u83aAQjhluXIMHhB2UVgebjykdFQ==
X-Received: by 2002:a17:90b:57d0:b0:30e:5c7f:5d26 with SMTP id 98e67ed59e1d1-31aba8d28a3mr10327971a91.24.1751862958713;
        Sun, 06 Jul 2025 21:35:58 -0700 (PDT)
Received: from localhost.localdomain (125-231-129-141.dynamic-ip.hinet.net. [125.231.129.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23c8455b966sm73379315ad.101.2025.07.06.21.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 21:35:58 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2] wireless-regdb: Update regulatory info for CEPT countries for 6GHz listed by WiFi Alliance
Date: Mon,  7 Jul 2025 12:35:47 +0800
Message-Id: <20250707043547.5740-1-pkshih@gmail.com>
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
 - Belarus (BY)
 - Belgium (BE)
 - Georgia (GE)
 - Iceland (IS)
 - Liechtenstein (LI)
 - Macedonia, The Former Yugoslav Republic of (MK)
 - Moldova, Republic of (MD)
 - Monaco (MC)
 - Montenegro (ME)
 - Norway (NO)
 - Russian Federation (RU)
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
v2:
 - reword for skipped countries
 - add [2][3] links to countries mentioned in commit messages.
   (suggested by ChenYu. Thanks!)
---
 db.txt | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index ed841fe42cd3..568cae03a85c 100644
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
@@ -350,11 +364,16 @@ country BT: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# Source:
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country BY: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 country BZ: DFS-JP
 	(2402 - 2482 @ 40), (30)
@@ -391,6 +410,9 @@ country CF: DFS-FCC
 # CH: https://www.ofcomnet.ch/api/rir/1010/04
 # CH: https://www.ofcomnet.ch/api/rir/1008/12
 # CH: https://www.ofcomnet.ch/#/fatTable
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country CH: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -738,10 +760,15 @@ country GD: DFS-FCC
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
 
@@ -959,7 +986,9 @@ country IR: DFS-ETSI
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
@@ -1130,8 +1159,10 @@ country LC: DFS-ETSI
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
@@ -1229,6 +1260,9 @@ country MA: DFS-ETSI
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country MC: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1236,6 +1270,7 @@ country MC: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source:
 # http://www.cnfr.md/index.php?pag=sec&id=117&l=en
@@ -1245,6 +1280,9 @@ country MC: DFS-ETSI
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
 # https://www.legis.md/cautare/downloadpdf/134846
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country MD: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1261,6 +1299,9 @@ country MD: DFS-ETSI
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country ME: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1268,6 +1309,7 @@ country ME: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 country MF: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
@@ -1287,6 +1329,9 @@ country MH: DFS-FCC
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country MK: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1294,6 +1339,7 @@ country MK: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
@@ -1457,6 +1503,9 @@ country NL: DFS-ETSI
 # NO: https://eng.nkom.no/technical/temporary-licenses/mobile-videolink/wireless-cameras-mobile-video-links/_attachment/9947
 # NO: http://www.lovdata.no/dokument/SF/forskrift/2012-01-19-77
 # In addition to EU NO can use 5725–5795 MHz and 5815–5850 bands with limit of 4 W EIRP (with DFS and TPC)
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country NO: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1867,6 +1916,9 @@ country TN: DFS-ETSI
 # Source:
 # Technical Criteria for Radio Devices and Systems Excluded from Frequency Allocation, Sept 9, 2022
 # https://www.btk.gov.tr/uploads/pages/ftm-teknik-olcutler-ek-5.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country TR: DFS-ETSI
 	(2400 - 2483.5 @ 40), (20)
 	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -1923,12 +1975,16 @@ country TZ: DFS-ETSI
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


