Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AAE787436
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 17:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbjHXPaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbjHXPaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 11:30:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E119BC
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 08:30:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEWkv1006960;
        Thu, 24 Aug 2023 15:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=v1ftzoKOgQHzAHqnOzcWmrhBWZ3pDMZ0yLpmUn8k44w=;
 b=lH5WrAtMHCaHqnD2C2HKbTkBgMeAknaZNfu07+axeIO2GaVVif64TDXA+iVYSkwugN9V
 a1xxYf4wfOjlqgzaouJdx301pEldQMIGCcwyBxBxAk3skFg5nGfv2Axqhz23wWEntrIB
 QBl1b2SPQGwHQQMu6vMoIMX+WpjxFrHGpNT2kSfm0GobPYP1M5y9HkL4kDrJ2nEPWqW8
 JirlEIhW2hUOqmnpPI8tnQchIE20yVot6VMZb4iC9RqgvlyBPprNlOuZeldFoIv/3d2L
 SLu9RS0PYvXuWxnaviU9XefBxrNIgMa3JemwXWhA2MsZFAVY9tADcmSd5rG0uwVThP3f Tw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sp1k9hf6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:30:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OFU8M7025989
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:30:08 GMT
Received: from [10.48.247.99] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 08:30:08 -0700
Message-ID: <3aded344-1ba0-405d-9541-aefc293f4ba2@quicinc.com>
Date:   Thu, 24 Aug 2023 08:30:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] wifi: ath11k: drop redundant check in
 ath11k_dp_rx_mon_dest_process()
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, Tom Rix <trix@redhat.com>,
        <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>,
        <ath11k@lists.infradead.org>
References: <20230824075121.121144-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230824075121.121144-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1E6o_mfAXAnz5nO1IR0D_vRrdXeLpQEu
X-Proofpoint-ORIG-GUID: 1E6o_mfAXAnz5nO1IR0D_vRrdXeLpQEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=420
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308240130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/24/2023 12:50 AM, Dmitry Antipov wrote:
> In 'ath11k_dp_rx_mon_dest_process()', 'mon_dst_srng' points to
> a member of 'srng_list', which is a fixed-size array inside
> 'struct ath11k_hal'. This way, if 'ring_id' is valid (i. e.
> between 0 and HAL_SRNG_RING_ID_MAX - 1 inclusive), 'mon_dst_srng'
> can't be NULL and so relevant check may be dropped.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath11k/dp_rx.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 1e488eed282b..3f315547878a 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -5097,13 +5097,6 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
>   
>   	mon_dst_srng = &ar->ab->hal.srng_list[ring_id];
>   
> -	if (!mon_dst_srng) {
> -		ath11k_warn(ar->ab,
> -			    "HAL Monitor Destination Ring Init Failed -- %p",
> -			    mon_dst_srng);
> -		return;
> -	}
> -
>   	spin_lock_bh(&pmon->mon_lock);
>   
>   	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);

