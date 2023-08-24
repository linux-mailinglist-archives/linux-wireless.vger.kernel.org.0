Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AEF787428
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 17:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbjHXP1L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbjHXP04 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 11:26:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0C81BC6
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 08:26:53 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEZIS5001500;
        Thu, 24 Aug 2023 15:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yEbqS9zhCPZYpnokmS+VjXXWNaPRQ0bmPoV5SyFrWdM=;
 b=n2TJh8UhrGpS0ZkUn5oJ+AS4T/K5d+rP5dB51GIhXH0iMjgsFQGPljq8z2Ow6wsRAolb
 oNqjAUTQqfbykhWDxPTefYE9rnbvxzK2DFKcoMREasdRh3eZ0n3GGpn1B0dG1FRypqcG
 ps1+c2wKvF/7ZfrzkIfU4Y8f54GJzi8WQbUp07NXI97n8fo0wCnn3rg5x2gnYec5dk06
 hEMiiCaSndphNSvGextrBZLVAJCsNU+uqP7Ro1KUjF2jkMiLW/7RdWgdbpwMOYpYEa11
 EA3O1BwN/8jA6he7OFuxNwqvrsQ63U3qqqa//x/kal6hwf3FjZ4nG8bqITeImSvrOZ2a wA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sp1r3sb08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:26:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OFQbYV025748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:26:37 GMT
Received: from [10.48.247.99] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 08:26:36 -0700
Message-ID: <11ee12c9-e851-4afe-b80e-15e9e46a51d0@quicinc.com>
Date:   Thu, 24 Aug 2023 08:26:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] [v3] wifi: ath10k: cleanup CE ring initialization
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>, <ath10k@lists.infradead.org>
References: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
 <20230824055117.42309-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230824055117.42309-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nRwpgeUVGEwupxiHOAkMAhhfDKSTMsNo
X-Proofpoint-GUID: nRwpgeUVGEwupxiHOAkMAhhfDKSTMsNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
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
> Commit 25d0dbcbd5c7 ("ath10k: split ce initialization and allocation")
> changes 'ath10k_ce_init_src_ring()' and 'ath10k_ce_init_dest_ring()'
> so these functions can't return -ENOMEM but always returns 0. This way
> both of them may be converted to 'void', and 'ath10k_ce_init_pipe()'
> may be simplified accordingly.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
> v3: split to smaller units per Jeff's suggestion
> v2: change 'ath10k_ce_alloc_rri()' to return -ENOMEM in case
> of 'dma_alloc_coherent()' failure and fix error handling in
> 'ath10k_snoc_hif_power_up()'
> ---
>   drivers/net/wireless/ath/ath10k/ce.c | 38 ++++++++--------------------
>   1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
> index c27b8204718a..ace92c636733 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.c
> +++ b/drivers/net/wireless/ath/ath10k/ce.c
> @@ -1352,9 +1352,9 @@ void ath10k_ce_enable_interrupts(struct ath10k *ar)
>   }
>   EXPORT_SYMBOL(ath10k_ce_enable_interrupts);
>   
> -static int ath10k_ce_init_src_ring(struct ath10k *ar,
> -				   unsigned int ce_id,
> -				   const struct ce_attr *attr)
> +static void ath10k_ce_init_src_ring(struct ath10k *ar,
> +				    unsigned int ce_id,
> +				    const struct ce_attr *attr)
>   {
>   	struct ath10k_ce *ce = ath10k_ce_priv(ar);
>   	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
> @@ -1389,13 +1389,11 @@ static int ath10k_ce_init_src_ring(struct ath10k *ar,
>   	ath10k_dbg(ar, ATH10K_DBG_BOOT,
>   		   "boot init ce src ring id %d entries %d base_addr %pK\n",
>   		   ce_id, nentries, src_ring->base_addr_owner_space);
> -
> -	return 0;
>   }
>   
> -static int ath10k_ce_init_dest_ring(struct ath10k *ar,
> -				    unsigned int ce_id,
> -				    const struct ce_attr *attr)
> +static void ath10k_ce_init_dest_ring(struct ath10k *ar,
> +				     unsigned int ce_id,
> +				     const struct ce_attr *attr)
>   {
>   	struct ath10k_ce *ce = ath10k_ce_priv(ar);
>   	struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
> @@ -1427,8 +1425,6 @@ static int ath10k_ce_init_dest_ring(struct ath10k *ar,
>   	ath10k_dbg(ar, ATH10K_DBG_BOOT,
>   		   "boot ce dest ring id %d entries %d base_addr %pK\n",
>   		   ce_id, nentries, dest_ring->base_addr_owner_space);
> -
> -	return 0;
>   }
>   
>   static int ath10k_ce_alloc_shadow_base(struct ath10k *ar,
> @@ -1662,25 +1658,11 @@ ath10k_ce_alloc_dest_ring_64(struct ath10k *ar, unsigned int ce_id,
>   int ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
>   			const struct ce_attr *attr)
>   {
> -	int ret;
> -
> -	if (attr->src_nentries) {
> -		ret = ath10k_ce_init_src_ring(ar, ce_id, attr);
> -		if (ret) {
> -			ath10k_err(ar, "Failed to initialize CE src ring for ID: %d (%d)\n",
> -				   ce_id, ret);
> -			return ret;
> -		}
> -	}
> +	if (attr->src_nentries)
> +		ath10k_ce_init_src_ring(ar, ce_id, attr);
>   
> -	if (attr->dest_nentries) {
> -		ret = ath10k_ce_init_dest_ring(ar, ce_id, attr);
> -		if (ret) {
> -			ath10k_err(ar, "Failed to initialize CE dest ring for ID: %d (%d)\n",
> -				   ce_id, ret);
> -			return ret;
> -		}
> -	}
> +	if (attr->dest_nentries)
> +		ath10k_ce_init_dest_ring(ar, ce_id, attr);
>   
>   	return 0;
>   }

