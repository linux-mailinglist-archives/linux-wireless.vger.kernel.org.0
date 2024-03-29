Return-Path: <linux-wireless+bounces-5590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B47892274
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CB628CD74
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8050413AA39;
	Fri, 29 Mar 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/2r5L+5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1628139578
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732237; cv=none; b=dT1Pj3uifQOoVwi7D5K0CJTMQ0ZElkSWGKXzppycXI7eZl6mLui5wAPSe3WBdO+BofZfacPh5Mr+PfM84mjWtgn4Ib//N+LVLL6F2x/fXZVTsTpnXWzbIzFKXLhT0FFX6k50hl0UaUcjici057XiByhXO2KyllfSs/fl6a7WTXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732237; c=relaxed/simple;
	bh=8V77xah4yhNVMN2cCcfaNNY+lDG7A6fibNbEMab70Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NoxtcYjokpHb4pXZ2SQUuk2cVvNI6ar9f3vuho08SYBc83d7FPTT3Xq5iJgEhi/WfpNWw3s+3sfKthnJoIZHIZxriFhEZwbAyQiNfB8/C5nHy3YNR6jMiYQrbZ4z6UneuXwMEwTP4jz9RfTFbm4Yyx+l3f+vqJMswzWBj3uAIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/2r5L+5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341ccef5058so1455770f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732234; x=1712337034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDPoBwJ5bVbQZyn7Kt2KFjIml91twnnq9PMjrREMHA0=;
        b=W/2r5L+5TloDmWztMjhTRmzXMgjPXFXs/uBOBjfKg0K/e8NN4DAD8GAUgprpmoqzqu
         YO1sB/WAfhGshDO7IxXyvqQxWpUm0r5ftNvLLHV60wr5GSRZ9TRchHPGh9zVa19ywC2O
         Mb4KaqsEAAjPeOb0gxJQ/squyxvUabzWn814NWPSIHyMkarFhPVtEKLM7WpXmp2x0vcw
         Aqj8Ch+yPsKkTFmyHtgJtGEP2pUlYe1EYy7mSL74MDzzSZo69RF2Ujw3oIRgpIp9M7s6
         FCuRYninOD8lsT/eMRLCXGpk5Jv9b/6QJZiPA/Gm2i2VpkFVFd0omR2WP8V9ILIZfcTZ
         im5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732234; x=1712337034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDPoBwJ5bVbQZyn7Kt2KFjIml91twnnq9PMjrREMHA0=;
        b=FBwEa1jv/oUxHqI3gF2muUYz+CHQniouaK4Xd5zJT27PtvL+2/GsUJC1lkYgpqNQke
         TPWtL+O1UE5YB1Xxc40Uf4sz4uyt81rIxGd6LL6IgcBbp/wWhsFyYkG6K7Z7M4TDROGY
         ycDM333XCtJ74+uB0oxJnh8ApgiRUHJnvsWClKhdFEfz67aOzO2ZZIm8KTSrXzIImcwe
         U70nG/d/2zle5Ao5vCN/5l9JA8RZtHA4e7y36HEgBs2YmGGm1/b38ELcDXP8dQIh7gBI
         wxKxdFReMb64dYzrqb9pNR/IT/DJnsMv+ElZ3OEdLkimqADqMOe1j6knyAJLiaP3EWEd
         2PCw==
X-Forwarded-Encrypted: i=1; AJvYcCVLJ3DwtYPTlXJ4QyjHnFCThao9yVXvkr3vmRYLXogSfK6ijDbKB2RUzLBeQtl6EOSuc0AyyCEyMr5hQjgJ4wLKuN7oUhlBcM0dIL6sh04=
X-Gm-Message-State: AOJu0Yx/or8zH0FzIg7yYnhrqp+8Xr8Cc82EWDubT+cgaLdf9Qn7foPi
	b1esdArJArySZUuuqgcaTk/cPV+mlRC82Mxs+kWeUwnVAHvuTQUDzgOHZgbdx08=
X-Google-Smtp-Source: AGHT+IGHKEJmqmT8lE9uFbvmdQZUSZGau59d/kr0LCpA6rDvXpAZdTZRaCDa1JV/UgtVfEhdvK61uQ==
X-Received: by 2002:a05:6000:1d82:b0:33d:a70d:a9b2 with SMTP id bk2-20020a0560001d8200b0033da70da9b2mr2096293wrb.5.1711732234082;
        Fri, 29 Mar 2024 10:10:34 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0033ec9936909sm4577665wrw.39.2024.03.29.10.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:10:33 -0700 (PDT)
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
Subject: [PATCH 5/6] wifi: microchip: wilc1000: replace open-coded module_sdio_driver()
Date: Fri, 29 Mar 2024 18:10:18 +0100
Message-Id: <20240329171019.63836-5-krzysztof.kozlowski@linaro.org>
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

Use module_sdio_driver() instead of open-coding it.  No functional
difference.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index d6d394693090..52a770c5e76f 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -981,8 +981,7 @@ static struct sdio_driver wilc_sdio_driver = {
 		.of_match_table = wilc_of_match,
 	}
 };
-module_driver(wilc_sdio_driver,
-	      sdio_register_driver,
-	      sdio_unregister_driver);
+module_sdio_driver(wilc_sdio_driver);
+
 MODULE_DESCRIPTION("Atmel WILC1000 SDIO wireless driver");
 MODULE_LICENSE("GPL");
-- 
2.34.1


