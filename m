Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E29C7EE811
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 21:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjKPUEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 15:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjKPUEc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 15:04:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7A1A7
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 12:04:28 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGFvxwa009704;
        Thu, 16 Nov 2023 20:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5nlQAqrPYNbe0NejFteYTFle+bF6Ip1xXchYXHHuMqE=;
 b=RFNaU3stvfB6CaAwHkbN6lVj0/Dgar9kqi9OplnRdDi3Q57nhHmcz0LOMCheEdMS8PVI
 poRyTg2jGuGmvT+ZR+Hby3FPhpvYeK41MUlW/J3OQ7yx/nHvSVZLNLh/JJgIXidUksRT
 NOmyBEGENIvVEnyySBGv6UV5+fr/yVS/XtJuq4f8yt5TZS5+goeWJ1UbcMCKXCJ2BDXb
 h+vanXbEePTw2dumdFuG2gJm/6ZIS5DP561qMgrRMAqmrV8tzDjzWRdUoxrIQRvxip8E
 wIUxux0rVxCpARW13PYmyEfTbFfhiL17VxZwNRvhi655L6PXT2wJIeDLVmrM2/EALqko RQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udhe1s8gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 20:04:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGK4QNa030856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 20:04:26 GMT
Received: from [10.110.1.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 12:04:26 -0800
Message-ID: <ab090825-7ed2-42ff-9190-8f33bcc174fd@quicinc.com>
Date:   Thu, 16 Nov 2023 12:04:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath10k: add support to allow broadcast action
 frame RX
Content-Language: en-US
To:     James Prestwood <prestwoj@gmail.com>,
        <linux-wireless@vger.kernel.org>
References: <20231116173246.40458-1-prestwoj@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231116173246.40458-1-prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7rcywdt16tjGh_0sZquMUPt6P8dCtMDb
X-Proofpoint-ORIG-GUID: 7rcywdt16tjGh_0sZquMUPt6P8dCtMDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_21,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160157
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/16/2023 9:32 AM, James Prestwood wrote:
> Broadcast action frames are needed for the Device Provisioning
> Protocol (DPP) for Presence and PKEX Exchange requests. Currently
> just ath9k has this capability so this is being enabled for
> ath10k (for at least one hardware variant).
> 
> Add a new capability flag in ath10k_hw_params to indicate support
> for receiving multicast action frames. This bit is then checked
> when configuring the RX filter and (if set) multicast action frame
> registration is enabled.
> 
> Until more hardware can be tested only the "qca6174 hw3.2" variant
> is enabling this feature.
> 
> Note: I went ahead and removed the 'changed_flags' mask operation
> since it had no effect, that parameter was not being used anywhere.
> 
> Tested-on: QCA6174 hw3.2 WLAN.RM.4.4.1-00288-
> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/core.c |  1 +
>  drivers/net/wireless/ath/ath10k/hw.h   |  3 +++
>  drivers/net/wireless/ath/ath10k/mac.c  | 14 +++++++++++---
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> v2:
>  * Add flag in ath10k_hw_params and only set FIF_MCAST_ACTION
>    if that hardware allows it.
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 5eb131ab916f..f2077756ffdf 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -381,6 +381,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
>  		.hw_restart_disconnect = false,
>  		.use_fw_tx_credits = true,
>  		.delay_unmap_buffer = false,
> +		.mcast_frame_registration = true,
>  	},
>  	{
>  		.id = QCA99X0_HW_2_0_DEV_VERSION,
> diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
> index 9643031a4427..2aeb52c7f189 100644
> --- a/drivers/net/wireless/ath/ath10k/hw.h
> +++ b/drivers/net/wireless/ath/ath10k/hw.h
> @@ -639,6 +639,9 @@ struct ath10k_hw_params {
>  	bool use_fw_tx_credits;
>  
>  	bool delay_unmap_buffer;
> +
> +	/* The hardware support multicast frame registrations */
> +	bool mcast_frame_registration;
>  };
>  
>  struct htt_resp;
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index ec8d5b29bc72..0d0de3646d31 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -1249,7 +1249,7 @@ static bool ath10k_mac_monitor_vdev_is_needed(struct ath10k *ar)
>  	return ar->monitor ||
>  	       (!test_bit(ATH10K_FW_FEATURE_ALLOWS_MESH_BCAST,
>  			  ar->running_fw->fw_file.fw_features) &&
> -		(ar->filter_flags & FIF_OTHER_BSS)) ||
> +		(ar->filter_flags & (FIF_OTHER_BSS | FIF_MCAST_ACTION))) ||
>  	       test_bit(ATH10K_CAC_RUNNING, &ar->dev_flags);
>  }
>  
> @@ -6027,11 +6027,15 @@ static void ath10k_configure_filter(struct ieee80211_hw *hw,
>  {
>  	struct ath10k *ar = hw->priv;
>  	int ret;
> +	unsigned int supported = SUPPORTED_FILTERS;
>  
>  	mutex_lock(&ar->conf_mutex);
>  
> -	changed_flags &= SUPPORTED_FILTERS;
> -	*total_flags &= SUPPORTED_FILTERS;
> +	if (ar->hw_params.mcast_frame_registration)
> +		supported |= FIF_MCAST_ACTION;
> +
> +	*total_flags &= supported;
> +
>  	ar->filter_flags = *total_flags;
>  
>  	ret = ath10k_monitor_recalc(ar);
> @@ -10114,6 +10118,10 @@ int ath10k_mac_register(struct ath10k *ar)
>  			      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
>  	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_AQL);
>  
> +	if (ar->hw_params.mcast_frame_registration)
> +		wiphy_ext_feature_set(ar->hw->wiphy,
> +				      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
> +
>  	if (test_bit(WMI_SERVICE_TX_DATA_ACK_RSSI, ar->wmi.svc_map) ||
>  	    test_bit(WMI_SERVICE_HTT_MGMT_TX_COMP_VALID_FLAGS, ar->wmi.svc_map))
>  		wiphy_ext_feature_set(ar->hw->wiphy,

+ath10k mailing list for visibility

(note I scan ath10/11/12k mailing lists constantly but due to the volume
only scan linux-wireless every few days)
