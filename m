Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC627527EC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjGMQC0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 12:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjGMQCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 12:02:20 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A8271F
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 09:02:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3c81:0:640:d488:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 43E3A60021;
        Thu, 13 Jul 2023 19:02:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id F2eqB42Wn8c0-kKnLUxVr;
        Thu, 13 Jul 2023 19:02:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689264135;
        bh=hPPMmiKwY1oM20k4fidTnyeo0kqVYkehCNjEfUoLMkI=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=J8JdN0TvzfVqOr1qWFkyWacVyaNWgMNqD3UeNN5G9SMBOKHpwC/8CXqHB7KUajfA4
         sPLtZpAU7OdjpNhhdSl33sTUgYhrGX76dlgKFV88k1uIchWr+ME8lD5+WS7lAYigJ3
         UNa4sNz+gEkjathesJ+W2HK9xHfFrgIGvWx2GHok=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: fix PCI and SNOC RX pipe operations
Date:   Thu, 13 Jul 2023 19:00:57 +0300
Message-ID: <20230713160101.333483-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'mod_timer()' expects expiration time in jiffies, add
missing 'msecs_to_jiffies()' in 'ath10k_pci_rx_post_pipe()'
and 'ath10k_snoc_rx_post_pipe()'. Also simplify the loops
and fix number of loop iterations in the former (it should
be equal to 'num' (i.e. number of buffers) and not 'num + 1'.

Fixes: 728f95eef523 ("ath10k: rework posting pci rx buffers")
Fixes: a6e149a9ff03 ("ath10k: add hif start/stop methods for wcn3990 snoc layer")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/pci.c  | 16 +++++++---------
 drivers/net/wireless/ath/ath10k/snoc.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index a7f44f6335fb..c004c87d3211 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -818,17 +818,15 @@ static void ath10k_pci_rx_post_pipe(struct ath10k_pci_pipe *pipe)
 	num = __ath10k_ce_rx_num_free_bufs(ce_pipe);
 	spin_unlock_bh(&ce->ce_lock);
 
-	while (num >= 0) {
+	while (num--) {
 		ret = __ath10k_pci_rx_post_buf(pipe);
-		if (ret) {
-			if (ret == -ENOSPC)
-				break;
-			ath10k_warn(ar, "failed to post pci rx buf: %d\n", ret);
-			mod_timer(&ar_pci->rx_post_retry, jiffies +
-				  ATH10K_PCI_RX_POST_RETRY_MS);
+		if (ret)
 			break;
-		}
-		num--;
+	}
+	if (ret != -ENOSPC) {
+		ath10k_warn(ar, "failed to post PCI rx buf: %d\n", ret);
+		mod_timer(&ar_pci->rx_post_retry, jiffies +
+			  msecs_to_jiffies(ATH10K_PCI_RX_POST_RETRY_MS));
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 26214c00cd0d..9ced24b1b177 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -544,16 +544,16 @@ static void ath10k_snoc_rx_post_pipe(struct ath10k_snoc_pipe *pipe)
 	spin_lock_bh(&ce->ce_lock);
 	num = __ath10k_ce_rx_num_free_bufs(ce_pipe);
 	spin_unlock_bh(&ce->ce_lock);
+
 	while (num--) {
 		ret = __ath10k_snoc_rx_post_buf(pipe);
-		if (ret) {
-			if (ret == -ENOSPC)
-				break;
-			ath10k_warn(ar, "failed to post rx buf: %d\n", ret);
-			mod_timer(&ar_snoc->rx_post_retry, jiffies +
-				  ATH10K_SNOC_RX_POST_RETRY_MS);
+		if (ret)
 			break;
-		}
+	}
+	if (ret != -ENOSPC) {
+		ath10k_warn(ar, "failed to post SNOC rx buf: %d\n", ret);
+		mod_timer(&ar_snoc->rx_post_retry, jiffies +
+			  msecs_to_jiffies(ATH10K_SNOC_RX_POST_RETRY_MS));
 	}
 }
 
-- 
2.41.0

