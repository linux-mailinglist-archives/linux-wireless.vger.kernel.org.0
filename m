Return-Path: <linux-wireless+bounces-5599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8BC89229F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497F3288AA6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09214139CFA;
	Fri, 29 Mar 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8fEDC27"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4BF1327F5
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733094; cv=none; b=TTnQlPpwD8ZqzmE3SfB7VvTlfqiQ94K9CDs7kwjyiWrPx9Q9BGdEPCT6Y8mDOe0PrUJ3mk+Kgy/FHE3HPvzYWye9DnwsnThDy7wlmAu0XTbkMzgF11agWlV4nJSWznTz/za/IxJYFFw5sXxrCpxQlOBQmRlXL7QWRP7OX+77jUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733094; c=relaxed/simple;
	bh=pEH88/Mvde7IOqLLQxygmayTZOYyn7iF1rcGpX9W2Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pn2MHdgPOablaYEy7q+nH0U72dfqVVs8qdIn5qRymiFfnssrHNPRZFCiZZW9XJcbRFn5ru41xcWonWT3Awvnu3ED++9nCaZuVuMF/MeNCcpyox/oyAFlQjbm2/ry2oV+9ch7FVcj4QyScAQjcMO1sdqlAH7lVgqVLGzQCnsrZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t8fEDC27; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4148d1b4a26so14803115e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711733091; x=1712337891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhPv9uNzNlnN3t5bm/Vtd9WoPCFFzK8p2hzOyPKe7ys=;
        b=t8fEDC27dwszNVo/2Qq50EfcUK/fASUS1YhwF8F76V4Obs4EaV9hqSO2v5F9pWB+A9
         624/6Xc9ZYtSHQVwj7XFYv3O2x+8wBp+nX5goC7QtUThyACdqldl7rPBVnjzBSfXfsEm
         VLqVMDHhqof++hmnv60JksciVuKqDHBVb6zlAT1y5PzFqohOIRs3WvpaOe+Ao0pbH7oP
         8uZ18oK6DjmeXDwYsn41xbGJSIzTokn/Sul5QsFNF9M47g7X7y7iAjCR7f621e882PG/
         y9RGJScFtlCrBx+q729iUdKDwcfwOCKvpNiC6JzaApD+mxqOD4dTNL+5JiuAEULclBHX
         RkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733091; x=1712337891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhPv9uNzNlnN3t5bm/Vtd9WoPCFFzK8p2hzOyPKe7ys=;
        b=Dpt4d6LbUrxFCciNWBQ+zTyh9Me3001acKlQJLxlZeaWjMxY49l5wwhm/sqsva50R3
         bSUr4pRm59He9hoBQIfYZs6Qu4t7rpVs3O/ycMhIJYKJLYa8PK3bXTvvivqponlR6Q4k
         MlNajJ0rni/VTzg4GARwt5Z1u7egvRa5GlAl+gTIigOEn3FELLYAV/ODfAXGjJbzraPW
         ggCZvWhF4rVS2vS+iqLoGnnvUz+CPghJsnUp6yOs0eK+7isyPjYgbh6axXApNZSlGgvW
         ixpK8e16PzpEoQKWfjecGrsj6nD12gGAGQohjckKJBE8CTOFDfUmfE59Oeq0WkeDrtIV
         YVrg==
X-Forwarded-Encrypted: i=1; AJvYcCU+QeiPl65sf6SyZpWAJVF9lDduFFkEHj4/u+bIoZJEZibLNcWH2u4A3OORVl0lWuCp4i2W2kp2jtixcP9w0YOBukYDb8+czM959npH7qQ=
X-Gm-Message-State: AOJu0YwtFPLr83lQR17f4Vf+QS8/WXwuSTUfQEIdQ0KsPGpX1/LdW8xW
	T94HTFRjJFeNBld5YDpQ67Z+srmjGJmGaayiFi6zgL1iLrbayvegWbrCHIccmmQ=
X-Google-Smtp-Source: AGHT+IHtYKNLRf0lt/+X8+eWcJn/VGUD97lyqseZN1lBqy+We9hdEYMyYTdeRsMpokaPE1hUiL48AQ==
X-Received: by 2002:a05:600c:548c:b0:414:860:bdc5 with SMTP id iv12-20020a05600c548c00b004140860bdc5mr1971848wmb.17.1711733090950;
        Fri, 29 Mar 2024 10:24:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm8491069wmo.39.2024.03.29.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:24:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 18:24:32 +0100
Subject: [PATCH 2/7] bluetooth: btmrvl_sdio: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-sdio-v1-2-e4010b11ccaa@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=732;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pEH88/Mvde7IOqLLQxygmayTZOYyn7iF1rcGpX9W2Dk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBvlY9jlnYndvqf4ycZsSLg8vHI3GcQCFdx8JA
 nKG7a+rQTOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgb5WAAKCRDBN2bmhouD
 100+D/45p3tm81nQpqO6l6fT5LIfUPqYUD+5qLGAv/aTKvxeR1Yoiwfz7NpAwUBnyXCBk4XhFcP
 Ua4kpdZv5BN8cum+6JCjXVf9Ocd+zqHQMcA+E8ydJLFDnrze7mebC3CV4E0hXseHWx9BnrNMW/S
 ORtSDUSspE6eK7ZldHdULSpWDlil715pyv2mreTgfId7O/qp23/Uf6sGU2ggjBmG/7XShm2m2ls
 A5bbVqHvAeWn+LlnLq2kVcfTVA6RiqfISLgnjkP4CSLkMX8ei3mRaliwKRcp4NRdzCzZqUF59Bo
 tBJFmLTBeOjbIGtuT/Y2nQCmELTX42Vy1XCoge50qKd7hFCalX5HS5IF7qFCTEt9Ny0oxGIzmD6
 LNdGn94V8xmkCxuVZ54z2+chM0jF4rHQ3Vc+3ydZtoMPpd4h1zbDi6WzRniqsmV+36WgKeiQI5l
 9+XGDH365JVRpeKJvyCejPc+dSYivtHvch1qXIfl7oIczK2k8ywUCki7anHKIQy7AD0RQqhE51x
 ud6O7CvXO/c90RWS1v8TRMpt5Xb/X//3fK2naX9rxz8C1ytLivxTgDLPmRTy88SmEUP9NCgMVV3
 nElrYtsRKiQ4liVrALFnVJualZhP/pvvh6NcPC324SgjSwfwhHd+onfWNDrwHsw9bQn+qEF5uVH
 0/iiDkzzaO2uI4g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/bluetooth/btmrvl_sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index d76c799553aa..85b7f2bb4259 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1736,7 +1736,6 @@ static struct sdio_driver bt_mrvl_sdio = {
 	.probe		= btmrvl_sdio_probe,
 	.remove		= btmrvl_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.coredump = btmrvl_sdio_coredump,
 		.pm = &btmrvl_sdio_pm_ops,
 	}

-- 
2.34.1


