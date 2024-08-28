Return-Path: <linux-wireless+bounces-12137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F0A962280
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5101F25EAD
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867D15CD54;
	Wed, 28 Aug 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpW4Z+uc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4538161914
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834845; cv=none; b=oemIvxOCriX09PXp5JiwLrDV8Iss2445rljri2Ekt5wg8sO7+bYdLh760Zkn+vrjhaFnmzW8VQkytV7lKbpVJ572MKAXdPkvGfNIC/aaFz4E+toYdqE4R4bxnr2UeYSM56C/bLOwVMaznusDAgoUGkO03I/KU6yeP/iaTz8QIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834845; c=relaxed/simple;
	bh=/248ix513pWLAaI9qq2aybsmgZZ9I5eovTyP+1meJjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bM9cIiK1y3UEw16YFJx9j7kSI1EHO7WyqldBeWXhrtobtIt19mS53QurNUrilAAXa+XS5WmR0hChN6CQIbzrCU2gqvRZQxINRbhgDJS7qh5WWDu+tkKLmcc2WoYblkunDdv1Yg7Rpn94LMxGLwL3ByMb/WpOFMJAQA1fiakOhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpW4Z+uc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20203988f37so63796235ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724834843; x=1725439643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMzCoIwoMsqcW8OO/DX/f2CvbyeoO1AQYc6WZ057c+o=;
        b=lpW4Z+ucapL/SODqtHjgkTpBSZjZ3nGHrJ/cK+/MfZCUeU+OsSWc/zM1RT59oeBQsE
         qDgHxJ8pizwnEhC0oZG8zm9SilNjm9e22ZQts7a0Y+e/ZGtAOsgy1l/yqgWpBN/LE0xl
         q3yNF5CygiK//e0v0j0Vvwt+Dc13AtnI2OqWtLv/1EfijcjyxQ12kk3xhSJ0leiybMrk
         /7H6xE1eE+eqRuycpP9uK9HAW4h5hx7lEWkkhxBqrL4CsVGSztYwFc9Q0TkPLPDvuc59
         b7yYB+l7KbJtKkpzwW+xmxapwhP3bu9/q85m9AHiVq7sU0CrlNEC3gkeemxdWqHYkGeb
         4hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724834843; x=1725439643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMzCoIwoMsqcW8OO/DX/f2CvbyeoO1AQYc6WZ057c+o=;
        b=C9VL2sTXO7ZT/gSF70TFbUPNiVbVddA29J6PKRnfUy6sQs9USEYklIHT7biyxybNvc
         BR37kXkuf86F+lIcka9XwA96Oz3AqwIMx9wiL+QpSiYh5K6s28XB3nmSKka0Yz+OK8wC
         Cj4r19pZ5KJfIZIAoeIg43ZhOZvvJ+QzWKX7Za7XaJ6w7vzkFXfTqFwAZAj3Kr4LqF6C
         yxRmSDWd7cdYT+SQ0AmWWscGLoccI1HiEY390XrgR/CgiXQKjKHfStny3W4rjpkvh///
         rpirOp2KEXy8s2HzY/MIOl17pOKtJ2RmHZvXrTsZjbe6zJ60GLPL5CjTxr+rgSp6yDGI
         U8rg==
X-Gm-Message-State: AOJu0Yy4irs4tkHgJxibbhRkul3Y+a8I5pc+2XonpqJvidfRdcquO2uc
	7Sye6fyTRDXZa2ZxWcw/Saa8Kj5UK527NUgTr63OThq/cMgBXIBe
X-Google-Smtp-Source: AGHT+IExD8v1JIMjRlDFsbjSq1eCFJcVYkTZs7BOlCOLtRzm3+hksUVC1IUORxwK0eFzDsYX/0+o4Q==
X-Received: by 2002:a17:903:5c4:b0:203:6c70:b8f4 with SMTP id d9443c01a7336-2039e4f25afmr120647315ad.41.1724834842670;
        Wed, 28 Aug 2024 01:47:22 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855dbefbsm94652645ad.136.2024.08.28.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:47:22 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 3/4] wireless-regdb: Update regulatory info for Israel (IL) for 2021
Date: Wed, 28 Aug 2024 16:47:05 +0800
Message-Id: <20240828084706.12257-3-pkshih@gmail.com>
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

Israel released the wireless telegraph regulations (certificates of
conformity) on 2021 [1]. Update regulation of Radio Local Area Network
(RLAN) below.

 * 5150 - 5250 MHz
   - 200 mW; 10 dBm/MHz (adopt 200 mW)
   - EN 301 893
   - inside a building only
 * 5250 - 5350 MHz
   - without TPC: 100 mW; 7 dBm/MHz (adopt 100 mW)
   - EN 301 893, DFS
   - inside a building only
 * 5470 - 5725 MHz
   - without TPC: 500 mW; 14 dBm/MHz (adopt 500 mW)
   - EN 301 893, DFS
   - inside a building only
 * 5945 - 6425 MHz
   - 200 mW; 10 dBm/MHz (adopt 200 mW)
   - EN 303 687
   - inside a building only

 * No touch 2402 - 2482 and 5725 - 5875 MHz, because the regulation not
   clearly point out RLAN for the frequency ranges.

[1] https://www.nevo.co.il/law_html/law01/502_483.htm#Seif9
[2] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_301893v020101p.pdf
[3] EN 303 687 https://www.etsi.org/deliver/etsi_en/303600_303699/303687/01.01.01_60/en_303687v010101p.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index 50ebd50becbd..0bc40db2d9b5 100644
--- a/db.txt
+++ b/db.txt
@@ -905,14 +905,16 @@ country IE: DFS-ETSI
 # IL: https://www.gov.il/he/departments/legalInfo/telegraph_law
 # IL: official document (pdf): https://rfa.justice.gov.il/SearchPredefinedApi/Documents/IdngyMn~ojdQSrkxuAqfZqiM8c1foi3TSZQhp7OMszo=
 # IL: also available as unofficial word doc: https://www.nevo.co.il/Handlers/LawOpenDoc.ashx?id=199708
+# https://www.nevo.co.il/law_html/law01/502_483.htm#Seif9
 country IL: DFS-ETSI
 	(2402 - 2482 @ 40), (20)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
-	(5250 - 5350 @ 80), (200 mW), NO-OUTDOOR, DFS, AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
 	# Table B List of conditions, row 63, indoor short range device without TPC (ETSI EN 301 893)
 	(5470 - 5725 @ 160), (500 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
 	# Table B List of conditions, row 68, wireless device using 802.11a/n/ac protocol
 	(5725 - 5875 @ 80), (200 mW), AUTO-BW
+	(5945 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
 # Source:
 # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
-- 
2.25.1


