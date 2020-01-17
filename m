Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7ED514058C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 09:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgAQIgk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 03:36:40 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:19399 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbgAQIgk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 03:36:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579250199; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=sSOGb9oeqliyoQWqyTB1FFLcvbcN7JdYJ8iDGaPKgvQ=; b=izAOY2bP2avBUN4fyaNjH834Xamw3NeWUtH8f0c+YcaABzAhM02bWM+zClX+bXxDr94dt/GV
 XLWjJu36hjFWxuJcso5TsDh4vK5m4PlfMTbcU4fER9hfn3CuChb26ynQJIzM1cvHGIg0+sLZ
 MXbWPrM6B9nRfKSOaS0O0lWO610=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e217214.7efd8b8e1420-smtp-out-n03;
 Fri, 17 Jan 2020 08:36:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B428C4479C; Fri, 17 Jan 2020 08:36:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A18F1C433A2;
        Fri, 17 Jan 2020 08:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A18F1C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath10k: add retry mechanism for ath10k_start
Date:   Fri, 17 Jan 2020 16:36:05 +0800
Message-Id: <20200117083605.392-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When simulate random transfer fail for sdio write and read, it happened
"Could not init core: -110" and then wlan up fail.

Test steps:
1. Add config and update kernel:
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y

2. Run simulate fail:
cd /sys/kernel/debug/mmc1/fail_mmc_request
echo 100 > probability
echo 1000 > interval
echo 1 > times && enter system suspend
press power button to wakeup system

