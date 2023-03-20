Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98DD6C1CE1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 17:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjCTQxO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjCTQwv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 12:52:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD38DBD4
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 09:44:43 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KCYfRZ012267;
        Mon, 20 Mar 2023 16:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0mJQqY0oGkzB9jiHI9vvpQXCd8AnpanNOaVldmBt824=;
 b=EzYLOoqjpXzCxTuH+zjc4ugOGObEcU63OLT3+zrozHTZsVir71aZyax6ceIcMa6tRG6V
 I4BZJ2b+yUv8stCwwqSVNDxHHKy+lTYkeojvp7z/P7pxGOvTWspxAlt2VTzLIV5Jgtjg
 ORn0hvVnUTDn+HfPG+n2NVwZV+175+Ni0qsvKt6YWbWFfVyshX7tzFey8IBgPAg8YVDK
 4saC7db9ZcLHchC7b3HFze0Efgf0Z18iqhc4RmNripte520ukrP8Xm3Vtaz8Ruyxq+GA
 mXEbc8V8GVNydtSJvVJuos/uRyHWvgvOCx7XOighk+u+18/DQ9nG3oQGeKb8rYkTxYzS aA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pek4fhb7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:44:10 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KGi9aP025236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:44:09 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 09:44:07 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH v2 4/4] wifi: ath11k: add AP power save support
Date:   Mon, 20 Mar 2023 22:13:34 +0530
Message-ID: <20230320164334.3325886-5-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320164334.3325886-1-quic_mkenna@quicinc.com>
References: <20230320164334.3325886-1-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KpyhKZLDxuv6TKsvPgH_u8RJjV2-C076
X-Proofpoint-ORIG-GUID: KpyhKZLDxuv6TKsvPgH_u8RJjV2-C076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_14,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

AP goes into the power save mode if no stations
are connected and it will come out of power save
as and when any of the station associate to it.

Driver will advertise this flag SUPPORTS_AP_PS to
enable the AP power save in mac80211.

This AP power save capability can be used to save
power with the drawback of reduced range or delayed
discovery of the AP.

This feature is enabled in QCN9074, IPQ8074, IPQ5018, QCN6122.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  8 ++++
 drivers/net/wireless/ath/ath11k/core.h |  8 ++++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 58 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 32 ++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  |  8 ++++
 6 files changed, 115 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 75fdbe4ef83a..5cf9203b751e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -117,6 +117,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.ftm_responder = true,
+		.supports_ap_ps = true,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -200,6 +201,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
 		.ftm_responder = true,
+		.supports_ap_ps = true,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -285,6 +287,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
 		.ftm_responder = false,
+		.supports_ap_ps = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -367,6 +370,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
 		.ftm_responder = true,
+		.supports_ap_ps = true,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -452,6 +456,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
 		.ftm_responder = false,
+		.supports_ap_ps = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -535,6 +540,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
 		.ftm_responder = false,
+		.supports_ap_ps = false,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -616,6 +622,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = true,
 		.support_fw_mac_sequence = true,
 		.ftm_responder = false,
+		.supports_ap_ps = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ5018_HW10,
@@ -696,6 +703,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
 		.ftm_responder = true,
+		.supports_ap_ps = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0830276e5028..fefb1fb5220d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -363,6 +363,7 @@ struct ath11k_vif {
 	struct ieee80211_chanctx_conf chanctx;
 	struct ath11k_arp_ns_offload arp_ns_offload;
 	struct ath11k_rekey_data rekey_data;
+	bool vif_ap_ps_enabled;
 
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct dentry *debugfs_twt;
@@ -589,6 +590,11 @@ struct ath11k_per_peer_tx_stats {
 #define ATH11K_FLUSH_TIMEOUT (5 * HZ)
 #define ATH11K_VDEV_DELETE_TIMEOUT_HZ (5 * HZ)
 
+enum ath11k_ap_ps_state {
+	ATH11K_AP_PS_STATE_OFF,
+	ATH11K_AP_PS_STATE_ON,
+};
+
 struct ath11k {
 	struct ath11k_base *ab;
 	struct ath11k_pdev *pdev;
@@ -732,6 +738,8 @@ struct ath11k {
 	/* protected by conf_mutex */
 	bool ps_state_enable;
 	bool ps_timekeeper_enable;
+	bool ap_ps_enabled;
+	enum ath11k_ap_ps_state ap_ps_state;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 0be4e1232384..40953e117cc5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -225,6 +225,7 @@ struct ath11k_hw_params {
 	bool smp2p_wow_exit;
 	bool support_fw_mac_sequence;
 	bool ftm_responder;
+	bool supports_ap_ps;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cad832e0e6b8..db0d772ff7c7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3215,6 +3215,43 @@ static int ath11k_mac_config_obss_pd(struct ath11k *ar,
 	return 0;
 }
 
+void ath11k_mac_ap_ps_recalc(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+	enum ath11k_ap_ps_state state = ATH11K_AP_PS_STATE_OFF;
+	int ret;
+	bool allow_ap_ps = true;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->vdev_type == WMI_VDEV_TYPE_STA ||
+		    !arvif->vif_ap_ps_enabled) {
+			allow_ap_ps = false;
+			break;
+		}
+	}
+
+	if (!allow_ap_ps)
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "ap ps is not allowed\n");
+
+	if (allow_ap_ps && !ar->num_stations && ar->ap_ps_enabled)
+		state = ATH11K_AP_PS_STATE_ON;
+
+	if (ar->ap_ps_state == state)
+		return;
+
+	ret = ath11k_wmi_pdev_ap_ps_cmd_send(ar, ar->pdev->pdev_id, state);
+	if (ret) {
+		ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+			   "failed to send ap ps command pdev_id %u state %u\n",
+			   ar->pdev->pdev_id, state);
+		return;
+	}
+
+	ar->ap_ps_state = state;
+}
+
 static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   struct ieee80211_bss_conf *info,
@@ -3567,6 +3604,16 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			   vif->addr, arvif->arp_ns_offload.ipv4_addr);
 	}
 
