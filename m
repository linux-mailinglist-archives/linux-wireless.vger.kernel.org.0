Return-Path: <linux-wireless+bounces-14516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 637089AFF51
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E794F1F23210
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E3B1FCC65;
	Fri, 25 Oct 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G3TRUDix"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578D1F81BD;
	Fri, 25 Oct 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850409; cv=none; b=qk9+ZqLQ/3exMfJqS/S2+ffTKQFqODw2rkdDeftHHoG+hM3UwPNLa5Tj68itJs6pP2E+hdntJn48YcVp1tME8XHBJLSt6XkQmLBuDDa62PhveHGDDdZHB/4u9boC9fuaVlv6c+36j03WMYu1I2dCG23uewIbqheIQUaTT7sXr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850409; c=relaxed/simple;
	bh=XFCPTdOf7277mkxyNqBln5PHSUltz8Pj1c1bIAULRes=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a1ZecXkoDCSmzQ5vCxmZIAFYP4WP05jxpPT/q8x0iY332iCUEpDJy+IPv0jK8KnV+AWh7BO2A1kU6DphwvUfs6273QLwyN25e7YZyVZC7EFF4RnqddxRjsy1tgxLEwQ3CPgNrVOgoM3mEB1nv4smXf6IiEIKa89ihkXCM9PuiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G3TRUDix; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P1BrSe004522;
	Fri, 25 Oct 2024 09:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PwYWGdB45qg/3CamTEfHajoG/yYk5oPu6x2vS9FthPY=; b=G3TRUDixCpwVp/37
	eY2953pgVDCWctZFVnwujl30TbLM7k3Hpsf5X5T4RnafIpoMNhu8okxsTXNwk/y1
	WFn3/aBkknSS119Y6ZoozDkRlKhQuCoAVRiKmdzjmepTwiuQ1eZ01SQlln8iMuwZ
	opeAR+8ovLlW90i/jyerf9H7yz3zct9ylkgXNnQyY1m0aGNvIrTZzQIj/0To82K1
	xfJ1IgfY9n1Gu15hNJYtx5Tf04Fz2TV8hFpz+/dHp1081Ss8AFMkym6hG2nF6+vE
	eAQG6JQ547jiV/YHfQcmVMeu70uFlldtEHCUYeLJOgLM8a3jStv6MQo9uz0lW+Gu
	VoIvFA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em688g37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 09:59:57 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P9xua0011713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 09:59:56 GMT
Received: from [10.151.41.25] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 02:59:52 -0700
Message-ID: <b2a18ac5-727d-4f5b-9465-c360e6432dc5@quicinc.com>
Date: Fri, 25 Oct 2024 15:29:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] dt-bindings: net: wireless: update required
 properties for ath12k PCI module
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
References: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
 <20241023060352.605019-2-quic_rajkbhag@quicinc.com>
 <87db3d68-ab1a-4cc4-9857-416de39cea0f@kernel.org>
 <e2c1ce1a-89af-4feb-a21a-9ca2578430e7@quicinc.com>
 <b97b8350-3925-40b0-8f87-f89df429a52a@kernel.org>
 <e7b27f57-efb2-45ea-bbe0-e5aeb90cbff9@quicinc.com>
 <606083d8-4332-45e4-be41-08ca5425cc03@kernel.org>
 <94defe49-c87a-44f6-8768-03f3d6687ac3@quicinc.com>
 <50c0f184-030b-4a19-bf8a-077505170f03@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <50c0f184-030b-4a19-bf8a-077505170f03@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DTVJxZ-XF8nN1HLYhmgfBnExrhPnEtDh
X-Proofpoint-GUID: DTVJxZ-XF8nN1HLYhmgfBnExrhPnEtDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=533 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250076

On 10/23/2024 5:38 PM, Krzysztof Kozlowski wrote:
> On 23/10/2024 12:28, Raj Kumar Bhagat wrote:
>> On 10/23/2024 12:29 PM, Krzysztof Kozlowski wrote:
>>> On 23/10/2024 08:53, Raj Kumar Bhagat wrote:
>>>> On 10/23/2024 12:17 PM, Krzysztof Kozlowski wrote:
>>>>> On 23/10/2024 08:45, Raj Kumar Bhagat wrote:
>>>>>> On 10/23/2024 12:05 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 23/10/2024 08:03, Raj Kumar Bhagat wrote:
>>>>>>>> The current device-tree bindings for the Ath12K module list many
>>>>>>>> WCN7850-specific properties as required. However, these properties are
>>>>>>>> not applicable to other Ath12K devices.
>>>>>>>>
>>>>>>>> Hence, remove WCN7850-specific properties from the required section,
>>>>>>>> retaining only generic properties valid across all Ath12K devices.
>>>>>>>> WCN7850-specific properties will remain required based on the device's
>>>>>>>> compatible enum.
>>>>>>> Just not true. These apply to all devices described in this binding.
>>>>>>>
>>>>>>> NAK.
>>>>>>>
>>>>>>> Don't send patches for your downstream stuff.
>>>>>> This is not for downstream. This series is the per-requisite for ath12k
>>>>>> MLO support in upstream.
>>>>>>
>>>>>> In the subsequent patch [2/6] we are adding new device (QCN9274) in this
>>>>>> binding that do not require the WCN7850 specific properties.
>>>>>>
>>>>>> This is a refactoring patch for the next patch [2/6].
>>>>> It's just wrong. Not true. At this point of patch there are no other
>>>>> devices. Don't refactor uselessly introducing incorrect hardware
>>>> Ok then, If we squash this patch with the next patch [2/6], that actually adding
>>>> the new device, then this patch changes are valid right?
>>> Yes, except I asked to have separate binding for devices with different
>>> interface (WSI). You add unrelated devices to same binding, growing it
>>> into something tricky to manage. Your second patch misses if:then
>>> disallwing all this WSI stuff for existing device... and then you should
>>> notice there is absolutely *nothing* in common.
>>>
>> I understand your point about having separate bindings if there are no common
>> properties. However, the title and description of this binding indicate that it
>> is intended for Qualcomm ath12k wireless devices with a PCI bus. Given this, the
>> QCN9274 seems to fit within the same binding.
> Feel free to fix it. Or add common schema used by multiple bindings.
> 
>> Additionally, there will likely be more properties added in the future that could
>> be common. For example, the “qcom,ath12k-calibration-variant” property (which the
> You are supposed to add them now, not later. See writing bindings. They
> are supposed to be complete.
> 

Sure will add "qcom,ath12k-calibration-variant" in next version.

>> ath12k host currently doesn’t support reading and using, hence we are not adding it
>> now) could be a common property.
> What is "host"? Either the device has this property or not. Whether host
> supports something does not really matter, right? You have hardware
> property or you have it *not*.

Ah, my bad. I meant to say “ath12k driver”.

