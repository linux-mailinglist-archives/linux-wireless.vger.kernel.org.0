Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3D78673D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 07:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjHXFyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 01:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239874AbjHXFyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 01:54:14 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293EF10F3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 22:54:08 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:287:0:640:7dd6:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 95C4B60066;
        Thu, 24 Aug 2023 08:54:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3sDNeg0WnqM0-mityzO2w;
        Thu, 24 Aug 2023 08:54:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692856445;
        bh=v89yO4m1iVXQ5m9RPsFn12Fiawgpo1r61rjyfLEXziM=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=M/FBLPGoz+O3/9N5ib0zNE9YXLjrD9xvVHVdS4YbgsbYHrbuxqk1sQ8V5VH2DRBBk
         nf2Ck8TDUFu2YpS/v5nHBmj6zdJ3mqaSiRjP9EQes8bEWFQxKeCWegFwE+n5dbnU5G
         bzJkkkRn2p5UhgA5FE6DHs7VZ1QViixs4hfKgv58=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/6] [v3] wifi: ath10k: simplify ath10k_ce_init_pipe()
Date:   Thu, 24 Aug 2023 08:51:07 +0300
Message-ID: <20230824055117.42309-2-dmantipov@yandex.ru>
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

Convert 'ath10k_ce_init_pipe()' to return 'void' and thus
simplify 'ath10k_pci_init_pipes()' and 'ath10k_snoc_init_pipes()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: split from the larger v2 patch
---
 drivers/net/wireless/ath/ath10k/ce.c   |  6 ++----
 drivers/net/wireless/ath/ath10k/ce.h   |  4 ++--
 drivers/net/wireless/ath/ath10k/pci.c  | 12 +++---------
 drivers/net/wireless/ath/ath10k/snoc.c | 12 +++---------
 4 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index ace92c636733..73aa3632b23c 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1655,16 +1655,14 @@ ath10k_ce_alloc_dest_ring_64(struct ath10k *ar, unsigned int ce_id,
  * initialization. It may be that only one side or the other is
  * initialized by software/firmware.
  */
-int ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
-			const struct ce_attr *attr)
+void ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
+			 const struct ce_attr *attr)
 {
 	if (attr->src_nentries)
 		ath10k_ce_init_src_ring(ar, ce_id, attr);
 
 	if (attr->dest_nentries)
 		ath10k_ce_init_dest_ring(ar, ce_id, attr);
-
-	return 0;
 }
 EXPORT_SYMBOL(ath10k_ce_init_pipe);
 
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index 666ce384a1d8..a0b408176f7f 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -220,8 +220,8 @@ int ath10k_ce_completed_send_next_nolock(struct ath10k_ce_pipe *ce_state,
 
 /*==================CE Engine Initialization=======================*/
 
-int ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
-			const struct ce_attr *attr);
+void ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
+			 const struct ce_attr *attr);
 void ath10k_ce_deinit_pipe(struct ath10k *ar, unsigned int ce_id);
 int ath10k_ce_alloc_pipe(struct ath10k *ar, int ce_id,
 			 const struct ce_attr *attr);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index a7f44f6335fb..8e05326400bb 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -2527,16 +2527,10 @@ void ath10k_pci_free_pipes(struct ath10k *ar)
 int ath10k_pci_init_pipes(struct ath10k *ar)
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
-	int i, ret;
+	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
-		ret = ath10k_ce_init_pipe(ar, i, &ar_pci->attr[i]);
-		if (ret) {
-			ath10k_err(ar, "failed to initialize copy engine pipe %d: %d\n",
-				   i, ret);
-			return ret;
-		}
-	}
+	for (i = 0; i < CE_COUNT; i++)
+		ath10k_ce_init_pipe(ar, i, &ar_pci->attr[i]);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 26214c00cd0d..4f835ad60080 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -941,16 +941,10 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 
 static int ath10k_snoc_init_pipes(struct ath10k *ar)
 {
-	int i, ret;
+	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
-		ret = ath10k_ce_init_pipe(ar, i, &host_ce_config_wlan[i]);
-		if (ret) {
-			ath10k_err(ar, "failed to initialize copy engine pipe %d: %d\n",
-				   i, ret);
-			return ret;
-		}
-	}
+	for (i = 0; i < CE_COUNT; i++)
+		ath10k_ce_init_pipe(ar, i, &host_ce_config_wlan[i]);
 
 	return 0;
 }
-- 
2.41.0

