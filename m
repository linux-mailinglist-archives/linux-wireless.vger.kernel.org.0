Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067677A0AAA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjINQWL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjINQWK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 12:22:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20BF10C7
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 09:22:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EFEiQM005157;
        Thu, 14 Sep 2023 16:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+oPTmMCRZ+eyuUvELPC5doooaqc2SJcA/qnvR/iCEG8=;
 b=HHQbyxhoFx/LOoV34QuH+XT3KjfteekcV4e+kJCtLbikex2yacQdBdXSrd0Du/ns3RGE
 +Qs0CyF/7IhTzFV0EdnKLA4Pwq7pxstixV/+xe1hQJwi7iZkwqUWfrum6U8jDuC2fshP
 wy3+0Oz/FgmQQJChhHmrV22Z1spevZM3neSEGxF3YiCNJKiwApxEAqgkIsdMtJzKI2AD
 F9L7f/bsHjzdlPWmDB+mqLQPepM27+7T1kYOwowlVaSGpW9vi0bWHZl5VOUltMiPk/Km
 GFtm2jcdXKPtA9YYmnS6yHhVTtzLLzUAzJWojIffHtn8Nc//586sG8XJeDk3z0mbiuY/ sQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3x6mshrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 16:21:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EGLu2X024225
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 16:21:56 GMT
Received: from [10.111.183.186] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 09:21:55 -0700
Message-ID: <ac5cdf25-7dc5-43ac-8cf9-8997dfd9e07e@quicinc.com>
Date:   Thu, 14 Sep 2023 09:21:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: drop HTT_DATA_TX_STATUS_DOWNLOAD_FAIL
Content-Language: en-US
To:     Dmitry Antipov <dmantipov@yandex.ru>
CC:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <lvc-project@linuxtesting.org>, <ath10k@lists.infradead.org>
References: <18eac255-720a-488e-882e-b79f098aba65@quicinc.com>
 <20230914160744.155903-1-dmantipov@yandex.ru>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230914160744.155903-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KQUm1_W4-OCyP_3aAJCi_6sqZFlb8voQ
X-Proofpoint-ORIG-GUID: KQUm1_W4-OCyP_3aAJCi_6sqZFlb8voQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=631 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140141
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/14/2023 9:07 AM, Dmitry Antipov wrote:
> According to Jeff, 'HTT_DATA_TX_STATUS_DOWNLOAD_FAIL' from
> 'enum htt_data_tx_status' is never actually used by the
> firmware code and so may be dropped, with the related
> adjustment to 'ath10k_htt_rx_tx_compl_ind()'.
> 
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> ---
>   drivers/net/wireless/ath/ath10k/htt.h    | 3 +--
>   drivers/net/wireless/ath/ath10k/htt_rx.c | 1 -
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
> index 7b24297146e7..c80470e8886a 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.h
> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> @@ -880,8 +880,7 @@ enum htt_data_tx_status {
>   	HTT_DATA_TX_STATUS_OK            = 0,
>   	HTT_DATA_TX_STATUS_DISCARD       = 1,
>   	HTT_DATA_TX_STATUS_NO_ACK        = 2,
> -	HTT_DATA_TX_STATUS_POSTPONE      = 3, /* HL only */
> -	HTT_DATA_TX_STATUS_DOWNLOAD_FAIL = 128
> +	HTT_DATA_TX_STATUS_POSTPONE      = 3 /* HL only */
>   };
>   
>   enum htt_data_tx_flags {
> diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
> index 438b0caaceb7..b261d6371c0f 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
> @@ -2964,7 +2964,6 @@ static void ath10k_htt_rx_tx_compl_ind(struct ath10k *ar,
>   		break;
>   	case HTT_DATA_TX_STATUS_DISCARD:
>   	case HTT_DATA_TX_STATUS_POSTPONE:
> -	case HTT_DATA_TX_STATUS_DOWNLOAD_FAIL:
>   		tx_done.status = HTT_TX_COMPL_STATE_DISCARD;
>   		break;
>   	default:

