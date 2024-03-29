Return-Path: <linux-wireless+bounces-5602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF908922AD
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589681C28F9E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797713BAD0;
	Fri, 29 Mar 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdwTozD5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1C13B2A4
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733100; cv=none; b=th0SmnKcZ1oZ0dwCzddCpGccPeBxTsA7aK5XL0LYEmmFjdUCgbS8Fq49W66NZ8JMCWkutdCRIveMVc0Ccu/HM4VZY95EBDFsNo60qzwjYfyFDnkqG7DsQFQHnVnSo5zIXYsNglIrwGYoEfi31Bqmg8VRfzQgC/zGKggosnx4eqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733100; c=relaxed/simple;
	bh=wDiiPdIToMYXQU5+yRee3/V3ANx19Hr4dGWjE2WOnus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ExdC4qHNAXlr23Lk/K/ECvvbQyo64PI/lLcBfQ+z0K/sFxmSXaC3jOmQlnsDs1jN83T3uCCX6Uvb4z6ia5YZrlmyXMGNRPiI92CgbFneeilIvKwB5H0Q3JbTb49HLmr0xEoFr9RK9H0CJLgW9w6HTJ64CcT30UOwrA7WCn4DhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdwTozD5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4154d24cc77so6254035e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711733096; x=1712337896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8BmwG7Q6jYnzmtteAjttsKel77uSlwfKjjKo/sXHv8=;
        b=hdwTozD5woF9OL4jxripOEhUPdN6zzBv04GjYd2tlIZ/VuBWyu/4gAghQIQ2Rg1Q13
         Uduw49mLBwdJoYiqGpqeDTHG7VK2TEU0pvjiSKXIu1bxBy9WK5S5NUJH8/9RK3PAJRzK
         opjX83w921eU7wm07SYYeQVLu0fnBpbbckeHGS+o+Q3zUE7BaqRYRUQESKQMCVAMlqZD
         D+owh08IIWAkYzzGAqIjaZxM/1M3y9c/EOMX4baSYIDLJYWTPpUhCrAO0Wxt9+Ow8FHz
         VXY+xkMSqxY3sTN3j2B9xFxacgbHif8dsbVK/2tf+KHMbWAeozWoQjrPFaSqfUHRp1HW
         huKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733096; x=1712337896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8BmwG7Q6jYnzmtteAjttsKel77uSlwfKjjKo/sXHv8=;
        b=N0LVmyhh66n0rDlswkSeeFfTVzXJDLBw9olQopXipeiNOkTaCPnGH4yaXhv6of66Xl
         dTzK841g46tyPWDs5ugLkNcmLeQnAUg8D6srpEpsGpW689RuR994a0aqCYywnH4MtPvw
         6I0BrvyKtHbfZhF7Bgnjel87fq9gdTO9KBiPQM2IKzFNEOQ+oTMDLpRbLzJ8CwHgG1dA
         jPlvhkUZcTz6MZ0q9M1E6g5ZO404C9uSPUObjgDQcmDPo3FvAfv+ZhLkTDCL+moEOfey
         nhPaem6iFB51/KlhB93l7L6Uh5SiinftnGHP+CWfqRxCwsw2V44rdTn/PAZ5XTr40jMC
         7W3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwzDffCikfCV6MNp/FeXZG0yG9iidHYzpNrvDLxqvrg/K5SF3lEpXxvxS5kB+opxz6t+8EUdj7ZaB+o1lAVK/30nN8T3CLfIZ69WO/0ks=
X-Gm-Message-State: AOJu0YyznwIk8o3lCAmAiv1rRuddMrdiJoRCPOlOXk2CLGLKgdIFBJcs
	/BH/XfHtJo5VNu3X/iBuz31E6SdnQnRA5eP5/CG7gqP06dq+PVjgBFP5HeuGfFg=
X-Google-Smtp-Source: AGHT+IGkMQKZmBwfysAyXcTOIdEaETGLP8XC6UQptvkkNiT6RrRdfIxr4AefhOFV8q8KgXAsCgTSLA==
X-Received: by 2002:a05:600c:4f44:b0:413:2c4b:35d1 with SMTP id m4-20020a05600c4f4400b004132c4b35d1mr2416556wmq.31.1711733096290;
        Fri, 29 Mar 2024 10:24:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm8491069wmo.39.2024.03.29.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:24:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 18:24:35 +0100
Subject: [PATCH 5/7] wifi: brcm80211: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-sdio-v1-5-e4010b11ccaa@linaro.org>
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
In-Reply-To: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wDiiPdIToMYXQU5+yRee3/V3ANx19Hr4dGWjE2WOnus=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBvlbWI+uz/9YwUaNlefiHsHpsoaQewqU+4KoC
 5vsAyo/lEyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgb5WwAKCRDBN2bmhouD
 17wwD/wJZQBJuomWoovMyFzif8oMaN6Puy7t9a5St5yy/oTFPoU3mqYzYEazstQewmxHvQUC57q
 12gVOI3lkjSN7jECNwwVrruhMnyzAPJX2Mj363zHzxxFAIWv02+1K2uoYMSiT3tboYo13zUUKAf
 bL2FV8El6mxFZoLTjYq+j+BQVkVDUxHH3vDDj5Gb6s5/CDQaSXMbzmJV3JM59LwxwkIRXOkDkp1
 6r4wkWH5vTAefQZbKuKd0GY+kaQ80eHpOhz5R+QbBiAWJ4KJoEKLXHFeXZJErpRRfi9vQgl1E/k
 Nds/H3lTLJ/HIIZv3545bPWIl7uWDabBQpm+o75gegBXRaW7DOP50XRPktxUF3cdtxXqz4IP6/n
 f2Ef/MKjS3MVCOlVsVThZS9RaoNQKbuM3yhDETpqBOv6Xv98szOYEkYtr5EQmMMkqydFE3FS50D
 30FIFa8pX2wUEu45dM3tEsXtoJn/CwiaDctGHRJfVHlBDC2pTeMT8eVp8SeRSEGIMmm4KNX4eHB
 PkQFlm9RMpykklRbyAQenHDshwl1WuDToLRkFW53XltZd8xXR4B5bYqMuV3Wdp8KN50y+1bUUxB
 Z5KPesX3r313jcBNZv7LfYa8aob+hVnPATZeEuObcXJCmEIndjEz5WZGaPdhbniutXm9FOlcdOm
 vozlrq6EJIGUBwA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 00679a990e3d..13391c2d82aa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1238,7 +1238,6 @@ static struct sdio_driver brcmf_sdmmc_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = brcmf_sdmmc_ids,
 	.drv = {
-		.owner = THIS_MODULE,
 		.pm = pm_sleep_ptr(&brcmf_sdio_pm_ops),
 		.coredump = brcmf_dev_coredump,
 	},

-- 
2.34.1


