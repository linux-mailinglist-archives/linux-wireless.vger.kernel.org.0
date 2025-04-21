Return-Path: <linux-wireless+bounces-21781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BFBA94BD0
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 06:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CD4189101F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59969F50F;
	Mon, 21 Apr 2025 04:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNuhcXkh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E47462;
	Mon, 21 Apr 2025 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745208050; cv=none; b=Vi2HE8z6LWQ1d639J3DPJQvYoWcyPcyBnVUQikSsfnHoajfeFwga1whQV2EGNOqQ3THPzjfdndhH9oW93kZrXLQOKRjigD2q5LrGmcu04i2BqopOILB7/WgBjJeb0qOhdUr94utWnnpyWZO3N4T7jKAm7Zbj0FDYSz2bciaOREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745208050; c=relaxed/simple;
	bh=7VNkzd2YDzUNUlp+7tBooUqklU7YkhOJGODvN2Qxe6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSJ9aP0pvjEDUNhatxo/lBl1A1h+P1iVXhL+5KwoGQLIRKJ0VtvpbRyoJJlvzTqB69MeAXtgj0PlP7ge9Mz0jxRkHBS1swhsoiK5asXe7QXnec5pQ1YRtshl0l5XAzo7fHHiwocCWkt9PCTN1NI6U1nsKq7FV5/Irlf/sMcoY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNuhcXkh; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c54f67db99so456401785a.1;
        Sun, 20 Apr 2025 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745208047; x=1745812847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CX/10vkx/hdhwiym0foBnWUfHy9pxSwgILnrTpQDOqM=;
        b=jNuhcXkhH97ipY0UPB5seKag8qlKmgLTFnBvfeizJOhKdkOgGyIqyd5z3hcgvPrgvn
         ki21SknK0SBz/yoFNL+jB5VTMgOrwXNoGTjr07Dn5DO1z+cvRDVTH9pQX49WG9gAC+Yn
         Xh/eNtDtIPQLiuCV5c7s304/8jmWpp8ikDSlFmYgxVr1Qg7IzUyV2MD/qeX/UdWfoldZ
         6Lhk9ARPAVx+J26D3HofsYY70F25rozq6mQQNu0HWksWow08+kSw78nkOpHlUUNPeDj8
         gvjaojSDgu4EdJagm10mSeYRmu/A7DFsjKmsge4YGrajlhpaZHl+Mu5HT4suCxM2Wsdh
         xNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745208047; x=1745812847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CX/10vkx/hdhwiym0foBnWUfHy9pxSwgILnrTpQDOqM=;
        b=FYgIBVO1FbpUwKY4j6zs71MGDbwYk45lQencXNyOvSBiqxF5dX9jul08KTCbWiB7Z/
         cxMxNwfUucW7mj2zI77F5X/1kATqgSrB+RLZhUv0am+y/Cdo6+AKVMAIlwbfdKhX5jvF
         +UrKGHvF2KlWrEM4tY+rnVL9HdLQU4G2SkaFQkKpxrbtH2LFVbUNyuvc56VAIzfbh9EC
         TLChXHSFnCyfUHCt6woBrJtn9IheNzUY65ls2CsZLO0XGqOA3D1DObcwcRoGIf0AFYey
         fDRcDaZhs6iizQZmS+Ks9Pm8cUNWjOHtVKdS62kMcVIxQIDiNz0q8kBdFcrXbAPRv05Y
         nNCA==
X-Forwarded-Encrypted: i=1; AJvYcCXxdBpT+N3zbvwMZvWSsJV0XhvxRhjyIr1NJxzDRJXGl2+BqLWNlwO3AvB/q75V6SRAIQcQelIe4bcpsds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJ5tuo9RRcdbAR7nFpMsZG7PRcWREiDWUTfHbLX9gqlRT2AQp
	8nL35TDx6amTsatpl+mQSx7N1B7RuIn45dY3qN1C4S5HJkEa8WtUandnpg==
X-Gm-Gg: ASbGncsxnIT40cPCwDGdaZrkhUM1NwTrYgg9nosD1vOAOTob188Ol4yJinR5ETtRfT6
	vlgXmIH3QCINLqph3zYHI7Myvh13UNshbd0CttWYh6H5qJxiMiU26PwQguGrTmYnRO89BFkK1nW
	iFolbpdaBeoa8SVDO+UKg0ieGpsHxyy/tftYcKJZYgH+wmP/ymwDcFFSAo11A50v/0LqPFtHGEI
	Pg6xiVjdvOT9NnDQ8sE55/92tfjOMM8C2mXRJhaKO6AYQKHVnJRtJPRco9y3r/m+5xleB4z+qp7
	AJ8Dq6C47YRukks8ijGcp45dx38=
X-Google-Smtp-Source: AGHT+IF1eaVaae3F64952TllyruDbPzcrWhEmWG5BmgwcJDsDXZ3/SzMHM+U6g2uLDmpJr9+pAIJAQ==
X-Received: by 2002:a05:620a:4445:b0:7c3:c9e5:e4ba with SMTP id af79cd13be357-7c925821affmr1859711285a.29.1745208047220;
        Sun, 20 Apr 2025 21:00:47 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b775c1sm374568085a.97.2025.04.20.21.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 21:00:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] wifi: ath9k: ahb: do ioremap resource in one step
Date: Sun, 20 Apr 2025 21:00:44 -0700
Message-ID: <20250421040044.44887-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies probe slightly and adds extra error codes.

Switching from devm_ioremap to the platform variant ends up calling
devm_request_mem_region, which reserves the memory region for the
various wmacs. Per board, there is only one wmac and after some fairly
thorough analysis, there are no overlapping memory regions between wmacs
and other devices on the ahb.

Tested on a TP-Link Archer C7v2.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: remove wrong devm irq conversion.
 drivers/net/wireless/ath/ath9k/ahb.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index d4805e02b927..49b7ab26c477 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -74,7 +74,6 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	void __iomem *mem;
 	struct ath_softc *sc;
 	struct ieee80211_hw *hw;
-	struct resource *res;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	int irq;
 	int ret = 0;
@@ -86,16 +85,10 @@ static int ath_ahb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no memory resource found\n");
-		return -ENXIO;
-	}
-
-	mem = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (mem == NULL) {
+	mem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mem)) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(mem);
 	}
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.49.0


