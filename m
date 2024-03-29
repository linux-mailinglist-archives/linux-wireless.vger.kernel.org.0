Return-Path: <linux-wireless+bounces-5591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6568892277
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB9C28CE2A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F07B13B2BE;
	Fri, 29 Mar 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYdkybMP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B713A879
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732239; cv=none; b=DR4/CU98+nfS47LZy3ilCna+xQxvAgDEpz1YE8w3VbLCFBzYB20DI+kkz6bbq4MRuDE2XIM5WzpLEf4Hwp384D7zgE0mXNrX+pQ+iH4zvnss6LHgFxFPX1Qm7VZ5Xb/PIyDcc7yv6vAL7KpQJvrYoT/py69FZzdX5cDBDYhuR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732239; c=relaxed/simple;
	bh=TtoLYL6/37TatoGV95OdUAgrxwm+qIAgopro4pJ3dOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IkLfCFPpbPDTHGQ5S7O6bx704OhQeFtqa5GplnNjxKiaUYHQ6bIXAsbECJJDHtlGstZ54oeUtpNZRar26oSaeCNgw6PiRJ7JkfYd8dhQqcet+eSUDUAjl3y29HzPhuxH5uHOxcb3ZOsKb2aGLsBHYuhWTU4V8PraZPRvLeY5tAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYdkybMP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1146922f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732235; x=1712337035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EySlbPc6lhk6b3mrukjMCPGSpH2zeiX1mm/v3sWT7Wk=;
        b=pYdkybMP/oxDS75jztBh8pcoWsmTGNySgSqINdQP1oknjqoRlVvHX1zudh4csugXan
         nLp4bYyy6IxM/lpoWritifzvYUjv8ZT9QJ8PoV6cML0wfzWIFOOKWBXf8/eQF8RC6NeA
         s+Tua+XD6G5LH2aujkPrEEudk7NsI1t+Ppd+yI0aFzPseBHk/d61TAJwupj7Nyb/nSHI
         snA43tbpq1Ri0hFzofiiYHGCAArUeNj62Et3NzesglAN0ELsXMdFa61UTme/RlTWtaBv
         N4OBfgAbcX+6HWWSSt2VkhptZpdOjuVv60J6rrJX3xnB4PGgY6tS/JmNVXB/yBk7QfNk
         +ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732235; x=1712337035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EySlbPc6lhk6b3mrukjMCPGSpH2zeiX1mm/v3sWT7Wk=;
        b=DWFcVAlv7kpvaLbEUjUFt747vYpQ25ccN2xW4bvJug3ia15oXjddxHkQCT37EdvyS/
         9tOmymSzbVtLRAlx87tMFqyU7BrzhXPkBtfe9SZJQqRC64Z/0Sac3Gm7yGKytlw6s8BR
         IXc4vDeudG7gK53238ToRTtkX6jZVHMPOvEbJRyqNFwSnvJqQNzKs+0UbhVBr2VUsHlF
         +Q+Lfq0/842xtESQh16DJ3FwfNIGRaJf6zTakfT8zsnvQjR3Q/4EVxpeJwfh9jJqRoru
         hvGmypyp1rnl/c3A+kRM2TFLUvi821HrgA6MDH1Ft4dTYz8dpmrtTNxkQfq6btklHC9i
         2u2A==
X-Forwarded-Encrypted: i=1; AJvYcCU2ixozyenSepge4RZrKEVsoo20cZf1IRACcUSLTe1QQaCQpSh4Vte2rQ4F4IWLAWkloSkBg4sC/D4llg7F5iplHh9RknMOVyscBfPRAQ8=
X-Gm-Message-State: AOJu0YwwSOoJ7kMvQLxH6tPTHeopQalL+LY/iRByEbBkpF4OK0I/Eqns
	dh80RE+8n2C0Nc50UqdSr2lE088B1yH41+CagLIAmu6YJgthVVTCYBUCubpWKIE=
X-Google-Smtp-Source: AGHT+IEqNLgv3fhZtbvScXxguICCF550H3MDTyxKI1RnEPjR6ISgVMuNMpqBGyf1gUhiVrwdueDb6Q==
X-Received: by 2002:adf:f108:0:b0:33e:c68d:d536 with SMTP id r8-20020adff108000000b0033ec68dd536mr2617553wro.15.1711732235465;
        Fri, 29 Mar 2024 10:10:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0033ec9936909sm4577665wrw.39.2024.03.29.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:10:35 -0700 (PDT)
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
Subject: [PATCH 6/6] wifi: marvell: mwifiex: replace open-coded module_sdio_driver()
Date: Fri, 29 Mar 2024 18:10:19 +0100
Message-Id: <20240329171019.63836-6-krzysztof.kozlowski@linaro.org>
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
 drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 75f53c2f1e1f..e1b58ca1b3ba 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -3183,7 +3183,7 @@ static struct mwifiex_if_ops sdio_ops = {
 	.up_dev = mwifiex_sdio_up_dev,
 };
 
-module_driver(mwifiex_sdio, sdio_register_driver, sdio_unregister_driver);
+module_sdio_driver(mwifiex_sdio);
 
 MODULE_AUTHOR("Marvell International Ltd.");
 MODULE_DESCRIPTION("Marvell WiFi-Ex SDIO Driver version " SDIO_VERSION);
-- 
2.34.1


