Return-Path: <linux-wireless+bounces-7431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB48C1E5C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 08:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBCC1C20DF8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 06:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DE515CD7D;
	Fri, 10 May 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GK8aGYZR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2513F456
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 06:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323692; cv=none; b=PlN9GDC2QJZeryikYFD+QJq/TvJMStnSyumS8diVwMNal6Z8+vjVCkAts95q9R8+JqrgEN+fjKFSAgIP/nJFiGgffcsrV+JwSxDCHob6YbcSHfFo62PrpdT6hZglClhQ0ixv5U2drGhgZ59lWoSEUYDICxg4W4Ytz+z0QG9ue1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323692; c=relaxed/simple;
	bh=WZVf12nTeEQMZ73ZQBl84Zr0IpoxCRkrh72tw/ksMUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpxz2Cbu1QW9neRKjidC/36+RlmCHLFJpvL5Rmn7UkRDs+oWfU1cHIaWFCKIch6BU2YXR6eIXa9G6mWprhLxNV/bIqydxrP7rrZ+fJrasIU3KrldrKhhViRqQ0p9zeSVlUzaM8J0rDeO/RTKx/FqjRt4ylBuoI/P/U74w8VJw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GK8aGYZR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2ti7H000333;
	Fri, 10 May 2024 06:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2Kr+J6r4xV39zISUfk7e5HkDZAKK6EacJ13cgLGaJ3M=; b=GK
	8aGYZRgqC0hssvCFRr4ai5AUv+dCn7nodD96La015mFYaAJ+PHLBefQlaG03nuBC
	9qi2U0/z6vI8gWgD1H2AhlXumQDhmIMnxhwZc5nyYT9+AqQDmcUyLrghjZtQIr0h
	QHK1baao6n6DN6JzIQBR3C5EibcHhITUUzXKIJN6+QhSqJyO6d/g805A7cHwSA2L
	oWhaexux9i5nbhK9VotwJFu2Fylxzu82xjnlbz6H6MDJCJI9OHQLs9I+jHWxAkoJ
	OBtbYS9T7TKYDVrWlUAADYgyKPLp3mDtum5hC9fjd/Xjtu89IvR3Mjcul9j4oWes
	tGSwwS3WMu6l91SBJsDQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w28sv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 06:48:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A6m4F5004605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 06:48:04 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 May 2024 23:48:03 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 3/7] wifi: ath12k: add WoW net-detect functionality
Date: Fri, 10 May 2024 14:47:44 +0800
Message-ID: <20240510064748.369452-4-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510064748.369452-1-quic_bqiang@quicinc.com>
References: <20240510064748.369452-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1YkCW5TtZPzZmbwjtYuVqP89NntBJEPB
X-Proofpoint-GUID: 1YkCW5TtZPzZmbwjtYuVqP89NntBJEPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100047

Implement net-detect feature by setting flag
WIPHY_WOWLAN_NET_DETECT if firmware supports this
feature. Driver sets the related PNO configuration
to firmware before entering WoW and firmware then
scans periodically and wakes up host if a specific
SSID is found.

Note that firmware crashes if we enable it for both
P2P vdev and station vdev simultaneously because
firmware can only support one vdev at a time. Since
there is rare scenario for a P2P vdev to do net-detect,
skip it for P2P vdevs.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   2 +
 drivers/net/wireless/ath/ath12k/mac.c  |  12 ++
 drivers/net/wireless/ath/ath12k/wmi.c  | 144 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h  | 169 +++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.c  | 199 ++++++++++++++++++++++++-
 5 files changed, 523 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 40774561ff6f..acd4db7daafb 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -630,6 +630,8 @@ struct ath12k {
 
 	u32 freq_low;
 	u32 freq_high;
+
+	bool nlo_enabled;
 };
 
 struct ath12k_hw {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 68f3d9a1789e..37d4b72df4c5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8765,6 +8765,18 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 		ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	}
 
