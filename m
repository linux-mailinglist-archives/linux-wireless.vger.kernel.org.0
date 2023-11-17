Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CC17EEEB3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 10:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345831AbjKQJcP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 04:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjKQJbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 04:31:53 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0EE1BF3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 01:31:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBy-0002WX-AO; Fri, 17 Nov 2023 10:31:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBw-009e8c-BG; Fri, 17 Nov 2023 10:31:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBw-002yjo-1l; Fri, 17 Nov 2023 10:31:12 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, kernel@pengutronix.de
Subject: [PATCH wifi-next 5/6] wifi: brcmfmac: Convert to platform remove callback returning void
Date:   Fri, 17 Nov 2023 10:31:02 +0100
Message-ID: <20231117093056.873834-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cqu0rMxMpS5T9wgBrb7wDBn5AdxukCT6CeUHSM8E6iU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzLW026t15O6rDRTnhHf2VesxOPdyJ0cjRAwE /I3vOTIPXGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcy1gAKCRCPgPtYfRL+ TiscB/9nE0k+th6hnSCSHF+ocm6M+lvednacS1/ZZav5d2nJ14vfg//IUj/z3+txvIdz98wpixc h73feH/uue2zYL5eW8iLXh3vz073mM+9buKfY8yFJ9lHl4lrgxJpNYPje4yO8lBzGgpFVGmcRTC neBmpQl/MNVitv6mFWDfEMbcYEBpjInuTB9sK0Uoo0mtER558HdCM4UUCEBW27VJy5BgO5nXthj Qd6kLvIaEzSL05/9FyUXPJTZymCOZ3JSgAnj11S/Nxdhrh/8R9DwZE8mMnqGaUniDu6NJzZlD/9 sX8seMgnGzWiO763RsnXyXqbJVLjg72mIe7ioEkxCf/Kw0wX
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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index a194b0e68eb5..b6d458e022fa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -578,18 +578,16 @@ static int __init brcmf_common_pd_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int brcmf_common_pd_remove(struct platform_device *pdev)
+static void brcmf_common_pd_remove(struct platform_device *pdev)
 {
 	brcmf_dbg(INFO, "Enter\n");
 
 	if (brcmfmac_pdata->power_off)
 		brcmfmac_pdata->power_off();
-
-	return 0;
 }
 
 static struct platform_driver brcmf_pd = {
-	.remove		= brcmf_common_pd_remove,
+	.remove_new	= brcmf_common_pd_remove,
 	.driver		= {
 		.name	= BRCMFMAC_PDATA_NAME,
 	}
-- 
2.42.0

