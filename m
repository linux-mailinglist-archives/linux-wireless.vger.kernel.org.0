Return-Path: <linux-wireless+bounces-5589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FFB892272
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960B71F25B46
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AF41386DF;
	Fri, 29 Mar 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLpFC7Yt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0D1369A7
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732235; cv=none; b=TczLmcp8gXa1eSFdEQuSxYG8XoCL8Rj8dzZj33oDediT3NovEjzaIBy3bp8tNdQK4xtNR6bi2lYZMhmRfvZcBQrslVddGH2nf8WZedLIqJtkonrRx6Q9kUHt3VLFBKsS5Pgp8i1z/vPThTKU6n2h5E6fBAczSUCObU03KW92dbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732235; c=relaxed/simple;
	bh=j8245kNmaqBdGD54O9qpNwjQ/vWPCZt5nPTvELzjL/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDr1HPkM9c3Z4Q0iSUZ3HiGv5BWwiVgG4ZEYBikeEZr9/puYK++14soHAZ+s17e9pip9vIKyTH/dmBQ39Vh3YwlnIlVBeOSf+1NDOyCEqmBD+FrhRE57/LOu00s95El68efOAtE6NoI/STrYbZrJLekFqflbVjzmR6YL3CoinSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLpFC7Yt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-341d381d056so1342435f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732232; x=1712337032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JyWn95xLCs1iHXcpGVAjRQMK08lG3ym0K6wct33L3E=;
        b=tLpFC7YtKxuP4E9ehr4QyL4D8irBYg6EMy5hBtoyHwJtj2jBU+mK8bFcZn9M81ylVY
         RQWZbtqakPbm0KxA90bxDnDsJvu1v93hI+na4k8oAkUJP0fO/Kcl93wFpOWye6szD33l
         fl7yItegzx+gBTlPfHarzlUJMtqZ2aPAuCoAv1DTNacJFz25iyX7IYOyVlMt2yLgyMca
         CmUsc7m27Qgrg5JMMk1qmMX+3DdKz1zIgyKpCB9hkOmWVjYWfyP5ps23ewXHepVOAR62
         lsyndx67fugh7e7pfLdqHPFqe9Td21FBoqTnbCi6ToLOaiM4QO/Vr0kprwqL/xC/UsfN
         c9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732232; x=1712337032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JyWn95xLCs1iHXcpGVAjRQMK08lG3ym0K6wct33L3E=;
        b=Ah739HQOXh9WyLHdDdwynDO9OvGYt/cxKUc1FETV66v/eXjxT5aKv0Nv6IbXs5hjCB
         u3x99PfzvOwwPk5GCNPNrAE6qvZiibvLInwxTkLxPEB3Q+r3SqCc3ggpLLz5gBWfgK6i
         AovWuZX7XXs2AcVAqbbJewCegZJ6XqKGmm8Ud+0MhqKFuZ9V3wX3xgQ+hvjgYrfiSbfy
         nsWPhXP19v4eaAjNW+XFB5EuEUm+wYoMDJe9Wlj0K+wTju+SnX+2UFooeQB5mHX1cJoO
         inyd5LRnGDDIuoi9Iwi9R8/s3B/NQlUh3UXPTD6KaxobVzhOfcqVGa14mLIGb1cG5bfb
         6/pw==
X-Forwarded-Encrypted: i=1; AJvYcCXpDMSY5s3LUURn+/g19r1WV/pzRfQjCfm3XFSG/Ard+/wcHIr8k1vrdlgsBFEwjzvUCv2JWb+BRNfUTqjnlwk6kguOU9g0/yJWSAhAKYY=
X-Gm-Message-State: AOJu0Yz4G2331n7vTNM+btE/p90GERB/Lch0+4yeXLX/Xncp+GxYElRW
	9mg9aLSxwOg2kW6E/OgwOeMko4zh7uzUOmFy8oxjdsYNPm1Gng9kh5jHHhAlCxc=
X-Google-Smtp-Source: AGHT+IFW9DruHBuveqwhg+ktCb+5HkBVxgytJ4thp6p1EHASXSQYVUlK+ranP095Y2tSt5loVpZ6xQ==
X-Received: by 2002:adf:f306:0:b0:33d:269e:132a with SMTP id i6-20020adff306000000b0033d269e132amr1766876wro.15.1711732232518;
        Fri, 29 Mar 2024 10:10:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0033ec9936909sm4577665wrw.39.2024.03.29.10.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:10:32 -0700 (PDT)
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
Subject: [PATCH 4/6] wifi: ti: wl1251: simplify module initialization
Date: Fri, 29 Mar 2024 18:10:17 +0100
Message-Id: <20240329171019.63836-4-krzysztof.kozlowski@linaro.org>
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
 drivers/net/wireless/ti/wl1251/sdio.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/sdio.c b/drivers/net/wireless/ti/wl1251/sdio.c
index 4e5b351f80f0..c705081249d6 100644
--- a/drivers/net/wireless/ti/wl1251/sdio.c
+++ b/drivers/net/wireless/ti/wl1251/sdio.c
@@ -323,25 +323,7 @@ static struct sdio_driver wl1251_sdio_driver = {
 	.remove		= wl1251_sdio_remove,
 	.drv.pm		= &wl1251_sdio_pm_ops,
 };
-
-static int __init wl1251_sdio_init(void)
-{
-	int err;
-
-	err = sdio_register_driver(&wl1251_sdio_driver);
-	if (err)
-		wl1251_error("failed to register sdio driver: %d", err);
-	return err;
-}
-
-static void __exit wl1251_sdio_exit(void)
-{
-	sdio_unregister_driver(&wl1251_sdio_driver);
-	wl1251_notice("unloaded");
-}
-
-module_init(wl1251_sdio_init);
-module_exit(wl1251_sdio_exit);
+module_sdio_driver(wl1251_sdio_driver);
 
 MODULE_DESCRIPTION("TI WL1251 SDIO helpers");
 MODULE_LICENSE("GPL");
-- 
2.34.1


