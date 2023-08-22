Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC678465E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 17:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbjHVP4i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjHVP4h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 11:56:37 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F1E4F
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 08:56:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1d9d:0:640:49d1:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 1ADC56003E;
        Tue, 22 Aug 2023 18:56:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4uL3vjKWqKo0-fmblPye8;
        Tue, 22 Aug 2023 18:56:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692719765;
        bh=cojbDnJhgQSIbg/drYDC8Dnm0AV1m+AEuwveaeehzxU=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=EOWl7sBvGRlRLvssG4EDAevBOly6RHilmJOY09dmtbHm1oMpg0uBqew4gAcyrk2ff
         ntCGdCLopiNC/pu8YZA1Y5xvBsCvgPzlBVUPyZDg8EQW3NvpwugD9nl2EV7yErp4hh
         TacF2fmqWCvhjTmR1vA8RD6nz9HQdyw0MISDfqxs=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/3] wifi: ath10k: cleanup CE initialization
Date:   Tue, 22 Aug 2023 18:54:24 +0300
Message-ID: <20230822155532.95983-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 25d0dbcbd5c7 ("ath10k: split ce initialization and allocation")
changes 'ath10k_ce_init_src_ring()' and 'ath10k_ce_init_dest_ring()'
so these functions can't return -ENOMEM but always returns 0. This way
both of the above may be converted to 'void' and related code may be
simplified as well.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/ahb.c  |  6 +---
 drivers/net/wireless/ath/ath10k/ce.c   | 44 +++++++-------------------
 drivers/net/wireless/ath/ath10k/ce.h   |  4 +--
 drivers/net/wireless/ath/ath10k/pci.c  | 29 ++++-------------
 drivers/net/wireless/ath/ath10k/pci.h  |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c | 22 +++----------
 6 files changed, 27 insertions(+), 80 deletions(-)

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
diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index c27b8204718a..73aa3632b23c 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1352,9 +1352,9 @@ void ath10k_ce_enable_interrupts(struct ath10k *ar)
 }
 EXPORT_SYMBOL(ath10k_ce_enable_interrupts);
 
-static int ath10k_ce_init_src_ring(struct ath10k *ar,
-				   unsigned int ce_id,
-				   const struct ce_attr *attr)
+static void ath10k_ce_init_src_ring(struct ath10k *ar,
+				    unsigned int ce_id,
+				    const struct ce_attr *attr)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
@@ -1389,13 +1389,11 @@ static int ath10k_ce_init_src_ring(struct ath10k *ar,
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
 		   "boot init ce src ring id %d entries %d base_addr %pK\n",
 		   ce_id, nentries, src_ring->base_addr_owner_space);
-
-	return 0;
 }
 
-static int ath10k_ce_init_dest_ring(struct ath10k *ar,
-				    unsigned int ce_id,
-				    const struct ce_attr *attr)
+static void ath10k_ce_init_dest_ring(struct ath10k *ar,
+				     unsigned int ce_id,
+				     const struct ce_attr *attr)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
@@ -1427,8 +1425,6 @@ static int ath10k_ce_init_dest_ring(struct ath10k *ar,
 	ath10k_dbg(ar, ATH10K_DBG_BOOT,
 		   "boot ce dest ring id %d entries %d base_addr %pK\n",
 		   ce_id, nentries, dest_ring->base_addr_owner_space);
-
-	return 0;
 }
 
 static int ath10k_ce_alloc_shadow_base(struct ath10k *ar,
@@ -1659,30 +1655,14 @@ ath10k_ce_alloc_dest_ring_64(struct ath10k *ar, unsigned int ce_id,
  * initialization. It may be that only one side or the other is
  * initialized by software/firmware.
  */
-int ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
-			const struct ce_attr *attr)
+void ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
+			 const struct ce_attr *attr)
 {
-	int ret;
-
-	if (attr->src_nentries) {
-		ret = ath10k_ce_init_src_ring(ar, ce_id, attr);
-		if (ret) {
-			ath10k_err(ar, "Failed to initialize CE src ring for ID: %d (%d)\n",
-				   ce_id, ret);
-			return ret;
-		}
-	}
-
-	if (attr->dest_nentries) {
-		ret = ath10k_ce_init_dest_ring(ar, ce_id, attr);
-		if (ret) {
-			ath10k_err(ar, "Failed to initialize CE dest ring for ID: %d (%d)\n",
-				   ce_id, ret);
-			return ret;
-		}
-	}
+	if (attr->src_nentries)
+		ath10k_ce_init_src_ring(ar, ce_id, attr);
 
-	return 0;
+	if (attr->dest_nentries)
+		ath10k_ce_init_dest_ring(ar, ce_id, attr);
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
index a7f44f6335fb..f6988075cd83 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -2524,21 +2524,13 @@ void ath10k_pci_free_pipes(struct ath10k *ar)
 		ath10k_ce_free_pipe(ar, i);
 }
 
-int ath10k_pci_init_pipes(struct ath10k *ar)
+void ath10k_pci_init_pipes(struct ath10k *ar)
 {
 	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
-	int i, ret;
-
-	for (i = 0; i < CE_COUNT; i++) {
-		ret = ath10k_ce_init_pipe(ar, i, &ar_pci->attr[i]);
-		if (ret) {
-			ath10k_err(ar, "failed to initialize copy engine pipe %d: %d\n",
-				   i, ret);
-			return ret;
-		}
-	}
+	int i;
 
-	return 0;
+	for (i = 0; i < CE_COUNT; i++)
+		ath10k_ce_init_pipe(ar, i, &ar_pci->attr[i]);
 }
 
 static bool ath10k_pci_has_fw_crashed(struct ath10k *ar)
@@ -2703,12 +2695,7 @@ static int ath10k_pci_qca988x_chip_reset(struct ath10k *ar)
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
@@ -2846,11 +2833,7 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
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
index 26214c00cd0d..ff902413ede2 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -939,20 +939,12 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
 	return 0;
 }
 
-static int ath10k_snoc_init_pipes(struct ath10k *ar)
+static void ath10k_snoc_init_pipes(struct ath10k *ar)
 {
-	int i, ret;
-
-	for (i = 0; i < CE_COUNT; i++) {
-		ret = ath10k_ce_init_pipe(ar, i, &host_ce_config_wlan[i]);
-		if (ret) {
-			ath10k_err(ar, "failed to initialize copy engine pipe %d: %d\n",
-				   i, ret);
-			return ret;
-		}
-	}
+	int i;
 
-	return 0;
+	for (i = 0; i < CE_COUNT; i++)
+		ath10k_ce_init_pipe(ar, i, &host_ce_config_wlan[i]);
 }
 
 static int ath10k_snoc_wlan_enable(struct ath10k *ar,
@@ -1084,11 +1076,7 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 
 	ath10k_ce_alloc_rri(ar);
 
-	ret = ath10k_snoc_init_pipes(ar);
-	if (ret) {
-		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
-		goto err_free_rri;
-	}
+	ath10k_snoc_init_pipes(ar);
 
 	return 0;
 
-- 
2.41.0

