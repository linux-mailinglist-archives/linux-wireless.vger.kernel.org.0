Return-Path: <linux-wireless+bounces-28990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4269C5E993
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AA694E2BA5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C339B337680;
	Fri, 14 Nov 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EaLiE5v0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZnGrmIg3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC333A021
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763141392; cv=none; b=DEb6Rl3ORGh2utlrhMFqm7sj6+mHNjv4iUtoG/ZcwY7DUw7Mid9aA6mOa2iG+xHpcAQbtqq/2XGZ8sAs9ZgnI3ha9IP6K6exAn1Diadct6HrWTeoj+bmwzuXkPZ9Ke2mZBh5FWQiTnff7ItE+tKwc1vCjtP1O3I6q0VYD/atD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763141392; c=relaxed/simple;
	bh=Bxj0CYVXHy/ry1+iDrsNRfoPOFrAUdLRt1mSPe788Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhM+xBlStDzdBmjXxqGv+PUwcJJcy1aYpJtyfzCO26u6Nvt8HzwB74+2eJ0eaEzwHSJpzUtG/kkTtuk/Bune3CE6wPVjoZPyGVUDb21t6V0kYXnBNWfyReuTj8Nt8FFetAj2eLfV6iq8tDSp+WQ9jCnl4dFiSBWgsltKZ6+RqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EaLiE5v0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZnGrmIg3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEHSoIB120611
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 17:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5IZF97taFsnmh5b8jmQL9+OMw+OoZEfr16LawJYCtrc=; b=EaLiE5v06eBoNWRH
	8f56DbeDfkYWz3OMQBUgnuNoeXpa4G65cGHMTg9RxojgAFMuFkYgwuidOeagGRXc
	RVSnIxxvJJN+VugWx4yAZnSlaqeW2iwL606y7mSR+t3Mdx8+XXBJmUwNK4CHqbqA
	d2uU7vQYBnkKWfNYTNX/9E1kiOf8BkJuxj8jznKreL37Kk1N+5llyRfaGL+DQINS
	ip4JRKdc5lwg5cC6q2sZslmo/CNfsYEivSETJR+Hz4Q/ks+VsDrPTLDGQvkhXAlN
	PCWDo1WqvwywPl/lNl7LJX/P/qVy8fZZh9elm/WwXLKYZbPQI8VJ3tflDRCUNsCW
	JyJ6yA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ae7pj07c2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 17:29:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-295595cd102so52526835ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763141389; x=1763746189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IZF97taFsnmh5b8jmQL9+OMw+OoZEfr16LawJYCtrc=;
        b=ZnGrmIg3ahx5c1N1+FXNtD/Cer3Cobpi9K4gsG3JC7X7MrKy+IbFu7QllVP4nYfFIv
         6C0PNuY+36WfBpyC+SP2XGvzGTsq+LmVDgqP8EJ3oAFToYfGjoZUcJg8cK5NHPvsTsqU
         7oFilJJr1Dv6upDsSh09zckpRLa6FYUU6cIcG/xL8UZbbzucZ+7AbNprvD5+ZavCy44U
         su9onxvJ4nKeWdMIgxM699MANK2gglJl3kuvC1i39nRL7LEB6PDkh4Lpi8XEAYo7spsM
         bxOCN/6m4yZvssADMnPgKq83XXTrLeQQiOW5/js6tsUReWh81+UECz+wlPE40ziS51rR
         HU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763141389; x=1763746189;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IZF97taFsnmh5b8jmQL9+OMw+OoZEfr16LawJYCtrc=;
        b=HO6MTCzdEpBQdtKbF8YguMJsNBmpdjjOTNvMY3GEygD0pjz3fod17nvJKtm6RZ/jni
         dElCxvldzjlyYzfrVtyT1QfuNvDudwCT89Kf3iXWejfff7BEPXzHZRhraBFw6CSBi5uU
         NgdhBYco75htTAKnRqg1ToOIKy1E1XL26l8oC/vlg8Y4v7M5CToREJ4N/OQ0QSlobNo+
         onFfeS8cTDjCuDbnE62PZiQDVOupsPDgXJX+EZEPnDUXWR/PWpmCiFG6wOy+29Rxac9l
         zWqSHkt2fAqnzD1dHKHclWbGKZOFwid3LfJpJmY6d3pGWQduDBbIbvvRYxMiswlnt7tW
         YVsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXASYWUxT7Pj+u5xmUk/mpQZhfWGFq8dUOtfY+PBaaL25kxEtU3BGKeRW5OS2EKVFKhcg3ORUqXY71yowPVUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87/6F6j2SGm85wRcG4PhzZ24az6SUQLewjIo6H8d+UTbR1ZkG
	jyajo1dyaGqEMqsA5ObaLTzL22El1qTlWK01H7ZFEAa+Dplr/pgIj1KBSGHVRpM6qi0CcyMv/Zz
	UIvl3q0kkNYzj2qGk2duLialT1P5cZfapEs6DBhqGdRoWRtNIJihVxRawu+1nDoowAYDZYA==
