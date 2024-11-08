Return-Path: <linux-wireless+bounces-15150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193DD9C25DE
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 20:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52FB1F21549
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 19:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF7A1AA1FC;
	Fri,  8 Nov 2024 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKF9gxnW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E71AA1F8;
	Fri,  8 Nov 2024 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095416; cv=none; b=TO3zsfh6g9EelO88uh8Qhz3nUnKrWzj6FxhT5wXLeKszlE8+qM+0STWY2CCk6tlAeBM/ol04yN5/7MCMOF84CU7M3b9Bz59390qreZvZKj1Ou1PQWsm2vbESce1qjq2iV6Xu0m/WlXNtvlvKyGs+gXuDFl3kCU7MziIeAGeMi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095416; c=relaxed/simple;
	bh=1kzMPNeE77BH7RWW2IHZPnZ3N0ckYJHNItG8iAj147g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOqzs1n73u9/y75bSNnXCB9v6IXBdnrZPK9Rpfzk+LL3hNJ55tH2ZVFAf4d2jfE5EtpiSZixQ4wWkxV5jwkqtbomXHCYswD8eUAEpFzZq/zC+Nb/G5wkE7qfjBJ0YVujyl3HMtz0tCMW9SBa9UVZ5U2HIelZkGWT4/Ccxwd9arI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKF9gxnW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e2915f00c12so2644814276.0;
        Fri, 08 Nov 2024 11:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731095414; x=1731700214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ePJ2Xji5F67wn/w1Ov+7ulu134bYlwHiGteXObNWNbo=;
        b=HKF9gxnWKpNxSyHeDX2oZBvNmUkXjaI6PxoqUV4kLmt1AY6HW1nuY4ASNqpHDhLF5C
         PBUn2BpKXMyfPBLfDFTRzycGGkeNfkQjIhX7J93vUXmt9k50iFVEBYGWsKqWCbZ8Rq3u
         mz9c543c7GUJWpr5BnzSDaUr8hO77xBWNjTkZMTLL/+C5YhvMxlGTmrruKNPq3EVT1Ue
         dp3ACUL5QBaBL/cV3poB2OsRjFiEoXwOdhglYbyYoWr+n/cMTcFgA22HRLCEdF1lzi4R
         vc1fv4DSGNga9/dQ5/CJr4JMUstt7zshEP5V4Vs9kHJ8TxTzVOM7WMHgDBU8vwIcm8ZA
         kMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731095414; x=1731700214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePJ2Xji5F67wn/w1Ov+7ulu134bYlwHiGteXObNWNbo=;
        b=wbozRtZ2BCzHuRcg12GjdAHTbjzsev1e2sc2kKdzQMJ+PJyMSkTJY5g14qiru8NUTO
         LJ+LBwBnsfSdr+Qk9PNt+4NlA34xE0PG2nsiNG93jYrOlDpBtGXehYZk7nCMEPbx5+Ra
         kNQ4s8SS4CD23o/aOTklpAii6AO7o2zfR+bpFlA4IPVyg1oheBcgVWJWz/A/TkuHu4P3
         6G6+yIkI8Ok5HBSi4QsopktMqT4c5GtAa6NUx7DCnNfH12AIFcBLAshShxpe8QgfLYHa
         qcGEyzFUiEcQcqWtsq8ktb4y+08MZvHfDj125mJp+l3maYDzLFIX4o1I4f9z0GkOMXqG
         EPCw==
X-Forwarded-Encrypted: i=1; AJvYcCV7h7w5oXGgKjKoKy6wSMKxi/iy6RDw3oiYarfwc2AjVTbBhOYJY4AO7GPcsj424uIcBIeaXdo7pRxcwpo=@vger.kernel.org, AJvYcCVSEMVhI94mnzmb8R27I9z0gdYb/bHnLwVnjTx+HBRus1HKI44r0YFyvQExk63ZxyDOqzsEFJFOXXOhnKi86/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaphjNUbvbwH+yoCjg4joURJ0oyq0E5aleWz7IwcHUhscfDmOs
	cqlD3pgeiI5p3c/59PnAOZXbyn2XpE3RvH7xqC0vpAWi+iMiriwbLfoS3pEG
X-Google-Smtp-Source: AGHT+IG5XIlFjABLXthiU/qHtrNVJWPOoFW3sTErkM+iA5TCvLfaew/GIAYaU1ptcfMu5QFABul+Cw==
X-Received: by 2002:a0d:d203:0:b0:6ea:e967:81da with SMTP id 00721157ae682-6eae9678286mr17518117b3.11.1731095413786;
        Fri, 08 Nov 2024 11:50:13 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8d84dbsm8571987b3.3.2024.11.08.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 11:50:13 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: johannes@sipsolutions.net
Cc: linville@tuxdriver.com,
	rklein@nvidia.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH V3] net: rfkill: gpio: Add check for clk_enable()
Date: Fri,  8 Nov 2024 14:53:41 -0500
Message-Id: <20241108195341.1853080-1-zmw12306@gmail.com>
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

v2 -> v3

1. Move int ret declaration into if.
2. Replace if (!ret) with if (ret).

v1 -> v2

1. Replace expection with error in commit msg.
---
 net/rfkill/rfkill-gpio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index c268c2b011f4..a8e21060112f 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -32,8 +32,12 @@ static int rfkill_gpio_set_power(void *data, bool blocked)
 {
 	struct rfkill_gpio_data *rfkill = data;
 
-	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled)
-		clk_enable(rfkill->clk);
+	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled) {
+		int ret = clk_enable(rfkill->clk);
+
+		if (ret)
+			return ret;
+	}
 
 	gpiod_set_value_cansleep(rfkill->shutdown_gpio, !blocked);
 	gpiod_set_value_cansleep(rfkill->reset_gpio, !blocked);
-- 
2.34.1


