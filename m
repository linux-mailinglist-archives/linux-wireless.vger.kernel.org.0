Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6F765915
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 18:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjG0Qrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjG0Qrm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 12:47:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B32696
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 09:47:41 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDkJRP008071;
        Thu, 27 Jul 2023 16:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WB28qqUYvyseSWD/r/j4+D+ItZWixPmzGHBsazWIPyA=;
 b=IUW7GFZVOiHOHNTTb6IvgWd/OEryD+D1NLucbHlhwhk7OECar+an4Zu9Nmk92uqTultZ
 u52jjWkv9rNJDRtd9QVtArx4OEMDTSDwuW/0M2Jm7XXD43zS9H9BQoh/a6iidXpam1Ga
 /8qEIYjNoBxt8wzE80LwrD1T0XfSjaYK4sU0sVFsoFIzEizIY7YuwAFVtGmHonc0t0Bd
 N4DYN/Vzx9TaTJ21LqsxJpJrqrm0vCOvU5+35VXXdpwrdR+m8Lv9QbM8y6hYB8TP0pSV
 Q64iGuiroOSTPRBdobWyyf46ETvGLjnEuKWr0x/LWMPxRM+UivsHBvQ2dBbk4C/SGWCW 6Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3krn9eth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 16:47:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RGlMqN022812
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 16:47:23 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 09:47:21 -0700
Message-ID: <d86d8f47-dbb2-1da6-794a-c020c317b4b5@quicinc.com>
Date:   Thu, 27 Jul 2023 09:47:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <mhi@lists.linux.dev>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20230727100430.3603551-1-kvalo@kernel.org>
 <20230727100430.3603551-3-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230727100430.3603551-3-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JoQrgzWxSJuMopEaBaBWAcPav_TeIEeU
X-Proofpoint-GUID: JoQrgzWxSJuMopEaBaBWAcPav_TeIEeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 suspectscore=0 mlxlogscore=921 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270151
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/27/2023 3:04 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Simple refactoring to make it easier to add firmware-2.bin support in the
> following patch.
> 
> Earlier ath11k_qmi_m3_load() supported changing m3.bin contents while ath11k is
> running. But that's not going to actually work, m3.bin is supposed to the be

nit: s/to the be/to be the/

> same during the lifetime of ath11k, for example we don't support changing the
> firmware capabilities on the fly. Due to this ath11k requests m3.bin firmware
> file first and only then checks m3_mem->vaddr, so we are basically requesting
> the firmware file even if it's not needed. Reverse the code so that m3_mem
> buffer is checked first, and only if it doesn't exist, then m3.bin is requested
> from user space.
> 
> Checking for m3_mem->size is redundant when m3_mem->vaddr is NULL, we would
> not be able to use the buffer in that case. So remove the check for size.
> 
> Simplify the exit handling and use 'goto out'.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath11k/qmi.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index d4eaf7d2ba84..9b13628fa3c7 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2506,6 +2506,10 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
>   	char path[100];
>   	int ret;
>   
> +	if (m3_mem->vaddr)
> +		/* m3 firmware buffer is already available in the DMA buffer */
> +		return 0;
> +
>   	fw = ath11k_core_firmware_request(ab, ATH11K_M3_FILE);
>   	if (IS_ERR(fw)) {
>   		ret = PTR_ERR(fw);
> @@ -2515,25 +2519,25 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
>   		return ret;
>   	}
>   
> -	if (m3_mem->vaddr || m3_mem->size)
> -		goto skip_m3_alloc;
> -
>   	m3_mem->vaddr = dma_alloc_coherent(ab->dev,
>   					   fw->size, &m3_mem->paddr,
>   					   GFP_KERNEL);
>   	if (!m3_mem->vaddr) {
>   		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
>   			   fw->size);
> -		release_firmware(fw);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto out;
>   	}
>   
> -skip_m3_alloc:
>   	memcpy(m3_mem->vaddr, fw->data, fw->size);
>   	m3_mem->size = fw->size;
> +
> +	ret = 0;
> +
> +out:
>   	release_firmware(fw);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static void ath11k_qmi_m3_free(struct ath11k_base *ab)

