Return-Path: <linux-wireless+bounces-15399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFA9CFD52
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 09:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D76283711
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 08:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FEB192B96;
	Sat, 16 Nov 2024 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3ufXE7X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0C20DF4
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745556; cv=none; b=aiOoNoYaKo0b+JCJLNmpBQIY6VMH+3GDPqPk0k2dOD91Rp+3L3XvQg76fw11aToxwQWvSIkRFMGzZzPpeVExI7hNGELJTdNMxzdkdegGYl11lHfFYn8WP3yzqfHS04VBHXNFy7wRTDI/KXSCEfdihuZnaBx5eNbQrfo+aGcVVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745556; c=relaxed/simple;
	bh=+B6bc7Z0FMcQiQephLXLFmLgurFI2YVax/WR7mcbadM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cKcbYFxrlKWDzSe46ghEO7IbQtFolDCgwCVVJ6aC/PN89grup8N4/zXCSWm21yssb51HY8+Kg4a1OEsJjYzllaCJ27iAxfuRG3js32dLWzmlYsBimioibhTtzYZpRmV/InBL3Pe+XWC4NMXMM1tB8Uc07Cyd2127EEF2JPrshHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3ufXE7X; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20e576dbc42so16195665ad.0
        for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 00:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731745554; x=1732350354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0UxS0/3N00vpPB7ijCRLU5kaQylJVug8qDcI6jU8NoQ=;
        b=P3ufXE7XoFQvWRHB0JO2lN5A7SkohMniOuxrkGBs965MHoeLLa62FB7hVeb2gidjMq
         qDZx1vqX7lbJu1Sc3mjXnpfBnw83NYNtR75fGrZtPUZ98hGRQpyi/jWbD1UcDyxyzsJn
         bKauCAg2rAU4pxfojOcKC9KKTiK0z6XUBzgCydLZERbZ0E9uW86EiaCMcJXt4cE1uOxG
         YX9TV7kagic+lxolyrF5KDOUsrJhOia+MHjGiimV+SPh7asD7dDKOlYbo8+OxIupbECP
         yq7T5G6StrcNDRbGVzeeuRu8xLQFG8tSBZWOS5P7ciqGrac7evoZFemZF5ke1slgNe0R
         JWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731745554; x=1732350354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UxS0/3N00vpPB7ijCRLU5kaQylJVug8qDcI6jU8NoQ=;
        b=Lpr91BFcuWp8ji9c8krF2uHauca3HpuXH89QMawIzVGxbaMJzmpVLHXeIe9FYqGWn+
         gmcGO8yVUVlbeWmL7q5ERMMuSrDrqSW6dwYTqY1hdAzJ630wioFoqhSi0YHb12upYRhA
         ZPy9w+q4tgIc9ReIXGs6X5c1cNzy+DK++AUeFJvfYr9jIjVjdgeaB13JhEf5zYPihfyk
         bhTQJfhCuhLU3JNTM2wUyMg0+6WIe/e6fyhkhMqZdfnD+L37iqJ6rRRpk/XL2LRLFJd4
         CFQvB8tpx95C41RdBE6rpU5cnX5n5LX2JkUvPngSRlmrZArwVaWNVAuBlpjuw/IyZz+X
         h9yw==
X-Gm-Message-State: AOJu0YzAzb5kiQmt+i33iDkrmaKwvihjq7ka/4hZR9SFS9ZvN/zjMuwZ
	xA7ZrJtPgc5IuXDSbk533E2wG3hZoNOQyN7VVtc/C6aM1Mz9k5iH
X-Google-Smtp-Source: AGHT+IED/u8d1RBUMm6XxFi9IuWea83oKUuGb1FozvnJAyHh5eli0C0xfrUHrnsyjSaIq2wzyZ+zVQ==
X-Received: by 2002:a17:902:f705:b0:20c:b700:6e10 with SMTP id d9443c01a7336-211d0d83b0dmr85313035ad.34.1731745553673;
        Sat, 16 Nov 2024 00:25:53 -0800 (PST)
