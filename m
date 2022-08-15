Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B515C59497D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 02:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbiHOXmd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 19:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354277AbiHOXlr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 19:41:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC824B851
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 13:11:32 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FK0RUI022703;
        Mon, 15 Aug 2022 20:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ye/c2j+Lcw+pD3nz6aQcjnoq7Nrtk5FvvV6MaC+Bh2Q=;
 b=j29BPz6wFfSDPRmhtuePC/nIPfrkQ83RBU8ZE1604L3GuzHdV+cCdkZIks6Nu9d4dTd7
 6y6OF4BkJoIaGf6FHVTUcQkDS/R9LifbEgZ76LPGXSx0oeZYSFGoEikwY0h9hou1OXNj
 8v+Gml6rbCkj9ZT9yLuGxtuherXozIN0rcFRfY+uhXP+8kRa8as6aaNngEoJuW9JIPyO
 O/UKhbghbTuu2tUlrVrLT+SnLMWlzPYGPAYTrvSK5LCWkPRXuaSGX+kgCv8R2EE3GEt3
 JVl0uE0O8Fsos+m3yVi/VJOEgD0wg2nkZmY5/1tw+9XXhVc/5KW5wOJD17erZPGlrB11 Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx467ed5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 20:11:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FKBNdf022874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 20:11:23 GMT
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 15 Aug
 2022 13:11:22 -0700
Message-ID: <8b456221-07aa-2620-784f-ae44ed2aa431@quicinc.com>
Date:   Mon, 15 Aug 2022 13:11:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 10/50] wifi: ath12k: add debug.h
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-11-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-11-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NZ2X94CPghaLOYk647l9jupgp865L1kp
X-Proofpoint-GUID: NZ2X94CPghaLOYk647l9jupgp865L1kp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
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
>   drivers/net/wireless/ath/ath12k/debug.h | 68 +++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
> new file mode 100644
> index 000000000000..ec2be467edbc
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/debug.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: BSD-3-Clause-Clear */
> +/*
> + * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _ATH12K_DEBUG_H_
> +#define _ATH12K_DEBUG_H_
> +
> +#include "trace.h"
> +
> +enum ath12k_debug_mask {
> +	ATH12K_DBG_AHB		= 0x00000001,
> +	ATH12K_DBG_WMI		= 0x00000002,
> +	ATH12K_DBG_HTC		= 0x00000004,
> +	ATH12K_DBG_DP_HTT	= 0x00000008,
> +	ATH12K_DBG_MAC		= 0x00000010,
> +	ATH12K_DBG_BOOT		= 0x00000020,
> +	ATH12K_DBG_QMI		= 0x00000040,
> +	ATH12K_DBG_DATA		= 0x00000080,
> +	ATH12K_DBG_MGMT		= 0x00000100,
> +	ATH12K_DBG_REG		= 0x00000200,
> +	ATH12K_DBG_TESTMODE	= 0x00000400,
> +	ATH12K_DBG_HAL		= 0x00000800,
> +	ATH12K_DBG_PCI		= 0x00001000,
> +	ATH12K_DBG_DP_TX	= 0x00001000,

duplicate assignments above

would using BIT() help here?
or does having the hex masks make it easier for folks generating the masks

> +	ATH12K_DBG_DP_RX	= 0x00002000,
> +	ATH12K_DBG_ANY		= 0xffffffff,
> +};
> +
> +__printf(2, 3) void ath12k_info(struct ath12k_base *ab, const char *fmt, ...);
> +__printf(2, 3) void ath12k_err(struct ath12k_base *ab, const char *fmt, ...);
> +__printf(2, 3) void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...);
> +
> +extern unsigned int ath12k_debug_mask;
> +
> +#ifdef CONFIG_ATH12K_DEBUG
> +__printf(3, 4) void __ath12k_dbg(struct ath12k_base *ab,
> +				 enum ath12k_debug_mask mask,
> +				 const char *fmt, ...);
> +void ath12k_dbg_dump(struct ath12k_base *ab,
> +		     enum ath12k_debug_mask mask,
> +		     const char *msg, const char *prefix,
> +		     const void *buf, size_t len);
> +#else /* CONFIG_ATH12K_DEBUG */
> +static inline int __ath12k_dbg(struct ath12k_base *ab,

should be a void function with an empty body to match the signature of 
the real function

> +			       enum ath12k_debug_mask dbg_mask,
> +			       const char *fmt, ...)
> +{
> +	return 0;
> +}
> +
> +static inline void ath12k_dbg_dump(struct ath12k_base *ab,
> +				   enum ath12k_debug_mask mask,
> +				   const char *msg, const char *prefix,
> +				   const void *buf, size_t len)
> +{
> +}
> +#endif /* CONFIG_ATH12K_DEBUG */
> +
> +#define ath12k_dbg(ar, dbg_mask, fmt, ...)			\
> +do {								\
> +	typeof(dbg_mask) mask = (dbg_mask);			\
> +	if (ath12k_debug_mask & mask)				\
> +		__ath12k_dbg(ar, mask, fmt, ##__VA_ARGS__);	\
> +} while (0)
> +
> +#endif /* _ATH12K_DEBUG_H_ */
> 

