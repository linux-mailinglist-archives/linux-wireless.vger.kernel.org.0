Return-Path: <linux-wireless+bounces-30712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E09D15204
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 20:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 338FA300F736
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC732470F;
	Mon, 12 Jan 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZA9Je4oq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PhfY1G6Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A423101C0
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247481; cv=none; b=aastAuF4kgWUkjh2ZUnGiEt/O9scWLoSdcLQNLqcgLyRUL/4kiSXbSgrZjBlgaQ1ivo09DkRDFuP/yfMrV3f4V4+OkVrTlOJvvRR8Fa3X5nNbRHUEML2xuxS0U5QEF4YigsAUansInd6581cv2zleouSkxaMTaVfNbQwz7f+fbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247481; c=relaxed/simple;
	bh=4Lu6pbEjxU9vVEUJ6IJCISofVK1ATmvsPJSfgIoGW8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odeJz2a2eS5skcBLjN1BhLhPFnh+HfDrt3+AwrwWY6NJJWzgNv7rarLb3vtJPbj3PkVkfORaeJNt/nkYphcap9FVvPrQbBEKSN7D46SaoiHU/5hhbq29AK7+fFUEbqEGf3SDXgsk4PdY0uv2Du0/w4bfP8CCplJY2ZSxy3XzlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZA9Je4oq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PhfY1G6Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CIfwwT2249973
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 19:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AyrQeNRGMKiWJm9jy2A0UK3uV8Lg7oA7wv2Q1YlslQE=; b=ZA9Je4oqZW40L1hB
	+78wHZw/b74HNB62MD4k0vJK0pyTwjMEDTuW2gjj3VM48Zjl6lRGWTwD6ngd9ksl
	PilZmg5s+d0GXyNkFfZ3t+5tFkmxki5jQRyZnvm01lcc3cg5RvrUUGQQvxs6XPuX
	tJDbn1ieTXQbgQvuzBifG2/KsURVdkjJ3z3EsDrLtIGjBijY+6d4wZ8Hcjn/axTP
	VyEovzbyIQkIeln0IYtKshzMmIIfjq/YJHivJ/dN8iavUc4+e/uZ15iHmrFXwltT
	Vsx41pi7wHh8gZw9ZkZJu08iGBmGT5G8zE6zsDldc6svK8L+TfS9uTLm4gVLdkPm
	lIOUMw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6fbr726-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 19:51:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ae25c02e7bso23199791eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 11:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768247479; x=1768852279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyrQeNRGMKiWJm9jy2A0UK3uV8Lg7oA7wv2Q1YlslQE=;
        b=PhfY1G6YcarV7W0WhwiRC8uArKlp6AjgnPrn3iDkiNNvx6+WD6fzdRS4FlrjWvMvQ4
         MWe+P28fl2VyrJmX75n61crJziQdZ8QMOYxjU5+PPpM7GblRFFUZg+x0f9KGl0HNlXST
         LEYryw1UMPeAtRnpwsRzCxF3kpNkux+FEa2mFMtYtR4wr39S80/qWGQLoy/pKpHGaakN
         eSALM175jmqeD0EnynE99V55i9Z8i/mjj4+ou9gn8OMlqsVNthaw0HOXuKmOpfxCUPrQ
         R4IHYA+LlWBOZBBkmyh3SMc7F1YE160isCFuXuJo/QZv7Q6i9XbtxRe5Qs0RhIBU2CHw
         FWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768247479; x=1768852279;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyrQeNRGMKiWJm9jy2A0UK3uV8Lg7oA7wv2Q1YlslQE=;
        b=HQVMTjANLwJQ69cyJmso91hzMIJ9oKpzQpyZHy4V23FStb92szU92HbP2KclYpVCCQ
         +XUQBg4/Oh45SNuxKwbmuSxum7vhQguqv8sYy8qPOrTJbmwQXBDpNQPJ9KXamgEk4cEl
         8LjC9m27vG44sNwfehfclqWaNHUCbUM7E7a1yD8aFZxROkV/CE8PsyVBMT7LVpvXvE0o
         MKGeMRql9IulIpIL2Z/YB271SeTm0tlBT2QFjORhMHR60l6xzRBZzQYxVmqFg7zeloQg
         ZmG9yXou06ISxzt262cDBivAc29aMjIaUhnhKnpJehgfEyqVwDmNBFZ2OLTexiHAkukT
         /P5g==
X-Forwarded-Encrypted: i=1; AJvYcCWtiZ8VwsgRFLX9cQcPOVxTDBmEp6ggOyCXq8YOz3GdNwRSfQhKBQSF1xX3OMeR+KNaAF7df+oiLcSRchmmzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YylBdxgRlUuYCW5NXNZ1abMEpYaooMNOcm+OgafCvPnRtg/SdXS
	kcjOFju5qYXxTccGKl+pCqI8Bjn7lB9mdR2HJXYQtJM5rfXEJO+EPRzNFXbHoV9MPffyQPs+IQb
	jWXVI3nyCEA7UZtqv452hLpXo+OtJCS+Kiz39C5emEc2StCtknJvbNxhctD1gUnq5rAoLvw==
