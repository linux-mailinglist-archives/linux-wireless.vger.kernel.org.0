Return-Path: <linux-wireless+bounces-12349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F3969028
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 00:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017DC1C21CD6
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 22:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE3018BBB2;
	Mon,  2 Sep 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJQaNTVy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F518990B;
	Mon,  2 Sep 2024 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317750; cv=none; b=TP9o16NP6IRDwaQ5e3MepVrZICC1TBNOnqK0uxBaYdKSnq9EME2apsrSPNIDGyCcKWknTzwm749M37p+MAtPFa0RH7RcXAB80xzsWeQLIdqAPgGwJXe/q7fYObMheXiI/SyWNePa3X/C4Szuabkfsg8Sul62VsIWidZyKWFCQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317750; c=relaxed/simple;
	bh=uOyPjGt0jQt2rh9a/QIkYjsMGeW+O2UMFkZJfXzINs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZcoNIqkUbqQe2JuJz6R0PtY/d/wA8N9NI5Ta/c7tOowOGVtkmXEt3x9tP2IW6UTHTGYOy6Ol6FfdiaFAAZ6OPIfbT9CkhbzeBGOqwkGP1p0063Ujtdk32XgtiFTGB3kQ4HH2qnY9XvRNUqgOhdqxUyxn/rMzJY3PnWtc+3fKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJQaNTVy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso636523a12.1;
        Mon, 02 Sep 2024 15:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725317747; x=1725922547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNOha94p1Pn6xGxE05olLPJMp0FKiE02MSaHBlDjyGc=;
        b=QJQaNTVyH7G9rwftHNX4JhY4q97aPbcXY7zw4UkrO2nA2OfMNKw3WMR06UnlNAriyJ
         7mIHXDRFdDFMjzjl9lOmZM9R0SCFSDC4GfCIwysb5fd9z/K6ijSpCn9JFBL1IfuExJ0Q
         vI5tCLXx9xQtHneBbXSBH53TU+F6CwdjUo9WKEjPSpRP2gCG7N3drLmBybHKo80aKtaS
         yCUUNEo7LCZOEnVjw3G6YkLArV91Qo0z18NF7YW4nghXulsiiNq2MgUkFAudKSgzstZc
         Jy4vWGVhZIeEaKJIqP3U3P4m2II/IqyCteyPgodFiaeyEDvQibHh5Ocu6F7P7ZaFSqt1
         Itmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317747; x=1725922547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNOha94p1Pn6xGxE05olLPJMp0FKiE02MSaHBlDjyGc=;
        b=J1gjSlRIrASg8qZ9kvEeg5PN9XlM43d/PiUxNYDJ7WF5r8XqFBVNFR3kShTvaK4ff0
         rcR0Fh7iYDrl33ZAEthGdBIGWPXva21MYXDQLuJsYEZ1FGqWwAqhgk1XJVx4WtDQOLJm
         FcS5J1iuZCiotk4r0iqbDMd59iHCnxSnjPyXyUkBC0GB1nDr+7WHFMZHofdcqv6DjFuD
         hKa+3ZrR0ioOmxtB5csFJYgF51rD8xLXswrbZTEukHMXOINN8fRuTvgTAInh77gOuOjX
         zWsAlOvyt3vKxSm9Zrcoe/a3kKYUYJdPJmWFu1etOgssDu6IV3ATpIcS6/W+jksLI0qM
         k4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM0rd0/ytxiqKfO1zkJFJ6/do5DC2iYJIlGf1GLOm+KoVcTKC/BGcyysfB73pS3f92W7YFRqsxAu6IWwmBhf8=@vger.kernel.org, AJvYcCWOCXrS/XjjQ4jtPFAhqT8DpQoKNlkt0lmF9ftMZONV/JUxIr8SXOXKKp6qJlPOkVkvgQ7xQj+v3DDO@vger.kernel.org, AJvYcCWVArHJKSsp/kbW+95Y2SS8kQP6MioUBk5PixiuoA+1CcMI6eEdoGHRQHuzytKvOKDvjWik4WjI@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiOJtVcj+G5yAwNvnI3Z/VS1RkPMMzAUW/SZE5KWruVAHqjoh
	U0yuFe0RNxrAJVbAaxnK0k4OwWPJIO0Ss1+4tU0AK3eQyxAdYRQE
X-Google-Smtp-Source: AGHT+IGqqJa6E9Fi04lpv5ylXuWwG4McM9U+cVel0dkTj5wzsYa/5sxRsZvHI2+j+UqV622HmJH7xQ==
X-Received: by 2002:a05:6402:270b:b0:5c2:5f31:8888 with SMTP id 4fb4d7f45d1cf-5c25f318b71mr2775796a12.15.1725317746338;
        Mon, 02 Sep 2024 15:55:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c74184sm6040568a12.32.2024.09.02.15.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:55:45 -0700 (PDT)
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
Subject: [PATCH v1 5/7] wifi: brcmfmac: of: Make use of irq_get_trigger_type()
Date: Tue,  3 Sep 2024 00:55:32 +0200
Message-Id: <20240902225534.130383-6-vassilisamir@gmail.com>
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
simple irq_get_trigger_type().

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index fe4f65756105..e2611f164fa8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -138,7 +138,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		brcmf_err("interrupt could not be mapped\n");
 		return;
 	}
-	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irqf = irq_get_trigger_type(irq);
 
 	sdio->oob_irq_supported = true;
 	sdio->oob_irq_nr = irq;
-- 
2.25.1


