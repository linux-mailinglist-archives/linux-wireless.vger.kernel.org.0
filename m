Return-Path: <linux-wireless+bounces-12347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A8496901C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 00:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF6FB227C4
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 22:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AAE1891B9;
	Mon,  2 Sep 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c04XdeDf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADA188929;
	Mon,  2 Sep 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317747; cv=none; b=j+vttcuZN6jA6pPqWQmyAwIKuqEvv2pR55mFEjN5vdWjslYiw8/xzrRXlhFKEC/VCikkWXxPPa0ZfQsS0hL6shoOAj4jToKoIVQb89BW0zrFYClTSNq4z7+RbUCnykPSJPQ1PLabnUsRfUddE0J1gOTdEJyrJaYTuifVe9S81Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317747; c=relaxed/simple;
	bh=fSzJPU8bmjY5Ro+DB3zswx5GV+Kvbzad2TRXw4i/y84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tkZdouUEwBPm60PCXC6VVpnw8UmXdF/80Zh9zyy09UYR+Yrl0aIOu+GLRprzX364I/sX9sG/wJBsZNTN/yUFWE/A6angS9MJH8Yrc/qVbZulA+rxNkX7/eHO/uxWzZRpzkid3CfDIJKi7UvnTsUfPuUtXu/YmczFPBUzbPGVMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c04XdeDf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so992123a12.0;
        Mon, 02 Sep 2024 15:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725317743; x=1725922543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMRQxsu6IuAS6frrvyS8c4hkmHHGDuOUXHIGD8sRn2E=;
        b=c04XdeDf0XFMavJl+ib6IesQ7Gm/VsQ3xwtA6sKxd4ra+g9WE3D1wp+WbmU0Nj9GFV
         LmGwpGcQWjgZ25a4zknmuuDmmaRHSweW2HXVM84pgPSkAGDUrc1+T1+l7yq6TtueDIUE
         Cfm9gQjn3UZ90HIIm/QyqoGWVArXvFx559XuWl0xmGASaWUDK2Obi1hYlyB09EphsO4e
         knI/EqPr6MywfbkaBRuvJ/2CFIJC6P+9ob1BIa6DzsLlkbzHfnMlyxQMioFqPJoF1elg
         5H7gY/pCqfiNJehWNBPqa46FEbHqi/S0r5Mty7D0WZmnf/tnT3nc2bHKIQcQku3nY1Du
         1exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317743; x=1725922543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMRQxsu6IuAS6frrvyS8c4hkmHHGDuOUXHIGD8sRn2E=;
        b=DvsdYjk8n4d1Ipz4FX5BEUOw8woPgG0B0uCqi3LJBptp9NjrM9c1Hu6MVFJAnoHbo7
         EtkdN6L/WuYDKvxPCQ3ZLVrfTxky2Rdw1JGNe3zXBK0TeqdbHFcRIAH99JuYDup+j/ds
         AbpC9vWm1tyX/IqcUcuQDXyxXBzpxchWERaorrWVi1EEtEXHfMFjpnOOKQ33qpTmdAkJ
         h/O3gYEqhp7HkyTAEykJ9zI/Sp2LZVZBeDTUWCE4Dy47xClaLhSBFkf97eeB/smpeEHF
         8CMHf/GRO9iI2KxDILVL4PkQTLkg6nkpMAqcS+UM7o+xjiD70+mVeMzlwwzX31fFZAda
         RA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCLCLJslznLgH63VKhG+xVy7JWBQbnoNzzJ02TYAw2EFHNAnBfL9x4uUJu3bA3PMmTlDbdhUO2OO2a@vger.kernel.org, AJvYcCW1hPm2cn96CuRBUFN4uC8UxzlwJZ/Ok59ELUYUnwvZREji8FMgVbhmz2GpxUJB58bFs7wwubzz@vger.kernel.org, AJvYcCXql/sqj2LXvDdYMpMBYy3dHEikN2nIA961gxTCecY2rZoizt3E2N2B4IeR0aQuqBiU0fY6wT/cE0IIjU5TYZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5/sCK1o0qvwbJwcUbZW2K9ep0gUTBhvLmateFanHQQiOYtJW
	1fCmMxIXYqgPEBfsAhBrmqTlbMccp7eFFpxMw6+jGwsJX9DpeHYd
X-Google-Smtp-Source: AGHT+IGpOoiKZ1FObkw+EeG22X+GUgUsivRxsCpbNjjmSCMOZtMUSBCFQPPTD6c5DMOsUOlzrB7Ojw==
X-Received: by 2002:a05:6402:40c5:b0:5c2:5cf7:a615 with SMTP id 4fb4d7f45d1cf-5c25cf7a653mr2982329a12.5.1725317742949;
        Mon, 02 Sep 2024 15:55:42 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c74184sm6040568a12.32.2024.09.02.15.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:55:42 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: linux@armlinux.org.uk,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nico@fluxnic.net,
	arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	robh@kernel.org,
	saravanak@google.com,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	devicetree@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v1 3/7] net: dsa: realtek: rtl8366rb: Make use of irq_get_trigger_type()
Date: Tue,  3 Sep 2024 00:55:30 +0200
Message-Id: <20240902225534.130383-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902225534.130383-1-vassilisamir@gmail.com>
References: <20240902225534.130383-1-vassilisamir@gmail.com>
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
 drivers/net/dsa/realtek/rtl8366rb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 9e821b42e5f3..e49cfdfb85cb 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -599,7 +599,7 @@ static int rtl8366rb_setup_cascaded_irq(struct realtek_priv *priv)
 	}
 
 	/* Fetch IRQ edge information from the descriptor */
-	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irq_trig = irq_get_trigger_type(irq);
 	switch (irq_trig) {
 	case IRQF_TRIGGER_RISING:
 	case IRQF_TRIGGER_HIGH:
-- 
2.25.1


