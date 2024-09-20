Return-Path: <linux-wireless+bounces-13028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC697CFC2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 03:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB341F214C4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 01:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CC2625;
	Fri, 20 Sep 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0P6NWQ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD915E8B
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726795177; cv=none; b=gJiClgWxLRh0PTbplfSPihI8T/SPDMFW9vK4OFrv7Uk29XTMZB5Iq0EEWrU/JYr8+pdepyRN9bVlSc0rB9hjX+hGRESOUBjp3xurVoqAcBxyZAjSZdEar/s9nkwm+5nnnkTnGNJgd+FpQ/FYKbh5lGUJBmJe4gPm3SyL/kWZAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726795177; c=relaxed/simple;
	bh=yj/T1EebZ5cD/qwKRs3jXsWCYj6k+96Y2oGWIHh23lY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fof6w+22usSSH68NjMDPsXqkK88Z7kVueHV2BnWTNi6zCw9YhBunHiIv90GdwF3U3xWr+oqtMaeKpWWwNOG7fLKWnjWfXjlsN2tXioKdN/FitZ1tUXDce53THNnD6Tkow8J9i+I3DTEz8Jweamc1mZ5FMTyzXf9yfJgFvmlEIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0P6NWQ7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206aee40676so14230265ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 18:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726795174; x=1727399974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSfZImcSqa+uFEx0KKNiivLbTp+IhV4+X3Qg5DK/KEo=;
        b=c0P6NWQ7gNHDRSF1VJs5UxFagCGLQzkddkt3Lfv++npkSWerybMyI69LI8WT7gOZ9d
         GHDPkgTgcrDoZ57S487LGDfSJB/R/b9E+co7qVh8Z9bWBliyOx66Qc7e841KECRmydsu
         aB4vaa1mZKcV+j2Rs0DF9z/iWkR2PaFvtp0QMrP8nRfErnHO7yE4peFZrqKI5Zzdk/p3
         TdjedFR6XIreLJEzHfABmKwkPHJ7sip/7ioMmsGrANwGhn1EbllBQ1cKVeggBFR6AkNK
         VLC/NCVIK+1HfYOf0TXBX9ICRSywrDyPluuamWQQotrnVHUz/5FoLQmLj48dHnq1eutj
         9v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726795174; x=1727399974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSfZImcSqa+uFEx0KKNiivLbTp+IhV4+X3Qg5DK/KEo=;
        b=HiiFSV7KJ2wa5m2NuD9RA5qzIo4wYJmwqcWXK9u+J/d0xlEhfdHhjXwFooo0oNWKry
         qAG5Ifj0PZEbz4Be2vsJFBnH5HoYw9d2q4UoPNp9Zet+m2pmhbgKJ9fbkeFzEuqc3QHe
         hrLEUSPOSBD2A66qp1BJ5EmmQUNyiQEU0G89CvavRITnAHu2bZhC2DL9Y4PAHF5TgJrt
         vhlKyd9tYacnBnKWD+FArC72a7/8T4ZiJAOlaheh0KgI9MA71BCf25KAz4TfoYhmf8Qr
         5xtoqwc3bA+fvfZ37627YoqkqNIMa5IeIdjz/iY7Dd91eAGWL/yrx6XfrV2rRgDvQ/WI
         eNug==
X-Gm-Message-State: AOJu0Yy+sDliJ8I97nSa8Vh9Qh9+BNL4whHP1NiSBIPVMmeFTyzR1fcp
	Cl07heZk5XYhJw8aEErV3gICLBuR+TpZDwSzpGXe1HfuHIaZd7jR8mgVRc0C
X-Google-Smtp-Source: AGHT+IFbgQrbxYjwtQn0sQCBm9qIarBXdG348D1rj614PsAJTWsBJwFjDKLNQ4QMe+lnoYHvL+5pZA==
X-Received: by 2002:a17:902:ef48:b0:205:8cde:34c3 with SMTP id d9443c01a7336-208d8423fdamr17208735ad.54.1726795173485;
        Thu, 19 Sep 2024 18:19:33 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2079472fb5csm85672215ad.252.2024.09.19.18.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 18:19:33 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Tanzania (TZ) for 2024
Date: Fri, 20 Sep 2024 09:19:01 +0800
Message-Id: <20240920011901.5038-1-pkshih@gmail.com>
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
 db.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 9a55f6b8cc98..5ef3236d26ae 100644
--- a/db.txt
+++ b/db.txt
@@ -1860,9 +1860,15 @@ country TW: DFS-FCC
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
+	(5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, NO-OUTDOOR
+	(5470 - 5725 @ 160), (250 mW), DFS, NO-OUTDOOR
+	(5725 - 5850 @ 80), (24), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source: https://zakon.rada.gov.ua/laws/show/z0201-15#n48
 # Although it is allowed to use up to 250 mW for some 5 GHz frequency ranges,
-- 
2.25.1


