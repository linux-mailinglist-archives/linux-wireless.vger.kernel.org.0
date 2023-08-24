Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1278742C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbjHXP1n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 11:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbjHXP1Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 11:27:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008A819B4
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 08:27:13 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OEX5uc007723;
        Thu, 24 Aug 2023 15:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eyA4eN0Q0H69qRDof+3i/mx0vO/f4DS+CmYVRvV7L/g=;
 b=ESYtREyx1vKZ2EBlGgM/RfgbdzromarEVJO3ZsDciawUNSOEFxIYigP9O+5dkkPnXsaf
 VDSJn47kZ/qVyQg1F4L3bI3k7AItF+v76JG6VdINFmiLLP5xCizRkIiFIwh7n7bolw/x
 WcCPjz93niKqFBMeYQSo9jgmNcYTRR0wd7dJHHFHOLrDnqLQd4lDzAMlRLR0xjNYM83B
 6Pu3C3POJljc+uo7elIy0pBtX2Rl1+cIYiwFlQhGNQxJWxznwVE7Pd+gcpoZeijUJS6n
 r8ktgzbR+fCWCOQJhlR4DwM0JmlX3azCN1RTp2mlHTsIxbT9L5blWs9b+avchhdDLcg4 LA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sp1k9hevh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:26:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37OFQstO023866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 15:26:54 GMT
Received: from [10.48.247.99] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 08:26:54 -0700
Message-ID: <29fe4dc9-eac9-42c5-aa50-699b9ba3b2fe@quicinc.com>
Date:   Thu, 24 Aug 2023 08:26:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] [v3] wifi: ath10k: simplify ath10k_ce_init_pipe()
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>, <ath10k@lists.infradead.org>
References: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
 <20230824055117.42309-1-dmantipov@yandex.ru>
 <20230824055117.42309-2-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230824055117.42309-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DRfxIe-T7xBBdtphzROMqMleAAACOx0e
X-Proofpoint-ORIG-GUID: DRfxIe-T7xBBdtphzROMqMleAAACOx0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_12,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308240129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/23/2023 10:51 PM, Dmitry Antipov wrote:
> Convert 'ath10k_ce_init_pipe()' to return 'void' and thus
> simplify 'ath10k_pci_init_pipes()' and 'ath10k_snoc_init_pipes()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
> v3: split from the larger v2 patch
> ---
>   drivers/net/wireless/ath/ath10k/ce.c   |  6 ++----
>   drivers/net/wireless/ath/ath10k/ce.h   |  4 ++--
>   drivers/net/wireless/ath/ath10k/pci.c  | 12 +++---------
>   drivers/net/wireless/ath/ath10k/snoc.c | 12 +++---------
>   4 files changed, 10 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
> index ace92c636733..73aa3632b23c 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.c
> +++ b/drivers/net/wireless/ath/ath10k/ce.c
> @@ -1655,16 +1655,14 @@ ath10k_ce_alloc_dest_ring_64(struct ath10k *ar, unsigned int ce_id,
>    * initialization. It may be that only one side or the other is
>    * initialized by software/firmware.
>    */
> -int ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
> -			const struct ce_attr *attr)
> +void ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
> +			 const struct ce_attr *attr)
>   {
>   	if (attr->src_nentries)
>   		ath10k_ce_init_src_ring(ar, ce_id, attr);
>   
>   	if (attr->dest_nentries)
>   		ath10k_ce_init_dest_ring(ar, ce_id, attr);
> -
> -	return 0;
>   }
>   EXPORT_SYMBOL(ath10k_ce_init_pipe);
>   
> diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
> index 666ce384a1d8..a0b408176f7f 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.h
> +++ b/drivers/net/wireless/ath/ath10k/ce.h
> @@ -220,8 +220,8 @@ int ath10k_ce_completed_send_next_nolock(struct ath10k_ce_pipe *ce_state,
>   
>   /*==================CE Engine Initialization=======================*/
>   
> -int ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
> -			const struct ce_attr *attr);
> +void ath10k_ce_init_pipe(struct ath10k *ar, unsigned int ce_id,
> +			 const struct ce_attr *attr);
>   void ath10k_ce_deinit_pipe(struct ath10k *ar, unsigned int ce_id);
>   int ath10k_ce_alloc_pipe(struct ath10k *ar, int ce_id,
>   			 const struct ce_attr *attr);
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
> index a7f44f6335fb..8e05326400bb 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -2527,16 +2527,10 @@ void ath10k_pci_free_pipes(struct ath10k *ar)
>   int ath10k_pci_init_pipes(struct ath10k *ar)
>   {
>   	struct ath10k_pci *ar_pci = ath10k_pci_priv(ar);
> -	int i, ret;
> +	int i;
>   
> -	for (i = 0; i < CE_COUNT; i++) {
> -		ret = ath10k_ce_init_pipe(ar, i, &ar_pci->attr[i]);
> -		if (ret) {
> -			ath10k_err(ar, "failed to initialize copy engine pipe %d: %d\n",
> -				   i, ret);
> -			return ret;
> -		}
> -	}
> +	for (i = 0; i < CE_COUNT; i++)
> +		ath10k_ce_init_pipe(ar, i, &ar_pci->attr[i]);
>   
>   	return 0;
>   }
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 26214c00cd0d..4f835ad60080 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -941,16 +941,10 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
>   
>   static int ath10k_snoc_init_pipes(struct ath10k *ar)
>   {
> -	int i, ret;
> +	int i;
>   
> -	for (i = 0; i < CE_COUNT; i++) {
> -		ret = ath10k_ce_init_pipe(ar, i, &host_ce_config_wlan[i]);
> -		if (ret) {
> -			ath10k_err(ar, "failed to initialize copy engine pipe %d: %d\n",
> -				   i, ret);
> -			return ret;
> -		}
> -	}
> +	for (i = 0; i < CE_COUNT; i++)
> +		ath10k_ce_init_pipe(ar, i, &host_ce_config_wlan[i]);
>   
>   	return 0;
>   }

