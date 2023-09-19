Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82E7A5AB5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 09:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjISHR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 03:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISHR6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 03:17:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD78FC
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 00:17:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J56H2e004537;
        Tue, 19 Sep 2023 07:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=rS9ObqtGM0EJ4rWrYqfTEY6yfa8SmpOgtGk0FdPb7IQ=;
 b=IDRt0IzJPqlKHx1d9IzHIUyz3oD3VdVnEoW3+Cy3JQ+sHB6804eHAuHGiH+pHUMG+IW/
 aOGY2P5nE9Dsq1vdSoM2RpWZLRM1TiTUaVbM8Gsuk1PqkI64tf67LnEZViyrlCHVcHc9
 ctfpNvVMddniJkUWXgnEw0i3UxUhDJ7L6BedY4tyoFJusK7aCo/Q90BNSngWtSGzDdKH
 aGDd8f905JJlpiXexXCU5RW+PXXm7HkAwMvsOJX0/RlvcfKaNI/GXs3McDYzHRQYDAvr
 0iYkRGylwXz2lrtX7ydqXXxKgw3KyOYGOMoRHjRaRXGQXpt/RZmGWiqLZ/OIiWTpUJly +Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6trqh90v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:17:48 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38J6vJnM003306;
        Tue, 19 Sep 2023 07:17:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3t6ppvhm7e-1;
        Tue, 19 Sep 2023 07:17:47 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J7HlfF009117;
        Tue, 19 Sep 2023 07:17:47 GMT
Received: from aisr-linux.qualcomm.com (aisr-linux.qualcomm.com [10.201.124.194])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 38J7Hk2s009101;
        Tue, 19 Sep 2023 07:17:47 +0000
Received: by aisr-linux.qualcomm.com (Postfix, from userid 4090849)
        id 36074E020C5; Tue, 19 Sep 2023 12:47:45 +0530 (IST)
From:   Aishwarya R <quic_aisr@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Aishwarya R <quic_aisr@quicinc.com>
Subject: [PATCH 7/7] wifi: ath12k: send TPC power to firmware for 6 GHz VDEV
Date:   Tue, 19 Sep 2023 12:47:24 +0530
Message-Id: <20230919071724.15505-8-quic_aisr@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230919071724.15505-1-quic_aisr@quicinc.com>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VV4I7Ja_XhI_Pv31HW67ALD12qUg22it
X-Proofpoint-ORIG-GUID: VV4I7Ja_XhI_Pv31HW67ALD12qUg22it
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190060
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When STATION is connected to a 6 GHz AP, or when AP boots up, it has
2 ways to configure the power limit to firmware. Currently it
sends 2 wmi command WMI_PDEV_PARAM_TXPOWER_LIMIT2G/
WMI_PDEV_PARAM_TXPOWER_LIMIT5G to firmware.

Add support to send WMI_VDEV_SET_TPC_POWER_CMDID to firmware which
include more parameters for power control. When firmware support
SERVICE_EXT_TPC_REG, it means firmware support this feature, then ath12k
discard BSS_CHANGED_TXPOWER flag from mac80211 which is used to the first
way for 6 GHz band.

The second way is to prepare the parameter for wmi command
WMI_VDEV_SET_TPC_POWER_CMDID and send the firmware after vdev start
response success from firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 25 +++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c | 67 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 36 +++++++++++++-
 3 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 35bd472267c1..5505f933a4e1 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2467,8 +2467,18 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev_id %i txpower %d\n",
 			   arvif->vdev_id, info->txpower);
 
-		arvif->txpower = info->txpower;
-		ath12k_mac_txpower_recalc(ar);
+		if (ar->supports_6ghz && info->chandef.chan &&
+		    info->chandef.chan->band == NL80211_BAND_6GHZ &&
+		    (arvif->vdev_type == WMI_VDEV_TYPE_STA ||
+		     arvif->vdev_type == WMI_VDEV_TYPE_AP) &&
+		     test_bit(WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT,
+			      ar->ab->wmi_ab.svc_map)) {
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+				   "discard tx power, change to set TPC power\n");
+		} else {
+			arvif->txpower = info->txpower;
+			ath12k_mac_txpower_recalc(ar);
+		}
 	}
 
 	if (changed & BSS_CHANGED_MCAST_RATE &&
@@ -5519,6 +5529,16 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 		return ret;
 	}
 
