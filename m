Return-Path: <linux-wireless+bounces-30939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD631D39BFB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 02:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E99FA3004533
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 01:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2453D1F09A5;
	Mon, 19 Jan 2026 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="myYNhLUS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TXJGqus7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBD2A1CF
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768786467; cv=none; b=fYrK5mumWhEgB/W6yrNP+udqDEQo1P1cTDw7xO/RgY8ZIHVqmxDpvK2rdR5QSRbyJVxMC688Tkc4hj0Wa48tNr00FHpngFj8XZliQtNWD16rMxoug+dQ2rdOASWT90/DFoipIy+xPPegpEAdJqQnecjKgQyH8FHAxk5Gq1GX7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768786467; c=relaxed/simple;
	bh=N5uHfs6ZcdF+4EryWWhcGuHg+C+sHxM9bRx58GDOBw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZ7I7T8Vaat10wiHMWT0Pl5NHSygBzMKnZ3nG0zkYXQoblpmOoogtgyA8Y7YUoEqxNlpxW4Sn7wJa3Sw8CN0wUPUcbGQAWDojRJZN/m1uhB7VbadolJ5pVpfWsihoTdQiD999uT2BR2sOv97os6HBfhIiOSJ++BuUS1sUqDv+m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=myYNhLUS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TXJGqus7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60ICFRRo2309290
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 01:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hOvdQBWjYZXhCIlZ66x3GrM29+gZ2gMcRylv0MRQCG8=; b=myYNhLUSWKWQV6iq
	XUr3MoXG3IAjYcV666prFefSHXzxLoxVClBTwY9osmYFrba6o2pjD/4qytYKH7qT
	UKeNMl0bjCT+OhVgx20eS0dauXbx1rReNJf6lVLXqkJofovAe1x5jYqZvde+dEtq
	ufeLvGWCyCPsWpuWUikbU/WQ1dc7UYuj7gg0bjt2VXhqUuRxfRZRHurdsjghKnGN
	j3qKa9Hc5mPa7H/x+rYBvifzQjQjWayC2kaRzJ3g37mJ956cXn6diL8Cgh8w0Iub
	JHsRPr4hkLJT6O6z6dvkYNRV2VL+XF+h2EELno3m0QNSM/opLNsALo4G77q02z2G
	J4txag==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br3q9b3tm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 01:34:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7f21951c317so2555752b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 17:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768786464; x=1769391264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOvdQBWjYZXhCIlZ66x3GrM29+gZ2gMcRylv0MRQCG8=;
        b=TXJGqus7UOX5lF4D9Bmwuv63TGkMFBvC6CZgjegh7hNz8hoHkAWdKpuGRMePe/bIcZ
         21H6Dq6Rs4UW9d7qbCqwnBOXsJzpb8ErEHHFz4YBaXJU6fSOKFF8AaLPqOoOeUJ2W+sp
         nk5a0iWZIDxGKBDOYmGJF5otKavVBtzqoPF/+2jT6A6PWKhYof9UezSbYRWJ3PeldQrx
         /Kp2b78EmDdnrXYZPqJMs9BvceA+LXaaZRJreAMfVH59Q0AphGC3MX8Cv5M7fA3pGW3Y
         zytGYwjfCVY3DQmnrYW79hcU/7C0dGNHMDBrmUxRldwnGhMoz3nbNrHV5goTrCtg7Rvm
         8/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768786464; x=1769391264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOvdQBWjYZXhCIlZ66x3GrM29+gZ2gMcRylv0MRQCG8=;
        b=fOk+npoVjIGxBcP91isG1H6rfz8nbRP8FHhu1TGgp7pKJoSLuZzfMhtIwVmh9/27JQ
         gfzFlk4KR/gbxj8bQAem37L1UQ6jH/H5pClMT/daYhGgmn7HR7e7QJUY/lrxarZvDYQi
         MheWR2cow5cvpUn1jYx2AygaPe6fFF7v8Zs5WAMAm1Ij1eS27GkXOVsi5GoOumbXedYc
         lfRZT4gAvfQruPFePJvG+lzqk2qsDlIDUaCntf2g/5WS9lmf9CJ7ZSrMRFE6Q64hKd/k
         0GBEHWJMqWQCrOg1j0mcVzK4FyNDy4xOTQ1gRrkur294+dKn00ejVQ6YkHHLlK9W5Z81
         2O7w==
