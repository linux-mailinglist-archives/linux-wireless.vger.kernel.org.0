Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2025B35795D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 03:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhDHBMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 21:12:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21469 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhDHBMq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 21:12:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617844356; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=rh/RqCa7A5mvj+q+IdUwxsW+jPxcC9piy12YNmJF5is=; b=ku1+A+cbI2LhVWUv2pLHp2yaTx0e3wkMcL6owCHJymSmtza5NO8uPEUw3Oi6j5W8Muu27TcX
 iuzoJ0oPbtmpVnng5Thu2FZtsKx+BB+74aW9hy5TaXI7xQZ9OGuwBk0NDjbFONwUBzlLAs1W
 5ZNGuxEgrtcw1nyM18Qd0gsq6Z0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 606e588303cfff345299e75c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 01:12:35
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3F00C43463; Thu,  8 Apr 2021 01:12:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C21F1C433CA;
        Thu,  8 Apr 2021 01:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C21F1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V6 1/2] ath11k: add WMI calls to manually add/del/pause/resume TWT dialogs
Date:   Wed,  7 Apr 2021 18:12:24 -0700
Message-Id: <20210408011225.1989-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210408011225.1989-1-alokad@codeaurora.org>
References: <20210408011225.1989-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

These calls are used for debugging and will be required for WFA
certification tests.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00680-QCAHKSWPL_SILICONZ-1
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
Changes in V6
* new function ath11k_wmi_twt_add_dialog_event_status()
* re-added WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT in
  wmi_tlv_policies which was missed in V5.

Changes in V5
* Setting and resetting of twt_enabled in WMI functions
* ath11k_dbg() instead of ath11k_info() in ath11k_wmi_twt_add_dialog_event()
* Made WMI error messages more readable

 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 247 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 114 ++++++++++++
 3 files changed, 358 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 55af982deca7..b59bf2c28193 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -566,6 +566,7 @@ struct ath11k {
 #endif
 	bool dfs_block_radar_events;
 	struct ath11k_thermal thermal;
+	u8 twt_enabled;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5ca2d80679b6..ec260ca22573 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -128,6 +128,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_probe_resp_tx_status_event) },
 	[WMI_TAG_VDEV_DELETE_RESP_EVENT] = {
 		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
+	[WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT] = {
+		.min_len = sizeof(struct wmi_twt_add_dialog_event) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -2897,11 +2899,12 @@ ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id)
 	/* TODO add MBSSID support */
 	cmd->mbss_support = 0;
 
-	ret = ath11k_wmi_cmd_send(wmi, skb,
-				  WMI_TWT_ENABLE_CMDID);
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_ENABLE_CMDID);
 	if (ret) {
 		ath11k_warn(ab, "Failed to send WMI_TWT_ENABLE_CMDID");
 		dev_kfree_skb(skb);
+	} else {
+		ar->twt_enabled = 1;
 	}
 	return ret;
 }
@@ -2926,11 +2929,181 @@ ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id)
 			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
 	cmd->pdev_id = pdev_id;
 
