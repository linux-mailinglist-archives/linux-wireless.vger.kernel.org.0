Return-Path: <linux-wireless+bounces-24931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A541AFC9B2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE167ADE3D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619E52690D1;
	Tue,  8 Jul 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABK/88kr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6812238D53
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974558; cv=none; b=LFkgi3g2E6+Iy2EwHHH0YWp28APwhFbY1JSZ3yfNcSbX6OObjBOSE3BgKOyOoTwZDE09y1eW+ao+d8Rqt5F1IafE0alEyXfgLjJX3iO0HWkTWmrD7WUG25nVMncMyj11AeBaPL5CMb21I2bFOfmYXqzlBCOGg7qohku091JoWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974558; c=relaxed/simple;
	bh=wpS34UGNPKhB3Y7a1GX5klnchvzmHEtKO4mzeGM9c+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ffDmb/Ro7S7D1813mdU82Hv+Jjb94i4DOvu2TpZImh0F8Q3/rZ6NrCc9elgRb0unF36CYWMBuHp+33vvNsas0gNhc0YRChwxvo9G0+lPOIZh2rsXDmGt9G2n/tl5VfMldvtKWzIrLRjQZ84N0JY6Z1+hxKZ/NdkNWenTC89XjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABK/88kr; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3220c39cffso4188603a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751974556; x=1752579356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2i29mDJnSXB2gW6vjG0iEU6TSVwxx53lisQx+OOeKA=;
        b=ABK/88krMe6iBKnFY8F3bVGFYreTN5MTBeZd0h09WpjT21B2aY4ACPzBixRS81MPdR
         /QuycycwxVy9v40gSX/vNdX7++pfyDx/Vs4xh36UM/cA7bwFE/vR0qoFGXNmTvLqMXOz
         rH2q6hjwaFjUQ7u+tdfpqNDzAxakCU+XKpOHULWUggi60u1DiWyY2EYcPaJewnrQ8VoC
         qeFCx0xM+zX+vHQ5P9mHrlVxQuDdtQOm3Bq+fgkXPL1pTFAtGXOVyjfuHMuj5otxl326
         pvlN9yoCmxhq7G9QMdf4/rIqjMEdzD7vTg4nU07W85KGZ9A9lGALhV7jbrZSyIMAFxlz
         nFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974556; x=1752579356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2i29mDJnSXB2gW6vjG0iEU6TSVwxx53lisQx+OOeKA=;
        b=WDm8mNsgjZDNZvfUHOr6pq+WYMQ6agj7JMW5bvz/noJMY9krU1PieuyxEGydKYmT2b
         dk5vZ7stIRrVvOn2CQC8e89/02CIHENA0ZOJwj+stHwooh94Gw7DYzEPfMunIR2tSLhX
         CnBHp07Z7pBKjgduWO4aQ9WJ+qazQRgQR/g4fxd8ZEdSf/9OLExN6ec0Rh2FI5oUlLOs
         tyN3DiiViZyHzzUDEOIONxdeNBXSoxjjl6yDV3M4c9IGyOXvcOKwjsaZFBpBkF89I1ZA
         oMyj6vFD3bCfJwhemjeO4SW4Vt0kD9k5P7oSGD/bPF9Yvcw5/F60tOMPgJH4h3n2pFjI
         u/vQ==
X-Gm-Message-State: AOJu0YyeK1LevuIfQ7EICcoDnSYF9PAhDH06aHVzQ/ftNCyQZgUGOpw8
	DqReUhe4ohlKcvXphLR5VJH8gdWoqN0q8w8aYJwZ0PxoJ3IBW5Vu432d
X-Gm-Gg: ASbGncs/r5A6hmD+GlaGPVKDfBuESKyit5lbV2BhgJ6QkCfv3UnuTQa0J0WzNDJdROS
	lJk3mfNw5lj5fzILy0OGxpDsmPxwurdS60vEjiC5aU9lFttAukdyAbkrXbEYoM7c6OHGFANRzoT
	LLsfEOYvEKf07svVJTe1WVMTDc5U6OShBhIDBlcfVDYHzaYduUe7tpfS+sn5kjMaKZczyRai7PR
	EBnsrnEAYvMaNO8DugJWbmMocoHeIlv3+811G1pA3aFIDQPL+8MOOnZWzNYubRhcWXheFC2NGvH
	V7rRyTQsAly87KWK9fCK09ZTg7Gb7rstQF5G6WhYRdX6OPPk/HXHh90VZyOmIolXe04rNTp1viw
	SX/VM7d9ZBCjwarlQBg3WqvVVl3TnN1JFfdEr9PsnLXX8ri0=
X-Google-Smtp-Source: AGHT+IHBcvz1E4nu823DV3u4R52vj198jlZBPLPlpuWBvufn4TptQGtUV0gBNjjnecZFLZCOlhBJEg==
X-Received: by 2002:a05:6a20:7f89:b0:220:7e77:f4f7 with SMTP id adf61e73a8af0-2260c2401efmr27389681637.25.1751974555983;
        Tue, 08 Jul 2025 04:35:55 -0700 (PDT)
Received: from localhost.localdomain (125-231-129-141.dynamic-ip.hinet.net. [125.231.129.141])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74ce359df4bsm11987658b3a.21.2025.07.08.04.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:35:55 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: update regulatory rules for Bosnia and Herzegovina (BA) for 6 GHz
Date: Tue,  8 Jul 2025 19:35:44 +0800
Message-Id: <20250708113544.3557-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

For CEPT countries, ECC/DEC/(20)01 [1][2] decision enters into force
on 8 November 2024; preferred date for implementation of this Decision
shall be 8 May 2025. Update regulatory rule for Bosnia and Herzegovina
accordingly.

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

[1] https://docdb.cept.org/implementation/16737
[2] https://docdb.cept.org/download/4685

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/db.txt b/db.txt
index 12ac14766a69..81ff14ecaac3 100644
--- a/db.txt
+++ b/db.txt
@@ -201,6 +201,9 @@ country AZ: DFS-ETSI
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# Harmonized CEPT countries for 6 GHz (ECC Decision (20)01)
+#  https://docdb.cept.org/implementation/16737
+#  https://docdb.cept.org/download/4685
 country BA: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -208,6 +211,7 @@ country BA: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
-- 
2.25.1