3. It happened Could not init core: -110.
[   66.432068] ath10k_sdio mmc1:0001:1: unable to send the bmi data to the device: -110
[   66.440012] ath10k_sdio mmc1:0001:1: unable to write to the device
[   66.453375] ath10k_sdio mmc1:0001:1: Could not init core: -110
[   66.653371] Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
[   66.999651] Workqueue: events_unbound async_run_entry_fn
[   67.004965] pstate: 60000005 (nZCv daif -PAN -UAO)
[   67.009799] pc : ieee80211_reconfig+0x630/0x19a4 [mac80211]
[   67.015413] lr : ieee80211_reconfig+0x630/0x19a4 [mac80211]
[   67.020979] sp : ffffff800d593bb0
[   67.024290] x29: ffffff800d593c30 x28: ffffff9169a11f80
[   67.029602] x27: ffffff91696d2018 x26: 0000000000000001
[   67.034915] x25: 00000000ffffff92 x24: ffffff9169a11f80
[   67.040228] x23: 0000000000000010 x22: ffffff91696d2018
[   67.045540] x21: ffffff9169a11f80 x20: 0000000000000000
[   67.050853] x19: ffffffc9aeaa0800 x18: 0000000000000000
[   67.056165] x17: 000000000000003c x16: ffffff91691b970c
[   67.061477] x15: 0000000000000006 x14: ffff001000000600
[   67.066790] x13: 000000000001a28e x12: 0000000000000000
[   67.072102] x11: 0000000000000000 x10: 0000000000000000
[   67.077415] x9 : c7b378ecef004f00 x8 : c7b378ecef004f00
[   67.082728] x7 : 0000000000000000 x6 : ffffff9169b66d2a
[   67.088041] x5 : 0000000000000000 x4 : 0000000000000000
[   67.093353] x3 : 00000000000188a2 x2 : ffffffc9bff05918
[   67.098666] x1 : ffffffc9bfefca08 x0 : 000000000000006d
[   67.103979] Call trace:
[   67.106470]  ieee80211_reconfig+0x630/0x19a4 [mac80211]
[   67.111736]  ieee80211_resume+0x34/0x68 [mac80211]
[   67.116586]  wiphy_resume+0x118/0x1d4 [cfg80211]
[   67.121205]  dpm_run_callback+0xe8/0x1e4
[   67.125128]  device_resume+0x1f4/0x228
[   67.128876]  async_resume+0x28/0x58
[   67.132362]  async_run_entry_fn+0x48/0xf8
[   67.136374]  process_one_work+0x210/0x410
[   67.140382]  worker_thread+0x234/0x3dc
[   67.144132]  kthread+0x120/0x130
[   67.147361]  ret_from_fork+0x10/0x18
[   67.150933] ---[ end trace 65dc48ed6f2300f6 ]---
[   67.156216] ------------[ cut here ]------------
[   67.160881] wlan0:  Failed check-sdata-in-driver check, flags: 0x0
[   67.167222] WARNING: CPU: 5 PID: 991 at /mnt/host/source/src/third_party/kernel/v4.19/net/mac80211/driver-ops.h:19 drv_remove_interface+0x1a8/0x1c0 [mac80211]
[   67.251884]  zram cfg80211 joydev
[   67.255206] CPU: 5 PID: 991 Comm: kworker/u16:3 Tainted: G        W         4.19.86 #67
[   67.263201] Hardware name: MediaTek krane sku0 board (DT)
[   67.268606] Workqueue: events_unbound async_run_entry_fn
[   67.273914] pstate: 60000005 (nZCv daif -PAN -UAO)
[   67.278720] pc : drv_remove_interface+0x1a8/0x1c0 [mac80211]
[   67.284394] lr : drv_remove_interface+0x1a8/0x1c0 [mac80211]
[   67.290045] sp : ffffff800d593990
[   67.293353] x29: ffffff800d5939c0 x28: 0000000000000030
[   67.298660] x27: ffffffc9ae8fd4a8 x26: 0000000000000000
[   67.303967] x25: 0000000000000000 x24: ffffffc9aeaa0c48
[   67.309274] x23: 0000000000000000 x22: ffffffc9aeaa1348
[   67.314581] x21: ffffffc9aeaa07a0 x20: ffffffc9ae8fc900
[   67.319887] x19: ffffffc9aeaa0800 x18: 0000000000000000
[   67.325194] x17: 000000000000003c x16: ffffff91691b970c
[   67.330501] x15: 0000000000000006 x14: ffff001000000600
[   67.335808] x13: 000000000001a2bc x12: 0000000000000000
[   67.341114] x11: 0000000000000000 x10: 0000000000000000
[   67.346420] x9 : c7b378ecef004f00 x8 : c7b378ecef004f00
[   67.351727] x7 : 0000000000000000 x6 : ffffff9169b66d1e
[   67.357033] x5 : 0000000000000000 x4 : 0000000000000000
[   67.362339] x3 : 0000000000017285 x2 : ffffffc9bff65918
[   67.367645] x1 : ffffffc9bff5ca08 x0 : 0000000000000036
[   67.372953] Call trace:
[   67.375417]  drv_remove_interface+0x1a8/0x1c0 [mac80211]
[   67.380749]  ieee80211_do_stop+0x620/0x6f8 [mac80211]
[   67.385822]  ieee80211_stop+0x20/0x30 [mac80211]
[   67.390439]  __dev_close_many+0xb8/0x11c
[   67.394357]  dev_close_many+0x70/0x100
[   67.398101]  dev_close+0x4c/0x80
[   67.401354]  cfg80211_shutdown_all_interfaces+0x50/0xcc [cfg80211]
[   67.407554]  ieee80211_handle_reconfig_failure+0x90/0x9c [mac80211]
[   67.413839]  ieee80211_reconfig+0x18dc/0x19a4 [mac80211]
[   67.419171]  ieee80211_resume+0x34/0x68 [mac80211]
[   67.423974]  wiphy_resume+0x118/0x1d4 [cfg80211]
[   67.428590]  dpm_run_callback+0xe8/0x1e4
[   67.432509]  device_resume+0x1f4/0x228
[   67.436253]  async_resume+0x28/0x58
[   67.439735]  async_run_entry_fn+0x48/0xf8
[   67.443742]  process_one_work+0x210/0x410
[   67.447746]  worker_thread+0x234/0x3dc
[   67.451489]  kthread+0x120/0x130
[   67.454716]  ret_from_fork+0x10/0x18
[   67.458286] ---[ end trace 65dc48ed6f2300f7 ]---
[   67.462952] ------------[ cut here ]------------
[   67.467648] WARNING: CPU: 5 PID: 991 at /mnt/host/source/src/third_party/kernel/v4.19/net/mac80211/driver-ops.c:39 drv_stop+0x1cc/0x1e4 [mac80211]
[   67.554573] CPU: 5 PID: 991 Comm: kworker/u16:3 Tainted: G        W         4.19.86 #67
[   67.562566] Hardware name: MediaTek krane sku0 board (DT)
[   67.567959] Workqueue: events_unbound async_run_entry_fn
[   67.573266] pstate: 60000005 (nZCv daif -PAN -UAO)
[   67.578071] pc : drv_stop+0x1cc/0x1e4 [mac80211]
[   67.582704] lr : drv_stop+0x1cc/0x1e4 [mac80211]
[   67.587313] sp : ffffff800d593970
[   67.590620] x29: ffffff800d5939a0 x28: 0000000000000030
[   67.595927] x27: ffffffc9ae8fd4a8 x26: 0000000000000000
[   67.601233] x25: 0000000000000000 x24: ffffffc9aeaa0c48
[   67.606540] x23: 0000000000000000 x22: ffffffc9aeaa1348
[   67.611846] x21: ffffffc9aeaa07a0 x20: ffffffc9ae8fc900
[   67.617153] x19: ffffffc9aeaa0800 x18: 0000000000000000
[   67.622460] x17: 000000000000003c x16: ffffff91691b970c
[   67.627767] x15: 0000000000000006 x14: ffff001000000600
[   67.633074] x13: 000000000001a358 x12: 0000000000000000
[   67.638380] x11: 0000000000000000 x10: 0000000000000000
[   67.643686] x9 : c7b378ecef004f00 x8 : c7b378ecef004f00
[   67.648992] x7 : 0000000000000000 x6 : ffffff9169b66d0c
[   67.654300] x5 : 0000000000000000 x4 : 0000000000000000
[   67.659606] x3 : 0000000000016529 x2 : ffffffc9bff65918
[   67.664913] x1 : ffffffc9bff5ca08 x0 : 0000000000000024
[   67.670219] Call trace:
[   67.672681]  drv_stop+0x1cc/0x1e4 [mac80211]
[   67.676971]  ieee80211_stop_device+0x48/0x54 [mac80211]
[   67.682215]  ieee80211_do_stop+0x678/0x6f8 [mac80211]
[   67.687286]  ieee80211_stop+0x20/0x30 [mac80211]
[   67.691898]  __dev_close_many+0xb8/0x11c
[   67.695816]  dev_close_many+0x70/0x100
[   67.699559]  dev_close+0x4c/0x80
[   67.702798]  cfg80211_shutdown_all_interfaces+0x50/0xcc [cfg80211]
[   67.708997]  ieee80211_handle_reconfig_failure+0x90/0x9c [mac80211]
[   67.715283]  ieee80211_reconfig+0x18dc/0x19a4 [mac80211]
[   67.720615]  ieee80211_resume+0x34/0x68 [mac80211]
[   67.725417]  wiphy_resume+0x118/0x1d4 [cfg80211]
[   67.730030]  dpm_run_callback+0xe8/0x1e4
[   67.733947]  device_resume+0x1f4/0x228
[   67.737690]  async_resume+0x28/0x58
[   67.741173]  async_run_entry_fn+0x48/0xf8
[   67.745178]  process_one_work+0x210/0x410
[   67.749183]  worker_thread+0x234/0x3dc
[   67.752925]  kthread+0x120/0x130
[   67.756149]  ret_from_fork+0x10/0x18
[   67.759717] ---[ end trace 65dc48ed6f2300f8 ]---
[   67.767629] dpm_run_callback(): wiphy_resume+0x0/0x1d4 [cfg80211] returns -110
[   67.774896] ieee80211 phy0: wiphy_resume+0x0/0x1d4 [cfg80211] returned -110 after 1777898 usecs