-	ret = ath11k_wmi_cmd_send(wmi, skb,
-				  WMI_TWT_DISABLE_CMDID);
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_DISABLE_CMDID);
 	if (ret) {
 		ath11k_warn(ab, "Failed to send WMI_TWT_DISABLE_CMDID");
 		dev_kfree_skb(skb);
+	} else {
+		ar->twt_enabled = 0;
+	}
+	return ret;
+}
+
+int ath11k_wmi_send_twt_add_dialog_cmd(struct ath11k *ar,
+				       struct wmi_twt_add_dialog_params *params)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
+	struct wmi_twt_add_dialog_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_twt_add_dialog_params_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TWT_ADD_DIALOG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+
+	cmd->vdev_id = params->vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, params->peer_macaddr);
+	cmd->dialog_id = params->dialog_id;
+	cmd->wake_intvl_us = params->wake_intvl_us;
+	cmd->wake_intvl_mantis = params->wake_intvl_mantis;
+	cmd->wake_dura_us = params->wake_dura_us;
+	cmd->sp_offset_us = params->sp_offset_us;
+	cmd->flags = params->twt_cmd;
+	if (params->flag_bcast)
+		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_BCAST;
+	if (params->flag_trigger)
+		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_TRIGGER;
+	if (params->flag_flow_type)
+		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_FLOW_TYPE;
+	if (params->flag_protection)
+		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_PROTECTION;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi add twt dialog vdev %u dialog id %u wake interval %u mantissa %u wake duration %u service period offset %u flags 0x%x\n",
+		   cmd->vdev_id, cmd->dialog_id, cmd->wake_intvl_us,
+		   cmd->wake_intvl_mantis, cmd->wake_dura_us, cmd->sp_offset_us,
+		   cmd->flags);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_ADD_DIALOG_CMDID);
+
+	if (ret) {
+		ath11k_warn(ab,
+			    "failed to send wmi command to add twt dialog: %d",
+			    ret);
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
+int ath11k_wmi_send_twt_del_dialog_cmd(struct ath11k *ar,
+				       struct wmi_twt_del_dialog_params *params)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
+	struct wmi_twt_del_dialog_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_twt_del_dialog_params_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TWT_DEL_DIALOG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+
+	cmd->vdev_id = params->vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, params->peer_macaddr);
+	cmd->dialog_id = params->dialog_id;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi delete twt dialog vdev %u dialog id %u\n",
+		   cmd->vdev_id, cmd->dialog_id);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_DEL_DIALOG_CMDID);
+	if (ret) {
+		ath11k_warn(ab,
+			    "failed to send wmi command to delete twt dialog: %d",
+			    ret);
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
+int ath11k_wmi_send_twt_pause_dialog_cmd(struct ath11k *ar,
+					 struct wmi_twt_pause_dialog_params *params)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
+	struct wmi_twt_pause_dialog_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_twt_pause_dialog_params_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_TWT_PAUSE_DIALOG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+
+	cmd->vdev_id = params->vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, params->peer_macaddr);
+	cmd->dialog_id = params->dialog_id;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi pause twt dialog vdev %u dialog id %u\n",
+		   cmd->vdev_id, cmd->dialog_id);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_PAUSE_DIALOG_CMDID);
+	if (ret) {
+		ath11k_warn(ab,
+			    "failed to send wmi command to pause twt dialog: %d",
+			    ret);
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
+int ath11k_wmi_send_twt_resume_dialog_cmd(struct ath11k *ar,
+					  struct wmi_twt_resume_dialog_params *params)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
+	struct wmi_twt_resume_dialog_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_twt_resume_dialog_params_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_TWT_RESUME_DIALOG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+
+	cmd->vdev_id = params->vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, params->peer_macaddr);
+	cmd->dialog_id = params->dialog_id;
+	cmd->sp_offset_us = params->sp_offset_us;
+	cmd->next_twt_size = params->next_twt_size;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi resume twt dialog vdev %u dialog id %u service period offset %u next twt subfield size %u\n",
+		   cmd->vdev_id, cmd->dialog_id, cmd->sp_offset_us,
+		   cmd->next_twt_size);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_TWT_RESUME_DIALOG_CMDID);
+	if (ret) {
+		ath11k_warn(ab,
+			    "failed to send wmi command to resume twt dialog: %d",
+			    ret);
+		dev_kfree_skb(skb);
 	}
 	return ret;
 }
@@ -6967,6 +7140,66 @@ static void ath11k_wmi_event_wow_wakeup_host(struct ath11k_base *ab, struct sk_b
 	complete(&ab->wow.wakeup_completed);
 }
 
+static const char *ath11k_wmi_twt_add_dialog_event_status(u32 status)
+{
+	switch (status) {
+	case WMI_ADD_TWT_STATUS_OK:
+		return "ok";
+	case WMI_ADD_TWT_STATUS_TWT_NOT_ENABLED:
+		return "twt disabled";
+	case WMI_ADD_TWT_STATUS_USED_DIALOG_ID:
+		return "dialog id in use";
+	case WMI_ADD_TWT_STATUS_INVALID_PARAM:
+		return "invalid parameters";
+	case WMI_ADD_TWT_STATUS_NOT_READY:
+		return "not ready";
+	case WMI_ADD_TWT_STATUS_NO_RESOURCE:
+		return "resource unavailable";
+	case WMI_ADD_TWT_STATUS_NO_ACK:
+		return "no ack";
+	case WMI_ADD_TWT_STATUS_NO_RESPONSE:
+		return "no response";
+	case WMI_ADD_TWT_STATUS_DENIED:
+		return "denied";
+	case WMI_ADD_TWT_STATUS_UNKNOWN_ERROR:
+		fallthrough;
+	default:
+		return "unknown error";
+	}
+}
+
+static void ath11k_wmi_twt_add_dialog_event(struct ath11k_base *ab,
+					    struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_twt_add_dialog_event *ev;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab,
+			    "failed to parse wmi twt add dialog status event tlv: %d\n",
+			    ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT];
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch twt add dialog wmi event\n");
+		goto exit;
+	}
+
+	if (ev->status)
+		ath11k_warn(ab,
+			    "wmi add twt dialog event vdev %d dialog id %d status %s\n",
+			    ev->vdev_id, ev->dialog_id,
+			    ath11k_wmi_twt_add_dialog_event_status(ev->status));
+
+exit:
+	kfree(tb);
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -7059,11 +7292,17 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_OFFLOAD_PROB_RESP_TX_STATUS_EVENTID:
 		ath11k_probe_resp_tx_status_event(ab, skb);
 		break;
+	case WMI_TWT_ADD_DIALOG_EVENTID:
+		ath11k_wmi_twt_add_dialog_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
 	case WMI_TWT_ENABLE_EVENTID:
 	case WMI_TWT_DISABLE_EVENTID:
+	case WMI_TWT_DEL_DIALOG_EVENTID:
+	case WMI_TWT_PAUSE_DIALOG_EVENTID:
+	case WMI_TWT_RESUME_DIALOG_EVENTID:
 	case WMI_PDEV_DMA_RING_CFG_RSP_EVENTID:
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "ignoring unsupported event 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 3ade1ddd35c9..eb573dad67c5 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4791,6 +4791,112 @@ struct wmi_twt_disable_params_cmd {
 	u32 pdev_id;
 } __packed;
 
