Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1926F244550
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgHNHL1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:11:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:54912 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbgHNHL0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:11:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389086; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UueX7NT6C0mBvDjY7nYGDWZLSv4hvt0bCQ5HzD4nb3o=; b=py+WSDBRu48y2D5LVJbEMlrqj+DcAxfDsiiY0yF+/i6hyUxlyadm5C7rvkhEoHrlvA/DZFzp
 m+Me8auXaj1UWCEcaQbzKlCbsizvnxSEvUsa8BEggf/olBkZ8TrG3QcesInxdIPDLn/ApLl6
 BDrlLXaD4cqWLG06+C7OUVLyoeo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f3638f4d96d28d61eef44bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 35D76C433CB; Fri, 14 Aug 2020 07:10:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 163D9C433C9;
        Fri, 14 Aug 2020 07:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 163D9C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 06/11] ath11k: setup ce tasklet for control path
Date:   Fri, 14 Aug 2020 10:10:25 +0300
Message-Id: <1597389030-13887-7-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

CE srng is used for control path and CE srng processing is done using tasklet
bottom half. Setup ce tasklet initialization and scheduling for control path.

Needed for PCI support.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.c  |   2 +
 drivers/net/wireless/ath/ath11k/ce.h  |   2 +
 drivers/net/wireless/ath/ath11k/pci.c | 116 +++++++++++++++++++++++++++++++---
 3 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index a457fe7f7049..59cb403b8597 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -524,6 +524,7 @@ void ath11k_ce_poll_send_completed(struct ath11k_base *ab, u8 pipe_id)
 	if ((pipe->attr_flags & CE_ATTR_DIS_INTR) && pipe->send_cb)
 		pipe->send_cb(pipe);
 }
+EXPORT_SYMBOL(ath11k_ce_per_engine_service);
 
 int ath11k_ce_send(struct ath11k_base *ab, struct sk_buff *skb, u8 pipe_id,
 		   u16 transfer_id)
@@ -673,6 +674,7 @@ void ath11k_ce_rx_post_buf(struct ath11k_base *ab)
 		}
 	}
 }
+EXPORT_SYMBOL(ath11k_ce_rx_post_buf);
 
 void ath11k_ce_rx_replenish_retry(struct timer_list *t)
 {
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index 688f357e6eaf..6e3a37909ade 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -181,4 +181,6 @@ int ath11k_ce_alloc_pipes(struct ath11k_base *ab);
 void ath11k_ce_free_pipes(struct ath11k_base *ab);
 int ath11k_ce_get_attr_flags(int ce_id);
 void ath11k_ce_poll_send_completed(struct ath11k_base *ab, u8 pipe_id);
+int ath11k_ce_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+				  u8 *ul_pipe, u8 *dl_pipe);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index af08f0542867..d5dcbb928baf 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -401,6 +401,14 @@ static void ath11k_pci_free_irq(struct ath11k_base *ab)
 	}
 }
 
+static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
+{
+	u32 irq_idx;
+
+	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
+	enable_irq(ab->irq_num[irq_idx]);
+}
+
 static void ath11k_pci_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
 {
 	u32 irq_idx;
@@ -409,11 +417,46 @@ static void ath11k_pci_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
 	disable_irq_nosync(ab->irq_num[irq_idx]);
 }
 
+static void ath11k_pci_ce_irqs_disable(struct ath11k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < CE_COUNT; i++) {
+		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+			continue;
+		ath11k_pci_ce_irq_disable(ab, i);
+	}
+}
+
+static void ath11k_pci_sync_ce_irqs(struct ath11k_base *ab)
+{
+	int i;
+	int irq_idx;
+
+	for (i = 0; i < CE_COUNT; i++) {
+		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
+		synchronize_irq(ab->irq_num[irq_idx]);
+	}
+}
+
+static void ath11k_pci_ce_tasklet(unsigned long data)
+{
+	struct ath11k_ce_pipe *ce_pipe = (struct ath11k_ce_pipe *)data;
+
+	ath11k_ce_per_engine_service(ce_pipe->ab, ce_pipe->pipe_num);
+
+	ath11k_pci_ce_irq_enable(ce_pipe->ab, ce_pipe->pipe_num);
+}
+
 static irqreturn_t ath11k_pci_ce_interrupt_handler(int irq, void *arg)
 {
 	struct ath11k_ce_pipe *ce_pipe = arg;
 
 	ath11k_pci_ce_irq_disable(ce_pipe->ab, ce_pipe->pipe_num);
+	tasklet_schedule(&ce_pipe->intr_tq);
 
 	return IRQ_HANDLED;
 }
