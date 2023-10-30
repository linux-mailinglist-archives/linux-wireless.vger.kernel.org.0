Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323E17DBC80
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 16:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjJ3PVW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3PVV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 11:21:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19123CC
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 08:21:19 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UETcKd029305;
        Mon, 30 Oct 2023 15:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=H3eZE4DZn65NWeuqSCuidbpplsFRTL7jQx5TLve6sd0=;
 b=bUDEvItxVr4kVZiqmdKHCK5A8sf6B4rcrpdScQNenrJsoS9hkJJaKG+HLzDAUzatLcC4
 gp45p8i4sVAp8DFpk5bbQ1Y8oHhhEq6Tpi39tC7mLnn3OtlhbwHgIb9o1A6/HoIDpMXj
 m4ibq2uuQIyxZXsn3j5SsSAI9p5zN6wLi0ShNXnqkSG25aiRlgvEibUyP9B7pC0vaJbs
 px3NlHn2VSBlrB+6pZjohSmTf+SzgaBTHj38d0lyc+yK7j5eot323/iMgmo58hxBhC7h
 ZxtucN54TN9uJ6xgER6dpG8lkMc/atjm7xYAOUceiVSM9zj7TnIUw24Y09rX+334+WR0 tg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0smrm8vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 15:21:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UFKscb005844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 15:20:54 GMT
Received: from [10.48.245.206] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 08:20:54 -0700
Message-ID: <ed73e278-82cc-4805-b096-ed358657e5ec@quicinc.com>
Date:   Mon, 30 Oct 2023 08:20:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: ath: create common testmode_i.h file for ath
 drivers
Content-Language: en-US
To:     Aaradhana Sahu <quic_aarasahu@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231030082749.17855-1-quic_aarasahu@quicinc.com>
 <20231030082749.17855-2-quic_aarasahu@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231030082749.17855-2-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LYpGdui-RLEqT4_8lC7F0433IrI3i6Ma
X-Proofpoint-GUID: LYpGdui-RLEqT4_8lC7F0433IrI3i6Ma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=984 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/2023 1:27 AM, Aaradhana Sahu wrote:
> User space application requires that the testmode interface
> is exactly same between ath drivers. Move testmode_i.h file
> in ath directory to ensure that all ath driver uses same testmode
> interface instead of duplicating testmode_i.h for each ath drivers.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/testmode.c    | 78 +++++++++----------
>   .../wireless/ath/{ath11k => }/testmode_i.h    | 52 ++++++-------
>   2 files changed, 65 insertions(+), 65 deletions(-)
>   rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (53%)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
> index 43bb23265d34..5da5e53f3eac 100644
> --- a/drivers/net/wireless/ath/ath11k/testmode.c
> +++ b/drivers/net/wireless/ath/ath11k/testmode.c
> @@ -10,18 +10,18 @@
>   #include "wmi.h"
>   #include "hw.h"
>   #include "core.h"
> -#include "testmode_i.h"
> +#include "../testmode_i.h"
>   
>   #define ATH11K_FTM_SEGHDR_CURRENT_SEQ		GENMASK(3, 0)
>   #define ATH11K_FTM_SEGHDR_TOTAL_SEGMENTS	GENMASK(7, 4)
>   
> -static const struct nla_policy ath11k_tm_policy[ATH11K_TM_ATTR_MAX + 1] = {
> -	[ATH11K_TM_ATTR_CMD]		= { .type = NLA_U32 },
> -	[ATH11K_TM_ATTR_DATA]		= { .type = NLA_BINARY,
> -					    .len = ATH11K_TM_DATA_MAX_LEN },
> -	[ATH11K_TM_ATTR_WMI_CMDID]	= { .type = NLA_U32 },
> -	[ATH11K_TM_ATTR_VERSION_MAJOR]	= { .type = NLA_U32 },
> -	[ATH11K_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
> +static const struct nla_policy ath11k_tm_policy[ATH_TM_ATTR_MAX + 1] = {
> +	[ATH_TM_ATTR_CMD]		= { .type = NLA_U32 },
> +	[ATH_TM_ATTR_DATA]		= { .type = NLA_BINARY,
> +					    .len = ATH_TM_DATA_MAX_LEN },
> +	[ATH_TM_ATTR_WMI_CMDID]	= { .type = NLA_U32 },

maintain vertical alignment of "="

> +	[ATH_TM_ATTR_VERSION_MAJOR]	= { .type = NLA_U32 },
> +	[ATH_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
>   };

