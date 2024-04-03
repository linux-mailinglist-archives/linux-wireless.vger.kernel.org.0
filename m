Return-Path: <linux-wireless+bounces-5829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246AF897248
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 16:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEA61F2220D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3EF14BF98;
	Wed,  3 Apr 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ks0grguv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228114A637
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153839; cv=none; b=j4dilAh0YsaJ0BVhtidMGg06t/jaMnnCXjYaY78hP454ZVNrlLxnP+5bKgNs5WkqUbWpYqI8yA9LFa1ZOJNHc8KtAeNvbT7PX/62gIn/PCt9HxKkXjfjiESZHAeIi7EjCplNI7v6roDh/GxEgiTQny62E3XlbNMFDj4Gs6XEqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153839; c=relaxed/simple;
	bh=+oQOj54E8azRB6OAy0SBTyBX7qm6Cw4f0BTTdrV/19g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwywQ+c+QO4IxXCNEzHhARGtgSvMhKepJPp7KiL1BAm05I0VoSqtYj7qnX5hjvUldyb1kQfxMpOs00uaBfft0/LhAvhCthhezDPzjv64monEDp7PxoKV+RQlQSJoB9+ZbzVwZhrjQv3wuu4onOwnrarQzQWFsNFPOWvJuBoF/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ks0grguv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4e60a64abcso170676266b.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Apr 2024 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712153835; x=1712758635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtzghwkQC0PmjQC/FhDBGdEgi78pS9U5YA2ZXwW6cgM=;
        b=ks0grguvOETbuTX2Mg9Hva8OdTgyp3ZoNri//mNIG4LhHfD5VN2y3OrEKkpEt3rEfw
         a6OBRloYMaZRiJ8NqNsQqlACjkPyqVECFecuEJP9bOhTlsAlK+j0NmIv0/4VCDF2AJ+w
         4sYorpaK029iWBNsxJggfB+ZJfOUUM4a5JaeF9EkmGAhBDqF0nZELGkaI+P+CtmjIgle
         NDQeu3Ba59gqOrYNQ4Q5foTDPhS2uXujDUekdPE0bG6h4zeWdwOVWbm712ByIebupWfg
         nP6a8Eflakj5Vv0N5yp3iqnT0tYkxgdDMDUC1AoRr2Cue1akSQjZgjvdTF+KyAGR2QqZ
         jctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153835; x=1712758635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtzghwkQC0PmjQC/FhDBGdEgi78pS9U5YA2ZXwW6cgM=;
        b=S3Kdb1iQOCT50xdvwfuifQ2BMQfjsj0fe3/JTENOiPIHvlP2MWJ0lFecCCvcFpulcq
         6FIQf08T+dtiAmUeqe5YMt0awy9GhPyKgIIwzKCrr+R+obNQZ3cG3PePsCR8ALXLxBKa
         anTQSVomHdUwGeXAy37kn5Y5mUs+FRxeqo6an1mnotcmyzMN4Cq0+tTLyaA3hk/lorA8
         FlOYYwRcmQ0CPjHs4aZPFk8OeGfEBzr9mhIKtQBb+Z5gbCQEbG8PGuij27S2Oomce1Hm
         OdmNPMMDr15CgItZQ9SSoW3DXiRL94MpxJQpijqwokmsMUZv42m0HvKsMaURe1ctr0Cp
         oG7A==
X-Forwarded-Encrypted: i=1; AJvYcCWVqBVP/gQjlva57dM27C3btAYn6bkPf8zYo+X+vgong3p3Xe9uiLl8io2Eu3HQ/aGxF/4JUcMBpt/X5q0uW0yXaN7GmUk2vU8VbmhGOmM=
X-Gm-Message-State: AOJu0YxdhCytFaOuipWP0FGXcSWBs+C0gxhTHk8BgCRS3CmtPeUrd2B9
	K5OvwdLSGb3ymEAEOD1l3gqpqpy8DUVg8usxUQ8T+BZ1TrXnuSDKXRWJDNFmWT4=
X-Google-Smtp-Source: AGHT+IHhgEWh9iPNOPHwnOG5Ucf0f1VjLhJAnC0jPd6Py8JOZqFE+ITUDFrj/tVu+BgC1bMNTDrVYA==
X-Received: by 2002:a17:906:f203:b0:a4e:3841:8da9 with SMTP id gt3-20020a170906f20300b00a4e38418da9mr2445038ejb.23.1712153834987;
        Wed, 03 Apr 2024 07:17:14 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm7737819ejc.53.2024.04.03.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:17:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Apr 2024 16:16:54 +0200
Subject: [PATCH v2 5/7] wifi: brcm80211: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-module-owner-sdio-v2-5-ae46d6b955eb@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=936;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+oQOj54E8azRB6OAy0SBTyBX7qm6Cw4f0BTTdrV/19g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmDWTdk4remwYQ8MPd4+0bn1vbzqllLhREEFzZE
 nqHbYhDUiaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZg1k3QAKCRDBN2bmhouD
 10GHEACVe0SHPfWrkE8WfxpC0NwDclSzh8WdeUe8P2iGIhi2sSBmHMWdbEVvwA9PEG7eDB+lXHQ
 y3vG54Y+GTZz3oErC9uQb+hWN3JzA1tsIZww1h9xrezZ+dHz+FpsZhz6VWSG271LLle0fmTzzzC
 3/SC+j3CiyPS/JRWizY1s4AxuFuSRiN67/LUGaXDQd5+VDig6n1gdH5oByYOnL2cZNDybG/fDje
 qSXiUl9pkheNK39WKuvwn5jVwJxdohynYCmR2ePhSJfLvyroUxXque3MgCqvk6DS61IR88VqP4X
 P3uEzcVFQCghvmhnv/Mj+gBdqOV/BJAjvC0Q0pwAfNKIv2A8LSd8KsvGgG6aalFW57nuOw8HC87
 5RoT8klgd7VwJA2f0bvjXtsZXkoIoL+73dU3mShuF5Ara7wcxpXXBrzpZdrJ8exjN3L/UYqbAsr
 MjQGm0YUEnN7MshNVlBNwx39kWCCvv5HV6qF31vpKcYUNjuD2FXj1n17JGqMO4pTPCn2DAUeyvd
 gQ2Cs2YcDuT78OzcrktDA+vylKPDyonrGSChlZ4WZWO7oiy64jN1KTzFJHsdFO/0vC3oOX1ts/q
 au+zXHVRkAi0iqcmT28UKAxFFFpWHoKMiv/HLfDlAWvQrtH3zcR0IoZdl+WyAU+Wx+uXvOAyNji
 8iU4ZZ+B2ce9nVw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---

Depends on the patch in mmc tree.
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


