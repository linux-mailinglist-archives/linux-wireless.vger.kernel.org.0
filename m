Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED8594705
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 01:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353021AbiHOXJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 19:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353286AbiHOXHo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 19:07:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E686A1436E5
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 12:59:41 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FJwTxb023789;
        Mon, 15 Aug 2022 19:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jCf5+ykmd9Sl81VVChFnagKK7rRMh/xZzl0L6rKABPc=;
 b=U62yOcasTI/7N5ggqAGD3+ZT00T5AvgGOgmBz0x1nLPM6P1ClJzRVjRy+NOiV7BcCKwU
 vAOisvGgzVqzx4WO2aPuzhTcSceNz80OP3ploe7FJip5BCbeNb4At7j1cbfyHizWOE6R
 4PTND9b5UULryzNh4FfG+/YNM1XHiIXpUVeZwd490hCfWHc2uJHgiWHSFA35Nw4SYo+v
 ZPZEZlpWR69Nss+rObyMB9bOR860/IViUUt7zNYDrJLYUOLT2ScN2gKQ1HUQAYIbDQHA
 Ih+gJuBxTxRUba1tP1tkO7MGiQfC96TQoqR04oKtXkg+vDKePp30YwSQdsX0GrA0OYbj rw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx1auejsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:59:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FJxWCj027441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:59:32 GMT
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 15 Aug
 2022 12:59:31 -0700
Message-ID: <3f8edc37-6be7-efe5-ac02-2d068f428277@quicinc.com>
Date:   Mon, 15 Aug 2022 12:59:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 08/50] wifi: ath12k: add dbring.h
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-9-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-9-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xcGydD4NK9sa6qXsGDGQ2cEQebhB401Y
X-Proofpoint-ORIG-GUID: xcGydD4NK9sa6qXsGDGQ2cEQebhB401Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=771 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150076
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
>   drivers/net/wireless/ath/ath12k/dbring.h | 80 ++++++++++++++++++++++++++++++++
>   1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dbring.h b/drivers/net/wireless/ath/ath12k/dbring.h
> new file mode 100644
> index 000000000000..2be2d8def3f0
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/dbring.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
> +/*
> + * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef ATH12K_DBRING_H
> +#define ATH12K_DBRING_H
> +
> +#include <linux/types.h>
> +#include <linux/idr.h>
> +#include <linux/spinlock.h>
> +#include "dp.h"
> +
> +struct ath12k_dbring_element {
> +	dma_addr_t paddr;
> +	u8 payload[0];

should just be payload[]

<https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays>

