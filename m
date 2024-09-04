Return-Path: <linux-wireless+bounces-12494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C496C2DA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 17:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DA7284767
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133AC1DFE2A;
	Wed,  4 Sep 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZQ2FtG8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0771DFE2E;
	Wed,  4 Sep 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464972; cv=none; b=sEDmQ9jImkSLkBQRogYkMKZtdFXTG52HZkGUDtbe9MctNwuT388+/LkhTmOyqWRx8tJjfwJjdDa03CV5n++krO9uaGP6QLh9p68rbV3NJ3bm39SBDsojgClUzylsX+Iw9Mw2Mp5/dsPisZrns2fp7C0RK/GGclRS2oicECrHy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464972; c=relaxed/simple;
	bh=XPXzxmxPuh0oRaEz8t/+d+iASKVe9XfXqjCyTenSPXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZ3CLHjFEbwzC1sU+xtMb6YEwe9W5b0JBKXV4da5Q+GrvSfF++8+92wKkDXHdN8XszVoLUTjewXQkfHe9G8tSMm0TbunnUTNsTKp1t/ROrZVE1y42L5rjc2VaZGnpCLvwnnaad0bF6VFZJkPAkKoH/QznAL2D/2HIWvkfKyZxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZQ2FtG8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so736100466b.2;
        Wed, 04 Sep 2024 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725464969; x=1726069769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBEQBp9g3k9SiXOvyYlcXlhKd3Urb0xWdAtZQorxYxM=;
        b=DZQ2FtG8MFQKjNWYFEQv1ZQ9/wsshkbFn7SLkuqOVrmSUedQPd7HpJeFHG+r0cqygw
         8EK8eM7iWj+DMd87B4rR1o4Rx1HfGF9JiSHifLNtz0PHLMiSbrPSd+LLpF81RGmBD8Xv
         DmBQr7Nb0M9Hf9rDClcAMLpDkQASObzY7QwshaRNijFMtYerAxyjbrC/imI+u1NXgiar
         fBCDYTFoLxGUND+ALVdjLbfIvVTTkBT2lIYxycz+K3ZV73vJlPWvDNSlFRdxJRJWFbr6
         uQ7+8FqYa1mHTua4brdDL0bNYMilOYxL1URU/V2PjYOEJfSGBUPt11oe4mvlY/o/1exC
         FrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464969; x=1726069769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBEQBp9g3k9SiXOvyYlcXlhKd3Urb0xWdAtZQorxYxM=;
        b=L+pokHweIRkOxlkyxhnImn27+NbOrjTWjy8dzzD+hEL4fFsi071x8Z+BFiGRFtsGNJ
         OOC/SxJ7WIfOFfal8jxF8U/hh+A71YDCQ71O+8qpgBvt8tK5+oayK7xKcHvUhLmftZ/L
         Q+TUU4qMsMF67KT9s6dTwMqCBat6s5pdUFsv39n2FWfERBhRhOGw/5Nk845Tev1XJVVF
         2MnSOjWfFoQv7thsrHfPFE3XDt+HjhhQAQztn3OO9KE/1RpHyz0sioUEdhB6qPBo0nh9
         FUy6wDbUTmhRqoNHY7X8OjKRV96FlKYsdumOor6XPRMKbai+cjG44tDWKlFyiTTnAxWH
         W4wg==
X-Forwarded-Encrypted: i=1; AJvYcCWEMSFvyEuej0XVPbJ7P+JvSMBsGquyrQGYKXeNLDO7wRleXNA93qb9xVSmhXPAlL7FhzHbNbDONqOFRvlWP5A=@vger.kernel.org, AJvYcCWOQCOo0sj0nJt6uvCwJdDl6OIgZE/kJmsqYAln3n54tQZF5MSRE94EJbJ/v5ou6ZU2Ai79Er6LGqNtV+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSIyuPoaJZY3vSpWJxB1PckLn16pR7AgUiDHaJkq4eDiFRq+V
	Rqc9QVlJMYpvj80I0tKnbe58YeiEdIiOP/pFrlX6PL6OZywh8xeM
X-Google-Smtp-Source: AGHT+IEdYRPw8lVb/idDkI5zThZomh9D+3QQoM1QCPI8EglGvkLtHPnmv3rRaWQPScsdO6vXDp4SVg==
X-Received: by 2002:a17:906:c102:b0:a86:92fa:cd1d with SMTP id a640c23a62f3a-a8a32f9f1c7mr393319766b.49.1725464967741;
        Wed, 04 Sep 2024 08:49:27 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62038c0asm7825566b.62.2024.09.04.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:49:27 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: knaerzche@gmail.com,
	leitao@debian.org,
	linus.walleij@linaro.org,
	javierm@redhat.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH wireless-next v2 2/3] wifi: wlcore: sdio: Make use of irq_get_trigger_type()
Date: Wed,  4 Sep 2024 17:49:18 +0200
Message-Id: <20240904154919.118513-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904154919.118513-1-vassilisamir@gmail.com>
References: <20240904154919.118513-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/net/wireless/ti/wlcore/sdio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index 92fb5b8dcdae..9e1b644beba9 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -324,15 +324,13 @@ static int wl1271_probe(struct sdio_func *func,
 	memset(res, 0x00, sizeof(res));
 
 	res[0].start = irq;
-	res[0].flags = IORESOURCE_IRQ |
-		       irqd_get_trigger_type(irq_get_irq_data(irq));
+	res[0].flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
 	res[0].name = "irq";
 
 
 	if (wakeirq > 0) {
 		res[1].start = wakeirq;
-		res[1].flags = IORESOURCE_IRQ |
-			       irqd_get_trigger_type(irq_get_irq_data(wakeirq));
+		res[1].flags = IORESOURCE_IRQ | irq_get_trigger_type(wakeirq);
 		res[1].name = "wakeirq";
 		num_irqs = 2;
 	} else {
-- 
2.25.1


