Return-Path: <linux-wireless+bounces-21708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47110A93045
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F5A172FF4
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30226B2BF;
	Fri, 18 Apr 2025 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l33Rzn63"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF04126869E;
	Fri, 18 Apr 2025 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944991; cv=none; b=DKxIPo6sq2qAIuMvobZiH8/IB0lmAdfWhf4l5ozmKrCTVZ2Yd390ViJgBvCHiDx5ZKY1nuJBFbNLNk/vVIVLGvYFBl9rWPDizgTXZMTz2/FtJGkIVvFQZQvdByTOFgYIoQuImUZRI3vktlE6ZuwbOVq198n3pcsVHVosf/gFhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944991; c=relaxed/simple;
	bh=xI8wcVt9PBaMOYZIchOHUTRza6RjhYXGj6Voef6dXGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qmUQvneuiJknW9RFLeCiWuAxriX3NRlVQFxijMMbt/a75QOopmRtfXpOJaSuqxGOw8x+G8f8drufD6tU0wotImKAfQBKRsmqmvUt6+j99V/0rluppxZS/ppT7VFMkIULsoFUcjRO6QBSJ6Se/pbYpTysGFxPC07lqeX12KaiIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l33Rzn63; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2EG1P015466;
	Fri, 18 Apr 2025 02:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e8QCKopgs3aQUJyiM+0Z1ii7ZvTACo5ccODitmmVBK8=; b=l33Rzn63OjmggJwL
	xLCwSs9h7LNAOJYRmMHEqxvD7gxFHDelwMAsXD3tgDEDYiJ7EV66qlHL/l+KpJFw
	ivpjAXb4Mwl4bQ2RYS7VsmZKzXYlyyrMKKyG1ZcOHPLR86s8CajJm3dAFfJ8ZmbH
	NPpYgQbUzAgLR2ceDS778DccKw6fdny1gd67uLCZcQE50XE5Fj4o1X5ov9jkGpvW
	rNqT/ZeUdIZvDiKbPmLRSlXJ4VWGcKt+//fRX7SMvlJLF9IQw2EnkTUkaJ9apySq
	Md7uv+vDBQaHkWKwzCvtmDaDLlVk82D3PCsRJh+IMJBog2u1uDg1DWEzSepcj2Oi
	+UYpgA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqh1jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2uKGe027982
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:20 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:56:19 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:47 +0800
Subject: [PATCH ath-next 14/15] wifi: ath12k: add handler for
 WMI_VDEV_SET_TPC_POWER_CMDID
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-14-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GjRFwLZkRDqsSmlmiET6qnWU-Glgveeh
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=6801bf56 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=rc9iBcrBPJ1xmIgFc9IA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GjRFwLZkRDqsSmlmiET6qnWU-Glgveeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

Add the handler for WMI_VDEV_SET_TPC_POWER_CMDID, it is for 6 GHz band.
A subsequent patch will call this handler to send power parameters to
firmware.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 60 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 57 +++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 6fa7cba35ab8f6d2420213c452a2722bed57b80a..7ad0934a344f2d1bd47775e4c6c0abc227a1ab33 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -9826,3 +9826,63 @@ bool ath12k_wmi_supports_6ghz_cc_ext(struct ath12k *ar)
 	return test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
 			ar->ab->wmi_ab.svc_map) && ar->supports_6ghz;
 }
+
+int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
+				       u32 vdev_id,
+				       struct ath12k_reg_tpc_power_info *param)
+{
+	struct wmi_vdev_set_tpc_power_cmd *cmd;
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_vdev_ch_power_params *ch;
+	int i, ret, len, array_len;
+	struct sk_buff *skb;
+	struct wmi_tlv *tlv;
+	u8 *ptr;
+
+	array_len = sizeof(*ch) * param->num_pwr_levels;
+	len = sizeof(*cmd) + TLV_HDR_SIZE + array_len;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	ptr = skb->data;
+
+	cmd = (struct wmi_vdev_set_tpc_power_cmd *)ptr;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_VDEV_SET_TPC_POWER_CMD,
+						 sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(vdev_id);
+	cmd->psd_power = cpu_to_le32(param->is_psd_power);
+	cmd->eirp_power = cpu_to_le32(param->eirp_power);
+	cmd->power_type_6ghz = cpu_to_le32(param->ap_power_type);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "tpc vdev id %d is psd power %d eirp power %d 6 ghz power type %d\n",
+		   vdev_id, param->is_psd_power, param->eirp_power, param->ap_power_type);
+
+	ptr += sizeof(*cmd);
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT, array_len);
+
+	ptr += TLV_HDR_SIZE;
+	ch = (struct wmi_vdev_ch_power_params *)ptr;
+
+	for (i = 0; i < param->num_pwr_levels; i++, ch++) {
+		ch->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_VDEV_CH_POWER_INFO,
+							sizeof(*ch));
+		ch->chan_cfreq = cpu_to_le32(param->chan_power_info[i].chan_cfreq);
+		ch->tx_power = cpu_to_le32(param->chan_power_info[i].tx_power);
+
+		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "tpc chan freq %d TX power %d\n",
+			   ch->chan_cfreq, ch->tx_power);
+	}
+
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_VDEV_SET_TPC_POWER_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_VDEV_SET_TPC_POWER_CMDID\n");
+		dev_kfree_skb(skb);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index e4d383c090a60461b1af4529c6d5ef2fa4a2f2e9..9d4ea4f359a7b12f80701baf422183fae6a55efe 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -26,6 +26,7 @@ struct ath12k_base;
 struct ath12k;
 struct ath12k_link_vif;
 struct ath12k_fw_stats;
