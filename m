Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE557797482
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjIGPjT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjIGPWh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823BA199A
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 08:22:09 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387DGftb004404;
        Thu, 7 Sep 2023 14:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uNekWqbroiT3eusW/jNl1HsuJO2UwOq39m0u9BjMw9o=;
 b=bveoZhUuDDXC/WFCDgL0VZPIEL1DGvHWRzZpIp0NMKQ6BxmKIr6wHk0qwZbjFkDQMyrq
 sAH0LD4+yE3x5Q+QAplswU4ZUSJnOMa07y2JNA2Cu8Pvj+gyZCNizAll6hC5uCJUoxbO
 yZzgnXYAYa5Cin9pK+JPuIp/VipQckTIMXZXQSIC9SqtWS4A813IHQimpdW0mWFvmZ63
 JMiEJkYOvBaLlVHkznBbtiseQH6Qg7lZBZUdFeQ2tK0z2REX9tCFv1RgVpRJSs/Oo4VM
 G8CHbMJIUT+1LgMTX0hDjgsL66e5JppwN4QuVGh7A9WNVO1pq+M5lURMDKJ+sHOZVtBp ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy4s7sgp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 14:52:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 387EqQ7x028647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 14:52:26 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 07:52:25 -0700
Message-ID: <4c0c9068-0982-4b05-9c11-1aa5913a9c8c@quicinc.com>
Date:   Thu, 7 Sep 2023 07:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: drop NULL pointer check in
 ath11k_dp_rx_mon_dest_process()
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>, <ath11k@lists.infradead.org>
References: <20230907083852.10775-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230907083852.10775-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F6BDw0kUruSFLFV7ZEWUTnqCYT_BTGsB
X-Proofpoint-ORIG-GUID: F6BDw0kUruSFLFV7ZEWUTnqCYT_BTGsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxlogscore=605 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309070132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/7/2023 1:38 AM, Dmitry Antipov wrote:
> Since 'srng_list' is a fixed-size array of 'struct hal_srng'
> in 'struct ath11_hal', any of its member can't be NULL and
> so relevant check may be dropped.
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
> index 146201d8dba2..4463e308968c 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -5094,13 +5094,6 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
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

