Return-Path: <linux-wireless+bounces-11309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B521094EDF2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBCBB2238F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C817BB3A;
	Mon, 12 Aug 2024 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=up.edu.ph header.i=@up.edu.ph header.b="BeohfF8K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034D1D699
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468799; cv=none; b=LJcgDNylnPyWRuZkC+R87GoeQbGYlez0Kypki+UCcRcZRvhKvtFOAq0zo3G+m4/ei9Z1bWibAGGoU6dFBm93nh0WC6AnOcEi3ZLdH0nvoKDgcfzI+6hcgjN1ir6hJ74ulZ61qxTCfAy1ocKV4XVIw3DK/aZJHezz6tpqxghrTaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468799; c=relaxed/simple;
	bh=csvRZpdCRQEZII8U/Ew2kLJrwi6ENJiJxv2QfSqpSEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFof00BpPobeQucBVyhKH+eAqrQ7gpxrMBNJNMoHpZjaDh5NgS3jDmgLf1j4RVfzt3R96kjJ41Yl3P8/O/ZuOwPLHGbClAz6S/YVSQlQ3IAq5sJ7Qe7Z3FK8MYVCJUxm4/sLXh2q610rElmdioGjY4x8G7etTaxemnYx7PgAZO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=up.edu.ph; spf=pass smtp.mailfrom=up.edu.ph; dkim=pass (2048-bit key) header.d=up.edu.ph header.i=@up.edu.ph header.b=BeohfF8K; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=up.edu.ph
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=up.edu.ph
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d5f9d68805so2446057eaf.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=up.edu.ph; s=up.edu.ph; t=1723468796; x=1724073596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YV6vFPhPARfxp8c+kV66rvLmVnOfu3xFpidfqyCEuUQ=;
        b=BeohfF8KKIGlSWJbp1RqvXr6OQ9V6M0g8tfAgvQ/Jb1BFapywZ9i/t6XNdPNc83UPs
         gq7G3FmEMaXkmIMRAEi+0QBMl/eO+41GPa+Oy9qdTx5+lDJWW+auF6l9WIPkRdelO8uw
         mjgVbLKWrKFvHAJo7CLln0k7PVnYU4VTK/LEyj11nvlpkj4TBBtRlXjUVKjESuRrEI48
         R7wySRR36lE1cMWzRkD19l9xMwyyXs7QO+/FboOdfyRErvGsYM0C9LK6czYwQmzezQVp
         AlhZF6aUvF2Fz2muUM1GzPtnoqu7MDsXl2Sx7JM1SjWsJbon9UQab4Mml+ivozNyF5+L
         o7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723468796; x=1724073596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YV6vFPhPARfxp8c+kV66rvLmVnOfu3xFpidfqyCEuUQ=;
        b=QMDhzwsxhzCCn0l0hbqqsoPOzzZOwyyl6OyjdIU7xqUJ+zyFgpMMAAUTxibW1ChQoI
         7eDa6pX30L3r0R0Jc3uVebjloPx+7tn7eqWLeXIj1EWry5Vq6nNgiQBhZFA5MBY+bJMX
         BSESVemQLfDOaQ0Fi1+neebixEotXSj3GYEmKI7/H5d1EdK6hGNl+tbTucQqbCda3Iwr
         69P/zO8zhBNY0hQ+aBgY5PeLL2ndCwon5YRaEn5UbZKJ8w8cTHV2huSJ4pxhPL8LAxHV
         t/CGR6bljmhC92pA2aa/hIFXFpiJrf+hJ3l8VRAJHuiuTHelsfZODf0cHEUnz0EdlGRG
         tZQw==
X-Gm-Message-State: AOJu0Ywr1eAGtdjoZuQ+RfESmQmGFDT+h650ixhglbcwjgOBF3mD+yk4
	w29YnJIQhzT/fQRZoj04Ypck1hxY5a6XMSTTsNLCofli3HTIwasn9jgJNTe//7A=
