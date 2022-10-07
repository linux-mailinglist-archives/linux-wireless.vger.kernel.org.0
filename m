Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618E65F7F99
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJGVRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 17:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJGVR2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 17:17:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCC536DFE
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 14:17:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297KQu1K028477;
        Fri, 7 Oct 2022 21:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3QrNVi1usyWME1gXqNkiJMWH+RqywCHaV32uqXC/9Ss=;
 b=RkH2RAp1CiM1y2GHQVnGvuLA/4zJ3Iqt5MUiIw8AhI8KpcSafcC2VxGzJ2GsbNrHTYmK
 cTgibubV3LP0AU20wTurAIPC8rCMjlfuVDOgwopKUqNGvR+LIi8sik8CKge6RZ3Y+e4s
 qOTJky3k6ZAN54R0uC1eajrL+S+DY+bdUe+lCm7C+AxVQdegX1hlLVbhZCD7BtXaSOWw
 SmOy5WzQzF20lU/SdxJqz8xv+bSSrWv7Ev8U8cEloxpcDDULHbUeA/63RekfvaXcNcsr
 Hd/jt/Qb4J4b651jmMvNRBa5V3OTVJd7HnaI+VGnLvi0LpOq0OYeoiCaCPr77qrhWL5D vA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k2a7qt48w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 21:17:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 297LHDAA014030
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Oct 2022 21:17:13 GMT
Received: from [10.110.6.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 7 Oct 2022
 14:17:12 -0700
Message-ID: <1b78eac5-2349-8845-aa5c-3092ba0e8b6f@quicinc.com>
Date:   Fri, 7 Oct 2022 14:17:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] wifi: ath11k: add support to configure channel dwell time
Content-Language: en-US
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20221007051130.6067-1-quic_mpubbise@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20221007051130.6067-1-quic_mpubbise@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o-Rs28QNKQy6QfjKH1iALLPA35fJ0bFq
X-Proofpoint-ORIG-GUID: o-Rs28QNKQy6QfjKH1iALLPA35fJ0bFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070127
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/6/2022 10:11 PM, Manikanta Pubbisetty wrote:
> Add support to configure channel dwell time during scan.
> Dwell time help to stay on the channel for a specified duration
> during scan and aid userspace in finding WiFi networks. Very
> useful in passive scans where longer dwell times are needed
> to find the WiFi networks.
> 
> Configure channel dwell time from duration of the scan request
> received from mac80211 when the duration is non-zero. When the
> scan request does not have duration value, use the default ones,
> the current implementation.
> 
> Advertise orresponding feature flag NL80211_EXT_FEATURE_SET_SCAN_DWELL

s/orresponding/corresponding/
Kalle can fix that when he merges so don't repost for that

> to enable the feature.
> 
> Change is applicable for all ath11k hardware.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 33 +++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 84d956ad4093..0da136916e0e 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -241,7 +241,10 @@ const struct htt_rx_ring_tlv_filter ath11k_mac_mon_status_filter_default = {
>   #define ath11k_a_rates (ath11k_legacy_rates + 4)
>   #define ath11k_a_rates_size (ARRAY_SIZE(ath11k_legacy_rates) - 4)
>   
> -#define ATH11K_MAC_SCAN_TIMEOUT_MSECS 200 /* in msecs */
> +#define ATH11K_MAC_SCAN_CMD_EVT_OVERHEAD		200 /* in msecs */
> +
> +/* Overhead due to the processing of channel switch events from FW */
> +#define ATH11K_SCAN_CHANNEL_SWITCH_WMI_EVT_OVERHEAD	10 /* in msecs */
>   
>   static const u32 ath11k_smps_map[] = {
>   	[WLAN_HT_CAP_SM_PS_STATIC] = WMI_PEER_SMPS_STATIC,
> @@ -3611,6 +3614,7 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
>   	struct scan_req_params arg;
>   	int ret = 0;
>   	int i;
> +	u32 scan_timeout;
>   
>   	mutex_lock(&ar->conf_mutex);
>   
> @@ -3680,6 +3684,26 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
>   		ether_addr_copy(arg.mac_mask.addr, req->mac_addr_mask);
>   	}
>   
> +	/* if duration is set, default dwell times will be overwritten */
> +	if (req->duration) {
> +		arg.dwell_time_active = req->duration;
> +		arg.dwell_time_active_2g = req->duration;
> +		arg.dwell_time_active_6g = req->duration;
> +		arg.dwell_time_passive = req->duration;
> +		arg.dwell_time_passive_6g = req->duration;
> +		arg.burst_duration = req->duration;
> +
> +		scan_timeout = min_t(u32, arg.max_rest_time *
> +				(arg.num_chan - 1) + (req->duration +
> +				ATH11K_SCAN_CHANNEL_SWITCH_WMI_EVT_OVERHEAD) *
> +				arg.num_chan, arg.max_scan_time);
> +	} else {
> +		scan_timeout = arg.max_scan_time;
> +	}
> +
> +	/* Add a margin to account for event/command processing */
> +	scan_timeout += ATH11K_MAC_SCAN_CMD_EVT_OVERHEAD;
> +
>   	ret = ath11k_start_scan(ar, &arg);
>   	if (ret) {
>   		ath11k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
> @@ -3688,10 +3712,8 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
>   		spin_unlock_bh(&ar->data_lock);
>   	}
>   
> -	/* Add a 200ms margin to account for event/command processing */
>   	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
> -				     msecs_to_jiffies(arg.max_scan_time +
> -						      ATH11K_MAC_SCAN_TIMEOUT_MSECS));
> +				     msecs_to_jiffies(scan_timeout));
>   
>   exit:
>   	kfree(arg.chan_list);
> @@ -9013,6 +9035,9 @@ static int __ath11k_mac_register(struct ath11k *ar)
>   				      NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
>   	}
>   
> +	wiphy_ext_feature_set(ar->hw->wiphy,
> +			      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
> +
>   	ath11k_reg_init(ar);
>   
>   	if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {
> 
> base-commit: 023baf1318ef21442fab3842bf03883bc81223e0

