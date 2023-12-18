Return-Path: <linux-wireless+bounces-904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE78168FE
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 09:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AFAB2273A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B046912B6C;
	Mon, 18 Dec 2023 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G+PsNLQl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C1125B1
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI8mehQ028335;
	Mon, 18 Dec 2023 08:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=SMr3H3hAeAfuh04Jgwm/g6mVQDXi94IeindmVS1KBC4=; b=G+
	PsNLQlURfF2w8qfBxJSP3FqDhiGX5RMjwEqLClNtpzbLsc6RXtUFdovl4I/BjNSn
	5/OwvAmTZT+AzFS1/tc67kZg0hK78KC75nUkQ7VbPhwR83DKXIF7BLpLxdrzbrI8
	Q+P74QCZf9QIa4FgJtTwayRB3ga2RGAv5wyxzAsc0cQTmOLz5HpDFSIyIQNuM424
	zztsb537bo4mOH6O+RXE7Vdu6/MwZxcbp70Bpq7w8nMljfAW91ui92gV4kRHZEVZ
	2jYu/HInQlipb6kPlNZgHx/pHphqzGpdnCOwQ3OX7eTNenRujrdySmyyPy5aBkZd
	/k3z4/SJ+IgA3uQa46tg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2gw0r8ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:59:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI8xAD0012058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 08:59:10 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 00:59:08 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v10 11/12] wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
Date: Mon, 18 Dec 2023 16:58:43 +0800
Message-ID: <20231218085844.2658-12-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218085844.2658-1-quic_bqiang@quicinc.com>
References: <20231218085844.2658-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LMwftesO-rOFF1zS5xr30JMOIQ3biu7N
X-Proofpoint-ORIG-GUID: LMwftesO-rOFF1zS5xr30JMOIQ3biu7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180064

From: Wen Gong <quic_wgong@quicinc.com>

Add the handler for WMI_VDEV_SET_TPC_POWER_CMDID, it is for 6 GHz band.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v10:
 no change.
v9:
 no change.
v8:
 no change.
v7:
 1. move this patch ahead.

 drivers/net/wireless/ath/ath11k/wmi.c | 63 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 61 ++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 593b1d17b9ba..fab1e240544a 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2379,6 +2379,69 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	return ret;
 }
 
