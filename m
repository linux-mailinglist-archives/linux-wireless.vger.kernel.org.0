Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0B95AA735
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 07:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiIBF0Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 01:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbiIBF0W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 01:26:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7274A65816;
        Thu,  1 Sep 2022 22:26:15 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2823Oqna023061;
        Fri, 2 Sep 2022 05:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7jAlRj3PYriaEU9vEl69b11OtzITxYbCjvSmlmGJzFA=;
 b=SodWcd7F/mnQpsTjPPrV8pktah2RrD5SMv0vd6aY9EyZIxVx+ULgv6pOtMkHVemrU2KE
 3j5aHEYs/TYfOzwKHZIKZfZHHy26XLDm6NKHKRR6t4spbtwx2j2sCwea5z1d0T9zwBrq
 qaEVKB/9jfBg533GyOrCbDPl7B+qVHRZazi0YY20mjrHx/wkRWm5oe2gFkhVFVUNpJG1
 +ZXvUInQoHPXZUPikHuQfq/Lzxz33WTsP2fxtWem+8MH6la39W7X0UKqTAF65Hj0D0jr
 B9S8eKLAyRUzTNG7AappOKUsO2TOZXucfG7lG/3KeYPdhKR3CLrCOeXOpGWwLIHEqRKM Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jarc83kr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 05:26:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2825Q1l6010111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 05:26:01 GMT
Received: from [10.216.33.176] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 22:25:59 -0700
Message-ID: <e76d9de6-e1a2-148f-15c3-0883622c5e46@quicinc.com>
Date:   Fri, 2 Sep 2022 10:55:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] dt: bindings: net: add bindings to add WoW support
 for WCN6750
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
References: <20220829124323.26874-1-quic_mpubbise@quicinc.com>
 <20220829124323.26874-2-quic_mpubbise@quicinc.com>
 <3b169ca3-2962-339f-c8cb-c48ac41c9aa5@linaro.org>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <3b169ca3-2962-339f-c8cb-c48ac41c9aa5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pCnEztbE5GP_FkWlpWFV7GK8dxmsuMDS
X-Proofpoint-GUID: pCnEztbE5GP_FkWlpWFV7GK8dxmsuMDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/30/2022 10:55 PM, Krzysztof Kozlowski wrote:
> On 29/08/2022 15:43, Manikanta Pubbisetty wrote:
>> Add required bindings to support WoW (Wake on Wireless) for
>> WCN6750 which is based on ath11k driver.
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> 
> Use scripts/get_maintainers.pl to CC all maintainers and relevant
> mailing lists.
> 

Sure, I'll take care of this going forward.

>> ---
>>   .../bindings/net/wireless/qcom,ath11k.yaml      | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> index a677b056f112..307a5b9d1588 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>> @@ -66,6 +66,14 @@ properties:
>>       required:
>>         - iommus
>>   
>> +  qcom,smem-states:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: State bits used in WCN6750 to signal the firmware
>> +                 to exit from WoW.
> 
> You need to describe the item (s).
> 

Okay

>> +
>> +  qcom,smem-state-names:
>> +    description: The names of the state bits used for SMP2P output
> 
> You need to describe the item (s).
> 

Okay

>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -410,6 +418,13 @@ examples:
>>           };
>>       };
>>   
>> +    smp2p-wpss {
>> +        wlan_smp2p_out: wlan_smp2p_out {
> 
> No underscores in node names. This example is incomplete and I am not
> sure what is the benefit of adding provider example to the consumer
> binding... Just skip it.
> 

Understood, I'll make the changes.

Thanks,
Manikanta
