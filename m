Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A94378E523
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 05:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbjHaDtp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 23:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345918AbjHaDtn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 23:49:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E925CE0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 20:49:40 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V3T6hk010219;
        Thu, 31 Aug 2023 03:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=S5a+p5gZ9WGY6cPpibnn508ey6Pe9M/v0/ucEDU3wzw=;
 b=hLK5Z4R+4gr3UnxZWI/3J1gRBQ/Pma9Mm+tiw4ldSlfwglnZtIUn9F7FoptOYH2ySpBC
 H+wPWUt9g2VgB9BXzgFpYyhk+TtVIerW6F9ay0Cwo3OjnUxqFb/vqIFWJMe+rpdWEWpQ
 yQ2O0nxiBdV6AGXyI5Ca4Oc4+WbD1iYfJyJGt5iDoYW+X1RYPxRiJx29wl5FsD7M/BtB
 qX0mN1mWsbVzcs+GUBipliAYNhYqTy+Yi+HwA8tDA2+++SMO3Znbr6DHZYmCl1ITDB8B
 WqTtx2pRIozYLA0M2hCsiBm4qVgz4rkneEZo/UHsa1cL4V3aGVcOHLUo7Ijol8zDPLZC Mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssmcvba8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 03:49:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V3nYJ9001476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 03:49:35 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 20:49:33 -0700
Message-ID: <d4ea2c1b-a142-1ce6-9566-7f501a30f533@quicinc.com>
Date:   Thu, 31 Aug 2023 09:19:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] wifi: ath12k: Set default beacon mode to burst mode
Content-Language: en-US
To:     Sidhanta Sahu <quic_sidhanta@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230830194617.26400-1-quic_sidhanta@quicinc.com>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20230830194617.26400-1-quic_sidhanta@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 86A2kBCTxcumMdbK4HzuZV-gMxTYF29H
X-Proofpoint-GUID: 86A2kBCTxcumMdbK4HzuZV-gMxTYF29H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310033
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/31/23 01:16, Sidhanta Sahu wrote:
> Currently, firmware does not like when beacon mode is set as staggered
> mode for more than one beaconing vifs. Beacon mode for multiple
> beaconing (transmitted) vifs are expected to be in burst mode. So set
> beacon mode to burst mode by default.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 1bb9802ef569..b16cbc3c906d 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2314,7 +2314,7 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>   
>   	if (changed & BSS_CHANGED_BEACON) {
>   		param_id = WMI_PDEV_PARAM_BEACON_TX_MODE;
> -		param_value = WMI_BEACON_STAGGERED_MODE;
> +		param_value = WMI_BEACON_BURST_MODE;
>   		ret = ath12k_wmi_pdev_set_param(ar, param_id,
>   						param_value, ar->pdev->pdev_id);
>   		if (ret)
In else part, we have a debug print. IMHO that should be changed too. 
Please check once.

		else
			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
				   "Set staggered beacon mode for VDEV: %d\n",
				   arvif->vdev_id);

Could you check once?

Aditya
