Return-Path: <linux-wireless+bounces-5828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F6897245
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA8D2852C2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574F14B070;
	Wed,  3 Apr 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flTLBk74"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302114A4F9
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153838; cv=none; b=XzavC5BLvNCRyToTAkNUF7U9fUJYu5XXs8xGRWY24cjUrfp1p8+TBr1N48G0WHjiEvTV6/C0n6W8ECnukiMKCdqyFlN24nS6lcckx0pBByts0G+TzgWOsgDv7GgmNEepjojwzdkQB9oeZYpswnJJYgMTqRimfGYuW2k+s+qNX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153838; c=relaxed/simple;
	bh=QdpKnfzTFfl7629ghdBbT/xMhayZvm2B+bXXRAfXC/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOXRWEeRUGvYtJcR5IMx+CKo6ZoLsWVJClG3gsTPRMUTeaUfyzBxOJ7yH2ULXs8O49NhzjqhzeQ1gJQSw+HLSS7ct5tvKOr3SU0gHW544/Z0XBcOqLqRpf+tB54vaWJqWvKZL79vpDQSZVNKZG63WycTSWwCjrWNV0YVdysXAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=flTLBk74; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4e34d138f9so675675166b.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Apr 2024 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712153833; x=1712758633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8CF3YqTJpyZfex95royntlXjuqDXfKm+2I23/q10a8=;
        b=flTLBk741YdhOMxL4bc4AfKV54RwzLD6zV22PZjSFTofV/7eVvQAGg80BexYg8PNnu
         9HIiF4cRP/zzjA4iFjw504MxYg+pOgi6FjCm4l+JQATGYvgGPQxzVbDfzAhWbJy2yTLb
         N34aRVvSLlN9wrlUqME+wwH2Bw3nxqGZY26f/0NuZaWbAkBGdB/RLytkRmO0Mdafj7Da
         EZ5P2AGPT6pxp1eyisBEQ1COtdx1dP2U56diCsN5g+yeymvV48ieY5hAykW9gLYEz3SZ
         LTk0zcYoxv8mvRMLON02dy3a0GjteLGmuckFhudICxFfvifxwRHhN7xkPklBzUyfVtpd
         Tseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153833; x=1712758633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8CF3YqTJpyZfex95royntlXjuqDXfKm+2I23/q10a8=;
        b=qfFX88JU4tI2PFAStj11LWUUZshwIu6hyuX8pYdPeJpizKNbA8Mq6tRklV0hO9/f+1
         CUbKrOnhL4xh1E4epR1wjkv4JoX01mZjON5olp/o1MrQA02KGRhJerimgSOy9eCWMaCi
         2zNxWcK4IbnXkMB9tgg1TxWFR8PglX94XV6stn7d5tSeRQi1KlDQ/6RaWSYVPBwTAzUj
         NiXUytU8TssT5sVe8Y4dRQUKFAG9VaX+AJkfGwVNbjeThIxLfKn4BEPue2LXedKvM9eU
         kzlmWJLDG4yjOacJmwqbtcoCdR28Em+WeAbDFfEzD+yMl8lEEL47ZT6TVlkQmmk6uWWK
         mt0w==
X-Forwarded-Encrypted: i=1; AJvYcCUT9EQGZqo9fcpnVSTv7EX5iin/YGZloluAbE2zpea0R8pt5vJ08FdXJuiLU8wbyC1tLx01MTeMeve6jH5Zr7FJZ7ySWlQMZnwA6FbLf4c=
X-Gm-Message-State: AOJu0Yz13qOJiA3wTaZvcrHAWIx+rz5RYBZEUfONT3fGvlzzYKSF2tMK
	aUkQ92RwpussjOuoRxtFOkYOBwJCYCz0j5F42Ny4h+q8udrMl1W7xvZzuyMaNMFg+A6vjOY2CHx
	I
X-Google-Smtp-Source: AGHT+IEUtfdmZfKGWRWu0raSk8TGFpN5pIwAwL9y5tPz9aK/wk4bFhzOX2A0Eo890n5dIjGnOyOkVw==
X-Received: by 2002:a17:907:9483:b0:a4e:a204:e646 with SMTP id dm3-20020a170907948300b00a4ea204e646mr1613986ejc.64.1712153833354;
        Wed, 03 Apr 2024 07:17:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm7737819ejc.53.2024.04.03.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:17:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Apr 2024 16:16:53 +0200
Subject: [PATCH v2 4/7] wifi: ath10k: sdio: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-module-owner-sdio-v2-4-ae46d6b955eb@linaro.org>
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
 Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=794;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=QdpKnfzTFfl7629ghdBbT/xMhayZvm2B+bXXRAfXC/g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmDWTcaSwzCg41URpHmCIIgbHloJ5RwRX5cfD8H
 j07G7iVMXKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZg1k3AAKCRDBN2bmhouD
 10i9D/99gR/B7ovrPXnyfbAPO/7GCElxPvvHn2XRdqAxM1ZKmgJ+gxlTXYBZvMuLM8KI9dwWCWl
 tSCaUaMHajsac3WbHxh1dsgEvWLQM0XPHZFyXu63SUpfrhIWkFJBqj2yJ5sBOMWoCLvlEY7iFiJ
 XIuwGpvYxcVW3xbdY9u8IRKe2d/QQClR+Pu7YwyaR3OPRRPjrlzxEIazSDl8UCUzoIBEEgXXcui
 D9Nl/I6MXKHrGyeQ75ObjBsC8f/55RhXUb0iwrFKNZ6fG+YHUkxsbjCiBqbDm8+8nvYE+d2WV7W
 /A1XSVK/KOjTZ/94nDBXPK/iIztegRewNOWl1TaG5lMMiIyQqvFHvRi5tqYyHeZiAf1y5FJqEHA
 eYIJqm66pLjbYfM0t8o4wvGIUMigBEVp4b6fZUb8J99Yp9zjodHujpfYihjqQWnhaxtHuHjDr5n
 ZasOnpB46kBTK8c+UVKJuMH/Pf0KQ5Quqv8VhOPdJHnKlfMwKfxGf/kGUBHs1uL6Cisxsytw7fX
 LW+wVCXaVhb38bZ+pjlVneUG11da1AYcl4gJgTHkDAAtTvny3D1hiLUWFQF4b5WqH5f3dIh4RVs
 mi/sXs9DKXNon/qkHvKUJr/49OHoZMqKQQ6S/QgwFY9OTVImKFTmbtSxDaoaGDw63BijvD0NYwr
 +bU9iK84wUPmpug==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---

Depends on the patch in mmc tree.
---
 drivers/net/wireless/ath/ath10k/sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 1acb9fba9a8e..cddd9e3010ee 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2667,7 +2667,6 @@ static struct sdio_driver ath10k_sdio_driver = {
 	.probe = ath10k_sdio_probe,
 	.remove = ath10k_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.pm = ATH10K_SDIO_PM_OPS,
 	},
 };

-- 
2.34.1


