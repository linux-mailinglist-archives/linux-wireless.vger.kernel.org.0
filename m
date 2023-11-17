Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C064D7EEEB0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 10:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbjKQJcN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 04:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbjKQJbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 04:31:51 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF81BE1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 01:31:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBw-0002W5-Bo; Fri, 17 Nov 2023 10:31:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBv-009e8S-VH; Fri, 17 Nov 2023 10:31:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBv-002yjh-M6; Fri, 17 Nov 2023 10:31:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH wifi-next 3/6] wifi: ath9k: Convert to platform remove callback returning void
Date:   Fri, 17 Nov 2023 10:31:00 +0100
Message-ID: <20231117093056.873834-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=N9Dy/6GQoy6eWX+yvg/Md8jIQ79Rp09sy8+AUKH7rkA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzLUfCLs5lvJrfBXqI+IKwDdFo/MXozPHEmu8 2TVZHj7V9aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcy1AAKCRCPgPtYfRL+ TmQXB/0R9ZkFar8V5zXc9jHXvyTaRRj5q5aNkfPJGI7OTAhu5rfoKCndcQLZW1IDLY00MogvlCb Fh4Ppg23d9weDryapg6JCm7YmQNqV0BKtSaDCPTldiC2AmSoRFUE2WrYR4ckm4+7gWAsK5ZINpw +ggpwYAvdxQ0VkKD73WBcsln+u9KKQLIh87kZ6fV9ikq690xRpw8P1tkbarWmm7Gb9u/M2HQoSD JlcuAnr25aycG9p2wSNvyeeSX49SNBBj8FHryxhSDzjoTfoQhLDyMMurgETJqYj10AUPi94zh7D FTFefmB81Y+6ykyeb+DrHx2yEljoYLA17jEIrnaOzbs3ZoH5
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
 drivers/net/wireless/ath/ath9k/ahb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 9bfaadfa6c00..1a6697b6e3b4 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -144,7 +144,7 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ath_ahb_remove(struct platform_device *pdev)
+static void ath_ahb_remove(struct platform_device *pdev)
 {
 	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
 
@@ -155,13 +155,11 @@ static int ath_ahb_remove(struct platform_device *pdev)
 		free_irq(sc->irq, sc);
 		ieee80211_free_hw(sc->hw);
 	}
-
-	return 0;
 }
 
 static struct platform_driver ath_ahb_driver = {
 	.probe      = ath_ahb_probe,
-	.remove     = ath_ahb_remove,
+	.remove_new = ath_ahb_remove,
 	.driver		= {
 		.name	= "ath9k",
 	},
-- 
2.42.0

