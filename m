Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE652AB3C5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgKIJmH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:42:07 -0500
Received: from z5.mailgun.us ([104.130.96.5]:56040 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgKIJmH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:42:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604914926; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VAjQDhllXNOlJ2zLAVbJ9DlvJwOUb2Wya7nVD0hZfWA=; b=GuGM3644zBekb/ITo9vlfzN3Xxuu2n0mVnmrrgGUh3n9xWBotMZ2mUFjLnbVZinGkZwYVK1p
 vYhTp6qGp71FeVRPAs6+myuCDUfS8tP6sHW8Zsv0WNWUc9ntm6qepRjNddoRVqx1X4bdFaOC
 LGLUReWz1yOxl7tGI5OEtAphQxo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa90eed61a7f890a6adbdad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 09:42:05
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98A0FC433C6; Mon,  9 Nov 2020 09:42:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ppranees-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D77C9C433C8;
        Mon,  9 Nov 2020 09:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D77C9C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ppranees@codeaurora.org
From:   P Praneesh <ppranees@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>
Subject: [PATCH v3] ath11k: add processor_id based ring_selector logic
Date:   Mon,  9 Nov 2020 15:11:55 +0530
Message-Id: <1604914915-12831-1-git-send-email-ppranees@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Current ring selector logic follows round-robin scheduling,
when a process switch from one processor to another each time,
the data in the cache would have to be invalidated
and re-loaded from RAM leads to poor cache utilization.

Therefore smp_processor_id() attempt to keep processes
on the same processor via processor affinity which improves
cache utilization. Also, ring selection could be chosen round
robin when the processor_id based ring selection does not
have the resources.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00874-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h  | 3 ---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 8 ++++----
 2 files changed, 4 insertions(+), 7 deletions(-)
---
v3: corrected commit log.
v2: corrected tested tags.
---
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 1cd9ef3..c2a4a7d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -714,9 +714,6 @@ struct ath11k_base {
 	} stats;
 	u32 pktlog_defs_checksum;
 
-	/* Round robbin based TCL ring selector */
-	atomic_t tcl_ring_selector;
-
 	struct ath11k_dbring_cap *db_caps;
 	u32 num_db_cap;
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index a9632b7..897c368 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -99,14 +99,14 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	pool_id = skb_get_queue_mapping(skb) & (ATH11K_HW_MAX_QUEUES - 1);
 
-	/* Let the default ring selection be based on a round robin
-	 * fashion where one of the 3 tcl rings are selected based on
-	 * the tcl_ring_selector counter. In case that ring
+	/* Let the default ring selection be based on current processor
+	 * number, where one of the 3 tcl rings are selected based on
+	 * the smp_processor_id(). In case that ring
 	 * is full/busy, we resort to other available rings.
 	 * If all rings are full, we drop the packet.
 	 * //TODO Add throttling logic when all rings are full
 	 */
-	ring_selector = atomic_inc_return(&ab->tcl_ring_selector);
+	ring_selector = smp_processor_id();
 
 tcl_ring_sel:
 	tcl_ring_retry = false;
-- 
2.7.4

