Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB446FDB4A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 12:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjEJKFr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 06:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbjEJKFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 06:05:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF626A6E
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 03:05:40 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A9DPZm005408;
        Wed, 10 May 2023 10:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kv8MWVu60Lknq1EU2YKGBd4G7B8gOFMpvJZU5/lJV4o=;
 b=TJZz4oaV2n1q90GsewZYQ1dafPF5bOWeTbmLla3kfmtp0PFI7t2Fesyq78C/x390exqD
 IJd5gOlVFV5xKVqxsh3Mh9SS2ha/N8TrTR3T8gpYbwj/mqg8s6lEMF1XRn7WhGu6Olyb
 O1OFhXiFngiOmaw1j5atjjOnMy3uv3dFYa4HTi5gBU3tCayZXa6xWa7Gi1sY2ad6xKfv
 vbS2TgV8U45U11ckwWwkilb1CQmF1clfbVkvW52lGugeqPDN5C6F5F80jqst2B3j0ocG
 Ez/QxXiBwTLFJfQHYGtMC95AR6zDRrmFXkpxC2s6aarwOl2deJTQeCovcgArP+RRCmyu jA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfuna1e0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:05:35 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AA5Y5Y028253
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:05:34 GMT
Received: from [10.201.192.62] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 10 May
 2023 03:05:33 -0700
Message-ID: <a409ded2-f6e5-bc74-3fdb-231a92d9bde5@quicinc.com>
Date:   Wed, 10 May 2023 15:35:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] ath11k: Relocate the func
 ath11k_mac_bitrate_mask_num_ht_rates() and change hweight16 to hweight8
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230504092033.3542456-2-quic_mkenna@quicinc.com>
Content-Language: en-US
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <20230504092033.3542456-2-quic_mkenna@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4cbLziBOcoqGqutvn0aq68RFU3oV7RCJ
X-Proofpoint-GUID: 4cbLziBOcoqGqutvn0aq68RFU3oV7RCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=666 mlxscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100079
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Ignore this patchset, I have sent the v2 version of this patchset by 
rebasing it on latest TOT.

> Relocate the function ath11k_mac_bitrate_mask_num_ht_rates() definition
> to call this function from other functions which helps to avoid the
> compilation error (function not defined).
>
> ht_mcs[] is 1 byte array and it is enough to use hweight8() instead
> of hweight16(). Hence, fixed the same.
>
> Tested on: Compile tested only.
>
> Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 30 +++++++++++++--------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 05920ad413c5..eb46d06272de 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>   /*
>    * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include <net/mac80211.h>
> @@ -4159,6 +4159,20 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>   	return ret;
>   }
>   
> +static int
> +ath11k_mac_bitrate_mask_num_ht_rates(struct ath11k *ar,
> +				     enum nl80211_band band,
> +				     const struct cfg80211_bitrate_mask *mask)
> +{
> +	int num_rates = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++)
> +		num_rates += hweight8(mask->control[band].ht_mcs[i]);
> +
> +	return num_rates;
> +}
> +
>   static int
>   ath11k_mac_bitrate_mask_num_vht_rates(struct ath11k *ar,
>   				      enum nl80211_band band,
> @@ -7542,20 +7556,6 @@ static void ath11k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
>   	ath11k_mac_flush_tx_complete(ar);
>   }
>   
> -static int
> -ath11k_mac_bitrate_mask_num_ht_rates(struct ath11k *ar,
> -				     enum nl80211_band band,
> -				     const struct cfg80211_bitrate_mask *mask)
> -{
> -	int num_rates = 0;
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++)
> -		num_rates += hweight16(mask->control[band].ht_mcs[i]);
> -
> -	return num_rates;
> -}
> -
>   static bool
>   ath11k_mac_has_single_legacy_rate(struct ath11k *ar,
>   				  enum nl80211_band band,
