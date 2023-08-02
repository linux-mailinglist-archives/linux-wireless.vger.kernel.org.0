Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DEA76D0C3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 17:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHBPAD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 11:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjHBPAC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 11:00:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA91FFA
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 07:59:59 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372BuXpQ026850;
        Wed, 2 Aug 2023 14:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jQ03W97o7ZUVoXDBXwz5ZxV9OrSqbS25eM9YHJeOPlI=;
 b=eupAp8YiSuBcjU3CDRcNktYZAMuStupsM3ugBO78AyTJsYIs5AqQSuAUBv70PZFGPer2
 PbOJRKi6GuTAFwpPbLAQ7yjWhmsMsyI9cZjEH4KB+8oRc3D1ZyRlkDeJGwSmoiFVHXpT
 a8NCOrLXci8lJQHZFPxSSwEvRhZ1RE+GLgmq386llcAKJz5E3GgoBU/pY1v4KHK9MKTR
 VuK16t/4Vx9vr24eo9OlJ42ykN6GM16XEVsMuRxpyFk5gM4lHgwolc/O8mLPBezpTaB0
 XoO3LPyBZaJf/YZLJgnKcMfz98FSLLuqiicM1lwDfC8+XOo2ganuvtExMO6zDfWABJth Pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7fre1n73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 14:59:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372ExnMJ017176
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 14:59:49 GMT
Received: from [10.111.177.49] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 07:59:49 -0700
Message-ID: <54733de9-db66-f1c4-9ad5-4d1f31529c05@quicinc.com>
Date:   Wed, 2 Aug 2023 07:59:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: fix WARN_ON during
 ath12k_mac_update_vif_chan
Content-Language: en-US
To:     Manish Dharanenthiran <quic_mdharane@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230802085852.19821-1-quic_mdharane@quicinc.com>
 <20230802085852.19821-2-quic_mdharane@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230802085852.19821-2-quic_mdharane@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5W_neT19CCOpIaBw2RbYfA7opp0dDnwA
X-Proofpoint-ORIG-GUID: 5W_neT19CCOpIaBw2RbYfA7opp0dDnwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_10,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=928 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/2/2023 1:58 AM, Manish Dharanenthiran wrote:
> Fix WARN_ON() from ath12k_mac_update_vif_chan() if vdev is not up.
> Since change_chanctx can be called even before vdev_up.
> 
> Do vdev stop followed by a vdev start in case of vdev is down.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1

Has this been tested on WCN7850? My understanding is that firmware may 
expect vdev down and then vdev restart

> 
> Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 1bb9802ef569..0ab95e138d1d 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5698,13 +5698,28 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
>   		if (WARN_ON(!arvif->is_started))
>   			continue;
>   
> -		if (WARN_ON(!arvif->is_up))
> -			continue;
> +		/* Firmware expect vdev_restart only if vdev is up.
> +		 * If vdev is down then it expect vdev_stop->vdev_start.
> +		 */
> +		if (arvif->is_up) {
> +			ret = ath12k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
> +			if (ret) {
> +				ath12k_warn(ab, "failed to restart vdev %d: %d\n",
> +					    arvif->vdev_id, ret);
> +				continue;
> +			}
> +		} else {
> +			ret = ath12k_mac_vdev_stop(arvif);
> +			if (ret) {
> +				ath12k_warn(ab, "failed to stop vdev %d: %d\n",
> +					    arvif->vdev_id, ret);
> +				continue;
> +			}
>   
> -		ret = ath12k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
> -		if (ret) {
> -			ath12k_warn(ab, "failed to restart vdev %d: %d\n",
> -				    arvif->vdev_id, ret);
> +			ret = ath12k_mac_vdev_start(arvif, &vifs[i].new_ctx->def);
> +			if (ret)
> +				ath12k_warn(ab, "failed to start vdev %d: %d\n",
> +					    arvif->vdev_id, ret);
>   			continue;
>   		}
>   

