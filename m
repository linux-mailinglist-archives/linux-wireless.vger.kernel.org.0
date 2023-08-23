Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119187854A5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHWJxm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 05:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbjHWJwX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 05:52:23 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAAA1FC2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 02:50:27 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3990:0:640:62ef:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 119A5600AD;
        Wed, 23 Aug 2023 12:50:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LoGi0T0DTa60-mM2RRM5c;
        Wed, 23 Aug 2023 12:50:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692784222;
        bh=AHxyg2buGg4i9ktGXN+yJXpIvRq865XuIpLyG1eNerQ=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=WIKlaRPdCBMxw24b72XlsKoALRh2MBXKfPEJyHA/QYzyX9UDM8Rew/ph56tPW8T6i
         kYfIjO6a8vPjNt7N8KHwJpEksVYEgdCx4FPbLEXeCMztRwsIJPtkxSeogu+n81xVbm
         kim6Z1N0Mu9dMGLnIgUBSA86ewp3gB2/+NQTF3V8=
Authentication-Results: mail-nwsmtp-smtp-production-main-22.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: ath10k: cleanup CE initialization
Date:   Wed, 23 Aug 2023 12:50:03 +0300
Message-ID: <20230823095008.50515-1-dmantipov@yandex.ru>
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
v2: change 'ath10k_ce_alloc_rri()' to return -ENOMEM in case
of 'dma_alloc_coherent()' failure and fix error handling in
'ath10k_snoc_hif_power_up()'
---
 drivers/net/wireless/ath/ath10k/ahb.c  |  6 +---
 drivers/net/wireless/ath/ath10k/ce.c   | 50 +++++++++-----------------
 drivers/net/wireless/ath/ath10k/ce.h   |  6 ++--
 drivers/net/wireless/ath/ath10k/pci.c  | 29 ++++-----------
 drivers/net/wireless/ath/ath10k/pci.h  |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c | 30 +++++-----------
 6 files changed, 36 insertions(+), 87 deletions(-)

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
index c27b8204718a..d7275dcc1f99 100644
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
 
@@ -1926,7 +1906,7 @@ int ath10k_ce_alloc_pipe(struct ath10k *ar, int ce_id,
 }
 EXPORT_SYMBOL(ath10k_ce_alloc_pipe);
 
-void ath10k_ce_alloc_rri(struct ath10k *ar)
+int ath10k_ce_alloc_rri(struct ath10k *ar)
 {
 	int i;
 	u32 value;
@@ -1939,7 +1919,7 @@ void ath10k_ce_alloc_rri(struct ath10k *ar)
 					   &ce->paddr_rri, GFP_KERNEL);
 
 	if (!ce->vaddr_rri)
-		return;
+		return -ENOMEM;
 
 	ath10k_ce_write32(ar, ar->hw_ce_regs->ce_rri_low,
 			  lower_32_bits(ce->paddr_rri));
@@ -1954,6 +1934,8 @@ void ath10k_ce_alloc_rri(struct ath10k *ar)
 		value |= ar->hw_ce_regs->upd->mask;
 		ath10k_ce_write32(ar, ce_base_addr + ctrl1_regs, value);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL(ath10k_ce_alloc_rri);
 
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index 666ce384a1d8..c90c00316356 100644
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
@@ -262,7 +262,7 @@ void ath10k_ce_enable_interrupts(struct ath10k *ar);
 void ath10k_ce_dump_registers(struct ath10k *ar,
 			      struct ath10k_fw_crash_data *crash_data);
 
-void ath10k_ce_alloc_rri(struct ath10k *ar);
+int ath10k_ce_alloc_rri(struct ath10k *ar);
 void ath10k_ce_free_rri(struct ath10k *ar);
 
 /* ce_attr.flags values */
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
index 26214c00cd0d..f41948d9eebb 100644
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
@@ -1082,18 +1074,14 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 		goto err_hw_power_off;
 	}
 
-	ath10k_ce_alloc_rri(ar);
-
-	ret = ath10k_snoc_init_pipes(ar);
-	if (ret) {
-		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
-		goto err_free_rri;
-	}
+	ret = ath10k_ce_alloc_rri(ar);
+	if (ret)
+		goto err_snoc_wlan_disable;
 
+	ath10k_snoc_init_pipes(ar);
 	return 0;
 
-err_free_rri:
-	ath10k_ce_free_rri(ar);
+err_snoc_wlan_disable:
 	ath10k_snoc_wlan_disable(ar);
 
 err_hw_power_off:
-- 
2.41.0

