Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C407860EC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 21:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbjHWTpc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbjHWTpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 15:45:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184AE57
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 12:45:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NIYf4t020118;
        Wed, 23 Aug 2023 19:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eUZb1aknFmMOtsFYwxRic9f1vtjnmWehMd1EvYS3ods=;
 b=WzAcQ1ha5c0Z9BFv/ZaCfA/Z1r+E0ryRKqOSZ+wxMydiNojtFoL4LsV09/EaLZKLIfVN
 cL/KweGn7e6RGfAKeBqWd4yRBURzKqYvIFQEL0iUQFonrIOjGPG8hSEME+jd0JB+D+ig
 hdZC4gzYIafw9kD9N3GF4lJuw9pgv3upzYG0hTAfgDfyFz5afpz4R2h121y/9YEOYsYG
 5aaUg23ME5gCJqJsFGb6pkXymnM/dE1Rwtli+EGYjxnjR37RpEBorcmg8a/MNFUc/w/Y
 te08bvXOnvj6z3wiNP38hkRJaOst9XLdt7jVMTM1Q5UtcpX885efn6ZSYw8fHj+La3dj Pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snqg3g59d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 19:45:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NJj4TR015519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 19:45:04 GMT
Received: from [10.48.244.52] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 12:45:03 -0700
Message-ID: <8e7e8299-c9a2-48ff-ac31-830665827798@quicinc.com>
Date:   Wed, 23 Aug 2023 12:45:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath9k: use u32 for txgain indexes
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <574813ed-b9aa-458f-9758-29662eb60689@quicinc.com>
 <20230823182401.196270-1-dmantipov@yandex.ru>
 <20230823182401.196270-2-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230823182401.196270-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P0l5yOJhMrRCy6OJvM82qJe_WsJj7OMC
X-Proofpoint-GUID: P0l5yOJhMrRCy6OJvM82qJe_WsJj7OMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_14,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxlogscore=741 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/23/2023 11:23 AM, Dmitry Antipov wrote:
> Since both 'ar9550_hw_get_modes_txgain_index()' and
> 'ar9561_hw_get_modes_txgain_index()' never returns
> negative values, prefer 'u32' over 'int' and adjust
> 'ar9003_hw_process_ini()' accordingly.
> 
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath9k/ar9003_phy.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
> index 4731e6618209..6274d1624261 100644
> --- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
> +++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
> @@ -766,10 +766,10 @@ static void ar9003_hw_prog_ini(struct ath_hw *ah,
>   	}
>   }
>   
> -static int ar9550_hw_get_modes_txgain_index(struct ath_hw *ah,
> +static u32 ar9550_hw_get_modes_txgain_index(struct ath_hw *ah,
>   					    struct ath9k_channel *chan)
>   {
> -	int ret;
> +	u32 ret;
>   
>   	if (IS_CHAN_2GHZ(chan)) {
>   		if (IS_CHAN_HT40(chan))
> @@ -791,7 +791,7 @@ static int ar9550_hw_get_modes_txgain_index(struct ath_hw *ah,
>   	return ret;
>   }
>   
> -static int ar9561_hw_get_modes_txgain_index(struct ath_hw *ah,
> +static u32 ar9561_hw_get_modes_txgain_index(struct ath_hw *ah,
>   					    struct ath9k_channel *chan)
>   {
>   	if (IS_CHAN_2GHZ(chan)) {
> @@ -916,7 +916,7 @@ static int ar9003_hw_process_ini(struct ath_hw *ah,
>   	 * TXGAIN initvals.
>   	 */
>   	if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
> -		int modes_txgain_index = 1;
> +		u32 modes_txgain_index = 1;
>   
>   		if (AR_SREV_9550(ah))
>   			modes_txgain_index = ar9550_hw_get_modes_txgain_index(ah, chan);

