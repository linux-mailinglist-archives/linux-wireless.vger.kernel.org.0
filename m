Return-Path: <linux-wireless+bounces-12350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939B96902E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 00:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7701C21AB5
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87C18E05B;
	Mon,  2 Sep 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI3mqUs2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8FD18BB9F;
	Mon,  2 Sep 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317752; cv=none; b=tdg7tZRUyu8c25Rhm/CCXzF1CKekrvgKLvA2J3bwtgtSWWbOSiVuhla9v7wO7Bpi5eg01g8Bp1XI6GAl25porwtbsgQWLT3z2FDxJK7aFMxtYs8Hr5NEjILjqv2nbp6jgGkD9pb/EfTX4AOk1xZ6rQeSMqTNKnwNxKIbf7+9GEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317752; c=relaxed/simple;
	bh=XPXzxmxPuh0oRaEz8t/+d+iASKVe9XfXqjCyTenSPXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OWTxhClp0bD6oo5/nK1SuPZ9ZALWlV0sPo1VL562eJOVNpZqmIrMAmER1kOAk+TTQ6WIVg7ZMX6zbNcuLEXgKghTHl8cvh1xv2NsW3qeI+chRQEqaA7SyNSmnRUIcURM4MBx7zuHUwyZbs9RW1TzTGIr/WKBxRUUcWKkWgc0xe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aI3mqUs2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c23f0a9699so2587751a12.1;
        Mon, 02 Sep 2024 15:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725317749; x=1725922549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBEQBp9g3k9SiXOvyYlcXlhKd3Urb0xWdAtZQorxYxM=;
        b=aI3mqUs2uQFjr5CbR+3EM/ABltFR7vNZk5qkiFfIDFRlXSzqXBMY+1kMS89a0HoOu8
         IZGFNDWVHkeMSKv8TgROsYSQA7B+jEP763NpHV8M6+xgByAKuISxi54JTpOexE/AkFtL
         k9dPyNUdcBsFqKBPSqYSflJUJIMcl7SAoiaPD8jIrQC6TqPu29ECfZ3828M4fI1m5qqG
         I8TGGRdfRx62b5X+RW6ipU6qF6jptkXNJDOTfEyFKci0dmt9Zm+ZLiFPWKsiXbxNLPIE
         rhyWN7Kq7gLyhTL9Fp8znPYQrfUzbObYzOWMbvxdz33reSRCjwQaW2aWW0VGT+Gk3x8j
         6LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317749; x=1725922549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBEQBp9g3k9SiXOvyYlcXlhKd3Urb0xWdAtZQorxYxM=;
        b=W/VYWukpN0JIbxMWv4Gyi45zeR7R7//GQ+z/zdiwvNUfMFz26laT1GjJ9WN0d9h6Fm
         AHu2bCJ3NXcsS0SELAcweYVEgMSaLBef8aPVQtEQIHNR9hleyr2zTRoXAYYt0cwCR8Kq
         2N+tbY+I/LLso44AD7eXFzyLlFy3A8fSl5KQefjT8ZV1rzuK9tmHjqsiVQMW2imTxwLP
         uJdBGytbhaE6tc5gke+6wg4CY7ezH7/+Lvxr2Ma9etTHFraa5q/LqLcS0VxToiH4IaMp
         6nsfmkn4dzYUsNNOPFSwGPgBPxm/DLiPJH/l9xV9/dp/x9ndht3G42jRml8wk7auIl9L
         jNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK4niEW89nnIdFXV8AnT3TDNoHqCYM1r+OJ8bauN3Ez84wVwEEjCRt1eaHJ0xlhnOOHVB2qIOg+pE/@vger.kernel.org, AJvYcCVzLbQGLRI3ZaaAB7K+2wk38+UQ4DKY/yMW2Ytci+UYXPLGAhHUgMSEN4Du1H5BbgmYjRpHvl3y@vger.kernel.org, AJvYcCW7//KPh8+OXQIDQPVLB2bMQDiSiTxlAgPLjjt0vM3TwHsH3BOMkT7iA1PfwAsjjE8T1LRr55nn2oNUssExNGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+dVKSsb/D91qjuaF3/O+krFi5nGq/Ejaw04aJBntB51rLHSW
	YQj5FO2Bfqiqf6cHdz+lLDCXFmUcsCWAO5vqdxNi2zIiMmtWbGU/
X-Google-Smtp-Source: AGHT+IFGC5whsYTLJRRo+OjnE/CnzW9ioCA7rs9/xXHxQe/SonC3TILzstrZixS3NMZMqFGr2Uhr7Q==
X-Received: by 2002:a05:6402:27d1:b0:5be:ea9c:5fe7 with SMTP id 4fb4d7f45d1cf-5c21ed40982mr11174299a12.16.1725317747871;
        Mon, 02 Sep 2024 15:55:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c74184sm6040568a12.32.2024.09.02.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:55:47 -0700 (PDT)
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
Subject: [PATCH v1 6/7] wifi: wlcore: sdio: Make use of irq_get_trigger_type()
Date: Tue,  3 Sep 2024 00:55:33 +0200
Message-Id: <20240902225534.130383-7-vassilisamir@gmail.com>
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


