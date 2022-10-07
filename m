Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED855F8143
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Oct 2022 01:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJGXhq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 19:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJGXhc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 19:37:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3349FA0252
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 16:37:31 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297NKH1Z012029;
        Fri, 7 Oct 2022 23:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DaZrRptNd0J7RK9afiTIY6x9U1/sXJGh+VYoxFATEa8=;
 b=UPWRLCRr1hT0fIzm+p5yCfcBqPWAH26eo3MKEwhsJE2bgbJL9BeTR6mBYRaMUzm7N29M
 paIPfiS542sllwdg/UNQT/ZynVqRlchjVQN50EOeQivPYDSAI8/IrnVfKiHvGIy2tNmO
 D/VUoHqR/pHOFHUc5wH5x2RIa1Iskxf2DMtttmFURGB/kl1FyELs1rScU34qFuG+Os2Z
 01Xummru6axngvPNdiZztfy2FxERwD/6jLhjHqYI6iZ0hR3oOHdJvj7u21p28N4LR7Xh
 SxeatOl1M9Hx586xCUphDlquu9FqAc0wfxhmrOmuIrhGw0USyIqZMqU27rATfTaNr82M Jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k2dmy9ymh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Oct 2022 23:37:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 297NbRZQ027716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Oct 2022 23:37:27 GMT
Received: from [10.110.6.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 7 Oct 2022
 16:37:26 -0700
Message-ID: <0cf2a588-b2e1-b5d3-2ab5-8e76ddee839e@quicinc.com>
Date:   Fri, 7 Oct 2022 16:37:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 8/8] wifi: ath11k: add ipq5018 device support
Content-Language: en-US
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
References: <20221006105913.18356-1-quic_kathirve@quicinc.com>
 <20221006105913.18356-9-quic_kathirve@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20221006105913.18356-9-quic_kathirve@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cDvAyRP9d_uoWqM7Ds6mIyYrtvXxkTTO
X-Proofpoint-ORIG-GUID: cDvAyRP9d_uoWqM7Ds6mIyYrtvXxkTTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210070140
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/6/2022 3:59 AM, Karthikeyan Kathirvel wrote:
> ipq5018 is a ahb 2ghz device, enable the compatible support for

nits: s/ahb/AHB/g && s/2ghz/2 GHz/

> ipq5018 in ahb.
> 
> Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/ahb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 231414e677b1..2bc45a7e51cb 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -32,6 +32,9 @@ static const struct of_device_id ath11k_ahb_of_match[] = {
>   	{ .compatible = "qcom,wcn6750-wifi",
>   	  .data = (void *)ATH11K_HW_WCN6750_HW10,
>   	},
> +	{ .compatible = "qcom,ipq5018-wifi",
> +	  .data = (void *)ATH11K_HW_IPQ5018_HW10,
> +	},
>   	{ }
>   };
>   

