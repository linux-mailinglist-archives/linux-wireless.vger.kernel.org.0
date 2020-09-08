Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4CC26093A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 06:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgIHENJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 00:13:09 -0400
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:45048
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgIHENH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 00:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599538386;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=/ATMxhB3ezVMuJNMwFz9YDbvK20gH8TOI5EQE3Y1UZc=;
        b=Ld+DKOCOz/9brNyuRgVmaP00cJIuAATRQRAxB+5anr7LxwErQhk+8e++WGcmSiCH
        BBjNrR3RbRU1WIIyWGz9VEmbFykUcTunfcGRrwRYY+oRGNpYM7l66eSqPtiy4GtnX/O
        yRgWEHZ3bOfnUhqnJuWuQdFrsPL+z6Z2S79eGL6w=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599538386;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=/ATMxhB3ezVMuJNMwFz9YDbvK20gH8TOI5EQE3Y1UZc=;
        b=gmfqOsodvl4kvZKjZxVOb5H+2V7XuhgUVPrGfgqbkDgc2+00zlklxiwTWt8X3zqR
        OMStXcTvabvmkKoaVNveqZiQkhJCjYcByLs4i/aOzr8gYgF6m5Pw9ooDhYZbuOjTO5A
        iHwQEbyN78cC7D9c9be4IwnR4XNcJ4qrmk43B0FU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=2.0 tests=ALL_TRUSTED,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FB44C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v6] ath10k: add atomic protection for device recovery
Date:   Tue, 8 Sep 2020 04:13:06 +0000
Message-ID: <010101746bead6a0-d5e97c66-dedd-4b92-810e-c2e4840fafc9-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.08-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When it has more than one restart_work queued meanwhile, the 2nd
restart_work is very easy to break the 1st restart work and lead
recovery fail.

Add a flag to allow only one restart work running untill
device successfully recovered.

It already has flag ATH10K_FLAG_CRASH_FLUSH, but it can not use this
flag again, because it is clear in ath10k_core_start. The function
ieee80211_reconfig(called by ieee80211_restart_work) of mac80211 do
many things and drv_start(call to ath10k_core_start) is 1st thing,
when drv_start complete, it does not mean restart complete. So it
add new flag and clear it in ath10k_reconfig_complete, because it
is the last thing called from drv_reconfig_complete of function
ieee80211_reconfig, after it, the restart process finished.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v6: change commit log 

v5: change ref count to BIT dev flag, change all
queue_work(ar->workqueue, &ar->restart_work) to ath10k_core_start_recovery

v4: add atomic_dec(&ar->restart_count) if state is not on

v3: change atomic_inc_and_test to atomic_add_return, remove check of ATH10K_STATE_ON

v2: add "add refcount for ath10k_core_restart" and remove ar_sdio->can_recovery
 drivers/net/wireless/ath/ath10k/core.c  | 11 +++++++++++
 drivers/net/wireless/ath/ath10k/core.h  |  4 ++++
 drivers/net/wireless/ath/ath10k/debug.c |  6 +++---
 drivers/net/wireless/ath/ath10k/mac.c   |  1 +
 drivers/net/wireless/ath/ath10k/pci.c   |  2 +-
 drivers/net/wireless/ath/ath10k/sdio.c  |  6 +++---
 drivers/net/wireless/ath/ath10k/snoc.c  |  2 +-
 drivers/net/wireless/ath/ath10k/wmi.c   |  2 +-
 8 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index cfffd20df0cc..a9c3cbb400be 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2277,6 +2277,17 @@ static int ath10k_init_hw_params(struct ath10k *ar)
 	return 0;
 }
 
