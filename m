Return-Path: <linux-wireless+bounces-30981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3417D3BCDB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 02:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F00E93025F83
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 01:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B46A14F112;
	Tue, 20 Jan 2026 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fglNsu1x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YO/3nEHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2404594A
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872686; cv=none; b=eHrSj31k2OpwSFtYZCnrnBUwk7gkNjCYlfpUtDAo9vL7uTI39xYmxlIX6JUA2WvuyxCvQInTBrixXr4x5vvXuP6+eEx60tqCh9W04EGWQLfFNms7xGaVwyD2czvYiCLMBGs0/y9SDTeNbaKfB3k9EV7AL/kDmg0RJZuEb68nBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872686; c=relaxed/simple;
	bh=iAKS1BK4j28Ya31b7iHmEe0ZkpwIHwD1S1jU2XOOoMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9Ol+OLpQ5/wRC0uXEHLpli+iBOt6fWW9r/7LvNm9rNdI9eN7s96FR+ONYzM2cGZY2VUvVcokL+KGnwF301r8sj/kvJdJUqZEEGo94NKku3FW4Am2wCM7+ldpsIClZM+kXOEYCbgEfWUyQpKg5lnuugENd+bRVDN9+IzXTTbdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fglNsu1x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YO/3nEHd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JNQcos3709998
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 01:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lo5hkEABfahVXNweqbZswU7f6XJxKtIJQAc9Kau6Vco=; b=fglNsu1xx7wBnxIn
	y0Fv+ZhZgmJ8iEygf6IQeDMsnCOGPkAUs0nDdUB0xn2IpPAJHjOvLgmH0EmO52a0
	WspeH9MxVHIwYl740X/caX4ZC8wHteL5z7chIqErgd3MQzGhZaAkguBggyfTWb/1
	hASotFtnW5pe/QoXriTExcxYBLOu1uG+fJwSxRXqt5h78fDbdm25NrXJIwdxvSBB
	+8ztFrjIJe3EdoEF5enrZE3qtVceplbXYGnTHFPih6Pc1UplVEmNLqgtCzYrmWRD
	cW1PM/NhFoQAvc5dV/H8rr+6+T6ARJZ0qJgdNGZBym3gO7R2NAv+2ZNVD6PKaM0D
	8WBuEw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgmuajqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 01:31:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c5539b9adbcso6946418a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768872683; x=1769477483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lo5hkEABfahVXNweqbZswU7f6XJxKtIJQAc9Kau6Vco=;
        b=YO/3nEHdsj/XWNmomv+l5dYQX+xDtIoUUQkKH9CvZ2RY/9XVzbZWKalR6HY644wlFj
         GFfv1j7ghfpBWJkMzjjZBRyG9O4yjOcFrMMu6FE71xmKORXLe47/WroC91ZlRAzd+Vwo
         OTPRJvvXYF2pCbMRD9zzDGaizaeOYUxUpiHyjeAlwAbC1oc7i8ldx/mw6QWcA/QZQDte
         YvwSKtvDNT9dXumj+SJo0SdLktxhjyJ9CTUxHJFQqvzXUglTcGlwg8VRwRMmO+1goxdz
         dugjH0SXzil16wFRNtiWcQnZXNwVbLzd4tqenafuaMkEWblivkAYseK9UBwrGizEWTYh
         zTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768872683; x=1769477483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lo5hkEABfahVXNweqbZswU7f6XJxKtIJQAc9Kau6Vco=;
        b=HWQaPqw1TApSPRncJ58BCOTKAZEWlzviAsRdN5/MuQGq3kpOMR2arYUnISiESixem6
         wjhb5IDLZTgWgB6Xx5DS/gl50DULvBZyfD9xZ7QziuR+7+jFwj61VVMvH46r7g2wCwCD
         MGazTZEA5bcGRUFkkdCoGliCIJtyHxhyuPuXp+ihM2RfUKiT/2jPQjVhy4EwLaWG3R1o
         kVOPacQHrr6QV8OIFC4w3RByih7KwMTWse7U0BAHQaIWe4cP9OjF8jgpQlyFJirsIu4d
         wUvni4qy1TYtyrcZM7mPJebiLNv6ao0kaHVXIGpSP8+wRjAq8B1s6n4mL6IlL0dzTsYr
         3u0w==
X-Forwarded-Encrypted: i=1; AJvYcCXVzwWxPNtvJUKSDk1If5UiEYfdGQP6co8srEbgo5nsPUApadtQxQo22E2aJQhQY/ZElFwI4zmFXZ1+RRjcjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwS4MsMTH89qt1p+Qr+/ZO5/vkbhBXpiG38eyYxSJ4klWRLNh
	T37bUH4fpWcByAqjBFH0NDrxYXlF4ZU4N0KvehCisUAnxxeCxCA8JaahAy02vUeSHbH30ZSIA0U
	O5lx9XF8C3Q93S9F/7cTqC0c9xR+4uhVCSl3aey8IpuDGU1oTI+UvS5n90u3qWlrmUtrVZg==
