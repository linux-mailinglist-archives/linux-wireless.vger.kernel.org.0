Return-Path: <linux-wireless+bounces-14896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA6F9BBD6D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 19:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0015E1F23823
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E71CBE8B;
	Mon,  4 Nov 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hpEfNnLm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5351C4A1F;
	Mon,  4 Nov 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745906; cv=none; b=lqW7SEv7kwX+TGDK23CiOvDrA35nWh9oitFlyOOWOkeT3y1pGESFnX9dlvT25yFOh0UBP1zujBnzAQgRPC7j1cFy1lMDE602qrNsdMtRKdZ1txRh2jywd3D66cLgHios5WLy2KiWWRg/WeWuCMyinNA8ycMp6k6BhCLGvJ1I+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745906; c=relaxed/simple;
	bh=cGfS1wEE+stDuU+Je6YO8Qvw5hRFhHUIGUGDv/UCH74=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=EPNnZvT3EeCTO8DFtThjw1Lc6nytoiR2vHY9BUfMKd0qTvlDQ2QFD+qGKZav7X2v6Yg6++bxnyvt0JKXOK7RCRs19+3Hs8NOtzYl561/HzdWQBZHc4h7L54Ze3BHQQV5RCRcNcpoiSkFoXk09iiAOOX2eVps/3RuhuAF6+zjh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hpEfNnLm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BuUHx019557;
	Mon, 4 Nov 2024 18:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+EKER39zPEEyrog9bTlCNvHU3yEaS6S/WnsUz/voEIE=; b=hpEfNnLm+CNWHZFX
	FLdGIc4hSjOhEcLsdThb7HmS2VXnFQhdD01ipaIe06srmuqDZ1ht5J4lK3UDeST6
	L2BqEiXd/N5KVfaPow2cw1Nw3ILlwkB+25X08NakFGJqq/1dfNCSq6S84YHK9Lam
	pEuLP6J+M6f6h/48R6AK4wOHSFzcQ20b3fr4wlzhBwl7wpje07e+I++ftcd/uBH1
	U8Lz4puZE+ADlOVsFCOOScvuB85sdSq+psXfPRpfo+fy3JdZBVWv8ZG5GEPXu+VV
	IDXJjUBg3390u1j0KJH2YslnDVzHA++x5mSqZzoVesZdF4TjE63X6Jxd7JkFlP2A
	o2f/Kg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42p5ye3b0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 18:44:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4IiuS5010046
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 18:44:56 GMT
Received: from [10.216.7.198] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 10:44:51 -0800
Message-ID: <cb69c30f-8230-4a8f-a538-3ec964b79084@quicinc.com>
Date: Tue, 5 Nov 2024 00:14:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: net: wireless: ath12k: describe
 WSI properties for QCN9274
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
 <20241029173050.2188150-2-quic_rajkbhag@quicinc.com>
 <764f8f22-146d-4edc-9d46-7fe3c7d9a2f2@kernel.org>
Content-Language: en-US
In-Reply-To: <764f8f22-146d-4edc-9d46-7fe3c7d9a2f2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0oQN_Dq4FfIAfAQUG9kFWelPC3LdiSAV
X-Proofpoint-GUID: 0oQN_Dq4FfIAfAQUG9kFWelPC3LdiSAV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040153

On 10/29/2024 11:22 PM, Krzysztof Kozlowski wrote:
> On 29/10/2024 18:30, Raj Kumar Bhagat wrote:
>> QCN9274 device has WSI support. WSI stands for WLAN Serial Interface.
>> It is used for the exchange of specific control information across
>> radios based on the doorbell mechanism. This WSI connection is
>> essential to exchange control information among these devices
>>
>> Hence, describe WSI interface supported in QCN9274 with the following
>> properties:
>>
>>  - qcom,wsi-group-id: It represents the identifier assigned to the WSI
>>    connection. All the ath12k devices connected to same WSI connection
>>    have the same wsi-group-id.
>>
>>  - qcom,wsi-master: Indicates if this device is the WSI master.
>>
>>  - ports: This is a graph ports schema that has two ports: TX (port@0)
>>    and RX (port@1). This represents the actual WSI connection among
>>    multiple devices.
> 
> Describe the hardware, not the contents of the patch/binding. We see it
> easily, but what we do not see is the hardware.
> 

sure will update the commit log.

>>
>> Also, describe the ath12k device property
>> "qcom,ath12k-calibration-variant". This is a common property among
>> ath12k devices.
> 
> Why do you describe it? What you do is easily visible. We do not see why.
> 

will remove this description in next version.

>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>  .../bindings/net/wireless/qcom,ath12k.yaml    | 241 +++++++++++++++++-
>>  1 file changed, 232 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
>> index 1b5884015b15..42bcd73dd159 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
>> @@ -1,5 +1,6 @@
>>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  # Copyright (c) 2024 Linaro Limited
>> +# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>  %YAML 1.2
>>  ---
>>  $id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml#
>> @@ -18,10 +19,17 @@ properties:
>>    compatible:
>>      enum:
>>        - pci17cb,1107  # WCN7850
>> +      - pci17cb,1109  # QCN9274
> 
> I asked for separate binding because it is quite a different device.
> Unless it is not... but then commit msg is quite not precise here.
> 

sure, will create a separate binding, may be "qcom,ath12k_wsi.yaml".
This will be for ath21k PCI device with WSI interface.

>>  
>>    reg:
>>      maxItems: 1
>>  
>> +  qcom,ath12k-calibration-variant:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 

thanks will remove "|"

