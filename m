Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA8187C15
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 10:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgCQJct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 05:32:49 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:35119 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgCQJct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 05:32:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584437568; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=okike3V1m4hC5lo8aMTQpeWZXWdG5dVaQ9XdEH/Vd0o=; b=KPuIVXh/sxWtvAugsCrh5eNvCfIFkzq5aBcbB8DEC5fhooZ4QZODwTHfob43q3bJ2WIYykRa
 7ad+HDsk2dqRsuk10pP+REnCNPm1Hk53q9zmYRmbMfJ6vP+ILqJht49NOhbiE7JAQK+kaUZ6
 gfaNlbBRxv0pxVw7tlAg8xKgMys=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e709933.7ff2f6321298-smtp-out-n02;
 Tue, 17 Mar 2020 09:32:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 604F0C433BA; Tue, 17 Mar 2020 09:32:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mpubbise)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 439B6C433CB;
        Tue, 17 Mar 2020 09:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 439B6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mpubbise@codeaurora.org
From:   Manikanta Pubbisetty <mpubbise@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: dump SRNG stats during FW assert
Date:   Tue, 17 Mar 2020 15:02:14 +0530
Message-Id: <1584437534-7521-1-git-send-email-mpubbise@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dumping the SRNG stats during FW assert, this would help
in debugging ring stuck issues.

Co-developed-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  6 ++++
 drivers/net/wireless/ath/ath11k/ce.h   |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hal.c  | 66 ++++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/hal.h  |  9 +++++
 drivers/net/wireless/ath/ath11k/qmi.c  |  1 +
 6 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index e7e3e64..eab7ed6 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -681,6 +681,9 @@ static irqreturn_t ath11k_ahb_ce_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ce_pipe *ce_pipe = arg;
 
+	/* last interrupt received for this CE */
+	ce_pipe->timestamp = jiffies;
+
 	ath11k_ahb_ce_irq_disable(ce_pipe->ab, ce_pipe->pipe_num);
 
 	tasklet_schedule(&ce_pipe->intr_tq);
@@ -712,6 +715,9 @@ static irqreturn_t ath11k_ahb_ext_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ext_irq_grp *irq_grp = arg;
 
+	/* last interrupt received for this group */
+	irq_grp->timestamp = jiffies;
+
 	ath11k_ahb_ext_grp_disable(irq_grp);
 
 	napi_schedule(&irq_grp->napi);
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index e355dfda..688f357 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -161,6 +161,7 @@ struct ath11k_ce_pipe {
 	struct ath11k_ce_ring *src_ring;
 	struct ath11k_ce_ring *dest_ring;
 	struct ath11k_ce_ring *status_ring;
+	u64 timestamp;
 };
 
 struct ath11k_ce {
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index af04e12..83f1f77 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -110,6 +110,7 @@ struct ath11k_ext_irq_grp {
 	u32 irqs[ATH11K_EXT_IRQ_NUM_MAX];
 	u32 num_irq;
 	u32 grp_id;
+	u64 timestamp;
 	struct napi_struct napi;
 	struct net_device napi_ndev;
 	/* Queue of pending packets, not expected to be accessed concurrently
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index b58ac11..9e40c4b 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -877,23 +877,32 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 		/* For LMAC rings, ring pointer updates are done through FW and
 		 * hence written to a shared memory location that is read by FW
 		 */
-		if (srng->ring_dir == HAL_SRNG_DIR_SRC)
+		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
+			srng->u.src_ring.last_tp =
+				*(volatile u32 *)srng->u.src_ring.tp_addr;
 			*srng->u.src_ring.hp_addr = srng->u.src_ring.hp;
-		else
+		} else {
+			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
 			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
+		}
 	} else {
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
+			srng->u.src_ring.last_tp =
+				*(volatile u32 *)srng->u.src_ring.tp_addr;
 			ath11k_ahb_write32(ab,
 					   (unsigned long)srng->u.src_ring.hp_addr -
 					   (unsigned long)ab->mem,
 					   srng->u.src_ring.hp);
 		} else {
+			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
 			ath11k_ahb_write32(ab,
 					   (unsigned long)srng->u.dst_ring.tp_addr -
 					   (unsigned long)ab->mem,
 					   srng->u.dst_ring.tp);
 		}
 	}
