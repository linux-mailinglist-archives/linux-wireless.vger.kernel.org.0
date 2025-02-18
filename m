Return-Path: <linux-wireless+bounces-19094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A4A39397
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 07:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 978097A3835
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 06:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522931AF0AE;
	Tue, 18 Feb 2025 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNMkJwta"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1456819
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739861673; cv=none; b=jhAXYO8V5/dX1F4ZMTF0sYO1Fw5Axxjzlfg0ISGpVvire2retybGmyrFDEAFVhgWWu9J/0E7WTAHqZDnsc/dGfnqi4P3jtKpUmYeaC6BVLrYcsjWIbJl9aHOy5Mj15nRF+9lBRk3yCnaV5NGQeyQC5UnweNErN+8uLb5Y7fzkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739861673; c=relaxed/simple;
	bh=eAKcqXSACOIEi14UrJtum1YS7nt6CKRwXXHZCB9W1wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fncEaqHmeukdkg+Wr/UGb54vWGhzew0e72XHueFBJaRRXg31bU9Dzhj3HeRBoMRgxp2vyAfjK31SoUBh/nGXSlIWBJwcwyawrHBrnyRiXOvaYGJftRf1pH4wMFbuayXDh1kCqttjWsYnbT0XU/RZ36Ein5cWayc4+UatTV1/QMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNMkJwta; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2210d92292eso66766295ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 22:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739861671; x=1740466471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Azt/7LsFRRTFGUrb7nymTq9Ik51qG0MgdwYHGSVGRmY=;
        b=BNMkJwtaigUBWvw2GnMIBR0IkB9cDF2PNBtMYwhIVgFiPY0qCvabOu7Nurt2G7lP3X
         X3TgGre4x7/o77H/5vOQZ6N1PdEnAghQpXGLHE5gmMqE647xfiqIChwSssIdC97wnelv
         AE0/DIceZxQCUtbv/KciWoSSW5CDBhatRkMMfx0t2o1r416kcGVt+qdvb3UOfqRMzsur
         QaL/HPAP44JLaG2PxYV9hFGeqxjmIQpdzxuWkeBhQeMCJIa1+gQFyL7RPvG+i/XSd+U2
         4VBMJne47bPswOcYStlFvAvNTkD24I0+u+h4yk8il1I+vPETfLSbZLdqXhgc8sn/keMf
         PTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739861671; x=1740466471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Azt/7LsFRRTFGUrb7nymTq9Ik51qG0MgdwYHGSVGRmY=;
        b=VAYvUILrYLbOP+xDxbiWN/cI19eA76Jt5tbrm2uYVqBX9OH26KSzqcnJjOXbiapKar
         rGRnC1TLU3qbQajHGBNH5CWtMMVyiU3UOW1cJry9k9ZEkzpxIkwXp7mLcq0OTeR0qWTI
         73TQy/qTKpn0FdFn1/wF7I8qUhv4cxI6BDlhaMLpsEVSBAm0xQuw4FoCjLuyiCoeoVIT
         YFUQPwZouxhD9ezZ3J/IWr1b7ruazQp4qg8TYyfNdFK+XyG41YvjocYIF+MVSf/Oc4AF
         F2rO+pPTX1A6WNXrK2pFIlFQIATgUjsXTf5dBGlRTtTVTWMAFqJCGCLyKLZ011qldCQ+
         ARYQ==
X-Gm-Message-State: AOJu0Ywr5eo9OxFJeD7fG8GM32boxKdbGZvD5rkBMfIp5vhI467h62rV
	aSXDASIScbybT6i2NGU/Wq2TBsZzRSVAtlTDczqVak5hHgCrpcrw
X-Gm-Gg: ASbGncszuWQgJU+se0jAJsoyVCRTvYnY/QbkJRwo1fP0+Xd6Kn9wm6ZEBMT4QTuyUkG
	ye2sLWZU5xs8nujJUjUqPlJMrbSsVRca/tKnZOXdXmrb01eKEez94ZLpsEVu0b6cQX02VcAJdk8
	xZzeYrUT5LBhrS4mQ31WaOuvHLQA4YWsXhvlBHAi3ssOpXo88brG1N0+j/3VBWT2YReLjSJE3gh
	B2HVh0Xpgu44GN4A4pE5QThDuaGNJsrqY4bHbCQkRXrOBErTmjIkaydsLKo90r0DITGHUJQ/gBm
	gVdQ8dkOQ8/YTmFq0XizfAJf4HlD7oWRMaIuzHYR/JRPZv67WD/XpNiDTA==
