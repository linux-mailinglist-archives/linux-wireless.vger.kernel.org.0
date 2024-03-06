Return-Path: <linux-wireless+bounces-4442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4495873FC0
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 19:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B03B22DCC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7B313E7C5;
	Wed,  6 Mar 2024 18:35:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B11613E7D4
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750152; cv=none; b=RuC/RFr+H7LO3opWYMQywuYv+QjrKEAx1u+Goaixq0fP6hdCbsW/C9EjGrICol1xpHRIh/QuSReBPTJC+paHVeEOFLdvmsPBShXy59ihV1uMwoy31lf2odsF04CyNf62FIilVeecpg0rgpWBfZfhZXyUsr5XyreyjkWJX+PHyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750152; c=relaxed/simple;
	bh=1vIIlOoXQqaRL43xN9hPITwtLtN+twVOgmkPslLsNSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jxG8X0+Uu5Rqb3naOldldUmSFZ5G9hU30FLqfz8VgKVhb8JPcc9NDqxhMgVmJy98B5kPoMb4qrtrdZXhltuiwlL/uieS2iSNzTBEoPgvHQduxcXSA4doK85drfQbonJ8XvDBdglLN7kmyb8EydZdx71jtx/ocw0ARSRO5wuEGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhw7D-0005KA-VB; Wed, 06 Mar 2024 19:35:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhw7C-004nYD-HC; Wed, 06 Mar 2024 19:35:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhw7C-000p5I-1P;
	Wed, 06 Mar 2024 19:35:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH next] net: rfkill: gpio: Convert to platform remove callback returning void
Date: Wed,  6 Mar 2024 19:35:38 +0100
Message-ID: <20240306183538.88777-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1vIIlOoXQqaRL43xN9hPITwtLtN+twVOgmkPslLsNSY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6Ld6SXNQ8RTQGV6ETDKHTmfaKrEzAajOf//vI aD7Twxafl6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZei3egAKCRCPgPtYfRL+ TliWB/4/44bcLECBDXbTYdOrnui5QJtNtr/GO/rgOMROTbzVURUfiQFiqKq2+5VFqIptqQiyyB2 yrWVWkXmXIyuvb5TDcbgoZWWwxv+zCF7SrX7S3bFOn9kWPaDEdbQKCh6trAHBsz9XZa+RVgYa8w MYoRMLTDXVcPS9p0fJKXf0CFEgjdBzod6gkiX37Oj5ur7Hm+EhdLjif6enPC42LCIw2NBwoQq4D eJZk43wPzmBA5cAmtl802rhpxI2RA9WCBHO+GibMoD/bGX/fhI9QL+PWxfBr9wFGqyltcdLc9qM 2W02UJ4z5D/p1e5u0/+zb0hJjNET5bbA9cTak6GR9MHiyMiL
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is merge window material. I'm unsure if I should put "net-next" or
"next" or "wireless-next" into the subject line. I hope my choice
doesn't make people angry :-)

Best regards
Uwe

 net/rfkill/rfkill-gpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 4e32d659524e..84529886c2e6 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -156,14 +156,12 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rfkill_gpio_remove(struct platform_device *pdev)
+static void rfkill_gpio_remove(struct platform_device *pdev)
 {
 	struct rfkill_gpio_data *rfkill = platform_get_drvdata(pdev);
 
 	rfkill_unregister(rfkill->rfkill_dev);
 	rfkill_destroy(rfkill->rfkill_dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_ACPI
@@ -183,7 +181,7 @@ MODULE_DEVICE_TABLE(of, rfkill_of_match);
 
 static struct platform_driver rfkill_gpio_driver = {
 	.probe = rfkill_gpio_probe,
-	.remove = rfkill_gpio_remove,
+	.remove_new = rfkill_gpio_remove,
 	.driver = {
 		.name = "rfkill_gpio",
 		.acpi_match_table = ACPI_PTR(rfkill_acpi_match),

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0


