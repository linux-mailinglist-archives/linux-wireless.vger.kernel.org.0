Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE697A6C15
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjISUJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjISUJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 16:09:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727EEB6
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 13:09:15 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JJZFYN027097;
        Tue, 19 Sep 2023 20:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8mB1Mh/gfo9YqrAb+mFvDc86FBJPmVawwwzj7vlUa0g=;
 b=Gkrc6Id9RE3LSGmBxd69uEEE2nnojc3Gbp/IN5BtpLKAhxZd7Xv00HmKtEzv2uZeeeUL
 5gt000UgwI7ASXAkJ/kpNHdpLcGrFW7aFuE8332J0xXdPMFDSbbNxkmLPC6lXb3yp9Hb
 C9R5aX3gNwQ5XXstoxQPBNpksV+/gBIsGinyYDLP55PE/b5K0WlSFbypucT1sWzmWE2j
 dn6GldUy5HzsB2ZU8/Rd8+FuMS//xeYgAeO+8WA6q3FOjAb3V8SRSsjSe4YgRD4RjVJO
 DTGkTcRemxvElrnRf63hqTFlpgWTs3ooEnjGZ84Mz9+Jq2Ti2sPrtFL0V9oS3uFQ0AMb pw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6vcmakc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 20:09:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JK9A2A030551
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 20:09:10 GMT
Received: from [10.48.245.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 13:09:09 -0700
Message-ID: <bca298ab-6f68-47d4-9de1-61815793cb08@quicinc.com>
Date:   Tue, 19 Sep 2023 13:09:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] wifi: ath12k: fill parameters for vdev_set_tpc_power
 wmi command
Content-Language: en-US
To:     Aishwarya R <quic_aisr@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
 <20230919071724.15505-7-quic_aisr@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230919071724.15505-7-quic_aisr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WFCy70Wqslpvq-gSJvPhIuPlWUF1DRRj
