Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCD3290852
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Oct 2020 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407910AbgJPP3H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Oct 2020 11:29:07 -0400
Received: from z5.mailgun.us ([104.130.96.5]:60842 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395514AbgJPP3G (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602862145; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=c7EgPMh9L9fAt7OZdHssjQiWLNMHrGBy1e1FDLDeNUU=; b=kW/ZOwg3C7jvHqz0jbfJX246InRxG+Zzwf0h7T+rcIBlrmmCJsR0H2sOn+l80NaSs1uHZmI6
 QgFzUoWr3ICnpKS3FZyfghrxcExRlFtHQvuny1l9k3uGDPGlDytkak0KCUBY6stc+RDkdve3
 qwrDZ0KT0miqn8G3H7QZb7fXyQo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f89bc2f06d81bc48dc9c543 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 15:28:47
 GMT
Sender: ssreeela=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06044C43385; Fri, 16 Oct 2020 15:28:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ssreeela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C52E0C433CB;
        Fri, 16 Oct 2020 15:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C52E0C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ssreeela@codeaurora.org
From:   Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Subject: [PATCH v4] ath11k: cold boot calibration support
Date:   Fri, 16 Oct 2020 20:58:31 +0530
Message-Id: <1602862111-14063-1-git-send-email-ssreeela@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govindaraj Saminathan <gsamin@codeaurora.org>

cold boot calibration is the process to calibrate all the channels
during the boot-up to avoid the calibration delay during the
channel change.
During the boot-up, firmware started in cold boot calibration mode
Firmware calibrate all channels and generate CalDb(DDR).
Subsequent wifi bringup will reuse the same CalDb.
Firmware is restarted in normal mode to continue the normal operation.

caldb memory address send to firmware through the QMI message.Firmware
use this address to store the caldb data and use it until next reboot.

This will give the improvement during the channel change. But it is
increasing the boot-up time(up to 15sec depend on number of radios).
So if the user want to reduce the boot-up time and accepting for channel
change delay, user can disable this feature using the module param
cold_boot_cal=0.

Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01162-QCAHKSWPL_SILICONZ-1

Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
Co-developed-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
---
v2:
   - Fixed compilations warnings
     Reported-by: kernel test robot <lkp@intel.com>
v3:
   - Rebased
     Added cold_boot_calib flag in hw params to enable cold boot calibration only for supported hardware
v4:
   - Made changes to switch to normal mode on cold boot calibration failure to resume normal operation
     Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 27 ++++++++++++++
 drivers/net/wireless/ath/ath11k/core.c |  4 ++
 drivers/net/wireless/ath/ath11k/core.h |  5 +++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/qmi.c  | 68 ++++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/qmi.h  |  3 ++
 6 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 430723c..c7843f4 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -340,6 +340,31 @@ static void ath11k_ahb_power_down(struct ath11k_base *ab)
 	rproc_shutdown(ab_ahb->tgt_rproc);
 }
 
+static int ath11k_ahb_fwreset_from_cold_boot(struct ath11k_base *ab)
+{
+	int timeout;
+
+	if (ath11k_cold_boot_cal == 0 || ab->qmi.cal_done ||
+	    ab->hw_params.cold_boot_calib == 0)
+		return 0;
+
+	ath11k_dbg(ab, ATH11K_DBG_AHB, "wait for cold boot done\n");
+	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
+				     (ab->qmi.cal_done  == 1),
+				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
+	if (timeout <= 0) {
+		ath11k_cold_boot_cal = 0;
+		ath11k_warn(ab, "Coldboot Calibration failed timed out\n");
+	}
+
+	/* reset the firmware */
+	ath11k_ahb_power_down(ab);
+	ath11k_ahb_power_up(ab);
+
+	ath11k_dbg(ab, ATH11K_DBG_AHB, "exited from cold boot mode\n");
+	return 0;
+}
+
 static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
 {
 	struct ath11k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
@@ -700,6 +725,8 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		goto err_ce_free;
 	}
 
+	ath11k_ahb_fwreset_from_cold_boot(ab);
+
 	return 0;
 
 err_ce_free:
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index ebd6886..1472d54 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -65,6 +65,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
+		.cold_boot_calib = true,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -102,6 +103,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
+		.cold_boot_calib = true,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -138,6 +140,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = false,
 		.supports_shadow_regs = true,
 		.idle_ps = true,
+		.cold_boot_calib = false,
 	},
 };
 
@@ -923,6 +926,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	INIT_LIST_HEAD(&ab->peers);
 	init_waitqueue_head(&ab->peer_mapping_wq);
 	init_waitqueue_head(&ab->wmi_ab.tx_credits_wq);
+	init_waitqueue_head(&ab->qmi.cold_boot_waitq);
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	ab->dev = dev;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 18b9742..7721a33 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -111,8 +111,13 @@ enum ath11k_firmware_mode {
 
 	/* factory tests etc */
 	ATH11K_FIRMWARE_MODE_FTM,
+
+	/* Cold boot calibration */
+	ATH11K_FIRMWARE_MODE_COLD_BOOT = 7,
 };
 
