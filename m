Return-Path: <linux-wireless+bounces-14617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A239B3D80
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 23:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A79B225E7
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 22:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827531CF5CA;
	Mon, 28 Oct 2024 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/C7Q5pn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E319005F
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153218; cv=none; b=QQKWiGrVidEH6qVgn61zNhsuUl9M4HRyeegYTgUPtNgOf2X1jyhwWzOZqCPPakjtuGkxAEegERFD+D/mGV76jhDANmDTJpXhXCASgUMAnbosgA2lYItZyPAkr29v72TyuMkEMqHwbDmX7gEtKhYMN3sUEw9maGFMG6VmtwxO66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153218; c=relaxed/simple;
	bh=T3zY1iojt5aZtxt1W1qBRwJM2MDbsqj2FO2IHTgW4+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JIPeag6hDqsWE2EkItil0DkqK9a/rbRBNaJolWGuA9PkH3VDHldt8PQVKYedzTFiMoVpA941aimYIxPrdWOKjNtlEmyjhTe0dKjH6C/kWSVDWUbc/ikV1g1y772E1c+/WQ4ahg8jqshyP5rYL2gm0tJ01Oh9oASXT0Eed12XOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r/C7Q5pn; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb3110b964so38081131fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730153214; x=1730758014; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijx3SbyGLD9fttKeJt8UbTRLoaINrfzyu2OaDvA9VEM=;
        b=r/C7Q5pnR7iQKgtqf47BtBL7ICxnpmPfpFjf9QLkxRuNJydZMxhO7CVpZOpxFNbsGb
         TQIdZcAlwoZOSpLzM5N/VqdnoYw98oexlLYab8zTR0DtoWVE4IQdEfy4+IVe4goDzjV3
         MWwT9l7CJ/6mOxrQeN2wQt8kTyD5nQleX7zlNIXTbq/u125vAeh6R7HqRpWrtjofExpN
         GJzq/ywQl1t6OANWKEJqxN7blmVG025KuRWup1CAOQ84Qo/trno++sFSNdZ2EH6JInNH
         FC1cXVWei3IawxCVgF18NHgKqGJxiP1XZGdNJRbFEa2w3D6GPl6ouFZeA8FRmbtkDc9F
         jeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153214; x=1730758014;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ijx3SbyGLD9fttKeJt8UbTRLoaINrfzyu2OaDvA9VEM=;
        b=uinJBboRZNhXWKkhAy8Cw7h40DEt/uXXyF3D51JtCYiEzJVpxFW11wAj6WKbflvhwe
         XO2em3qa9klA0esYahtgWDTbbMi0keWa6px0n4MqgQnb9fjqHSbJRdXOTRgnCkZak4+8
         bQFw7F4yN3Er7JswFregQ5NTc1cisfyUNFlQ+lVyPc1w1WQFCpefWiGAB33EBNBh/18v
         XCuIDSDIGrhIdw2gpcRmi69sjNbi4/9fz+Huw/3l6wRabl96XG1jD27H1SpR8+EMAZ+d
         t2jjWKs37SOxWYAiS9RCxz27y8VawQoUFo9h+zwUxyaIEvNyZe28ZKh9kLcocOfu/5rD
         nIbg==
X-Gm-Message-State: AOJu0Yz1GPrRJeIiGPlKSeNDjaYOGuvPOmsHDt1tYSQ0HChwX5vldWWu
	rccySc/8hYugX4S4lePQb9Cq8iFDlJdicDfehWjbwaaGoLcBXZlS1OCX+9swgW0=
X-Google-Smtp-Source: AGHT+IGs4WDExaogrlXHdgw3R1jPqGJGm5zywy9oYHpMOGUnmhxnRsAfl7DWnsytavmejXSbFwUyeQ==
X-Received: by 2002:a05:6512:3b2b:b0:535:6aa9:9855 with SMTP id 2adb3069b0e04-53b3472951amr4543722e87.0.1730153214432;
        Mon, 28 Oct 2024 15:06:54 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12495fsm1189576e87.93.2024.10.28.15.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:06:54 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 23:06:53 +0100
Subject: [PATCH] wifi: cw1200: Fix potential NULL dereference
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-cw1200-fix-v1-1-e092b6558d1e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPwKIGcC/x2MQQqAIBAAvyJ7TtAlRPpKdEjdai8WChWIf2/pO
 AMzDSoVpgqTalDo5spnFrCDgniseSfNSRjQ4GgNeh0fi8bojV+N5GyI5F0MCSS4Con+Z/PS+wc
 VRZrBXAAAAA==
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

A recent refactoring was identified by static analysis to
cause a potential NULL dereference, fix this!

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202410121505.nyghqEkK-lkp@intel.com/
Fixes: 2719a9e7156c ("wifi: cw1200: Convert to GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/wireless/st/cw1200/cw1200_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/st/cw1200/cw1200_spi.c b/drivers/net/wireless/st/cw1200/cw1200_spi.c
index 4f346fb977a9..862964a8cc87 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_spi.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_spi.c
@@ -450,7 +450,7 @@ static int __maybe_unused cw1200_spi_suspend(struct device *dev)
 {
 	struct hwbus_priv *self = spi_get_drvdata(to_spi_device(dev));
 
-	if (!cw1200_can_suspend(self->core))
+	if (self && !cw1200_can_suspend(self->core))
 		return -EAGAIN;
 
 	/* XXX notify host that we have to keep CW1200 powered on? */

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241028-cw1200-fix-2e61bce86cbd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


