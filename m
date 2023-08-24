Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A479A787751
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 19:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbjHXRyG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbjHXRx7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 13:53:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE861BDC
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 10:53:57 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEWs8g003357;
        Thu, 24 Aug 2023 17:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dBgfiEC8pWqdOMl6jHLFTKO3sYLnGvIz2JDpikBzcg8=;
 b=fog5X41xAl/gdDvu2QCi9hjqlG0mrPjNJnNZT1UX9wJ1vC2fxgT64bpvekweTrxuzOJL
 4mbKIaiHccmRyArHeOU2Sh8GV34SgAwUfW2nzjaXN3QyRiRI6LXMd3b5LCrQ9FSMD6VH
 lkWBrsClFSCLlP0VN8QPw9QBjiJtdcLaq01Q1o+KEWPQNo+CFSHd3yUAqP08OE8aL3SJ
 3ODjgZxIC1qp1bvfH3irUWmaZ/qxlZ6lElKPe86lGzP3TPAJZ4SYpg+m3aV1eE0VoXU0
 lECsqwDomx72x6GbD8jOqeQ/muE5Asem3zlQGyuALZ9mrOXdmwhckLkGRHC9ETyNlKp9 TA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snxtat7u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 17:53:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OHrmkq004944
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 17:53:48 GMT
Received: from [10.48.247.99] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 10:53:42 -0700
Message-ID: <5dd4c98d-b3a8-4df5-a8fe-d8125a57baf0@quicinc.com>
Date:   Thu, 24 Aug 2023 10:53:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: ath11k: fix stack usage of
 ath11k_mac_op_remain_on_channel()
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, Tom Rix <trix@redhat.com>,
        <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>,
        <ath11k@lists.infradead.org>
References: <20230824075121.121144-1-dmantipov@yandex.ru>
 <20230824075121.121144-5-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230824075121.121144-5-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ip86py_Cj0RnCXOBGIsftRjj-74ccYaa
X-Proofpoint-GUID: ip86py_Cj0RnCXOBGIsftRjj-74ccYaa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_14,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/24/2023 12:50 AM, Dmitry Antipov wrote:
> When compiling with clang 16.0.6, I've noticed the following:
> 
> drivers/net/wireless/ath/ath11k/mac.c:8900:12: warning: stack frame
> size (1032) exceeds limit (1024) in 'ath11k_mac_op_remain_on_channel'
> [-Wframe-larger-than]
> static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>             ^
> 68/1032 (6.59%) spills, 964/1032 (93.41%) variables
> 
> So switch to kzalloc()'ed instance of 'struct scan_req_params' and
> adjust the function in subject accordingly.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 44 +++++++++++++++------------
>   1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 2aadf2c387b6..3e2983d30a5a 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -8905,7 +8905,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>   {
>   	struct ath11k *ar = hw->priv;
>   	struct ath11k_vif *arvif = (void *)vif->drv_priv;
> -	struct scan_req_params arg;
> +	struct scan_req_params *arg;
>   	int ret;
>   	u32 scan_time_msec;
>   
> @@ -8937,27 +8937,31 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
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
>   		ret = -ENOMEM;
>   		goto exit;
>   	}
> +	ath11k_wmi_start_scan_init(ar, arg);
> +	arg->num_chan = 1;
> +	arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
> +				 GFP_KERNEL);
> +	if (!arg->chan_list) {
> +		ret = -ENOMEM;
> +		goto free_arg;
> +	}
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
> @@ -8983,7 +8987,9 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>   	ret = 0;
>   
>   free_chan_list:
> -	kfree(arg.chan_list);
> +	kfree(arg->chan_list);
> +free_arg:
> +	kfree(arg);
>   exit:
>   	mutex_unlock(&ar->conf_mutex);
>   	return ret;