X-Google-Smtp-Source: AGHT+IEo3bfLnDHA7PuB+xcNoXw1PVeSN2YT/EZlO8XhMijXe8ECXX0hNOWsRb5aJzSzuxSEPL2jnw==
X-Received: by 2002:a05:6871:e020:b0:268:bb3a:cf90 with SMTP id 586e51a60fabf-26fcb6a0b43mr94900fac.18.1723468796360;
        Mon, 12 Aug 2024 06:19:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:4453:59c:d600:9959:2afb:92b5:96e8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbea2332sm4223719a12.86.2024.08.12.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:19:55 -0700 (PDT)
From: Gacel Perfinian <gcperfinian@up.edu.ph>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org,
	Gacel Perfinian <gcperfinian@up.edu.ph>
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Philippines (PH) on 6GHz
Date: Mon, 12 Aug 2024 21:18:12 +0800
Message-ID: <20240812131811.565-2-gcperfinian@up.edu.ph>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Philippine National Telecommunications Commission has issued
Memorandum Circular 002-07-2024 [1] on 05 July 2024, amending
the allowed frequencies for HIPERLANs and RLANs specified in Section 2
of Memorandum Circular No. 03-05-2007 [2]. The amendment has been in
force since 22 July, 15 days after publication in The Philippine Star
and copies furnished to the UP Law Center as mandated by law.

The amended frequency table allows HIPERLAN and RLAN devices to operate
on 5925 - 6425 MHz band for up to 25 mW eirp for indoor and outdoor use
(excluding UAV/drone use) and 250 mW eirp for indoor use only.

[1] https://ntc.gov.ph/wp-content/uploads/2024/MEMORANDUM%20CIRCULAR/NTC%20MC%20No.%20002-07-2024.pdf
[2] https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulations/MemoCirculars/MC2007/MC-03-05-2007.pdf

Signed-off-by: Gacel Perfinian <gcperfinian@up.edu.ph>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index e952d0a..788cd04 100644
--- a/db.txt
+++ b/db.txt
@@ -1493,9 +1493,11 @@ country PG: DFS-FCC
 # NTC MC 03-05-2007 https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulations/MemoCirculars/MC2007/MC-03-05-2007.pdf
 # NTC MC 03-08-2013 https://region7.ntc.gov.ph/images/LawsRulesAndRegulations/MC/WDN/MC_03-08-2013.pdf
 # NTC MC 01-01-2016 https://ntc.gov.ph/wp-content/uploads/2016/MC/Explanatory-MC-No-01-01-2016.pdf
+# NTC MC 002-07-2024 https://ntc.gov.ph/wp-content/uploads/2024/MEMORANDUM%20CIRCULAR/NTC%20MC%20No.%20002-07-2024.pdf
 # 2400 - 2483.5 MHz: NTC MC 09-09-2003, Section 3.1; NTC MC 03-08-2013, Section 3.1; NTC MC 03-05-2007, Section 2
 # 5150 - 5350 MHz: NTC MC 09-09-2003, Section 3.1; NTC MC 03-08-2013, Section 3.1; NTC MC 03-05-2007, Section 2
 # 5470 - 5850 MHz: NTC MC 09-09-2003, Section 3.1; NTC MC 03-08-2013, Section 3.1 NTC MC 03-05-2007, Section 2
+# 5925 - 6425 MHz: NTC MC 002-07-2024, Section 1; NTC MC 03-05-2007, Section 2
 # 57000 - 66000 MHz: NTC MC 01-01-2016, Section 1
 
 country PH: DFS-FCC
@@ -1504,6 +1506,7 @@ country PH: DFS-FCC
 	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
 	(5470 - 5725 @ 160), (24), DFS
 	(5725 - 5850 @ 80), (24)
+	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (24)
 
 country PK: DFS-JP
-- 
2.45.2.windows.1


