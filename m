Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E869E20C91C
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2020 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgF1RCe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jun 2020 13:02:34 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:39531 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbgF1RCe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jun 2020 13:02:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593363753; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=DU8ZU2MJ5uByVOri1ezZlBjRg2J/nMH9W0fUTW7kFYE=; b=bKoBVMP7wA6Sjr6atsrLOsK1dRhXEcNlqEN1ACITdMWzMzzu+UamGYW7pVFxWIjxcZK6sI9g
 WdRcZE8Nx/Hk+/InMpi6mFJLck+TSURdn/2NxP8aaRebJqQLQpB9i52aEg1VEO2uo3pQ7wyf
 /d4jgAajIFYGfb+ZQ9Y0TM89YIM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ef8cd120206ad41d1cad360 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 28 Jun 2020 17:02:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C48AEC433CA; Sun, 28 Jun 2020 17:02:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tamizhr-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0E1AC433CB;
        Sun, 28 Jun 2020 17:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0E1AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH 1/4] ath10k: Add wmi command support for station specific TID config
Date:   Sun, 28 Jun 2020 22:31:55 +0530
Message-Id: <1593363718-5148-2-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593363718-5148-1-git-send-email-tamizhr@codeaurora.org>
References: <1593363718-5148-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds WMI interface to configure station specific
TID configuration . Host needs to send station's MAC address
along with TID number and its configuration to target through
WMI_10_4_PER_PEER_PER_TID_CONFIG_CMDID.

WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT flag is added to advertise
this support.

Testing:
   * Tested HW: QCA9888
   * Tested FW: 10.4-3.5.1-00052

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/wmi-ops.h | 19 +++++++++++
 drivers/net/wireless/ath/ath10k/wmi.c     | 32 +++++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi.h     | 52 +++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-ops.h b/drivers/net/wireless/ath/ath10k/wmi-ops.h
index 0dd484f..fc9e3ae 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-ops.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-ops.h
@@ -224,6 +224,8 @@ struct wmi_ops {
 	struct sk_buff *(*gen_bb_timing)
 			(struct ath10k *ar,
 			 const struct wmi_bb_timing_cfg_arg *arg);
+	struct sk_buff *(*gen_per_peer_per_tid_cfg)(struct ath10k *ar,
+				const struct wmi_per_peer_per_tid_cfg_arg *arg);
 
 };
 
@@ -1656,4 +1658,21 @@ struct wmi_ops {
 	return ath10k_wmi_cmd_send(ar, skb,
 				   ar->wmi.cmd->set_bb_timing_cmdid);
 }
+
+static inline int
+ath10k_wmi_set_per_peer_per_tid_cfg(struct ath10k *ar,
+				const struct wmi_per_peer_per_tid_cfg_arg *arg)
+{
+	struct sk_buff *skb;
+
+	if (!ar->wmi.ops->gen_per_peer_per_tid_cfg)
+		return -EOPNOTSUPP;
+
+	skb = ar->wmi.ops->gen_per_peer_per_tid_cfg(ar, arg);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	return ath10k_wmi_cmd_send(ar, skb,
+				   ar->wmi.cmd->per_peer_per_tid_config_cmdid);
+}
 #endif
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index a81a1ab..4316551 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -740,6 +740,7 @@
 	.tdls_peer_update_cmdid = WMI_10_4_TDLS_PEER_UPDATE_CMDID,
 	.tdls_set_offchan_mode_cmdid = WMI_10_4_TDLS_SET_OFFCHAN_MODE_CMDID,
 	.radar_found_cmdid = WMI_10_4_RADAR_FOUND_CMDID,
+	.per_peer_per_tid_config_cmdid = WMI_10_4_PER_PEER_PER_TID_CONFIG_CMDID,
 };
 
 static struct wmi_peer_param_map wmi_peer_param_map = {
@@ -9005,6 +9006,36 @@ static u32 ath10k_wmi_prepare_peer_qos(u8 uapsd_queues, u8 sp)
 }
 
 static struct sk_buff *
