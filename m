Return-Path: <linux-wireless+bounces-21100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2042AA794BE
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 19:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301ED3B71D6
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C71946C7;
	Wed,  2 Apr 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXD4OSUZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426BA15CD46
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616478; cv=none; b=UdWBaTyLD++AdNLIpJv9C94lEqr+x/b8/BJaPBD+tz2DlJdacVl5Zx8bgdH71xce4wOmaXhO9yzwlt58fnkLw4+SuWaoF7AU98EK+S94Ie2ImH3xp5iqkf7RADNl6TmkGkwMXovTkizMQTp1s+Zlxbdo/w87gGBeZtIcDJkIW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616478; c=relaxed/simple;
	bh=Yfb/6K2Y9joPQZ5O5lVp6R0r+QWgLuIm9iDMLqAvJN8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pGX3SUuwVQMeg+h6KQc2lNcx7TcMolgmiGiLVW7JhRFLspx+CtUbu3veiiV/FvnmSGqoVS+xnuT6SkK+iUuzTYElm53Votm2T/RRU75KZy+XV/kbTajxfKrrQSzus6EnNzj/N1Bmjy0vy528h7FiZ+fix9YF83CVKBWbTBZfXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXD4OSUZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso157215a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743616473; x=1744221273; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP6g6iqjdECjym60EFMO1NnyembHXxTGdRuQ+jC1fRQ=;
        b=RXD4OSUZMx/zLVPzGJ9ZX/qg9C+ZB9PaZcBYtu69x9GvGohmnopACmB+mvyGXqI4cz
         cxRVfGLrOmmdMZvn9tucWJqos3BjhIsG4kg8JijhTv8EIHsMMarOlXCyhgmq/3ppLaup
         LwgJeo9QEmIhmnzLSRTtqXGzYYOfJcbaSTGyoUu8iWzPh+U5KzDWu5rvmBbW4ZQ/gWDB
         Re7vITa3akdUe2ME/I+7VZ2KHus0o/tY1ABLh8tK3ZoUUw01ydkT7N5RUWI4OinQA96d
         4p1nynhU+vjn5rcR4qMbSuQ+oEKd0CCwVRWG2Gsiu4LfzgDV/AFRmiIIlQDmTlFuxtPw
         VoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743616473; x=1744221273;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gP6g6iqjdECjym60EFMO1NnyembHXxTGdRuQ+jC1fRQ=;
        b=gNmgIkaCPJo34O8XGiCpGBaXda0JNKzk5vnVO4gDEvVkpzGxTtd/ws/k83WM53bVi9
         tATWMFgIuANjDoe1EVUfa92zfWMgyv0absBCdtmeGwQdPhcy9/O2Nea3ImkKaRmLBEDg
         aj2rbn1DpbPIratHkzIMaWA/jzfoTyGQVyyjCDjVkyiSnwkd+7CdixLPpRu2sBem58Uf
         THgFY01EZmBELtJTXp9FF+NCgWyWdn4P9xBrTNm8cx1KalNTgFb58yqS0lEy2rQnn8jy
         tv2GGZTouB3i+Itzoo1p9aqqDV1ZZ28SIjml7pqr60YFQpE7KloezTwP+nehGMOkpoHc
         J3UA==
X-Gm-Message-State: AOJu0Yxez4cjRrGnaRKRdA/voKHA4E8hTgGsr2psAruVOzZgCt1cRswG
	nSUfKXUXlI0n/Qf5rdMV9pAatL4cPsmbuM4UL6hGlk7WhrSJecDP3KudVg==
X-Gm-Gg: ASbGncu9d2T3qbun13xyPjfWN5tq2Lc56VFM9D1SQ6rSQOqAhVurcF8PaXFqbu5T24Y
	Zom1SBWq10kVmk/Sb5UoEvHnbuyUbOkpJXz18C6XOUjKrEfnlMbcu3iGt0N0NWwHOd85iDCJgjo
	XQsHz8pRCfyy+sZcGFDSwqlVZcW2MDXJ+uv1HMTLTIvCOydBCRQmg1C8f/2CLjUlELDK0EnIwak
	NyGnPNPc8InvVjbyB2wDf1V5v749cdltB3yWCJIbXZkeTn27gpYSdGjTy85Gi7X70UKn+XkoYrS
	CEnvaonm738+Ktcv0zwrTnvcfZqpIBcBjnndcCNNOIkfnbfYTFeVmD+1wKFoGyac
X-Google-Smtp-Source: AGHT+IFSa+8mpt1BmemVALBi4ZYsAO3dtZokfWvsHG0Zvv7h0w0nj0Ti5eerYZLtLkxRn9pn1/iXmw==
X-Received: by 2002:a05:6402:42ca:b0:5ed:5fa2:98d9 with SMTP id 4fb4d7f45d1cf-5f04ec09509mr2888487a12.28.1743616473155;
        Wed, 02 Apr 2025 10:54:33 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16ef8bcsm8980411a12.42.2025.04.02.10.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 10:54:32 -0700 (PDT)
