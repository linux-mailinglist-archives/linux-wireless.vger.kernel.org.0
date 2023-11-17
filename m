Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD157EEEB7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 10:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjKQJcX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 04:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjKQJcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 04:32:04 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81523D67
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 01:31:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBy-0002We-Lm; Fri, 17 Nov 2023 10:31:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBw-009e8g-HW; Fri, 17 Nov 2023 10:31:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3vBw-002yjs-7w; Fri, 17 Nov 2023 10:31:12 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
        Wang Yufen <wangyufen@huawei.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        linux-wireless@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH wifi-next 6/6] wifi: mt76: Convert to platform remove callback returning void
Date:   Fri, 17 Nov 2023 10:31:03 +0100
Message-ID: <20231117093056.873834-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
References: <20231117093056.873834-8-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3950; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+3uRgiNiFEUq76nz+Tl18IjBYtgiYGwpGMdyzAD5v60=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzLXT1SjMog7G1p0Rt6rpyQjo0Au315Pg03xv eJWDyH3yuuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcy1wAKCRCPgPtYfRL+ TvnCB/9W4nN1DVz3DUuF4txvKaocsAYBLBRVL5oSyWLKW3jc9vc7e7+t0d3pFlApANOGIhJ/4e7 /alJ8pDpLBgOtaQfXZc2JQuIMxE7uHDjraYxXtA7x1ztdzOrpkm7VBYuljDA8tjxqmUnTA7PSXH yf5X/s/jKtKRvqYYcCmjH1o9qCNY38dLQ0KfC0hOuelhXaEXM93Ns9jG3NnQkp0FrPNZocuhbIP 8yLjFgb4lOi4nDO0kG1Z5WPrmyTVl04hL09tbZ7brIJ6qDjfla/2ZMIuQjr6swLEM/xI8kGUCKN mmMpEauAJ7RTTJdaLpN/4y5pp4WMgzEi8Blu10DQ2eenY2Ha
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

Trivially convert the three mt76 drivers from always returning zero in
the remove callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c | 7 ++-----
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c | 6 ++----
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 6 ++----
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index ba927033bbe8..ec02148a7f1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -52,15 +52,12 @@ mt76_wmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int
-mt76_wmac_remove(struct platform_device *pdev)
+static void mt76_wmac_remove(struct platform_device *pdev)
 {
 	struct mt76_dev *mdev = platform_get_drvdata(pdev);
 	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
 
 	mt7603_unregister_device(dev);
-
-	return 0;
 }
 
 static const struct of_device_id of_wmac_match[] = {
@@ -74,7 +71,7 @@ MODULE_FIRMWARE(MT7628_FIRMWARE_E2);
 
 struct platform_driver mt76_wmac_driver = {
 	.probe		= mt76_wmac_probe,
-	.remove		= mt76_wmac_remove,
+	.remove_new	= mt76_wmac_remove,
 	.driver = {
 		.name = "mt76_wmac",
 		.of_match_table = of_wmac_match,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/soc.c b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
index f13d1b418742..12e3e4a91d27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/soc.c
@@ -45,13 +45,11 @@ static int mt7622_wmac_probe(struct platform_device *pdev)
 	return mt7615_mmio_probe(&pdev->dev, mem_base, irq, mt7615e_reg_map);
 }
 
-static int mt7622_wmac_remove(struct platform_device *pdev)
+static void mt7622_wmac_remove(struct platform_device *pdev)
 {
 	struct mt7615_dev *dev = platform_get_drvdata(pdev);
 
 	mt7615_unregister_device(dev);
-
-	return 0;
 }
 
 static const struct of_device_id mt7622_wmac_of_match[] = {
@@ -65,7 +63,7 @@ struct platform_driver mt7622_wmac_driver = {
 		.of_match_table = mt7622_wmac_of_match,
 	},
 	.probe = mt7622_wmac_probe,
-	.remove = mt7622_wmac_remove,
+	.remove_new = mt7622_wmac_remove,
 };
 
 MODULE_FIRMWARE(MT7622_FIRMWARE_N9);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 06e3d9db996c..8b4809703efc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -1282,13 +1282,11 @@ static int mt798x_wmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mt798x_wmac_remove(struct platform_device *pdev)
+static void mt798x_wmac_remove(struct platform_device *pdev)
 {
 	struct mt7915_dev *dev = platform_get_drvdata(pdev);
 
 	mt7915_unregister_device(dev);
-
-	return 0;
 }
 
 static const struct of_device_id mt798x_wmac_of_match[] = {
@@ -1305,7 +1303,7 @@ struct platform_driver mt798x_wmac_driver = {
 		.of_match_table = mt798x_wmac_of_match,
 	},
 	.probe = mt798x_wmac_probe,
-	.remove = mt798x_wmac_remove,
+	.remove_new = mt798x_wmac_remove,
 };
 
 MODULE_FIRMWARE(MT7986_FIRMWARE_WA);
-- 
2.42.0

