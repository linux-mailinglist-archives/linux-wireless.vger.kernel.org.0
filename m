Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957BA5A14FD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 16:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiHYO7p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 10:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiHYO7o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 10:59:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBB6B5A78
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 07:59:42 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PBLRbQ020598;
        Thu, 25 Aug 2022 14:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qCk5VESLGfnaSsTlBTBGfMQ1jV8FlbrNCIhmlJBvPlc=;
 b=dmOBioTwWMadYVnnG3+Ki6UNnJ9rGqhutD5QrFqbNsACLFAbFj0yXvSXBLasu2tfxwI5
 LNkwhLyq9fdLa2PZfLo5pAkQHWlZQqG7qTnHpQAq0tWRgcRdRwyNhnskn3qeE5QJv4Fe
 CUQfgiICXL42C6ixxZ4AiKo6HVZq2Lf0SWYKGgJGD7twx60T4zVSfuYChtm0KS1ZuHOY
 PK/oU1Qs5fA1SN5BdsIqM0xvXthnmuarLA0gEaJkKjd7Xt+1w6YSwBM/BY6XSKs8uFGh
 zv6Hzu2JUZbaqWH+Wc762xVGeTc6D00xFBTTqXYkhnrIZeuEQLv66V8xdR6LJQ3G6VdV YA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j5xcujfku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 14:59:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PExXRX023694
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 14:59:33 GMT
Received: from [10.110.120.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 07:59:32 -0700
Message-ID: <44b3af84-1a83-7ff0-b826-8532bee0b4c0@quicinc.com>
Date:   Thu, 25 Aug 2022 07:59:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/4] ath11k: Fix double free issue during SRNG deinit
Content-Language: en-US
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220825111818.30869-1-quic_mpubbise@quicinc.com>
 <20220825111818.30869-2-quic_mpubbise@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220825111818.30869-2-quic_mpubbise@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ipx_u9gPZkfz5CwwgEKMyB2Sc26wyu-_
X-Proofpoint-ORIG-GUID: ipx_u9gPZkfz5CwwgEKMyB2Sc26wyu-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_06,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=985 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/25/2022 4:18 AM, Manikanta Pubbisetty wrote:
> Currently struct ath11k_hal::srng_config pointer is not assigned
> to NULL after freeing the memory in ath11k_hal_srng_deinit().
> This could lead to double free issue in a scerario where

nit: s/scerario/scenario/

> ath11k_hal_srng_deinit() is invoked back to back.
> 
> In the current code, although the chances are very low, the above
> said scenario could happen when hardware recovery has failed and
> then there is another FW assert where ath11k_hal_srng_deinit() is
> invoked once again as part of recovery. Addressing this issue is
> important when low power mode support is enabled in the driver
> (will be added by a future patch) where this scenario is likely.
> 
> Fix this by assigning the struct ath11k_hal::srng_config pointer
> to NULL after freeing the memory.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/hal.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index bda71ab5a1f2..ebdf3b1a6661 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1319,6 +1319,7 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>   	ath11k_hal_free_cont_rdp(ab);
>   	ath11k_hal_free_cont_wrp(ab);
>   	kfree(hal->srng_config);
> +	hal->srng_config = NULL;
>   }
>   EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>   

