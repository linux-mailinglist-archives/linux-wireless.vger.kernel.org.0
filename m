Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC76752804
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jul 2023 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjGMQHE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 12:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjGMQHD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 12:07:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530A22709
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 09:07:02 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DEa52B017979;
        Thu, 13 Jul 2023 16:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4rfGSNDWFVI60CrzeXbFWlF6DIRFsfBUSOHd7A8pudw=;
 b=TlE303xavJqYQ65EAS9dLyWk8cCSAhqLLkqSa+CtZSSEnoLeQqBJjaWqvBm3dF8O/YNP
 FS/PDPJq1I8mA1UuG32tiEXSLrT9Ir37F10BlM75W4kXY+Jz/YHfV1vW8jZqgK3uxM/9
 3VqDusJyc+8+GAww1ci2LQ/W0z9WZGZC5MzGKLRhhVnuCSEsIumwwr+QM/Ov1TN4Ktja
 3Oh4+RLAfQsnjbCXV5qY5sTEVrpeb8fsR743ZDOwr4oyVPz4S34N6CGmazLVDsiX2F62
 yMrl/0O6gpjI7WuinY21VVsCjgJTZHE77e1SzAlO63N84QPLsHrhEHg2xspyTlkWUYW0 Ug== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtgn18mce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 16:06:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DG6olB029852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 16:06:50 GMT
Received: from [10.111.182.44] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 09:06:49 -0700
Message-ID: <5a053fc3-7fd0-f8ea-7512-e473815814f4@quicinc.com>
Date:   Thu, 13 Jul 2023 09:06:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath10k: fix PCI and SNOC RX pipe operations
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>
CC:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, <linux-wireless@vger.kernel.org>
References: <20230713160101.333483-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230713160101.333483-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: niAODIQFPp83vbeMlxG0Pl8rDaV6saky
X-Proofpoint-ORIG-GUID: niAODIQFPp83vbeMlxG0Pl8rDaV6saky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=696 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130142
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/13/2023 9:00 AM, Dmitry Antipov wrote:
> Since 'mod_timer()' expects expiration time in jiffies, add
> missing 'msecs_to_jiffies()' in 'ath10k_pci_rx_post_pipe()'
> and 'ath10k_snoc_rx_post_pipe()'. Also simplify the loops
> and fix number of loop iterations in the former (it should
> be equal to 'num' (i.e. number of buffers) and not 'num + 1'.
> 
> Fixes: 728f95eef523 ("ath10k: rework posting pci rx buffers")
> Fixes: a6e149a9ff03 ("ath10k: add hif start/stop methods for wcn3990 snoc layer")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>   drivers/net/wireless/ath/ath10k/pci.c  | 16 +++++++---------
>   drivers/net/wireless/ath/ath10k/snoc.c | 14 +++++++-------
>   2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
> index a7f44f6335fb..c004c87d3211 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -818,17 +818,15 @@ static void ath10k_pci_rx_post_pipe(struct ath10k_pci_pipe *pipe)
>   	num = __ath10k_ce_rx_num_free_bufs(ce_pipe);
>   	spin_unlock_bh(&ce->ce_lock);
>   
> -	while (num >= 0) {
> +	while (num--) {
>   		ret = __ath10k_pci_rx_post_buf(pipe);
> -		if (ret) {
> -			if (ret == -ENOSPC)
> -				break;
> -			ath10k_warn(ar, "failed to post pci rx buf: %d\n", ret);
> -			mod_timer(&ar_pci->rx_post_retry, jiffies +
> -				  ATH10K_PCI_RX_POST_RETRY_MS);
> +		if (ret)
>   			break;
> -		}
> -		num--;
> +	}
> +	if (ret != -ENOSPC) {

doesn't this do incorrect processing for the case where ret == 0?

> +		ath10k_warn(ar, "failed to post PCI rx buf: %d\n", ret);
> +		mod_timer(&ar_pci->rx_post_retry, jiffies +
> +			  msecs_to_jiffies(ATH10K_PCI_RX_POST_RETRY_MS));
>   	}
>   }
>   
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 26214c00cd0d..9ced24b1b177 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -544,16 +544,16 @@ static void ath10k_snoc_rx_post_pipe(struct ath10k_snoc_pipe *pipe)
>   	spin_lock_bh(&ce->ce_lock);
>   	num = __ath10k_ce_rx_num_free_bufs(ce_pipe);
>   	spin_unlock_bh(&ce->ce_lock);
> +
>   	while (num--) {
>   		ret = __ath10k_snoc_rx_post_buf(pipe);
> -		if (ret) {
> -			if (ret == -ENOSPC)
> -				break;
> -			ath10k_warn(ar, "failed to post rx buf: %d\n", ret);
> -			mod_timer(&ar_snoc->rx_post_retry, jiffies +
> -				  ATH10K_SNOC_RX_POST_RETRY_MS);
> +		if (ret)
>   			break;
> -		}
> +	}
> +	if (ret != -ENOSPC) {

doesn't this do incorrect processing for the case where ret == 0?

> +		ath10k_warn(ar, "failed to post SNOC rx buf: %d\n", ret);
> +		mod_timer(&ar_snoc->rx_post_retry, jiffies +
> +			  msecs_to_jiffies(ATH10K_SNOC_RX_POST_RETRY_MS));
>   	}
>   }
>   

