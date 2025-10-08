Return-Path: <linux-wireless+bounces-27886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4671FBC4890
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAE7B4E6FF4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8FC224B09;
	Wed,  8 Oct 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zag6UPXc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75C35966
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922512; cv=none; b=nii73nCHoPLUzeZT2BNmeJLNsbxiawaEuUsL8nmT6E1eONFQrgcAxFgB7dAXXTH/FOhlRVzP/spYAXhZqtNcratAwc004rs5cassgsGvkLROC49JwmZY1O+O4/NibbDBCKGAE6IlLu1G8pYs3Yn1pIbhdsFLaNBs3LYrqM+cLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922512; c=relaxed/simple;
	bh=AZgfpz/q67cZvhcrGfEfBOZxORglU0KDAGjwOqIlKqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2196nJekbkU1pTaMl6wwmRlVUbcGS74dyoUbrwty7uZAv4cIKKLMrpCzHIX+LiI/jCfgeC75Cvk+Rl1oQjMtpYc/CsT2Qfn/6jpv3HEgJRQEDpxxB/7O8dfSBLAvkJuJwBq50V8yiyxPDqGF1yhxioqrsT1jJrtitINDhSIV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zag6UPXc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so3564804b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759922510; x=1760527310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CY9sBhAH5xyY7adQ+pO128vNRZQE2GY/Fvz2grNM6jw=;
        b=Zag6UPXcexzFPcXobRaa4i+iAjyUoky/AYU2QVU/Z94frtKdegi+lGumG12QyIRCNr
         ZW9yKszIKy2iKxlYaWyp9MnhFtBpCdd7jTiPanWxItQadIesAE9OqtSYYeyN91omg0bK
         PQHxPeLGKfMc7bAva9JC8zIYdhZO7ZOCQe+n0k27zgXx895rgOKsl2kdYUkxN7CgmwHJ
         0mvxw5sLazXNB3NnZIqcRBSMqx86J30n8KArgq0Dxid7j27PLCRtqSwal18oS9Mry+1T
         dFwdcZCoeQ4T2vpAcKwSoMjfNTa30VuboG5lY09+UDPwMctaU5q7x0nlI6hVb111aEg7
         SdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759922510; x=1760527310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CY9sBhAH5xyY7adQ+pO128vNRZQE2GY/Fvz2grNM6jw=;
        b=mDCxYyS+6ACUyz7StRvpSLOBHwQF2hHxSRdzEsyz5Tk2P9w+FQA0/VaHv7yOKnKhIR
         Vl+cgRjI/SA7Ur24a0ut/oVXJWCf1i8Bf040GBZmoYZBRHYQGpT0fEWCZ1glHrdveCP8
         wPYlggFHaMuGXoArNskfuK+25JsT+DP0EJCD5gMtdrBp+RB4Yfda+jkEXAjoMYJynyTD
         q/SB/xTPDy3N0B37nPo/NlswKXg836Xs8XXgYjawnV91oEf0SAq/a0pvrgsKWN2YeYzF
         8F7ww4goQzuwVUJZhuiYNbdFKlwLGXFOGpKxFCoWtPVFfkE7na/yakryJnnFoQKPG1at
         Y9jQ==
X-Gm-Message-State: AOJu0YxpRaYmkqOX/HTUc5ELV/s2vO3wXrFnHHEoS0IfclHj/r3dbv66
	lMPUDpM2Gaf8zQKHQ6cUXg4oDm1/qn8AL93QW/ejxpk0XGUohf64q7Rg1mTCK/WH
X-Gm-Gg: ASbGncvQ0J6IElkqOR7vxdDVgB7Eoj937asUe3Cg0B0jdOC1pfa7898nXHDCyOOO3kI
	6zYY3ZwLZwyraotoTjZT/uDJYiyZIgc3S+Cydx7Pr16iZjZPuVJTV+01+rL+GADq70/EPpDDpn9
	owY5jxSw6pKmePjAMOIqQEu6OqtB4sK8suO00zpMvXQLe8QMgOc7ozTycwr+R5VHpg2gx9ns5Ex
	tb2QI7rgxMfX8WCgluD4kPIssRSIQk+nV4W32Xt/t5U61tEGhsIsSh9N8BtwcZsrRAIRPKilQAO
	TMjF3nPqEuVnnyz9PoE3jBGrMP+BdrZ+dgMn7yTwpTbdKL0I8L3SutXR1+Yn1eC81tAqOp5urpg
	lIKn8na8fMchu2rx0vAECGW2hXjxjJnxEDOeZyL1IsC75R9wxqhpZya/4OZg=
