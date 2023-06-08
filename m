Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA34727E7F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 13:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbjFHLJQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjFHLJC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 07:09:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DDB4225
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 04:07:01 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358ApacK025788;
        Thu, 8 Jun 2023 11:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6CYH/yvi+lpnCPwaJ4+GEAetEPEA12O1uGjN5TpUzRU=;
 b=Byjs/V8uSbNC9HAW9qoGEPsJSUvpaN7QGR7fT9xbEISXmRYBAdUvY7+8UIaLtclpjfQY
 ZhXj6oiMERRqIlj5vLmxpQ1fJK0SMdp1CwaaHc1Ullm2rGuUdNl0eoMtXVHYaNJHKxOo
 LrRvXpcO/2gR+QbwBLJ+tUN24Y55FAdS2nSdkE0c9w68rft8c8MUEjGxZEaFTlCrTIrP
 qb40cYO+n55ZeYirsPIjLr0uohOWsSzk/aWE6Mrj6jEHPpnnpALk3Zh0f/YPbbWt1teG
 0Y9Fq7ZuLLAEV193wQ8YYTfwyh3fcNlhOaQarCrFss3VdHRVdQSzIB1l6FWb3mAwxcKn 5A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r36pdrswc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 11:06:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358B6fFp010850
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 11:06:41 GMT
Received: from [10.216.0.83] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 04:06:32 -0700
Message-ID: <e2c15d6b-2416-91cb-f08c-2ed985a9634b@quicinc.com>
Date:   Thu, 8 Jun 2023 16:36:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] wifi: ath12k: fix conf_mutex in
 ath12k_mac_op_unassign_vif_chanctx()
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230608104444.3134-1-quic_wgong@quicinc.com>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20230608104444.3134-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SWsNV4XKYzk4g_J5mGDYlTlSY8_Bnnk4
X-Proofpoint-ORIG-GUID: SWsNV4XKYzk4g_J5mGDYlTlSY8_Bnnk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_07,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=922 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080094
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 6/8/2023 4:14 PM, Wen Gong wrote:
> "mutex_unlock(&ar->conf_mutex);" is always called at end of function
> ath12k_mac_op_unassign_vif_chanctx(), so delete this unlock to make
> sure lock/unlock is paired.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index ee792822b411..e65f5337d8f5 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5910,7 +5910,6 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>   		}
>   
>   		arvif->is_started = false;
> -		mutex_unlock(&ar->conf_mutex);
>   	}
>   
>   	ret = ath12k_mac_vdev_stop(arvif);
> 
> base-commit: 0a00db612b6df1fad80485e3642529d1f28ea084

LGTM
