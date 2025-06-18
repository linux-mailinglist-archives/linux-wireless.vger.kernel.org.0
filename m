Return-Path: <linux-wireless+bounces-24236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5A9ADE32D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 07:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8429317ACBE
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 05:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A7C19F10A;
	Wed, 18 Jun 2025 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQOEEMGs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4CA93D
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225769; cv=none; b=IeNIDZGU47B2ObBDBauUrUeNOyQ7RQz/aUv94B2K7KhMVFjLS7EbY4WLk0Y5AwTBNH2Jo3CIgCHlvQoRck1cvW4pp8QY3naio/MRf2iMR4FxB+JQy0OAITEe6PLi2Gm38L9QkoPVqOYE6A29tFdlHsxPJJM23Tfw7qZgxkUpWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225769; c=relaxed/simple;
	bh=4ealcSewFFWg7Vt5sOfFmvMAxpWpHGVj1mdV4wAP8WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jykVVi8F37VxHvZefry0hERnla5ASafhwrOBV5G2wrEih3aX4FTUxH8jM2NIbozDGmDusyD3U0laQcuZGQCwUVHnti1V6lVleNvppvtHf2540zBe0gNa5pVQuKaITTFAgN4gOWIvg7H2x7awgO5ccrUnYFHuV+6Zmhn6GSbbH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQOEEMGs; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso7763266a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 22:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750225767; x=1750830567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yl03F77x7X0pfLzfRRbzE9IQMa3TVDzSlJ+zUSG7hg4=;
        b=mQOEEMGsauhRP/S1mxDoByKhZi3ZT5HOlpZWmGKRDGhZP/1z2oGS4NcmSkasbNcfEN
         8XPffPE5b4DZuNP3f7K8BBfJR2uffrhoyWbdMi2596+2mqzrHjeISADRKibanCD4aqO0
         gk639GivM0jPAR0KEYYjhlWUBs4cF+XiqTU+M6Wk98usDaInP/7BpI7kKaOnBOjy2q57
         GYSfNH9bqbFGfyn90644SxIq4e/SBrOyLFGemUWlPxQJ1hr3k1uKp0hv5CcrkRAb1GOk
         6KXSZ51SEfUGNQ/wFACEy3d74NlooHY/bppw43vsMRbtcdB3vH0hAFy9TuGcuPBDXiFo
         Qh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750225767; x=1750830567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl03F77x7X0pfLzfRRbzE9IQMa3TVDzSlJ+zUSG7hg4=;
        b=dxQIE+2x09xC2TJZi+57r17Jt8nKyauRfRE/uTtUzttbQG/EYQeSV9ebRab++mRALG
         650olkJnoHayZS0qCL29s0l95ozYVJXE1AEAFeaa6uqe+dNxWDjZczfqN5JloSsBPYL2
         3qHgBDqEDVaFpcZuVw+A/AQ3z768WeA3ndVLDaM3wdSxYeckWhRT179tEYKon23TG+Po
         gQKuT7oGBs+BQJGimYnyWYphF4hec2roE+lbuQE2CzkIwsUO47tnx5BGneE3SbIIS2DR
         TLZ/OjviSvEBiKzdCl7lUiKPC0knWSGdMpZZPDhKkMQAvYf0uzXDMZjp6avViW0mIeNT
         MgwA==
X-Gm-Message-State: AOJu0YxCsJK7JWmHP32Q7Kfih+ihdJvxwYMD0UqdgIDgX7Ui4aZjbTRe
	T7iKBXQJpvdd27Kc5Pf6zcsxxRDP6VDczFRwrRiX7DqwYikMRZQzAHux
X-Gm-Gg: ASbGncvVRVadQe2s8xDSmqfJoXkYAEtGgAMSvRPBBlZPOpZcAswEVHBop8Mwg3u8WiH
	ZbAH8pzDreMRPfhnLpmjFFN1V2HyEyZTWSqOUJfVoAKospMwcFnGMR8O9h6P42ZYP5UhC39JJwm
	1oeN6gRkAfOMC7HikKHR8vgrZ9kvEAslwb8DA47UDnSd8/1Vc5SF9GOoY3zLREibB2pYoaYQyZT
	lzT8wq/LF9H+3+mQEUrZBV5oBOobdtzQRQRSotHG39Bga+yR+gI4dimqSBksvd9dx26roBPmcXl
	jpR8Hs3pn/zPzbL+tIk2ZHepqWQMXqpa4wRGesHOrw5C3HJC912C6t5gx37beKJbSjmmsDWlKvc
	BtYE1MSMQ9oihUQ7ihpBuo/Y47sutK2vr52crMbk=
X-Google-Smtp-Source: AGHT+IH8Vhu+Z2PQyXbK4DSQd63bQSdTCFrq4+W5hfzDqDTcu33WofNAyXYZ/crpEphkvujak7Tr7w==
X-Received: by 2002:a05:6a20:d049:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-21fbd459503mr26683661637.7.1750225767178;
        Tue, 17 Jun 2025 22:49:27 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7488ffecccesm10045865b3a.5.2025.06.17.22.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 22:49:26 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Egypt (EG) for 2024
Date: Wed, 18 Jun 2025 13:49:04 +0800
Message-Id: <20250618054904.9107-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

National Telecommunications Regulatory Authority (NTRA) released Radio
Spectrum Guidelines for Short-range Devices (SRD) on November 2024.

As Table 4 Mandatary requirements for Wideband Data Transmission Systems:
Including Wireless LAN (Wi-Fi and Multiple GIGABIT wireless systems for
Indoor applications only)

* Wi-Fi for indoor applications only, so add NO-OUTDOOR for all entries.

* 2400 - 2483.5 MHz
  - 100 mW e.i.r.p.
  - EN 300 328
* 5150 - 5350 MHz
  - 200 mW e.i.r.p.
  - DFS and TPC in 5250 - 5350 MHz
    * for devices without TPC, the limit is lowered 3 dBm
  - EN 301 893
* 5925 - 6425 MHz
  - 250 mW e.i.r.p.
  - EN 303 687
* 57 - 66 GHz
  - 40 dBm e.i.r.p.
  - EN 302 567

[1] https://www.tra.gov.eg/wp-content/uploads/2024/11/EGY-NTRA-November-2024-SRD_English-1.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index e331d4f763e3..4a05bdca781e 100644
--- a/db.txt
+++ b/db.txt
@@ -632,11 +632,13 @@ country EE: DFS-ETSI
 	(57000 - 66000 @ 2160), (40)
 
 # https://www.tra.gov.eg/wp-content/uploads/2022/03/EGY-NTRA-March-2022-SRD_English_Final.pdf
+# https://www.tra.gov.eg/wp-content/uploads/2024/11/EGY-NTRA-November-2024-SRD_English-1.pdf
 country EG: DFS-ETSI
-	(2402 - 2483.5 @ 40), (20)
-	(5150 - 5250 @ 80), (23), AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(57000 - 66000 @ 2160), (40)
+	(2402 - 2483.5 @ 40), (100 mW), NO-OUTDOOR
+	(5150 - 5250 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI, NO-OUTDOOR
+	(5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW, wmmrule=ETSI, NO-OUTDOOR
+	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
 # ES as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1


