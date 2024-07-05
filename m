Return-Path: <linux-wireless+bounces-10007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF4A9281B1
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 08:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B4E1F2172A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 06:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881C1411E4;
	Fri,  5 Jul 2024 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1FiuYoi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E313E898
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159601; cv=none; b=cXjOJihhaX8e6H5MtnU5OSgfp67gMNYN60A+YRT1yGBU9n8uMrciY4f1MslXvRcMN/WUcrH8XUz9mlBRWYeZZKoCb5pGZTA8XlBeUQJ4QGmg13GRqFSN0l/bxiHakyRHv9uWA21rEHohXm68nLWFfpzn1xuq6KvJB5R2NxyBWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159601; c=relaxed/simple;
	bh=9MW/6ix5rdSsmBwzospNR/rhct++kKoY+52dT+GaMt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+vCXBpCbWHx+p7W5UgG9l3gSUoZZB/2ONratb8B/+2kx2k6jrS0gRIhDs90PYj3OnDwqmKr4m1KEYF0pQTA1gTocZ4TUL15MTIJ+FMO9pg27leN1NzlyGtP4XbOICN+59UTlXAS7Kaqjmr4+7E1je/t4nzBdbTaG76S/Jx5JKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1FiuYoi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so7200165ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jul 2024 23:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720159598; x=1720764398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFimwcGPqA/3C6txqo+w6+bkEZEwHJWd41rNjtZetvc=;
        b=g1FiuYoi10P+UEgmmvjlZi5Eh/xux5uIe2Ax+8QactTyF5RyfYRmTDTEYZQXGatwDn
         qDNj/AdK+2HMPC5BDQxBnsv+9dbNUtYYeX/nAFtyvsd/PPxLx/ZyCvB94VcG1qf/rBA+
         mJFls8c1U/91BOk3RVGMS88d6sSn7mTl6TdQi/eh/clKywp26lE3wQ3zGq7i9K+j0RUx
         H8cgB4Xhioh3dHOUoPTXweTGM7TiA9izBp1luAX4MaZO8A7OJ3ivGAmqhxfijDxoG6j9
         AcfkSnvtb3nwk4HoCRsAJG9dey5W3bOeg12Gcj9PhHCHMl7LYDcDSZNppCzcVBXUO7HR
         hAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159598; x=1720764398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFimwcGPqA/3C6txqo+w6+bkEZEwHJWd41rNjtZetvc=;
        b=VDE31MhjIfL1o7Ird9Ttq9tnFzD18m55i1I3gTFG5Q5ukQYCDOoEQk1qFwe4VeuiJ6
         ahdqnoCMcq+LdKqgM9fx499wg6HAJ3ZRtfh+gZd1KINf06KnnI/EJFeFtvdVaxqD+1+s
         fGoHYH77S7pTp70A8QqlvRHMt8DMGw9lzBVC2NE64TjU7B2KxbAZ/OLEa0r5wCqarKMO
         cAUPkYd8Fur/Jl9W2RJkW0v8GuA6mC0MQlT0Yp+3r5Qj8VofMwg5OAr9VdPeJdJx4iws
         ylwXvv/PP9A+WRYOzvHus/d9imjUuf/vtuUDZ3na9F5+Y1mqVMx/qAT3EzvwIxG1UloL
         BRSw==
X-Gm-Message-State: AOJu0Yw63WnopE5miMdanYhBIBUL2AoHuU9ypOvSugvwddqyrT9VKj18
	NPynn1EWcVUD4NtvflURtBw211IN4Zg3U8JvbNKpNUaLRnN/zXiv
X-Google-Smtp-Source: AGHT+IHAGkebesN9NU6K6lfoSM+YOuC9Q2qmAgtHao3q8/qnW14rcMjreSfpgPl51CEfgtbMlLU/Uw==
X-Received: by 2002:a17:902:f690:b0:1f6:6ef0:dae4 with SMTP id d9443c01a7336-1fb33e86742mr30741765ad.32.1720159598391;
        Thu, 04 Jul 2024 23:06:38 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fb4e7c31afsm4644645ad.2.2024.07.04.23.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:06:38 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH 5/5] wireless-regdb: Update regulatory info for Togo (TG) for 2022
Date: Fri,  5 Jul 2024 14:06:13 +0800
Message-Id: <20240705060613.28909-5-pkshih@gmail.com>
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

Republic ToGolaise released Decision N 226/ARCEP/DG/22.

2400-2483.5 MHz
  - EIRP 100 mW and 10 mW/MHz density
5150-5350 MHz
  - EIRP 200 mW
  - If TPC is not used, must be reduced by 3 dB
5470-5850 MHz
  - EIRP 1W
  - If TPC is not used, must be reduced by 3 dB
5925-6425 MHz
  - LPI
    * EIRP 23 dBm (200 mW)
    * EIRP density 10 dBm/MHz
    * Use limited to indoor
  - VLP
    * EIRP 14 dBm (25 mW)
    * EIRP density -1 dBm/MHz
57-66 GHz
  - EIRP 40 dBm and 13 dBm/MHz density

[1] https://arcep.tg/wp-content/uploads/2022/12/Decision-226-22-Determinant-les-categories-et-conditions-techniques-dexploitation-des-appareils-de-faible-puissance-et-de-faible-portee.pdf

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 2a4f1ed524c1..6192dafe9715 100644
--- a/db.txt
+++ b/db.txt
@@ -1763,11 +1763,15 @@ country TD: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# Source:
+# https://arcep.tg/wp-content/uploads/2022/12/Decision-226-22-Determinant-les-categories-et-conditions-techniques-dexploitation-des-appareils-de-faible-puissance-et-de-faible-portee.pdf
 country TG: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 40), (20)
-	(5250 - 5330 @ 40), (20), DFS
-	(5490 - 5710 @ 40), (27), DFS
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 40), (200 mW)
+	(5250 - 5350 @ 40), (20), DFS
+	(5470 - 5850 @ 40), (27), DFS
+	(5925 - 6425 @ 320), (23), NO-OUTDOOR
+	(57000 - 66000 @2160), (40)
 
 # Source:
 # https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
-- 
2.25.1


