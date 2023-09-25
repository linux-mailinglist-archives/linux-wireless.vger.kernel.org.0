Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D57ADF5D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 21:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjIYTBD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjIYTBD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 15:01:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5828295
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 12:00:55 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PHxHpS010670;
        Mon, 25 Sep 2023 19:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WVOeGxUbcje7tguoD5dQDxVc7TDw4QK9aSHUqmlJXWM=;
 b=ao06b0i3BXx8vHHxZ1tKxFd8DUhlxigl8DxZKRmTaYLLgWHAZ5y/pAUjaJNdFxp0IAbl
 cMoLekoPAok6Ic0bzZtp56exXUlemlKID+BMry+aVy6XDkcADn9LEiGpEb9FzO4TX91w
 wVrk4mY4Mva/Nl73G5gPhScJWiO/T8N0BVxDFh+qRBtk+OdpFkPwqb/+cDozhyw/BXYX
 g2NED0Ga/ez5p9cXwHXNH5I4J1F83yEVjmVt4yKzEf3nWSLCqIOQkVQLftc5i41w4THT
 czOt/QRoKXOAQMMVifPxwQ2eS/IwFrY4Kghs2Co+IHZo0akVBiGee9jZj3uMxDHjmCG/ Rw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9pywd7xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 19:00:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PJ0nPK020928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 19:00:49 GMT
Received: from [10.48.244.213] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 12:00:48 -0700
Message-ID: <30dfbf07-9ec9-4ac9-8199-9f08dbe03739@quicinc.com>
Date:   Mon, 25 Sep 2023 12:00:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix ath11k_mac_op_remain_on_channel() stack
 usage
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Tom Rix <trix@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
References: <20230925124613.2452273-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230925124613.2452273-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4OPlV-CaGsX-2tsw2VWJ5Or-lkwLV6Fz
X-Proofpoint-ORIG-GUID: 4OPlV-CaGsX-2tsw2VWJ5Or-lkwLV6Fz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_15,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250148
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/25/2023 5:46 AM, Dmitry Antipov wrote:
> When compiling with clang 16.0.6, I've noticed the following:
> 
> drivers/net/wireless/ath/ath11k/mac.c:8903:12: warning: stack frame
> size (1032) exceeds limit (1024) in 'ath11k_mac_op_remain_on_channel'
> [-Wframe-larger-than]
> static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>             ^
> 68/1032 (6.59%) spills, 964/1032 (93.41%) variables
> 
> So switch to kzalloc()'ed instance of 'struct scan_req_params' like
> it's done in 'ath11k_mac_op_hw_scan()'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 43 +++++++++++++++------------
>   1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 6ed036b51dba..c7d51f6aeede 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -8908,7 +8908,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>   {
>   	struct ath11k *ar = hw->priv;
>   	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
> -	struct scan_req_params arg;
> +	struct scan_req_params *arg = NULL;
>   	int ret;
>   	u32 scan_time_msec;
>   
> @@ -8940,27 +8940,31 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>   
>   	scan_time_msec = ar->hw->wiphy->max_remain_on_channel_duration * 2;
>   
> -	memset(&arg, 0, sizeof(arg));
> -	ath11k_wmi_start_scan_init(ar, &arg);
> -	arg.num_chan = 1;
> -	arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
> -				GFP_KERNEL);
> -	if (!arg.chan_list) {
> +	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
> +	if (!arg) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +	ath11k_wmi_start_scan_init(ar, arg);
> +	arg->num_chan = 1;
> +	arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
> +				 GFP_KERNEL);
> +	if (!arg->chan_list) {
>   		ret = -ENOMEM;
>   		goto exit;
>   	}
>   
> -	arg.vdev_id = arvif->vdev_id;
> -	arg.scan_id = ATH11K_SCAN_ID;
> -	arg.chan_list[0] = chan->center_freq;
> -	arg.dwell_time_active = scan_time_msec;
> -	arg.dwell_time_passive = scan_time_msec;
> -	arg.max_scan_time = scan_time_msec;
> -	arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
> -	arg.scan_flags |= WMI_SCAN_FILTER_PROBE_REQ;
> -	arg.burst_duration = duration;
> -
> -	ret = ath11k_start_scan(ar, &arg);
> +	arg->vdev_id = arvif->vdev_id;
> +	arg->scan_id = ATH11K_SCAN_ID;
> +	arg->chan_list[0] = chan->center_freq;
> +	arg->dwell_time_active = scan_time_msec;
> +	arg->dwell_time_passive = scan_time_msec;
> +	arg->max_scan_time = scan_time_msec;
> +	arg->scan_flags |= WMI_SCAN_FLAG_PASSIVE;
> +	arg->scan_flags |= WMI_SCAN_FILTER_PROBE_REQ;
> +	arg->burst_duration = duration;
> +
> +	ret = ath11k_start_scan(ar, arg);
>   	if (ret) {
>   		ath11k_warn(ar->ab, "failed to start roc scan: %d\n", ret);
>   
> @@ -8986,8 +8990,9 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>   	ret = 0;
>   
>   free_chan_list:
> -	kfree(arg.chan_list);
> +	kfree(arg->chan_list);
>   exit:
> +	kfree(arg);

consider adding a free_arg: label which you'd goto if the chan_list 
allocation fails. exit: would continue to just have the mutex_unlock()

with that change you no longer need the arg = NULL initializer

>   	mutex_unlock(&ar->conf_mutex);
>   	return ret;
>   }

