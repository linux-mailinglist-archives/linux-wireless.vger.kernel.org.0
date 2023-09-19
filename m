Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABC57A6C48
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 22:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjISUWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjISUWR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 16:22:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD65BE
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 13:22:11 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JKCQMj013130;
        Tue, 19 Sep 2023 20:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0664GNu6kdAzaJVNwn82lFiHh34fchNprkK1Q+qGWjo=;
 b=VTPgH24EjNOw9khsRF9OKKoN5qIodu7Hr5ZZq/Gmcfxd+M7ye10r50eyiSo4gZ1TpH9l
 hCpoOU8JinpeRzZ8mMzkKB7KCp2iEXYTNW1vKYF+JQuAwzwkBcm5wtjbFhRpPHcXuRGG
 ESqeBMAKU+/Dxkjfy1bG5tFXEoKCmTjUQv2DJbTzjx243+NjzchBqu4sptu3/qIV+X9d
 4nVU95T88tF/jmeub4pF2gkVLSJ7P91M51DNkeWUmcjR6dqAyXPyn4bWYoJ4hb+EqiOw
 qBpgh5K7hh9XtSCLbs2N+201uLTo1QkDroK6V9vH+oYdU/nwV0Dqy5PEZ8CS/Zdwb5kG AA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6mtsbxk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 20:21:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JKLxtm004409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 20:21:59 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 13:21:58 -0700
Message-ID: <b5238b10-ca83-40df-b7e3-b0161b98ede7@quicinc.com>
Date:   Tue, 19 Sep 2023 13:21:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] wifi: ath12k: send TPC power to firmware for 6 GHz
 VDEV
Content-Language: en-US
To:     Aishwarya R <quic_aisr@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
 <20230919071724.15505-8-quic_aisr@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230919071724.15505-8-quic_aisr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RuqnkPKSv7Pw9JHCaEYjC13WVA346ub6
X-Proofpoint-ORIG-GUID: RuqnkPKSv7Pw9JHCaEYjC13WVA346ub6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_10,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/19/2023 12:17 AM, Aishwarya R wrote:
> When STATION is connected to a 6 GHz AP, or when AP boots up, it has

what is "it"?

> 2 ways to configure the power limit to firmware. Currently it
> sends 2 wmi command WMI_PDEV_PARAM_TXPOWER_LIMIT2G/
> WMI_PDEV_PARAM_TXPOWER_LIMIT5G to firmware.
> 
> Add support to send WMI_VDEV_SET_TPC_POWER_CMDID to firmware which
> include more parameters for power control. When firmware support
> SERVICE_EXT_TPC_REG, it means firmware support this feature, then ath12k
> discard BSS_CHANGED_TXPOWER flag from mac80211 which is used to the first
> way for 6 GHz band.

I'm not parsing this last sentence. s I mentioned in a previous patch, 
it will be easier to understand if you break it down:
what the current code does
what is wrong with the current code
how to fix the current code