X-Gm-Gg: ASbGncsfjrds6STG3OsyutttC8ZLLe9iiN1JeDFrhWdlaG3fskmo8Qy1A6pKB5lD2MA
	dfX5XV0dwJ4AQq93ZMAYpR90a2HVOIrvOzAgVOVOMWNiOlWR0XFdTWYpPH6V6nIcd8xOBiGo8HE
	kjgH5dnxMspDEpyf5lwvyGqgA2IsstZnYqImg1vlfIco1FuFGlzJQIOIUFG3yLXY5+dmRVYPuJX
	vkiWsobFv+VvGlNXAmw1PVFayJZbcoKLL+KVyr1xBt6TxRJbH1h3bd8/ySNF8m8LiUAfd+t0Mr5
	r0Uxz6zrhPustgKWdTePfrCbFr/KLL+S7lyWkd5UIHC/AVlqHzdbVBtnYnrrIRPjbXS+ElyxnJ7
	9cphbD4Y4dD11kvyZ1za9sxyO6wJzYAo/16SPVYskPJbiqGZYRr9e3QdOoliCKqfiwhRD/0Rbel
	nm
X-Received: by 2002:a17:902:f705:b0:295:9871:81dd with SMTP id d9443c01a7336-2986a6f3f40mr46121015ad.25.1763141388603;
        Fri, 14 Nov 2025 09:29:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5PNiK7CQR10eCNgq3oo/oD5kyy0U8463HcRT84zlTmppSmWLyBUIeJxcQWwOn0JbTobSH0g==
X-Received: by 2002:a17:902:f705:b0:295:9871:81dd with SMTP id d9443c01a7336-2986a6f3f40mr46120635ad.25.1763141388095;
        Fri, 14 Nov 2025 09:29:48 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c24941csm61501935ad.41.2025.11.14.09.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 09:29:47 -0800 (PST)
Message-ID: <7757501b-2576-4f5d-a16a-40e06f12cb5f@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 09:29:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: wireless: ath: Deprecate
 'qcom,calibration-variant' property
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
 <20251114-ath-variant-tbl-v1-2-a9adfc49e3f3@oss.qualcomm.com>
 <b9b4f1bb-45ef-404e-b75e-962e85a557a2@kernel.org>
 <fmumja63j3xvbvfxlmtnkfubgw4jwo5f43srrpfgqrxyqknrj4@izsqazgbiehp>
 <1703d8d7-5105-4585-b8f0-82bb54809718@kernel.org>
 <kve3f7zkywwsfkylom3jp4e3ejlspnlvnmlkuq77uy6fqsy5dt@gaitvppj2jcw>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <kve3f7zkywwsfkylom3jp4e3ejlspnlvnmlkuq77uy6fqsy5dt@gaitvppj2jcw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XhFeZnN8ednz8EdsqZ43_x128wRjPfUt
