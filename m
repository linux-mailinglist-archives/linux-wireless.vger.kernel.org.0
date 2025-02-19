Return-Path: <linux-wireless+bounces-19110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA0FA3AFA5
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 03:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759A51723E7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 02:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84C17CA12;
	Wed, 19 Feb 2025 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2Nc0FFA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF4187553
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932500; cv=none; b=ixLsK+HtjK8E+BtAZmy+E5BDOxyVxURhU6+wwpQ7mFFhflbmehGkWEVB2MarLr2CD40z9cD3ijkLvtlBLm//dPtDkaOz0rkRFIjwtBOTV/9wYuwuwQcVCBz9NKlyB0lN9x/GlO2Kzv8Bwid4h3Yoyjy1YSN061YFFGBwsL4h6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932500; c=relaxed/simple;
	bh=N5zDv/fqmGyPpLEYLzIUIaba0EOMK+00YTHCMAow7O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uuUFg8bFxIve4jycG7w6yPvyneYYdbUl9OTxBjmzgr56Q1/BJ2Xezfx9/jF+hkzN6RFxVmtee6o0CYk25g7DRI7A0GufUopf6GKV/9zWQr4xnIGbttLZ/QxJOkwv+D0BX71JFYYzKxXmZP7NuS2VVd3bDRBYoixI9vGXnDoBVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2Nc0FFA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220f4dd756eso84454505ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 18:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739932498; x=1740537298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1u2pB2szRJcEslDwlgFx2CcAzeLV+6q0mMcBgTJR6E=;
        b=a2Nc0FFATxi7eASzFg8sgR397hGaLOV/k91HVxZlGsM1eiStXKhbM5y0iMUgfywC77
         JnB+Q0fVc2JhXSrs0chB7vWpiz4ElBfLSRNeQwJKr6rHnbMAHN1igGO3S+EMIn5NCwIX
         P12NeGP4fBkIBDPAIf/qIhtVLHEARNz2SY+W6hD+HNrzNdTwQZu0J98HwJ0sbCcp29M6
         d3I4leA8JJE/LjqcRPCNMiwY1OqnwnZ5PdFxJpOuDKsTgM3VUEmrKMlnLnlAn2t/yPaT
         VrS3EF7vUMxSk0UQlJNagQI9VLweLdp+RrA0zjhvooH2V9y7seJeUQqBpydpz9dk4EIS
         ZZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932498; x=1740537298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1u2pB2szRJcEslDwlgFx2CcAzeLV+6q0mMcBgTJR6E=;
        b=Yz1MnXlFJtDtJb1WuPdQ9BbDOeiAfUonx+fsVdJr9ILzUfBawJ2xOLZxMpRjRzvebo
         QDMbXC7wj8pfGrG+gTY569r6mnWnklMWMDIXR//7iNlcxV6m11x9OImGmuuXYjaMigNL
         9GUYpXS9M9cdw8dYZEf1rr/4jd0zBS1HtmcxUpYpl/0q1qPn3TuhbihVO63xcptwhlWB
         IS3YHUcOjNSQi6zP8QyqK1WE+X0ZR/Fn7xZvPafcZPccwAjqrlQs+f1XDQsw8CtbtT1N
         pkf4pe5r+0DJpvsbDE6V8qD3hpKLb0vg7AlGVDPy8mhBwMYfUoQ4YlONzSCsxge7xnpe
         aT1Q==
X-Gm-Message-State: AOJu0Ywy18bFz6WLUXv1qwE19UEKJu365M2rsQK8jmWyHHux4V2sSeap
	Nz8+cwJFP5RcDhs/uDwbu8N+mkWpaWRQbjNkX4hCB3uW2kLiNLV3
X-Gm-Gg: ASbGncuHR5HcNv7VJflmWVQXRVDE6O8i1NY4C9iCo1/tHvE35kuu1r+6ZIJdcm5baW9
	fwySDQmdA7tFXvMo2KPTqtd/XA7SnLr07RAOQSbWCUmQUzfVsC8nHMrGrV5NjjFM/5O5Er0pkzM
	WZa/TJ5WLow0XyJBJQ9GyPM7BLvC3Gt+GP4kTEVrUpMnicScAI6DfoiwGMfyvNybWyux8137A/6
	Byyq6RDbw9Yv0Y+lxNpNKCRO5YCeRky0+TPf87feL05zbEQgF3eNslv8NWCfYSGltgNPnDMp8T7
	9jNBFeAMUrvcL2COSkS31DCxuYVtB1/ke2PaFNM8+jPMzfqR76ciX923Mw==
X-Google-Smtp-Source: AGHT+IEIBi6Xz6yQOikL9DfUMDni6fZ5csfboVSXVClh3d9QyljKBHTQnt9pu8iN2ShKKrhijJhCIA==
X-Received: by 2002:a17:903:2f88:b0:21f:8718:fc64 with SMTP id d9443c01a7336-221040d8187mr273437115ad.46.1739932497817;
        Tue, 18 Feb 2025 18:34:57 -0800 (PST)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d536671asm96837625ad.88.2025.02.18.18.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:34:57 -0800 (PST)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	johannes@sipsolutions.net,
	mobin@mobintestserver.ir
Subject: [PATCH v3 2/3] wireless-regdb: Update regulatory rules for Iran (IR) on both 2.4 and 5Ghz for 2021
Date: Wed, 19 Feb 2025 10:34:14 +0800
Message-Id: <20250219023415.14229-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219023415.14229-1-pkshih@gmail.com>
References: <20250219023415.14229-1-pkshih@gmail.com>
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


