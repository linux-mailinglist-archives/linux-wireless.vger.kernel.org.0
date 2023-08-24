Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6991C78742D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242055AbjHXP1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbjHXP1i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 11:27:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572071AD
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 08:27:36 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEX4ap032377;
        Thu, 24 Aug 2023 15:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Zr7FFBFt27CYrMs9F5nVWLO87GbjyWyuhtIAWCBvG80=;
 b=b8H2QilDJtgDhlb2TUhWADeaDyT+acggJZVBwXb3KnIfV64hM5YOXVZsWEYaV1uhicpS
 IFu2mdB9+BFbq4gB0F0Kay3LCPqAi0y8UfPltfnvPc0M2bTJ2dM4bk6x9HvAIwUI7Ofi
 NJN97aas7a7rivoCgh18+FBdch3LVLzyKA3pkBrNpXraeEvqyL2PsIS+1nQfbDSwvHae
 mB/3TN/FbA5E4NonEpRpGuekkrTnzs7H/UzkKU8odXV47FzFHSLbObYbDS98AycQLwfA
 9JsraK/0tfb0XG+6+xrQLLqrlAYxDRHvoSYaQmkO3gMfAlcYAAtSYgeXg+pO/StexE7T sw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sp4sbryn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:27:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OFRTNU026573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:27:29 GMT
Received: from [10.48.247.99] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 08:27:29 -0700
Message-ID: <0e901fad-97ae-46ea-bebb-d1d5a557e8ae@quicinc.com>
Date:   Thu, 24 Aug 2023 08:27:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] [v3] wifi: ath10k: do not ignore possible
 dma_alloc_coherent() error
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>, <ath10k@lists.infradead.org>
References: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
 <20230824055117.42309-1-dmantipov@yandex.ru>
 <20230824055117.42309-4-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230824055117.42309-4-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JE-nww3xbZCoiw6ap1qy-EzYZazHn05Z
X-Proofpoint-GUID: JE-nww3xbZCoiw6ap1qy-EzYZazHn05Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=859 impostorscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/23/2023 10:51 PM, Dmitry Antipov wrote:
> Change 'ath10k_ce_alloc_rri()' to return -ENOMEM in case
> of 'dma_alloc_coherent()' failure and fix error handling in
> 'ath10k_snoc_hif_power_up()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
> v3: split from the larger v2 patch
> ---
>   drivers/net/wireless/ath/ath10k/ce.c   | 6 ++++--
>   drivers/net/wireless/ath/ath10k/ce.h   | 2 +-
>   drivers/net/wireless/ath/ath10k/snoc.c | 9 ++++++++-
>   3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
> index 73aa3632b23c..d7275dcc1f99 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.c
> +++ b/drivers/net/wireless/ath/ath10k/ce.c
> @@ -1906,7 +1906,7 @@ int ath10k_ce_alloc_pipe(struct ath10k *ar, int ce_id,
>   }
>   EXPORT_SYMBOL(ath10k_ce_alloc_pipe);
>   
> -void ath10k_ce_alloc_rri(struct ath10k *ar)
> +int ath10k_ce_alloc_rri(struct ath10k *ar)
>   {
>   	int i;
>   	u32 value;
> @@ -1919,7 +1919,7 @@ void ath10k_ce_alloc_rri(struct ath10k *ar)
>   					   &ce->paddr_rri, GFP_KERNEL);
>   
>   	if (!ce->vaddr_rri)
> -		return;
> +		return -ENOMEM;
>   
>   	ath10k_ce_write32(ar, ar->hw_ce_regs->ce_rri_low,
>   			  lower_32_bits(ce->paddr_rri));
> @@ -1934,6 +1934,8 @@ void ath10k_ce_alloc_rri(struct ath10k *ar)
>   		value |= ar->hw_ce_regs->upd->mask;
>   		ath10k_ce_write32(ar, ce_base_addr + ctrl1_regs, value);
>   	}
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL(ath10k_ce_alloc_rri);
>   
> diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
> index a0b408176f7f..c90c00316356 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.h
> +++ b/drivers/net/wireless/ath/ath10k/ce.h
> @@ -262,7 +262,7 @@ void ath10k_ce_enable_interrupts(struct ath10k *ar);
>   void ath10k_ce_dump_registers(struct ath10k *ar,
>   			      struct ath10k_fw_crash_data *crash_data);
>   
> -void ath10k_ce_alloc_rri(struct ath10k *ar);
> +int ath10k_ce_alloc_rri(struct ath10k *ar);
>   void ath10k_ce_free_rri(struct ath10k *ar);
>   
>   /* ce_attr.flags values */
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 815df15f58fb..b3acb6ad6f45 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1074,10 +1074,17 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
>   		goto err_hw_power_off;
>   	}
>   
> -	ath10k_ce_alloc_rri(ar);
> +	ret = ath10k_ce_alloc_rri(ar);
> +	if (ret)
> +		goto err_snoc_wlan_disable;
>   
>   	ath10k_snoc_init_pipes(ar);
>   
> +	return 0;
> +
> +err_snoc_wlan_disable:
> +	ath10k_snoc_wlan_disable(ar);
> +
>   err_hw_power_off:
>   	ath10k_hw_power_off(ar);
>   

