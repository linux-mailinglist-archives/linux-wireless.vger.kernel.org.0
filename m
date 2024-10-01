Return-Path: <linux-wireless+bounces-13367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE298B864
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7191C22E35
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA019ABA4;
	Tue,  1 Oct 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOFuA9mc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADA919D8BC
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775095; cv=none; b=XwsR5M/26tvqyNB1tSnx4p6wTDbPXFbvPsjjoDry4kFKl+P2SftDC+/vvaODP4io4LG/Pvz/W53sjq/XQNib5HG+k9N84x25W00CBrmMnY0GHcc0OTCqwSc0dPae7+3oMmyLOUQ/VHcJ7avdfY+KSLfWrJm2YFYxQGf+bT7wnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775095; c=relaxed/simple;
	bh=3tF4vbOgijTWD/UA3To8SloNHamCgS7uM+qqDFP9V/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3RmGxoS+Kx9QxS/jpRZaLtRGutC0euTPOc878YroxFbfvMUWJuoU3fvZ791kgOrfmGztoD0y7Wn1NxTDRfnXGLLRd086I51Fi1tO6CGTDmeN8zU2aGgXWehurfPSKOkxS/LqNxf2otRjMEbbGSyWjoccXy5mJtO9rAjNECKSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOFuA9mc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b90984971so19136225ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2024 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727775093; x=1728379893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST2qop5iFMqE5KADf9pmpkXfU9fvzDZibt0hwBbJQEw=;
        b=GOFuA9mcJcxYKLj8n59njvVSCbbaoDKGrVgV8KTOm/kPbrb3a208xXRX8F5U3db6/I
         fsQzqngcA2TXUhHF5HzJRgmDNgbmvtMb5OM6m2xyZlt5VoXtZxVSd56Uz78t590G1Gi7
         RJ2BRetA7sVrQUp4Fxnhw9mA2fBTx1IQGpbPVGVOhIhDVUIxdH04A3fDgVw4c2MgQajc
         N0ssqexO6+fK7D7XXUj4vk2RLfZk2yHqJIgU5fdAZs7A/wTi0a4ATwB6Y5XWXJTdkqC/
         kQFf6HwpYtkLRrFbwtYkvpDmFBbVI7GQvh3ptJZ/OiYOL8G51G7EdgViq8+4W72qlb9S
         4MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775093; x=1728379893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST2qop5iFMqE5KADf9pmpkXfU9fvzDZibt0hwBbJQEw=;
        b=PT/hAGIKbw9MEHKDauV0abCG8nzhv0JaPxQV51ZnciOm6FqX0g9SD8tXV2WkI+BN47
         6vEwzjweY2iuPa1VXYeAeyRPOB9Se28yz6AX/iwiVC8yk2Omx5iEz2J7YeBR913uqrkK
         WKNfOHD/rK0i/PPmHzxw610T0t96efofyvJjAhfyjAMgxv/qSv1epmiK67uYqblcQOrh
         dPH2Yl/b2scfLty9QaLZoxaQSMCoiRp/NrASRG6PTSQPqW08T/8Lm/ED4d4tAYX1EQS4
         +9yDByS4u+iJ+k9pS6dDRJ1w+FuQ/jcQqv7ehV226pALBACPY1XI/fpwDWvyMycg++v/
         hs6w==
X-Gm-Message-State: AOJu0YzU3FJffZLZ+QRT/4STO4Pp5MPqK8c74O/IO3L5Vu/QdC+u0bWU
	gfUOJTMw+dTmj7r0KaLADL3BEa5+b6ndoS47EDyuBx0hqXAj5q0OFn62jo01
X-Google-Smtp-Source: AGHT+IHG5EenjYVqfoJiFPgSc8gutfeDjszNYLoPqiXmipJ2sn5RtbzuOzcjylw2HFqIfsAlKUBJzA==
X-Received: by 2002:a17:902:f552:b0:20b:91f5:aae8 with SMTP id d9443c01a7336-20b91f5bc8bmr65947215ad.55.1727775092889;
        Tue, 01 Oct 2024 02:31:32 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37d68906sm66102625ad.38.2024.10.01.02.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:31:32 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 2/2] wireless-regdb: Update regulatory info for Serbia (RS) for 2024
Date: Tue,  1 Oct 2024 17:30:49 +0800
Message-Id: <20241001093049.37515-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001093049.37515-1-pkshih@gmail.com>
References: <20241001093049.37515-1-pkshih@gmail.com>
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
     * EN 300 328
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
 * 5725 - 5875 MHz
   - reference [1] page 123,     section 5725 MHz - 5830 MHz, 12th row
     * EN 302 502
       - 24 dBm
       - 5725 - 5850 MHz, DFS
 * 5925 - 6425 MHz
   - reference [1] page 124,     section 5925 MHz - 6700 MHz, 6th row
     * EN 303 687
       - 23 dBm, LPI
 * 57 - 66 GHz
   - reference [1] page 158,     section 57 GHz - 58.2 GHz, 7th row
     * EN 302 567
       - 40 dBm

[1] https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utvrdjivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
[2] EN 302 328 https://www.etsi.org/deliver/etsi_en/300300_300399/300328/02.02.02_60/en_300328v020202p.pdf
[3] EN 302 066 https://www.etsi.org/deliver/etsi_en/302000_302099/302066/02.02.00_20/en_302066v020200a.pdf
[4] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
[5] EN 302 502 https://www.etsi.org/deliver/etsi_en/302500_302599/302502/02.01.01_60/en_302502v020101p.pdf
[6] EN 303 687 https://www.etsi.org/deliver/etsi_en/303600_303699/303687/01.01.01_60/en_303687v010101p.pdf
[7] EN 302 567 https://www.etsi.org/deliver/etsi_en/302500_302599/302567/02.01.01_60/en_302567v020101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v1:
  - copy stuffs from reverted "SR".
  - add missing stuffs of "5725 - 5875 MHz" and "57 - 66 GHz"
---
 db.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/db.txt b/db.txt
index 54310fb5736d..93043733c3b0 100644
--- a/db.txt
+++ b/db.txt
@@ -1637,13 +1637,15 @@ country RO: DFS-ETSI
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utvrdjivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
 country RS: DFS-ETSI
-	(2400 - 2483.5 @ 40), (100 mW)
-	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
-	# short range devices (ETSI EN 300 440-1)
-	(5725 - 5875 @ 80), (25 mW)
+	(2400 - 2483.5 @ 40), (20)
+	(5150 - 5250 @ 80), (23), AUTO-BW
+	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
+	(5470 - 5725 @ 160), (27), DFS
+	(5725 - 5850 @ 80), (24), DFS, AUTO-BW
+	(5850 - 5875 @ 80), (24), AUTO-BW
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
 	# 60 GHz band channels 1-4, ref: Etsi En 302 567
 	(57000 - 66000 @ 2160), (40)
 
-- 
2.25.1


