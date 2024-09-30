Return-Path: <linux-wireless+bounces-13319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B88989DA2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 11:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2167C1F21683
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF76183CAA;
	Mon, 30 Sep 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXc2W9ja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76400186616
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687072; cv=none; b=Xb420cSNRQ6wREgWRmNsmX8Mr7JiJO6lfmD7+J9XYJIiKWGxsQp3ec++ZT2pSD3q/Hm38oITm2kVydbrAkTVCU6qXX6HYkQUNIfsyuAMXDgtHdpKW4E47MtQOSE0PzDd6rPzsMu7x8Ew6CHo62co/cYUHjGb9qLtZyiPwxZtzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687072; c=relaxed/simple;
	bh=ZeH3tsgUVc7EJ421BX/eOwL639NIwxE7IPLoMHNMvkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnweOeGCii999EH1He47z+u0o8AT16R5BO5CHiVYijRWO3j0bq/VJEEOGdMWHDp/isJIEOI0hHZvUNEg0N2xBPRpQr5LHnRDz6gKONQhn1A+HFATTpT97sLi1Kc3Geg9Gf0owoFnYEJ4wIU0F4Og8BxyC08qyPCavU3HCtQ3A6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXc2W9ja; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so3519635b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727687070; x=1728291870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORaJDlvQnympO3hAnhO+eW7AqBF+2CEiHEVUGjcCDbE=;
        b=AXc2W9jaAUbGmmhSi+rrNKw0lXvz2TNYPN/DABbC44ysYax7xQac9FfTHdSvVgK2Qc
         LdMjlvVLOl8CR+ASyj7qbpI4A+BsPM++f6ay3UN9PoJlfLljiFeswt8ePSMxXNy+vdDF
         yN+kMTAqnFPoIYvpwXP8aQxW/0HEukMPX7EE1pRK3fDyuB71iyhQ9HwgIenpA89uoeFc
         Yz/yoglwEPXJFFm6BF++r1vk0BYSAJcGYWQB4P2/XtkGnSuZ7OEHnYKPcKwMlU+yh8Z0
         JCuSTAM0bjDUb3IiDPFej7rHdlKkKzaEjaZ9qKtmLfNSVVREIVRxse2i4zIvWBVt58r8
         R7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687070; x=1728291870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORaJDlvQnympO3hAnhO+eW7AqBF+2CEiHEVUGjcCDbE=;
        b=nQbTz4l/Ih6Bn8NE5rlEYQXWj9+HIJ5uAiAqO0Ooc8ngS1ZON7FX1veiA/N/E0l7CH
         ZF0Dnlw9urJe65W/KjB7YMA1+Z1lSrhol/KuYC372qYZJkKvFgrr4IMVYiHmoOC+RgJn
         c/USs6JixEs0fyWH+dDhdDA9/RbkfiKoB3rrDW/wKmiWQ21em8nmobTnnpLnmYI9uuV1
         xqxg7Q0u1VbT/6Jz5TcxEExSXLNjiUemLnnK8guTtRWE1nhbGlwZUoDK46YusxcusQvx
         otKiix2rwE0DqhwIxhGgqd0ZjSrmgzxhuV4+xQXeyxkRENc0tYEHoN927S+26Xj/eUf/
         i+OA==
X-Gm-Message-State: AOJu0YwL+YYt1wVFLKjgGfd4vYw7Bbw/eVCJRdfs0LNZLRW8wVwI+eCU
	/8+qvDxWdW7H+3eOStDkTdVacdyZPYfE9npP1AD+xkPlNSnjygqc
X-Google-Smtp-Source: AGHT+IHFIuIoXvob0CtewxlvNmhZkjzGLnRZ9R+TKA/iEfmHDe8pezvMHkONT23eFA43aIx6Y8BTBA==
X-Received: by 2002:a05:6a00:4b53:b0:718:dbc7:2d2f with SMTP id d2e1a72fcca58-71b192af06dmr23961003b3a.5.1727687069546;
        Mon, 30 Sep 2024 02:04:29 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b264bc1a3sm5777328b3a.75.2024.09.30.02.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:04:29 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v3] wireless-regdb: Update regulatory info for Tanzania (TZ) for 2024
Date: Mon, 30 Sep 2024 17:03:47 +0800
Message-Id: <20240930090347.11085-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

United Republic of Tanzania, Tanzania Communications Regulatory Authority
released Minimum Technical Specifications for Short Range Devices (SRDs)
on 2024 [1].

 * 2400-2483.5 MHz
   - 100 mW e.i.r.p.
 * 5150-5350 MHz
   - 200 mW mean e.i.r.p.
     * The maximum mean e.i.r.p. density shall be limited to 10 mW/MHz
       in any 1 MHz band.
   - EN 301 893
     * without TPC: 20 dBm when operating in 5250-5350 MHz
       (20 dBm is adopted for 5250-5350 MHz)
     * DFS: 5250-5350 MHz
   - Restricted to indoor use.
 * 5470-5725 MHz
   - 250 mW e.i.r.p
     * The maximum mean e.i.r.p. density shall be limited to 50 mW/MHz
       in any 1 MHz band
   - EN 301 893
     * DFS: 5470-5725 MHz
   - Indoor as well as outdoor use allowed.
 * 5725-5850 MHz
   - 1W
   - EN 302 502
     * DFS: 5850 - 5875 MHz
     * FWA device shall have the capability to reduce the operating
       mean EIRP level to a level not exceeding 24 dBm for ChS = 20 MHz
       (24 dBm is adopted)
 * 5945-6425 MHz
   - 23 dBm for LPI usage
     (should be indoor naturally)
   - 14 dBm for VLP usage

[1] https://www.tcra.go.tz/download/sw-1719952895-Minimum%20Technical%20Specifications%20for%20Short%20Range%20Devices%20(SRD),%20June%202024.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3:
  - remove NO-OUTDOOR from 5470-5725 MHz, since "Indoor as well as outdoor
    use allowed."
v2:
  - 20 dBm when operating in 5250-5350 MHz for devices without TPC
---
 db.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 956cfd044157..a1408b1da878 100644
--- a/db.txt
+++ b/db.txt
@@ -1873,9 +1873,15 @@ country TW: DFS-FCC
 	# 60g band, LP0002 section 4.13.1.1 (1)(A), EIRP=40dBm(43dBm peak)
 	(57000 - 66000 @ 2160), (40)
  
-country TZ:
-	(2402 - 2482 @ 40), (20)
-	(5735 - 5835 @ 80), (30)
+# Source:
+# https://www.tcra.go.tz/download/sw-1719952895-Minimum%20Technical%20Specifications%20for%20Short%20Range%20Devices%20(SRD),%20June%202024.pdf
+country TZ: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), AUTO-BW, NO-OUTDOOR
+	(5250 - 5350 @ 80), (20), DFS, AUTO-BW, NO-OUTDOOR
+	(5470 - 5725 @ 160), (250 mW), DFS
+	(5725 - 5850 @ 80), (24), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source: https://zakon.rada.gov.ua/laws/show/z0201-15#n48
 # Although it is allowed to use up to 250 mW for some 5 GHz frequency ranges,
-- 
2.25.1