+
+	srng->timestamp = jiffies;
 }
 
 void ath11k_hal_setup_link_idle_list(struct ath11k_base *ab,
@@ -1017,6 +1026,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 				params->intr_batch_cntr_thres_entries;
 	srng->intr_timer_thres_us = params->intr_timer_thres_us;
 	srng->flags = params->flags;
+	srng->initialized = 1;
 	spin_lock_init(&srng->lock);
 
 	for (i = 0; i < HAL_SRNG_NUM_REG_GRP; i++) {
@@ -1122,3 +1132,55 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
 	ath11k_hal_free_cont_rdp(ab);
 	ath11k_hal_free_cont_wrp(ab);
 }
+
+void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
+{
+	struct hal_srng *srng;
+	struct ath11k_ext_irq_grp *irq_grp;
+	struct ath11k_ce_pipe *ce_pipe;
+	int i;
+
+	ath11k_err(ab, "Last interrupt received for each CE:\n");
+	for (i = 0; i < CE_COUNT; i++) {
+		ce_pipe = &ab->ce.ce_pipe[i];
+
+		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		ath11k_err(ab, "CE_id %d pipe_num %d %ums before\n",
+			   i, ce_pipe->pipe_num,
+			   jiffies_to_msecs(jiffies - ce_pipe->timestamp));
+	}
+
+	ath11k_err(ab, "\nLast interrupt received for each group:\n");
+	for (i = 0; i < ATH11K_EXT_IRQ_GRP_NUM_MAX; i++) {
+		irq_grp = &ab->ext_irq_grp[i];
+		ath11k_err(ab, "group_id %d %ums before\n",
+			   irq_grp->grp_id,
+			   jiffies_to_msecs(jiffies - irq_grp->timestamp));
+	}
+
+	for (i = 0; i < HAL_SRNG_RING_ID_MAX; i++) {
+		srng = &ab->hal.srng_list[i];
+
+		if (!srng->initialized)
+			continue;
+
+		if (srng->ring_dir == HAL_SRNG_DIR_SRC)
+			ath11k_err(ab,
+				   "src srng id %u hp %u, reap_hp %u, cur tp %u, cached tp %u last tp %u napi processed before %ums\n",
+				   srng->ring_id, srng->u.src_ring.hp,
+				   srng->u.src_ring.reap_hp,
+				   *srng->u.src_ring.tp_addr, srng->u.src_ring.cached_tp,
+				   srng->u.src_ring.last_tp,
+				   jiffies_to_msecs(jiffies - srng->timestamp));
+		else if (srng->ring_dir == HAL_SRNG_DIR_DST)
+			ath11k_err(ab,
+				   "dst srng id %u tp %u, cur hp %u, cached hp %u last hp %u napi processed before %ums\n",
+				   srng->ring_id, srng->u.dst_ring.tp,
+				   *srng->u.dst_ring.hp_addr,
+				   srng->u.dst_ring.cached_hp,
+				   srng->u.dst_ring.last_hp,
+				   jiffies_to_msecs(jiffies - srng->timestamp));
+	}
+}
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 4cfd934..36df374 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -529,6 +529,8 @@ struct hal_srng {
 	 */
 	u32 hwreg_base[HAL_SRNG_NUM_REG_GRP];
 
+	u64 timestamp;
+
 	/* Source or Destination ring */
 	enum hal_srng_dir ring_dir;
 
@@ -554,6 +556,9 @@ struct hal_srng {
 
 			/* max transfer size */
 			u16 max_buffer_length;
+
+			/* head pointer at access end */
+			u32 last_hp;
 		} dst_ring;
 
 		struct {
@@ -577,6 +582,9 @@ struct hal_srng {
 
 			/* Low threshold - in number of ring entries */
 			u32 low_threshold;
+
+			/* tail pointer at access end */
+			u32 last_tp;
 		} src_ring;
 	} u;
 };
@@ -893,5 +901,6 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
 			  struct hal_srng_params *params);
 int ath11k_hal_srng_init(struct ath11k_base *ath11k);
 void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
+void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
 
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 2377895..c00a99a 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2365,6 +2365,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 			break;
 		case ATH11K_QMI_EVENT_FW_READY:
 			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
+				ath11k_hal_dump_srng_stats(ab);
 				queue_work(ab->workqueue, &ab->restart_work);
 				break;
 			}
-- 
2.7.4
