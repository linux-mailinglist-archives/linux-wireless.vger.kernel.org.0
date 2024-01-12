Return-Path: <linux-wireless+bounces-1780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66582BA39
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 05:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894AA1C23DE5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB71B281;
	Fri, 12 Jan 2024 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="I8HfZQI9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911F1B27B
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3e8a51e6bso48352735ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 20:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1705032146; x=1705636946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qxnuEyTVUUpLp+ePr9gDSD91DA7RHzLkiJHL+QBZnhQ=;
        b=I8HfZQI9u+vDOIJYOokD+IzUNQcixKdgTA1kPPMjyGXPGGIT4739pfOoq4SCeYv5x5
         lOvYUkBbhZ8j2ofegc6NaDv/EXBR9zyVXfV14NG0uqW3KK/GCfwmEcyo/oUc/UH08iDw
         FJZCt+CP+Ml1Y6KTC3AODESHdEfs0vJEYpscY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705032146; x=1705636946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxnuEyTVUUpLp+ePr9gDSD91DA7RHzLkiJHL+QBZnhQ=;
        b=ILgH3VbpkqyEcpPFhZmUkfMun95/JZAF2d4rDqOa5VMVOZ9PVYXNxVfxPpnbxT0TK9
         SN9Wa0bD8c91VOEmhM7lBLk3WvaZWLm1G9ILYdq3NEISJq80TRVWuPx7NM3pKPytjOA3
         x/rYcJpLVpHl2jQULv1Ao0GRqpTcODhUfi8H/xozo898K0YpEZIDV6gWpypLhYKLFVVz
         DdT6HlmzR2b2Il1YsvPA7uBbmESnzyPwrOTiy15RVrQRMzyAsO+QRlk3l68u17xOUbeH
         rczxXlhaJ/ebm4oSiwDs2s54FM28/zI+UW3Uuh5olhA7dr5ggWa6UN6d2Rv5FzbnuJYf
         RT+g==
X-Gm-Message-State: AOJu0Yz9+4f2Rd9Eiy9r8VPl9PQNB5ylIJTiVZMYCh67uve7+h5E1FwS
	er9lO5WY2+DznmYYOMFSe53eVhgJYcgx5mmsXovqpLEQgOa/
X-Google-Smtp-Source: AGHT+IHZeDWWwCgtE+zguR4zMIL7gnI95iPf2nR5kGAqj2X+Z2BifSj38w0SVxPUcFxJWddcfO3B5w==
X-Received: by 2002:a17:903:8ce:b0:1d4:5cf1:3484 with SMTP id lk14-20020a17090308ce00b001d45cf13484mr531085plb.62.1705032145784;
        Thu, 11 Jan 2024 20:02:25 -0800 (PST)
Received: from p14s2i.. ([2401:7400:c808:b52:9565:61c2:9ce0:d352])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001d403969b65sm1999226plc.187.2024.01.11.20.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 20:02:25 -0800 (PST)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Andrew Yong <me@ndoo.sg>
Subject: [PATCH] wireless-regdb: Update and disable 5470-5730MHz band according to TPC requirement for Singapore (SG)
Date: Fri, 12 Jan 2024 12:02:17 +0800
Message-ID: <20240112040217.24356-1-me@ndoo.sg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  - Use original regulation Tx power of 1000mW with TPC for 5470-5730MHz band instead of -3dBm offset without TPC
  - Comment out 5470 - 5730 band to disable it since TPC is not implemented

Signed-off-by: Andrew Yong <me@ndoo.sg>
---
 db.txt | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 15b439d..ed76600 100644
--- a/db.txt
+++ b/db.txt
@@ -1594,10 +1594,7 @@ country SE: DFS-ETSI
 # 5725 - 5850 MHz: IMDA TS SRD, Table 1 Sub-band 35
 # 5945 - 6425 MHz: IMDA TS SRD, Table 1 Sub-band 45b
 # 57000 - 66000 MHz: IMDA TS SRD, Table 1 Sub-band 40
-# Note: 500mW for 5470-5725MHz bands per FCC Part 15 Section 15.407 (2) 5.47-5.725 GHz as referenced by IMDA TS SRD
-#  AU and BG regulatory domains use the same interpretation of cited FCC and ETSI standards
 # Note: The transmit power for 5250-5350MHz bands can be raised (by 3dBm) to 200mW when TPC is implemented: IMDA TS SRD, Table 1 Sub-band 33a
-# Note: The transmit power for 5470-5725MHz bands can be raised (by 3dBm) to 1000mW when TPC is implemented: IMDA TS SRD Table 1 Sub-band 34
 
 country SG: DFS-FCC
 	(2400 - 2483.5 @ 40), (200 mW)
@@ -1607,7 +1604,8 @@ country SG: DFS-FCC
         # Since 5725 ~ 5730 MHz belongs to the next range which has looser
         # requirements, we can extend the range by 5 MHz to make the kernel
         # happy and be able to use channel 144.
-	(5470 - 5730 @ 160), (500 mW), DFS
+	# 5470 - 5730 requires (unimplemented) TPC per legislation
+        #(5470 - 5730 @ 160), (1000 mW), DFS
 	(5725 - 5850 @ 80), (1000 mW)
 	(5945 - 6425 @ 320), (250 mW), NO-OUTDOOR
 	(57000 - 66000 @ 2160), (10000 mW)
-- 
2.43.0


