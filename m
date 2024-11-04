Return-Path: <linux-wireless+bounces-14897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9DC9BBD8B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 19:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943CE1C21A8C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 18:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755801CB9E5;
	Mon,  4 Nov 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D+91PJ0A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B418622;
	Mon,  4 Nov 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746524; cv=none; b=QVunBhdxCo9m2lUObxwnWisfdGjzxkttPoRNsRVMt2oCKDzZWQRMe+R+MF1fv9MKGwTRvs2RDjPXp9LzsvuDqinRLoiDZY7xSlr/9H+uwvt3QKfaZfah+GSMfXw61yl2uwx2RZKNQltWE5v/640j/cjh3T2LNZ8qJX9XnSwJ/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746524; c=relaxed/simple;
	bh=sAVXfE+viSyvyyb4ZsPNYrVskuTdS5aiXCQOI2NGJf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=irqZ+XVHBUhnx1XZBfs6F36XrgaXVH19ZijlDYnctzfQOfAqwWQZukay1U5SekrjZjm2bLSt5H+FL1e055u5KPdqpVBiYcUqJisLpkalCBSqDs3Vu1fKNMl5P5KUOEZD4dvCHLEmxTOjCaQjSHeEciFqi7Y15BgqTBNqmII6c4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D+91PJ0A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Bj2UP027157;
	Mon, 4 Nov 2024 18:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EnzS8YCHDwGTykF7cqgVjEldgKDqxW3aidPt90wH09U=; b=D+91PJ0AwEv1Tw2P
	EzvBll3qLGS+D6UmAcOQ4MjGRs/NRYKLxKqpywKd9+sU4hbSMp/qRpIltYy4FK4A
	V2VehFRREqPKG7Hk7JzqGGLjzxC150xvCNGhY1d+PmHzz5bAN04syd/SZ2fxGWPd
	kTPdPSu7fJRSTZN1+9M4/EF4MApN7uYe9LAj1Yvbmc4WVKXjFqszXN88giZ8Doi/
	AcD1kDdsqfwxVsZ4I2zWlbNdIwP3pamSCPnJM+rV4RS8Ca/enNxiEqiBR2exATuD
	i+RskwNWGEnu//DN/O3mwCg/2CpBtxGr0e6c+sE2Uh5AlFyWIyMrChXpqMB0JmGv
	zJ0E4g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ncyxw630-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 18:55:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4ItEYB030484
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 18:55:14 GMT
Received: from [10.216.7.198] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 10:55:09 -0800
Message-ID: <b8054e94-1ea4-4d39-8050-2f3ddd0a8b3f@quicinc.com>
Date: Tue, 5 Nov 2024 00:25:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: net: wireless: ath12k: describe
 WSI properties for QCN9274
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
 <20241029173050.2188150-2-quic_rajkbhag@quicinc.com>
 <4d273cac-8955-4850-bd8a-0bad318c1e4f@quicinc.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <4d273cac-8955-4850-bd8a-0bad318c1e4f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kkVYawqLpV08D4dHjeKgglZUYSoOEZOB
X-Proofpoint-GUID: kkVYawqLpV08D4dHjeKgglZUYSoOEZOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040155

On 10/31/2024 12:34 AM, Jeff Johnson wrote:
> On 10/29/2024 10:30 AM, Raj Kumar Bhagat wrote:
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
>>
>> Also, describe the ath12k device property
>> "qcom,ath12k-calibration-variant". This is a common property among
>> ath12k devices.
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
>>  
>>    reg:
>>      maxItems: 1
>>  
>> +  qcom,ath12k-calibration-variant:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: |
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
> is there a reason to not have these in some order?
> 

This could be made in same order. In next version will update.
But in actual hardware the pcie and wsi connection may not be same order.

>> +               |       |        |       |        |       |
>> +        +----->|  wsi  |------->|  wsi  |------->|  wsi  |-----+
>> +        |      | grp 0 |        | grp 0 |        | grp 2 |     |
> s/grp 2/grp 0/???                                          ^ typo?
> 

Thanks for pointing out, this is a typo. will update in next version.
>> +        |      +-------+        +-------+        +-------+     |
>> +        +------------------------------------------------------+
>> +
>> +      Diagram to represent two WSI connections (two separate WSI groups)
>> +      among four devices.
>> +
>> +           +-------+    +-------+          +-------+    +-------+
>> +           | pcie2 |    | pcie3 |          | pcie1 |    | pcie0 |
> again seems strange to not have any logical (to me) order

Will keep this example diagram in pcie order in next version.