+	if (ar->supports_6ghz &&
+	    chandef->chan->band == NL80211_BAND_6GHZ &&
+	    (arvif->vdev_type == WMI_VDEV_TYPE_STA ||
+	     arvif->vdev_type == WMI_VDEV_TYPE_AP) &&
+	     test_bit(WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT, ar->ab->wmi_ab.svc_map)) {
+		ath12k_mac_fill_reg_tpc_info(ar, arvif->vif, &arvif->chanctx);
+		ath12k_wmi_send_vdev_set_tpc_power(ar, arvif->vdev_id,
+						   &arvif->reg_tpc_info);
+	}
+
 	ar->num_started_vdevs++;
 	ath12k_dbg(ab, ATH12K_DBG_MAC,  "vdev %pM started, vdev_id %d\n",
 		   arvif->vif->addr, arvif->vdev_id);
@@ -6304,6 +6324,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		if (power_type == IEEE80211_REG_UNSET_AP)
 			power_type = IEEE80211_REG_LPI_AP;
 
+		arvif->chanctx = *ctx;
 		if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
 			ath12k_mac_parse_tx_pwr_env(ar, vif, ctx);
 	}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 5bfca2513730..582c7e80c76b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2311,6 +2311,73 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	return ret;
 }
 
+int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
+				       u32 vdev_id,
+				       struct ath12k_reg_tpc_power_info *param)
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_vdev_set_tpc_power_cmd *cmd;
+	struct wmi_vdev_ch_power_info_params *ch;
+	struct sk_buff *skb;
+	struct wmi_tlv *tlv;
+	u8 *ptr;
+	int i, ret, len;
+
+	len = sizeof(*cmd) + TLV_HDR_SIZE;
+	len += (sizeof(*ch) * param->num_pwr_levels);
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	ptr = skb->data;
+
+	cmd = (struct wmi_vdev_set_tpc_power_cmd *)ptr;
+	cmd->tlv_header = cpu_to_le32(FIELD_PREP(WMI_TLV_TAG,
+						 WMI_TAG_VDEV_SET_TPC_POWER_CMD) |
+				      FIELD_PREP(WMI_TLV_LEN,
+						 sizeof(*cmd) - TLV_HDR_SIZE));
+	cmd->vdev_id = cpu_to_le32(vdev_id);
+	cmd->psd_power = cpu_to_le32(param->is_psd_power);
+	cmd->eirp_power = cpu_to_le32(param->eirp_power);
+	cmd->power_type_6ghz = cpu_to_le32(param->power_type_6ghz);
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "wmi TPC vdev_id: %d is_psd_power: %d eirp_power: %d power_type_6ghz: %d\n",
+		   vdev_id, param->is_psd_power, param->eirp_power,
+		   param->power_type_6ghz);
+
+	ptr += sizeof(*cmd);
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = cpu_to_le32(FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
+				  FIELD_PREP(WMI_TLV_LEN,
+					     param->num_pwr_levels * sizeof(*ch)));
+
+	ptr += TLV_HDR_SIZE;
+	ch = (struct wmi_vdev_ch_power_info_params *)ptr;
+
+	for (i = 0; i < param->num_pwr_levels; i++, ch++) {
+		ch->tlv_header = cpu_to_le32(FIELD_PREP(WMI_TLV_TAG,
+							WMI_TAG_VDEV_CH_POWER_INFO) |
+					     FIELD_PREP(WMI_TLV_LEN,
+							sizeof(*ch) - TLV_HDR_SIZE));
+
+		ch->chan_cfreq = cpu_to_le32(param->chan_power_info[i].chan_cfreq);
+		ch->tx_power = cpu_to_le32(param->chan_power_info[i].tx_power);
+
+		ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+			   "wmi TPC chan_cfreq: %d , tx_power: %d\n",
+			   ch->chan_cfreq, ch->tx_power);
+	}
+
+	ret = ath12k_wmi_cmd_send(wmi, skb,
+				  WMI_VDEV_SET_TPC_POWER_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send WMI_VDEV_SET_TPC_POWER_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
 int ath12k_wmi_send_scan_stop_cmd(struct ath12k *ar,
 				  struct ath12k_wmi_scan_cancel_arg *arg)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 9f24f8ded52f..a97eb2544ab0 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -24,6 +24,7 @@
 
 struct ath12k_base;
 struct ath12k;
+struct ath12k_reg_tpc_power_info;
 
 /* There is no signed version of __le32, so for a temporary solution come
  * up with our own version. The idea is from fs/ntfs/endian.h.
@@ -388,6 +389,7 @@ enum wmi_tlv_cmd_id {
 	WMI_VDEV_SET_CUSTOM_AGGR_SIZE_CMDID,
 	WMI_VDEV_ENCRYPT_DECRYPT_DATA_REQ_CMDID,
 	WMI_VDEV_ADD_MAC_ADDR_TO_RX_FILTER_CMDID,
+	WMI_VDEV_SET_TPC_POWER_CMDID,
 	WMI_PEER_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_PEER),
 	WMI_PEER_DELETE_CMDID,
 	WMI_PEER_FLUSH_TIDS_CMDID,
@@ -1924,6 +1926,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_MAC_PHY_CAPABILITIES_EXT = 0x36F,
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
+	WMI_TAG_VDEV_SET_TPC_POWER_CMD = 0x3B5,
+	WMI_TAG_VDEV_CH_POWER_INFO,
 	WMI_TAG_MAX
 };
 
@@ -2148,7 +2152,8 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 
-	WMI_MAX_EXT_SERVICE
+	WMI_MAX_EXT_SERVICE,
+	WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT = 280,
 };
 
 enum {
@@ -3037,6 +3042,32 @@ struct ath12k_wmi_element_info_arg {
 	u8 *ptr;
 };
 
+struct wmi_vdev_ch_power_info_params {
+	__le32 tlv_header;
+	__le32 chan_cfreq; /* Channel center frequency (MHz) */
+	/* Unit: dBm, either PSD/EIRP power for this frequency or
+	 * incremental for non-PSD BW
+	 */
+	__le32 tx_power;
+} __packed;
+
+struct wmi_vdev_set_tpc_power_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 psd_power; /* Value: 0 or 1, is PSD power or not */
+	__le32 eirp_power;
+	/* Maximum EIRP power (dBm units), valid only if power is PSD */
+	__le32 power_type_6ghz; /* Type: WMI_6 GHz_REG_TYPE, used for halphy CTL lookup */
+	/* This fixed_param TLV is followed by the below TLVs:
+	 * num_pwr_levels of wmi_vdev_ch_power_info
+	 * For PSD power, it is the PSD/EIRP power of the frequency (20 MHz chunks).
+	 * For non-psd power, the power values are for 20, 40, and till
+	 * BSS BW power levels.
+	 * The num_pwr_levels will be checked by sw how many elements present
+	 * in the variable-length array.
+	 */
+} __packed;
+
 #define WMI_IE_BITMAP_SIZE             8
 
 #define WMI_SCAN_MAX_NUM_SSID                0x0A
@@ -4824,5 +4855,8 @@ int ath12k_wmi_probe_resp_tmpl(struct ath12k *ar, u32 vdev_id,
 			       struct sk_buff *tmpl);
 int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 			   enum wmi_host_hw_mode_config_type mode);
+int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
+				       u32 vdev_id,
+				       struct ath12k_reg_tpc_power_info *param);
 
 #endif
-- 
2.17.1