X-Proofpoint-GUID: WFCy70Wqslpvq-gSJvPhIuPlWUF1DRRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_10,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/19/2023 12:17 AM, Aishwarya R wrote:
> Prepare the parameters which is needed for wmi cmd
> vdev_set_tpc_power.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h |   1 +
>   drivers/net/wireless/ath/ath12k/mac.c  | 273 +++++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/mac.h  |   3 +
>   drivers/net/wireless/ath/ath12k/wmi.c  |   1 +
>   drivers/net/wireless/ath/ath12k/wmi.h  |   1 +
>   5 files changed, 279 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 01768fe79bd6..e9bf87f740cd 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -606,6 +606,7 @@ struct ath12k {
>   	bool monitor_vdev_created;
>   	bool monitor_started;
>   	int monitor_vdev_id;
> +	s8 max_allowed_tx_power;
>   };
>   
>   struct ath12k_band_cap {
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 0683b22137b0..35bd472267c1 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5883,6 +5883,279 @@ static u8 ath12k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
>   	return num_pwr_levels;
>   }
>   
> +static u16 ath12k_mac_get_6ghz_start_frequency(struct cfg80211_chan_def *chan_def)
> +{
> +	u16 diff_seq;
> +
> +	/* It is to get the lowest channel number's center frequency of the chan.

s/It is to //

also suggest any function documentation should appear before the 
function, and if the function requires documentation, that kernel-doc 
format be used

same guidance applies to the functions that follow

> +	 * For example,
> +	 * bandwidth=40 MHz, center frequency is 5965, lowest channel is 1
> +	 * with center frequency 5955, its diff is 5965 - 5955 = 10.
> +	 * bandwidth=80 MHz, center frequency is 5985, lowest channel is 1
> +	 * with center frequency 5955, its diff is 5985 - 5955 = 30.
> +	 * bandwidth=160 MHz, center frequency is 6025, lowest channel is 1
> +	 * with center frequency 5955, its diff is 6025 - 5955 = 70.
> +	 */
> +	switch (chan_def->width) {
> +	case NL80211_CHAN_WIDTH_160:
> +		diff_seq = 70;
> +		break;
> +	case NL80211_CHAN_WIDTH_80:
> +	case NL80211_CHAN_WIDTH_80P80:
> +		diff_seq = 30;
> +		break;
> +	case NL80211_CHAN_WIDTH_40:
> +		diff_seq = 10;
> +		break;
> +	default:
> +		diff_seq = 0;
> +	}
> +
> +	return chan_def->center_freq1 - diff_seq;
> +}
> +
> +static u16 ath12k_mac_get_seg_freq(struct cfg80211_chan_def *chan_def,
> +				   u16 start_seq, u8 seq)
> +{
> +	u16 seg_seq;
> +
> +	/* It is to get the center frequency of the specific bandwidth.
> +	 * start_seq means the lowest channel number's center frequency.
> +	 * seq 0/1/2/3 means 20 MHz/40 MHz/80 MHz/160 MHz & 80P80.
> +	 * For example,
> +	 * lowest channel is 1, its center frequency 5955,
> +	 * center frequency is 5955 when bandwidth=20 MHz, its diff is 5955 - 5955 = 0.
> +	 * lowest channel is 1, its center frequency 5955,
> +	 * center frequency is 5965 when bandwidth=40 MHz, its diff is 5965 - 5955 = 10.
> +	 * lowest channel is 1, its center frequency 5955,
> +	 * center frequency is 5985 when bandwidth=80 MHz, its diff is 5985 - 5955 = 30.
> +	 * lowest channel is 1, its center frequency 5955,
> +	 * center frequency is 6025 when bandwidth=160 MHz, its diff is 6025 - 5955 = 70.
> +	 */
> +	if (chan_def->width == NL80211_CHAN_WIDTH_80P80 && seq == 3)
> +		return chan_def->center_freq2;
> +
> +	seg_seq = 10 * (BIT(seq) - 1);
> +	return seg_seq + start_seq;
> +}
> +
> +static void ath12k_mac_get_psd_channel(struct ath12k *ar,
> +				       u16 step_freq,
> +				       u16 *start_freq,
> +				       u16 *center_freq,
> +				       u8 i,
> +				       struct ieee80211_channel **temp_chan,
> +				       s8 *tx_power)
> +{
> +	/* It is to get the center frequency for each 20 MHz.
> +	 * For example, if the chan is 160 MHz and center frequency is 6025,
> +	 * then it include 8 channels, they are 1/5/9/13/17/21/25/29,
> +	 * channel number 1's center frequency is 5955, it is parameter start_freq.
> +	 * parameter i is the step of the 8 channels. i is 0~7 for the 8 channels.
> +	 * the channel 1/5/9/13/17/21/25/29 maps i=0/1/2/3/4/5/6/7,
> +	 * and maps its center frequency is 5955/5975/5995/6015/6035/6055/6075/6095,
> +	 * the gap is 20 for each channel, parameter step_freq means the gap.
> +	 * after get the center frequency of each channel, it is easy to find the
> +	 * struct ieee80211_channel of it and get the max_reg_power.
> +	 */
> +	*center_freq = *start_freq + i * step_freq;
> +	*temp_chan = ieee80211_get_channel(ar->hw->wiphy, *center_freq);
> +	*tx_power = (*temp_chan)->max_reg_power;
> +}
> +
> +static void ath12k_mac_get_eirp_power(struct ath12k *ar,
> +				      u16 *start_freq,
> +				      u16 *center_freq,
> +				      u8 i,
> +				      struct ieee80211_channel **temp_chan,
> +				      struct cfg80211_chan_def *def,
> +				      s8 *tx_power)
> +{
> +	/* It is to get the center frequency for 20 MHz/40 MHz/80 MHz/
> +	 * 160 MHz & 80P80 bandwidth, and then plus 10 to the center frequency,
> +	 * it is the center frequency of a channel number.
> +	 * For example, when configured channel number is 1.
> +	 * center frequency is 5965 when bandwidth=40 MHz, after plus 10, it is 5975,
> +	 * then it is channel number 5.
> +	 * center frequency is 5985 when bandwidth=80 MHz, after plus 10, it is 5995,
> +	 * then it is channel number 9.
> +	 * center frequency is 6025 when bandwidth=160 MHz, after plus 10, it is 6035,
> +	 * then it is channel number 17.
> +	 * after get the center frequency of each channel, it is easy to find the
> +	 * struct ieee80211_channel of it and get the max_reg_power.
> +	 */
> +	*center_freq = ath12k_mac_get_seg_freq(def, *start_freq, i);
> +	*center_freq += 10;
> +	*temp_chan = ieee80211_get_channel(ar->hw->wiphy, *center_freq);
> +	*tx_power = (*temp_chan)->max_reg_power;
> +}
> +
> +void ath12k_mac_fill_reg_tpc_info(struct ath12k *ar,
> +				  struct ieee80211_vif *vif,
> +				  struct ieee80211_chanctx_conf *ctx)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_vif *arvif = (void *)vif->drv_priv;
> +	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
> +	struct ath12k_reg_tpc_power_info *reg_tpc_info = &arvif->reg_tpc_info;
> +	struct ieee80211_channel *chan, *temp_chan;
> +	u8 pwr_lvl_idx, num_pwr_levels, pwr_reduction;
> +	bool is_psd_power = false, is_tpe_present = false;
> +	s8 max_tx_power[IEEE80211_MAX_NUM_PWR_LEVEL],
> +		psd_power, tx_power = 0, eirp_power = 0;
> +	u16 start_freq = 0, center_freq = 0;
> +
> +	chan = ctx->def.chan;
> +	start_freq = ath12k_mac_get_6ghz_start_frequency(&ctx->def);
> +	pwr_reduction = bss_conf->pwr_reduction;
> +
> +	if (arvif->vdev_type == WMI_VDEV_TYPE_STA &&
> +	    arvif->reg_tpc_info.num_pwr_levels) {
> +		is_tpe_present = true;
> +		num_pwr_levels = arvif->reg_tpc_info.num_pwr_levels;
> +	} else {
> +		num_pwr_levels = ath12k_mac_get_num_pwr_levels(&ctx->def);
> +	}
> +
> +	for (pwr_lvl_idx = 0; pwr_lvl_idx < num_pwr_levels; pwr_lvl_idx++) {
> +		/* STA received TPE IE*/
> +		if (is_tpe_present) {
> +			/* local power is PSD power*/
> +			if (chan->flags & IEEE80211_CHAN_PSD) {
> +				/* Connecting AP is psd power */
> +				if (reg_tpc_info->is_psd_power) {
> +					is_psd_power = true;
> +					ath12k_mac_get_psd_channel(ar, 20,
> +								   &start_freq,
> +								   &center_freq,
> +								   pwr_lvl_idx,
> +								   &temp_chan,
> +								   &tx_power);
> +					psd_power = temp_chan->psd;
> +					eirp_power = tx_power;
> +					max_tx_power[pwr_lvl_idx] =
> +						min_t(s8,
> +						      psd_power,
> +						      reg_tpc_info->tpe[pwr_lvl_idx]);
> +				/* Connecting AP is not psd power */
> +				} else {
> +					ath12k_mac_get_eirp_power(ar,
> +								  &start_freq,
> +								  &center_freq,
> +								  pwr_lvl_idx,
> +								  &temp_chan,
> +								  &ctx->def,
> +								  &tx_power);
> +					psd_power = temp_chan->psd;
> +					/* convert psd power to EIRP power based
> +					 * on channel width
> +					 */
> +					tx_power =
> +						min_t(s8, tx_power,
> +						      psd_power + 13 + pwr_lvl_idx * 3);
> +					max_tx_power[pwr_lvl_idx] =
> +						min_t(s8,
> +						      tx_power,
> +						      reg_tpc_info->tpe[pwr_lvl_idx]);
> +			}

bad brace placement?

> +			/* local power is not PSD power */
> +			} else {
> +				/* Connecting AP is psd power */
> +				if (reg_tpc_info->is_psd_power) {
> +					is_psd_power = true;
> +					ath12k_mac_get_psd_channel(ar, 20,
> +								   &start_freq,
> +								   &center_freq,
> +								   pwr_lvl_idx,
> +								   &temp_chan,
> +								   &tx_power);
> +					eirp_power = tx_power;
> +					max_tx_power[pwr_lvl_idx] =
> +						reg_tpc_info->tpe[pwr_lvl_idx];
> +				/* Connecting AP is not psd power */
> +				} else {
> +					ath12k_mac_get_eirp_power(ar,
> +								  &start_freq,
> +								  &center_freq,
> +								  pwr_lvl_idx,
> +								  &temp_chan,
> +								  &ctx->def,
> +								  &tx_power);
> +					max_tx_power[pwr_lvl_idx] =
> +						min_t(s8,
> +						      tx_power,
> +						      reg_tpc_info->tpe[pwr_lvl_idx]);
> +				}
> +		}

bad brace placement?

> +		/* STA not received TPE IE */
> +		} else {
> +			/* local power is PSD power*/
> +			if (chan->flags & IEEE80211_CHAN_PSD) {
> +				is_psd_power = true;
> +				ath12k_mac_get_psd_channel(ar, 20,
> +							   &start_freq,
> +							   &center_freq,
> +							   pwr_lvl_idx,
> +							   &temp_chan,
> +							   &tx_power);
> +				psd_power = temp_chan->psd;
> +				eirp_power = tx_power;
> +				max_tx_power[pwr_lvl_idx] = psd_power;
> +			} else {
> +				ath12k_mac_get_eirp_power(ar,
> +							  &start_freq,
> +							  &center_freq,
> +							  pwr_lvl_idx,
> +							  &temp_chan,
> +							  &ctx->def,
> +							  &tx_power);
> +				max_tx_power[pwr_lvl_idx] = tx_power;
> +			}
> +		}
> +
> +		if (is_psd_power) {
> +			/* If AP local power constraint is present */
> +			if (pwr_reduction)
> +				eirp_power = eirp_power - pwr_reduction;
> +
> +			/* If FW updated max tx power is non zero, then take the min of
> +			 * firmware updated ap tx power
> +			 * and max power derived from above mentioned parameters.
> +			 */
> +			ath12k_dbg(ab, ATH12K_DBG_MAC,
> +				   "eirp power : %d firmware report power : %d\n",
> +				   eirp_power, ar->max_allowed_tx_power);
> +			if ((ar->max_allowed_tx_power) && (ab->hw_params->idle_ps))
> +				eirp_power = min_t(s8,
> +						   eirp_power,
> +						   ar->max_allowed_tx_power);
> +		} else {
> +			/* If AP local power constraint is present */
> +			if (pwr_reduction)
> +				max_tx_power[pwr_lvl_idx] =
> +					max_tx_power[pwr_lvl_idx] - pwr_reduction;
> +			/* If FW updated max tx power is non zero, then take the min of
> +			 * firmware updated ap tx power
> +			 * and max power derived from above mentioned parameters.
> +			 */
> +			if ((ar->max_allowed_tx_power) && (ab->hw_params->idle_ps))
> +				max_tx_power[pwr_lvl_idx] =
> +					min_t(s8,
> +					      max_tx_power[pwr_lvl_idx],
> +					      ar->max_allowed_tx_power);
> +		}
> +		reg_tpc_info->chan_power_info[pwr_lvl_idx].chan_cfreq = center_freq;
> +		reg_tpc_info->chan_power_info[pwr_lvl_idx].tx_power =
> +			max_tx_power[pwr_lvl_idx];
> +	}
> +
> +	reg_tpc_info->num_pwr_levels = num_pwr_levels;
> +	reg_tpc_info->is_psd_power = is_psd_power;
> +	reg_tpc_info->eirp_power = eirp_power;
> +	reg_tpc_info->power_type_6ghz =
> +		ath12k_ieee80211_ap_pwr_type_convert(vif->bss_conf.power_type);
> +}
> +
>   static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
>   					struct ieee80211_vif *vif,
>   					struct ieee80211_chanctx_conf *ctx)
> diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
> index 82f590004d05..ce2ce7f324d7 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.h
> +++ b/drivers/net/wireless/ath/ath12k/mac.h
> @@ -68,6 +68,9 @@ struct ath12k *ath12k_mac_get_ar_by_vdev_id(struct ath12k_base *ab, u32 vdev_id)
>   struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id);
>   enum wmi_vdev_type ath12k_mac_get_ar_vdev_type(struct ath12k *ar);
>   
> +void ath12k_mac_fill_reg_tpc_info(struct ath12k *ar,
> +				  struct ieee80211_vif *vif,
> +				  struct ieee80211_chanctx_conf *ctx);
>   void ath12k_mac_drain_tx(struct ath12k *ar);
>   void ath12k_mac_peer_cleanup_all(struct ath12k *ar);
>   int ath12k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 211bdb915173..5bfca2513730 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -5588,6 +5588,7 @@ static void ath12k_vdev_start_resp_event(struct ath12k_base *ab, struct sk_buff
>   	}
>   
>   	ar->last_wmi_vdev_start_status = 0;
> +	ar->max_allowed_tx_power = le32_to_cpu(vdev_start_resp.max_allowed_tx_power);
>   
>   	status = le32_to_cpu(vdev_start_resp.status);
>   
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index c3b110af1272..9f24f8ded52f 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3796,6 +3796,7 @@ struct wmi_vdev_start_resp_event {
>   	};
>   	__le32 cfgd_tx_streams;
>   	__le32 cfgd_rx_streams;
> +	__le32 max_allowed_tx_power;
>   } __packed;
>   
>   /* VDEV start response status codes */

