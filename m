Return-Path: <linux-wireless+bounces-13602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E80992CEE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655DB1C231C9
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887421D434E;
	Mon,  7 Oct 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="y660Vn8T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E31D1757
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307013; cv=none; b=PbaLoUXoSGDEWlYuAHFexIbYzloLpmJwHpO0+e7EKrdjpBdV/d7IjyqDBaUaIvmY8Lfr/0AzY2LDPf/zXQAvmEyZbyJtzqtYYHEb/mY7I8FJt7ye1WZrs1ge6Kl69qajIF/QUU21hPe4GDsYPU1sfssruyg9J/AOZv6qRPYlmi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307013; c=relaxed/simple;
	bh=OcYuo83U2iRwCpYhaFW8wDpfY57aiwrGoCMgI1DeJwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfgx9i9ev0RcQ5zAe/jAeQuIsssey2Qv5i86NIwrGAlIGqxejaQLVwd1AXrDptkZsDXvZFcxjVDNdfKVSyFW5xgo6G9hVEYlT3qBXG679iPBworMvHUbb7px0zFD2v4tNyWnTLPyDwkEONHSWff4raoSSbti83Q+JGMyYf+Mv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=y660Vn8T; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so27438565e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2024 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728307010; x=1728911810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xJ2YFkWfoe18Mjx4VFZ0GmwDt9WkCYa7a9JNvVutAI=;
        b=y660Vn8TF1N8RN7VNvfYjsefWwuMFay3yXawBOTqUWFEx0Id6hTU12M2AJIOqzx/TO
         +4pzycIJTYb5ETYUhp+kRQGokwjcNO9f6XuN0J4NZPnuSTwLFAq1GTbUJ0dniyG/jENF
         w+LRvARU6OF+GgtxI1XGAglQK+Q57pbpmsM0UKD1rElspWWr/zk960ENodyUwcYkeoC3
         WW+qNuzn4WQ8JA/HpCmDBZekH/cxZCVVBI5f4optbo7zF21UBznwZa5aOJNnftCUKZvt
         w1giQ/9HzwdZIYRnULgxZDd1NV6shyTGZYH7EanvWg2JkkF9U3qLewhiwtOXwO7BxLTV
         wPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307010; x=1728911810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xJ2YFkWfoe18Mjx4VFZ0GmwDt9WkCYa7a9JNvVutAI=;
        b=V/CNlL/2mp2KbLxlw+AFdmuz8BSJhnVtmJKOKv1nwbFp4ogrBbR+L17wVGevE6oWFc
         DqpOzz06ro2vUg1u0w5ZcDrxklPqZXdDqPG6VxhX1MEYxrK6em8liIs+FAUl6XH+Y51h
         SR1guB7rpeWtAiecdGa5B599REY7wIt0wbIDnQO93Tddv+kpC/aCa4XB9OGdy/Ybs3Ft
         n1YTGux7ZTFK+H/GxXqfTpp6mI0lCd8fTs7XegqEvjA1KG+3JM38EE/0rmu9Wd78rNxv
         DLX9dFWDkHc0dqyDYhaibo6k2N8b8hpZ5h9N91cjFvwcmbmcXO0ZiMxUEwj7mrDWKexV
         ymiw==
X-Gm-Message-State: AOJu0Yzx3ugwxyAL71EES1JZw/kIwAnxwvoLQkR+OLF9J5aWzRCsouzq
	p2zOjT8K828XWA3y9NsdiVWQ225sdGtASiQJWOPz5b8ko0EJ6/gZ3Sfb8hylwNM6rHav+pITSAK
	D
X-Google-Smtp-Source: AGHT+IFCxIu22KVn102zI/v0p4tBA3WyzTx0G+ILqzEftEQiZFlR0gzu/jBnsdN6zjbqWia8kun3jQ==
X-Received: by 2002:a7b:c5c3:0:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-42f892fd471mr57225385e9.17.1728307009843;
        Mon, 07 Oct 2024 06:16:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d672sm92484155e9.28.2024.10.07.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:16:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] wifi: brcmfmac: of: use devm_clk_get_optional_enabled_with_rate()
Date: Mon,  7 Oct 2024 15:16:39 +0200
Message-ID: <20241007131639.98358-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Fold the separate clk_set_rate() call into the clock getter.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index b90e23bb9366..ae98e371dbfd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -116,12 +116,11 @@ int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	clk = devm_clk_get_optional_enabled_with_rate(dev, "lpo", 32768);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
 	brcmf_dbg(INFO, "%s LPO clock\n", clk ? "enable" : "no");
-	clk_set_rate(clk, 32768);
 
 	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
 		return 0;
-- 
2.43.0


