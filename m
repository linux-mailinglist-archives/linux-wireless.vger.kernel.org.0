Return-Path: <linux-wireless+bounces-38998-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3lsLJ5BfVWoSngAAu9opvQ
	(envelope-from <linux-wireless+bounces-38998-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 23:58:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D5974F60E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 23:58:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aDgIpLSy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38998-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38998-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1559301B814
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 21:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA2370AEB;
	Mon, 13 Jul 2026 21:58:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418336F8EF
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 21:58:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979916; cv=none; b=pnWi53/9v6Y/schQLb04YtOualDXvWgq8TjIaaKlmKEDFL/Pwe+3pfy5B583thxdbS+i/MhcnNRX9oANNLN0iVKw6IO3ZiQPpAqECtGDmcwXXO7O8nXXzvk/Nfpb1Uibi4zD3wUGDr6oOnP97MnOrzUEhWjv+wP62GKvd9pR0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979916; c=relaxed/simple;
	bh=st8OCkl2uEVUo+nCeSO035T37xhSKLVGnAsrrqljeB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UxqsniUsXmdc98vOOoLVyii7Rsb2XwYBz1iaUtFTyNPPoMujbOP8MhnEdH0JgqBtAVt1ftFlnHiWYh/yRTh1PjfKxLBtITaxUru3iI/irhSoWGn9K5tIZWY+5ad4X1LvtYlgViwqrNrvrSGnYsQZUNKls7fLIFHMQG4ZjDYAuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDgIpLSy; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso2862366a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783979913; x=1784584713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yshtlaVMWhJIfh0u1M9eE4U25PEVkmE+xpFn1y1nP8A=;
        b=aDgIpLSyaXuEWM00BHDia2mU55aGZiR/YH38rfpR3oZoJxRmN7HQA6dyqZCa9R6WIV
         eYbmlQIANpq2bQgxSfFdfb2bJKrrPDb4D/kOuM1vmS6pu1s5xJ46qUh/Ulgn1nTa3nbm
         MaHGFhAh55fcw/viwP5B19mRoFnGivCa7T2orgWKn3YL1MuyEz7hfpqAyjaJYXmQ+tTd
         mbccEnupPiEeOpHR/9jtPjBMqrpmft4lewLbr9xLG25XsFpX+b9wkGrN6OwpFYKP8jnc
         /1uounDHO+o2eruIOXT8Cn3rZfalw690ftGpLldt05EYqnzTmLn+DkpZDmtoChWJabbG
         +uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979913; x=1784584713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yshtlaVMWhJIfh0u1M9eE4U25PEVkmE+xpFn1y1nP8A=;
        b=XrOiRpwXgEk3QnmbkJx+7ZX26i5bM6RcATfi5rC1Hst7Y5/qKTn9jewSQeGYC0eVb3
         pEI7d6Cn6IBcf6Cs9TeB2Rq8k4q3n2CLeWxZ2kfxetTH5Em3djc8dRXzT60Iddn+W9ir
         W41rWQ/ml6NfRKr+JUn+17LPdJPvTuPu/bIWHgMUjiHTOzEsdo8b7NfdqeP686zlWart
         sodQaO5L0ZKB1TV8fjOnOCafla44LCS+fMrK81qlUsJegxKMOfT2H8XjCuL0cTs6a4x8
         jzgWzBmPHvkWOBiVu7jVtqt8obVp/j+j8z9/nfq/VikUgkRXEjRlp3OZL2Ysiq9By06u
         eSQw==
X-Forwarded-Encrypted: i=1; AHgh+RogEJYXleQFOx5fLtpbeWUc2pKWfunDEWVeq6MdRf2Jd5BFlWe/Ei/MyfHXrYAmWPArduPl0SZU7bPr0zm+Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7tftCIoteLgUZTOswHRyG7u8pH3aJRWQJ6LpWu1siskVZTwl
	puKoZbPTE6t/rFZR/dr8lXXlUmSnD8L7xKmZAR2FP0+2C1jSozLhXAgg
X-Gm-Gg: AfdE7ckrtcFRZN+bu1o0wHs3/TclgI+qgUSVMXpgZzWqNtSb4nWFU6dSRH1vLxcXnBJ
	yyKkSyr+aC/1ngL2ae/U6ViCqA0edZ8JOKabs4Y/tV7vOOnaZi6O/zsIEsJBJUu/nDYuyp4N1E9
	H2l6S/MqrtdYx1Xc3ajuwdSooaFPuaGA7VWRLYT/NIYpk2lEInglUPv5yScjPrF8sHv+X4dY4SQ
	GsZGwO5iMxZiSHmN2l/9QWq4aeglUuPXggO7gm87acK3CbnObeZBbpPJ80lOGBnIz/agj1O3f1w
	VDEDKwyEiiNfT+UlIpAUwHb16McAxqg5jhlK5GPURVz9Pn4TD45pLBnviW3gUXgRNTtoi7cxq5N
	1eBTDwOEvhH8pfaNJr/Jz5/1HdX9OdFmTdJy0LQWKxzyU+TbdaexBua6Ysh4LqopuUaIe0txuga
	Sit/MjQoxMHsK1G4cvPATiBx8V3GCNI56PhbWM5zhYPHcd+qqPjeGIRhhIx57IQypzh7M3STa9x
	FDL
X-Received: by 2002:a05:6a20:3d02:b0:3bf:b60b:da95 with SMTP id adf61e73a8af0-3c110f61152mr11557886637.60.1783979912715;
        Mon, 13 Jul 2026 14:58:32 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8a5992c9sm28371487c88.4.2026.07.13.14.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:58:32 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 13 Jul 2026 14:58:24 -0700
Subject: [PATCH v2 3/3] MIPS: BCM47XX: Convert buttons to software nodes
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-bcm47xx-swnode-v2-3-2b879f0c193c@gmail.com>
References: <20260713-b4-bcm47xx-swnode-v2-0-2b879f0c193c@gmail.com>
In-Reply-To: <20260713-b4-bcm47xx-swnode-v2-0-2b879f0c193c@gmail.com>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Michael Buesch <m@bues.ch>, Hauke Mehrtens <hauke@hauke-m.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-b242f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38998-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:brgl@kernel.org,m:arnd@arndb.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch,hauke-m.de,alpha.franken.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49D5974F60E

Convert the legacy gpio-keys platform device on BCM47XX boards to
use software nodes/properties. This allows us to describe the GPIO
keys and their GPIO bindings using software nodes, so that support
for platform data can eventually be removed from the gpio-keys
driver.

Detect the active bus type (BCMA or SSB) and reference the
corresponding GPIO controller's software node (bcma_gpio_swnode or
ssb_gpio_swnode) in the button properties.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/mips/bcm47xx/buttons.c | 442 +++++++++++++++++++++++++-------------------
 1 file changed, 255 insertions(+), 187 deletions(-)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 46994f9bb821..151a4ee2803f 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -1,9 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm47xx_private.h"
 