+int ath11k_wmi_send_vdev_set_tpc_power(struct ath11k *ar,
+				       u32 vdev_id,
+				       struct ath11k_reg_tpc_power_info *param)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_vdev_set_tpc_power_cmd *cmd;
+	struct wmi_vdev_ch_power_info *ch;
+	struct sk_buff *skb;
+	struct wmi_tlv *tlv;
+	u8 *ptr;
+	int i, ret, len, array_len;
+
+	array_len = sizeof(*ch) * param->num_pwr_levels;
+	len = sizeof(*cmd) + TLV_HDR_SIZE + array_len;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	ptr = skb->data;
+
+	cmd = (struct wmi_vdev_set_tpc_power_cmd *)ptr;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_VDEV_SET_TPC_POWER_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	cmd->psd_power = param->is_psd_power;
+	cmd->eirp_power = param->eirp_power;
+	cmd->power_type_6ghz = param->ap_power_type;
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi tpc vdev id %d is psd power %d eirp power %d 6 GHz power type %d\n",
+		   vdev_id, param->is_psd_power, param->eirp_power, param->ap_power_type);
+
+	ptr += sizeof(*cmd);
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, array_len);
+
+	ptr += TLV_HDR_SIZE;
+	ch = (struct wmi_vdev_ch_power_info *)ptr;
+
+	for (i = 0; i < param->num_pwr_levels; i++, ch++) {
+		ch->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+					    WMI_TAG_VDEV_CH_POWER_INFO) |
+				FIELD_PREP(WMI_TLV_LEN,
+					   sizeof(*ch) - TLV_HDR_SIZE);
+
+		ch->chan_cfreq = param->chan_power_info[i].chan_cfreq;
+		ch->tx_power = param->chan_power_info[i].tx_power;
+
+		ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+			   "wmi tpc chan freq %d TX power %d\n",
+			   ch->chan_cfreq, ch->tx_power);
+	}
+
+	ret = ath11k_wmi_cmd_send(wmi, skb,
+				  WMI_VDEV_SET_TPC_POWER_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_VDEV_SET_TPC_POWER_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
 int ath11k_wmi_send_scan_stop_cmd(struct ath11k *ar,
 				  struct scan_cancel_param *param)
 {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 7e416e09aa5f..ec6580ece3c0 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -15,6 +15,7 @@ struct ath11k;
 struct ath11k_fw_stats;
 struct ath11k_fw_dbglog;
 struct ath11k_vif;
+struct ath11k_reg_tpc_power_info;
 
 #define PSOC_HOST_MAX_NUM_SS (8)
 
@@ -327,6 +328,36 @@ enum wmi_tlv_cmd_id {
 	WMI_VDEV_SET_CUSTOM_AGGR_SIZE_CMDID,
 	WMI_VDEV_ENCRYPT_DECRYPT_DATA_REQ_CMDID,
 	WMI_VDEV_ADD_MAC_ADDR_TO_RX_FILTER_CMDID,
+	/** WMI commands related to dbg arp stats */
+	WMI_VDEV_SET_ARP_STAT_CMDID,
+	WMI_VDEV_GET_ARP_STAT_CMDID,
+	/** get tx power for the current vdev */
+	WMI_VDEV_GET_TX_POWER_CMDID,
+	/* limit STA offchannel activity */
+	WMI_VDEV_LIMIT_OFFCHAN_CMDID,
+	/** To set custom software retries per-AC for vdev */
+	WMI_VDEV_SET_CUSTOM_SW_RETRY_TH_CMDID,
+	/** To set chainmask configuration for vdev */
+	WMI_VDEV_CHAINMASK_CONFIG_CMDID,
+	WMI_VDEV_GET_BCN_RECEPTION_STATS_CMDID,
+	/* request LTE-Coex info */
+	WMI_VDEV_GET_MWS_COEX_INFO_CMDID,
+	/** delete all peer (excluding bss peer) */
+	WMI_VDEV_DELETE_ALL_PEER_CMDID,
+	/* To set bss max idle time related parameters */
+	WMI_VDEV_BSS_MAX_IDLE_TIME_CMDID,
+	/** Indicates firmware to trigger Audio sync */
+	WMI_VDEV_AUDIO_SYNC_TRIGGER_CMDID,
+	/** Gives Qtimer value to firmware */
+	WMI_VDEV_AUDIO_SYNC_QTIMER_CMDID,
+	/** Preferred channel list for each vdev */
+	WMI_VDEV_SET_PCL_CMDID,
+	/** VDEV_GET_BIG_DATA_CMD IS DEPRECATED - DO NOT USE */
+	WMI_VDEV_GET_BIG_DATA_CMDID,
+	/** Get per vdev BIG DATA stats phase 2 */
+	WMI_VDEV_GET_BIG_DATA_P2_CMDID,
+	/** set TPC PSD/non-PSD power */
+	WMI_VDEV_SET_TPC_POWER_CMDID,
 	WMI_PEER_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_PEER),
 	WMI_PEER_DELETE_CMDID,
 	WMI_PEER_FLUSH_TIDS_CMDID,
@@ -1880,6 +1911,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_PDEV_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
+	WMI_TAG_VDEV_SET_TPC_POWER_CMD = 0x3B5,
+	WMI_TAG_VDEV_CH_POWER_INFO,
 	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD = 0x3D8,
 	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD,
 	WMI_TAG_MAX
@@ -3169,6 +3202,31 @@ struct wlan_ssid {
 	u8 ssid[WLAN_SSID_MAX_LEN];
 };
 
+struct wmi_vdev_ch_power_info {
+	u32 tlv_header;
+	u32 chan_cfreq; /* Channel center frequency (MHz) */
+	/* Unit: dBm, either PSD/EIRP power for this frequency or
+	 * incremental for non-PSD BW
+	 */
+	u32 tx_power;
+} __packed;
+
+struct wmi_vdev_set_tpc_power_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 psd_power; /* Value: 0 or 1, is PSD power or not */
+	u32 eirp_power; /* Maximum EIRP power (dBm units), valid only if power is PSD */
+	u32 power_type_6ghz; /* Type: WMI_6GHZ_REG_TYPE, used for halphy CTL lookup */
+	/* This fixed_param TLV is followed by the below TLVs:
+	 * num_pwr_levels of wmi_vdev_ch_power_info
+	 * For PSD power, it is the PSD/EIRP power of the frequency (20 MHz chunks).
+	 * For non-PSD power, the power values are for 20, 40, and till
+	 * BSS BW power levels.
+	 * The num_pwr_levels will be checked by sw how many elements present
+	 * in the variable-length array.
+	 */
+} __packed;
+
 #define WMI_IE_BITMAP_SIZE             8
 
 /* prefix used by scan requestor ids on the host */
@@ -6488,4 +6546,7 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 				struct cur_regulatory_info *reg_info,
 				enum ieee80211_ap_reg_power power_type);
 bool ath11k_wmi_supports_6ghz_cc_ext(struct ath11k *ar);
+int ath11k_wmi_send_vdev_set_tpc_power(struct ath11k *ar,
+				       u32 vdev_id,
+				       struct ath11k_reg_tpc_power_info *param);
 #endif
-- 
2.25.1


