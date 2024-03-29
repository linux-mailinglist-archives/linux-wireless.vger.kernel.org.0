Return-Path: <linux-wireless+bounces-5587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358289226E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452031C20A48
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50550134724;
	Fri, 29 Mar 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTA3rqNe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77328DC0
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732233; cv=none; b=m/n1M8/kqpRC+dWIg+BlGh+eHDY7SuilzITQZ+nZhIjLXi1iHNGY+iH5O+59APWXuhvDlwbHGcEogSZmV/dL4XN+kO6hWKPQ3Y1F0mQWOzJI94nH7bznV3DOXwyEL2XlJ0hETgCRFEjgS4hrl4ANyzmKxJR5kWkWlhETFKwGXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732233; c=relaxed/simple;
	bh=1do6tfNH68DObpEKyzA1h8TA9LOtGeD6ZTJRXrUWXBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBCcSrn78ydx/oDV08gdP0Onj/XfYSro10ZNmfdkcHENTn9zqx4oztogGzpk6SXENW4ACiHsw91miZFWGVFf9/brNWwWjDi+uXw9Hf/k2ArotxoDVp8jySgGHawk2FuiF0mSp4Tg4vebx2FSySk4ddJ+XYSqeuT8PDw8hC9j0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTA3rqNe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4154471fb59so12214295e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732230; x=1712337030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl9e/glL3WN5Ke/EqF6PlMNs4wHLhHYNYdj8lwPraLU=;
        b=qTA3rqNe3HAuOX8zS3pIZjF07nneZy0VMQVEDGMMX3Ul+Yq1nhz27sqdyA9Dk4tHag
         dpLMI+HqoJu8ju9RrzFpjjxN+qpkRzSrVMQ9fF0w9AQPwFdMt4RkR0Uw/OfTN/d78TXa
         4X18NN0HtAKYACKJFhBka63MH4uWERlReRnTsuRu3nIaXtrdAlkI6pBUQv+Iq2OQ8qEK
         IDd76XAGRx6TEZewkOs1w5PRRlc6Ms6xWtgDemhXyEV9/vmVrXbWfT+bityzqXymJsTG
         Xizp3blV4aJWjRDrSGnsKg3EZPvJGphBrmK+MAcpKGT91r8nCjMEg6lIUipJosEm2dRy
         vZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732230; x=1712337030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl9e/glL3WN5Ke/EqF6PlMNs4wHLhHYNYdj8lwPraLU=;
        b=ojQ2J2ZhzAvFFjk1/26p/32oGnmMfcWMooruifhweS5jdS1wN88a1ZmM6ZrZ2seL+r
         zS18vjRqX3fgf1Vok40r4V0FTMkuY95VLBWEevnJq/b5d4PSTVjDjEux648GZy0hiX0Q
         1m/b9bfEfqmKk1sGBSwC9Rw56EVNcn/Gb+Y7ZYyH2ybsHMCEKM3YCMe44hauKcyytZpf
         LxfrFFIHC/j6YxR4jfFLSJJrXDIqAC+2cU/3BWdNs11Yin5u8m47uhpzKRkIxvyBGYNe
         mICfqOrKmMqS145zvsUOdyaUQIjfIVC2jZVjzH/hGZ5NUnUQOin6qtRVipGfzWhtlwlm
         z8cg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Hq5J9Pg2M8rzWiBMqpE5lKG79JnDuhKwM4d9nnSW4cyJ5CEuuBqvr9LeJph0nE4P8FghzNweQ5eH1QV5ffOdBgN4LZFeQ+4iiZt62eM=
X-Gm-Message-State: AOJu0Yw7nEz0E8T/filcBoT3ep7haG0QU5cD392eQ0DAxsPiVcQQwDX5
	38D/r5V3mphpdLzJCDvR3FpD6gAkW1PPCkikOYPd5+VOOPl25O65Wp9ZFzNboiEamejJMlvbJ1t
	O
X-Google-Smtp-Source: AGHT+IGWRmVRru6HhXuMrT26wbmLt8juVtl8/ndRNMn7ZfdtMw/RN4XPuzVFDz8oZ9VNkUeJPKHs3g==
X-Received: by 2002:a5d:4750:0:b0:33e:69db:bf8a with SMTP id o16-20020a5d4750000000b0033e69dbbf8amr1582625wrs.59.1711732229769;
        Fri, 29 Mar 2024 10:10:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0033ec9936909sm4577665wrw.39.2024.03.29.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:10:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] wifi: ath6kl: sdio: simplify module initialization
Date: Fri, 29 Mar 2024 18:10:15 +0100
Message-Id: <20240329171019.63836-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
References: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver's initialization functions do not perform any custom code,
except printing messages.  Printing messages on modules
loading/unloading is discouraged because it pollutes the dmesg
regardless whether user actually has this device.  Core kernel code
already gives tools to investigate whether module was loaded or not.

Drop the printing messages which allows to replace open-coded
module_sdio_driver().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
---
 drivers/net/wireless/ath/ath6kl/sdio.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless/ath/ath6kl/sdio.c
index 8a43c48ec1cf..9ab091044706 100644
--- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -1427,25 +1427,7 @@ static struct sdio_driver ath6kl_sdio_driver = {
 	.remove = ath6kl_sdio_remove,
 	.drv.pm = ATH6KL_SDIO_PM_OPS,
 };
-
-static int __init ath6kl_sdio_init(void)
-{
-	int ret;
-
-	ret = sdio_register_driver(&ath6kl_sdio_driver);
-	if (ret)
-		ath6kl_err("sdio driver registration failed: %d\n", ret);
-
-	return ret;
-}
-
-static void __exit ath6kl_sdio_exit(void)
-{
-	sdio_unregister_driver(&ath6kl_sdio_driver);
-}
-
-module_init(ath6kl_sdio_init);
-module_exit(ath6kl_sdio_exit);
+module_sdio_driver(ath6kl_sdio_driver);
 
 MODULE_AUTHOR("Atheros Communications, Inc.");
 MODULE_DESCRIPTION("Driver support for Atheros AR600x SDIO devices");
-- 
2.34.1