+void ath10k_core_start_recovery(struct ath10k *ar)
+{
+	if (test_and_set_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags)) {
+		ath10k_warn(ar, "already restarting\n");
+		return;
+	}
+
+	queue_work(ar->workqueue, &ar->restart_work);
+}
+EXPORT_SYMBOL(ath10k_core_start_recovery);
+
 static void ath10k_core_restart(struct work_struct *work)
 {
 	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 5c18f6c20462..347137ab7c09 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -837,6 +837,9 @@ enum ath10k_dev_flags {
 
 	/* Per Station statistics service */
 	ATH10K_FLAG_PEER_STATS,
+
+	/* Indicates that ath10k device is during recovery process and not complete */
+	ATH10K_FLAG_RESTARTING,
 };
 
 enum ath10k_cal_mode {
@@ -1291,6 +1294,7 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		      const struct ath10k_fw_components *fw_components);
 int ath10k_wait_for_suspend(struct ath10k *ar, u32 suspend_opt);
 void ath10k_core_stop(struct ath10k *ar);
+void ath10k_core_start_recovery(struct ath10k *ar);
 int ath10k_core_register(struct ath10k *ar,
 			 const struct ath10k_bus_params *bus_params);
 void ath10k_core_unregister(struct ath10k *ar);
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index e8250a665433..6b6dde513bab 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -583,7 +583,7 @@ static ssize_t ath10k_write_simulate_fw_crash(struct file *file,
 		ret = ath10k_debug_fw_assert(ar);
 	} else if (!strcmp(buf, "hw-restart")) {
 		ath10k_info(ar, "user requested hw restart\n");
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 		ret = 0;
 	} else {
 		ret = -EINVAL;
@@ -2005,7 +2005,7 @@ static ssize_t ath10k_write_btcoex(struct file *file,
 		}
 	} else {
 		ath10k_info(ar, "restarting firmware due to btcoex change");
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 	}
 
 	if (val)
@@ -2136,7 +2136,7 @@ static ssize_t ath10k_write_peer_stats(struct file *file,
 
 	ath10k_info(ar, "restarting firmware due to Peer stats change");
 
-	queue_work(ar->workqueue, &ar->restart_work);
+	ath10k_core_start_recovery(ar);
 	ret = count;
 
 exit:
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 82b4bf5ba612..9980011feea8 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7268,6 +7268,7 @@ static void ath10k_reconfig_complete(struct ieee80211_hw *hw,
 		ath10k_info(ar, "device successfully recovered\n");
 		ar->state = ATH10K_STATE_ON;
 		ieee80211_wake_queues(ar->hw);
+		clear_bit(ATH10K_FLAG_RESTARTING, &ar->dev_flags);
 	}
 
 	mutex_unlock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 36426efdb2ea..a21b44ea04ab 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1774,7 +1774,7 @@ static void ath10k_pci_fw_dump_work(struct work_struct *work)
 
 	mutex_unlock(&ar->dump_mutex);
 
-	queue_work(ar->workqueue, &ar->restart_work);
+	ath10k_core_start_recovery(ar);
 }
 
 static void ath10k_pci_fw_crashed_dump(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 81ddaafb6721..eef96dd1e1ff 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -561,7 +561,7 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 				    ATH10K_HTC_MBOX_MAX_PAYLOAD_LENGTH);
 			ret = -ENOMEM;
 
-			queue_work(ar->workqueue, &ar->restart_work);
+			ath10k_core_start_recovery(ar);
 			ath10k_warn(ar, "exceeds length, start recovery\n");
 
 			goto err;
@@ -960,7 +960,7 @@ static int ath10k_sdio_mbox_read_int_status(struct ath10k *ar,
 	ret = ath10k_sdio_read(ar, MBOX_HOST_INT_STATUS_ADDRESS,
 			       irq_proc_reg, sizeof(*irq_proc_reg));
 	if (ret) {
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 		ath10k_warn(ar, "read int status fail, start recovery\n");
 		goto out;
 	}
@@ -2501,7 +2501,7 @@ void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
 
 	ath10k_sdio_enable_intrs(ar);
 
-	queue_work(ar->workqueue, &ar->restart_work);
+	ath10k_core_start_recovery(ar);
 }
 
 static int ath10k_sdio_probe(struct sdio_func *func,
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 645ed5f63ef8..9ab696f758bd 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1295,7 +1295,7 @@ int ath10k_snoc_fw_indication(struct ath10k *ar, u64 type)
 	switch (type) {
 	case ATH10K_QMI_EVENT_FW_READY_IND:
 		if (test_bit(ATH10K_SNOC_FLAG_REGISTERED, &ar_snoc->flags)) {
-			queue_work(ar->workqueue, &ar->restart_work);
+			ath10k_core_start_recovery(ar);
 			break;
 		}
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index a81a1ab2de19..c6be27ad7543 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1936,7 +1936,7 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 	if (ret == -EAGAIN) {
 		ath10k_warn(ar, "wmi command %d timeout, restarting hardware\n",
 			    cmd_id);
-		queue_work(ar->workqueue, &ar->restart_work);
+		ath10k_core_start_recovery(ar);
 	}
 
 	return ret;
-- 
2.23.0

