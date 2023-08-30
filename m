Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB52F78E149
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 23:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbjH3VQO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 17:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjH3VQN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 17:16:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0403FC
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 14:15:39 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UEgr0B021818;
        Wed, 30 Aug 2023 20:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4yxvoqNIOy1VStdPAKHxN6XviU4lL2CZh+DCGyCRMbE=;
 b=SlmE/jY047XB9YN/97BDdknzKVLN8uKZ9wh1SngbpXARUwJggEi0JU88nwdvTv3NBhme
 6bsU8KsGkUx6oV38VtJ3Agt8uWQxGWit1+YSiXt0RvZpQs8XMwVNJ6HpLLgPlbXx2KVL
 L6rZb2js7eonQoiGEJqTtEn8QM2RPPuteDW69y50F/g7jJ/Bh44S/q70LA3Pv8+dygL1
 ufB6V+rfCV+UKsoPelOEdoT9OEvb+JcqoTMkzyX/hrKlhZ5K9jjgjJwN7znuI0AZIeNM
 24u+CR760kQsbT9YvK0h3khHsDVt6m2HywDvgo88/U53UPMOWHJdrUEQLpIn/Jsx1nKK vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st3whs61h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 20:24:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37UKOce2007789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 20:24:38 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 13:24:38 -0700
Message-ID: <f57ab9eb-5f76-4adf-b31f-9d21d38d0217@quicinc.com>
Date:   Wed, 30 Aug 2023 13:24:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Set default beacon mode to burst mode
Content-Language: en-US
To:     Sidhanta Sahu <quic_sidhanta@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230830194617.26400-1-quic_sidhanta@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230830194617.26400-1-quic_sidhanta@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b4B0suDtvHU-LTcYR4nHatjfAz3K2DCv
X-Proofpoint-ORIG-GUID: b4B0suDtvHU-LTcYR4nHatjfAz3K2DCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/30/2023 12:46 PM, Sidhanta Sahu wrote:
> Currently, firmware does not like when beacon mode is set as staggered
> mode for more than one beaconing vifs. Beacon mode for multiple
> beaconing (transmitted) vifs are expected to be in burst mode. So set
> beacon mode to burst mode by default.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

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

