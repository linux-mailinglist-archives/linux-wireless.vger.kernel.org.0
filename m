Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D686B7EEEAD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 10:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbjKQJcL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 04:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbjKQJbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 04:31:49 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A83F1BDF
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 01:31:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBw-0002W2-5V; Fri, 17 Nov 2023 10:31:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBv-009e8P-PA; Fri, 17 Nov 2023 10:31:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBv-002yjd-G9; Fri, 17 Nov 2023 10:31:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-wireless@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH wifi-next 2/6] wifi: ath5k: Convert to platform remove callback returning void
Date:   Fri, 17 Nov 2023 10:30:59 +0100
Message-ID: <20231117093056.873834-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Cn+O4+g/1tMrz3IA5hL3E0hfLvZWdc/lCQDXHNZaDVs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzLTquOPtRTk3um5arJ1oVOgAhyYgLJYcn0gL pcyOsG7nHSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcy0wAKCRCPgPtYfRL+ ThatB/4sxUbLcY3DhhSdejvoAgsu9EBeuq6vbkWK/LhgCijDtR68FvOkNzvM1IlSSBCTOY/DKMe BWSOVxTXOVxB6KnEikbSPu6VnFQAift8Uy1l7FMkbxd4EofLyud4sanwClTXZjfFplTlMVcoc0g XluHpcWgeF4sNRvzdl92VQ4Jx7hvTEiPdF/nJ4Z5R8Gy/DjaKazvwC2q8H4rP7Uq5GsTWGewHSy 52hZT4cGBq+pgrLOh8bS5MC3CJU8/tNOI1xRtPB5BSWmmueKLWHH2tRxueWz49MBVRDFtApQtPl Jibtied2OPQJlM4dgGeVnxa389LSiGJiCxRimi6o+YIvffAd
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
 drivers/net/wireless/ath/ath5k/ahb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wireless/ath/ath5k/ahb.c
index 08bd5d3b00f1..f27308ccb2f1 100644
--- a/drivers/net/wireless/ath/ath5k/ahb.c
+++ b/drivers/net/wireless/ath/ath5k/ahb.c
@@ -185,7 +185,7 @@ static int ath_ahb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ath_ahb_remove(struct platform_device *pdev)
+static void ath_ahb_remove(struct platform_device *pdev)
 {
 	struct ar231x_board_config *bcfg = dev_get_platdata(&pdev->dev);
 	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
@@ -193,7 +193,7 @@ static int ath_ahb_remove(struct platform_device *pdev)
 	u32 reg;
 
 	if (!hw)
-		return 0;
+		return;
 
 	ah = hw->priv;
 
@@ -215,13 +215,11 @@ static int ath_ahb_remove(struct platform_device *pdev)
 	ath5k_deinit_ah(ah);
 	iounmap(ah->iobase);
 	ieee80211_free_hw(hw);
-
-	return 0;
 }
 
 static struct platform_driver ath_ahb_driver = {
 	.probe      = ath_ahb_probe,
-	.remove     = ath_ahb_remove,
+	.remove_new = ath_ahb_remove,
 	.driver		= {
 		.name	= "ar231x-wmac",
 	},
-- 
2.42.0