X-Authority-Analysis: v=2.4 cv=Z53h3XRA c=1 sm=1 tr=0 ts=6917670d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LHIKCdfOQfCGPyi8WdcA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: XhFeZnN8ednz8EdsqZ43_x128wRjPfUt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDE0MSBTYWx0ZWRfX4Qb/oangTQ8T
 FfDS/6qe6NHXOvkxovNRbmBRIhWC+vKUe4/FjJJWE+O11ZO3eZxSVqLPFFKQ7wqksML9XhU4wWJ
 M2jWnidRbIVNGsW/Vyzjfo53WdTs41X28LfxFOzGtaBd6vIPrgikIuWwcHIAPdrbF+6ImtbxmS3
 F8afTUS1PBouzR+u9NlgL5pPV+SP4edrygLYQSyU96z6AZ3oXVXaFlFiB4h05jorTtReNoSgwLo
 fI1izLb7KZPcuMzV9XzoOD9oNIF+coGAtKJLDxzV5DYaaO04KS2v2NRdbgd516a+8mwqziGIodP
 JiZfjNIvzLVKNe/XRVGmV0MQUUYyBKx/pAYh1XSKiX/2b5pItAkUf1lDx9qGvLFwaCyOzJrI4LH
 +soVz9Mt/GLO1MI55M2HkQdc/15epA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140141

On 11/14/2025 3:18 AM, Manivannan Sadhasivam wrote:
> On Fri, Nov 14, 2025 at 12:04:55PM +0100, Krzysztof Kozlowski wrote:
>> On 14/11/2025 12:02, Manivannan Sadhasivam wrote:
>>> On Fri, Nov 14, 2025 at 11:47:25AM +0100, Krzysztof Kozlowski wrote:
>>>> On 14/11/2025 11:22, Manivannan Sadhasivam wrote:
>>>>> On devicetree platforms, ath{10k/11k} drivers rely on the presence of the
>>>>> 'qcom,calibration-variant' property to select the correct calibration data
>>>>> for device variants with colliding IDs.
>>>>>
>>>>> But this property based selection has its own downside that it needs to be
>>>>> added to the devicetree node of the WLAN device, especially for PCI based
>>>>> devices. Currently, the users/vendors are forced to hardcode this property
>>>>> in the PCI device node. If a different device need to be attached to the
>>>>> slot, then the devicetree node also has to be changed. This approach is not
>>>>> scalable and creates a bad user experience.
>>>>>
>>>>> So deprecate this property from WLAN devicetree nodes and let the drivers
>>>>> do the devicetree model based calibration variant lookup using a static
>>>>> table.
>>>>>
>>>>> This also warrants removing the property from examples in the binding.
>>>>>
>>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> The problem - visible in one of the examples here - is that one board
>>>> has multiple WiFi chips and they use different calibration-variant
>>>> properties. How do you find the right calibration variant for such case
>>>> based on board machine match?
>>>>
>>>
>>> I suspect the legitimacy of the example here. I don't understand how a single
>>> machine can have same devices with 3 different calibration data.
>>
>> Me neither but I am not the domain expert here.
>>
>>>
>>> AFAIU, calibration data is specific to the platform design. And I don't see any
>>> upstream supported devicetree having similar properties.
>> Deprecating these is fine with me, but I would prefer if we get here
>> some clear answers that mentioned case cannot happen. If you are sure of
>> that, please mention it in commit msg.
>>
> 
> I'm pretty sure that this example is wrong. But I will wait for Jeff or other
> ath developers to confirm.

As discussed privately this is a valid example. This is a single-band chip. So
a tri-band router platform will have 3 boards, one that is supporting 2 GHz,
one supporting 5 GHz, and one supporting 6 GHz, and each frequency range will
have different calibration data.

So we still need to support slot-specific configuration in cases where the
slot to board mapping really is fixed in the platform.

/jeff

