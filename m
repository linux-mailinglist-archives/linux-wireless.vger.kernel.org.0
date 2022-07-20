Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED957B7CA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 15:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiGTNrK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 09:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240053AbiGTNrD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 09:47:03 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEDE5A176
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658324823; x=1689860823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8oP1tOcBbp7S4vWaVcr9dfMKTfjLNKZVMmMu+KzqfE=;
  b=R3h4gCl1GKVqhU6ZYkaeqbHffsvExJyTiSg/4rovJ1qJee6HEU6BijjM
   fJN402zJaG3nD7jzTSem+q5wE8aRPX19K9HZaD5rYxuUYqa0TLhUKFiD/
   zFc+6runYrsWHYXS3ag8G+1U23w5id6oimBGgtV0r9to7HBAjfXbxasT0
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 20 Jul 2022 06:47:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:47:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:46:38 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 06:46:36 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH] ath11k: Add support to connect to non-transmit MBSSID profiles
Date:   Wed, 20 Jul 2022 19:16:22 +0530
Message-ID: <20220720134622.15293-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
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

Add support to connect to a non-transmit MBSSID AP profile.

Non-transmit MBSSID profile parameters are passed to the firmware
via WMI VDEV UP command and this helps firmware to track MBSSID
profile within the multi-BSS beacon and report beacon loss if
any.

WCN6750, QCA6390 & WCN6855 firmwares have the support and hence
enable the support on these hardwares.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  7 +++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  |  5 +++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 15 +++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c8e0bc935838..fc988db449d1 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -111,6 +111,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.supports_multi_bssid = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -187,6 +188,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.supports_multi_bssid = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -262,6 +264,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.supports_multi_bssid = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -337,6 +340,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 2,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.supports_multi_bssid = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -412,6 +416,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.supports_multi_bssid = true,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -486,6 +491,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 0,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.supports_multi_bssid = true,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -560,6 +566,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.ce_window_idx = 2,
 		.fixed_fw_mem = true,
 		.support_off_channel_tx = false,
+		.supports_multi_bssid = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 77dc5c851c9b..fb96edbe5820 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -205,6 +205,7 @@ struct ath11k_hw_params {
 	u8 ce_window_idx;
 	bool fixed_fw_mem;
 	bool support_off_channel_tx;
+	bool supports_multi_bssid;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d83d3c944594..c36f9026912e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8835,6 +8835,11 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	if (ab->hw_params.single_pdev_only && ar->supports_6ghz)
 		ieee80211_hw_set(ar->hw, SINGLE_SCAN_ON_ALL_BANDS);
 
+	if (ab->hw_params.supports_multi_bssid) {
+		ieee80211_hw_set(ar->hw, SUPPORTS_MULTI_BSSID);
+		ieee80211_hw_set(ar->hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
+	}
+
 	ieee80211_hw_set(ar->hw, SIGNAL_DBM);
 	ieee80211_hw_set(ar->hw, SUPPORTS_PS);
 	ieee80211_hw_set(ar->hw, SUPPORTS_DYNAMIC_PS);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5d9437ea92cf..2b5721e8e607 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -995,9 +995,13 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
+	struct ieee80211_bss_conf *bss_conf;
+	struct ath11k_vif *arvif;
 	struct sk_buff *skb;
 	int ret;
 
+	arvif = ath11k_mac_get_arvif(ar, vdev_id);
+
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
@@ -1011,6 +1015,17 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	ether_addr_copy(cmd->vdev_bssid.addr, bssid);
 
+	if (arvif && arvif->vif->type == NL80211_IFTYPE_STATION) {
+		bss_conf = &arvif->vif->bss_conf;
+
+		if (bss_conf->nontransmitted) {
+			ether_addr_copy(cmd->trans_bssid.addr,
+					bss_conf->transmitter_bssid);
+			cmd->profile_idx = bss_conf->bssid_index;
+			cmd->profile_num = bss_conf->bssid_indicator;
+		}
+	}
+
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_VDEV_UP_CMDID);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to submit WMI_VDEV_UP cmd\n");
-- 
2.35.1