+enum WMI_HOST_TWT_COMMAND {
+	WMI_HOST_TWT_COMMAND_REQUEST_TWT = 0,
+	WMI_HOST_TWT_COMMAND_SUGGEST_TWT,
+	WMI_HOST_TWT_COMMAND_DEMAND_TWT,
+	WMI_HOST_TWT_COMMAND_TWT_GROUPING,
+	WMI_HOST_TWT_COMMAND_ACCEPT_TWT,
+	WMI_HOST_TWT_COMMAND_ALTERNATE_TWT,
+	WMI_HOST_TWT_COMMAND_DICTATE_TWT,
+	WMI_HOST_TWT_COMMAND_REJECT_TWT,
+};
+
+#define WMI_TWT_ADD_DIALOG_FLAG_BCAST           BIT(8)
+#define WMI_TWT_ADD_DIALOG_FLAG_TRIGGER         BIT(9)
+#define WMI_TWT_ADD_DIALOG_FLAG_FLOW_TYPE       BIT(10)
+#define WMI_TWT_ADD_DIALOG_FLAG_PROTECTION      BIT(11)
+
+struct wmi_twt_add_dialog_params_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+	u32 wake_intvl_us;
+	u32 wake_intvl_mantis;
+	u32 wake_dura_us;
+	u32 sp_offset_us;
+	u32 flags;
+} __packed;
+
+struct wmi_twt_add_dialog_params {
+	u32 vdev_id;
+	u8 peer_macaddr[ETH_ALEN];
+	u32 dialog_id;
+	u32 wake_intvl_us;
+	u32 wake_intvl_mantis;
+	u32 wake_dura_us;
+	u32 sp_offset_us;
+	u8 twt_cmd;
+	u8 flag_bcast;
+	u8 flag_trigger;
+	u8 flag_flow_type;
+	u8 flag_protection;
+} __packed;
+
+enum  wmi_twt_add_dialog_status {
+	WMI_ADD_TWT_STATUS_OK,
+	WMI_ADD_TWT_STATUS_TWT_NOT_ENABLED,
+	WMI_ADD_TWT_STATUS_USED_DIALOG_ID,
+	WMI_ADD_TWT_STATUS_INVALID_PARAM,
+	WMI_ADD_TWT_STATUS_NOT_READY,
+	WMI_ADD_TWT_STATUS_NO_RESOURCE,
+	WMI_ADD_TWT_STATUS_NO_ACK,
+	WMI_ADD_TWT_STATUS_NO_RESPONSE,
+	WMI_ADD_TWT_STATUS_DENIED,
+	WMI_ADD_TWT_STATUS_UNKNOWN_ERROR,
+};
+
+struct wmi_twt_add_dialog_event {
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+	u32 status;
+} __packed;
+
+struct wmi_twt_del_dialog_params {
+	u32 vdev_id;
+	u8 peer_macaddr[ETH_ALEN];
+	u32 dialog_id;
+} __packed;
+
+struct wmi_twt_del_dialog_params_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+} __packed;
+
+struct wmi_twt_pause_dialog_params {
+	u32 vdev_id;
+	u8 peer_macaddr[ETH_ALEN];
+	u32 dialog_id;
+} __packed;
+
+struct wmi_twt_pause_dialog_params_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+} __packed;
+
+struct wmi_twt_resume_dialog_params {
+	u32 vdev_id;
+	u8 peer_macaddr[ETH_ALEN];
+	u32 dialog_id;
+	u32 sp_offset_us;
+	u32 next_twt_size;
+} __packed;
+
+struct wmi_twt_resume_dialog_params_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+	u32 sp_offset_us;
+	u32 next_twt_size;
+} __packed;
+
 struct wmi_obss_spatial_reuse_params_cmd {
 	u32 tlv_header;
 	u32 pdev_id;
@@ -5339,6 +5445,14 @@ void ath11k_wmi_fw_stats_fill(struct ath11k *ar,
 int ath11k_wmi_simulate_radar(struct ath11k *ar);
 int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id);
 int ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id);
+int ath11k_wmi_send_twt_add_dialog_cmd(struct ath11k *ar,
+				       struct wmi_twt_add_dialog_params *params);
+int ath11k_wmi_send_twt_del_dialog_cmd(struct ath11k *ar,
+				       struct wmi_twt_del_dialog_params *params);
+int ath11k_wmi_send_twt_pause_dialog_cmd(struct ath11k *ar,
+					 struct wmi_twt_pause_dialog_params *params);
+int ath11k_wmi_send_twt_resume_dialog_cmd(struct ath11k *ar,
+					  struct wmi_twt_resume_dialog_params *params);
 int ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
 				 struct ieee80211_he_obss_pd *he_obss_pd);
 int ath11k_wmi_pdev_set_srg_bss_color_bitmap(struct ath11k *ar, u32 *bitmap);

base-commit: 1924a31a1d7c49a87dad0c6df7a3bff3d68cc462
-- 
2.25.0

