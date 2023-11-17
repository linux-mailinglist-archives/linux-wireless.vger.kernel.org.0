Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59187EEEAF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 10:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbjKQJcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 04:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345748AbjKQJbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 04:31:51 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DC71BE2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 01:31:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBw-0002WO-My; Fri, 17 Nov 2023 10:31:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBw-009e8X-5D; Fri, 17 Nov 2023 10:31:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBv-002yjk-Rv; Fri, 17 Nov 2023 10:31:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH wifi-next 4/6] wifi: wcn36xx: Convert to platform remove callback returning void
Date:   Fri, 17 Nov 2023 10:31:01 +0100
Message-ID: <20231117093056.873834-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/ttUp2M5cZQsomdzrGK/RBLVhYvusZgwx6aihSw9aS0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzLVJfxMIG3sjF2ZFPDpj1ORbqA9cY1g1eSKA q/Hg9f0IX2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcy1QAKCRCPgPtYfRL+ TpdTB/9KHc/1xM523LAekxlN8ClroE1JcXgKwZS+MHYQoKq2HPCYHkbOVAifFvamwq7qGb5GsIl bu5hd1OyJYmB82uCET9symNHbwMdBiQW+LTKUmO4oQ+dlJD7KjwcvZweG9V/TWefbaq6O1CDIwn hI1oP1uvBrEQ74Dp5bDOMWPUNebLWOfvlDvmByqgX07A5IRx7Q5H7/l55AUK3GUddTFhW4IYPnk oPKMj8Gli+GzCpLIl6/XeGuQb/DMTtllyP/JOUvSR8GlvIzjd90/ip8B408W4ey+aIEvxOCZnBK NPFcDmLuxWCiY0BBpVk9NoQnsXtx/e2G8vSu2P8rUzIYo5hX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
 drivers/net/wireless/ath/wcn36xx/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 2bd1163177f0..41119fb177e3 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1644,7 +1644,7 @@ static int wcn36xx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int wcn36xx_remove(struct platform_device *pdev)
+static void wcn36xx_remove(struct platform_device *pdev)
 {
 	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
 	struct wcn36xx *wcn = hw->priv;
@@ -1666,8 +1666,6 @@ static int wcn36xx_remove(struct platform_device *pdev)
 
 	mutex_destroy(&wcn->hal_mutex);
 	ieee80211_free_hw(hw);
-
-	return 0;
 }
 
 static const struct of_device_id wcn36xx_of_match[] = {
@@ -1678,7 +1676,7 @@ MODULE_DEVICE_TABLE(of, wcn36xx_of_match);
 
 static struct platform_driver wcn36xx_driver = {
 	.probe      = wcn36xx_probe,
-	.remove     = wcn36xx_remove,
+	.remove_new = wcn36xx_remove,
 	.driver         = {
 		.name   = "wcn36xx",
 		.of_match_table = wcn36xx_of_match,
-- 
2.42.0