+ath10k_wmi_10_4_gen_per_peer_per_tid_cfg(struct ath10k *ar,
+				const struct wmi_per_peer_per_tid_cfg_arg *arg)
+{
+	struct wmi_peer_per_tid_cfg_cmd *cmd;
+	struct sk_buff *skb;
+
+	skb = ath10k_wmi_alloc_skb(ar, sizeof(*cmd));
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	memset(skb->data, 0, sizeof(*cmd));
+
+	cmd = (struct wmi_peer_per_tid_cfg_cmd *)skb->data;
+	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
+	ether_addr_copy(cmd->peer_macaddr.addr, arg->peer_macaddr.addr);
+	cmd->tid = cpu_to_le32(arg->tid);
+	cmd->ack_policy = cpu_to_le32(arg->ack_policy);
+	cmd->aggr_control = cpu_to_le32(arg->aggr_control);
+	cmd->rate_control = cpu_to_le32(arg->rate_ctrl);
+	cmd->retry_count = cpu_to_le32(arg->retry_count);
+	cmd->rcode_flags = cpu_to_le32(arg->rcode_flags);
+
+	ath10k_dbg(ar, ATH10K_DBG_WMI,
+		   "wmi noack tid %d vdev id %d ack_policy %d aggr %u rate_ctrl %u rcflag %u retry_count %d mac_addr %pM\n",
+		   arg->tid, arg->vdev_id, arg->ack_policy, arg->aggr_control, arg->rate_ctrl,
+		   arg->rcode_flags, arg->retry_count, arg->peer_macaddr.addr);
+	return skb;
+}
+
+static struct sk_buff *
 ath10k_wmi_op_gen_echo(struct ath10k *ar, u32 value)
 {
 	struct wmi_echo_cmd *cmd;
@@ -9413,6 +9444,7 @@ static u32 ath10k_wmi_prepare_peer_qos(u8 uapsd_queues, u8 sp)
 	.gen_pdev_get_tpc_table_cmdid =
 			ath10k_wmi_10_4_op_gen_pdev_get_tpc_table_cmdid,
 	.gen_radar_found = ath10k_wmi_10_4_gen_radar_found,
+	.gen_per_peer_per_tid_cfg = ath10k_wmi_10_4_gen_per_peer_per_tid_cfg,
 
 	/* shared with 10.2 */
 	.pull_echo_ev = ath10k_wmi_op_pull_echo_ev,
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 511144b..7fed735 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -203,6 +203,7 @@ enum wmi_service {
 	WMI_SERVICE_SYNC_DELETE_CMDS,
 	WMI_SERVICE_TX_PWR_PER_PEER,
 	WMI_SERVICE_SUPPORT_EXTEND_ADDRESS,
+	WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT,
 
 	/* Remember to add the new value to wmi_service_name()! */
 
@@ -503,6 +504,7 @@ static inline char *wmi_service_name(enum wmi_service service_id)
 	SVCSTR(WMI_SERVICE_SYNC_DELETE_CMDS);
 	SVCSTR(WMI_SERVICE_TX_PWR_PER_PEER);
 	SVCSTR(WMI_SERVICE_SUPPORT_EXTEND_ADDRESS);
+	SVCSTR(WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT);
 
 	case WMI_SERVICE_MAX:
 		return NULL;
@@ -834,6 +836,8 @@ static inline void wmi_10_4_svc_map(const __le32 *in, unsigned long *out,
 	       WMI_SERVICE_TX_PWR_PER_PEER, len);
 	SVCMAP(WMI_10_4_SERVICE_RESET_CHIP,
 	       WMI_SERVICE_RESET_CHIP, len);
+	SVCMAP(WMI_10_4_SERVICE_PEER_TID_CONFIGS_SUPPORT,
+	       WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT, len);
 }
 
 #undef SVCMAP
@@ -1036,6 +1040,7 @@ struct wmi_cmd_map {
 	u32 tdls_set_offchan_mode_cmdid;
 	u32 radar_found_cmdid;
 	u32 set_bb_timing_cmdid;
+	u32 per_peer_per_tid_config_cmdid;
 };
 
 /*
@@ -1877,6 +1882,8 @@ enum wmi_10_4_cmd_id {
 	WMI_10_4_PDEV_SET_BRIDGE_MACADDR_CMDID,
 	WMI_10_4_ATF_GROUP_WMM_AC_CONFIG_REQUEST_CMDID,
 	WMI_10_4_RADAR_FOUND_CMDID,
+	WMI_10_4_PEER_CFR_CAPTURE_CMDID,
+	WMI_10_4_PER_PEER_PER_TID_CONFIG_CMDID,
 	WMI_10_4_PDEV_UTF_CMDID = WMI_10_4_END_CMDID - 1,
 };
 
@@ -7220,6 +7227,51 @@ struct wmi_tdls_peer_event {
 	__le32 vdev_id;
 } __packed;
 
+enum wmi_tid_aggr_control_conf {
+	WMI_TID_CONFIG_AGGR_CONTROL_IGNORE,
+	WMI_TID_CONFIG_AGGR_CONTROL_ENABLE,
+	WMI_TID_CONFIG_AGGR_CONTROL_DISABLE,
+};
+
+enum wmi_noack_tid_conf {
+	WMI_NOACK_TID_CONFIG_IGNORE_ACK_POLICY,
+	WMI_PEER_TID_CONFIG_ACK,
+	WMI_PEER_TID_CONFIG_NOACK,
+};
+
+enum wmi_tid_rate_ctrl_conf {
+	WMI_TID_CONFIG_RATE_CONTROL_IGNORE,
+	WMI_TID_CONFIG_RATE_CONTROL_AUTO,
+	WMI_TID_CONFIG_RATE_CONTROL_FIXED_RATE,
+	WMI_TID_CONFIG_RATE_CONTROL_DEFAULT_LOWEST_RATE,
+};
+
+struct wmi_per_peer_per_tid_cfg_arg {
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 tid;
+	enum wmi_noack_tid_conf ack_policy;
+	enum wmi_tid_aggr_control_conf aggr_control;
+	u8 rate_ctrl;
+	u32 retry_count;
+	u32 rcode_flags;
+};
+
+struct wmi_peer_per_tid_cfg_cmd {
+	__le32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	__le32 tid;
+
+	/* see enum wmi_noack_tid_conf */
+	__le32 ack_policy;
+	/* see enum wmi_tid_aggr_control_conf */
+	__le32 aggr_control;
+	/* see enum wmi_tid_rate_ctrl_conf */
+	__le32 rate_control;
+	__le32 rcode_flags;
+	__le32 retry_count;
+} __packed;
+
 enum wmi_txbf_conf {
 	WMI_TXBF_CONF_UNSUPPORTED,
 	WMI_TXBF_CONF_BEFORE_ASSOC,
-- 
1.9.1

