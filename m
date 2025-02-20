Return-Path: <linux-wireless+bounces-19154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988F7A3CE23
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 01:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5CD7A8B84
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 00:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BA130A73;
	Thu, 20 Feb 2025 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFpkzDfY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE883EA98
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011509; cv=none; b=uoGM/A7YWxYO89luddcqRJwhkyRR73Hcc9z4qcQa1Knc3xzGEayXj/HP+sCawq2ky9h/2ca7uKRh63oLzLJ6NIXrA29OfMU1tWQ9pC7cj6bCNDBVibRrLRDnp93Wr13dk8VxhZUBSe69xt/9GlL6xpxGXGiy2lDxF0uk1NOnnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011509; c=relaxed/simple;
	bh=MOYugM7thv9gyugA0db+YZzBQWK8x6BmDy+LZU/ck1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Usz4H01TQwhLgvLecy26CsfgEeI/VDT3TCDD4CNSFoq7HQ7zPEl+k+hIp8yTS3E/6Vh6GM+9hco/TCxAHszwaEVl9o8zaTxDIaFQAYBxC76ogRqCU4X9iARtwYER1Qgef5aeO3mywdUw4uy5uzM1dlbARVgRTWkjlSxt/jhNf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFpkzDfY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c2a87378so4734365ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 16:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740011506; x=1740616306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT8PuNhIQOxs+vvKcgiaSZipcAIpw5GCWJUnkxFYnqg=;
        b=PFpkzDfYvHU7WdmFUGPbP3XNL3b4oT6fNoSDChuqpUFHBgVVfS8ONBAGS7/EusM2zW
         RjcZQr5pB3fpqDWgBQxBbrxybpupJnWpXnwktV39CgeaBIzUGlE8g9slSuv4e8mVyFpw
         xmnkxtdGWZiO16gWjDPX+n9BPSQLzIrw60C5z01hec3WcTavoH06rV+nmGHlnGVM0K5H
         A26dumBnfwgx5O3x6nIOjcumWAQrANsbucPtF5eHy6MbKAy9ECNJCigeoDmlHqL5P813
         CtfRy30Jo7tC/kdjgrWHflnP4fFOxHdDahv4i+pGYBz0ny0QPO7yKHsX3RSznn4gxT23
         Mk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740011506; x=1740616306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT8PuNhIQOxs+vvKcgiaSZipcAIpw5GCWJUnkxFYnqg=;
        b=Hb9xakycH9bNBDgthQMrPeGD8Zkqu8nt3GFcbM3fv8hdcrqNvcBIi4mLRgj7zYoju2
         VVVXdrUy8lREfL2N//jJtabzaflxGAadCi+hFLqtQvoLAv3S8bIOSO3oLmX/qOjP3h74
         UmyavR88NAizS0Pi9NqslNpAYVaVYV8sgyqTZ+2UtxG+nLyHU825wkefiFgY1XawUnCF
         5zMVRZczG3T/Cn4tTQrknuu7PXs/CcfzZbgOB9Jl1mtY7Fdh7wQiHt2Wk02lYUhDgcXK
         N6Ib+6n84d1oRUCAQriBxMp1eNiR4Y+35M/4Tqy8PFM08wcTZzG0Qjv1bOLC8LfK7xg8
         T9Pw==
X-Gm-Message-State: AOJu0YyUum85NGl/mcDMQOlbXqsP+uPe5yBhRzgHq4jW/o0LbspDl/1G
	VDsG1dUQTMUwiMu/AFInvHQv/LpjXjp8MfC1WZXk2VqVj4Km31by
X-Gm-Gg: ASbGncvbw7BFaiLQPdok1Q11GJgciVEUuXJEqt+y2qO3cFpBB2BZ/MUNWjBOZXtg5V4
	2avbkFD27gtcOVr4IctZ7RB9niO9vv86cgKe7z72WXgz447IvDgB1CLGNh+niq/OuCXL/S5kMZ+
	iiQJowSvpW8HF8/iT/0gVg23AdyjSiFF4wmIVn9oThlXxy04rEzmLDEHM3Shr9u83aqKwtoVneU
	bSFoGRSAXKsjxckDY17LJ5t7IHYZ9Ug5ED7pvGLbjtUEGpSquhc5ZLA2ZJ516UxMWo4TndvxfZA
	VwcDog7HC/wVCeo8tyvunegVBZxRRrqUBqRnTrfd7bJO75q+m1RahMWISA==
X-Google-Smtp-Source: AGHT+IFg09w2cWtPw9wf7KJ0gZEvQh/RK6q4pivGWj+L8RQ2RRqhBEp0aJE/LztbBbjrL/3yriZuSA==
X-Received: by 2002:a17:903:1c5:b0:220:f509:686a with SMTP id d9443c01a7336-2210407b939mr350891405ad.29.1740011506289;
        Wed, 19 Feb 2025 16:31:46 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d556d6d2sm108857895ad.177.2025.02.19.16.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 16:31:45 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	johannes@sipsolutions.net,
	mobin@mobintestserver.ir
Subject: [PATCH v4 2/3] wireless-regdb: Update regulatory rules for Iran (IR) on both 2.4 and 5Ghz for 2021
Date: Thu, 20 Feb 2025 08:31:02 +0800
Message-Id: <20250220003103.4484-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220003103.4484-1-pkshih@gmail.com>
References: <20250220003103.4484-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Decision No. 4004-01DEC-CRA, 8th Edition - February 2021,
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
* 5725 - 5850
  - 4000 mW e.i.r.p
  - 36dBm in every 500 kHz
  - DFS
  - Outdoor use only
  - P2P only
  - TPC is required without provision for no TPC. (Don't add this rule)

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
v4:
 - no change
v3:
  - correct release year 2021
  - add NO-INDOOR entry
v2:
  - add outdoor info to commit message as reference
  - add Reported-by and Closes tags
  - db.txt: mark 5250 - 5350 as NO-OUTDOOR
---
 db.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index d56ad32d31c9..7fe673111f62 100644
--- a/db.txt
+++ b/db.txt
@@ -934,9 +934,13 @@ country IN:
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
+	(5470 - 5725 @ 160), (27), DFS, NO-INDOOR
 
 # IS as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.25.1


