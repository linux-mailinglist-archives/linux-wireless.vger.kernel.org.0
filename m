Return-Path: <linux-wireless+bounces-13318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F360F989D48
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 10:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9079280A76
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8C0126C07;
	Mon, 30 Sep 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmX5OvWP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750213D531
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686347; cv=none; b=iYUOcQxoMsTOIuzrRjpvjeX2GQXFP1ZB+9kBrS+lUGVYOKudWsIXXvTdTVQV2kgMhoEmjgPsFu7KLqmCFmIw6QGihnTjuXUY16pGH2NicDVdZRSufTWoVJsBWpZWYbRS2O9Hfpl1xw248wyhej7yuCELmjuSpoq31EWmiuRxSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686347; c=relaxed/simple;
	bh=TQE4segIn7K7TY4aqun96Q+vumK87wqCxd0UAZYpdMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dJiAA3bKLbW5ISXNoxLRcjXEMcZje7pcRWxPDI93mq0mj0t+aI0mazg9L5kj2vKLJtpNm6voR46Y5Lf/Zqy51kyjU2q4D4wrWzjVloFdrBlHiDdD2VxyUArDjKTA7VnATrdHVRMz0mXmcFDJkAiM5zzCZhw8cSp8mIpAdEfke7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmX5OvWP; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7163489149eso3429166a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727686346; x=1728291146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hT900MQVpXa5tDUbRnu9huAT0/u/D21Vi3hT0pX5t/M=;
        b=UmX5OvWP9cwrklu4V5R43Fl8cGBYz+WOUI5vzOuE/cta8dW5y7IwvmdGXMax7UPh/x
         l891S2yAue+/8wP4eeu40cZaMPiicJs10oFPJkO5dxWSTL+9VPHh7uKGo2t/SOrJO/bD
         lyyXPnOX9UQOgC79K8DMVZt0eHBgbtweuFpztSJtYhJZmeiAtRnX8DlBkQs/9ttwNChY
         9Xa5xQJISg72gZTMG/GtaVYe6jRKz73hcOSPquhOlEslISAtcg4Rze3cVbGzlY96xjFm
         qV34Sgif6pxNfZZnj03vx1o1ZlBnLKZBZvSplfMP4wgIpT0ByADCjvdN8Pue+r3Y61Og
         Vxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686346; x=1728291146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hT900MQVpXa5tDUbRnu9huAT0/u/D21Vi3hT0pX5t/M=;
        b=FKmwuyOp2NwtfnfgMlzitjt8DHPuYwZfif7vmPQesL4LZdxLBH9SU5+4e4fRoqDYpJ
         olXtMb87farxPZ8f66V1QA081v/ExqsQ8r7Or5Oj7zr+gygWAxkmwHppyr0junklknn9
         AiCqw5mGUuOBcrL1JjVR+G7G8eRxeeMOB7CMOQnE5EnB3mjAmXFc6Bh7W2qMyRH4UJjQ
         nLseco4/HWisKXQztmN/JVZ5TCorWGbko/Bar6R7H+EYH5e6sYWUFfXMU5IeZMF0TqJt
         dXHwgZsvc/ICVGGgI9YdHuJayiNhgh/wgQAoHID+CjweNGTFNxO6gz2B9jT6+m6I0p6S
         /NQg==
X-Gm-Message-State: AOJu0YwAj06D+KUhK3CTxYpZN7k4gWeqL/hJ6AHTUrGd9mZkoqBaue3y
	9yQk6JEKH9EOcJk5xSAZfU+CGVVPXASFgQa8lUcKrZA4ATt4wW0K
X-Google-Smtp-Source: AGHT+IEwE+dJYvcb71id0l2YD4NvE1doLPKZAiOo1UvuxHWIQzv/fRz2UK+KxVFfRn/BpobLp/ZqVQ==
X-Received: by 2002:a05:6a20:2d0a:b0:1d5:1604:65e5 with SMTP id adf61e73a8af0-1d516046696mr7204456637.40.1727686345584;
        Mon, 30 Sep 2024 01:52:25 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b2652b1c0sm5940149b3a.145.2024.09.30.01.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:52:25 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Tanzania (TZ) for 2024
Date: Mon, 30 Sep 2024 16:51:43 +0800
Message-Id: <20240930085143.10754-1-pkshih@gmail.com>
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
v2:
  - 20 dBm when operating in 5250-5350 MHz for devices without TPC
---
 db.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 956cfd044157..932f8464de5a 100644
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
+	(5470 - 5725 @ 160), (250 mW), DFS, NO-OUTDOOR
+	(5725 - 5850 @ 80), (24), DFS
+	(5945 - 6425 @ 320), (23), NO-OUTDOOR
 
 # Source: https://zakon.rada.gov.ua/laws/show/z0201-15#n48
 # Although it is allowed to use up to 250 mW for some 5 GHz frequency ranges,
-- 
2.25.1