Received: from pkshih-B33E.realtek.com (125-231-72-119.dynamic-ip.hinet.net. [125.231.72.119])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-211d0f32008sm23685975ad.157.2024.11.16.00.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 00:25:53 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Syria (SY) for 2020
Date: Sat, 16 Nov 2024 16:25:16 +0800
Message-Id: <20241116082516.8819-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Syrian Arab Republic, Telecommunications and Post Regulatory Authority
released regulations for Short range devices approved by Board of
Commissioners Resolution No. 18 dated 3/14/2020 [2] via page [1].

In page 8, section WIDEBAND DATA TRANSMISSION SYSTEMS defines

* 2400-2483.5 MHz
  - 100 mW EIRP
  - Indoor only
  - EN 300 328
* 5150-5250 MHz
  - 200 mW EIRP
  - Indoor only
  - EN 301 893
* 5250-5350 MHz
  - 200 mW EIRP
  - Indoor only
  - EN 301 893
    * DFS
* 5470-5725 MHz
  - 200 mW EIRP
  - Indoor
  - EN 301 893
    * DFS
* 5725-5875 MHz
  - 200 mW EIRP
  - Indoor only
  - EN 302 502 (In [2], EN 301 893 should be a typo)
    * DFS: 5725 - 5850
* 57-66 GHz
  - 40 dBm EIRP
  - Indoor only
  - EN 302 567

[1] https://sytpra.gov.sy/pages/%D9%84%D9%88%D8%A7%D8%A6%D8%AD-%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9/%D9%84%D9%88%D8%A7%D8%A6%D8%AD-%D8%A7%D9%84%D8%B7%D9%8A%D9%81-%D8%A7%D9%84%D8%AA%D8%B1%D8%AF%D8%AF%D9%8A-%D8%A7%D9%84%D8%B1%D8%A7%D8%AF%D9%8A%D9%88%D9%8A
[2] https://sytpra.gov.sy/public/uploads/files/%D8%A7%D9%84%D8%A7%D8%B7%D8%A7%D8%B1%20%D8%A7%D9%84%D9%82%D8%A7%D9%86%D9%88%D9%86%D9%8A/%D9%84%D9%88%D8%A7%D8%A6%D8%AD%20%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9/%D9%84%D9%88%D8%A7%D8%A6%D8%AD%20%D8%A7%D9%84%D8%B7%D9%8A%D9%81%20%D8%A7%D9%84%D8%AA%D8%B1%D8%AF%D8%AF%D9%8A%20%D8%A7%D9%84%D8%B1%D8%A7%D8%AF%D9%8A%D9%88%D9%8A/L1.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index a12f931ef4b2..fc70e625e81a 100644
--- a/db.txt
+++ b/db.txt
@@ -1784,8 +1784,16 @@ country SV: DFS-FCC
 	(5735 - 5835 @ 20), (30)
 	(5925 - 7125 @ 320), (12), NO-OUTDOOR
 
-country SY:
-	(2402 - 2482 @ 40), (20)
+# Source:
+# https://sytpra.gov.sy/public/uploads/files/%D8%A7%D9%84%D8%A7%D8%B7%D8%A7%D8%B1%20%D8%A7%D9%84%D9%82%D8%A7%D9%86%D9%88%D9%86%D9%8A/%D9%84%D9%88%D8%A7%D8%A6%D8%AD%20%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9/%D9%84%D9%88%D8%A7%D8%A6%D8%AD%20%D8%A7%D9%84%D8%B7%D9%8A%D9%81%20%D8%A7%D9%84%D8%AA%D8%B1%D8%AF%D8%AF%D9%8A%20%D8%A7%D9%84%D8%B1%D8%A7%D8%AF%D9%8A%D9%88%D9%8A/L1.pdf
+country SY: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW), NO-OUTDOOR
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, DFS
+	(5470 - 5725 @ 160), (200 mW), NO-OUTDOOR, DFS
+	(5725 - 5850 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, DFS
+	(5850 - 5875 @ 20), (200 mW), NO-OUTDOOR, AUTO-BW
+	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
 # Source:
 # http://www.telecommission.tc/Spectrum-plan20110324-101210.html
-- 
2.25.1


