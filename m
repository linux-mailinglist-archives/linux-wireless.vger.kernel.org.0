Return-Path: <linux-wireless+bounces-10005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F89281AF
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 08:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14A21C225CE
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 06:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7C313C69C;
	Fri,  5 Jul 2024 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMQODU6z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5713E898
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159598; cv=none; b=J67HtZqEKjrZiGefSPCEw3ejQI0arRQJUuM9DcLevha1GHWcEeVRGa+gA27X4u7U2r3B9oqQUcuBAHUC8krndxnkGc6cSuerezI9WvOi6zd9/pRFLFQY/CQNxqXAqHjfuBIuHOf41nLp1kDIwpkiBo/95/1Aw2FSq3XcSiF1yJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159598; c=relaxed/simple;
	bh=8AO1BOe9LkxFuk6+LVcxm00fkFuZuQRZUsJHrjFnFT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZ4mOh9E6tcxqryWJ/zMbvQB+q5JC0byULQL5HZR4e9NdRD0NH8L93RCdfOMBijGZ5NTWtcwTvnWT/Z4m5Cmf3nb/ocq93IjywWHEEpF3xNXp0k9y1mY8O/q+WDcYlAFccm8AR32iiTsKuiHQB4SU4bwlylxyjT8CAczev61rhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMQODU6z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so5602695ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jul 2024 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720159596; x=1720764396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmrsxMr4EyNCdAf8dgXZk8rx67sFoHp+GBef47bCff8=;
        b=aMQODU6zHGJ/GyshDeTQnCsalr54N9neFxSuKdZybp1NQFAYmoUPbwP4eRfrVYzLEg
         BPVsWi1CEycq/uR6F491HlRjIQ0pgGBbtJwC2yxrQhMQ3+dQ9dzw5oaH7VmEIZNwIUNc
         6NkLvFLoxUHDOTA5aAgebhKNFgiowcytkRNbsnBSUdWUN5E5tbIH86hwpxSw3D9yqrgE
         sIwIpoilqaqIv0Pc3LNf7Q3mcSDXMnheUTOwMK81wBot74D1sngT7r8Hty8uaStbIYfp
         PudpBJbunaJ+bJV133kqgCCR1GLM3cJwXIsh2R3oWNu8KBpf64b0vIPmcD9nyRe58mnm
         YSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159596; x=1720764396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmrsxMr4EyNCdAf8dgXZk8rx67sFoHp+GBef47bCff8=;
        b=RvqSqTtqJKpOG0JIS/TXw0iBorHV1gHujybY4i+RJSwE7tpzUuEXRiCOKD+OoaudXQ
         vwaxV+Pazr5Sf9g6T8JsDjQ2Zw7yDWx425dBCgP+wRj8kyRARS2IyT+dF4P9YqH4jADn
         NXFMxxJiaAPtv77dfpFoCVb/CyxDUe1xxtEFFY4zvOpBwsFpSUjmvQk8ltKtj/9YskDz
         CFzhAVMWV2Zpjmo4jzxhdDguCyY+LAZeQAhPQg1C8RBk5c/zEG703Y5kXxQQ5B9f1RUL
         vt7f/WGhXbpbl76DpE0zk9S3N0/9DdgNM5tLZVeDWlmDW0Fvb3yN0yau5afK6OJxT2Tx
         S0QA==
X-Gm-Message-State: AOJu0YzZc6sRPse8ljB2fukOQVTPUQcxoEQCRGaQIji+jMTK/vKAoTQ5
	mC7rOl9Y7qtOF01IQRvTtPbl/pUDhsjHwEUaMEilHedaj5IM27yH0iPJ5KXX
X-Google-Smtp-Source: AGHT+IGMSTfTB6AYf5SQWBr1P+60ChDEoHW5lpZwxJcIiv5bFn9L1/VdmXOKzocEiCFASQwzy15RDg==
X-Received: by 2002:a17:902:ce82:b0:1fa:b511:5d31 with SMTP id d9443c01a7336-1fb33e76e16mr30306595ad.27.1720159595609;
        Thu, 04 Jul 2024 23:06:35 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fb4e7c31afsm4644645ad.2.2024.07.04.23.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:06:35 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 3/5] wireless-regdb: Update regulatory info for Qatar (QA) on 6GHz
Date: Fri,  5 Jul 2024 14:06:11 +0800
Message-Id: <20240705060613.28909-3-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705060613.28909-1-pkshih@gmail.com>
References: <20240705060613.28909-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Communications Regulatory Authority, State of Qatar, released
Class License for the use of RLAN devices over 5925-6425 MHz Band on
26 April 2022 [2] via page [1].

Technical Requirements for the use of RLAN Devices over 5925-6425MHz
 - Low Power
   * e.i.r.p 23 dBm
   * Indoor Use only
 - Very Low Power
   * e.i.r.p 14 dBm
   * Indoor and Outdoor Use

[1] https://www.cra.gov.qa/en/document/class-license-for-the-use-of-rlan-devices-over-5925-6425-mhz-band
[2] https://www.cra.gov.qa/-/media/System/D/2/5/8/D258CF18B83A5613B0D590193CB799CB/Class-License-WIFI-6E-Final-English-032022--V3.ashx

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index 2e862b322f13..d6b14c055afb 100644
--- a/db.txt
+++ b/db.txt
@@ -1559,12 +1559,15 @@ country PY: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://www.cra.gov.qa/-/media/System/D/2/5/8/D258CF18B83A5613B0D590193CB799CB/Class-License-WIFI-6E-Final-English-032022--V3.ashx
 country QA: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW), NO-OUTDOOR
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
 	(5250 - 5350 @ 80), (200 mW), NO-OUTDOOR, DFS, AUTO-BW
 	(5470 - 5725 @ 160), (100 mW), NO-OUTDOOR, DFS
 	(5725 - 5875 @ 80), (100 mW), NO-OUTDOOR, DFS
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
 
 country RE: DFS-ETSI
-- 
2.25.1