X-Google-Smtp-Source: AGHT+IGq9/h3SCHVJ26M/IheL3kyqejiM/guUXKuxBEkYZSVffGGqGY0aWbkPUC6zjPk0MfMOTpvKw==
X-Received: by 2002:a05:6a00:17a7:b0:780:9932:6ae9 with SMTP id d2e1a72fcca58-793876363abmr4056737b3a.18.1759922510121;
        Wed, 08 Oct 2025 04:21:50 -0700 (PDT)
Received: from localhost (2403-5806-8049--d1d.ip6.aussiebb.net. [2403:5806:8049::d1d])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-78b0206f619sm18501471b3a.67.2025.10.08.04.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:21:49 -0700 (PDT)
From: Richard Huynh <voxlympha@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Richard Huynh <voxlympha@gmail.com>
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Australia (AU) for 2025
Date: Wed,  8 Oct 2025 22:21:04 +1100
Message-ID: <20251008112104.8558-1-voxlympha@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of October 1 2025, a new class licence is in effect[1]
Update the link and references in the comments to it

Also align the 915-928mhz block with the document

Additionally for the lower part of 6Ghz spectrum:
- Allow for EHT-320 as it complies with PSD limits
- Expand the upper range up to 6585 as permitted in new licence

[1] https://www.legislation.gov.au/Details/F2025L01047

Signed-off-by: Richard Huynh <voxlympha@gmail.com>
---
 db.txt | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/db.txt b/db.txt
index 16bcb32..1d17271 100644
--- a/db.txt
+++ b/db.txt
@@ -145,43 +145,43 @@ country AT: DFS-ETSI
 
 # Source:
 # 'Item' in the comments below refers to each numbered rule found at:
-# https://www.legislation.gov.au/Details/F2023C00524
+# https://www.legislation.gov.au/Details/F2025L01047 within Table 8
+# except for 5850-5875 which is found in Table 1.
 # Both DFS-ETSI and DFS-FCC are acceptable per AS/NZS 4268 Appendix B.
 # The EIRP for DFS bands can be increased by 3dB if TPC is implemented.
 # In order to allow 80MHz operation between 5650-5730MHz the upper boundary
 # of this more restrictive band has been shifted up by 5MHz from 5725MHz.
 country AU: DFS-ETSI
-	# Item 58
-	(915 - 920 @ 4), (1000 mW)
-	(920 - 928 @ 8), (1000 mW)
+	# Item 1
+	(915 - 928 @ 8), (1000 mW)
 
-	# Item 59
+	# Item 3 and 7
 	(2400 - 2483.5 @ 40), (4000 mW)
 
-	# Item 61
+	# Item 10
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
 
-	# Item 62 (200 mW allowed if TPC is used)
+	# Item 11 (200 mW allowed if TPC is used)
 	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, AUTO-BW, DFS
 
-	# Item 63(a) (1000 mW with TPC)
+	# Item 12(a) (1000 mW with TPC)
 	(5470 - 5600 @ 80), (500 mW), DFS
 
-	# Item 63(b) (1000 mW with TPC)
+	# Item 12(b) (1000 mW with TPC)
 	# The end is 5725 but we borrow 5 MHz from the following less restrictive band
 	# so we can get an 80 MHz channel.
 	(5650 - 5730 @ 80), (500 mW), DFS
 
-	# Item 60
+	# Item 9
 	(5730 - 5850 @ 80), (4000 mW), AUTO-BW
 
-	# Item 22
+	# Item 22 of Table 1
 	(5850 - 5875 @ 20), (25 mW), AUTO-BW
 
-	# Item 63AA (25 mW if outdoors)
-	(5925 - 6425 @ 160), (250 mW), NO-OUTDOOR
+	# Item 13 (25 mW if outdoors)
+	(5925 - 6585 @ 320), (250 mW), NO-OUTDOOR
 
-	# Item 65
+	# Item 18
 	(57000 - 71000 @ 2160), (20000 mW), NO-OUTDOOR
 
 country AW: DFS-ETSI
-- 
2.51.0


