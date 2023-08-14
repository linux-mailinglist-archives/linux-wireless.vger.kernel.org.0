Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5677BBDC
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjHNOk6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 10:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjHNOkZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 10:40:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B2FF5
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 07:40:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECrCue032286;
        Mon, 14 Aug 2023 14:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Awq0VCTn7hOYLbV3Lp5RBFBDxM8X8dv8HQfrBsnccAE=;
 b=E0tVhc9TNbwLuV6Vx29o9UbPF6J7vGCgBg7O0REb4LE+GL4YcLKYhM5WtiTqarEfjXDz
 JMsESnImOMiIvtzZEOPEHVLsDzK8fX0GmOVoVqq5R2Tfc1TA5ZIAks2ykIQoIDpLlVLD
 gSTwSs/SnGCQ6y78yO4Z27WeW3FP9eZIN4inhOpo59APX1buLHhe2euNrUK3eBZTcf4G
 VpZjHWhEstFfiA9Vk1uOcihn5NaGqBjO5NXjdlAUgP28dOVe9874AJWU0UubojqiXTev
 y3G7idIqupxZH0RgNYGU3hwFCIu1y+KlyNgCB8uYpz5dMSUkGxfDtJl5OOP7P37CJngs Nw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3tym24q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 14:40:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EEe6M3006816
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 14:40:06 GMT
Received: from [10.48.240.144] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 07:40:05 -0700
Message-ID: <f54ac1e5-4a3d-780a-0e83-5a26b472c17f@quicinc.com>
Date:   Mon, 14 Aug 2023 07:40:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] wifi: ath: Use is_multicast_ether_addr() to
 check multicast Ether address
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, <kvalo@kernel.org>,
        <briannorris@chromium.org>, <johannes.berg@intel.com>,
        <Jason@zx2c4.com>, <toke@toke.dk>, <tj@kernel.org>,
        <mukesh.sisodiya@intel.com>, <quic_vjakkam@quicinc.com>,
        <johannes.wiesboeck@aisec.fraunhofer.de>,
        <linux-wireless@vger.kernel.org>
References: <20230814124212.302738-1-ruanjinjie@huawei.com>
 <20230814124212.302738-2-ruanjinjie@huawei.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230814124212.302738-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _fvsNocpzA0W04cSxZDcIvFskF92STOU
X-Proofpoint-ORIG-GUID: _fvsNocpzA0W04cSxZDcIvFskF92STOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/14/2023 5:42 AM, Ruan Jinjie wrote:
> Use is_multicast_ether_addr() to perform the Checking.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/key.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/key.c b/drivers/net/wireless/ath/key.c
> index b7b61d4f02ba..21a93fec284d 100644
> --- a/drivers/net/wireless/ath/key.c
> +++ b/drivers/net/wireless/ath/key.c
> @@ -104,7 +104,7 @@ bool ath_hw_keysetmac(struct ath_common *common, u16 entry, const u8 *mac)
>   		 * Not setting this bit allows the hardware to use the key
>   		 * for multicast frame decryption.
>   		 */
> -		if (mac[0] & 0x01)
> +		if (is_multicast_ether_addr(mac))
>   			unicast_flag = 0;
>   
>   		macLo = get_unaligned_le32(mac);