+struct ath12k_reg_tpc_power_info;
 
 /* There is no signed version of __le32, so for a temporary solution come
  * up with our own version. The idea is from fs/ntfs/endian.h.
@@ -386,6 +387,22 @@ enum wmi_tlv_cmd_id {
 	WMI_VDEV_SET_CUSTOM_AGGR_SIZE_CMDID,
 	WMI_VDEV_ENCRYPT_DECRYPT_DATA_REQ_CMDID,
 	WMI_VDEV_ADD_MAC_ADDR_TO_RX_FILTER_CMDID,
+	WMI_VDEV_SET_ARP_STAT_CMDID,
+	WMI_VDEV_GET_ARP_STAT_CMDID,
+	WMI_VDEV_GET_TX_POWER_CMDID,
+	WMI_VDEV_LIMIT_OFFCHAN_CMDID,
+	WMI_VDEV_SET_CUSTOM_SW_RETRY_TH_CMDID,
+	WMI_VDEV_CHAINMASK_CONFIG_CMDID,
+	WMI_VDEV_GET_BCN_RECEPTION_STATS_CMDID,
+	WMI_VDEV_GET_MWS_COEX_INFO_CMDID,
+	WMI_VDEV_DELETE_ALL_PEER_CMDID,
+	WMI_VDEV_BSS_MAX_IDLE_TIME_CMDID,
+	WMI_VDEV_AUDIO_SYNC_TRIGGER_CMDID,
+	WMI_VDEV_AUDIO_SYNC_QTIMER_CMDID,
+	WMI_VDEV_SET_PCL_CMDID,
+	WMI_VDEV_GET_BIG_DATA_CMDID,
+	WMI_VDEV_GET_BIG_DATA_P2_CMDID,
+	WMI_VDEV_SET_TPC_POWER_CMDID,
 	WMI_PEER_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_PEER),
 	WMI_PEER_DELETE_CMDID,
 	WMI_PEER_FLUSH_TIDS_CMDID,
@@ -1955,6 +1972,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_TPC_STATS_REG_PWR_ALLOWED,
 	WMI_TAG_TPC_STATS_RATES_ARRAY,
 	WMI_TAG_TPC_STATS_CTL_PWR_TABLE_EVENT,
+	WMI_TAG_VDEV_SET_TPC_POWER_CMD = 0x3B5,
+	WMI_TAG_VDEV_CH_POWER_INFO,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
 	WMI_TAG_DCS_AWGN_INT_TYPE = 0x3C5,
 	WMI_TAG_MLO_TX_SEND_PARAMS,
@@ -5939,6 +5958,41 @@ struct wmi_tpc_stats_arg {
 	struct wmi_tpc_ctl_pwr_table_arg ctl_array;
 };
 
+struct wmi_vdev_ch_power_params {
+	__le32 tlv_header;
+
+	/* Channel center frequency (MHz) */
+	__le32 chan_cfreq;
+
+	/* Unit: dBm, either PSD/EIRP power for this frequency or
+	 * incremental for non-PSD BW
+	 */
+	__le32 tx_power;
+} __packed;
+
+struct wmi_vdev_set_tpc_power_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+
+	/* Value: 0 or 1, is PSD power or not */
+	__le32 psd_power;
+
+	 /* Maximum EIRP power (dBm units), valid only if power is PSD */
+	__le32 eirp_power;
+
+	/* Type: WMI_6GHZ_REG_TYPE, used for halphy CTL lookup */
+	__le32 power_type_6ghz;
+
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
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -6134,5 +6188,8 @@ void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
 			      struct ath12k_fw_stats *fw_stats, u32 stats_id,
 			      char *buf);
 bool ath12k_wmi_supports_6ghz_cc_ext(struct ath12k *ar);
+int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
+				       u32 vdev_id,
+				       struct ath12k_reg_tpc_power_info *param);
 
 #endif

-- 
2.34.1


