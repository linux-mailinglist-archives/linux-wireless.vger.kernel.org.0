Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3391792ECB
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbjIETY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 15:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjIETY2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 15:24:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C280E10C3
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 12:24:12 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385HN4lL001227;
        Tue, 5 Sep 2023 18:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iAi8u8zQIjOkxgowa2A9ZQ3QoTAvWBnfwkqUcTHHkvw=;
 b=ZgWghoRIbB/LM6FSK2nJJhNrFnapxEngxfsEyaejG2IUNkEoNfLcjcgLQw5ekgq2p5jv
 zoDmwT9RDZfvhfkwj5QB0Klj2my11nnoj9mqyaL1rDzTHPXIcu02Y49uYK24KBaLkY4h
 k1rMyEBnlPoJ71e6QLY1e6ZmaLqifekv0GpPotoidDHq7KNf+rO1nm/2+6rEdMBLPhvw
 THz1uLDwRuIRZ7BapDW1zmBOjv5CNYMtVWB0baGD8SWlF6n5xXqOpWJOXVbLEaaEkBVb
 5jplkJ25IeG8H/zf3EejMNMkxzNr7BbeEz8W7Y/IV9Tx5kTHJphoRDQ22ONnt0HlTUwC Tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3swpr6j8fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:28:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 385ISpke002765
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 18:28:51 GMT
Received: from [10.227.111.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 11:28:51 -0700
Message-ID: <bddf5e10-fe6d-4e7d-b4f0-49b27db3f3fd@quicinc.com>
Date:   Tue, 5 Sep 2023 11:27:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Set default beacon mode to burst mode
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230830194617.26400-1-quic_sidhanta@quicinc.com>
 <d4ea2c1b-a142-1ce6-9566-7f501a30f533@quicinc.com>
Content-Language: en-US
From:   Sidhanta Sahu <quic_sidhanta@quicinc.com>
In-Reply-To: <d4ea2c1b-a142-1ce6-9566-7f501a30f533@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lq_6abZaATkADSgjfQU5LlqiFsW6-89U
X-Proofpoint-GUID: lq_6abZaATkADSgjfQU5LlqiFsW6-89U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309050160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/30/2023 8:49 PM, Aditya Kumar Singh wrote:
> On 8/31/23 01:16, Sidhanta Sahu wrote:
>> Currently, firmware does not like when beacon mode is set as staggered
>> mode for more than one beaconing vifs. Beacon mode for multiple
>> beaconing (transmitted) vifs are expected to be in burst mode. So set
>> beacon mode to burst mode by default.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c 
>> b/drivers/net/wireless/ath/ath12k/mac.c
>> index 1bb9802ef569..b16cbc3c906d 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -2314,7 +2314,7 @@ static void 
>> ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>>         if (changed & BSS_CHANGED_BEACON) {
>>           param_id = WMI_PDEV_PARAM_BEACON_TX_MODE;
>> -        param_value = WMI_BEACON_STAGGERED_MODE;
>> +        param_value = WMI_BEACON_BURST_MODE;
>>           ret = ath12k_wmi_pdev_set_param(ar, param_id,
>>                           param_value, ar->pdev->pdev_id);
>>           if (ret)
> In else part, we have a debug print. IMHO that should be changed too. 
> Please check once.
>
>         else
>             ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
>                    "Set staggered beacon mode for VDEV: %d\n",
>                    arvif->vdev_id);
>
> Could you check once?
Yes, Will change it in next version.
>
> Aditya
