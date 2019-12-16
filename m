Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA0120439
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 12:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfLPLmM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 06:42:12 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:25582 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbfLPLmM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 06:42:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576496532; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=cCAbvx8d76X6UnOOZeIMAnfSmKqs+7sEPAPeeSxg55o=; b=E/DLkFF9/6Ncex7QW1mXwkWLpITtsHjaIarN/C6c/rX1II3KyvV06wfCUAwZ148RhsC6nyL1
 0KssNL/Mx8+S56Q0ZT/B9s3x8US4WfNqh4MRDpQxM7/EhuU2R2hML/odjWooXxhofzO2ZgBt
 LAEjr8NG3jSES7JabSrcf/qZphQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df76d90.7f94a41c46c0-smtp-out-n01;
 Mon, 16 Dec 2019 11:42:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9810C43383; Mon, 16 Dec 2019 11:42:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from cheath10p342229-lin.qca.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4B91C433A2;
        Mon, 16 Dec 2019 11:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4B91C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH 2/2] ath10k: Add support to read btcoex related data from DT
Date:   Mon, 16 Dec 2019 17:10:15 +0530
Message-Id: <1576496415-23064-2-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1576496415-23064-1-git-send-email-tamizhr@codeaurora.org>
References: <1576496415-23064-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BTCOEX feature is not supported by all QCA4019 chipsets.
Since btcoex enabled by default in firmware, host needs to
enable COEX support depends on the hardware. Enabling it
by default in unsupported hardware will cause some
feature disabled in hardware.
This patch will read btcoex_support flag and
wlan priority gpio pin number from DT. Depends on the
btcoex_support flag value host will expose BTCOEX support
and wlan priority gpio pin number to target.

Testing:
	* Tested HW : QCA4019
	* Tested FW : 10.4-3.2.1.1-00017

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c  | 44 ++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/core.h  |  9 +++++++
 drivers/net/wireless/ath/ath10k/debug.c |  3 +++
 drivers/net/wireless/ath/ath10k/mac.c   |  3 ++-
 drivers/net/wireless/ath/ath10k/wmi.c   |  2 +-
 5 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5ec16ce..f9434bc 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2119,6 +2119,40 @@ static int ath10k_download_cal_data(struct ath10k *ar)
 	return 0;
 }
 
+static void ath10k_core_fetch_btcoex_dt(struct ath10k *ar)
+{
+	struct device_node *node;
+	u32 coex_support = 0;
+	int ret;
+
+	node = ar->dev->of_node;
+	if (!node)
+		goto out;
+
+	ret = of_property_read_u32(node, "qcom,coexist-support", &coex_support);
+	if (ret) {
+		ar->coex_support = ATH10K_DT_COEX_NOT_FOUND;
+		goto out;
+	}
+
+	if (coex_support) {
+		ar->coex_support = ATH10K_DT_COEX_SUPPORTED;
+	} else {
+		ar->coex_support = ATH10K_DT_COEX_NOT_SUPPORTED;
+		ar->coex_gpio_pin = -1;
+		goto out;
+	}
+
+	ret = of_property_read_u32(node, "qcom,coexist-gpio-pin",
+				   &ar->coex_gpio_pin);
+	if (ret)
+		ar->coex_gpio_pin = -1;
+
+out:
+	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot coex_support %d coex_gpio_pin %d\n",
+		   ar->coex_support, ar->coex_gpio_pin);
+}
+
 static int ath10k_init_uart(struct ath10k *ar)
 {
 	int ret;
@@ -2696,14 +2730,22 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		if (test_bit(WMI_SERVICE_BSS_CHANNEL_INFO_64, ar->wmi.svc_map))
 			val |= WMI_10_4_BSS_CHANNEL_INFO_64;
 
+		ath10k_core_fetch_btcoex_dt(ar);
+
 		/* 10.4 firmware supports BT-Coex without reloading firmware
 		 * via pdev param. To support Bluetooth coexistence pdev param,
 		 * WMI_COEX_GPIO_SUPPORT of extended resource config should be
 		 * enabled always.
+		 *
+		 * We can still enable BTCOEX if firmware has the support
+		 * eventhough btceox_support value is
+		 * ATH10K_DT_BTCOEX_NOT_FOUND
 		 */
+
 		if (test_bit(WMI_SERVICE_COEX_GPIO, ar->wmi.svc_map) &&
 		    test_bit(ATH10K_FW_FEATURE_BTCOEX_PARAM,
-			     ar->running_fw->fw_file.fw_features))
+			     ar->running_fw->fw_file.fw_features) &&
+		    ar->coex_support != ATH10K_DT_COEX_NOT_SUPPORTED)
 			val |= WMI_10_4_COEX_GPIO_SUPPORT;
 
 		if (test_bit(WMI_SERVICE_TDLS_EXPLICIT_MODE_ONLY,
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 5101bf2..90f437a 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -875,6 +875,12 @@ enum ath10k_tx_pause_reason {
 	ATH10K_TX_PAUSE_MAX,
 };
 
+enum ath10k_dt_coex_support_flag {
+	ATH10K_DT_COEX_NOT_FOUND,
+	ATH10K_DT_COEX_SUPPORTED,
+	ATH10K_DT_COEX_NOT_SUPPORTED,
+};
+
 struct ath10k_fw_file {
 	const struct firmware *firmware;
 
@@ -1222,6 +1228,9 @@ struct ath10k {
 	struct ath10k_bus_params bus_param;
 	struct completion peer_delete_done;
 
+	enum ath10k_dt_coex_support_flag coex_support;
+	int coex_gpio_pin;
+
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index e000677..bb452a1 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1978,6 +1978,9 @@ static ssize_t ath10k_write_btcoex(struct file *file,
 	if (strtobool(buf, &val) != 0)
 		return -EINVAL;
 
+	if (ar->coex_support == ATH10K_DT_COEX_NOT_SUPPORTED)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&ar->conf_mutex);
 
 	if (ar->state != ATH10K_STATE_ON &&
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 767c7bf..63c22653 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4982,7 +4982,8 @@ static int ath10k_start(struct ieee80211_hw *hw)
 	param = ar->wmi.pdev_param->enable_btcoex;
 	if (test_bit(WMI_SERVICE_COEX_GPIO, ar->wmi.svc_map) &&
 	    test_bit(ATH10K_FW_FEATURE_BTCOEX_PARAM,
-		     ar->running_fw->fw_file.fw_features)) {
+		     ar->running_fw->fw_file.fw_features) &&
+	    ar->coex_support != ATH10K_DT_COEX_NOT_SUPPORTED) {
 		ret = ath10k_wmi_pdev_set_param(ar, param, 0);
 		if (ret) {
 			ath10k_warn(ar,
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 13f7531..4684aa75 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -8787,7 +8787,7 @@ static int ath10k_wmi_10_4_op_get_vdev_subtype(struct ath10k *ar,
 	cmd = (struct wmi_ext_resource_config_10_4_cmd *)skb->data;
 	cmd->host_platform_config = __cpu_to_le32(type);
 	cmd->fw_feature_bitmap = __cpu_to_le32(fw_feature_bitmap);
-	cmd->wlan_gpio_priority = __cpu_to_le32(-1);
+	cmd->wlan_gpio_priority = __cpu_to_le32(ar->coex_gpio_pin);
 	cmd->coex_version = __cpu_to_le32(WMI_NO_COEX_VERSION_SUPPORT);
 	cmd->coex_gpio_pin1 = __cpu_to_le32(-1);
 	cmd->coex_gpio_pin2 = __cpu_to_le32(-1);
-- 
1.9.1
