Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000484D16AB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Mar 2022 12:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346611AbiCHLym (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Mar 2022 06:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346603AbiCHLyk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Mar 2022 06:54:40 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DAB33A05;
        Tue,  8 Mar 2022 03:53:44 -0800 (PST)
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 08 Mar 2022 03:53:44 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Mar 2022 03:53:43 -0800
X-QCInternal: smtphost
Received: from unknown (HELO youghand-linux.qualcomm.com) ([10.206.66.115])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Mar 2022 17:23:32 +0530
Received: by youghand-linux.qualcomm.com (Postfix, from userid 2370257)
        id 750E122681; Tue,  8 Mar 2022 17:23:31 +0530 (IST)
From:   Youghandhar Chintala <youghand@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pillair@codeaurora.org, dianders@chromium.org, kuabhs@chromium.org,
        briannorris@chromium.org, mpubbise@codeaurora.org,
        Youghandhar Chintala <youghand@codeaurora.org>
Subject: [PATCH v5 2/2] ath10k: Trigger sta disconnect on hardware restart
Date:   Tue,  8 Mar 2022 17:23:25 +0530
Message-Id: <20220308115325.5246-3-youghand@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220308115325.5246-1-youghand@codeaurora.org>
References: <20220308115325.5246-1-youghand@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently after the hardware restart triggered from the driver,
the station interface connection remains intact, since a disconnect
trigger is not sent to userspace. This can lead to a problem in
targets where the wifi mac sequence is added by the firmware.

After the target restart, its wifi mac sequence number gets
reset to zero. Hence AP to which our device is connected will receive
frames with a  wifi mac sequence number jump to the past, thereby
resulting in the AP dropping all these frames, until the frame
arrives with a wifi mac sequence number which AP was expecting.

To avoid such frame drops, its better to trigger a station disconnect
upon target hardware restart which can be done with API
ieee80211_reconfig_disconnect exposed to mac80211.

The other targets are not affected by this change, since the hardware
params flag is not set.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00048

Signed-off-by: Youghandhar Chintala <youghand@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 25 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h   |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 9e1f483e1362..2092bfd02cd1 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -94,6 +94,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = true,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA988X_HW_2_0_VERSION,
@@ -131,6 +132,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = true,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA9887_HW_1_0_VERSION,
@@ -169,6 +171,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -202,6 +205,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.bmi_large_size_download = true,
 		.supports_peer_stats_info = true,
 		.dynamic_sar_support = true,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -239,6 +243,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -276,6 +281,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -313,6 +319,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -354,6 +361,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.supports_peer_stats_info = true,
 		.dynamic_sar_support = true,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -397,6 +405,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA9984_HW_1_0_DEV_VERSION,
@@ -447,6 +456,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA9888_HW_2_0_DEV_VERSION,
@@ -494,6 +504,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -531,6 +542,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -570,6 +582,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -600,6 +613,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.uart_pin_workaround = true,
 		.credit_size_workaround = true,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = QCA4019_HW_1_0_DEV_VERSION,
@@ -644,6 +658,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
+		.hw_restart_disconnect = false,
 	},
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
@@ -674,6 +689,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = false,
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = true,
+		.hw_restart_disconnect = true,
 	},
 };
 
@@ -2442,6 +2458,7 @@ EXPORT_SYMBOL(ath10k_core_napi_sync_disable);
 static void ath10k_core_restart(struct work_struct *work)
 {
 	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
+	struct ath10k_vif *arvif;
 	int ret;
 
 	set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
@@ -2480,6 +2497,14 @@ static void ath10k_core_restart(struct work_struct *work)
 		ar->state = ATH10K_STATE_RESTARTING;
 		ath10k_halt(ar);
 		ath10k_scan_finish(ar);
+		if (ar->hw_params.hw_restart_disconnect) {
+			list_for_each_entry(arvif, &ar->arvifs, list) {
+				if (arvif->is_up &&
+				    arvif->vdev_type == WMI_VDEV_TYPE_STA)
+					ieee80211_hw_restart_disconnect(arvif->vif);
+			}
+		}
+
 		ieee80211_restart_hw(ar->hw);
 		break;
 	case ATH10K_STATE_OFF:
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 5215a6816d71..93acf0dd580a 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -633,6 +633,8 @@ struct ath10k_hw_params {
 	bool supports_peer_stats_info;
 
 	bool dynamic_sar_support;
+
+	bool hw_restart_disconnect;
 };
 
 struct htt_resp;
-- 
2.29.0