+	if (test_bit(WMI_TLV_SERVICE_NLO, ar->wmi->wmi_ab->svc_map)) {
+		wiphy->max_sched_scan_ssids = WMI_PNO_MAX_SUPP_NETWORKS;
+		wiphy->max_match_sets = WMI_PNO_MAX_SUPP_NETWORKS;
+		wiphy->max_sched_scan_ie_len = WMI_PNO_MAX_IE_LENGTH;
+		wiphy->max_sched_scan_plans = WMI_PNO_MAX_SCHED_SCAN_PLANS;
+		wiphy->max_sched_scan_plan_interval =
+					WMI_PNO_MAX_SCHED_SCAN_PLAN_INT;
+		wiphy->max_sched_scan_plan_iterations =
+					WMI_PNO_MAX_SCHED_SCAN_PLAN_ITRNS;
+		wiphy->features |= NL80211_FEATURE_ND_RANDOM_MAC_ADDR;
+	}
+
 	ret = ath12k_wow_init(ar);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to init wow: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4e6cb0f99c7a..f337f2197578 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7575,3 +7575,147 @@ int ath12k_wmi_wow_del_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id)
 
 	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
 }
+
+static struct sk_buff *
+ath12k_wmi_op_gen_config_pno_start(struct ath12k *ar, u32 vdev_id,
+				   struct wmi_pno_scan_req_arg *pno)
+{
+	struct nlo_configured_params *nlo_list;
+	size_t len, nlo_list_len, channel_list_len;
+	struct wmi_wow_nlo_config_cmd *cmd;
+	__le32 *channel_list;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	void *ptr;
+	u32 i;
+
+	len = sizeof(*cmd) +
+	      sizeof(*tlv) +
+	      /* TLV place holder for array of structures
+	       * nlo_configured_params(nlo_list)
+	       */
+	      sizeof(*tlv);
+	      /* TLV place holder for array of uint32 channel_list */
+
+	channel_list_len = sizeof(u32) * pno->a_networks[0].channel_count;
+	len += channel_list_len;
+
+	nlo_list_len = sizeof(*nlo_list) * pno->uc_networks_count;
+	len += nlo_list_len;
+
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	ptr = skb->data;
+	cmd = ptr;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_NLO_CONFIG_CMD, sizeof(*cmd));
+
+	cmd->vdev_id = cpu_to_le32(pno->vdev_id);
+	cmd->flags = cpu_to_le32(WMI_NLO_CONFIG_START | WMI_NLO_CONFIG_SSID_HIDE_EN);
+
+	/* current FW does not support min-max range for dwell time */
+	cmd->active_dwell_time = cpu_to_le32(pno->active_max_time);
+	cmd->passive_dwell_time = cpu_to_le32(pno->passive_max_time);
+
+	if (pno->do_passive_scan)
+		cmd->flags |= cpu_to_le32(WMI_NLO_CONFIG_SCAN_PASSIVE);
+
+	cmd->fast_scan_period = cpu_to_le32(pno->fast_scan_period);
+	cmd->slow_scan_period = cpu_to_le32(pno->slow_scan_period);
+	cmd->fast_scan_max_cycles = cpu_to_le32(pno->fast_scan_max_cycles);
+	cmd->delay_start_time = cpu_to_le32(pno->delay_start_time);
+
+	if (pno->enable_pno_scan_randomization) {
+		cmd->flags |= cpu_to_le32(WMI_NLO_CONFIG_SPOOFED_MAC_IN_PROBE_REQ |
+					  WMI_NLO_CONFIG_RANDOM_SEQ_NO_IN_PROBE_REQ);
+		ether_addr_copy(cmd->mac_addr.addr, pno->mac_addr);
+		ether_addr_copy(cmd->mac_mask.addr, pno->mac_addr_mask);
+	}
+
+	ptr += sizeof(*cmd);
+
+	/* nlo_configured_params(nlo_list) */
+	cmd->no_of_ssids = cpu_to_le32(pno->uc_networks_count);
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, nlo_list_len);
+
+	ptr += sizeof(*tlv);
+	nlo_list = ptr;
+	for (i = 0; i < pno->uc_networks_count; i++) {
+		tlv = (struct wmi_tlv *)(&nlo_list[i].tlv_header);
+		tlv->header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_ARRAY_BYTE,
+						     sizeof(*nlo_list));
+
+		nlo_list[i].ssid.valid = cpu_to_le32(1);
+		nlo_list[i].ssid.ssid.ssid_len =
+			cpu_to_le32(pno->a_networks[i].ssid.ssid_len);
+		memcpy(nlo_list[i].ssid.ssid.ssid,
+		       pno->a_networks[i].ssid.ssid,
+		       le32_to_cpu(nlo_list[i].ssid.ssid.ssid_len));
+
+		if (pno->a_networks[i].rssi_threshold &&
+		    pno->a_networks[i].rssi_threshold > -300) {
+			nlo_list[i].rssi_cond.valid = cpu_to_le32(1);
+			nlo_list[i].rssi_cond.rssi =
+					cpu_to_le32(pno->a_networks[i].rssi_threshold);
+		}
+
+		nlo_list[i].bcast_nw_type.valid = cpu_to_le32(1);
+		nlo_list[i].bcast_nw_type.bcast_nw_type =
+					cpu_to_le32(pno->a_networks[i].bcast_nw_type);
+	}
+
+	ptr += nlo_list_len;
+	cmd->num_of_channels = cpu_to_le32(pno->a_networks[0].channel_count);
+	tlv = ptr;
+	tlv->header =  ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, channel_list_len);
+	ptr += sizeof(*tlv);
+	channel_list = ptr;
+	for (i = 0; i < pno->a_networks[0].channel_count; i++)
+		channel_list[i] = cpu_to_le32(pno->a_networks[0].channels[i]);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi tlv start pno config vdev_id %d\n",
+		   vdev_id);
+
+	return skb;
+}
+
+static struct sk_buff *ath12k_wmi_op_gen_config_pno_stop(struct ath12k *ar,
+							 u32 vdev_id)
+{
+	struct wmi_wow_nlo_config_cmd *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd);
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	cmd = (struct wmi_wow_nlo_config_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_NLO_CONFIG_CMD, len);
+
+	cmd->vdev_id = cpu_to_le32(vdev_id);
+	cmd->flags = cpu_to_le32(WMI_NLO_CONFIG_STOP);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "wmi tlv stop pno config vdev_id %d\n", vdev_id);
+	return skb;
+}
+
+int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
+			      struct wmi_pno_scan_req_arg  *pno_scan)
+{
+	struct sk_buff *skb;
+
+	if (pno_scan->enable)
+		skb = ath12k_wmi_op_gen_config_pno_start(ar, vdev_id, pno_scan);
+	else
+		skb = ath12k_wmi_op_gen_config_pno_stop(ar, vdev_id);
+
+	if (IS_ERR_OR_NULL(skb))
+		return -ENOMEM;
+
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_NETWORK_LIST_OFFLOAD_CONFIG_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 0dacd1e2ee67..3d01562a43f6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5096,6 +5096,173 @@ struct wmi_wow_ev_arg {
 	enum wmi_wow_wake_reason wake_reason;
 };
 
+#define WMI_PNO_MAX_SCHED_SCAN_PLANS      2
+#define WMI_PNO_MAX_SCHED_SCAN_PLAN_INT   7200
+#define WMI_PNO_MAX_SCHED_SCAN_PLAN_ITRNS 100
+#define WMI_PNO_MAX_NETW_CHANNELS         26
+#define WMI_PNO_MAX_NETW_CHANNELS_EX      60
+#define WMI_PNO_MAX_SUPP_NETWORKS         WLAN_SCAN_PARAMS_MAX_SSID
+#define WMI_PNO_MAX_IE_LENGTH             WLAN_SCAN_PARAMS_MAX_IE_LEN
+
+/* size based of dot11 declaration without extra IEs as we will not carry those for PNO */
+#define WMI_PNO_MAX_PB_REQ_SIZE    450
+
+#define WMI_PNO_24GHZ_DEFAULT_CH     1
+#define WMI_PNO_5GHZ_DEFAULT_CH      36
+
+#define WMI_ACTIVE_MAX_CHANNEL_TIME 40
+#define WMI_PASSIVE_MAX_CHANNEL_TIME   110
+
+/* SSID broadcast type */
+enum wmi_ssid_bcast_type {
+	BCAST_UNKNOWN      = 0,
+	BCAST_NORMAL       = 1,
+	BCAST_HIDDEN       = 2,
+};
+
+#define WMI_NLO_MAX_SSIDS    16
+#define WMI_NLO_MAX_CHAN     48
+
+#define WMI_NLO_CONFIG_STOP                             BIT(0)
+#define WMI_NLO_CONFIG_START                            BIT(1)
+#define WMI_NLO_CONFIG_RESET                            BIT(2)
+#define WMI_NLO_CONFIG_SLOW_SCAN                        BIT(4)
+#define WMI_NLO_CONFIG_FAST_SCAN                        BIT(5)
+#define WMI_NLO_CONFIG_SSID_HIDE_EN                     BIT(6)
+
+/* This bit is used to indicate if EPNO or supplicant PNO is enabled.
+ * Only one of them can be enabled at a given time
+ */
+#define WMI_NLO_CONFIG_ENLO                             BIT(7)
+#define WMI_NLO_CONFIG_SCAN_PASSIVE                     BIT(8)
+#define WMI_NLO_CONFIG_ENLO_RESET                       BIT(9)
+#define WMI_NLO_CONFIG_SPOOFED_MAC_IN_PROBE_REQ         BIT(10)
+#define WMI_NLO_CONFIG_RANDOM_SEQ_NO_IN_PROBE_REQ       BIT(11)
+#define WMI_NLO_CONFIG_ENABLE_IE_WHITELIST_IN_PROBE_REQ BIT(12)
+#define WMI_NLO_CONFIG_ENABLE_CNLO_RSSI_CONFIG          BIT(13)
+
+struct wmi_nlo_ssid_params {
+	__le32 valid;
+	struct ath12k_wmi_ssid_params ssid;
+} __packed;
+
+struct wmi_nlo_enc_params {
+	__le32 valid;
+	__le32 enc_type;
+} __packed;
+
+struct wmi_nlo_auth_params {
+	__le32 valid;
+	__le32 auth_type;
+} __packed;
+
+struct wmi_nlo_bcast_nw_params {
+	__le32 valid;
+	__le32 bcast_nw_type;
+} __packed;
+
+struct wmi_nlo_rssi_params {
+	__le32 valid;
+	__le32 rssi;
+} __packed;
+
+struct nlo_configured_params {
+	/* TLV tag and len;*/
+	__le32 tlv_header;
+	struct wmi_nlo_ssid_params ssid;
+	struct wmi_nlo_enc_params enc_type;
+	struct wmi_nlo_auth_params auth_type;
+	struct wmi_nlo_rssi_params rssi_cond;
+
+	/* indicates if the SSID is hidden or not */
+	struct wmi_nlo_bcast_nw_params bcast_nw_type;
+} __packed;
+
+struct wmi_network_type_arg {
+	struct cfg80211_ssid ssid;
+	u32 authentication;
+	u32 encryption;
+	u32 bcast_nw_type;
+	u8 channel_count;
+	u16 channels[WMI_PNO_MAX_NETW_CHANNELS_EX];
+	s32 rssi_threshold;
+};
+
+struct wmi_pno_scan_req_arg {
+	u8 enable;
+	u8 vdev_id;
+	u8 uc_networks_count;
+	struct wmi_network_type_arg a_networks[WMI_PNO_MAX_SUPP_NETWORKS];
+	u32 fast_scan_period;
+	u32 slow_scan_period;
+	u8 fast_scan_max_cycles;
+
+	bool do_passive_scan;
+
+	u32 delay_start_time;
+	u32 active_min_time;
+	u32 active_max_time;
+	u32 passive_min_time;
+	u32 passive_max_time;
+
+	/* mac address randomization attributes */
+	u32 enable_pno_scan_randomization;
+	u8 mac_addr[ETH_ALEN];
+	u8 mac_addr_mask[ETH_ALEN];
+};
+
+struct wmi_wow_nlo_config_cmd {
+	__le32 tlv_header;
+	__le32 flags;
+	__le32 vdev_id;
+	__le32 fast_scan_max_cycles;
+	__le32 active_dwell_time;
+	__le32 passive_dwell_time;
+	__le32 probe_bundle_size;
+
+	/* ART = IRT */
+	__le32 rest_time;
+
+	/* Max value that can be reached after SBM */
+	__le32 max_rest_time;
+
+	/* SBM */
+	__le32 scan_backoff_multiplier;
+
+	/* SCBM */
+	__le32 fast_scan_period;
+
+	/* specific to windows */
+	__le32 slow_scan_period;
+
+	__le32 no_of_ssids;
+
+	__le32 num_of_channels;
+
+	/* NLO scan start delay time in milliseconds */
+	__le32 delay_start_time;
+
+	/* MAC Address to use in Probe Req as SA */
+	struct ath12k_wmi_mac_addr_params mac_addr;
+
+	/* Mask on which MAC has to be randomized */
+	struct ath12k_wmi_mac_addr_params mac_mask;
+
+	/* IE bitmap to use in Probe Req */
+	__le32 ie_bitmap[8];
+
+	/* Number of vendor OUIs. In the TLV vendor_oui[] */
+	__le32 num_vendor_oui;
+
+	/* Number of connected NLO band preferences */
+	__le32 num_cnlo_band_pref;
+
+	/* The TLVs will follow.
+	 * nlo_configured_params nlo_list[];
+	 * u32 channel_list[num_of_channels];
+	 */
+} __packed;
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -5257,4 +5424,6 @@ int ath12k_wmi_wow_add_pattern(struct ath12k *ar, u32 vdev_id, u32 pattern_id,
 int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
 				    enum wmi_wow_wakeup_event event,
 				    u32 enable);
+int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
+			      struct wmi_pno_scan_req_arg  *pno_scan);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index bab4419b13b2..6b61f5da7933 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -23,6 +23,13 @@ static const struct wiphy_wowlan_support ath12k_wowlan_support = {
 	.max_pkt_offset = WOW_MAX_PKT_OFFSET,
 };
 