Message-ID: <29cd29ba-bc51-4d5b-ad48-a43c6ce72d56@gmail.com>
Date: Wed, 2 Apr 2025 20:54:30 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: Fix the module names printed in dmesg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The rtw88 module names all start with the "rtw88_" prefix, but the
messages in dmesg mostly use the "rtw_" prefix. The messages from
rtw88_8723cs don't even have the underscore.

Use the KBUILD_MODNAME macro in every driver. This ensures that the
messages in dmesg will always use the module name.

Before:

Mar 17 15:54:19 ideapad2 kernel: rtw_8814au 2-4:1.0: Firmware version 33.6.0, H2C version 6

After:

Mar 17 16:33:35 ideapad2 kernel: rtw88_8814au 2-4:1.0: Firmware version 33.6.0, H2C version 6

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723de.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723du.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8812au.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814ae.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814au.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821au.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822be.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cs.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
index 8d38d36be8c0..1f98d35a8dd1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
@@ -19,7 +19,7 @@ static const struct sdio_device_id rtw_8723cs_id_table[] = {
 MODULE_DEVICE_TABLE(sdio, rtw_8723cs_id_table);
 
 static struct sdio_driver rtw_8723cs_driver = {
-	.name = "rtw8723cs",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8723cs_id_table,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723de.c b/drivers/net/wireless/realtek/rtw88/rtw8723de.c
index abbaafa32851..87c8bc9d18a9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723de.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723de.c
@@ -17,7 +17,7 @@ static const struct pci_device_id rtw_8723de_id_table[] = {
 MODULE_DEVICE_TABLE(pci, rtw_8723de_id_table);
 
 static struct pci_driver rtw_8723de_driver = {
-	.name = "rtw_8723de",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8723de_id_table,
 	.probe = rtw_pci_probe,
 	.remove = rtw_pci_remove,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
index e5b6960ba0a0..206b77e5b98e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
@@ -25,7 +25,7 @@ static const struct sdio_device_id rtw_8723ds_id_table[] =  {
 MODULE_DEVICE_TABLE(sdio, rtw_8723ds_id_table);
 
 static struct sdio_driver rtw_8723ds_driver = {
-	.name = "rtw_8723ds",
+	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
 	.id_table = rtw_8723ds_id_table,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723du.c b/drivers/net/wireless/realtek/rtw88/rtw8723du.c
index 322a805da76b..b661a26e0e22 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723du.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723du.c
@@ -24,7 +24,7 @@ static int rtw8723du_probe(struct usb_interface *intf,
 }
 
 static struct usb_driver rtw_8723du_driver = {
-	.name = "rtw_8723du",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8723du_id_table,
 	.probe = rtw8723du_probe,
 	.disconnect = rtw_usb_disconnect,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812au.c b/drivers/net/wireless/realtek/rtw88/rtw8812au.c
index e18995f4cc78..dfea89670372 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812au.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812au.c
@@ -82,7 +82,7 @@ static const struct usb_device_id rtw_8812au_id_table[] = {
 MODULE_DEVICE_TABLE(usb, rtw_8812au_id_table);
 
 static struct usb_driver rtw_8812au_driver = {
-	.name = "rtw_8812au",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8812au_id_table,
 	.probe = rtw_usb_probe,
 	.disconnect = rtw_usb_disconnect,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814ae.c b/drivers/net/wireless/realtek/rtw88/rtw8814ae.c
index 54d2e20a7764..c7436f1c8d40 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814ae.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814ae.c
@@ -17,7 +17,7 @@ static const struct pci_device_id rtw_8814ae_id_table[] = {
 MODULE_DEVICE_TABLE(pci, rtw_8814ae_id_table);
 
 static struct pci_driver rtw_8814ae_driver = {
-	.name = "rtw_8814ae",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8814ae_id_table,
 	.probe = rtw_pci_probe,
 	.remove = rtw_pci_remove,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814au.c b/drivers/net/wireless/realtek/rtw88/rtw8814au.c
index afe045fb84de..1a0886ec17dd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814au.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814au.c
@@ -42,7 +42,7 @@ static const struct usb_device_id rtw_8814au_id_table[] = {
 MODULE_DEVICE_TABLE(usb, rtw_8814au_id_table);
 
 static struct usb_driver rtw_8814au_driver = {
-	.name = "rtw_8814au",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8814au_id_table,
 	.probe = rtw_usb_probe,
 	.disconnect = rtw_usb_disconnect,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821au.c b/drivers/net/wireless/realtek/rtw88/rtw8821au.c
index a01744b64e8d..28c281b32978 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821au.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821au.c
@@ -66,7 +66,7 @@ static const struct usb_device_id rtw_8821au_id_table[] = {
 MODULE_DEVICE_TABLE(usb, rtw_8821au_id_table);
 
 static struct usb_driver rtw_8821au_driver = {
-	.name = "rtw_8821au",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8821au_id_table,
 	.probe = rtw_usb_probe,
 	.disconnect = rtw_usb_disconnect,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
index f3d971feda04..40637c079d99 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
@@ -21,7 +21,7 @@ static const struct pci_device_id rtw_8821ce_id_table[] = {
 MODULE_DEVICE_TABLE(pci, rtw_8821ce_id_table);
 
 static struct pci_driver rtw_8821ce_driver = {
-	.name = "rtw_8821ce",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8821ce_id_table,
 	.probe = rtw_pci_probe,
 	.remove = rtw_pci_remove,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cs.c b/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
index a359413369a4..6d94162213c6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cs.c
@@ -20,7 +20,7 @@ static const struct sdio_device_id rtw_8821cs_id_table[] =  {
 MODULE_DEVICE_TABLE(sdio, rtw_8821cs_id_table);
 
 static struct sdio_driver rtw_8821cs_driver = {
-	.name = "rtw_8821cs",
+	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
 	.id_table = rtw_8821cs_id_table,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
index a019f4085e73..7a0fffc359e2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
@@ -48,7 +48,7 @@ static int rtw_8821cu_probe(struct usb_interface *intf,
 }
 
 static struct usb_driver rtw_8821cu_driver = {
-	.name = "rtw_8821cu",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8821cu_id_table,
 	.probe = rtw_8821cu_probe,
 	.disconnect = rtw_usb_disconnect,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822be.c b/drivers/net/wireless/realtek/rtw88/rtw8822be.c
index 4994950776cd..0bb9f70e7920 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822be.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822be.c
@@ -17,7 +17,7 @@ static const struct pci_device_id rtw_8822be_id_table[] = {
 MODULE_DEVICE_TABLE(pci, rtw_8822be_id_table);
 
 static struct pci_driver rtw_8822be_driver = {
-	.name = "rtw_8822be",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8822be_id_table,
 	.probe = rtw_pci_probe,
 	.remove = rtw_pci_remove,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bs.c b/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
index 31d8645f83bd..744781dcb419 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bs.c
@@ -20,7 +20,7 @@ static const struct sdio_device_id rtw_8822bs_id_table[] =  {
 MODULE_DEVICE_TABLE(sdio, rtw_8822bs_id_table);
 
 static struct sdio_driver rtw_8822bs_driver = {
-	.name = "rtw_8822bs",
+	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
 	.id_table = rtw_8822bs_id_table,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
index 572d1f31832e..5fdc36c88a76 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
@@ -88,7 +88,7 @@ static int rtw8822bu_probe(struct usb_interface *intf,
 }
 
 static struct usb_driver rtw_8822bu_driver = {
-	.name = "rtw_8822bu",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8822bu_id_table,
 	.probe = rtw8822bu_probe,
 	.disconnect = rtw_usb_disconnect,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
index e26c6bc82936..9def732480af 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
@@ -21,7 +21,7 @@ static const struct pci_device_id rtw_8822ce_id_table[] = {
 MODULE_DEVICE_TABLE(pci, rtw_8822ce_id_table);
 
 static struct pci_driver rtw_8822ce_driver = {
-	.name = "rtw_8822ce",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8822ce_id_table,
 	.probe = rtw_pci_probe,
 	.remove = rtw_pci_remove,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822cs.c b/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
index 975e81c824f2..322281e07eb8 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822cs.c
@@ -20,7 +20,7 @@ static const struct sdio_device_id rtw_8822cs_id_table[] =  {
 MODULE_DEVICE_TABLE(sdio, rtw_8822cs_id_table);
 
 static struct sdio_driver rtw_8822cs_driver = {
-	.name = "rtw_8822cs",
+	.name = KBUILD_MODNAME,
 	.probe = rtw_sdio_probe,
 	.remove = rtw_sdio_remove,
 	.id_table = rtw_8822cs_id_table,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
index 157d5102a4b1..324fd5c8bfd4 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
@@ -32,7 +32,7 @@ static int rtw8822cu_probe(struct usb_interface *intf,
 }
 
 static struct usb_driver rtw_8822cu_driver = {
-	.name = "rtw_8822cu",
+	.name = KBUILD_MODNAME,
 	.id_table = rtw_8822cu_id_table,
 	.probe = rtw8822cu_probe,
 	.disconnect = rtw_usb_disconnect,
-- 
2.49.0