X-Gm-Gg: AZuq6aKJoWuVmKmbHhocWr+czkqG9drbi4r9UkyK8FtpqjNqdnPvRTmeVB+NZbaG9+Q
	oa/b4aDhNNvZ2Ygx0C1s4sZzRYVRyHw2Ck8fa/TdeoMtiUttl6xjHQw2AOrGRB+zjWyZgDyYXDx
	Nmaa09BgQYET3svPD1vhhJvMeDFSY/sd0ag705qnZg934ooYlD7z+aKl7o1CFmmNl/5KzTIlKff
	T11Q8EoZY1G8SHwS6os6MvsqMwhEDFV217U1Dp4wMYGi4HIcH/TCx1d64OyeW6l9zQ0lmCaqvac
	JNiD0hHHNsM1dJc6+xRkqlOvPrBHVnwe4GbgRicc/wCDl63+uh8JdyOAd5fQeGUFDXmhcWuDda2
	5C4zKaf3GYA2eRCzLuDiBCCRIjyzsLzWFy1ExgT77i57cKo6/6RuKy3fRcu+8ZHkpix/m2Jjb3x
	Tkmmip
X-Received: by 2002:a17:902:e842:b0:2a1:14dd:573 with SMTP id d9443c01a7336-2a7698f3e16mr2290045ad.23.1768872682850;
        Mon, 19 Jan 2026 17:31:22 -0800 (PST)
X-Received: by 2002:a17:902:e842:b0:2a1:14dd:573 with SMTP id d9443c01a7336-2a7698f3e16mr2289815ad.23.1768872682297;
        Mon, 19 Jan 2026 17:31:22 -0800 (PST)
Received: from [10.133.33.36] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190d16a8sm106620155ad.39.2026.01.19.17.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 17:31:21 -0800 (PST)
Message-ID: <61c8787d-ddfa-4cf8-b3fa-a85cc1526680@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 09:31:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 ath-current 2/2] dt-bindings: net: wireless:
 ath11k-pci: deprecate 'firmware-name' property
To: Krzysztof Kozlowski <krzk@kernel.org>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260119140238.3360658-1-miaoqing.pan@oss.qualcomm.com>
 <20260119140238.3360658-3-miaoqing.pan@oss.qualcomm.com>
 <2bf8dfc9-148a-4914-86a9-ebbb871a6887@kernel.org>
Content-Language: en-US
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <2bf8dfc9-148a-4914-86a9-ebbb871a6887@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAxMSBTYWx0ZWRfXw9GM31/oo71l
 9lejzRvYEFCogOXQJm1c9le96Caqc7Wn+Gb2pQO40+q+29ZGIA9owaCHgZBOjCo4uNL1tLvmQMV
 b78Tlf+ugeIK7clvnRjA1kTNg6D1wRfXOK3MVi/Bu+kb0Ygljbl7OZpK8KCDVRBjFEj78Be1IH7
 ho+qtJrpTjbpZXqk70HO96ykj/LIsL8r00F4ZvHEcBb2pFWj0wXhGHkrPXI7CF66rQ1i1qRWDt+
 eDiLPIWDn7CQdobbJtqUYTVrheFWqz9FrhdnN2oZEIC16oFTwpyz9U4FtKl1JDrd+eqaNTqD4su
 7AEWK6+HX+7eNwDauyAOum5NWDjOiwxapQbW2gWe1RxzafCacHWuNeZ4EqD8Xbr2OzmYm6xlESA
 xATV6FuBVADJOWdYMJV5ya5InlqTPtwzfOVtkXESGp6754sF5w1MMmd5T4cMFBpe9wuw61FQ5E0
 KHSMnNvrlvXG3USLSzQ==
X-Authority-Analysis: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=696edaeb cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=5fP8d3j7kvdYVt2Ov_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: C01lbWmz5vemyFtyTjfsooJJH6c8bHxW
X-Proofpoint-GUID: C01lbWmz5vemyFtyTjfsooJJH6c8bHxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200011



On 1/19/2026 10:48 PM, Krzysztof Kozlowski wrote:
> On 19/01/2026 15:02, Miaoqing Pan wrote:
>> The firmware-name property was originally introduced to allow end-users
>> and integrators to select use-case-specific firmware for the WCN6855.
>> However, specifying firmware for an M.2 WLAN module in the Device Tree
>> is not appropriate. Instead, this functionality will be handled within
>> the ath11k driver. Therefore, the firmware-name property is now
>> deprecated.
>>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> 
> 
> Is this the same patch as the one which received review/tag?
> 
> Best regards,
> Krzysztof

Do you mean adding back the tag
‘Acked-by: Rob Herring (Arm) <robh@kernel.org>’ because the patch had no 
changes when that review/tag was given?

