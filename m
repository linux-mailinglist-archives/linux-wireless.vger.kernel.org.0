Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0610159638F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiHPUOE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiHPUOC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 16:14:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C7B48CA8
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 13:14:01 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GH7cb7028902;
        Tue, 16 Aug 2022 20:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8P0soDbJ1oOjlkfNXwBRd7XDxxptQKqyFMf5Zy4fKTA=;
 b=LRCG5HPV77uZt2DE3VEEmUWI5cCcFpmFmknPF9WascW8souOhoOYaIJ+hPFkt/LMUKQD
 WcrBchcznxa/qMQd/qNgW7OlkQCBLDwj+tyN8fbM3zIOQRiRp9QRGKVXNHwCEmeO2Ocv
 qOFY45zpViAL54907i53rB2WESoPQmi7aaWIFBtgbyLPK3f6gSSyIPbSvG7WBaeyK3ou
 +tHiLjvyVywRXG8Zw5a/ILgbjGGxMUGxnNs5c0+zkhsB7nj+xULMcoFR6qCmt8vUHXhw
 BSnEO0D0vnvKfShTgemCzsvWduDXwisT9yLK3Wv7RAPLIkzv5zkIm6vSdQ6ISsIggt6+ Bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j08un22kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 20:13:48 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27GKDl9b012804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 20:13:47 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 16 Aug 2022 13:13:47 -0700
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 13:13:47 -0700
Message-ID: <e4c2c436-82e2-bf15-a635-e8f4e566d8d2@quicinc.com>
Date:   Tue, 16 Aug 2022 13:13:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 13/50] wifi: ath12k: add dp_mon.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-14-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-14-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: csbTEcF5SYzLZQP7OcvtV-9CuiPgyHbN
X-Proofpoint-GUID: csbTEcF5SYzLZQP7OcvtV-9CuiPgyHbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=990 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/12/2022 9:09 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> (Patches split into one patch per file for easier review, but the final
> commit will be one big patch. See the cover letter for more info.)
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 2598 ++++++++++++++++++++++++++++++
>   1 file changed, 2598 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> new file mode 100644
> index 000000000000..479be0e441d8
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -0,0 +1,2598 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "dp_mon.h"
> +#include "debug.h"
> +#include "dp_rx.h"
> +#include "dp_tx.h"
> +#include "peer.h"
> +
> +static void ath12k_dp_mon_rx_handle_ofdma_info(void *rx_tlv,
> +					       struct hal_rx_user_status *rx_user_status)
> +{
> +	struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
> +				(struct hal_rx_ppdu_end_user_stats *)rx_tlv;
> +
> +	rx_user_status->ul_ofdma_user_v0_word0 = __le32_to_cpu(ppdu_end_user->info6);
> +	rx_user_status->ul_ofdma_user_v0_word1 = __le32_to_cpu(ppdu_end_user->rsvd2[10]);

this violates the convention that info* is used for fields that are 
accessed while rsvd* is used for fields that are not accessed. in 
addition, use of magic number offsets is also not nice.

imo what would improve this code is to have accessor macros/inline 
functions defined co-resident with the struct so that all the magic 
numbers and magic fields are contained within the acessors, and the 
actual code here looks really readable.
