Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06F178F77C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 05:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348238AbjIADkz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 23:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjIADkv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 23:40:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5696718C
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 20:40:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3813PIOv019655;
        Fri, 1 Sep 2023 03:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b/djOISPbbNKu9e3Cy/GHYQgzJiRTjmdrBcMv1U3+WQ=;
 b=Ey3AMZT2mFd4wWgGCUpI3A7jUh0xtp0h4b2QFBKeFhnt9/4jOFRi+iI8/bnVfbpVml3P
 XCz5mEGURQ4rxWSXpfnZTJ5Hcrh4/Fw8UeawvIbaxBkfahhdN6bP69+ItxKN2QvpN1OD
 kjzpfkoGHtmjQRx4wZt8pgFBcJLaKPUT+6ynLyJj1QcKQ5/PC2Uz9Bw8pTRefKlQylFn
 hctllL8H/m1yPL7bjtUFFp6sVejCmHWceOcw3Ksjps9P4ZDoK+78W4cJYhEVb8Ihg/MO
 m2YAKmImpWb8qzM1ZYjjl9Yr95dW4FpiCsxSwlsf/0M0ALoYJUq/x1ZOsZx25V0rFSa6 MQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stxru15ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 03:40:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3813eg2u011445
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 03:40:42 GMT
Received: from [10.111.179.211] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 20:40:41 -0700
Message-ID: <3188a89a-7d8f-49e2-abb6-7cefcde4cc1a@quicinc.com>
Date:   Thu, 31 Aug 2023 20:40:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix possible out-of-bound read in
 ath12k_htt_pull_ppdu_stats()
Content-Language: en-US
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230901015602.45112-1-quic_bqiang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230901015602.45112-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q0aapyQDZB_rO4_rSqCfRJlHjdlFDguK
X-Proofpoint-ORIG-GUID: Q0aapyQDZB_rO4_rSqCfRJlHjdlFDguK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_01,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxlogscore=996 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/31/2023 6:56 PM, Baochen Qiang wrote:
> len is extracted from HTT message and could be an unexpected value in
> case errors happen, so add validation before using to avoid possible
> out-of-bound read in the following message iteration and parsing.
> 
> The same issue also applies to ppdu_info->ppdu_stats.common.num_users,
> so validate it before using too.
> 
> These are found during code review.
> 
> Compile test only.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath12k/dp_rx.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index e6e64d437c47..5189a0690d44 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1555,6 +1555,13 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
>   
>   	msg = (struct ath12k_htt_ppdu_stats_msg *)skb->data;
>   	len = le32_get_bits(msg->info, HTT_T2H_PPDU_STATS_INFO_PAYLOAD_SIZE);
> +	if (len > (skb->len - struct_size(msg, data, 0))) {
> +		ath12k_warn(ab,
> +			    "HTT PPDU STATS event has unexpected payload size %u, should be smaller than %u\n",
> +			    len, skb->len);
> +		return -EINVAL;
> +	}
> +
>   	pdev_id = le32_get_bits(msg->info, HTT_T2H_PPDU_STATS_INFO_PDEV_ID);
>   	ppdu_id = le32_to_cpu(msg->ppdu_id);
>   
> @@ -1583,6 +1590,15 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
>   		goto exit;
>   	}
>   
> +	if (ppdu_info->ppdu_stats.common.num_users >= HTT_PPDU_STATS_MAX_USERS) {
> +		spin_unlock_bh(&ar->data_lock);
> +		ath12k_warn(ab,
> +			    "HTT PPDU STATS event has unexpected num_users %u, should be smaller than %u\n",
> +			    ppdu_info->ppdu_stats.common.num_users, HTT_PPDU_STATS_MAX_USERS);
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
>   	/* back up data rate tlv for all peers */
>   	if (ppdu_info->frame_type == HTT_STATS_PPDU_FTYPE_DATA &&
>   	    (ppdu_info->tlv_bitmap & (1 << HTT_PPDU_STATS_TAG_USR_COMMON)) &&
> 
> base-commit: a62b0aeb556839fb6abb9835874443b08fe95598

