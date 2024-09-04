Return-Path: <linux-wireless+bounces-12476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CACB96BA9E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 13:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013BC1F20CD4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE91CF5C5;
	Wed,  4 Sep 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m9zRjv1I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C11CF298
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449325; cv=none; b=AsikR5yISy8boPc8l3+ey8wZ9zMRekFMfiHd8j2ia5nA4VUydf+h1uDXVNfyuvk9w13GGMJ8wKnYLfNv0+G4TE204uiXVsQr67BOpQDrfBk2lX5hHvACa6+DMoCHa4a/XlwqEYIyKKi6+SMX0S038uIh7vUi34HmpAHhNZ4uvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449325; c=relaxed/simple;
	bh=uJC4OSRKni2/TYin5U6GuDXtc3Fay3pCxYsqUKknc58=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tRwYUPXsto4A8ySY0imShka89q6U2B1SH5AJ+T9EnY+534bdaGGja9PpPPAhOTSNTDUwbA1awxCl/pVQ5yLI21T7uCTZ6Onts/Wwd0FP7vIAXYiPoSd7o6lzAdfpiORtOV04nR7i2xGBE8wc3uHsttQDiTK/pZZ79Mk6SO8xngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m9zRjv1I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4844XqBf010436;
	Wed, 4 Sep 2024 11:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xjkb3QG2bFTs2HAj7L2XMWiq7Muv4WQK1R9pqJf6Ak0=; b=m9zRjv1Io2/+2RpJ
	HTlMI+3+j3C5jlvDnS2HQZE/2CQnFV31ifL5Ltqp2hiv+SI3DCvTE1QqlVyvWG5s
	VFJy59Txkgrl4DMImCmq8eRCV6kQQsmA6z1v+wcRbkaP2qQXkMzaB6NYpFbtAFlv
	GiCM/f7rfib/G62VeoyNMm4vUibGxKo2iIFwNma+Po+iCdcyL/Gyx/8ITFJ+q4b0
	6gKTaP1P1Z8AsfV7e7H/e9kAhHj/DnOB6aAJPIf1zbFZe1ic27V9oN4xFe4DozuF
	twzvnv5YD+/gWQ6nFDpWA+0i/1vwemFIefIHM8+NdF5f1DglLTbmXciioqc3Txpc
	2gWilg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41egmrh0k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:28:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484BScpn013546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 11:28:38 GMT
Received: from [10.216.28.224] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 04:28:37 -0700
Message-ID: <9e40f028-dc71-41cb-a5ac-772ef91129ac@quicinc.com>
Date: Wed, 4 Sep 2024 16:58:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/18] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
 <20240814094323.3927603-2-quic_rajkbhag@quicinc.com>
 <6a740dee-464a-4a10-9c25-ee6f0d22b279@kernel.org>
 <cecf0e32-b84c-423e-89c3-61eab9f1928a@quicinc.com>
 <1e2a2974-b78b-483f-9190-34d5dae69f7d@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <1e2a2974-b78b-483f-9190-34d5dae69f7d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7saOCANniRwpVAMd4bGUcS32u0Bbju3T
X-Proofpoint-ORIG-GUID: 7saOCANniRwpVAMd4bGUcS32u0Bbju3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040087

On 9/4/2024 1:08 PM, Krzysztof Kozlowski wrote:
> On 04/09/2024 09:23, Raj Kumar Bhagat wrote:
>>>> +  qcom,board_id:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description:
>>>> +      Board id value, it identifies the variant of ath12k WiFi device.
>>>
>>> Please do not upstream whatever you have in your vendor tree... You even
>>> copied its style! There is no such property in upstream.
>>>
>>> NAK, you are duplicating compatibles.
>>>
>>>
>>
>> qcom,board_id is a new parameter introduced to distinguish between different variants
>> of ath12k devices that share the same compatible value. This differentiation is crucial
>> as these variants have different qcom,board_id values (with the same compatible) based
> 
> You must explain why compatible cannot be used for that.
> 

The compatible property is used to define the variant of the Ath12k device. However, the
Ath12k device variant does not change with different capabilities or configurations
(e.g., operating band). The qcom,board_id parameter is introduced to define these
configurations, not the device variant itself.

>> on WiFi frequency bands capability. For example, 2 GHz, 5 GHz, 6 GHz, or multi-band
>> variants of ath12k devices have different qcom,board_id values.
>>
>> In the next version, I will include the above information in the qcom,board_id
>> description.
> 
> Please follow DTS coding style. And style of existing properties like
> this. Did you look for them? I claim you just sent whatever you had in
> downstream.
> 

Checked "Devicetree Specification, Release v0.4", section 4.1.1,
seems "_" to be avoided for property name and hyphen "-" to be used. Also, qcom,board-id
is already taken in "Documentation/devicetree/bindings/arm/qcom.yaml". In the next
version will change this property name.

> 
> Best regards,
> Krzysztof
> 


