Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB17528FF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjGMQrA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjGMQq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 12:46:59 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CFD1986
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 09:46:57 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ab03:0:640:a6db:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 3182C60093;
        Thu, 13 Jul 2023 19:46:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rkepGP2DaeA0-iNIMkBKe;
        Thu, 13 Jul 2023 19:46:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689266814;
        bh=gfcMFxr/wQKjSzmq+1RFZLkOOuKCJns6sdCBFMK1NRQ=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=XapigjQOw8sU3k0+4EI9hmiRoqgDPvoTYXjGjXAX4WG4BDxPFMctPSECIgL5q4UMP
         eBCh7jn68MnlGgvtqAsv8lfnyoFcOOsyO6BtBcuaiY3mr8HmLgqniVN91KUlfyWXpW
         dgqNmN9D8iecaNqAcEbb/eNfFvIqDeD1qPZuMZcw=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: ath10k: fix PCI and SNOC RX pipe operations
Date:   Thu, 13 Jul 2023 19:46:10 +0300
Message-ID: <20230713164628.341491-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <5a053fc3-7fd0-f8ea-7512-e473815814f4@quicinc.com>
References: <5a053fc3-7fd0-f8ea-7512-e473815814f4@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v2: fix successful termination of loops (when no errors are
    returned by __xxx_rx_post_buf() functions) (Jeff Johnson)
---
 drivers/net/wireless/ath/ath10k/pci.c  | 16 +++++++---------
 drivers/net/wireless/ath/ath10k/snoc.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index a7f44f6335fb..5eee792b63bd 100644
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
+	if (ret && ret != -ENOSPC) {
+		ath10k_warn(ar, "failed to post PCI rx buf: %d\n", ret);
+		mod_timer(&ar_pci->rx_post_retry, jiffies +
+			  msecs_to_jiffies(ATH10K_PCI_RX_POST_RETRY_MS));
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 26214c00cd0d..a5085cb31c23 100644
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
+	if (ret && ret != -ENOSPC) {
+		ath10k_warn(ar, "failed to post SNOC rx buf: %d\n", ret);
+		mod_timer(&ar_snoc->rx_post_retry, jiffies +
+			  msecs_to_jiffies(ATH10K_SNOC_RX_POST_RETRY_MS));
 	}
 }
 
-- 
2.41.0

