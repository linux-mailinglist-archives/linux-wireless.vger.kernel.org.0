Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC7245750
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 13:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgHPL2g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 07:28:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60270 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbgHPL2Q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 07:28:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597577294; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=w0aM1qiRDmjtugm0HbCA+kB8Yx3k5WmO21zhrBwDimc=; b=CFG3gpgdcN85Y15E+fy5gJmbXpVVq1lUeqr1/0YumpYJg5xloxKxQofcPoj211UxaErkEdcF
 VxNim1pPCsbViutxpV6Ls0bBIHDkhQ8ZplHiVd6dgoNaOj9FSTRL6Gqzw9SbelFG3QPd5R95
 O6cQ+pSsHZDE13KsG23tkRk15nA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f3915a4d96d28d61ec54c39 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 11:16:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70AAFC43387; Sun, 16 Aug 2020 11:16:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2F66C433CB;
        Sun, 16 Aug 2020 11:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2F66C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 05/12] ath11k: ce: remove CE_COUNT() macro
Date:   Sun, 16 Aug 2020 14:16:32 +0300
Message-Id: <1597576599-8857-6-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
References: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This macro is evil as it's accesses ab variable in a hidden way. It's better
for readibility to access ab->hw_params.ce_count directly.

This is done in a separate patch to keep the patches simple. No functional changes.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 12 ++++++------
 drivers/net/wireless/ath/ath11k/ce.c  | 12 ++++++------
 drivers/net/wireless/ath/ath11k/ce.h  |  1 -
 drivers/net/wireless/ath/ath11k/hal.c |  2 +-
 drivers/net/wireless/ath/ath11k/htc.c |  2 +-
 drivers/net/wireless/ath/ath11k/pci.c | 12 ++++++------
 6 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 4bc3558fc300..8466c62a83d6 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -384,7 +384,7 @@ static void ath11k_ahb_kill_tasklets(struct ath11k_base *ab)
 {
 	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
 
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
@@ -475,7 +475,7 @@ static void ath11k_ahb_sync_ce_irqs(struct ath11k_base *ab)
 	int i;
 	int irq_idx;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
@@ -503,7 +503,7 @@ static void ath11k_ahb_ce_irqs_enable(struct ath11k_base *ab)
 {
 	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		ath11k_ahb_ce_irq_enable(ab, i);
@@ -514,7 +514,7 @@ static void ath11k_ahb_ce_irqs_disable(struct ath11k_base *ab)
 {
 	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		ath11k_ahb_ce_irq_disable(ab, i);
@@ -601,7 +601,7 @@ static void ath11k_ahb_free_irq(struct ath11k_base *ab)
 	int irq_idx;
 	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		irq_idx = ATH11K_IRQ_CE0_OFFSET + i;
@@ -756,7 +756,7 @@ static int ath11k_ahb_config_irq(struct ath11k_base *ab)
 	int ret;
 
 	/* Configure CE irqs */
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
 
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index c75007e92830..41c1a6e56596 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -718,7 +718,7 @@ void ath11k_ce_cleanup_pipes(struct ath11k_base *ab)
 	struct ath11k_ce_pipe *pipe;
 	int pipe_num;
 
-	for (pipe_num = 0; pipe_num < CE_COUNT; pipe_num++) {
+	for (pipe_num = 0; pipe_num < ab->hw_params.ce_count; pipe_num++) {
 		pipe = &ab->ce.ce_pipe[pipe_num];
 		ath11k_ce_rx_pipe_cleanup(pipe);
 
@@ -736,7 +736,7 @@ void ath11k_ce_rx_post_buf(struct ath11k_base *ab)
 	int i;
 	int ret;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		pipe = &ab->ce.ce_pipe[i];
 		ret = ath11k_ce_rx_post_pipe(pipe);
 		if (ret) {
@@ -767,7 +767,7 @@ int ath11k_ce_init_pipes(struct ath11k_base *ab)
 	int i;
 	int ret;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		pipe = &ab->ce.ce_pipe[i];
 
 		if (pipe->src_ring) {
@@ -825,7 +825,7 @@ void ath11k_ce_free_pipes(struct ath11k_base *ab)
 	int desc_sz;
 	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		pipe = &ab->ce.ce_pipe[i];
 
 		if (pipe->src_ring) {
@@ -874,7 +874,7 @@ int ath11k_ce_alloc_pipes(struct ath11k_base *ab)
 
 	spin_lock_init(&ab->ce.ce_lock);
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		attr = &ab->hw_params.host_ce_config[i];
 		pipe = &ab->ce.ce_pipe[i];
 		pipe->pipe_num = i;
@@ -914,7 +914,7 @@ void ath11k_ce_byte_swap(void *mem, u32 len)
 
 int ath11k_ce_get_attr_flags(struct ath11k_base *ab, int ce_id)
 {
-	if (ce_id >= CE_COUNT)
+	if (ce_id >= ab->hw_params.ce_count)
 		return -EINVAL;
 
 	return ab->hw_params.host_ce_config[ce_id].flags;
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index 8feb6e98ea13..cf704f18f3a1 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -6,7 +6,6 @@
 #ifndef ATH11K_CE_H
 #define ATH11K_CE_H
 
-#define CE_COUNT (ab->hw_params.ce_count)
 #define CE_COUNT_MAX 12
 
 /* Byte swap data words */
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index cca019cc0234..7dcdcc1a72fb 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1157,7 +1157,7 @@ void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
 	int i;
 
 	ath11k_err(ab, "Last interrupt received for each CE:\n");
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		ce_pipe = &ab->ce.ce_pipe[i];
 
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index bc0026c1e4a6..e9e354fc11fa 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -478,7 +478,7 @@ int ath11k_htc_wait_target(struct ath11k_htc *htc)
 	if (!time_left) {
 		ath11k_warn(ab, "failed to receive control response completion, polling..\n");
 
-		for (i = 0; i < CE_COUNT; i++)
+		for (i = 0; i < ab->hw_params.ce_count; i++)
 			ath11k_ce_per_engine_service(htc->ab, i);
 
 		time_left =
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index e4551fb493ff..37bd385348c3 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -393,7 +393,7 @@ static void ath11k_pci_free_irq(struct ath11k_base *ab)
 {
 	int i, irq_idx;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		irq_idx = ATH11K_PCI_IRQ_CE0_OFFSET + i;
@@ -421,7 +421,7 @@ static void ath11k_pci_ce_irqs_disable(struct ath11k_base *ab)
 {
 	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		ath11k_pci_ce_irq_disable(ab, i);
@@ -433,7 +433,7 @@ static void ath11k_pci_sync_ce_irqs(struct ath11k_base *ab)
 	int i;
 	int irq_idx;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 
@@ -477,7 +477,7 @@ static int ath11k_pci_config_irq(struct ath11k_base *ab)
 		return ret;
 
 	/* Configure CE irqs */
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		msi_data = (i % msi_data_count) + msi_irq_start;
 		irq = ath11k_pci_get_msi_irq(ab->dev, msi_data);
 		ce_pipe = &ab->ce.ce_pipe[i];
@@ -521,7 +521,7 @@ static void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
 {
 	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
 			continue;
 		ath11k_pci_ce_irq_enable(ab, i);
@@ -680,7 +680,7 @@ static void ath11k_pci_kill_tasklets(struct ath11k_base *ab)
 {
 	int i;
 
-	for (i = 0; i < CE_COUNT; i++) {
+	for (i = 0; i < ab->hw_params.ce_count; i++) {
 		struct ath11k_ce_pipe *ce_pipe = &ab->ce.ce_pipe[i];
 
 		if (ath11k_ce_get_attr_flags(ab, i) & CE_ATTR_DIS_INTR)
-- 
2.7.4

