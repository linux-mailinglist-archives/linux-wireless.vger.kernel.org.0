Return-Path: <linux-wireless+bounces-4483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD04887602F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 09:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2F11C22651
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BB32C85C;
	Fri,  8 Mar 2024 08:51:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DB208AD
	for <linux-wireless@vger.kernel.org>; Fri,  8 Mar 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887904; cv=none; b=pWlki/EhUEwNyz5ReOk6gth6liGpwCrF5UwTvqsPxm7IiitDCM5Ut3Gn3pwrz9fSowQuqe7eD1Kxd2KDLenIosZTFW0Efzdc3qkRoZpDQk2ofBBufesgXnab4tqKPH6ZVkqHc1RdzgZKVeLtEjznwF/KtMDyFFYAUoS8wDnYVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887904; c=relaxed/simple;
	bh=c0Cnl8ikeMfmNdB41RuxboV0cAOLKezFofDlHFzQqFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jHSRHvvkcuWALZW/ol7KK5cZsObMgCVOa+kdk88VlcqAK24XcWC5osCrsWwkjkzw7TU9ri/jb1s5MePiQxpW8lfIbQvFHxy19xHrLJVLCkmbZgJhISLKcKXfzpqyt9d78VPGwZsJe/CcdqfLe7Tydw9rmwv3U5ySV8Hks8aK/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVx4-0006lO-LE; Fri, 08 Mar 2024 09:51:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVx4-0056Mt-8t; Fri, 08 Mar 2024 09:51:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVx4-00244b-0c;
	Fri, 08 Mar 2024 09:51:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] bcma: convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:03 +0100
Message-ID:  <a92e4b2f7aace64a1e3a91af7974a6982700a18f.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=c0Cnl8ikeMfmNdB41RuxboV0cAOLKezFofDlHFzQqFA=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRXFysepzxjsHPYJ6u+SUmjYeEGJrl9nTn8jWtmrblaO 3UFn/HeTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmkqLGwTDjnWy4XiJL7Z+2 2gAdK4lLnA1LPb8F1N4ujjQ5a3Ri4hLFGZwr3zSvCZA8MLX+dkvfC2OfojdZBgd7NaYfP/zRgm9 T6GdhyRebWqp2XThW65vgbJTk87jAmZEr8nPN3pgJrDsr5ffpu/FGK5nYBjA5fHNUkfZUWDN3j/ TKmUbXI+W7fKczLBDhErrElqmR+eLK4crb/Hd4lhQ43m+LmPv7ltFNLt6bti1G8rpT13ilTQ8u0 zlkPPUH1/4Hdxot2lJO8ZSqXtyfwzC5N+npN+5pNYFz7cv7Eo/mqmqHmekKMZ2Vm3Z694G53z3E HsiWXFl84Y7tkTezfhSUmG3pW7LMUMH2TPVnXp83jLs1AQ==
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
 drivers/bcma/host_soc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bcma/host_soc.c b/drivers/bcma/host_soc.c
index 90d5bdc12e03..8ae0b918e740 100644
--- a/drivers/bcma/host_soc.c
+++ b/drivers/bcma/host_soc.c
@@ -240,15 +240,13 @@ static int bcma_host_soc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int bcma_host_soc_remove(struct platform_device *pdev)
+static void bcma_host_soc_remove(struct platform_device *pdev)
 {
 	struct bcma_bus *bus = platform_get_drvdata(pdev);
 
 	bcma_bus_unregister(bus);
 	iounmap(bus->mmio);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static const struct of_device_id bcma_host_soc_of_match[] = {
@@ -263,7 +261,7 @@ static struct platform_driver bcma_host_soc_driver = {
 		.of_match_table = bcma_host_soc_of_match,
 	},
 	.probe		= bcma_host_soc_probe,
-	.remove		= bcma_host_soc_remove,
+	.remove_new	= bcma_host_soc_remove,
 };
 
 int __init bcma_host_soc_register_driver(void)

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