@@ -444,6 +487,9 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 
 		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
 
+		tasklet_init(&ce_pipe->intr_tq, ath11k_pci_ce_tasklet,
+			     (unsigned long)ce_pipe);
+
 		ret = request_irq(irq, ath11k_pci_ce_interrupt_handler,
 				  IRQF_SHARED, irq_name[irq_idx],
 				  ce_pipe);
@@ -471,14 +517,6 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 	ab->qmi.service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390;
 }
 
-static void ath11k_pci_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
-{
-	u32 irq_idx;
-
-	irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + ce_id;
-	enable_irq(ab->irq_num[irq_idx]);
-}
-
 static void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
 {
 	int i;
@@ -638,14 +676,75 @@ static void ath11k_pci_power_down(struct ath11k_base *ab)
 	ath11k_mhi_stop(ab_pci);
 }
 
+static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
+{
+	int i;
+
+	for (i = 0; i < CE_COUNT; i++) {
+		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
+
+		if (ath11k_ce_get_attr_flags(i) & CE_ATTR_DIS_INTR)
+			continue;
+
+		tasklet_kill(&ce_pipe->intr_tq);
+	}
+}
+
 static void ath11k_pci_stop(struct ath11k_base *ab)
 {
+	ath11k_pci_ce_irqs_disable(ab);
+	ath11k_pci_sync_ce_irqs(ab);
+	ath11k_pci_kill_tasklets(ab);
 	ath11k_ce_cleanup_pipes(ab);
 }
 
 static int ath11k_pci_start(struct ath11k_base *ab)
 {
 	ath11k_pci_ce_irqs_enable(ab);
+	ath11k_ce_rx_post_buf(ab);
+
+	return 0;
+}
+
+static int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
+					  u8 *ul_pipe, u8 *dl_pipe)
+{
+	const struct service_to_pipe *entry;
+	bool ul_set = false, dl_set = false;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(target_service_to_ce_map_wlan); i++) {
+		entry = &target_service_to_ce_map_wlan[i];
+
+		if (__le32_to_cpu(entry->service_id) != service_id)
+			continue;
+
+		switch (__le32_to_cpu(entry->pipedir)) {
+		case PIPEDIR_NONE:
+			break;
+		case PIPEDIR_IN:
+			WARN_ON(dl_set);
+			*dl_pipe = __le32_to_cpu(entry->pipenum);
+			dl_set = true;
+			break;
+		case PIPEDIR_OUT:
+			WARN_ON(ul_set);
+			*ul_pipe = __le32_to_cpu(entry->pipenum);
+			ul_set = true;
+			break;
+		case PIPEDIR_INOUT:
+			WARN_ON(dl_set);
+			WARN_ON(ul_set);
+			*dl_pipe = __le32_to_cpu(entry->pipenum);
+			*ul_pipe = __le32_to_cpu(entry->pipenum);
+			dl_set = true;
+			ul_set = true;
+			break;
+		}
+	}
+
+	if (WARN_ON(!ul_set || !dl_set))
+		return -ENOENT;
 
 	return 0;
 }
@@ -659,6 +758,7 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.power_up = ath11k_pci_power_up,
 	.get_msi_address =  ath11k_pci_get_msi_address,
 	.get_user_msi_vector = ath11k_get_user_msi_assignment,
+	.map_service_to_pipe = ath11k_pci_map_service_to_pipe,
 };
 
 static int ath11k_pci_probe(struct pci_dev *pdev,
-- 
2.7.4

