Return-Path: <linux-wireless+bounces-28348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB968C17E6D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 02:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6805E1A60A4A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 01:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD752D9ED8;
	Wed, 29 Oct 2025 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="SygCRRso"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEC17B50F
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701077; cv=none; b=cv6RX5d/EPFkRRyOE5ECFqLwtaUcGay1Gu4PbUprYUsvhTpFlyzAHOjrz33tLEpEz3sx2NSIyXxo2IlhOdEn5dHvulU4whyhXLspv8tmrSwC4ZQLAu7nQECsHgO1hTUNhwNjAI57xxAfO9rNpqjmUtYHbdc4vvNHAIJ9EM2iAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701077; c=relaxed/simple;
	bh=Q+ejeT97l2zjDwtMb1qHalF2BUaWBmByl8f4zvQQ4sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwuoa7GS+gwm4eHW+xPtGojyga3DGb6FWIsGdASfLZwxLwa2mGcP7ko6dcf4S+zKRqfzpVnFTe7whEOxW4gUwOdzMu+XWl78z0e/Vjt4FFhV5O7eV5XARmFFlpQECszxWOxwd3uYNrHbIs8cyxtT3zN9aVDwNAd+v7ueJunmk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg; spf=pass smtp.mailfrom=ndoo.sg; dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b=SygCRRso; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-339a0b9ed6cso1564744a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 18:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1761701075; x=1762305875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1WXAlkDmDx9NmbLlS9VcnsufaxwGigfvd9PslVMSa4Y=;
        b=SygCRRso+ICaFONFlHfoM2b27QIYslbMugMAE4ANoc5vCcT1lB9HPSIwpNRYRrnENj
         xSQXhlOc1I2e2sJ6whjndWJNu+bEkT1IWFlVAUq87lVV45eJ+HiY3NOiK9dXQ7keBWnH
         8Ac8jH88+fsAPYBhzxuj6jC20uh5wyLmUc/yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761701075; x=1762305875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WXAlkDmDx9NmbLlS9VcnsufaxwGigfvd9PslVMSa4Y=;
        b=JuPhIS1t6w5AIzdWE1C8MRCNEeB4wVtoxV/YKGsyZ2G+pak0yo/Z1mZddOUI8Pobbb
         v1PuDK0nxWmlHN/JOm48MRi5qglpVqfA+6yu05aeFtFId5FN4oiSwZUYoWLRJMagmNx6
         jUw8XXLzC/GGp7EZ9J4CMyPmv5igBvHVfrqDxmy9KcdujqCQOMu9duTUtq9RpFw33IaM
         h3iBfNhM//ZAGzijWln6nhNgcs5mR7kPS0oNdMFljhax7LcYAmfsdI/QKdoWRVmdHNDD
         xCnFYV7ogm8wi53LtBGq/Mg47LeDD3R+rw1gMcyOIgpu1woQJZnyF1t3vOcYG7c2ytim
         EqFQ==
X-Gm-Message-State: AOJu0YxLFiq94TPfypldw7CS7UmeCwv4L4BEyZs30BRa3DXS7hNCdakm
	BzrZWP0m1tfBYpKwK3t8gRYIK6l8Xb10YWfvD4fPQyIL6UPUCCrJ1nRrMTGHZpbjicCf03SMFfO
	giQo=
X-Gm-Gg: ASbGnct7xqbwwjBfrY2dddtYNc82r7aOFoggbHlvZQUd9SgpmHia2AklQTcmrvCGrgt
	iNyESbMJ3QD8j3NniiUXakrQ0axV1kjwZU8seStnw7HHwFRn2vFnKrwidh2cDwYJmee7i4QeIya
	Q4EgjNrF1oznu3tpkyIc74mWwJGOjxvRWWcRvvkvui//DhVcWvezYyU5oH0y9IoPMbBSV2yG+Lu
	tzZP+ADbEvRz+0IGSLDSVQgTa3QEUzcafgFKZBFj3bD9TskvUuYrvEObiHsdNoOlGWHWEztttLY
	wuHLCn09rCGLpo+UxdMPsLxhtVKV5pYjD5Q2Xgy+argK4L65Q7hDJU+QyQcGu6MjHf0zoZFxwbq
	UUaVL5Rev7m2tvnrX1xuWGDMNCupeIySKKsC75wRywKWajgYYE4QvkFbx56JOvyyqc2oWgbWyVl
	fLibWxYoZwqyHsjJBY8fq4H1NNA1wJ1onaYkkIkhAfO159bNszQz0CjBYu+p3MbehcQ9GbNxlXe
	L4KzA==
