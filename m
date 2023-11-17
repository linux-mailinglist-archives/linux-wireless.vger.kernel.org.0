Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15567EEEAC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 10:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbjKQJcK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 04:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbjKQJbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 04:31:49 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC401BDC
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 01:31:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBw-0002W1-7T; Fri, 17 Nov 2023 10:31:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBv-009e8M-Ga; Fri, 17 Nov 2023 10:31:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBv-002yjZ-7e; Fri, 17 Nov 2023 10:31:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH wifi-next 1/6] wifi: ath11k: Convert to platform remove callback returning void
Date:   Fri, 17 Nov 2023 10:30:58 +0100
Message-ID: <20231117093056.873834-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3hYN3tnM4/NZ3knZ/+upus+mpO+Pxs5arIlHPwnJHaU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzLSL9vS6NnmImZuTLnRn0N7U5Tf5PTOeIPAq +P5ZjIJpaaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcy0gAKCRCPgPtYfRL+ Tsi0B/9CWelcJYoumkh4qKAWMn+yfrTHa3oNZC8oj2WIo1CAmki62h720/KIXJAKJNhRUgxlPBd a/AM6wsviq081gNYx5al77rBGez7HA1HWdjJmgCNKDPfF+NoU/n1/8TRerAaQU/yfKSRRsn5ZCf ANcAFLLiJMMvOjfgmp3S+Fs/l3jvXIjBwB3SgUnyHMCVZTWZvIl8OaC17iHYiLhpZSy7ezGdyN2 1Guu929RP0Y6BXZsSW2L8ovYi2EqcOdm0LvV6KdDFRmZgqOldK/sh0UvcixRfOT6UVis9yC8GbQ Fm9ZlQumTYb4qSqoLlxzm3HbzAUoUEVcQJ5JXVds+mfxXJU+
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
 drivers/net/wireless/ath/ath11k/ahb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 235336ef2a7a..f8ae9ba85500 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1251,7 +1251,7 @@ static void ath11k_ahb_free_resources(struct ath11k_base *ab)
 	platform_set_drvdata(pdev, NULL);
 }
 
-static int ath11k_ahb_remove(struct platform_device *pdev)
+static void ath11k_ahb_remove(struct platform_device *pdev)
 {
 	struct ath11k_base *ab = platform_get_drvdata(pdev);
 
@@ -1267,8 +1267,6 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 
 qmi_fail:
 	ath11k_ahb_free_resources(ab);
-
-	return 0;
 }
 
 static void ath11k_ahb_shutdown(struct platform_device *pdev)
@@ -1296,7 +1294,7 @@ static struct platform_driver ath11k_ahb_driver = {
 		.of_match_table = ath11k_ahb_of_match,
 	},
 	.probe  = ath11k_ahb_probe,
-	.remove = ath11k_ahb_remove,
+	.remove_new = ath11k_ahb_remove,
 	.shutdown = ath11k_ahb_shutdown,
 };
 
-- 
2.42.0

