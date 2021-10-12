Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12542A2EA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 13:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhJLLSM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 07:18:12 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19671 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhJLLSK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 07:18:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634037368; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=RLwtSyczHXrmwI41URsgeQHDCH2qk5zy2DPYlSlzIDI=; b=pEixJMwzUJJqKfqwt2qUo+EAx4oj8lwIEcq1g5iNgnqHwREQZakVi2xyfbwWbuZlIQAZSnKj
 m10BtB6u9VTB5XGUTRw52vhZhWzQrqGi9lRfMAYjyaxKGBYVVDJz6Wdn2llFMR7Q88h2mesd
 fFjnUGfxzHcJB08lXgiL0NHqEsA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61656e77f3e5b80f1fcc8044 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Oct 2021 11:16:07
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85058C4360D; Tue, 12 Oct 2021 11:16:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42DA3C4338F;
        Tue, 12 Oct 2021 11:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 42DA3C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: support MAC address randomization in scan
Date:   Tue, 12 Oct 2021 15:16:38 -0400
Message-Id: <20211012191638.8749-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver reports NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR capability
to upper layer based on the service bit firmware reported. Driver
sets the spoofed flag in scan_ctrl_flag to firmware if upper layer
has enabled this feature in scan request.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 19 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c | 30 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  9 +++++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 797e45e..bb5d12f40 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3048,6 +3048,12 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
 	}
 
+	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		arg.scan_f_add_spoofed_mac_in_probe = 1;
+		ether_addr_copy(arg.mac_addr.addr, req->mac_addr);
+		ether_addr_copy(arg.mac_mask.addr, req->mac_addr_mask);
+	}
+
 	if (req->n_channels) {
 		arg.num_chan = req->n_channels;
 		for (i = 0; i < arg.num_chan; i++)
@@ -4992,6 +4998,14 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 		goto err;
 	}
 
+	if (test_bit(WMI_TLV_SERVICE_SPOOF_MAC_SUPPORT, ar->wmi->wmi_ab->svc_map)) {
+		ret = ath11k_wmi_scan_prob_req_oui(ar, ar->mac_addr);
+		if (ret) {
+			ath11k_err(ab, "failed to set prob req oui: %i\n", ret);
+			goto err;
+		}
+	}
+
 	ret = ath11k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_ARP_AC_OVERRIDE,
 					0, pdev->pdev_id);
 	if (ret) {
@@ -7888,6 +7902,11 @@ static int __ath11k_mac_register(struct ath11k *ar)
 
 	ar->hw->wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
+	if (test_bit(WMI_TLV_SERVICE_SPOOF_MAC_SUPPORT, ar->wmi->wmi_ab->svc_map)) {
+		ar->hw->wiphy->features |=
+			NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
+	}
+
 	if (test_bit(WMI_TLV_SERVICE_NLO, ar->wmi->wmi_ab->svc_map)) {
 		ar->hw->wiphy->max_sched_scan_ssids = WMI_PNO_MAX_SUPP_NETWORKS;
 		ar->hw->wiphy->max_match_sets = WMI_PNO_MAX_SUPP_NETWORKS;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5b02e95..888c587 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2181,6 +2181,8 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	cmd->num_ssids = params->num_ssids;
 	cmd->ie_len = params->extraie.len;
 	cmd->n_probes = params->n_probes;
+	ether_addr_copy(cmd->mac_addr.addr, params->mac_addr.addr);
+	ether_addr_copy(cmd->mac_mask.addr, params->mac_mask.addr);
 
 	ptr += sizeof(*cmd);
 
@@ -8983,3 +8985,31 @@ int ath11k_wmi_gtk_rekey_getinfo(struct ath11k *ar,
 		   arvif->vdev_id);
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
 }
+
+int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
+				 const u8 mac_addr[ETH_ALEN])
+{
+	struct sk_buff *skb;
+	struct wmi_scan_prob_req_oui_cmd *cmd;
+	u32 prob_req_oui;
+	int len;
+
+	prob_req_oui = (((u32)mac_addr[0]) << 16) |
+		       (((u32)mac_addr[1]) << 8) | mac_addr[2];
+
+	len = sizeof(*cmd);
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_scan_prob_req_oui_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_SCAN_PROB_REQ_OUI_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->prob_req_oui = prob_req_oui;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi scan prob req oui %d\n",
+		   prob_req_oui);
+
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_SCAN_PROB_REQ_OUI_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 61dc5ea..6848089 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3369,6 +3369,8 @@ struct scan_req_params {
 	u32 num_hint_bssid;
 	struct hint_short_ssid hint_s_ssid[WLAN_SCAN_MAX_HINT_S_SSID];
 	struct hint_bssid hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
+	struct wmi_mac_addr mac_addr;
+	struct wmi_mac_addr mac_mask;
 };
 
 struct wmi_ssid_arg {
@@ -3749,6 +3751,11 @@ struct wmi_scan_chan_list_cmd {
 	u32 pdev_id;
 } __packed;
 
+struct wmi_scan_prob_req_oui_cmd {
+	u32 tlv_header;
+	u32 prob_req_oui;
+}  __packed;
+
 #define WMI_MGMT_SEND_DOWNLD_LEN	64
 
 #define WMI_TX_PARAMS_DWORD0_POWER		GENMASK(7, 0)
@@ -6056,4 +6063,6 @@ int ath11k_wmi_gtk_rekey_offload(struct ath11k *ar,
 				 struct ath11k_vif *arvif, bool enable);
 int ath11k_wmi_gtk_rekey_getinfo(struct ath11k *ar,
 				 struct ath11k_vif *arvif);
+int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
+				 const u8 mac_addr[ETH_ALEN]);
 #endif
-- 
2.7.4

