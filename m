Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AAE7860EA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 21:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbjHWTpb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 15:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbjHWTpB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 15:45:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFD510CF
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 12:44:59 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NJgTRs016249;
        Wed, 23 Aug 2023 19:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=puU1+qRG8o7icK6YxZUTLO0XOiSjriCmILVklshbtes=;
 b=BY86/OKeWvQLX/Qz//zdr45YiHh3B5qhUVqWG0aGNN79A4hJoZgfI/bC2N9X5XaRuTVm
 juHXiV1GgC+9sg4M9r+3nqtR0vvIwOjuxuyS4YPubFC6EPDCGzgM/lxqOCni2dWblVy5
 RfdwcPc1PVP/UFnLOoQNjZzUp9ag1ad0z4YuKpVMHIuPvnkgoJyaQIbVjn5sxFC2dfKo
 4lV7Q4uVx21Hs9UVK/hoXpueNxyu9i0ZywV+aLjaRIv5pPhrOzktJZhaeDnsEJQJwBW+
 /t9wUwCccrnWbeyT5NBmlSwYC6zUJCGhVVmke7EmNk3l6vWYjvml9yk3xJpBIvoz6FLE 6w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn26sk2r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 19:44:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NJioAA002966
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 19:44:50 GMT
Received: from [10.48.244.52] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 12:44:49 -0700
Message-ID: <44301b29-9a2d-4fe6-b409-5bfde87d9156@quicinc.com>
Date:   Wed, 23 Aug 2023 12:44:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath9k: simplify ar9003_hw_process_ini()
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>
References: <574813ed-b9aa-458f-9758-29662eb60689@quicinc.com>
 <20230823182401.196270-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230823182401.196270-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IoakS_np_cE5wowE9fi05B20alI1gHSQ
X-Proofpoint-GUID: IoakS_np_cE5wowE9fi05B20alI1gHSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_14,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=521 classifier=spam adjust=0 reason=mlx scancount=1
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
> Since commit 8896934c1684 ("ath9k_hw: remove direct accesses to channel
> mode flags") changes 'ar9550_hw_get_modes_txgain_index()' so it never
> returns -EINVAL, and 'ar9561_hw_get_modes_txgain_index()' never returns
> negative value too, an extra check in 'ar9003_hw_process_ini()' may be
> dropped.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath9k/ar9003_phy.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
> index a29c11f944a5..4731e6618209 100644
> --- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
> +++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
> @@ -925,9 +925,6 @@ static int ar9003_hw_process_ini(struct ath_hw *ah,
>   			modes_txgain_index =
>   				ar9561_hw_get_modes_txgain_index(ah, chan);
>   
> -		if (modes_txgain_index < 0)
> -			return -EINVAL;
> -
>   		REG_WRITE_ARRAY(&ah->iniModesTxGain, modes_txgain_index,
>   				regWrites);
>   	} else {

