Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55051C400F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgEDQhm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 12:37:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19060 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729525AbgEDQhm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 12:37:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588610260; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=UtcerFtustCSgKOFDYg3WB9iGLAfHwaOZXP8d7yCVGs=; b=wbYTPDBGDRYb5n1r4R8zMOWoltAod1CULbFDTcOmE0Wm/+KMTWDz0M8FkYDDxijNCS7XQMko
 5pWtGjB3iFONvo1XS1CltZ1or/T8woqsSkJovumfV5/kD72OM2nxrvADMsOlJOMyTbc/ItGG
 RkbqMhJ/D7Ftlqe+SO14QLvT/MY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb044cb.7efc0afd24c8-smtp-out-n04;
 Mon, 04 May 2020 16:37:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CD02C433F2; Mon,  4 May 2020 16:37:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from cheath10p342229-lin.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A6DDC433CB;
        Mon,  4 May 2020 16:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A6DDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ashok Raj Nagarajan <arnagara@codeaurora.org>,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH] ath11k: Add support to reset htt peer stats
Date:   Mon,  4 May 2020 22:05:47 +0530
Message-Id: <1588610147-20231-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ashok Raj Nagarajan <arnagara@codeaurora.org>

This patch add supports to reset the per peer htt stats.

Usage:

echo 1 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/stations/<peer MAC addr>/htt_peer_stats_reset

While doing so, sync the wmi services between FW and host.

Signed-off-by: Ashok Raj Nagarajan <arnagara@codeaurora.org>
Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debug.h       |  2 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 67 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h         | 37 +++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 45454fc..f8aa48e 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -80,6 +80,8 @@ struct ath_pktlog_hdr {
 	u8 payload[0];
 };
 
+#define ATH11K_HTT_PEER_STATS_RESET BIT(16)
+
 #define ATH11K_HTT_STATS_BUF_SIZE (1024 * 512)
 #define ATH11K_FW_STATS_BUF_SIZE (1024 * 1024)
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 68963cf..6b720ee 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -8,6 +8,8 @@
 #include "core.h"
 #include "peer.h"
 #include "debug.h"