> 
> The second way is to prepare the parameter for wmi command
> WMI_VDEV_SET_TPC_POWER_CMDID and send the firmware after vdev start
> response success from firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 25 +++++++++-
>   drivers/net/wireless/ath/ath12k/wmi.c | 67 +++++++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h | 36 +++++++++++++-
>   3 files changed, 125 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 35bd472267c1..5505f933a4e1 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2467,8 +2467,18 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>   		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev_id %i txpower %d\n",
>   			   arvif->vdev_id, info->txpower);
>   
> -		arvif->txpower = info->txpower;
> -		ath12k_mac_txpower_recalc(ar);
> +		if (ar->supports_6ghz && info->chandef.chan &&
> +		    info->chandef.chan->band == NL80211_BAND_6GHZ &&
> +		    (arvif->vdev_type == WMI_VDEV_TYPE_STA ||
> +		     arvif->vdev_type == WMI_VDEV_TYPE_AP) &&
> +		     test_bit(WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT,
> +			      ar->ab->wmi_ab.svc_map)) {
> +			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
> +				   "discard tx power, change to set TPC power\n");
> +		} else {
> +			arvif->txpower = info->txpower;
> +			ath12k_mac_txpower_recalc(ar);
> +		}
>   	}
>   
>   	if (changed & BSS_CHANGED_MCAST_RATE &&
> @@ -5519,6 +5529,16 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
>   		return ret;
>   	}
>   
> +	if (ar->supports_6ghz &&
> +	    chandef->chan->band == NL80211_BAND_6GHZ &&
> +	    (arvif->vdev_type == WMI_VDEV_TYPE_STA ||
> +	     arvif->vdev_type == WMI_VDEV_TYPE_AP) &&
> +	     test_bit(WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT, ar->ab->wmi_ab.svc_map)) {

this complex test occurs in two places. can it be refactored into a 
well-named bool imperative function?

> +		ath12k_mac_fill_reg_tpc_info(ar, arvif->vif, &arvif->chanctx);
> +		ath12k_wmi_send_vdev_set_tpc_power(ar, arvif->vdev_id,
> +						   &arvif->reg_tpc_info);
> +	}
> +
>   	ar->num_started_vdevs++;
>   	ath12k_dbg(ab, ATH12K_DBG_MAC,  "vdev %pM started, vdev_id %d\n",
>   		   arvif->vif->addr, arvif->vdev_id);
> @@ -6304,6 +6324,7 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
>   		if (power_type == IEEE80211_REG_UNSET_AP)
>   			power_type = IEEE80211_REG_LPI_AP;
>   
> +		arvif->chanctx = *ctx;
>   		if (arvif->vdev_type == WMI_VDEV_TYPE_STA)
>   			ath12k_mac_parse_tx_pwr_env(ar, vif, ctx);
>   	}
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 5bfca2513730..582c7e80c76b 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -2311,6 +2311,73 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>   	return ret;
>   }
>   
> +int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
> +				       u32 vdev_id,
> +				       struct ath12k_reg_tpc_power_info *param)
> +{
> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
> +	struct wmi_vdev_set_tpc_power_cmd *cmd;
> +	struct wmi_vdev_ch_power_info_params *ch;
> +	struct sk_buff *skb;
> +	struct wmi_tlv *tlv;
> +	u8 *ptr;
> +	int i, ret, len;
> +
> +	len = sizeof(*cmd) + TLV_HDR_SIZE;
> +	len += (sizeof(*ch) * param->num_pwr_levels);
> +
> +	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	ptr = skb->data;
> +
> +	cmd = (struct wmi_vdev_set_tpc_power_cmd *)ptr;
> +	cmd->tlv_header = cpu_to_le32(FIELD_PREP(WMI_TLV_TAG,
> +						 WMI_TAG_VDEV_SET_TPC_POWER_CMD) |
> +				      FIELD_PREP(WMI_TLV_LEN,
> +						 sizeof(*cmd) - TLV_HDR_SIZE));

use ath12k_wmi_tlv_cmd_hdr() everywhere you are creating a TLV header


> +	cmd->vdev_id = cpu_to_le32(vdev_id);
> +	cmd->psd_power = cpu_to_le32(param->is_psd_power);
> +	cmd->eirp_power = cpu_to_le32(param->eirp_power);
> +	cmd->power_type_6ghz = cpu_to_le32(param->power_type_6ghz);
> +	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
> +		   "wmi TPC vdev_id: %d is_psd_power: %d eirp_power: %d power_type_6ghz: %d\n",
> +		   vdev_id, param->is_psd_power, param->eirp_power,
> +		   param->power_type_6ghz);
> +
> +	ptr += sizeof(*cmd);
> +	tlv = (struct wmi_tlv *)ptr;
> +	tlv->header = cpu_to_le32(FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
> +				  FIELD_PREP(WMI_TLV_LEN,
> +					     param->num_pwr_levels * sizeof(*ch)));
> +
> +	ptr += TLV_HDR_SIZE;
> +	ch = (struct wmi_vdev_ch_power_info_params *)ptr;
> +
> +	for (i = 0; i < param->num_pwr_levels; i++, ch++) {
> +		ch->tlv_header = cpu_to_le32(FIELD_PREP(WMI_TLV_TAG,
> +							WMI_TAG_VDEV_CH_POWER_INFO) |
> +					     FIELD_PREP(WMI_TLV_LEN,
> +							sizeof(*ch) - TLV_HDR_SIZE));
> +
> +		ch->chan_cfreq = cpu_to_le32(param->chan_power_info[i].chan_cfreq);
> +		ch->tx_power = cpu_to_le32(param->chan_power_info[i].tx_power);
> +
> +		ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
> +			   "wmi TPC chan_cfreq: %d , tx_power: %d\n",
> +			   ch->chan_cfreq, ch->tx_power);
> +	}
> +
> +	ret = ath12k_wmi_cmd_send(wmi, skb,
> +				  WMI_VDEV_SET_TPC_POWER_CMDID);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to send WMI_VDEV_SET_TPC_POWER_CMDID\n");
> +		dev_kfree_skb(skb);
> +	}
> +	return ret;
> +}
> +
>   int ath12k_wmi_send_scan_stop_cmd(struct ath12k *ar,
>   				  struct ath12k_wmi_scan_cancel_arg *arg)
>   {
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 9f24f8ded52f..a97eb2544ab0 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -24,6 +24,7 @@
>   
>   struct ath12k_base;
>   struct ath12k;
> +struct ath12k_reg_tpc_power_info;
>   
>   /* There is no signed version of __le32, so for a temporary solution come
>    * up with our own version. The idea is from fs/ntfs/endian.h.
> @@ -388,6 +389,7 @@ enum wmi_tlv_cmd_id {
>   	WMI_VDEV_SET_CUSTOM_AGGR_SIZE_CMDID,
>   	WMI_VDEV_ENCRYPT_DECRYPT_DATA_REQ_CMDID,
>   	WMI_VDEV_ADD_MAC_ADDR_TO_RX_FILTER_CMDID,
> +	WMI_VDEV_SET_TPC_POWER_CMDID,
>   	WMI_PEER_CREATE_CMDID = WMI_TLV_CMD(WMI_GRP_PEER),
>   	WMI_PEER_DELETE_CMDID,
>   	WMI_PEER_FLUSH_TIDS_CMDID,
> @@ -1924,6 +1926,8 @@ enum wmi_tlv_tag {
>   	WMI_TAG_MAC_PHY_CAPABILITIES_EXT = 0x36F,
>   	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
>   	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
> +	WMI_TAG_VDEV_SET_TPC_POWER_CMD = 0x3B5,
> +	WMI_TAG_VDEV_CH_POWER_INFO,
>   	WMI_TAG_MAX
>   };
>   
> @@ -2148,7 +2152,8 @@ enum wmi_tlv_service {
>   	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
>   	WMI_TLV_SERVICE_EXT2_MSG = 220,
>   
> -	WMI_MAX_EXT_SERVICE
> +	WMI_MAX_EXT_SERVICE,
> +	WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT = 280,
>   };
>   
>   enum {
> @@ -3037,6 +3042,32 @@ struct ath12k_wmi_element_info_arg {
>   	u8 *ptr;
>   };
>   
> +struct wmi_vdev_ch_power_info_params {
> +	__le32 tlv_header;
> +	__le32 chan_cfreq; /* Channel center frequency (MHz) */
> +	/* Unit: dBm, either PSD/EIRP power for this frequency or
> +	 * incremental for non-PSD BW
> +	 */
> +	__le32 tx_power;
> +} __packed;
> +
> +struct wmi_vdev_set_tpc_power_cmd {
> +	__le32 tlv_header;
> +	__le32 vdev_id;
> +	__le32 psd_power; /* Value: 0 or 1, is PSD power or not */
> +	__le32 eirp_power;
> +	/* Maximum EIRP power (dBm units), valid only if power is PSD */
> +	__le32 power_type_6ghz; /* Type: WMI_6 GHz_REG_TYPE, used for halphy CTL lookup */
> +	/* This fixed_param TLV is followed by the below TLVs:
> +	 * num_pwr_levels of wmi_vdev_ch_power_info
> +	 * For PSD power, it is the PSD/EIRP power of the frequency (20 MHz chunks).
> +	 * For non-psd power, the power values are for 20, 40, and till
> +	 * BSS BW power levels.
> +	 * The num_pwr_levels will be checked by sw how many elements present
> +	 * in the variable-length array.
> +	 */
> +} __packed;
> +
>   #define WMI_IE_BITMAP_SIZE             8
>   
>   #define WMI_SCAN_MAX_NUM_SSID                0x0A
> @@ -4824,5 +4855,8 @@ int ath12k_wmi_probe_resp_tmpl(struct ath12k *ar, u32 vdev_id,
>   			       struct sk_buff *tmpl);
>   int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
>   			   enum wmi_host_hw_mode_config_type mode);
> +int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
> +				       u32 vdev_id,
> +				       struct ath12k_reg_tpc_power_info *param);
>   
>   #endif

