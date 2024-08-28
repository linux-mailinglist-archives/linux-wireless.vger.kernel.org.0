Return-Path: <linux-wireless+bounces-12136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5A496227F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B656028577C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5EB15C15C;
	Wed, 28 Aug 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAlFr272"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD915B552
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834843; cv=none; b=aNgNfcPSczPJZx7Tvz1reO+jHKw3H36/61e91ZSbPGrM6gxV/iBhJjOB5R/62HiV4wLwjidMNb3s4CmOyacFKtK3BGX8dWrfsC5uGP8IRkaeZWVLHXv1gNXr30dZjWw4ht6RXRax56u4vNx/8Zsmun/s5P7XHzDVXCGel42feXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834843; c=relaxed/simple;
	bh=DMZd8l8FQZtJjOD6JevoLxhn0xGWurYOpGvS9aANE88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d64BmDUPcFLsRk4YbuzZRh3xOxJ0T8bcTboo9nlbGmPT5espW+YzT57A8SyYRZiSxMHAvFa+fhLtNAeeyt0e/11iz4bJQ6Z9su+0lEcKRSUKLP/oN+tQAfLvM5wKgDgnONmKiP8iKAXQzFRd01+FOjv0BAk6NIkLLIVF6EQzmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAlFr272; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so5302916b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724834841; x=1725439641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfpRa7+a4X2inrM5zoCBa7zeS6Loig5tC7RkDoQ/JIA=;
        b=ZAlFr272qvwPQ4vfHnyGmd0uEElgDap/rWA4Jv33JaI6NNZTQKJI5YHB+V7Ua1eKbw
         ehnCqzev3h+zk4EezplE4172umUFoRnYs6ghLMuTAJKe7585fZEv6qUjIygYfwRg4UJP
         m3SzQ4pkB+GtaiQ+EVExQ+DnX1YeK2DscrGJv9iy2R91Z1qOiWDy7UpHatm5tOnDjPsi
         v0dYt6VUfcm9LJEp/ER5fUDZIDONdHLHavQhrac/W6iqUIw13qoKt1C5ZgjeD+67uXWW
         fF/icJg273hKTHU14yWoehXRPcU0x7Y9h9invZA5IWhWZ9JF8RQt0oalwIneZhqKEJKL
         5A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724834841; x=1725439641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfpRa7+a4X2inrM5zoCBa7zeS6Loig5tC7RkDoQ/JIA=;
        b=lq0Z55WgU/N7x+1ntCtbY4bAVQW9P9vxK3kkbiuLXWu0qQmq8qI0sQprdHOsXB1Sx8
         GZbu8ve4JAtWGojyb/xBT3GlweFLeuDCCAxWf45b95BGUNkxki1odtMQKijin6vOsQwY
         bX7yUrc7V3QZ44weVMkywvZN9yFdq03HOp0eiopHnjcn7/PX53A/lHQzQjE4PWuD6dsA
         y8ZSZ9J49e24mleutbZdI4GKc7dUeZmRlhGVJ3EiLC6iZedGn8IcnV3HhlqWD86JFl8B
         M0XbRBqVxMPrEbMhmP+XxEJdqKuL6FdZHjJEasi+6YeTTFMjONUMVBLOeupPB1MVmGe1
         pOJg==
X-Gm-Message-State: AOJu0YyTO1d0iRTSmW1Q7IKS5xWgplUgJpq+CXTEB+xAAE5Pb3ERN3Tz
	Q0/vO5/9LbSe62aj+0fUu5w/2lTZZYBGla1qA3J3pMCx6zwIIoFy
X-Google-Smtp-Source: AGHT+IEo5kc0UskrmXhwcGonI7c33NWKtwpzB5UDJZews7Ydk/FlrsiGcgCmC2ZHnZ69uiNTyEa5zQ==
X-Received: by 2002:a05:6a21:9d91:b0:1c6:ecee:1850 with SMTP id adf61e73a8af0-1cc8a07cbbamr19049098637.49.1724834841083;
        Wed, 28 Aug 2024 01:47:21 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855dbefbsm94652645ad.136.2024.08.28.01.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:47:20 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 2/4] wireless-regdb: Update regulatory info for Kuwait (KW) for 2022
Date: Wed, 28 Aug 2024 16:47:04 +0800
Message-Id: <20240828084706.12257-2-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828084706.12257-1-pkshih@gmail.com>
References: <20240828084706.12257-1-pkshih@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Kuwait, CITRA (Communication & Information Technology Regulatory Authority)
released Regulations for Wi-Fi service on 2022 [1] via page [2].

 * 2400 - 2483.5 MHz
   - upper limit 100 mW; 10 mW/MHz (adopt 100 mW)
 * 5150 - 5250 MHz
   - upper limit 200 mW; 10 mW/MHz (adopt 200 mW)
 * 5250 - 5350 MHz
   - upper limit 100 mW; 10 mW/MHz (adopt 100 mW)
   - DFS
 * 5470 - 5725 MHz
   - upper limit 500 mW; 50 mW/MHz (adopt 500 mW)
   - DFS
 * 5725 - 5825 MHz
   - upper limit 500 mW; 50 mW/MHz (adopt 500 mW)
   - DFS
 * 5925 - 6425 MHz
   - 200 mW
   - indoor only

[1] https://citra.gov.kw/sites/ar/Lists/CITRALaws/Attachments/14/%D8%A7%D9%84%D9%84%D8%A7%D8%A6%D8%AD%D8%A9%20%D8%A7%D9%84%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9%20%D9%84%D8%AE%D8%AF%D9%85%D8%A9%20%D8%A7%D9%84%D9%88%D8%A7%D9%8A%20%D9%81%D8%A7%D9%8A.pdf
[2] https://citra.gov.kw/sites/ar/Pages/CITRALaws.aspx

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index ad8dddc9c800..50ebd50becbd 100644
--- a/db.txt
+++ b/db.txt
@@ -1050,10 +1050,14 @@ country KR: DFS-JP
 	# 60 GHz band channels 1-4
 	(57000 - 66000 @ 2160), (43)
 
+# Source:
+# https://citra.gov.kw/sites/ar/Lists/CITRALaws/Attachments/14/%D8%A7%D9%84%D9%84%D8%A7%D8%A6%D8%AD%D8%A9%20%D8%A7%D9%84%D8%AA%D9%86%D8%B8%D9%8A%D9%85%D9%8A%D8%A9%20%D9%84%D8%AE%D8%AF%D9%85%D8%A9%20%D8%A7%D9%84%D9%88%D8%A7%D9%8A%20%D9%81%D8%A7%D9%8A.pdf
 country KW: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5170 - 5250 @ 80), (200 mW), AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW
+	(5470 - 5825 @ 160), (500 mW), DFS
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
 country KY: DFS-FCC
 	(2402 - 2482 @ 40), (20)
-- 
2.25.1


