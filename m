Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0E57B7E1
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiGTNtc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiGTNtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:49:31 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ECC5F98C
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658324970; x=1689860970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Luffi8Hk7UDy9ZDtGfNl3xBLWLmljerJ/dWknoJXS2U=;
  b=wRb9EoZotsNKigtvJODoD41mXq2JXo3+ZIPPxgO++KJw2vWR7BVublv3
   5Z4g4fo1aSflRoyhYm5+vfIGyDzvymgK+2lwv8HUMvQj12lgg/VtbL73n
   +0u3GnRv+pMM2SEGL897lmyN+0kgsEIfXN/ra/vKNwXdv8xWzEYwuLmMS
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jul 2022 06:49:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:49:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:49:29 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:49:27 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 2/2] ath11k: Add cold boot calibration support on WCN6750
Date:   Wed, 20 Jul 2022 19:19:09 +0530
Message-ID: <20220720134909.15626-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720134909.15626-1-quic_mpubbise@quicinc.com>
References: <20220720134909.15626-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add cold boot calibration support on WCN6750. Unlike other
chipsets where firmware(FW)  is restarted after cold boot
calibration is completed, it is recommended not to restart
the firmware for WCN6750.

For WCN6750, FW sends both CAL_DONE & FW_READY QMI indication
to the driver after cold boot calibration is completed.

QMI message flow for WCN6750 with cold boot support:
FW_INIT_DONE to HOST -> CALIBRATION Mode to FW -> CAL_DONE to Host ->
FW_READY to Host -> MODE_ON to FW

QMI message flow for other chipsets with cold boot support:
FW_INIT_DONE to Host -> CALIBRATION Mode to FW -> FW_READY to Host ->
Trigger FW restart -> FW_INIT_DONE to HOST -> MODE_ON to FW

QMI message flow for chipsets without cold boot support:
FW_INIT_DONE to Host -> MODE_ON to FW

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  3 ++-
 drivers/net/wireless/ath/ath11k/core.c |  9 ++++++++-
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/qmi.c  | 22 ++++++++++++++++++++--
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index d7d33d5cdfc5..11769f10cc07 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -361,7 +361,8 @@ static int ath11k_ahb_fwreset_from_cold_boot(struct ath11k_base *ab)
 	int timeout;
 
 	if (ath11k_cold_boot_cal == 0 || ab->qmi.cal_done ||
-	    ab->hw_params.cold_boot_calib == 0)
+	    ab->hw_params.cold_boot_calib == 0 ||
+	    ab->hw_params.cbcal_restart_fw == 0)
 		return 0;
 
 	ath11k_dbg(ab, ATH11K_DBG_AHB, "wait for cold boot done\n");
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c8e0bc935838..5930f7c0b51a 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -84,6 +84,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.supports_sta_ps = false,
 		.cold_boot_calib = true,
+		.cbcal_restart_fw = true,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
@@ -160,6 +161,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.supports_sta_ps = false,
 		.cold_boot_calib = true,
+		.cbcal_restart_fw = true,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
@@ -235,6 +237,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = true,
 		.supports_sta_ps = true,
 		.cold_boot_calib = false,
+		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
@@ -310,6 +313,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.supports_sta_ps = false,
 		.cold_boot_calib = false,
+		.cbcal_restart_fw = false,
 		.fw_mem_mode = 2,
 		.num_vdevs = 8,
 		.num_peers = 128,
@@ -385,6 +389,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = true,
 		.supports_sta_ps = true,
 		.cold_boot_calib = false,
+		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
@@ -459,6 +464,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = true,
 		.supports_sta_ps = true,
 		.cold_boot_calib = false,
+		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
@@ -532,7 +538,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.supports_sta_ps = true,
-		.cold_boot_calib = false,
+		.cold_boot_calib = true,
+		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
 		.num_vdevs = 16 + 1,
 		.num_peers = 512,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 77dc5c851c9b..5b88fe164a63 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -178,6 +178,7 @@ struct ath11k_hw_params {
 	bool idle_ps;
 	bool supports_sta_ps;
 	bool cold_boot_calib;
+	bool cbcal_restart_fw;
 	int fw_mem_mode;
 	u32 num_vdevs;
 	u32 num_peers;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index e6ced8597e1d..2be45683260c 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3014,8 +3014,10 @@ static void ath11k_qmi_msg_fw_ready_cb(struct qmi_handle *qmi_hdl,
 
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi firmware ready\n");
 
-	ab->qmi.cal_done = 1;
-	wake_up(&ab->qmi.cold_boot_waitq);
+	if (!ab->qmi.cal_done) {
+		ab->qmi.cal_done = 1;
+		wake_up(&ab->qmi.cold_boot_waitq);
+	}
 
 	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_FW_READY, NULL);
 }
@@ -3029,6 +3031,8 @@ static void ath11k_qmi_msg_cold_boot_cal_done_cb(struct qmi_handle *qmi_hdl,
 					      struct ath11k_qmi, handle);
 	struct ath11k_base *ab = qmi->ab;
 
+	ab->qmi.cal_done = 1;
+	wake_up(&ab->qmi.cold_boot_waitq);
 	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi cold boot calibration done\n");
 }
 
@@ -3200,6 +3204,20 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 
 			break;
 		case ATH11K_QMI_EVENT_FW_READY:
+			/* For targets requiring a FW restart upon cold
+			 * boot completion, there is no need to process
+			 * FW ready; such targets will receive FW init
+			 * done message after FW restart.
+			 */
+			if (ab->hw_params.cbcal_restart_fw)
+				break;
+
+			clear_bit(ATH11K_FLAG_CRASH_FLUSH,
+				  &ab->dev_flags);
+			clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+			ath11k_core_qmi_firmware_ready(ab);
+			set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
+
 			break;
 		case ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE:
 			break;
-- 
2.35.1