+static inline bool ath12k_wow_is_p2p_vdev(struct ath12k_vif *arvif)
+{
+	return (arvif->vdev_subtype == WMI_VDEV_SUBTYPE_P2P_DEVICE ||
+		arvif->vdev_subtype == WMI_VDEV_SUBTYPE_P2P_CLIENT ||
+		arvif->vdev_subtype == WMI_VDEV_SUBTYPE_P2P_GO);
+}
+
 int ath12k_wow_enable(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -242,7 +249,103 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
 	i80211_pattern->pkt_offset = pkt_ofs;
 }
 
-static int ath12k_vif_wow_set_wakeups(struct ath12k_vif *arvif,
+static int
+ath12k_wow_pno_check_and_convert(struct ath12k *ar, u32 vdev_id,
+				 const struct cfg80211_sched_scan_request *nd_config,
+				 struct wmi_pno_scan_req_arg *pno)
+{
+	int i, j;
+	u8 ssid_len;
+
+	pno->enable = 1;
+	pno->vdev_id = vdev_id;
+	pno->uc_networks_count = nd_config->n_match_sets;
+
+	if (!pno->uc_networks_count ||
+	    pno->uc_networks_count > WMI_PNO_MAX_SUPP_NETWORKS)
+		return -EINVAL;
+
+	if (nd_config->n_channels > WMI_PNO_MAX_NETW_CHANNELS_EX)
+		return -EINVAL;
+
+	/* Filling per profile params */
+	for (i = 0; i < pno->uc_networks_count; i++) {
+		ssid_len = nd_config->match_sets[i].ssid.ssid_len;
+
+		if (ssid_len == 0 || ssid_len > 32)
+			return -EINVAL;
+
+		pno->a_networks[i].ssid.ssid_len = ssid_len;
+
+		memcpy(pno->a_networks[i].ssid.ssid,
+		       nd_config->match_sets[i].ssid.ssid,
+		       ssid_len);
+		pno->a_networks[i].authentication = 0;
+		pno->a_networks[i].encryption     = 0;
+		pno->a_networks[i].bcast_nw_type  = 0;
+
+		/* Copying list of valid channel into request */
+		pno->a_networks[i].channel_count = nd_config->n_channels;
+		pno->a_networks[i].rssi_threshold = nd_config->match_sets[i].rssi_thold;
+
+		for (j = 0; j < nd_config->n_channels; j++) {
+			pno->a_networks[i].channels[j] =
+					nd_config->channels[j]->center_freq;
+		}
+	}
+
+	/* set scan to passive if no SSIDs are specified in the request */
+	if (nd_config->n_ssids == 0)
+		pno->do_passive_scan = true;
+	else
+		pno->do_passive_scan = false;
+
+	for (i = 0; i < nd_config->n_ssids; i++) {
+		j = 0;
+		while (j < pno->uc_networks_count) {
+			if (pno->a_networks[j].ssid.ssid_len ==
+				nd_config->ssids[i].ssid_len &&
+			    !memcmp(pno->a_networks[j].ssid.ssid,
+				    nd_config->ssids[i].ssid,
+				    pno->a_networks[j].ssid.ssid_len)) {
+				pno->a_networks[j].bcast_nw_type = BCAST_HIDDEN;
+				break;
+			}
+			j++;
+		}
+	}
+
+	if (nd_config->n_scan_plans == 2) {
+		pno->fast_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
+		pno->fast_scan_max_cycles = nd_config->scan_plans[0].iterations;
+		pno->slow_scan_period =
+			nd_config->scan_plans[1].interval * MSEC_PER_SEC;
+	} else if (nd_config->n_scan_plans == 1) {
+		pno->fast_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
+		pno->fast_scan_max_cycles = 1;
+		pno->slow_scan_period = nd_config->scan_plans[0].interval * MSEC_PER_SEC;
+	} else {
+		ath12k_warn(ar->ab, "Invalid number of scan plans %d !!",
+			    nd_config->n_scan_plans);
+	}
+
+	if (nd_config->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+		/* enable mac randomization */
+		pno->enable_pno_scan_randomization = 1;
+		memcpy(pno->mac_addr, nd_config->mac_addr, ETH_ALEN);
+		memcpy(pno->mac_addr_mask, nd_config->mac_addr_mask, ETH_ALEN);
+	}
+
+	pno->delay_start_time = nd_config->delay;
+
+	/* Current FW does not support min-max range for dwell time */
+	pno->active_max_time = WMI_ACTIVE_MAX_CHANNEL_TIME;
+	pno->passive_max_time = WMI_PASSIVE_MAX_CHANNEL_TIME;
+
+	return 0;
+}
+
+static int ath12k_wow_vif_set_wakeups(struct ath12k_vif *arvif,
 				      struct cfg80211_wowlan *wowlan)
 {
 	const struct cfg80211_pkt_pattern *patterns = wowlan->patterns;
@@ -275,6 +378,26 @@ static int ath12k_vif_wow_set_wakeups(struct ath12k_vif *arvif,
 
 		if (wowlan->magic_pkt)
 			__set_bit(WOW_MAGIC_PKT_RECVD_EVENT, &wow_mask);
+
+		if (wowlan->nd_config) {
+			struct wmi_pno_scan_req_arg *pno;
+			int ret;
+
+			pno = kzalloc(sizeof(*pno), GFP_KERNEL);
+			if (!pno)
+				return -ENOMEM;
+
+			ar->nlo_enabled = true;
+
+			ret = ath12k_wow_pno_check_and_convert(ar, arvif->vdev_id,
+							       wowlan->nd_config, pno);
+			if (!ret) {
+				ath12k_wmi_wow_config_pno(ar, arvif->vdev_id, pno);
+				__set_bit(WOW_NLO_DETECTED_EVENT, &wow_mask);
+			}
+
+			kfree(pno);
+		}
 		break;
 	default:
 		break;
@@ -347,7 +470,9 @@ static int ath12k_wow_set_wakeups(struct ath12k *ar,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	list_for_each_entry(arvif, &ar->arvifs, list) {
-		ret = ath12k_vif_wow_set_wakeups(arvif, wowlan);
+		if (ath12k_wow_is_p2p_vdev(arvif))
+			continue;
+		ret = ath12k_wow_vif_set_wakeups(arvif, wowlan);
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to set wow wakeups on vdev %i: %d\n",
 				    arvif->vdev_id, ret);
@@ -358,6 +483,61 @@ static int ath12k_wow_set_wakeups(struct ath12k *ar,
 	return 0;
 }
 
+static int ath12k_wow_vdev_clean_nlo(struct ath12k *ar, u32 vdev_id)
+{
+	int ret = 0;
+
+	if (ar->nlo_enabled) {
+		struct wmi_pno_scan_req_arg *pno =
+			kzalloc(sizeof(*pno), GFP_KERNEL);
+		if (!pno)
+			return -ENOMEM;
+
+		pno->enable = 0;
+		ar->nlo_enabled = false;
+		ret = ath12k_wmi_wow_config_pno(ar, vdev_id, pno);
+		kfree(pno);
+	}
+
+	return ret;
+}
+
+static int ath12k_wow_vif_clean_nlo(struct ath12k_vif *arvif)
+{
+	struct ath12k *ar = arvif->ar;
+	int ret = 0;
+
+	switch (arvif->vdev_type) {
+	case WMI_VDEV_TYPE_STA:
+		ret = ath12k_wow_vdev_clean_nlo(ar, arvif->vdev_id);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int ath12k_wow_nlo_cleanup(struct ath12k *ar)
+{
+	struct ath12k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (ath12k_wow_is_p2p_vdev(arvif))
+			continue;
+		ret = ath12k_wow_vif_clean_nlo(arvif);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to clean nlo settings on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
@@ -443,8 +623,16 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 	ath12k_hif_irq_enable(ar->ab);
 
 	ret = ath12k_wow_wakeup(ar);
-	if (ret)
+	if (ret) {
 		ath12k_warn(ar->ab, "failed to wakeup from wow: %d\n", ret);
+		goto exit;
+	}
+
+	ret = ath12k_wow_nlo_cleanup(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to cleanup nlo: %d\n", ret);
+		goto exit;
+	}
 
 exit:
 	if (ret) {
@@ -480,6 +668,11 @@ int ath12k_wow_init(struct ath12k *ar)
 		ar->wow.wowlan_support.max_pkt_offset -= WOW_MAX_REDUCE;
 	}
 
+	if (test_bit(WMI_TLV_SERVICE_NLO, ar->wmi->wmi_ab->svc_map)) {
+		ar->wow.wowlan_support.flags |= WIPHY_WOWLAN_NET_DETECT;
+		ar->wow.wowlan_support.max_nd_match_sets = WMI_PNO_MAX_SUPP_NETWORKS;
+	}
+
 	ar->wow.max_num_patterns = ATH12K_WOW_PATTERNS;
 	ar->wow.wowlan_support.n_patterns = ar->wow.max_num_patterns;
 	ar->ah->hw->wiphy->wowlan = &ar->wow.wowlan_support;
-- 
2.25.1