X-Google-Smtp-Source: AGHT+IF7e9AGyJ8zCYZTX7ukImJg7kj7vR7sgwNsJ+lnwjJQx3OqPMM2y0TkoFlSndRGF1hssTEdyA==
X-Received: by 2002:a17:902:c404:b0:269:96d2:9c96 with SMTP id d9443c01a7336-294dea100damr8378035ad.0.1761701074815;
        Tue, 28 Oct 2025 18:24:34 -0700 (PDT)
Received: from localhost.localdomain ([121.120.74.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm133275645ad.6.2025.10.28.18.24.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 18:24:34 -0700 (PDT)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org,
	Andrew Yong <me@ndoo.sg>
Subject: [PATCH] wireless-regdb: Update regulatory info for Malaysia (MY) for 2025
Date: Wed, 29 Oct 2025 09:24:29 +0800
Message-ID: <20251029012429.68658-1-me@ndoo.sg>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malaysia Communications and Multimedia Commission announced CLASS ASSIGNMENT NO. 2 OF 2025[1].

With reference to class assignments on pages 9 and 10, and Power Spectral Density (PSD) limits on page 20, update the following rules:

2400-2500 MHz: Align previous 2402-2482 MHz rule to class assignment
5150-5250 MHz:
  1. Align previous 5170-5250 MHz rule to class assignment
  2. Mark as NO-OUTDOOR
5250-5350 MHz:
  1. Align previous 5250-5330 MHz rule to class assignment
  2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calculated at 20 MHz channel width
  3. Mark as NO-OUTDOOR
5470-5650 MHz:
  1. Align previous 5490-5650 MHz rule to class assignment
  2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calculated at 20 MHz channel width
5725-5875 MHz: Align previous 5735-5835 MHz rule to class assignment
5925-6425 MHz: Increase EIRP from 200 mW to 250 mW (remains within PSD limit of 12.5 mW/MHz)

[1] https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-No-2-of-2025.pdf

Signed-off-by: Andrew Yong <me@ndoo.sg>
---
 db.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/db.txt b/db.txt
index 1d17271..dc72989 100644
--- a/db.txt
+++ b/db.txt
@@ -1450,14 +1450,16 @@ country MX: DFS-FCC
 	(5925 - 6425 @ 320), (12), NO-OUTDOOR
 
 # Source:
-# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signed_19012022.pdf
+# https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignment-No-2-of-2025.pdf
 country MY: DFS-FCC
-	(2402 - 2482 @ 40), (500 mW)
-	(5170 - 5250 @ 80), (1000 mW), AUTO-BW
-	(5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW
-	(5490 - 5650 @ 160), (1000 mW), DFS
-	(5735 - 5835 @ 80), (1000 mW)
-	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
+	(2400 - 2500 @ 40), (500 mW)
+	(5150 - 5250 @ 80), (1000 mW), AUTO-BW, NO-OUTDOOR
+	# 5250 - 5350 MHz regulatory limit is 1000 mW, but 200 mW reaches the PSD limit of 10 mW / MHz at 20 MHz channel width
+	(5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, NO-OUTDOOR
+	# 5470 - 5650 MHz regulatory limit is 1000 mW, but 200 mW reaches the PSD limit of 10 mW / MHz at 20 MHz channel width
+	(5470 - 5650 @ 160), (200 mW), DFS
+	(5725 - 5875 @ 80), (1000 mW)
+	(5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
 
 # Source:
 # https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
-- 
2.50.1 (Apple Git-155)