X-Forwarded-Encrypted: i=1; AJvYcCV3JZLBTO6hjI1sTiOPDc/6ODwntMiqxu9MmuA0wQOZZPNligVGr7PNdySurIJwcseGhhdvd0Bq2NTxEEuTCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4l6Q3Mm97/Di8iOiXqCTZXf9FDOUa2nGOlMAx1Y8bkmuELmja
	tpHdQrCnEk9wVnUBjqVNxKDid9Z3KhHGTRDDZqNHWyzbr7J3LdqMpddAe/sPUWbQIdficg9kWtB
	DloNQlN+pmuG2FXErmI2efWO41jxF6pH2TH6GIOYBToZEZs42AJYwW0pdTBpkK6lAOwKw4g==
X-Gm-Gg: AY/fxX4Oo30LxNcjccGjrx4aQ+ZehKoAqaUUCjIeHSx3z4Hs27D0peK0Tdr5kd/ltnu
	uTd4tfik5CA5TYZLYP1o6nyvVvBxA6GpjaVXVysaTc+5odCKp8vX4sVT9YeBichY/JFV99JwzUk
	zisK0xln18VlPuuTCI624l6m66AeJdJVnmc0328QXOeiBWFTuB34+A7zN2T5xSsu57TFgP/utuh
	Yu8BZOu4NDX9T2QoI+y6DToBz3ioF49ereqa3Cg+/Vy+mTfBd/UPL7v61qwfXqOi5s1dR9Zh5Yw
	+auP4Y0XrVf4H5uIzdBj39KqJSw1EwsrqQkHncq+xXsvSMr98CKpoVUQcM4SHfJnT9HuAghMDMP
	H/uuUxMKpiCynI0tNjgGWP5FW+7AJKFcGIOZC8rR5k9Z/+Ol143jgf6oBzDj0HRxAyewuf9a2hV
	kHlu7y
X-Received: by 2002:a05:6a00:1407:b0:81e:81fb:b391 with SMTP id d2e1a72fcca58-81fa181fee4mr8040797b3a.45.1768786464098;
        Sun, 18 Jan 2026 17:34:24 -0800 (PST)
X-Received: by 2002:a05:6a00:1407:b0:81e:81fb:b391 with SMTP id d2e1a72fcca58-81fa181fee4mr8040784b3a.45.1768786463569;
        Sun, 18 Jan 2026 17:34:23 -0800 (PST)
Received: from [10.133.33.36] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277a15sm7499351b3a.42.2026.01.18.17.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 17:34:23 -0800 (PST)
Message-ID: <4562bdbc-9811-4f73-bc4b-f5a62ba1c965@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 09:34:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-current 2/2] dt-bindings: net: wireless:
 ath11k-pci: remove obsolete firmware-name property
To: Krzysztof Kozlowski <krzk@kernel.org>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251214025230.716387-1-miaoqing.pan@oss.qualcomm.com>
 <20251214025230.716387-3-miaoqing.pan@oss.qualcomm.com>
 <fa997674-402a-41cf-9334-f7fc89ae5ebc@kernel.org>