Add retry mechanism for ath10k_start to make sure wlan up success.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
Tested with QCA6174 PCIe with firmware WLAN.RM.4.4.1-00110-QCARMSWP-1.
Tested with QCA9984 PCIe with firmware 10.4-3.9.0.2-00046.
Tested with QCA9988 PCIe with firmware 10.4-3.9.0.2-00070.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c |  1 +
 drivers/net/wireless/ath/ath10k/core.h |  2 ++
 drivers/net/wireless/ath/ath10k/hw.h   |  2 ++
 drivers/net/wireless/ath/ath10k/mac.c  | 23 ++++++++++++++++++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 91f131b87efc..59c9b850aa44 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -190,6 +190,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.uart_pin_workaround = true,
 		.tx_stats_over_pktlog = false,
 		.bmi_large_size_download = true,
+		.start_retry = ATH10K_START_RETRY,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index e57b2e7235e3..2b55bec0dc6a 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -82,6 +82,8 @@
 /* Default Airtime weight multipler (Tuned for multiclient performance) */
 #define ATH10K_AIRTIME_WEIGHT_MULTIPLIER  4
 
+#define ATH10K_START_RETRY 10
+
 struct ath10k;
 
 static inline const char *ath10k_bus_str(enum ath10k_bus bus)
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 54176a0c0479..7615a9212e7c 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -623,6 +623,8 @@ struct ath10k_hw_params {
 
 	/* tx stats support over pktlog */
 	bool tx_stats_over_pktlog;
+
+	u32 start_retry;
 };
 
 struct htt_rx_desc;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3856edba7915..96afd813367b 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4814,7 +4814,7 @@ int ath10k_mac_rfkill_enable_radio(struct ath10k *ar, bool enable)
 	return 0;
 }
 
-static int ath10k_start(struct ieee80211_hw *hw)
+static int __ath10k_start(struct ieee80211_hw *hw)
 {
 	struct ath10k *ar = hw->priv;
 	u32 param;
@@ -5030,6 +5030,27 @@ static int ath10k_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
+static int ath10k_start(struct ieee80211_hw *hw)
+{
+	struct ath10k *ar = hw->priv;
+	int ret, loop = ar->hw_params.start_retry + 1;
+	enum ath10k_state state = ar->state;
+
+	while (loop != 0) {
+		ar->state = state;
+		ret = __ath10k_start(hw);
+		loop--;
+
+		if (ret)
+			ath10k_warn(ar, "failed to start, loops: %d, ret: %d\n",
+				    loop, ret);
+		else
+			break;
+	}
+
+	return ret;
+}
+
 static void ath10k_stop(struct ieee80211_hw *hw)
 {
 	struct ath10k *ar = hw->priv;
-- 
2.23.0
