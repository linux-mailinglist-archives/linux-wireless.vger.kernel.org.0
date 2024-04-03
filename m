Return-Path: <linux-wireless+bounces-5830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3889724B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 16:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996371F23125
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FEC14C588;
	Wed,  3 Apr 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNaRJZXv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729A14B072
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153840; cv=none; b=P9pgbFd7TX23WzczHr+OJTBxSqh6cmneJJ9etB3DbGRQqr/VR6QkX8HSRBuIO7PEKhartuaIe+quoJOw87rxyiZwUgZY6wqZdFNX/TRMv5213X7B2exRR3jY929e06RoRweecAM41Ue/RRLDfEutjFAgT3Tds88+YFcs5D7Vme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153840; c=relaxed/simple;
	bh=44MLP9zefnsNnal/9x3LUH01f3HB/XMi7tqRa1ODu/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ow/CG/sFW8TtVNudE7hNZjDsleeZheL47xYCrTomz08nK8n7qnAMhBmKoU43RSplJcT3zJxS0UnMb0bI6pBHigtyDs+bZg+/zC94TlEJtSLKPm09WpQR772JCGGupAcLyXFyHdPPlcsHHMaWZGwhH00I2jMEQ/7LoNklN4lWwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uNaRJZXv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so9532975a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Apr 2024 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712153836; x=1712758636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0vV1TVhRuXYRf/9v8gYugm0cKFpboW4ZZINajTG3+I=;
        b=uNaRJZXvanAS5Bdenpj9jIK8YQ571I0xjJzdRUAElmKB2hjP4IDGTTPm3OnF9AYxx4
         7Ay5aULnJM3CnwGKnsH2xrXofFpa8/s3lmOqAlrEEVlR461CJVkUNtGZnzs8m0Ly1eGY
         r34hkVnT4aA4D0o5LsRm2LWkOiV+CZy06B2ADgxZ9btuC+Ik7TF7RKfQixNM0JUCTjoO
         e9Rm9MrhT9Rmsb4VmXx0115fJpP8iyLmL/4Ske52nHls0c17c3xiUMDXOj3/OhJVhcux
         FaNc2jorEMyzsupyqxxyCcvj0A2DxcZXEr5+5dsWEUD5F/Wn6qud3yrEx1g3XEjfwE8f
         1tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153836; x=1712758636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0vV1TVhRuXYRf/9v8gYugm0cKFpboW4ZZINajTG3+I=;
        b=xP9G8XMXlVOH8SLx+btRYSmZ3A/dK/z+WZsHRjxISFSsfpD+tNR5MPaMo2qE2ug6dM
         Xe9a/2GEGIizvdqMW9QX5yBVwXuQI4ku92Dk8Boa5kGNMLbsO9h0GtjlyJFox4bIZ0GW
         ce8RsPLMRsQuFj+jNdmuoCFh6Q4Isq6k0fo+hjUmkF3FDb0Hx4bwFhfOMd0FUdKgZI7T
         exCHVnRRhpvoXYAYaIOKsdA+JxKcEkF8Bu361XdaLJvxr7w3FhZURC7fOAYzZmhSFPgg
         7aaLya/TfmC9XK7ANykoELMSBRrd1mh42GE+QvICp93bQDupLljnv0KEq085Yz2d5Lr1
         QBlg==
X-Forwarded-Encrypted: i=1; AJvYcCVa2bhF+ZYwz2KGHt/ijo0xHGaSr/wqdEB/PxCwGdurSavj6ksk1KbecVd3jU7UKQa5gdEXxktDCho/xL1GEnthkg2asA3OQJ/IYTxOPqo=
X-Gm-Message-State: AOJu0YwRIUOa3vDzsbykqJIOQyQY19RrsDcdzGf+aNI1GX2XnbEc95oC
	o1JhKMVpYqr5a1eja1+Kb2eqwcaY+dgjuXkTPeJ+pV+LeMR/zHa/Fg+geYA3cWo=
X-Google-Smtp-Source: AGHT+IESXedZWS12j/IBeLIYCIeiTvUtDhGnVVmwc7Y65AKvMiVNSuQO/q5aF56JXsx/yKl9XqaeMg==
X-Received: by 2002:a17:906:b889:b0:a4e:101e:8a97 with SMTP id hb9-20020a170906b88900b00a4e101e8a97mr1828471ejb.65.1712153836735;
        Wed, 03 Apr 2024 07:17:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm7737819ejc.53.2024.04.03.07.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:17:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Apr 2024 16:16:55 +0200
Subject: [PATCH v2 6/7] wifi: mwifiex: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-module-owner-sdio-v2-6-ae46d6b955eb@linaro.org>
References: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
In-Reply-To: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=901;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=44MLP9zefnsNnal/9x3LUH01f3HB/XMi7tqRa1ODu/w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmDWTe16dq1dJEsJSnP/kRyVGwLiEnTFn788+oV
 GGtYkan9UyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZg1k3gAKCRDBN2bmhouD
 1/9kEACCfFciE1oJa5A3bFkEqBgQPN/py7DctCjUn70y9z0g5ME7fMcUi9khdsK8OM3rvoqne+o
 U8NNqieNKtAO9IMi2CPA1wC8M4Wh9e4SCx5XngbxiNWP9/eEAnHvBGxckTaLGtPrX0yqgvpb8zf
 8DDyI6avfAZTM75Goy/SBVEFEQHhNDXHBwAsHJfHHerATA2Eb0RtNfrdl6KZNHpw9dBki/Gqguq
 SmFaK64ZzF3NvOxY3j0bnSd7+TSXkt/XbCu94FYgP69uva7f608NittH/9PlF3lPqtwoMFZuite
 C72R5lG5ygVaTQrAjmpVPU+ptiW1S4WE56ZoAMnE13XJ40cnXSfWCTvHVkap0FYipYZJ2jbI6ZW
 T52u7f1yoFmxcJMxt+wi0OFJ5yr0sRPZ4ykTk0TE0FEnjdfZUTra0qpR1eTpP4SwDyNKwTHqerO
 7mCz2E+zeY7hHhvcaiaVLD67Zh3oiZaz7Gk0bCdz+AIZSS4+r/eIJZPXCi87hUJG7mzgB7kCyKO
 n629sK+58CEmUGqaqdYlJyFJhXPRHh0x3psIBUbElx8S/NNF8VpPJ+ayj+xk0YEQBcco9ZuQjVG
 XvGW/Qwa5uZQp0HPCL5SceQ0/zwQULALaSmtsD/ZYO5Jd3u1gzfyw0+kMi/gdZyZ+KN53+foAhu
 PLE3iIJrkQ+zufA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Kalle Valo <kvalo@kernel.org>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---

Depends on the patch in mmc tree.
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index f41048b5cd3c..bda9b2b8a1f3 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -979,7 +979,6 @@ static struct sdio_driver mwifiex_sdio = {
 	.probe = mwifiex_sdio_probe,
 	.remove = mwifiex_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.coredump = mwifiex_sdio_coredump,
 		.pm = &mwifiex_sdio_pm_ops,
 	}

-- 
2.34.1


