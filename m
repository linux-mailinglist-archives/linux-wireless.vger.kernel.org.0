Return-Path: <linux-wireless+bounces-15115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AACD9C1197
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 23:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF68B1C2208D
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 22:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769AC21832A;
	Thu,  7 Nov 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlDW2416"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B02178FC;
	Thu,  7 Nov 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017819; cv=none; b=PccHe5mKwjrUbb2dLLSXTQuKco/YirWbG6NNnrTorXPx7DOzW9EIGLv3dVGFNL85Yg9lUpz4RSdOiYuHH7HpcQpupWhRqJII7vurzBGZJtsVrZxjv0EOiNuP9GauUI1i34H8jC7erpvU+WvfFZ87JfkU4Ua48ul/LnyL0lZq9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017819; c=relaxed/simple;
	bh=xf9xGmhSpFGUPyrwUNSI1zzdMVE6EvQL1eFH68Nz8NA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0KpZzotX9eW6A6Wh7sD2FsqCnzwIQBuYMyAwKmevLaMF/R9ULc4ce/uuhl4rX+c7XTtP9IIdvYqH+XpSNUvJ9GFIfCEqFQv1aZmGGnwtAzQ5bCOENA4jprTWt0IAdVHm+olmg/JENpUeAvY/Y1DOvbv+7WpTEZSNldPPHZwo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlDW2416; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b154f71885so97356285a.0;
        Thu, 07 Nov 2024 14:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731017817; x=1731622617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2Z1r/hnOYYan2Wj/wirtBVPSPK+XYjxE+M/cxSnG40=;
        b=FlDW24163wkijeTRvhoeBydGQutRV79OMFEiaFLVMdll/GjSglegOHQvpbLmTydIy1
         Cc3MFPYKwGnIKGQ15hOcqxNowVzg8c/gltiWzDFTS66VJobzbfBGdoHSW4S5AKRLbUAo
         UI6mk0sEHRKrsw3rvgQhqLjBBa5z8tqE9Wv5BEs4XTHGcYALsw0m+b9J8zU0WAjYF1BL
         Voxd43mWSlbyJXRbfdt8S1JDeO1wK71O041u9xmOz892y3blSHHxwFYxuRrAX+cwgESR
         kFu8UeoVZu5umGhwJaIoPLv1YjER5Gaf5TE9ptQ8FFZxXdwh7hBlvEcSDy3x3iZDh4tQ
         +8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731017817; x=1731622617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2Z1r/hnOYYan2Wj/wirtBVPSPK+XYjxE+M/cxSnG40=;
        b=JNlSDo21q0MFJvjWaGsU/ZPrRSHTTC9TGc5tniDc4oWcB/WcMXdTJOEIuxtusVbGVQ
         cJtuU32YI5gUQDFMbSmb+/zXjL4QrOrsUF2QrqLWhYbaFr47piFS6YjO09mzUeCco+Cm
         fRTs6Qc5fvPRU1GaDAEJ3V8sS5sh2/K6AF/CEFgJdHNLM05FctZp6q+ap0G4P2f0dwME
         v5f+d03sUbdEMe3k8TevJa7epcAjoW2MmVBNR9v7Vgmbo5y4fgVBU3TAn7koCv2OqxDv
         6Ul86HcuhbO2KPnEzYBFYyHDNECQ75Taq6qSWtfEEmpjV2KD7mJaL3uer2LJklrvoB91
         n31w==
X-Forwarded-Encrypted: i=1; AJvYcCWY5ds9jUfICm+Q9piqVwvB5dNbuFZJgA4Wml0z1o9QhC7FoPxT4z19nWE1uJWrTBpWWVWL7K1hh9tfR48=@vger.kernel.org, AJvYcCXJey8xF3MDZtetdbb7vNq1PcHm5RrCAvoMpwfp+29CFYL8+xgsvxwcEiY3P45isSCzX5mqENtG1DvfCeClMXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwIZwBhCFmeFr0WqhgVheM7V8j1ZR732VVzhLDpyokkyEaCNJ
	v0rh9mDpv/RQhHC0ZjYzoy6B9YCxW53ju/45zGFuGusXSsUag7un
X-Google-Smtp-Source: AGHT+IECDuWbZYEeGkYdgF26QM5bEITgyHbEAdV/jD1wDHcEzypXDaIzlzPrvFP5qRNF7hfcgG91tw==
X-Received: by 2002:a05:620a:c52:b0:7b1:4fba:b02e with SMTP id af79cd13be357-7b331e88f18mr98062185a.12.1731017816847;
        Thu, 07 Nov 2024 14:16:56 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dbfasm101615085a.24.2024.11.07.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:16:56 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: johannes@sipsolutions.net
Cc: linville@tuxdriver.com,
	rklein@nvidia.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH v2] net: rfkill: gpio: Add check for clk_enable()
Date: Thu,  7 Nov 2024 17:20:43 -0500
Message-Id: <20241107222043.1414437-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: 7176ba23f8b5 ("net: rfkill: add generic gpio rfkill driver")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2

1. Replace expection with error in commit msg.
---
 net/rfkill/rfkill-gpio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index c268c2b011f4..a87bb99231a6 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -31,9 +31,13 @@ struct rfkill_gpio_data {
 static int rfkill_gpio_set_power(void *data, bool blocked)
 {
 	struct rfkill_gpio_data *rfkill = data;
+	int ret;
 
-	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled)
-		clk_enable(rfkill->clk);
+	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled) {
+		ret = clk_enable(rfkill->clk);
+		if (!ret)
+			return ret;
+	}
 
 	gpiod_set_value_cansleep(rfkill->shutdown_gpio, !blocked);
 	gpiod_set_value_cansleep(rfkill->reset_gpio, !blocked);
-- 
2.34.1


