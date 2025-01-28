Return-Path: <linux-wireless+bounces-18074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570CBA20EE5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 17:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9357A4412
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD83199E88;
	Tue, 28 Jan 2025 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DCI2rwHq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF02904;
	Tue, 28 Jan 2025 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082805; cv=none; b=QUkbjiUWBW65a3mz9p+6GtnUE51RU0JkszVSVZtrfQl4G+U5ZVG7oCYpmpo14vQEEBng4LnpRFsxvXeEvtMwoLpRpeD1pScccJaydv19+1ByUXpWgd8xtePfELMubmThkjaSqwnsLCBXnzBDE0NMKIjQVBxM+Rlaiz478XLwrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082805; c=relaxed/simple;
	bh=JYOVQnyo0ahIAz2q7Kcd4sGIB3IeZB+FU/ghOBR59GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oGmv+Ve6zN1MJEtL1gICft8HtD7YUQIDViIum2Hwl4D3jf9QeAiXxCEzWdO1LkU13owR0s0M0gjzyDtyhTvMy9zoBnJ74E2lifR2GXmT+7/g5YpxLCLWdwlYU/qWVfMM7ebnsZEjmYhCyPkHyJn5P4x28b5ecyWu3kJDYr1OL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DCI2rwHq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SAT6jS000946;
	Tue, 28 Jan 2025 16:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1cOivfFeB/eUmYrh4Uon3OR3ZvdSfHGK9cXmoZGGBSc=; b=DCI2rwHq8tQoYzfj
	zRaYCPJR5uVLKRRtqOCvYXIeRrwLBpvXEMAHgxAt++RmubPgcs+VnKLGYvITPuun
	KoRZinkwdiXsrnPftI+brN3Ii4jtAds1HyzGkYUxzpBJfdv770r8kkg2p/lT1NC7
	c5RzETz8uzaI/KxA0KXJpyctQ1RJbXU+xT30dC6WFBT4rRG2MQ28uaKYbziSCzHw
	zwCAHY5VaIkLqVJs/7U4JLpe0Tw7NXRH2fsbXUkUs6/fjqV7fwkFiAzE58Q/YH0k
	IcQ6vSQjQM3pldTHid5wZLd8ukYNu7nqlJA4xd/jWHSCwo9Qcajs1wD8uHu/py2W
	z9e4EA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ewh48wak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 16:46:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50SGkcYN018843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 16:46:38 GMT
Received: from [10.216.5.143] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 08:46:33 -0800
Message-ID: <ae712489-3268-4786-9f4f-c30d53d324d6@quicinc.com>
Date: Tue, 28 Jan 2025 22:16:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: add wifi node for IPQ5332 based
 RDP441
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
References: <20250128091012.2574478-1-quic_rajkbhag@quicinc.com>
 <20250128091012.2574478-3-quic_rajkbhag@quicinc.com>
 <b3ff05c1-6424-4ace-a873-ddf1a0d3d07d@kernel.org>
 <a752a135-9cd0-402b-b0fb-967491cfdaee@quicinc.com>
 <7d23afc2-ccb0-4a57-afcc-c5ac01013ea2@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <7d23afc2-ccb0-4a57-afcc-c5ac01013ea2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 00P8SaYMGofXQseVz_j9om20SrWwWXvr
X-Proofpoint-ORIG-GUID: 00P8SaYMGofXQseVz_j9om20SrWwWXvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280124

On 1/28/2025 3:54 PM, Krzysztof Kozlowski wrote:
> On 28/01/2025 10:41, Raj Kumar Bhagat wrote:
>>>> +
>>>> +	reserved-memory {
>>>> +		#address-cells = <2>;
>>>> +		#size-cells = <2>;
>>>> +		ranges;
>>>> +
>>>> +		q6_region: wcss@4a900000 {
>>>> +			reg = <0x0 0x4a900000 0x0 0x02b00000>;
>>>> +			no-map;
>>>> +		};
>>>> +
>>>> +		m3_dump: m3-dump@4d400000 {
>>>
>>> This fails with your wireless patchset.
>>>
>>
>> Yes, this will fail with v4 wireless patch.
>> We have v5 (yet to be sent) to read the correct reserved memory. Since,
>> in v4 I was asked to address and send DTS patch separately, The corresponding
>> driver patches are yet to be sent.
> 
> 
> So you send it to prove my point? OK, fine. So this patch confirms your
> driver changes should be rejected.
> 

There seems to be some confusion here.

Based on the comments in v4, as quoted below:
"Please post the updated DTS in a separate series after fixing all the issues
pointed out by the DTS coding style."

I understood that you wanted to review only the DT-related patches first
before the driver implementation. Hence, this is posted separately before the
v5 driver is posted.

If I misunderstood, please let me know. We will continue with v5 of the original
series 'wifi: ath12k: add Ath12k AHB driver support for IPQ5332'. The v5 will
include dt-binding, driver, and reference DTS as well.

>>
>>>> +			reg = <0x0 0x4D400000 0x0 0x100000>;
>>>> +			no-map;
>>>> +		};
>>>> +	};
>>>>  };
>>>>  
>>>>  &blsp1_i2c1 {
>>>> @@ -63,3 +104,16 @@ data-pins {
>>>>  		};
>>>>  	};
>>>>  };
>>>> +
>>>> +&wifi0 {
>>>> +	memory-region = <&q6_region>, <&m3_dump>;
>>>> +	memory-region-names = "q6-region", "m3-dump";
>>>
>>> Binding said you have four items. I don't understand why this varies and
>>> why this is 2 items instead.
>>>
>>
>> In total we have 4 items, with minItems as 2.
>> The other 2 items (q6-caldb & mlo-global-mem) functionalities are not yet enabled
>> in ath12k driver. Hence these memory are not reserved yet.
> 
> That's not a valid reason to skip valid items. DTS is not dependent on
> driver. Submit proper hardware description, not something carved to
> match your driver.
> 

Sure, we can have all four reserved memory sections in the DTS. However, ath12k
will not use all four reserved memory sections as of now. Once the functionality
corresponding to q6-caldb and mlo-global-mem is enabled, these reserved memory
sections will be used.

In that case, we can also drop 'minItems' to 2 in the binding?