X-Gm-Gg: AY/fxX4CojE/00bFQQep4HhD1fT+qZHZzczNsqjQttCcGsT3QvVvw0Ty5H7Jw2uI2ek
	MGpeabRWchxXRB2+TnWq4LwILCmkjovPIC/oWiQODEoluQXjvjUl1BaslDTUXatM/RuneqM3FII
	L+f9OSV1HWG1CUxssaAnO7tMFvEg/p7tuxgZBZSsL0HFrhfcHHyOe+8oUgJxLYkNqPKIasf0JFp
	TzGJxVaJOxZWWPDgkt9jHGT4aUZ/YjvPcZvO/41RAqqXci1+Lrqkg49EuD3NAB5NF2vzuRcr3zW
	dHf0UVvUjib2voWZQ+xQ4p1xxqqWJfIaFNLU/fys5VaTzsCpSXYaVePHOhWz6uaEOYf3praoEce
	sOkUiFlL09fQCnKOfqB2ICacl2IKzhTbv5Wbre0t3mfru4sitUyloiZ9xgLSq5jGs9rYqNMSo0I
	+0
X-Received: by 2002:a05:7301:490b:b0:2ab:9f55:d15a with SMTP id 5a478bee46e88-2b17d318ccemr12574111eec.29.1768247479044;
        Mon, 12 Jan 2026 11:51:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk6xYB4ZRN+cIwyeLW8/iG9JuwoV/B2OUgags4UdIMA807zGQKH2Qblcn9/Gn+mcQnl8ucdA==
X-Received: by 2002:a05:7301:490b:b0:2ab:9f55:d15a with SMTP id 5a478bee46e88-2b17d318ccemr12574098eec.29.1768247478533;
        Mon, 12 Jan 2026 11:51:18 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d76aasm15520905eec.33.2026.01.12.11.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 11:51:18 -0800 (PST)
Message-ID: <0ad4722d-1557-4d8d-ae45-c0fdf893067f@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 11:51:16 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current 2/2] dt-bindings: net: wireless: ath11k-pci:
 deprecate 'firmware-name' property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
 <20251204071100.970518-3-miaoqing.pan@oss.qualcomm.com>
 <f60bc80d-a947-4083-9e14-000a937de412@oss.qualcomm.com>
 <76d1c3ad-d648-4719-b016-1f16b195e64c@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <76d1c3ad-d648-4719-b016-1f16b195e64c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE2NSBTYWx0ZWRfX3t/tDVEqSQ3q
 uWeIqN1CZDP2PSg9HUpQPGPGFOStL3x2Kx66YlLeNG4J2jkOkZ49KFxZnaSb/MBI656miOMvk4K
 WNyPyvhk/1G2VZwg5X3qJKDyDPLAiOOMRy0f2UFkWyKEPk9Frjrpo79kRhSiU7MR96PSFM6QTMW
 nJY2+DQtytQZ9haxrB49mORnpgyKDvGbh7NHw+C5a8yXbuLrkHbU03s69MoAKb9TIaEUQrX0QMn
 sA66IgsNcWentRyOawOQgsdnO/pzwlhjlIq0SBMg2xHyyRu0SL3vO2eLyur4DNv4rRh8mrVXZ7e
 6735xYMJt58ZyyiSHuJZ8TRUqeWlSuDEq2XheuscBSWl7JXaxNNawDTL6wj0mtROGEk5HNcWdZN
 SxiUxyznG+m9szhAhlzJ2BXzG3QmnF7ds3K0B2yyy2vT5C8TeYAvkPAcpvpN3ht7AEVdZtoRNH2
 rwnwn4VsMCJfdwL22hg==
X-Proofpoint-GUID: q75qVidlHIk7b80ElLS4AFG0Mt2rtRse
X-Authority-Analysis: v=2.4 cv=ZrLg6t7G c=1 sm=1 tr=0 ts=696550b7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=V5SxF7jbE5cyk4fQ5xYA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: q75qVidlHIk7b80ElLS4AFG0Mt2rtRse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_05,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120165

On 12/11/2025 7:23 PM, Krzysztof Kozlowski wrote:
> On 11/12/2025 17:44, Jeff Johnson wrote:
>> On 12/3/2025 11:11 PM, Miaoqing Pan wrote:
>>> The firmware-name property was introduced to allow end-users and
>>> integrators to select usecase specific firmware for the WCN6855.
>>> However, specifying firmware for an M.2 WLAN module in the Device
>>> Tree is not appropriate. Instead, this functionality will be handled
>>> within the ath11k driver.
>>>
>>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>>> ---
>>>  .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>>> index e34d42a30192..0162e365798b 100644
>>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>>> @@ -37,6 +37,7 @@ properties:
>>>  
>>>    firmware-name:
>>>      maxItems: 1
>>> +    deprecated: true
>>>      description:
>>>        If present, a board or platform specific string used to lookup
>>>        usecase-specific firmware files for the device.
>>
>> The driver patch completely removes support for this, so is this really
>> considered deprecated? Or should this actually be considered obsolete and
> 
> That's silent ABI break. I will formally NAK the patch.
> 
> 
>> completely removed?
>>
>> Do any DTS files actually reference this?
>>
>> /jeff
> 
> 
> Best regards,
> Krzysztof

Krzysztof,
Can you check the v2 to see if you still want to NAK?

https://msgid.link/20251214025230.716387-3-miaoqing.pan@oss.qualcomm.com

Thanks,
/jeff

