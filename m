Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4361B7AB29F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjIVNZW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIVNZV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 09:25:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307BBCE
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 06:25:15 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MBTDYs019375;
        Fri, 22 Sep 2023 13:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=70eCGEBkn8Zebosxnq21A/1BJKgdyXbyLOT6ZT0QK64=;
 b=LoRApp6wNaJHFPkGRGUUr82ZMlqV6X/KD+DnCddYtGDqghoX57rt1yblvD1JOL6w8Y6A
 x+c5yPt9NJWBi+VNf5OeaV4VWpUAsdegH8PvWHBuJhn0F4LCzG8k3+zGlNaXCzCBZtj1
 kALa5CnR3GUgFVA445POrF4DYUP7ydZ+HlrtLTJ6qx/fZcrpsLp//9YTjgHBSRYsVeUo
 2JHTfYDWsvoveb/YAFw0wwjPoKz6WktFC7cVwAnX480/mNYaJ15BRWbq7kmhZR5LS7kh
 exJk/zv3iV5cu2U+MI8SpF6wjoF/VCRThG9vqFZLAhabSpR4TAbGguxn5lkTEWe0YDcE hA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9a3e886u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 13:25:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MDP8xK006385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 13:25:08 GMT
Received: from [10.216.13.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 22 Sep
 2023 06:25:06 -0700
Message-ID: <60aaa1fc-99cf-476c-af51-e5ad425792f9@quicinc.com>
Date:   Fri, 22 Sep 2023 18:55:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/13] wifi: ath11k: send TPC power to firmware for 6
 GHz station
Content-Language: en-US
To:     Wen Gong <quic_wgong@quicinc.com>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
 <20230920082349.29111-14-quic_wgong@quicinc.com>
 <eb08e0f2-c932-4d79-b2ee-813c2999d1a5@quicinc.com>
 <fbad2af6-9c3f-c241-b820-7820b4200bf4@quicinc.com>
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <fbad2af6-9c3f-c241-b820-7820b4200bf4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aNl11cgHOBgzZKDwDorLgPEXrr5_wSX3
X-Proofpoint-GUID: aNl11cgHOBgzZKDwDorLgPEXrr5_wSX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_11,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/22/23 15:42, Wen Gong wrote:
> On 9/22/2023 5:24 PM, Aditya Kumar Singh wrote:
>> On 9/20/23 13:53, Wen Gong wrote:
>>> When station is connected to a 6 GHz AP, it has 2 way to configure
>>> the power limit to firmware. The first way is to send 2 wmi command
>>> WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G to
>>> firmware, the second way is to send WMI_VDEV_SET_TPC_POWER_CMDID to
>>> firmware which include more parameters for power control.
>>>
>>> The first way is disabled in previous patch
>>> "ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for 6 
>>> GHz".
>>>
>>> Prepare the parameter for wmi command WMI_VDEV_SET_TPC_POWER_CMDID and
>>> send the firmware after vdev start response success from firmware, it
>>> is for the second way of power control.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI 
>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>>>
>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>> ---
>>>   drivers/net/wireless/ath/ath11k/mac.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c 
>>> b/drivers/net/wireless/ath/ath11k/mac.c
>>> index a8ae281d2635..f8b907a758b1 100644
>>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>>> @@ -7296,6 +7296,12 @@ ath11k_mac_vdev_start_restart(struct 
>>> ath11k_vif *arvif,
>>>           return ret;
>>>       }
>>>   +    if (ath11k_mac_supports_station_tpc(ar, arvif, chandef)) {
>>> +        ath11k_mac_fill_reg_tpc_info(ar, arvif->vif, &arvif->chanctx);
>> So we are passing local copy of channel context stored in 
>> arvif->chanctx. Do we need to update it when channel changes?
>>
>> I see that during assignment time, we are copying/updating it and 
>> accordingly the command will be sent to firmware, but what about when 
>> STA moves channel? arvif->chanctx should be updated and tpc command 
>> should be sent again in that case?
> 
> This has been discussed before here per question of Johannes:"Could this 
> information change? Should we track it in beacons?":
> 
> [PATCH 9/9] mac80211: save transmit power envelope element and power 
> constraint
> 
> https://lore.kernel.org/linux-wireless/38e7d9d2eebafa7245a36a0a0396094526eb3efd.camel@sipsolutions.net/
That's fine. That's w.r.t to TX power change. I'm saying here about CSA? 
What when AP tries to switch channel? For that client need not 
disassociate and associate back right?

In that case, channel context in mac80211 layer will change. But our 
driver's arvif->chanctx will have previous one only. We are using 
channel context to get the ieee80211_channel which has the PSD value, 
and that value we are sending to firmware via TPC command during intial 
association time. So when channel changes, firmware also should be 
updated with the latest PSD values via TPC command for the latest 
channel right?



