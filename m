Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01F83D18F5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhGUUkg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:40:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24942 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhGUUkf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902472; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Rye3Rx63L1XhV5EVGhi9u0OaBEhT0ebda3RefdVtzpE=; b=Ykb2wUAiytYAK1jyfu5pncFB58QQ0BlbzFxmMdq72MCCc/uDSsnbc4pczMjrZnVGAg4oSlAN
 MytPdxvybWbPpFiWTNPmUq59xljrOuhRhAwDJY0ZwL14xYEUbx9yH+K6RyqWyxCv54yiTPyY
 js2sTD5tk8AL/nXLF4zCAslr3nQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60f88fc7e31d882d1819c5f2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:21:11
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91231C43460; Wed, 21 Jul 2021 21:21:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD9CCC43147;
        Wed, 21 Jul 2021 21:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD9CCC43147
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 12/12] ath11k: Change QCN9074 firmware to operate in mode-2
Date:   Thu, 22 Jul 2021 00:20:29 +0300
Message-Id: <20210721212029.142388-12-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

In mode-2 QCN9074 firmware uses 15 MB of host memory and firmware
request 1 MB size segments in QMI, whereas in mode-0 firmware uses 45 MB
of host memory and each segment is of 2 MB size. In mode-2 firmware
operates with reduced number of vdevs and peers.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Co-developed-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 23 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/core.h |  6 ++++++
 drivers/net/wireless/ath/ath11k/hw.c   | 14 +++++++-------
 drivers/net/wireless/ath/ath11k/hw.h   | 20 +++++++++++---------
 drivers/net/wireless/ath/ath11k/mac.c  | 10 +++++-----
 drivers/net/wireless/ath/ath11k/qmi.c  |  2 +-
 6 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index d2ab3b134632..9f2c9795767e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -77,6 +77,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.cold_boot_calib = true,
+		.fw_mem_mode = 0,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
@@ -124,6 +125,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = false,
 		.idle_ps = false,
 		.cold_boot_calib = true,
+		.fw_mem_mode = 0,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
@@ -170,6 +172,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_shadow_regs = true,
 		.idle_ps = true,
 		.cold_boot_calib = false,
+		.fw_mem_mode = 0,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
@@ -217,6 +220,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.cold_boot_calib = false,
 		.supports_suspend = false,
+		.fw_mem_mode = 2,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.fix_l1ss = true,
 	},
@@ -262,11 +266,27 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = true,
 		.cold_boot_calib = false,
 		.supports_suspend = true,
+		.fw_mem_mode = 0,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.fix_l1ss = false,
 	},
 };
 