-#include <linux/input.h>
-#include <linux/gpio_keys.h>
+#include "linux/err.h"
+#include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
+#include <linux/input-event-codes.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
 #include <bcm47xx_board.h>
 #include <bcm47xx.h>
 
@@ -11,29 +16,34 @@
  * Database
  **************************************************/
 
-#define BCM47XX_GPIO_KEY(_gpio, _code)					\
-	{								\
-		.code		= _code,				\
-		.gpio		= _gpio,				\
-		.active_low	= 1,					\
+struct bcm47xx_gpio_key {
+	u16 code;
+	u8 pin;
+	u8 flags;
+};
+
+#define BCM47XX_GPIO_KEY(_gpio, _code)			\
+	{						\
+		.code	= _code,			\
+		.pin	= _gpio,			\
+		.flags	= GPIO_ACTIVE_LOW,		\
 	}
 
-#define BCM47XX_GPIO_KEY_H(_gpio, _code)				\
-	{								\
-		.code		= _code,				\
-		.gpio		= _gpio,				\
+#define BCM47XX_GPIO_KEY_H(_gpio, _code)		\
+	{						\
+		.code	= _code,			\
+		.pin	= _gpio,			\
+		.flags	= GPIO_ACTIVE_HIGH,		\
 	}
 
 /* Asus */
 
-static const struct gpio_keys_button
-bcm47xx_buttons_asus_rtn10u[] __initconst = {
+static const struct bcm47xx_gpio_key bcm47xx_buttons_asus_rtn10u[] __initconst = {
 	BCM47XX_GPIO_KEY(20, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(21, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
-bcm47xx_buttons_asus_rtn12[] __initconst = {
+static const struct bcm47xx_gpio_key bcm47xx_buttons_asus_rtn12[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(1, KEY_RESTART),
 	BCM47XX_GPIO_KEY(4, BTN_0), /* Router mode */
@@ -41,74 +51,73 @@ bcm47xx_buttons_asus_rtn12[] __initconst = {
 	BCM47XX_GPIO_KEY(6, BTN_2), /* AP mode */
 };
 
-static const struct gpio_keys_button
-bcm47xx_buttons_asus_rtn16[] __initconst = {
+static const struct bcm47xx_gpio_key bcm47xx_buttons_asus_rtn16[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(8, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_rtn66u[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(9, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl300g[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl320ge[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl330ge[] __initconst = {
 	BCM47XX_GPIO_KEY(2, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl500g[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl500gd[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl500gpv1[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_RESTART),
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl500gpv2[] __initconst = {
 	BCM47XX_GPIO_KEY(2, KEY_RESTART),
 	BCM47XX_GPIO_KEY(3, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl500w[] __initconst = {
 	BCM47XX_GPIO_KEY_H(6, KEY_RESTART),
 	BCM47XX_GPIO_KEY_H(7, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl520gc[] __initconst = {
 	BCM47XX_GPIO_KEY(2, KEY_RESTART),
 	BCM47XX_GPIO_KEY(3, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl520gu[] __initconst = {
 	BCM47XX_GPIO_KEY(2, KEY_RESTART),
 	BCM47XX_GPIO_KEY(3, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wl700ge[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_POWER), /* Hard disk power switch */
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON), /* EZSetup */
@@ -116,21 +125,21 @@ bcm47xx_buttons_asus_wl700ge[] __initconst = {
 	BCM47XX_GPIO_KEY(7, KEY_RESTART), /* Hard reset */
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_asus_wlhdd[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
 /* Huawei */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_huawei_e970[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
 /* Belkin */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_belkin_f7d4301[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 	BCM47XX_GPIO_KEY(8, KEY_WPS_BUTTON),
@@ -138,44 +147,44 @@ bcm47xx_buttons_belkin_f7d4301[] __initconst = {
 
 /* Buffalo */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_buffalo_whr2_a54g54[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_buffalo_whr_g125[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
 	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode switch */
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_buffalo_whr_g54s[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY_H(4, KEY_RESTART),
 	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode switch */
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_buffalo_whr_hp_g54[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
 	BCM47XX_GPIO_KEY(5, BTN_0), /* Router / AP mode switch */
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_buffalo_wzr_g300n[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_buffalo_wzr_rs_g54[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_buffalo_wzr_rs_g54hp[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
@@ -183,20 +192,20 @@ bcm47xx_buttons_buffalo_wzr_rs_g54hp[] __initconst = {
 
 /* Dell */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_dell_tm2300[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_RESTART),
 };
 
 /* D-Link */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_dlink_dir130[] __initconst = {
 	BCM47XX_GPIO_KEY(3, KEY_RESTART),
 	BCM47XX_GPIO_KEY(7, KEY_UNKNOWN),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_dlink_dir330[] __initconst = {
 	BCM47XX_GPIO_KEY(3, KEY_RESTART),
 	BCM47XX_GPIO_KEY(7, KEY_UNKNOWN),
@@ -204,127 +213,127 @@ bcm47xx_buttons_dlink_dir330[] __initconst = {
 
 /* Linksys */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_e1000v1[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_e1000v21[] __initconst = {
 	BCM47XX_GPIO_KEY(9, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(10, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_e2000v1[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(8, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_e2500v3[] __initconst = {
 	BCM47XX_GPIO_KEY(9, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(10, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_e3000v1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_e3200v1[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_RESTART),
 	BCM47XX_GPIO_KEY(8, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_e4200v1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt150nv1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt150nv11[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt160nv1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt160nv3[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt300n_v1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt300nv11[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_UNKNOWN),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt310nv1[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 	BCM47XX_GPIO_KEY(8, KEY_UNKNOWN),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt310n_v2[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt320n_v1[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(8, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt54g3gv2[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_WIMAX),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt54g_generic[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt610nv1[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 	BCM47XX_GPIO_KEY(8, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrt610nv2[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_linksys_wrtsl54gs[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
@@ -332,154 +341,154 @@ bcm47xx_buttons_linksys_wrtsl54gs[] __initconst = {
 
 /* Luxul */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_abr_4400_v1[] = {
 	BCM47XX_GPIO_KEY(14, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_xap_310_v1[] = {
 	BCM47XX_GPIO_KEY(20, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_xap_1210_v1[] = {
 	BCM47XX_GPIO_KEY(8, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_xap_1230_v1[] = {
 	BCM47XX_GPIO_KEY(8, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_xap_1240_v1[] = {
 	BCM47XX_GPIO_KEY(8, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_xap_1500_v1[] = {
 	BCM47XX_GPIO_KEY(14, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_xbr_4400_v1[] = {
 	BCM47XX_GPIO_KEY(14, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_xvw_p30_v1[] = {
 	BCM47XX_GPIO_KEY(20, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_xwr_600_v1[] = {
 	BCM47XX_GPIO_KEY(8, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_luxul_xwr_1750_v1[] = {
 	BCM47XX_GPIO_KEY(14, KEY_RESTART),
 };
 
 /* Microsoft */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_microsoft_nm700[] __initconst = {
 	BCM47XX_GPIO_KEY(7, KEY_RESTART),
 };
 
 /* Motorola */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_motorola_we800g[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_motorola_wr850gp[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_motorola_wr850gv2v3[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_RESTART),
 };
 
 /* Netgear */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_r6200_v1[] __initconst = {
 	BCM47XX_GPIO_KEY(2, KEY_RFKILL),
 	BCM47XX_GPIO_KEY(3, KEY_RESTART),
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_r6300_v1[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_wn2500rp_v1[] __initconst = {
 	BCM47XX_GPIO_KEY(12, KEY_RESTART),
 	BCM47XX_GPIO_KEY(31, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_wndr3400v1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
 	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(8, KEY_RFKILL),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_wndr3400_v3[] __initconst = {
 	BCM47XX_GPIO_KEY(12, KEY_RESTART),
 	BCM47XX_GPIO_KEY(23, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_wndr3700v3[] __initconst = {
 	BCM47XX_GPIO_KEY(2, KEY_RFKILL),
 	BCM47XX_GPIO_KEY(3, KEY_RESTART),
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_wndr4500v1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(5, KEY_RFKILL),
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_wnr1000_v3[] __initconst = {
 	BCM47XX_GPIO_KEY(2, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(3, KEY_RESTART),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_wnr3500lv1[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
 	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_wnr3500lv2[] __initconst = {
 	BCM47XX_GPIO_KEY(4, KEY_RESTART),
 	BCM47XX_GPIO_KEY(6, KEY_WPS_BUTTON),
 	BCM47XX_GPIO_KEY(8, KEY_RFKILL),
 };
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_netgear_wnr834bv2[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
 /* SimpleTech */
 
-static const struct gpio_keys_button
+static const struct bcm47xx_gpio_key
 bcm47xx_buttons_simpletech_simpleshare[] __initconst = {
 	BCM47XX_GPIO_KEY(0, KEY_RESTART),
 };
@@ -488,31 +497,96 @@ bcm47xx_buttons_simpletech_simpleshare[] __initconst = {
  * Init
  **************************************************/
 
-static struct gpio_keys_platform_data bcm47xx_button_pdata;
-
-static struct platform_device bcm47xx_buttons_gpio_keys = {
-	.name = "gpio-keys",
-	.dev = {
-		.platform_data = &bcm47xx_button_pdata,
+static int __init
+bcm47xx_buttons_add(const struct bcm47xx_gpio_key *buttons, int nbuttons)
+{
+	struct platform_device *pdev;
+	const struct software_node *gpio_swnode;
+	struct property_entry *p;
+	int error;
+	int i;
+
+	switch (bcm47xx_bus_type) {
+#ifdef CONFIG_BCM47XX_BCMA
+	case BCM47XX_BUS_TYPE_BCMA:
+		gpio_swnode = &bcma_gpio_swnode;
+		break;
+#endif
+#ifdef CONFIG_BCM47XX_SSB
+	case BCM47XX_BUS_TYPE_SSB:
+		gpio_swnode = &ssb_gpio_swnode;
+		break;
+#endif
+	default:
+		return -ENODEV;
 	}
-};
 
-/* Copy data from __initconst */
-static int __init bcm47xx_buttons_copy(const struct gpio_keys_button *buttons,
-				       size_t nbuttons)
-{
-	size_t size = nbuttons * sizeof(*buttons);
+	/* 1 node for gpio-keys device, 1 node for each button, 1 terminator */
+	const struct software_node **node_group __free(kfree) =
+		kcalloc(1 + nbuttons + 1, sizeof(*node_group), GFP_KERNEL);
+	if (!node_group)
+		return -ENOMEM;
 
-	bcm47xx_button_pdata.buttons = kmemdup(buttons, size, GFP_KERNEL);
-	if (!bcm47xx_button_pdata.buttons)
+	/* 1 code property, 1 gpio property, 1 terminator */
+	struct property_entry *props __free(kfree) =
+		kcalloc(nbuttons * 3, sizeof(*props), GFP_KERNEL);
+	if (!props)
 		return -ENOMEM;
-	bcm47xx_button_pdata.nbuttons = nbuttons;
 
+	/* 1 node for gpio-keys device, 1 node for each button */
+	struct software_node *nodes __free(kfree) =
+		kcalloc(1 + nbuttons, sizeof(*nodes), GFP_KERNEL);
+	if (!nodes)
+		return -ENOMEM;
+
+	struct software_node_ref_args *ref_args __free(kfree) =
+		kcalloc(nbuttons, sizeof(*ref_args), GFP_KERNEL);
+	if (!ref_args)
+		return -ENOMEM;
+
+	/* gpio-keys node */
+	nodes[0].name = "bcm47xx-gpio-buttons";
+
+	p = props;
+	for (i = 0; i < nbuttons; i++) {
+		const struct bcm47xx_gpio_key *button = &buttons[i];
+		struct software_node *node = &nodes[1 + i];
+		struct software_node_ref_args *ref = &ref_args[i];
+
+		node->parent = &nodes[0];
+		node->properties = p;
+
+		*ref = SOFTWARE_NODE_REFERENCE(gpio_swnode, button->pin, button->flags);
+		*p++ = PROPERTY_ENTRY_REF("gpios", &ref_args[i]);
+		*p++ = PROPERTY_ENTRY_U32("linux,code", button->code);
+		p++;
+	}
+
+	for (i = 0; i < nbuttons + 1; i++)
+		node_group[i] = &nodes[i];
+
+	error = software_node_register_node_group(node_group);
+	if (error)
+		return error;
+
+	pdev = platform_device_register_full(&(struct platform_device_info){
+		.name = "gpio-keys",
+		.swnode = &nodes[0],
+	});
+	error = PTR_ERR_OR_ZERO(pdev);
+	if (error) {
+		software_node_unregister_node_group(node_group);
+		return error;
+	}
+
+	retain_and_null_ptr(props);
+	retain_and_null_ptr(nodes);
+	retain_and_null_ptr(ref_args);
 	return 0;
 }
 
-#define bcm47xx_copy_bdata(dev_buttons)					\
-	bcm47xx_buttons_copy(dev_buttons, ARRAY_SIZE(dev_buttons));
+#define bcm47xx_add_bdata(dev_buttons)					\
+	bcm47xx_buttons_add(dev_buttons, ARRAY_SIZE(dev_buttons))
 
 int __init bcm47xx_buttons_register(void)
 {
@@ -521,52 +595,52 @@ int __init bcm47xx_buttons_register(void)
 
 	switch (board) {
 	case BCM47XX_BOARD_ASUS_RTN10U:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn10u);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_rtn10u);
 		break;
 	case BCM47XX_BOARD_ASUS_RTN12:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn12);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_rtn12);
 		break;
 	case BCM47XX_BOARD_ASUS_RTN16:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn16);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_rtn16);
 		break;
 	case BCM47XX_BOARD_ASUS_RTN66U:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn66u);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_rtn66u);
 		break;
 	case BCM47XX_BOARD_ASUS_WL300G:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl300g);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl300g);
 		break;
 	case BCM47XX_BOARD_ASUS_WL320GE:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl320ge);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl320ge);
 		break;
 	case BCM47XX_BOARD_ASUS_WL330GE:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl330ge);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl330ge);
 		break;
 	case BCM47XX_BOARD_ASUS_WL500G:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500g);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl500g);
 		break;
 	case BCM47XX_BOARD_ASUS_WL500GD:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500gd);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl500gd);
 		break;
 	case BCM47XX_BOARD_ASUS_WL500GPV1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500gpv1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl500gpv1);
 		break;
 	case BCM47XX_BOARD_ASUS_WL500GPV2:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500gpv2);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl500gpv2);
 		break;
 	case BCM47XX_BOARD_ASUS_WL500W:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl500w);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl500w);
 		break;
 	case BCM47XX_BOARD_ASUS_WL520GC:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl520gc);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl520gc);
 		break;
 	case BCM47XX_BOARD_ASUS_WL520GU:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl520gu);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl520gu);
 		break;
 	case BCM47XX_BOARD_ASUS_WL700GE:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wl700ge);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wl700ge);
 		break;
 	case BCM47XX_BOARD_ASUS_WLHDD:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_wlhdd);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_asus_wlhdd);
 		break;
 
 	case BCM47XX_BOARD_BELKIN_F7D3301:
@@ -574,193 +648,193 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_BELKIN_F7D4301:
 	case BCM47XX_BOARD_BELKIN_F7D4302:
 	case BCM47XX_BOARD_BELKIN_F7D4401:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_belkin_f7d4301);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_belkin_f7d4301);
 		break;
 
 	case BCM47XX_BOARD_BUFFALO_WHR2_A54G54:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_whr2_a54g54);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_buffalo_whr2_a54g54);
 		break;
 	case BCM47XX_BOARD_BUFFALO_WHR_G125:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_whr_g125);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_buffalo_whr_g125);
 		break;
 	case BCM47XX_BOARD_BUFFALO_WHR_G54S:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_whr_g54s);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_buffalo_whr_g54s);
 		break;
 	case BCM47XX_BOARD_BUFFALO_WHR_HP_G54:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_whr_hp_g54);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_buffalo_whr_hp_g54);
 		break;
 	case BCM47XX_BOARD_BUFFALO_WZR_G300N:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_wzr_g300n);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_buffalo_wzr_g300n);
 		break;
 	case BCM47XX_BOARD_BUFFALO_WZR_RS_G54:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_wzr_rs_g54);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_buffalo_wzr_rs_g54);
 		break;
 	case BCM47XX_BOARD_BUFFALO_WZR_RS_G54HP:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_buffalo_wzr_rs_g54hp);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_buffalo_wzr_rs_g54hp);
 		break;
 
 	case BCM47XX_BOARD_DELL_TM2300:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_dell_tm2300);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_dell_tm2300);
 		break;
 
 	case BCM47XX_BOARD_DLINK_DIR130:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_dlink_dir130);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_dlink_dir130);
 		break;
 	case BCM47XX_BOARD_DLINK_DIR330:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_dlink_dir330);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_dlink_dir330);
 		break;
 
 	case BCM47XX_BOARD_HUAWEI_E970:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_huawei_e970);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_huawei_e970);
 		break;
 
 	case BCM47XX_BOARD_LINKSYS_E1000V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e1000v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_e1000v1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_E1000V21:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e1000v21);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_e1000v21);
 		break;
 	case BCM47XX_BOARD_LINKSYS_E2000V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e2000v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_e2000v1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_E2500V3:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e2500v3);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_e2500v3);
 		break;
 	case BCM47XX_BOARD_LINKSYS_E3000V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e3000v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_e3000v1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_E3200V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e3200v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_e3200v1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_E4200V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_e4200v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_e4200v1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT150NV1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt150nv1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt150nv1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT150NV11:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt150nv11);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt150nv11);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT160NV1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt160nv1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt160nv1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT160NV3:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt160nv3);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt160nv3);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT300N_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt300n_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt300n_v1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT300NV11:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt300nv11);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt300nv11);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt310nv1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt310nv1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT310NV2:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt310n_v2);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt310n_v2);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT320N_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt320n_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt320n_v1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G3GV2:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt54g3gv2);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt54g3gv2);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101:
 	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467:
 	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt54g_generic);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt54g_generic);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT610NV1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt610nv1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt610nv1);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRT610NV2:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt610nv2);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrt610nv2);
 		break;
 	case BCM47XX_BOARD_LINKSYS_WRTSL54GS:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrtsl54gs);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_linksys_wrtsl54gs);
 		break;
 
 	case BCM47XX_BOARD_LUXUL_ABR_4400_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_abr_4400_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_abr_4400_v1);
 		break;
 	case BCM47XX_BOARD_LUXUL_XAP_310_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_310_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_xap_310_v1);
 		break;
 	case BCM47XX_BOARD_LUXUL_XAP_1210_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_1210_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_xap_1210_v1);
 		break;
 	case BCM47XX_BOARD_LUXUL_XAP_1230_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_1230_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_xap_1230_v1);
 		break;
 	case BCM47XX_BOARD_LUXUL_XAP_1240_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_1240_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_xap_1240_v1);
 		break;
 	case BCM47XX_BOARD_LUXUL_XAP_1500_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xap_1500_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_xap_1500_v1);
 		break;
 	case BCM47XX_BOARD_LUXUL_XBR_4400_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xbr_4400_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_xbr_4400_v1);
 		break;
 	case BCM47XX_BOARD_LUXUL_XVW_P30_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xvw_p30_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_xvw_p30_v1);
 		break;
 	case BCM47XX_BOARD_LUXUL_XWR_600_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xwr_600_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_xwr_600_v1);
 		break;
 	case BCM47XX_BOARD_LUXUL_XWR_1750_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_luxul_xwr_1750_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_luxul_xwr_1750_v1);
 		break;
 
 	case BCM47XX_BOARD_MICROSOFT_MN700:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_microsoft_nm700);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_microsoft_nm700);
 		break;
 
 	case BCM47XX_BOARD_MOTOROLA_WE800G:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_motorola_we800g);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_motorola_we800g);
 		break;
 	case BCM47XX_BOARD_MOTOROLA_WR850GP:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_motorola_wr850gp);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_motorola_wr850gp);
 		break;
 	case BCM47XX_BOARD_MOTOROLA_WR850GV2V3:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_motorola_wr850gv2v3);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_motorola_wr850gv2v3);
 		break;
 
 	case BCM47XX_BOARD_NETGEAR_R6200_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_r6200_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_r6200_v1);
 		break;
 	case BCM47XX_BOARD_NETGEAR_R6300_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_r6300_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_r6300_v1);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WN2500RP_V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wn2500rp_v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_wn2500rp_v1);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR3400V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3400v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_wndr3400v1);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR3400_V3:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3400_v3);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_wndr3400_v3);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR3700V3:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr3700v3);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_wndr3700v3);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNDR4500V1:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wndr4500v1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_wndr4500v1);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNR1000_V3:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr1000_v3);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_wnr1000_v3);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNR3500L:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr3500lv1);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_wnr3500lv1);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNR3500L_V2:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr3500lv2);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_wnr3500lv2);
 		break;
 	case BCM47XX_BOARD_NETGEAR_WNR834BV2:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_netgear_wnr834bv2);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_netgear_wnr834bv2);
 		break;
 
 	case BCM47XX_BOARD_SIMPLETECH_SIMPLESHARE:
-		err = bcm47xx_copy_bdata(bcm47xx_buttons_simpletech_simpleshare);
+		err = bcm47xx_add_bdata(bcm47xx_buttons_simpletech_simpleshare);
 		break;
 
 	default:
@@ -769,13 +843,7 @@ int __init bcm47xx_buttons_register(void)
 	}
 
 	if (err)
-		return -ENOMEM;
-
-	err = platform_device_register(&bcm47xx_buttons_gpio_keys);
-	if (err) {
-		pr_err("Failed to register platform device: %d\n", err);
 		return err;
-	}
 
 	return 0;
 }

-- 
2.55.0.795.g602f6c329a-goog


