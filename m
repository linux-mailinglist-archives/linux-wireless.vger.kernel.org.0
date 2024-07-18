Return-Path: <linux-wireless+bounces-10330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C019346A8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 05:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5451F22BFD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 03:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42CC1B86CE;
	Thu, 18 Jul 2024 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DswiG9ge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC51BDDB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721272670; cv=none; b=qpYDNyQoPWL/2SrzaQ99RPaCMaBmle33rvRwfrE4hmbaNEUNJdhKznTGmMGr9lDzhzoOdgpdpfMsNQXXDp0nQlM5d3UpTbRCG1Wi1Yvp6aaCvRMDQcEukKZERXuN54RyL2ZLOEnc+c3G1bJOoRioF1GuHjpPsmKLyCQaYdKwE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721272670; c=relaxed/simple;
	bh=9XseGb+ghJJKPAZ+fK+QV5dXijguc/1yZMSdtkUoSWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MoUhZTZaALZR5sZYPLENy5qQcDtyx4DSGEYpvAJPYjQrPBOxwITqXCtfiedIlo4GV5tshlGvZ4IrkznzhK4VzAVw1qa7LLpdNRvfknUHYS2s7AT75bMRU62Pxxsf11PZtU5svQiGhnJ6ZDMgzkVqJ/VlLVIJ7iSvKAOhF04GxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DswiG9ge; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc56fd4de1so2530655ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 20:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721272668; x=1721877468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihMU63pYAY1/iw7FoaHkrKZCrOt532isV3MhgcX5ljc=;
        b=DswiG9gev5n5UnZ9O4ZGmQPlFfljWIoh8cQ97JBuAwY2rCAqBJWTFu4vvSDnMDTrz7
         ny/I/wZdRRNjX7DFHIDJ3n+PZcqfP214UsBBCdhVrqK7wdyKwGCz/43OgT8AQ6sd6vU+
         Rw9E+gniDLRFo57oRhcJkHnZgwjRFkWirkWkHDNYgHlf+HJMIUXte69GUUaJqYx0Q2s8
         jzbMW1dPPgSGqujzl+7SJa89ohHLJWBW0nTEBbhQw0iPP3pu4I5tCZ0Uk0MIPtyV28lt
         1qqA0Fkypn2BacHXc2m2qTHKp3fNgTN87fUhxvHkptydwCArEKpGzVKcHTWP17zC+ymm
         hTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721272668; x=1721877468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihMU63pYAY1/iw7FoaHkrKZCrOt532isV3MhgcX5ljc=;
        b=eETc+iiE6W42NWC5JAPtZeHef/fI8HcG07Fv/nWczrFn/23O2rkXwLW1GWymfB1FfY
         tnJ9y/qJdWPQwBKJaM/Y+ktk0y8BqcafBjRSINo3Y+9s2AcvR83W+kcp4p81fI+N5C6N
         AlPGvBoaRZTsuUQ/OvaWjPlRSFpXDky1CwnkP5xsxbxpOQ+bO+jC4NtqFYdRaKMbjvTP
         u7MhTf8zlS3wockK8PaJLdf2Bw2yuHoJPbqVUb1xxMLggSzWHePIpA1zyl/0kidl6G7j
         QfC48RZanKaIPP7MGRConM8m/8BVcD5snpMmmvWi+vFLUf/u3DYG8b9TiTm8x2vHB6ao
         HX/g==
X-Gm-Message-State: AOJu0YzqwTNV8jox2LcNtgYQRJ5pjlNjTbGrLbQJF4WOII6blK2yGHQJ
	fccll+O5cnH5j2sjbIsABgXIYDMwSnl6LY7pg4K7hDCvnezU1DUdUz+/PVm53UA=
X-Google-Smtp-Source: AGHT+IHtYmtphye08uDhj8PleQBfwpO3a7Lo+fzNr7ln98YiA2wnN9AwVkxi8PWgWP9DONCSS5ALRA==
X-Received: by 2002:a17:902:cf05:b0:1fc:41c0:7a82 with SMTP id d9443c01a7336-1fc5b0ce813mr30962705ad.0.1721272668394;
        Wed, 17 Jul 2024 20:17:48 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fc0bc27383sm82503565ad.140.2024.07.17.20.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:17:48 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Add regulatory info for Namibia (NA) for 2023
Date: Thu, 18 Jul 2024 11:17:18 +0800
Message-Id: <20240718031718.19403-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

COMMUNICATIONS REGULATORY AUTHORITY OF NAMIBIA released NOTICE IN TERMS OF
THE REGULATIONS REGARDING THE SUBMISSIONS OF INTERCONNECTION AGREEMENTS
AND TARIFFS on 3 April 2023 [1].

* 2400-2483.5 MHz
  100 mW e.i.r.p.

* 5150-5350 MHz
  200 mW mean e.i.r.p.
  Restricted to indoor use
  The maximum mean e.i.r.p. density shall be limited to 10 mW/MHz
  (ETSI [2]: 200mW (23dBm) -6 dBm to be 17 dBm; DFS 5250-5350)

* 5470-5725 MHz
  250 mW e.i.r.p.
  Indoor as well as outdoor use allowed.
  The maximum mean e.i.r.p. density shall be limited to 50 mW/MHz
  (ETSI [2]: 250mW (24dBm) -6 dBm to be 18 dBm; DFS)

* 5725-5 875 MHz
  PTP/PTMP: max mean e.i.r.p = 4 W
  Mesh/AP-MP: max mean e.i.r.p = 2 W
  (ETSI [3]: The FWA device shall have the capability to reduce the
   operating mean EIRP level to a level not exceeding 24 dBm for
   ChS = 20 MHz and 21 dBm for ChS = 10 MHz. 24 dBm is adopted)

* 5925-6425 MHz
  - 23 dBm (200mW) mean e.i.r.p
    Restricted to indoor use only.
    Mean e.i.r.p density for in-band emissions = 10 dBM/MHz
  - 14 dBm (25) e.i.r.p mW
    Very Low Power (VLP) indoor outdoor use.
    Maximum meand e.i.r.p. for inband emissions = 1 dBm/MHz

* 57-66 GHz
  40 dBm (10W) mean e.i.r.p
  23 dBm/MHz e.i.r.p. density
  Indoor use only

The EN 301 893 [2] specifies reduced power limit of 23 and 27 dBm for
5150-5350 MHz and 5470-5725 MHz respectively for devices that don't
implement TPC. Also reduced TPC requires being able to reduce TX power by
up to 6 dB. The DFS applicable frequency range are 5250-5350 MHz and
5470-5725 MHz.

[1] https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
[2] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
[3] EN 302 502 https://www.etsi.org/deliver/etsi_en/302500_302599/302502/02.01.01_60/en_302502v020101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/db.txt b/db.txt
index 6192dafe9715..2a50afb60c06 100644
--- a/db.txt
+++ b/db.txt
@@ -1355,6 +1355,17 @@ country MY: DFS-FCC
 	(5735 - 5835 @ 80), (1000 mW)
 	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
+# Source:
+# https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
+country NA: DFS-ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (17), AUTO-BW, NO-OUTDOOR
+	(5250 - 5350 @ 80), (17), DFS, AUTO-BW, NO-OUTDOOR
+	(5470 - 5725 @ 160), (18), DFS
+	(5725 - 5875 @ 80), (24)
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
+
 country NG: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5250 - 5330 @ 80), (30), DFS
-- 
2.25.1


