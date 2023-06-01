Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E179719576
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjFAI0R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFAI0Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 04:26:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966E125
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 01:26:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4ddE-0002th-GT; Thu, 01 Jun 2023 10:26:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4ddC-004JKY-Se; Thu, 01 Jun 2023 10:26:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4ddC-00A5yZ-4N; Thu, 01 Jun 2023 10:26:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH net-next 2/4] ath10k: Drop checks that are always false
Date:   Thu,  1 Jun 2023 10:25:54 +0200
Message-Id: <20230601082556.2738446-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601082556.2738446-1-u.kleine-koenig@pengutronix.de>
References: <20230601082556.2738446-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Yfnwqnu04xN5zBPB75lffig/GKnzspVu8L0rjK4grlM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkeFYNH9B9+cgVgG1rALdO44a+2awW1rJORFSvx 5lBEbtN+3eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHhWDQAKCRCPgPtYfRL+ TpRCB/47yB+eQRU7pdV1LYcp0fUx1OeF3hlOATCnnNXYV4ZMpzUEemcA9EZktaH4Ako6XjMW9D9 3wDC53dbWEhhRYJ/NNnaz9NZp9cG88rtC3ij4HdEwjSeGUdU2UhSfhaEFwNWtzhKLPeCbEgZhTH FGgtQ5Hiriu79W9CPXymRD1QXisW8Hs8ZOUtmE7ddnS5xnXJiHB3s3OZ7VGGsbKPjDxerJ895mo YRBLWh3Trd8eaBSRbjxqeDLHZEKe0iod0ea7buh3YFZYzCgacYMFcwe2dV0eUhPm3PGfABPrHrL RZ0q6czA2fUYs93OrE72DGM0v7Ikhx1OLEzRSAczbVaQRVsk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

platform_get_drvdata() cannot return NULL as the probe function calls
platform_set_drvdata() with a non-NULL argument or returns with a failure.
In the first case, platform_get_drvdata() returns this non-NULL value and
in the second the remove callback isn't called at all.

ath10k_ahb_priv() cannot return NULL and ar_ahb is unused after the check
anyhow.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/wireless/ath/ath10k/ahb.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index 7bb45c66cff7..fffdbad75074 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -823,15 +823,6 @@ static int ath10k_ahb_probe(struct platform_device *pdev)
 static int ath10k_ahb_remove(struct platform_device *pdev)
 {
 	struct ath10k *ar = platform_get_drvdata(pdev);
-	struct ath10k_ahb *ar_ahb;
-
-	if (!ar)
-		return -EINVAL;
-
-	ar_ahb = ath10k_ahb_priv(ar);
-
-	if (!ar_ahb)
-		return -EINVAL;
 
 	ath10k_dbg(ar, ATH10K_DBG_AHB, "ahb remove\n");
 
-- 
2.39.2

