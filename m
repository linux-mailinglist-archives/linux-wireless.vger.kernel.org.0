Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD42D5CFB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbgLJOGU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 09:06:20 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:11745 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389952AbgLJOGS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 09:06:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607609158; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=6XNLyR5UP1nCj9yvmX0qqk9euWe4lT6Qo3p5W5Jw/qE=; b=eJOtoTVzXOjyT2efsyob1HPNKfeBXHlebAGe4+Rll5fvw0Xs3jxiSuia7IKEIEqBJtzu2DHc
 A+hU2SNcBN8C+Qhyuc++vBPfM2YChMR5kgQTqx+py/ZF70FVG9IXHDIhhCEdcMLRY8s6ZotN
 MugRPdUN6klqhw3pNClJK6SNhww=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fd22b2c65f116f287f1081d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Dec 2020 14:05:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E76C5C4346D; Thu, 10 Dec 2020 14:05:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91992C43465;
        Thu, 10 Dec 2020 14:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91992C43465
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/6] ath11k: put hw to DBS using WMI_PDEV_SET_HW_MODE_CMDID
Date:   Thu, 10 Dec 2020 16:05:20 +0200
Message-Id: <1607609124-17250-3-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
References: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

It's recommended to use wmi command WMI_PDEV_SET_HW_MODE_CMDID to put hardware
to dbs mode instead of wmi_init command. This fixes a few strange stability
issues.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 12 ++++++++---
 drivers/net/wireless/ath/ath11k/hw.h   |  6 ------
 drivers/net/wireless/ath/ath11k/wmi.c  | 38 ++++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.h  |  3 +++
 4 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index da20ed752ca5..3c28e7ad7d51 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -51,7 +51,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq8074,
 		.svc_to_ce_map_len = 21,
 		.single_pdev_only = false,
-		.needs_band_to_mac = true,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
 		.rx_mac_buf_ring = false,
@@ -89,7 +88,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq6018,
 		.svc_to_ce_map_len = 19,
 		.single_pdev_only = false,
-		.needs_band_to_mac = true,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
 		.rx_mac_buf_ring = false,
@@ -127,7 +125,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
 		.single_pdev_only = true,
-		.needs_band_to_mac = false,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
 		.rx_mac_buf_ring = true,
@@ -646,6 +643,15 @@ static int ath11k_core_start(struct ath11k_base *ab,
 		goto err_reo_cleanup;
 	}
 
+	/* put hardware to DBS mode */
+	if (ab->hw_params.single_pdev_only) {
+		ret = ath11k_wmi_set_hw_mode(ab, WMI_HOST_HW_MODE_DBS);
+		if (ret) {
+			ath11k_err(ab, "failed to send dbs mode: %d\n", ret);
+			goto err_hif_stop;
+		}
+	}
+
 	ret = ath11k_dp_tx_htt_h2t_ver_req_msg(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to send htt version request message: %d\n",
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 17c4560b1c73..f33a458a465f 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -143,12 +143,6 @@ struct ath11k_hw_params {
 
 	bool single_pdev_only;
 
-	/* For example on QCA6390 struct
-	 * wmi_init_cmd_param::band_to_mac_config needs to be false as the
-	 * firmware creates the mapping.
-	 */
-	bool needs_band_to_mac;
-
 	bool rxdma1_enable;
 	int num_rxmda_per_pdev;
 	bool rx_mac_buf_ring;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 59e179d86f38..79b7f991c612 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3479,6 +3479,35 @@ int ath11k_wmi_wait_for_unified_ready(struct ath11k_base *ab)
 	return 0;
 }
 
+int ath11k_wmi_set_hw_mode(struct ath11k_base *ab,
+			   enum wmi_host_hw_mode_config_type mode)
+{
+	struct wmi_pdev_set_hw_mode_cmd_param *cmd;
+	struct sk_buff *skb;
+	struct ath11k_wmi_base *wmi_ab = &ab->wmi_ab;
+	int len;
+	int ret;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi_ab, len);
+	cmd = (struct wmi_pdev_set_hw_mode_cmd_param *)skb->data;
+
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_PDEV_SET_HW_MODE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->pdev_id = WMI_PDEV_ID_SOC;
+	cmd->hw_mode_index = mode;
+
+	ret = ath11k_wmi_cmd_send(&wmi_ab->wmi[0], skb, WMI_PDEV_SET_HW_MODE_CMDID);
+	if (ret) {
+		ath11k_warn(ab, "failed to send WMI_PDEV_SET_HW_MODE_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 {
 	struct ath11k_wmi_base *wmi_sc = &ab->wmi_ab;
@@ -3497,10 +3526,11 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	init_param.hw_mode_id = wmi_sc->preferred_hw_mode;
 	init_param.mem_chunks = wmi_sc->mem_chunks;
 
-	if (ab->hw_params.needs_band_to_mac) {
-		init_param.num_band_to_mac = ab->num_radios;
-		ath11k_fill_band_to_mac_param(ab, init_param.band_to_mac);
-	}
+	if (ab->hw_params.single_pdev_only)
+		init_param.hw_mode_id = WMI_HOST_HW_MODE_MAX;
+
+	init_param.num_band_to_mac = ab->num_radios;
+	ath11k_fill_band_to_mac_param(ab, init_param.band_to_mac);
 
 	return ath11k_init_cmd_send(&wmi_sc->wmi[0], &init_param);
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 05d5f6d30072..62840717a946 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5171,4 +5171,7 @@ int ath11k_wmi_fils_discovery(struct ath11k *ar, u32 vdev_id, u32 interval,
 			      bool unsol_bcast_probe_resp_enabled);
 int ath11k_wmi_probe_resp_tmpl(struct ath11k *ar, u32 vdev_id,
 			       struct sk_buff *tmpl);
+int ath11k_wmi_set_hw_mode(struct ath11k_base *ab,
+			   enum wmi_host_hw_mode_config_type mode);
+
 #endif
-- 
2.7.4