X-Google-Smtp-Source: AGHT+IGSMSVHkVGhqnP4mJH/5lHEXfWApvRDHSByzlRsvYgvMFfwnCdX0UWVk+xZOBEMkyXgXngx0Q==
X-Received: by 2002:a17:902:f711:b0:20c:9936:f0ab with SMTP id d9443c01a7336-221040d6a6dmr201091445ad.47.1739861670875;
        Mon, 17 Feb 2025 22:54:30 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d5364385sm81710935ad.63.2025.02.17.22.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 22:54:30 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	mobin@mobintestserver.ir
Subject: [PATCH v2] wireless-regdb: Update regulatory rules for Iran (IR) on both 2.4 and 5Ghz for 2019
Date: Tue, 18 Feb 2025 14:53:52 +0800
Message-Id: <20250218065352.17313-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Decision No. 4004-01DEC-CRA, 8th Edition - February 2019,
Radiocommunications and Regulatory Organization.
General radio license for the use of parts of the frequency bands
2400-2483.5 MHz, 5150-5250 MHz, 5350-5250 MHz, 5470-5725 MHz, and
5850-5725 MHz in radio access networks. [1]

* 2400 - 2483.5
  - indoor
    * 100 mW e.i.r.p
    * 10dBm in every 1Mhz
  - outdoor
    * 4000 mW e.i.r.p
  - Intersection of indoor and outdoor. Indoor values are adopted.
* 5150 - 5250
  - indoor & outdoor
    * 200 mW e.i.r.p
    * 10dBm/MHz per 1MHz bandwidth or -6dBm/25kHz per 25kHz bandwidth
* 5250 - 5350
  - indoor
    * 200 mW e.i.r.p
    * 10dBm/MHz per 1MHz bandwidth
  - outdoor
    * 1000 mW e.i.r.p
    * 17dBm/MHz per 1MHz bandwidth
    * DFS
  - For outdoor usage, TPC is required, and there is no provision for
    3 dB power reduction if TPC is not implemented. Mark this band
    as indoor-only.
* 5470 - 5725
  - 1000 mW e.i.r.p
  - 17dBm/MHz per 1MHz bandwidth
  - DFS
  - If TPC is not used, the maximum radiated e.i.r.p. must be reduced
    by 3dB.
  - Outdoor use only
    (Since NO-INDOOR flag is not supported by current format, don't add
     this entry.)
* 5725 - 5850
  - 4000 mW e.i.r.p
  - 36dBm in every 500 kHz
  - DFS
  - Outdoor use only
    (Since NO-INDOOR flag is not supported by current format, don't add
     this entry.)
  - P2P only
  - TPC is required without provision for no TPC.

These information is from [4], Mobin Aydinfar shared the official link [1]
(inaccessible from outside of Iran), a mirror version [2] and translated
version [3].

[1] https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-0050569b0899
[2] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-doc.pdf
[3] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-table.ods
[4] https://lore.kernel.org/linux-wireless/c9ccf5ba-c091-45c4-9283-970bfa4f1afe@mobintestserver.ir/T/#u

Reported-by: Mobin Aydinfar <mobin@mobintestserver.ir>
Closes: https://lore.kernel.org/linux-wireless/c9ccf5ba-c091-45c4-9283-970bfa4f1afe@mobintestserver.ir/T/#u
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - add outdoor info to commit message as reference
  - add Reported-by and Closes tags
  - db.txt: mark 5250 - 5350 as NO-OUTDOOR
---
 db.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index d56ad32d31c9..5457f53372ae 100644
--- a/db.txt
+++ b/db.txt
@@ -934,9 +934,12 @@ country IN:
 	(5470 - 5725 @ 160), (24), DFS
 	(5725 - 5875 @ 80), (30)
 
-country IR: DFS-JP
-	(2402 - 2482 @ 40), (20)
-	(5735 - 5835 @ 80), (30)
+# Source:
+# https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968f-0050569b0899
+country IR: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW)
+	(5250 - 5350 @ 80), (200 mW), DFS, NO-OUTDOOR
 
 # IS as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1