+extern bool ath11k_cold_boot_cal;
+
 #define ATH11K_IRQ_NUM_MAX 52
 #define ATH11K_EXT_IRQ_NUM_MAX	16
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 1dda425..17c4560 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -161,6 +161,7 @@ struct ath11k_hw_params {
 	bool supports_monitor;
 	bool supports_shadow_regs;
 	bool idle_ps;
+	bool cold_boot_calib;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c2b1651..f704617 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -14,6 +14,13 @@
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
 #define HOST_CSTATE_BIT			0x04
 
+bool ath11k_cold_boot_cal = 1;
+EXPORT_SYMBOL(ath11k_cold_boot_cal);
+module_param_named(cold_boot_cal, ath11k_cold_boot_cal, bool, 0644);
+MODULE_PARM_DESC(cold_boot_cal,
+		 "Cold boot will bring down the channel switch time but "
+		 "it will increase the driver load time (enable:1, disable:0)");
+
 static struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
 	{
 		.data_type	= QMI_OPT_FLAG,
@@ -1769,9 +1776,16 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 				ath11k_warn(ab, "qmi mem size is low to load caldata\n");
 				return -EINVAL;
 			}
-			/* TODO ath11k does not support cold boot calibration */
-			ab->qmi.target_mem[idx].paddr = 0;
-			ab->qmi.target_mem[idx].vaddr = NULL;
+
+			if (ath11k_cold_boot_cal && ab->hw_params.cold_boot_calib) {
+				ab->qmi.target_mem[idx].paddr =
+						     ATH11K_QMI_CALDB_ADDRESS;
+				ab->qmi.target_mem[idx].vaddr =
+						     (void *)ATH11K_QMI_CALDB_ADDRESS;
+			} else {
+				ab->qmi.target_mem[idx].paddr = 0;
+				ab->qmi.target_mem[idx].vaddr = NULL;
+			}
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
 			idx++;
@@ -2352,6 +2366,32 @@ int ath11k_qmi_firmware_start(struct ath11k_base *ab,
 	return 0;
 }
 
+static int ath11k_qmi_process_coldboot_calibration(struct ath11k_base *ab)
+{
+	int timeout;
+	int ret;
+
+	ret = ath11k_qmi_wlanfw_mode_send(ab, ATH11K_FIRMWARE_MODE_COLD_BOOT);
+	if (ret < 0) {
+		ath11k_warn(ab, "qmi failed to send wlan fw mode:%d\n", ret);
+		return ret;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "Coldboot calibration wait started\n");
+
+	timeout = wait_event_timeout(ab->qmi.cold_boot_waitq,
+				     (ab->qmi.cal_done  == 1),
+				     ATH11K_COLD_BOOT_FW_RESET_DELAY);
+	if (timeout <= 0) {
+		ath11k_warn(ab, "Coldboot Calibration failed - wait ended\n");
+		return 0;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "Coldboot calibration done\n");
+
+	return 0;
+}
+
 static int
 ath11k_qmi_driver_event_post(struct ath11k_qmi *qmi,
 			     enum ath11k_qmi_event_type type,
@@ -2501,11 +2541,18 @@ static void ath11k_qmi_msg_fw_ready_cb(struct qmi_handle *qmi_hdl,
 	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_FW_READY, NULL);
 }
 
-static void ath11k_qmi_msg_cold_boot_cal_done_cb(struct qmi_handle *qmi,
+static void ath11k_qmi_msg_cold_boot_cal_done_cb(struct qmi_handle *qmi_hdl,
 						 struct sockaddr_qrtr *sq,
 						 struct qmi_txn *txn,
 						 const void *decoded)
 {
+	struct ath11k_qmi *qmi = container_of(qmi_hdl,
+					      struct ath11k_qmi, handle);
+	struct ath11k_base *ab = qmi->ab;
+
+	ab->qmi.cal_done = 1;
+	wake_up(&ab->qmi.cold_boot_waitq);
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi cold boot calibration done\n");
 }
 
 static const struct qmi_msg_handler ath11k_qmi_msg_handlers[] = {
@@ -2618,9 +2665,16 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 				break;
 			}
 
-			ath11k_core_qmi_firmware_ready(ab);
-			ab->qmi.cal_done = 1;
-			set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
+			if (ath11k_cold_boot_cal && ab->qmi.cal_done == 0 &&
+			    ab->hw_params.cold_boot_calib) {
+				ath11k_qmi_process_coldboot_calibration(ab);
+			} else {
+				clear_bit(ATH11K_FLAG_CRASH_FLUSH,
+					  &ab->dev_flags);
+				clear_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
+				ath11k_core_qmi_firmware_ready(ab);
+				set_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags);
+			}
 
 			break;
 		case ATH11K_QMI_EVENT_COLD_BOOT_CAL_DONE:
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index b0a818f..64209ef 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -12,6 +12,7 @@
 #define ATH11K_HOST_VERSION_STRING		"WIN"
 #define ATH11K_QMI_WLANFW_TIMEOUT_MS		5000
 #define ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE	64
+#define ATH11K_QMI_CALDB_ADDRESS		0x4BA00000
 #define ATH11K_QMI_BDF_MAX_SIZE			(256 * 1024)
 #define ATH11K_QMI_CALDATA_OFFSET		(128 * 1024)
 #define ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
@@ -33,6 +34,7 @@
 #define QMI_WLANFW_MAX_DATA_SIZE_V01		6144
 #define ATH11K_FIRMWARE_MODE_OFF		4
 #define ATH11K_QMI_TARGET_MEM_MODE_DEFAULT	0
+#define ATH11K_COLD_BOOT_FW_RESET_DELAY		(40 * HZ)
 
 struct ath11k_base;
 
@@ -125,6 +127,7 @@ struct ath11k_qmi {
 	struct target_info target;
 	struct m3_mem_region m3_mem;
 	unsigned int service_ins_id;
+	wait_queue_head_t cold_boot_waitq;
 };
 
 #define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		189
-- 
2.7.4

