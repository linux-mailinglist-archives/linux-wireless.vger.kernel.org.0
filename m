Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3AE6F0078
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 07:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbjD0Fkh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 01:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242710AbjD0Fkg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 01:40:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FEE30D3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 22:40:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R5UlWW020082;
        Thu, 27 Apr 2023 05:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WzulRp1kem0x/P3rNHe/4X8sDVV7iTTPypY7fOmeLpI=;
 b=NvYB/PdNSPwogIYIBz+JtuLQWlgKDEMLmM/OJHJrOXe16rFZipPM3X2Yxs7Gj91RGbtv
 P53Zu5Ee5iUHsLBWAzZGkjUP4d3WzxRa4qoTMI9gPWcriDo1a/H/C9p4u00YtNerkmLY
 exbb56t+7L1qz8k5BtvfQ2FhW79w5hYdOCwMjmLcIb2r/r0564BpjIiqVEtQ61FWbfVc
 snEw3inQ1fINqLgOLksQ9V8Y1LMoSCdl2ZGAmNsGb7IVjtscow/wgkFXjlE5y+VoS80K
 6l7JtDuY6lrVmYM4rTvyzWvUPt+JsH9fUeeut/38QufExzcDRHSeXaWKECcayarTi47f LQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q79euh1j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 05:40:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33R5eN7I032464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 05:40:23 GMT
Received: from [10.216.21.5] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 26 Apr
 2023 22:40:22 -0700
Message-ID: <5d97fc5b-3396-6d45-b504-bb254137c576@quicinc.com>
Date:   Thu, 27 Apr 2023 11:10:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: ath12k: Use msdu_end to check MCBC
Content-Language: en-US
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230427013021.29792-1-quic_bqiang@quicinc.com>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20230427013021.29792-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HQdXDBH2rmY7rUors1yu--dyWn63kIJr
X-Proofpoint-ORIG-GUID: HQdXDBH2rmY7rUors1yu--dyWn63kIJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_03,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=952 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270050
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 4/27/2023 7:00 AM, Baochen Qiang wrote:
> We are seeing a very low TCP throughput testing with some specific
> tools. This is because for sub-frames of an AMSDU, MCBC flag in
> mpdu_start may be not valid, and as a result those frames would be
> dropped by kernel.
> 
> Change to get it from msdu_end.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/hal.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index 0ec53afe9915..980ec2024b37 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -889,8 +889,8 @@ static u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
>   
>   static bool ath12k_hw_wcn7850_rx_desc_is_mcbc(struct hal_rx_desc *desc)
>   {
> -	return __le32_to_cpu(desc->u.wcn7850.mpdu_start.info6) &
> -	       RX_MPDU_START_INFO6_MCAST_BCAST;
> +	return __le32_to_cpu(desc->u.wcn7850.msdu_end.info5) &
> +	       RX_MSDU_END_INFO5_DA_IS_MCBC;

Please note that RX_MSDU_END_INFO5_DA_IS_MCBC is to notify if the DA 
address is mc/bc while RX_MPDU_START_INFO6_MCAST_BCAST is to inform
if the RA (addr1) is mc/bc. Both may not be used interchangeably, for 
example if we want to enable PN replay check for mc/bc frames we need
to use RX_MPDU_START_INFO6_MCAST_BCAST. You can probably define a new
call back for da_mc_bc check instead of modifying the same callback.

Vasanth

