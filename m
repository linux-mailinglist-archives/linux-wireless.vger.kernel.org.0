Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1649DA3B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jan 2022 06:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiA0Fdr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jan 2022 00:33:47 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2542 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbiA0Fdr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jan 2022 00:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643261627; x=1674797627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ab7NghZ+xnLjogVj6QomxLHLTctgOwl/jJKhlfXHZdA=;
  b=dZkXhHqXIWvZpeFQGczqm07GVpNsSF+d/zVbEFSXIUxmU7BH+tg2Tw2g
   XfC1XZCl49qn9RYRenpSJwyZ4uVvJKz6U70DlhIY67tRbH4c/tL4WhKLd
   9Bl+6MpBdBT3LJfiW6uMY9HyPSr08QKirQE6OoI8pWt2mSWfQW1v54oza
   E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jan 2022 21:33:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 21:33:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:46 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 26 Jan 2022 21:33:44 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH RFC 2/8] ath11k: Register shutdown handler for WCN6750
Date:   Thu, 27 Jan 2022 11:03:23 +0530
Message-ID: <1643261609-13500-3-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643261609-13500-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the system shuts down, SMMU driver will be stopped
and will not assist in IOVA translation. SMMU driver expects
all of its consumers to shutdown before shutting down itself.
WCN6750 being one of the consumer should not perform DMA
activity after SMMU shutdown which will otherwise result
in a SMMU fault.

SMMU driver will call the shutdown() callback of all its
consumer devices and the consumers shall stop further DMA
activity after the invocation of their respective shutdown()
callback.

Register the shutdown() callback to the platform core for WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 36 ++++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/qmi.c |  3 +--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 7cb13a0..97ee8c4 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -1069,6 +1069,7 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 
 	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
 	cancel_work_sync(&ab->restart_work);
+	cancel_work_sync(&ab->qmi.event_work);
 
 	ath11k_core_deinit(ab);
 qmi_fail:
@@ -1082,6 +1083,38 @@ static int ath11k_ahb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void ath11k_ahb_shutdown(struct platform_device *pdev)
+{
+	struct ath11k_base *ab = platform_get_drvdata(pdev);
+	unsigned long left;
+
+	reinit_completion(&ab->driver_recovery);
+
+	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags)) {
+		left = wait_for_completion_timeout(&ab->driver_recovery,
+						   ATH11K_AHB_RECOVERY_TIMEOUT);
+		if (!left)
+			ath11k_warn(ab, "failed to receive recovery response completion\n");
+	}
+
+	set_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags);
+	cancel_work_sync(&ab->restart_work);
+	cancel_work_sync(&ab->qmi.event_work);
+
+	if (!(test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)))
+		goto free_resources;
+
+	ath11k_core_deinit(ab);
+
+free_resources:
+	ath11k_ahb_free_irq(ab);
+	ath11k_hal_srng_deinit(ab);
+	ath11k_ahb_fw_resource_deinit(ab);
+	ath11k_ce_free_pipes(ab);
+	ath11k_core_free(ab);
+	platform_set_drvdata(pdev, NULL);
+}
+
 static struct platform_driver ath11k_ahb_driver = {
 	.driver         = {
 		.name   = "ath11k",
@@ -1089,6 +1122,7 @@ static struct platform_driver ath11k_ahb_driver = {
 	},
 	.probe  = ath11k_ahb_probe,
 	.remove = ath11k_ahb_remove,
+	.shutdown = ath11k_ahb_shutdown,
 };
 
 static int ath11k_ahb_init(void)
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 4745ff9..f50c273 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -3185,7 +3185,6 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 void ath11k_qmi_deinit_service(struct ath11k_base *ab)
 {
 	qmi_handle_release(&ab->qmi.handle);
-	cancel_work_sync(&ab->qmi.event_work);
 	destroy_workqueue(ab->qmi.event_wq);
 	ath11k_qmi_m3_free(ab);
 	ath11k_qmi_free_target_mem_chunk(ab);
-- 
2.7.4