Content-Language: en-US
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <fa997674-402a-41cf-9334-f7fc89ae5ebc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAxMSBTYWx0ZWRfX6xfuphjRSI0q
 cOmEtCiyKVG1dHW4bb/Qb054ZSs55HdkQJFk4MoC2k66LtPJUelvdNfGTsXaz3cSFdr39E2RFkS
 Omfeg01bXXc4zERjSTQwKZ1RO+MK/sEqRz5RVInPvaE24dcP8+MAWRx8a74L16NGMw8gcWF7HOl
 XDUYW34gn8EATbvpDtgQBJs56rzuoSrWTuKbmNGcDi/MSw8toChBADFVjtvXxoSB5RGbLOLRsYS
 WtU2o0N5c10vhrlKid/GqhHxfzshNBuActKD3eEXHuSEzsPEUuOPZDdbN1K7J5byvP/1AerQr5c
 +VQWy69AICt22F8Vbpsk0sEkhPJTkjoaVoexOXS1VivWzlzfDZ/RahtVTz9JmakvBGlaK1k7fbx
 CnFLVsV7xRHJZqw6PfcevsA1AaeEYzXNPWUqy7TgG1zm92n6cUKOwZ0jBn5ohVCcTzmw1Tg28Oz
 xJC7iu6FmMOM27bYrhA==
X-Proofpoint-ORIG-GUID: SiA_9NczH0df92r1meaP1rdXNRpuZynM
X-Proofpoint-GUID: SiA_9NczH0df92r1meaP1rdXNRpuZynM
X-Authority-Analysis: v=2.4 cv=dPurWeZb c=1 sm=1 tr=0 ts=696d8a20 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=a9Ey2deuWmHcFssUcOUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190011



On 1/13/2026 3:28 PM, Krzysztof Kozlowski wrote:
> On 14/12/2025 03:52, Miaoqing Pan wrote:
>> The firmware-name property was introduced to allow end-users and
>> integrators to select usecase specific firmware for the WCN6855.
>> However, specifying firmware for an M.2 WLAN module in the Device
>> Tree is not appropriate. Instead, this functionality will be handled
>> within the ath11k driver.
>>
>> The driver has removed all support for firmware-name, and no upstream
>> Device Tree files reference this property. Therefore, this patch
>> removes the property from the binding and marks it as obsolete.
> 
> No, it does not mark it obsolete. Point me to the place.
> 
>>
>> This is a DT ABI-breaking change, but safe since there are no in-tree
>> users.
> 
> It's not safe. What about my board using this WiFi? Or Mr. foo's board?
> 
> Still NAK, you did not improve it.
> 
> 

I think it’s necessary to clarify the background here. As you can see 
from the git log, all changes related to ath11k firmware-name were 
submitted by me, and the intention was to allow the lemans-evk, 
monaco-evk, and hamoa-iot-evk boards to specify dedicated firmware for 
the WCN6855 Wi-Fi chip. However, the Wi-Fi‑related DTS nodes for these 
boards have never been submitted upstream, because adding a 
firmware-name property for an M.2 device is not appropriate and would be 
difficult for the community to accept. Therefore, the original approach 
was abandoned.

The alternative solution is to propose a static lookup table that maps 
device compatibles to firmware names. As a result, we have not submitted 
any DTS patches adding firmware-name for those boards to date. This is 
why I believe that removing firmware-name from the bindings is safe.

If this explanation is still not sufficient, please let me know what 
additional steps are required for accepting these two patches. Thank you.

>>
>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 
> And that's a fake tag.
> 
> Rob never acked such patch! Adding tags for something completely
> different is not acceptable.
> 
> 
> Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml   | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> index e34d42a30192..653b319fee88 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> @@ -35,12 +35,6 @@ properties:
>>         string to uniquely identify variant of the calibration data for designs
>>         with colliding bus and device ids
>>   
>> -  firmware-name:
>> -    maxItems: 1
>> -    description:
>> -      If present, a board or platform specific string used to lookup
>> -      usecase-specific firmware files for the device.
>> -
>>     vddrfacmn-supply:
>>       description: VDD_RFA_CMN supply regulator handle
>>   
> 
> 
> Best regards,
> Krzysztof