+static const struct ath11k_num_vdevs_peers ath11k_vdevs_peers[] = {
+	{
+		.num_vdevs = (16 + 1),
+		.num_peers = 512,
+	},
+	{
+		.num_vdevs = (8 + 1),
+		.num_peers = 128,
+	},
+	{
+		.num_vdevs = 8,
+		.num_peers = 128,
+	},
+};
+
 int ath11k_core_suspend(struct ath11k_base *ab)
 {
 	int ret;
@@ -668,6 +688,7 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 {
 	int ret;
 
+	ab->num_vdevs_peers = ath11k_vdevs_peers[ab->hw_params.fw_mem_mode];
 	ret = ath11k_qmi_init_service(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to initialize qmi :%d\n", ret);
@@ -958,7 +979,7 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
 	ath11k_dp_free(ab);
 	ath11k_hal_srng_deinit(ab);
 
-	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
+	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
 	ret = ath11k_hal_srng_init(ab);
 	if (ret)
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 394ba7b9c8ab..79c52d28a3a2 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -663,6 +663,11 @@ struct ath11k_soc_dp_stats {
 	struct ath11k_dp_ring_bp_stats bp_stats;
 };
 
+struct ath11k_num_vdevs_peers {
+	u32 num_vdevs;
+	u32 num_peers;
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath11k_base {
 	enum ath11k_hw_rev hw_rev;
@@ -754,6 +759,7 @@ struct ath11k_base {
 	struct timer_list mon_reap_timer;
 
 	struct completion htc_suspend;
+	struct ath11k_num_vdevs_peers num_vdevs_peers;
 
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 7a343db1dde8..e54b02fd2cc3 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -149,18 +149,18 @@ static void ath11k_hw_ipq8074_reo_setup(struct ath11k_base *ab)
 static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
 					   struct target_resource_config *config)
 {
-	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS;
+	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS(ab);
 
 	if (ab->num_radios == 2) {
-		config->num_peers = TARGET_NUM_PEERS(DBS);
-		config->num_tids = TARGET_NUM_TIDS(DBS);
+		config->num_peers = TARGET_NUM_PEERS(ab, DBS);
+		config->num_tids = TARGET_NUM_TIDS(ab, DBS);
 	} else if (ab->num_radios == 3) {
-		config->num_peers = TARGET_NUM_PEERS(DBS_SBS);
-		config->num_tids = TARGET_NUM_TIDS(DBS_SBS);
+		config->num_peers = TARGET_NUM_PEERS(ab, DBS_SBS);
+		config->num_tids = TARGET_NUM_TIDS(ab, DBS_SBS);
 	} else {
 		/* Control should not reach here */
-		config->num_peers = TARGET_NUM_PEERS(SINGLE);
-		config->num_tids = TARGET_NUM_TIDS(SINGLE);
+		config->num_peers = TARGET_NUM_PEERS(ab, SINGLE);
+		config->num_tids = TARGET_NUM_TIDS(ab, SINGLE);
 	}
 	config->num_offload_peers = TARGET_NUM_OFFLD_PEERS;
 	config->num_offload_reorder_buffs = TARGET_NUM_OFFLD_REORDER_BUFFS;
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 8a75afae11db..a1be4f79acb4 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -11,26 +11,27 @@
 /* Target configuration defines */
 
 /* Num VDEVS per radio */
-#define TARGET_NUM_VDEVS	(16 + 1)
+#define TARGET_NUM_VDEVS(ab)	((ab)->num_vdevs_peers.num_vdevs)
 
-#define TARGET_NUM_PEERS_PDEV	(512 + TARGET_NUM_VDEVS)
+#define TARGET_NUM_PEERS_PDEV(ab) \
+		(((ab)->num_vdevs_peers.num_peers + (TARGET_NUM_VDEVS(ab))))
 
 /* Num of peers for Single Radio mode */
-#define TARGET_NUM_PEERS_SINGLE		(TARGET_NUM_PEERS_PDEV)
+#define TARGET_NUM_PEERS_SINGLE(ab)		(TARGET_NUM_PEERS_PDEV(ab))
 
 /* Num of peers for DBS */
-#define TARGET_NUM_PEERS_DBS		(2 * TARGET_NUM_PEERS_PDEV)
+#define TARGET_NUM_PEERS_DBS(ab)		(2 * TARGET_NUM_PEERS_PDEV(ab))
 
 /* Num of peers for DBS_SBS */
-#define TARGET_NUM_PEERS_DBS_SBS	(3 * TARGET_NUM_PEERS_PDEV)
+#define TARGET_NUM_PEERS_DBS_SBS(ab)	(3 * TARGET_NUM_PEERS_PDEV(ab))
 
 /* Max num of stations (per radio) */
-#define TARGET_NUM_STATIONS	512
+#define TARGET_NUM_STATIONS(ab)	((ab)->num_vdevs_peers.num_peers)
 
-#define TARGET_NUM_PEERS(x)	TARGET_NUM_PEERS_##x
+#define TARGET_NUM_PEERS(ab, x)	TARGET_NUM_PEERS_##x(ab)
 #define TARGET_NUM_PEER_KEYS	2
-#define TARGET_NUM_TIDS(x)	(2 * TARGET_NUM_PEERS(x) + \
-				 4 * TARGET_NUM_VDEVS + 8)
+#define TARGET_NUM_TIDS(ab, x)	((2 * (TARGET_NUM_PEERS(ab, x))) + \
+				 (4 * (TARGET_NUM_VDEVS(ab)) + 8))
 
 #define TARGET_AST_SKID_LIMIT	16
 #define TARGET_NUM_OFFLD_PEERS	4
@@ -168,6 +169,7 @@ struct ath11k_hw_params {
 	bool supports_shadow_regs;
 	bool idle_ps;
 	bool cold_boot_calib;
+	int fw_mem_mode;
 	bool supports_suspend;
 	u32 hal_desc_sz;
 	bool fix_l1ss;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 5ab42324a564..10a838563683 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5377,9 +5377,9 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 		goto err;
 	}
 
-	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS - 1)) {
+	if (ar->num_created_vdevs > (TARGET_NUM_VDEVS(ab) - 1)) {
 		ath11k_warn(ab, "failed to create vdev %u, reached max vdev limit %d\n",
-			    ar->num_created_vdevs, TARGET_NUM_VDEVS);
+			    ar->num_created_vdevs, TARGET_NUM_VDEVS(ab));
 		ret = -EBUSY;
 		goto err;
 	}
@@ -7509,8 +7509,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ar->hw->wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
-	ar->max_num_stations = TARGET_NUM_STATIONS;
-	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
+	ar->max_num_stations = TARGET_NUM_STATIONS(ab);
+	ar->max_num_peers = TARGET_NUM_PEERS_PDEV(ab);
 
 	ar->hw->wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
@@ -7605,7 +7605,7 @@ int ath11k_mac_register(struct ath11k_base *ab)
 
 	/* Initialize channel counters frequency value in hertz */
 	ab->cc_freq_hz = IPQ8074_CC_FREQ_HERTZ;
-	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
+	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
 
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index cc3c4412d679..7e82d03b0d87 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2816,7 +2816,7 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 	memset(&ab->qmi.target_mem, 0, sizeof(struct target_mem_chunk));
 	ab->qmi.ab = ab;
 
-	ab->qmi.target_mem_mode = ATH11K_QMI_TARGET_MEM_MODE_DEFAULT;
+	ab->qmi.target_mem_mode = ab->hw_params.fw_mem_mode;
 	ret = qmi_handle_init(&ab->qmi.handle, ATH11K_QMI_RESP_LEN_MAX,
 			      &ath11k_qmi_ops, ath11k_qmi_msg_handlers);
 	if (ret < 0) {
-- 
2.25.1

