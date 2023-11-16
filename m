Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A963A7EE771
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjKPTZE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 14:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPTZC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 14:25:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4318D
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 11:24:59 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGFulgc009990;
        Thu, 16 Nov 2023 19:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NUHZZ8GEA4+SZqQqSw8w2Q1XMY+r1gu5FdCWiOiBC2s=;
 b=m2+GMOjSFRSeiqlJAcg/zUu/qL79URjHx/NMMl68nFR8Qq0W9s0r9TvBaqptRiapod11
 xtuBDY7UpMg/fytm4Wlg9B9catEttJZlAX6XUaV3Qx9fPvUF/uKczfMfYT2m4EcBE27y
 WsGE4sfJRtoRyygx0oVNUsRJxH4iM82bYQEdhuYACPhC7xBPwmKjVt7wXyNJ+87V28hN
 e0u1SqQT3UkjNrv4Hi5KcdpZsvVNtUoS+7piKR7KyAWKVT+CpoJ+vqd0i37PYwpA2B46
 C0d/63viE+UiC+Gti+2Z+jbIDzETJTLoOeTRZIVHX0IoBgoM2q377c9hqxE4ZTQJAefx kQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udeww9h0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 19:24:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGJOv44006852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 19:24:57 GMT
Received: from [10.110.1.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 11:24:57 -0800
Message-ID: <343af05d-eab9-4411-a016-8d7d96f78379@quicinc.com>
Date:   Thu, 16 Nov 2023 11:24:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: use select for CRYPTO_MICHAEL_MIC
Content-Language: en-US
To:     James Prestwood <prestwoj@gmail.com>,
        <linux-wireless@vger.kernel.org>
References: <20231113153544.282461-1-prestwoj@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231113153544.282461-1-prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eroUzm-u_ZYQGkKA22DZT_Ff0aSjuNCl
X-Proofpoint-GUID: eroUzm-u_ZYQGkKA22DZT_Ff0aSjuNCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_20,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=801 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160152
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/13/2023 7:35 AM, James Prestwood wrote:
> Let ath11k select this option automatically which makes building
> more intuitive if the user enables this driver (rather than the
> driver not building unless CRYPTO_MICAEL_MIC is explicitly enabled)

s/MICAEL/MICHAEL/

add hard stop

Also suggest you include (or summarize) the information that Kalle
shared that ath is the outlier here:

Further investigation shows that ath11k and ath12k are the only who use
'depends on' with CRYPTO_MICHAEL_MIC:

./drivers/net/wireless/intel/ipw2x00/Kconfig:	select CRYPTO_MICHAEL_MIC
./drivers/net/wireless/intersil/hostap/Kconfig:	select CRYPTO_MICHAEL_MIC
./drivers/net/wireless/intersil/orinoco/Kconfig:	select CRYPTO_MICHAEL_MIC
./drivers/net/wireless/ath/ath11k/Kconfig:	depends on CRYPTO_MICHAEL_MIC
./drivers/net/wireless/ath/ath12k/Kconfig:	depends on CRYPTO_MICHAEL_MIC
./drivers/staging/rtl8192e/Kconfig:	select CRYPTO_MICHAEL_MIC
./drivers/staging/ks7010/Kconfig:	select CRYPTO_MICHAEL_MIC

consider these comments apply to ath12k change as well :)

> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> ---
>  drivers/net/wireless/ath/ath11k/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
> index ad5cc6cac05b..27f0523bf967 100644
> --- a/drivers/net/wireless/ath/ath11k/Kconfig
> +++ b/drivers/net/wireless/ath/ath11k/Kconfig
> @@ -2,7 +2,7 @@
>  config ATH11K
>  	tristate "Qualcomm Technologies 802.11ax chipset support"
>  	depends on MAC80211 && HAS_DMA
> -	depends on CRYPTO_MICHAEL_MIC
> +	select CRYPTO_MICHAEL_MIC
>  	select ATH_COMMON
>  	select QCOM_QMI_HELPERS
>  	help

