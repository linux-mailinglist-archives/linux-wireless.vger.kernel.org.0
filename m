Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37337707AB2
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjERHQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 03:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjERHQa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 03:16:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC11185
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 00:16:29 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I7FgSY017360;
        Thu, 18 May 2023 07:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VVJ1gn0Eq1ogzFXJs4dLGBVQAOgq4fU3KueXzNks620=;
 b=E7lXLaEGQA/x5ZBSbPyyCfXufNN/JGXj11E+B9B4JtIPxjOyoaoIfMBDOk74K1F5MBB2
 HBuH7EoRqvCsTnUNJX4otkHqvfzHEpOABGh3RFGR3gD69vbWdIVMBMSxDrRRu9Ez5zLq
 NO1Bku86xlN+tLJ3vxjCvBGtIugHLqJUbf7PGw0FA2eeXHQu0euLBeopoGPB0C0j7Lr/
 wPWmeKotni+5UdX8ae4aS676Ui82fFESTcqYYwvKKShNlaPBl75weU8MYMmiX6a6ArB6
 9nxP3n8hs7JGhMZ6lUAVHpZkuA9LpqpaS1vXDIaE4BhvohVQF9l24p8uWqcWTBd7Hnd2 RQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnb7h8ear-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 07:16:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I7GP4K010143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 07:16:25 GMT
Received: from [10.216.42.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 18 May
 2023 00:16:23 -0700
Message-ID: <bab80d1c-5ae4-546d-af1a-12d06b6a8d2e@quicinc.com>
Date:   Thu, 18 May 2023 12:46:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: ath12k: Avoid NULL pointer access during management
 transmit cleanup
To:     Balamurugan S <quic_bselvara@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230518071046.14337-1-quic_bselvara@quicinc.com>
Content-Language: en-US
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20230518071046.14337-1-quic_bselvara@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NgWqy3fjfbEybMNtXKTcAuJtkQMLa0hQ
X-Proofpoint-GUID: NgWqy3fjfbEybMNtXKTcAuJtkQMLa0hQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180054
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/18/2023 12:40 PM, Balamurugan S wrote:
> Currently 'ar' reference is not added in skb_cb.
> Though this is generally not used during transmit completion
> callbacks, on interface removal the remaining idr cleanup callback
> uses the ar pointer from skb_cb from management txmgmt_idr. Hence fill them
> during transmit call for proper usage to avoid NULL pointer dereference.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index d814d74bc168..a344211f5b53 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4443,6 +4443,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_vif *arvif,
>   	int buf_id;
>   	int ret;
>   
> +	ATH12K_SKB_CB(skb)->ar = ar;
>   	spin_lock_bh(&ar->txmgmt_idr_lock);
>   	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
>   			   ATH12K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);
> 
> base-commit: 610b78b97bad8f3e77c27a15e9a03cbbb4109697

LGTM
