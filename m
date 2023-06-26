Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0286F73E304
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jun 2023 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjFZPQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jun 2023 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjFZPQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jun 2023 11:16:43 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B54D3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jun 2023 08:16:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3faf:0:640:537b:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 8AEF960065;
        Mon, 26 Jun 2023 18:16:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bGM21E2WuSw0-15Sexy6X;
        Mon, 26 Jun 2023 18:16:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687792598;
        bh=nHZNBg1lY2fHaMT5s/DQ6RfZqCnQitRSQzp7idkVQUs=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=I8aR1Nk1UNwA1erbBBrIrJriksKH6xbphOh6pn7NSkGN2ZnODVp3TdA/ty9A7LMAg
         wa6xE5wOS0SdfBOlSH1lmjsTOfN76mm6r4Iz4F1c5+olnXqyMdfHKtEZ8VJYQozJ9i
         aamt/5NNPtHsuc3hnv8y9TJ8ypJRbTDrbXWGmrVI=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: convert msecs to jiffies where needed
Date:   Mon, 26 Jun 2023 18:14:29 +0300
Message-ID: <20230626151636.314868-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'mod_timer()' assumes expire time in jiffies and not milliseconds,
'msecs_to_jiffies()' should be used in 'ath10k_pci_rx_post_pipe()' and
'ath10k_snoc_rx_post_pipe()'.

This patch also introduces a minor refactoring and fixes number of loop
iterations in 'ath10k_pci_rx_post_pipe()' (I assume that the number of
calls of '__ath10k_pci_rx_post_buf()' should be equal to number of buffers
returned by '__ath10k_ce_rx_num_free_bufs()' and not plus one).

Fixes: a6e149a9ff03 ("ath10k: add hif start/stop methods for wcn3990 snoc layer")
Fixes: 728f95eef523 ("ath10k: rework posting pci rx buffers")

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/pci.c  | 20 ++++++++++----------
 drivers/net/wireless/ath/ath10k/snoc.c | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index a7f44f6335fb..18eca7a2154a 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -818,17 +818,17 @@ static void ath10k_pci_rx_post_pipe(struct ath10k_pci_pipe *pipe)
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
-			break;
-		}
-		num--;
+		if (unlikely(ret))
+			goto err;
+	}
+	return;
+err:
+	if (ret != -ENOSPC) {
+		ath10k_warn(ar, "failed to post pci rx buf: %d\n", ret);
+		mod_timer(&ar_pci->rx_post_retry, jiffies +
+			  msecs_to_jiffies(ATH10K_PCI_RX_POST_RETRY_MS));
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 26214c00cd0d..9d180d02cc7c 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -544,16 +544,18 @@ static void ath10k_snoc_rx_post_pipe(struct ath10k_snoc_pipe *pipe)
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
-			break;
-		}
+		if (unlikely(ret))
+			goto err;
+	}
+	return;
+err:
+	if (ret != -ENOSPC) {
+		ath10k_warn(ar, "failed to post rx buf: %d\n", ret);
+		mod_timer(&ar_snoc->rx_post_retry, jiffies +
+			  msecs_to_jiffies(ATH10K_SNOC_RX_POST_RETRY_MS));
 	}
 }
 
-- 
2.41.0