>> +      string to uniquely identify variant of the calibration data for designs
>> +      with colliding bus and device ids
>> +
>>    vddaon-supply:
>>      description: VDD_AON supply regulator handle
>>  
>> @@ -49,21 +57,100 @@ properties:
>>    vddpcie1p8-supply:
>>      description: VDD_PCIE_1P8 supply regulator handle
>>  
>> +  wsi:
> 
> Not much improved here. I asked to drop the node.
> 

In next version will remove "wsi". The properties under wsi (ports,
qcom,wsi-master, etc) will be directly under ath12k device node.

>> +    type: object
>> +    description: |
>> +      The ath12k devices (QCN9274) feature WSI support. WSI stands for
>> +      WLAN Serial Interface. It is used for the exchange of specific
>> +      control information across radios based on the doorbell mechanism.
>> +      This WSI connection is essential to exchange control information
>> +      among these devices.
>> +
>> +      Diagram to represent one WSI connection (one WSI group) among
>> +      three devices.
>> +
>> +               +-------+        +-------+        +-------+
>> +               | pcie2 |        | pcie3 |        | pcie1 |
>> +               |       |        |       |        |       |
>> +        +----->|  wsi  |------->|  wsi  |------->|  wsi  |-----+
>> +        |      | grp 0 |        | grp 0 |        | grp 2 |     |
>> +        |      +-------+        +-------+        +-------+     |
>> +        +------------------------------------------------------+
>> +
>> +      Diagram to represent two WSI connections (two separate WSI groups)
>> +      among four devices.
>> +
>> +           +-------+    +-------+          +-------+    +-------+
>> +           | pcie2 |    | pcie3 |          | pcie1 |    | pcie0 |
>> +           |       |    |       |          |       |    |       |
>> +       +-->|  wsi  |--->|  wsi  |--+   +-->|  wsi  |--->|  wsi  |--+
>> +       |   | grp 0 |    | grp 0 |  |   |   | grp 1 |    | grp 1 |  |
>> +       |   +-------+    +-------+  |   |   +-------+    +-------+  |
>> +       +---------------------------+   +---------------------------+
>> +
>> +    properties:
>> +      qcom,wsi-group-id:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          It represents the identifier assigned to the WSI connection. All
>> +          the ath12k devices connected to same WSI connection have the
>> +          same wsi-group-id.
> 
> That's not needed according to description. Entire group is defined by
> graph.
> 

So this mean "qcom,wsi-group-id" to be dropped and we can assign the
group ID (in ath12k driver implementation) by using the graph?

>> +
>> +      qcom,wsi-master:
>> +        type: boolean
>> +        description:
>> +          Indicates if this device is the WSI master.
>> +
> 
> This copies property name. Why being master is important?
> 

The master device in the WSI group aids (is capable) to synchronize the Timing
Synchronization Function (TSF) clock across all devices in the group. Will include
this information in next version.

> Also, use some different name: see preferred names in kernel coding style.
> 

Thanks for pointing out, will use "qcom,wsi-controller"

>> +      ports:
>> +        $ref: /schemas/graph.yaml#/properties/ports
>> +        description:
>> +          These ports are used to connect multiple WSI supported devices to
>> +          form the WSI group.
>> +
>> +        properties:
>> +          port@0:
>> +            $ref: /schemas/graph.yaml#/properties/port
>> +            description:
>> +              This is the TX port of WSI interface. It is attached to the RX
>> +              port of the next device in the WSI connection.
>> +
>> +          port@1:
>> +            $ref: /schemas/graph.yaml#/properties/port
>> +            description:
>> +              This is the RX port of WSI interface. It is attached to the TX
>> +              port of the previous device in the WSI connection.
>> +
>> +    required:
>> +      - qcom,wsi-group-id
>> +      - ports
>> +
>> +    additionalProperties: false
>> +
>>  required:
>>    - compatible
>>    - reg
>> -  - vddaon-supply
>> -  - vddwlcx-supply
>> -  - vddwlmx-supply
>> -  - vddrfacmn-supply
>> -  - vddrfa0p8-supply
>> -  - vddrfa1p2-supply
>> -  - vddrfa1p8-supply
>> -  - vddpcie0p9-supply
>> -  - vddpcie1p8-supply
>>  
>>  additionalProperties: false
>>  
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - pci17cb,1107
>> +    then:
>> +      required:
>> +        - vddaon-supply
>> +        - vddwlcx-supply
>> +        - vddwlmx-supply
>> +        - vddrfacmn-supply
>> +        - vddrfa0p8-supply
>> +        - vddrfa1p2-supply
>> +        - vddrfa1p8-supply
>> +        - vddpcie0p9-supply
>> +        - vddpcie1p8-supply
> 
> Commit says WSI applies only to new variant, so properties should be
> disallowed... or just follow my feedback last time: separate binding.
> 

Sure, we will have separate binding in next version.

>> +
>>  examples:
>>    - |
>>      #include <dt-bindings/clock/qcom,rpmh.h>
>> @@ -97,3 +184,139 @@ examples:
>>              };
>>          };
>>      };
>> +
>> +  - |
>> +    pcie1 {
> 
> pcie {
> and keep all nodes here
> 

sure

>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +
>> +        pcie@0 {
>> +            device_type = "pci";
>> +            reg = <0x0 0x0 0x0 0x0 0x0>;
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            ranges;
>> +
>> +            wifi1@0 {
> 
> wifi@
> 
> Same in other places.
> 

Thanks, will update.

>> +                compatible = "pci17cb,1109";
>> +                reg = <0x0 0x0 0x0 0x0 0x0>;
>> +
>> +                qcom,ath12k-calibration-variant = "RDP433_1";
>> +
>> +                wsi {
> 
> No resources here? Not a bus? You already got comment about it.
> 

sure will remove wsi node and directly define ports and other properties
inside wifi.