+#include "dp_tx.h"
+#include "debug_htt_stats.h"
 
 void
 ath11k_accumulate_per_peer_tx_stats(struct ath11k_sta *arsta,
@@ -749,6 +751,66 @@ static ssize_t ath11k_dbg_sta_write_aggr_mode(struct file *file,
 	.llseek = default_llseek,
 };
 
+static ssize_t
+ath11k_write_htt_peer_stats_reset(struct file *file,
+				  const char __user *user_buf,
+				  size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	int ret;
+	u8 type;
+
+	ret = kstrtou8_from_user(user_buf, count, 0, &type);
+	if (ret)
+		return ret;
+
+	if (!type)
+		return ret;
+
+	mutex_lock(&ar->conf_mutex);
+	cfg_params.cfg0 = HTT_STAT_PEER_INFO_MAC_ADDR;
+	cfg_params.cfg0 |= FIELD_PREP(GENMASK(15, 1),
+				HTT_PEER_STATS_REQ_MODE_FLUSH_TQM);
+
+	cfg_params.cfg1 = HTT_STAT_DEFAULT_PEER_REQ_TYPE;
+
+	cfg_params.cfg2 |= FIELD_PREP(GENMASK(7, 0), sta->addr[0]);
+	cfg_params.cfg2 |= FIELD_PREP(GENMASK(15, 8), sta->addr[1]);
+	cfg_params.cfg2 |= FIELD_PREP(GENMASK(23, 16), sta->addr[2]);
+	cfg_params.cfg2 |= FIELD_PREP(GENMASK(31, 24), sta->addr[3]);
+
+	cfg_params.cfg3 |= FIELD_PREP(GENMASK(7, 0), sta->addr[4]);
+	cfg_params.cfg3 |= FIELD_PREP(GENMASK(15, 8), sta->addr[5]);
+
+	cfg_params.cfg3 |= ATH11K_HTT_PEER_STATS_RESET;
+
+	ret = ath11k_dp_tx_htt_h2t_ext_stats_req(ar,
+						 ATH11K_DBG_HTT_EXT_STATS_PEER_INFO,
+						 &cfg_params,
+						 0ULL);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send htt peer stats request: %d\n", ret);
+		mutex_unlock(&ar->conf_mutex);
+		return ret;
+	}
+
+	mutex_unlock(&ar->conf_mutex);
+
+	ret = count;
+
+	return ret;
+}
+
+static const struct file_operations fops_htt_peer_stats_reset = {
+	.write = ath11k_write_htt_peer_stats_reset,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir)
 {
@@ -771,4 +833,9 @@ void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	debugfs_create_file("addba", 0200, dir, sta, &fops_addba);
 	debugfs_create_file("addba_resp", 0200, dir, sta, &fops_addba_resp);
 	debugfs_create_file("delba", 0200, dir, sta, &fops_delba);
+
+	if (test_bit(WMI_TLV_SERVICE_PER_PEER_HTT_STATS_RESET,
+		     ar->ab->wmi_ab.svc_map))
+		debugfs_create_file("htt_peer_stats_reset", 0600, dir, sta,
+				    &fops_htt_peer_stats_reset);
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index ba05935..a47c6a6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1976,6 +1976,43 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_TX_DATA_MGMT_ACK_RSSI = 174,
 	WMI_TLV_SERVICE_NAN_DISABLE_SUPPORT = 175,
 	WMI_TLV_SERVICE_HTT_H2T_NO_HTC_HDR_LEN_IN_MSG_LEN = 176,
+	WMI_TLV_SERVICE_COEX_SUPPORT_UNEQUAL_ISOLATION = 177,
+	WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT = 178,
+	WMI_TLV_SERVICE_SUPPORT_EXTEND_ADDRESS = 179,
+	WMI_TLV_SERVICE_BEACON_RECEPTION_STATS = 180,
+	WMI_TLV_SERVICE_FETCH_TX_PN = 181,
+	WMI_TLV_SERVICE_PEER_UNMAP_RESPONSE_SUPPORT = 182,
+	WMI_TLV_SERVICE_TX_PER_PEER_AMPDU_SIZE = 183,
+	WMI_TLV_SERVICE_BSS_COLOR_SWITCH_COUNT = 184,
+	WMI_TLV_SERVICE_HTT_PEER_STATS_SUPPORT = 185,
+	WMI_TLV_SERVICE_UL_RU26_ALLOWED = 186,
+	WMI_TLV_SERVICE_GET_MWS_COEX_STATE = 187,
+	WMI_TLV_SERVICE_GET_MWS_DPWB_STATE = 188,
+	WMI_TLV_SERVICE_GET_MWS_TDM_STATE = 189,
+	WMI_TLV_SERVICE_GET_MWS_IDRX_STATE = 190,
+	WMI_TLV_SERVICE_GET_MWS_ANTENNA_SHARING_STATE = 191,
+	WMI_TLV_SERVICE_ENHANCED_TPC_CONFIG_EVENT = 192,
+	WMI_TLV_SERVICE_WLM_STATS_REQUEST = 193,
+	WMI_TLV_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT = 194,
+	WMI_TLV_SERVICE_WPA3_FT_SAE_SUPPORT = 195,
+	WMI_TLV_SERVICE_WPA3_FT_SUITE_B_SUPPORT = 196,
+	WMI_TLV_SERVICE_VOW_ENABLE = 197,
+	WMI_TLV_SERVICE_CFR_CAPTURE_IND_EVT_TYPE_1 = 198,
+	WMI_TLV_SERVICE_BROADCAST_TWT = 199,
+	WMI_TLV_SERVICE_RAP_DETECTION_SUPPORT = 200,
+	WMI_TLV_SERVICE_PS_TDCC = 201,
+	WMI_TLV_SERVICE_THREE_WAY_COEX_CONFIG_LEGACY   = 202,
+	WMI_TLV_SERVICE_THREE_WAY_COEX_CONFIG_OVERRIDE = 203,
+	WMI_TLV_SERVICE_TX_PWR_PER_PEER = 204,
+	WMI_TLV_SERVICE_STA_PLUS_STA_SUPPORT = 205,
+	WMI_TLV_SERVICE_WPA3_FT_FILS = 206,
+	WMI_TLV_SERVICE_ADAPTIVE_11R_ROAM = 207,
+	WMI_TLV_SERVICE_CHAN_RF_CHARACTERIZATION_INFO = 208,
+	WMI_TLV_SERVICE_FW_IFACE_COMBINATION_SUPPORT = 209,
+	WMI_TLV_SERVICE_TX_COMPL_TSF64 = 210,
+	WMI_TLV_SERVICE_DSM_ROAM_FILTER = 211,
+	WMI_TLV_SERVICE_PACKET_CAPTURE_SUPPORT = 212,
+	WMI_TLV_SERVICE_PER_PEER_HTT_STATS_RESET = 213,
 
 	WMI_MAX_EXT_SERVICE
 
-- 
1.9.1
