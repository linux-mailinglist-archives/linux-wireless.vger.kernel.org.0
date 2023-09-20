Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EFC7A75F7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 10:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjITIg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 04:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjITIYv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 04:24:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281CB110
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 01:24:35 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K3TSFs014857;
        Wed, 20 Sep 2023 08:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=fsB+gyJ/dU71Smb3BDIVbZ8QH1hoHha8UB2IldVbng8=;
 b=VEA5F9xt9pnKq3T9XXKb7OcfHT+B0DKoyGZDkyMGh+vGPWrDkTiQrxF0ylHZl7S8bBEX
 YbMaPN54IA8X+pvxI0y6QirwJiASgr6p5Kpmj0vsBJESIcUkJTLOw+aoKT4647ioYSLp
 g9kLaq/BCodZbOsfmKXyIFuRZIg14gKioX3ewGRyWGQD9NXNLgYGNLwOLzO2kg6RXLWD
 foWXowoXZHYqt3oDdLK2UWWwwC4av5zHVgXcs3v873aRHw+7U17Rn/4zmzPi9hNdQJBh
 UDSaMsAp/yyZlakssa9S10o+1ZGZvz7EsEvmqLwHDR9pNMmJytRdYu/1Lb5qcPniZbq+ YA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7qj90pv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 08:24:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K8OUYU006233
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 08:24:30 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 20 Sep 2023 01:24:27 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
Subject: [PATCH v6 12/13] wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
Date:   Wed, 20 Sep 2023 04:23:48 -0400
Message-ID: <20230920082349.29111-13-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230920082349.29111-1-quic_wgong@quicinc.com>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hLG325VhAFB0cjt1fLHPBRO9lw_3Wdh8
X-Proofpoint-ORIG-GUID: hLG325VhAFB0cjt1fLHPBRO9lw_3Wdh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the handler for WMI_VDEV_SET_TPC_POWER_CMDID, it is for 6 GHz band.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 63 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 61 ++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d93ed92335c7..43c47967eec1 100644
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
+	int i, ret, len;
+
+	len = sizeof(*cmd) + TLV_HDR_SIZE;
+	len += (sizeof(struct wmi_vdev_ch_power_info) * param->num_pwr_levels);
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
+		      FIELD_PREP(WMI_TLV_LEN, param->num_pwr_levels * sizeof(*ch));
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
index ed1a6db23709..dbe973698a89 100644
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
@@ -1878,6 +1909,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_PDEV_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
+	WMI_TAG_VDEV_SET_TPC_POWER_CMD = 0x3B5,
+	WMI_TAG_VDEV_CH_POWER_INFO,
 	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD = 0x3D8,
 	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD,
 	WMI_TAG_MAX
@@ -3168,6 +3201,31 @@ struct wlan_ssid {
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
@@ -6512,4 +6570,7 @@ void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
 int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 				struct cur_regulatory_info *reg_info,
 				enum ieee80211_ap_reg_power power_type);
+int ath11k_wmi_send_vdev_set_tpc_power(struct ath11k *ar,
+				       u32 vdev_id,
+				       struct ath11k_reg_tpc_power_info *param);
 #endif
-- 
2.40.1