+	if ((changed & BSS_CHANGED_PS) && vif->type == NL80211_IFTYPE_AP) {
+		if (!info->ap_ps_enable)
+			arvif->vif_ap_ps_enabled = false;
+		else
+			arvif->vif_ap_ps_enabled = true;
+
+		ar->ap_ps_enabled = info->ap_ps_enable;
+		ath11k_mac_ap_ps_recalc(ar);
+	}
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -4651,6 +4698,8 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "Added peer: %pM for VDEV: %d\n",
 		   sta->addr, arvif->vdev_id);
 
+	ath11k_mac_ap_ps_recalc(ar);
+
 	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar)) {
 		arsta->tx_stats = kzalloc(sizeof(*arsta->tx_stats), GFP_KERNEL);
 		if (!arsta->tx_stats) {
@@ -4810,6 +4859,8 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 
 		kfree(arsta->rx_stats);
 		arsta->rx_stats = NULL;
+
+		ath11k_mac_ap_ps_recalc(ar);
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_ASSOC &&
 		   (vif->type == NL80211_IFTYPE_AP ||
@@ -6599,6 +6650,8 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				    ret);
 	}
 
+	ath11k_mac_ap_ps_recalc(ar);
+
 	mutex_unlock(&ar->conf_mutex);
 
 	return 0;
@@ -6703,6 +6756,8 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 
 	ath11k_debugfs_remove_interface(arvif);
 
+	ath11k_mac_ap_ps_recalc(ar);
+
 	/* TODO: recal traffic pause state based on the available vdevs */
 
 	mutex_unlock(&ar->conf_mutex);
@@ -9122,6 +9177,9 @@ static int __ath11k_mac_register(struct ath11k *ar)
 		ieee80211_hw_set(ar->hw, USES_RSS);
 	}
 
+	if (ar->ab->hw_params.supports_ap_ps)
+		ieee80211_hw_set(ar->hw, SUPPORTS_AP_PS);
+
 	ar->hw->wiphy->features |= NL80211_FEATURE_STATIC_SMPS;
 	ar->hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 27f3fceb33c5..02b14ba6ad45 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1290,6 +1290,38 @@ ath11k_wmi_rx_reord_queue_remove(struct ath11k *ar,
 	return ret;
 }
 
+int ath11k_wmi_pdev_ap_ps_cmd_send(struct ath11k *ar, u32 pdev_id,
+				   u32 param_value)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_pdev_ap_ps_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_ap_ps_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_PDEV_GREEN_AP_PS_ENABLE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->pdev_id = pdev_id;
+	cmd->param_value = param_value;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_PDEV_GREEN_AP_PS_ENABLE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send ap ps enable/disable cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi pdev ap ps set pdev id %d value %d\n",
+		    pdev_id, param_value);
+
+	return ret;
+}
+
 int ath11k_wmi_pdev_set_param(struct ath11k *ar, u32 param_id,
 			      u32 param_value, u8 pdev_id)
 {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b23b7a22bc9a..8b37dd935a95 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3037,6 +3037,12 @@ struct wmi_fwtest_set_param_cmd_param {
 	u32 param_value;
 };
 
+struct wmi_pdev_ap_ps_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 param_value;
+} __packed;
+
 struct wmi_pdev_set_param_cmd {
 	u32 tlv_header;
 	u32 pdev_id;
@@ -6445,5 +6451,7 @@ int ath11k_wmi_pdev_set_bios_sar_table_param(struct ath11k *ar, const u8 *sar_va
 int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar);
 int ath11k_wmi_sta_keepalive(struct ath11k *ar,
 			     const struct wmi_sta_keepalive_arg *arg);
+int ath11k_wmi_pdev_ap_ps_cmd_send(struct ath11k *ar, u32 pdev_id,
+				   u32 value);
 
 #endif
-- 
2.25.1

