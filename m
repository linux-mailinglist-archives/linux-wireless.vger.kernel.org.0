Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4371A719575
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFAI0R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFAI0P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 04:26:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976D11F
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 01:26:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4ddE-0002uE-GT; Thu, 01 Jun 2023 10:26:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4ddD-004JKk-Kn; Thu, 01 Jun 2023 10:26:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q4ddC-00A5yf-KJ; Thu, 01 Jun 2023 10:26:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH net-next 4/4] atk10k: Don't opencode ath10k_pci_priv() in ath10k_ahb_priv()
Date:   Thu,  1 Jun 2023 10:25:56 +0200
Message-Id: <20230601082556.2738446-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601082556.2738446-1-u.kleine-koenig@pengutronix.de>
References: <20230601082556.2738446-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mB84wW1K4jc1xLTUjLQHhA/td0xttZYqfcR4I36/mvA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkeFYQL7s14DdzYELR1Cx2HAvAJ61K34lTqhuXN Yq/CSdxCiOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHhWEAAKCRCPgPtYfRL+ Tio+B/4hk7D3EVxU+bfB+uzq0dJigX32SKnyzzrImpCpKSo5DIu/Cwrm2CPNSpRyoxsJA9EG/Db rqDhS1JCk4QrSgjoYWVMOJ35wLdxVEQYKBxN8QcvtTz5+Ng88zEnXV06eoK7m3X7A6yPfdRiALT 4rpj5oY8Jis7gIyjEXXMi0/1evYR6wVFLcUOSX9mdc3cFwlKWa3u8Kd7Cvr0O/0vdWHbktCOn3G Esc9RYWUxaMLW0aC3c0dYxqV50Bthr17alGpMQvFJxxQUc4pNNShI0J+zDxNrp1NgjO9Mh3jPeR Ryk307k+z6X1zimvOzeOrKgvT3fiMqDI5/pj9O8Cf/4qXfLL
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

This introduces no changes in the compiled result (tested for an
ARCH=arm allmodconfig build).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/wireless/ath/ath10k/ahb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index 632da4c5e5da..4a006fb4d424 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -27,7 +27,7 @@ MODULE_DEVICE_TABLE(of, ath10k_ahb_of_match);
 
 static inline struct ath10k_ahb *ath10k_ahb_priv(struct ath10k *ar)
 {
-	return &((struct ath10k_pci *)ar->drv_priv)->ahb[0];
+	return &ath10k_pci_priv(ar)->ahb[0];
 }
 
 static void ath10k_ahb_write32(struct ath10k *ar, u32 offset, u32 value)
-- 
2.39.2

