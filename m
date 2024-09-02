Return-Path: <linux-wireless+bounces-12326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CE396819F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 10:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E922828A8
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 08:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5481865EB;
	Mon,  2 Sep 2024 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK3VOUg8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B5917C9B3
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265408; cv=none; b=RYdM+XQ3bbRzbZpyVXMJpCV7RT1qFkvNACGUIag5lzTBNZTJ5hxL3Cr2sDC6rxmb+xs+0EjyNtZVP9YYs8BTeF2OaFMV6VEjZP4SCWmM8gxC3cs6fUWyNfSMp5C0ebgYEfzzQ+tWPKCbpTR2eV6G5N/OvMooAWP99lplzgBYLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265408; c=relaxed/simple;
	bh=HJ4GjbSZuWFNZE/yKSJBC3oWVdFz5FgDZ486Om5wrXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6ItJ0qiVjnzw2aJga6W7FMHnPrpYNdFw/8KwQZ3KM6Fxj58Z/koj8RMaczqpwbKoCc5Amq9Ax8QYYxPV8sqy1oe7Qv3WS9hr0Tf8gpx3Ozt+sQwH7+i4RW/xoLkcAmQefNf4dDasD+BVS/8CWQSrFJs6vfqo8UmaRSKXm4g9g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK3VOUg8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7176645e440so10464b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2024 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725265406; x=1725870206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBHYtqdNFmbRMMdOEczGdY8Jt3MbUklrVgbDj1ZJqgY=;
        b=AK3VOUg8NvyN/VRQLJMZ9qaMHivlXO4iJ1a7v6iMh22BFyB+KGVpK7r1EqIRM+FWjz
         2UwunISbdGQrmGIQrVFNTh4oSLDSCqx3vRQKhfLHGmsjdjVFAd6oKaFrFxHiJ/+AlM/D
         g6xAKpuG9oqmmuZRL/u5BT1P4+pSsShPo1J6Rbqeb2HSxVYxyrusIZS6Zln17VxNYO1+
         FTqB4B7Do5aY5XNv0evELWnTPZXzvxOxopOtUtYNQJXxFXznVLn0//I963whwbx1nRdt
         c61QQn0cLjcRy2aVRf2VQuWmp5BNwhzFrw88lxHImGnV1JaiHfUfffqDowJAjXzgYbfj
         zlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265406; x=1725870206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBHYtqdNFmbRMMdOEczGdY8Jt3MbUklrVgbDj1ZJqgY=;
        b=RSGlkm/0TOyTNd1u02hgcL/r2BpvHbc+uqTuv9GjVe4zkBassavF7+SbIqm1xqCCRV
         nnZDGEfLTsIiyR08kzFfJYxf1PhQvlJsY3bdh3wxT1o/77oZnZX8YyfHqeQ+/XljlVBP
         bRWui9CMhRJpipfBCf65p7NKEAz8BOI93eOZQw3b4ONwLuiuWSmzZuuFef4Zbv8g7oQr
         28Cf5Zku5MxRg18ZPJX/SLK3279kMS6g6CHvd9wjZeviBsje39xLSdBaVR7h6gM4w4kc
         M0YsK8ljDfzEB5S3u4C3TS4Xu6YuA1qQpYlaYWexNQsxwv23MYZxS/aoz921gGrs94qN
         Y92g==
X-Gm-Message-State: AOJu0YymIDiJM3vr7firNQj/IAWmGtwj2z2jZS8we767HsV9o+8OLobQ
	p/orYmbrNdJF345+jVHlF5cVXOXTDB/8DxXi+5P74a9vOv6AK9YZME0ncRof
X-Google-Smtp-Source: AGHT+IFN1LVZKAOiL+yucTIly4eSo/pCrDR7ephnARiP3qFKI3765q22Js5BjEQfX+qiH3DD1SQvdg==
X-Received: by 2002:a05:6a00:9160:b0:714:1a71:cb0a with SMTP id d2e1a72fcca58-715e101f8camr22541075b3a.10.1725265405654;
        Mon, 02 Sep 2024 01:23:25 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e56d8827sm6376370b3a.161.2024.09.02.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:23:25 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH v2 4/4] wireless-regdb: Update regulatory info for Honduras (HN) for 2023
Date: Mon,  2 Sep 2024 16:23:04 +0800
Message-Id: <20240902082304.52326-4-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902082304.52326-1-pkshih@gmail.com>
References: <20240902082304.52326-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Honduras, Telecommunication Commission (CONATEL) modified national note
HND40A on 2023 [1], which Wireless Access System/Radio Local Area Network
(WAS/RLAN) have a general license to operate in frequency ranges:

 * 902 - 928 MHz
 * 2400 - 2483.5 MHz
 * 5150 - 5250 MHz
 * 5250 - 5350 MHz
 * 5470 - 5725 MHz
 * 5725 - 5850 MHz
 * 5925 - 6425 MHz (*)
   - By [3] clause 65, "maximum power spectral density for low power indoor
     client devices in this band is 6 dB below the limit for access
     points (or -1 dBm/MHz based on the adopted PSD limit)."
     Then, 12 dBm is adopted.
   - By [3] section 15.407 General technical requirements, (d) Operational
     restrictions for 6 GHz U-NII devices, (5), "an exception exists for
     transmitting brief messages to an access point when attempting to
     join its network after detecting a signal that confirms that
     an access point is operating on a particular channel."
     Then, NO-IR flag is set.
 * 24.05 - 24.25 GHz
 * 57 - 71 GHz (*)
   - By [4] footer 952, "limits the average EIRP of 60 GHz transmitters to
     40 dBm and the peak EIRP to 43 dBm."
     Then, 40 dBm is adopted.

Article 5 of resolution NR006/23 [2] mentioned Recognition of Standards and
International Standards including FCC, which limits and ranges of FCC are
used due to lack of limits [1], but only newly add freqnecy ranges marked
by asterisk (*).

[1] https://www.conatel.gob.hn/doc/Regulacion/resoluciones/2023/NR05-23.pdf
[2] https://www.conatel.gob.hn/doc/Regulacion/resoluciones/2023/NR006-23.pdf
[3] https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-use-of-the-6ghz-band
[4] https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - add FCC source references for 5925 - 6425 MHz and 57 - 71 GHz, and
    update commit messages accordingly.
---
 db.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/db.txt b/db.txt
index 0be933c86c8a..c7341b5596dc 100644
--- a/db.txt
+++ b/db.txt
@@ -819,12 +819,16 @@ country HK: DFS-ETSI
 	(5730 - 5850 @ 80), (36)
 	(5925 - 6425 @ 160), (14)
 
+# Source:
+# https://www.conatel.gob.hn/doc/Regulacion/resoluciones/2023/NR05-23.pdf
 country HN: DFS-FCC
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 80), (17), AUTO-BW
 	(5250 - 5330 @ 80), (24), DFS, AUTO-BW
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
+	(5925 - 6425 @ 320), (12), NO-OUTDOOR, NO-IR
+	(57240 - 71000 @ 2160), (40)
 
 country HR: DFS-ETSI
 # HR as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
-- 
2.25.1


