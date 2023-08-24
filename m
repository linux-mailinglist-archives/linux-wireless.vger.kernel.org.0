Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC8786740
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 07:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjHXFyd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 01:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbjHXFyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 01:54:14 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086A10EF
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 22:54:08 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:287:0:640:7dd6:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 53A39600FB;
        Thu, 24 Aug 2023 08:54:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3sDNeg0WnqM0-4iySjM7O;
        Thu, 24 Aug 2023 08:54:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692856446;
        bh=V867+j81x5Cd4WaPkN/obRGwvMqMHZZAGTghdHDCViQ=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ZTvw8psG3FY68c+HA23jD5S9h0RQpY1YoUFokRrHweacUfWapqAT5vJxfloHzNCu0
         GPh64xpgeTf+JKQ8N5viAWiL1kRl5X60f5Z2Ce9k0tQ65hGJUWWR1PQINUQnNuzrDi
         zN77XYNHRNS9sCLu+U7nX9avY61t0LUO6r2myvNg=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/6] [v3] wifi: ath10k: cleanup CE pipes initialization
Date:   Thu, 24 Aug 2023 08:51:08 +0300
Message-ID: <20230824055117.42309-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824055117.42309-1-dmantipov@yandex.ru>
References: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
 <20230824055117.42309-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert 'ath10k_pci_init_pipes()' and 'ath10k_snoc_init_pipes()'
to 'void' and thus simplify 'ath10k_ahb_hif_power_up()',
'ath10k_pci_qca988x_chip_reset()' and 'ath10k_snoc_hif_power_up()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: split from the larger v2 patch
---
 drivers/net/wireless/ath/ath10k/ahb.c  |  6 +-----
 drivers/net/wireless/ath/ath10k/pci.c  | 17 +++--------------
 drivers/net/wireless/ath/ath10k/pci.h  |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c | 16 ++--------------
 4 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index 76efea2f1138..c3a2eeb5542d 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -655,11 +655,7 @@ static int ath10k_ahb_hif_power_up(struct ath10k *ar,
 		goto out;
 	}
 
-	ret = ath10k_pci_init_pipes(ar);
-	if (ret) {
-		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
-		goto out;
-	}
+	ath10k_pci_init_pipes(ar);
 
 	ret = ath10k_pci_init_config(ar);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 8e05326400bb..f6988075cd83 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -2524,15 +2524,13 @@ void ath10k_pci_free_pipes(struct ath10k *ar)
 		ath10k_ce_free_pipe(ar, i);
 }
 
-int ath10k_pci_init_pipes(struct ath10k *ar)
+void ath10k_pci_init_pipes(struct ath10k *ar)
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
 	int i;
 
 	for (i = 0; i < CE_COUNT; i++)
 		ath10k_ce_init_pipe(ar, i, &ar_pci->attr[i]);
-
-	return 0;
 }
 
 static bool ath10k_pci_has_fw_crashed(struct ath10k *ar)
@@ -2697,12 +2695,7 @@ static int ath10k_pci_qca988x_chip_reset(struct ath10k *ar)
 		 * sufficient to verify if device is capable of booting
 		 * firmware blob.
 		 */
-		ret = ath10k_pci_init_pipes(ar);
-		if (ret) {
-			ath10k_warn(ar, "failed to init copy engine: %d\n",
-				    ret);
-			continue;
-		}
+		ath10k_pci_init_pipes(ar);
 
 		ret = ath10k_pci_diag_read32(ar, QCA988X_HOST_INTEREST_ADDRESS,
 					     &val);
@@ -2840,11 +2833,7 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
 		goto err_sleep;
 	}
 
-	ret = ath10k_pci_init_pipes(ar);
-	if (ret) {
-		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
-		goto err_sleep;
-	}
+	ath10k_pci_init_pipes(ar);
 
 	ret = ath10k_pci_init_config(ar);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath10k/pci.h b/drivers/net/wireless/ath/ath10k/pci.h
index 480cd97ab739..3b3ded87aef9 100644
--- a/drivers/net/wireless/ath/ath10k/pci.h
+++ b/drivers/net/wireless/ath/ath10k/pci.h
@@ -238,7 +238,7 @@ void ath10k_pci_free_pipes(struct ath10k *ar);
 void ath10k_pci_rx_replenish_retry(struct timer_list *t);
 void ath10k_pci_ce_deinit(struct ath10k *ar);
 void ath10k_pci_init_napi(struct ath10k *ar);
-int ath10k_pci_init_pipes(struct ath10k *ar);
+void ath10k_pci_init_pipes(struct ath10k *ar);
 int ath10k_pci_init_config(struct ath10k *ar);
 void ath10k_pci_rx_post(struct ath10k *ar);
 void ath10k_pci_flush(struct ath10k *ar);
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 4f835ad60080..815df15f58fb 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -939,14 +939,12 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 	return 0;
 }
 
-static int ath10k_snoc_init_pipes(struct ath10k *ar)
+static void ath10k_snoc_init_pipes(struct ath10k *ar)
 {
 	int i;
 
 	for (i = 0; i < CE_COUNT; i++)
 		ath10k_ce_init_pipe(ar, i, &host_ce_config_wlan[i]);
-
-	return 0;
 }
 
 static int ath10k_snoc_wlan_enable(struct ath10k *ar,
@@ -1078,17 +1076,7 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 
 	ath10k_ce_alloc_rri(ar);
 
-	ret = ath10k_snoc_init_pipes(ar);
-	if (ret) {
-		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
-		goto err_free_rri;
-	}
-
-	return 0;
-
-err_free_rri:
-	ath10k_ce_free_rri(ar);
-	ath10k_snoc_wlan_disable(ar);
+	ath10k_snoc_init_pipes(ar);
 
 err_hw_power_off:
 	ath10k_hw_power_off(ar);
-- 
2.41.0

