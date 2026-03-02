Return-Path: <linux-wireless+bounces-32354-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIGHEKK3pWkiFQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32354-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 17:15:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E240C1DC877
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40E86301B791
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A8407585;
	Mon,  2 Mar 2026 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5N8pKhM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dmvPSix/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B410387372
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468101; cv=none; b=JgRg6ahu7Itjowt1sTAqFdxmb//5QcHqh6ds3Og7RyIXbv+Zt0v2mdKSVjJ5vuoPSlDYTt1+pS8SJoeJvDy2r9Pt2mDXdkqUOJH4oFZDAqKNT7gaQ7b/3i3Q3q7uuVFCTFdObEVdyKCVb7p6E6CUoxRNR/3kkoWQWI0hzr71UTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468101; c=relaxed/simple;
	bh=UlDDRfYMQCy4dMb8ub7qmUIYbzBqkLxmb/vOmCiN0GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKAFkLXMOhezQ/QzmjfPLZ3fOwYThys9GwyrVDnJeQuor9NJRk3G3IUau8X3EerC/jnoKo6ZLSqriaKQKLFXtwjJnju7AZyoA5uLJ2Lt+i+h/Xqw2O5JIrUx6/d5S+BGq8PjvqLpTkqKLyHjFofSIeoGh9A191qZP0ty0+2Yrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a5N8pKhM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dmvPSix/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622CdQgC2504590
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 16:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nRvFyLu20woM9Nd9DY8wZ7AJPeFp5N8jdye++AlPH5M=; b=a5N8pKhMaN/+BQbn
	Bj4GyZfXolnTbvWJyLpJT5ZFqtPRDxSyE27z+7JLoRodIyQDxHH3jXvVsWEGoJWd
	4C65zzUEfA7XN8v4BB5yEzSfSr1V4hEQOKK/deklSaM6cVrQW9+Qj6pHXnh4BKs9
	71IsC+dcG0keWUE1UZLxd8/UuYFMXtYsarxptVfBhhH09vQFJ9gsZ+etKzMYCDde
	LCHQ/cV0zYDmStsKxySJ1ryd/UglSkXE+LBmfmL4mOP9WG94VkmlRi+4u+D38V92
	QozduZYFcQgzSJdj4kQZ0GqObC8SN32XmWNepu+oM8ueFTWpQ9NBDBJvo/aj69dc
	3gIKqg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5het0wx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 16:14:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70d16d5a9so3192320985a.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772468099; x=1773072899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nRvFyLu20woM9Nd9DY8wZ7AJPeFp5N8jdye++AlPH5M=;
        b=dmvPSix/iOjNg9o8H58h2ZHNfTpo77xEBmjLtNF8s7YoAUvIuk3pSKQxs9CW9st8/U
         +DpFJZLgu7Ed3OVG+cSKVFSPwIFVLaF9e9dlKWOQb3sek7+/h6ncAgrDTF6MFyo/1IqB
         DJjk+ectjyzCyBYpXJClXV180V3MmX/EUKBixZj/Q4h/XrRHJLXVFoLIaZW2TnMVhew+
         9lPaFFK195NTT7ej3D9UnehLbDR79iN4e1GsUjWEHfoZslhaRExuBEPSYIcHxCSaekSF
         mD3jIhMV9GUycJfF6OYnGw2B3ZTrzP/+VemxXfqyFAT/2lP3wdqbmVgsLGWl3sapJnxj
         2pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468099; x=1773072899;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRvFyLu20woM9Nd9DY8wZ7AJPeFp5N8jdye++AlPH5M=;
        b=NhAhAwSA57GYTw+vDlUhz7WALVHabpBu/IWHF8MrxIHgJy+aQsImweBOBkdZOs2a/p
         dnsIW4hTVcaNhHdBMRUKFy9FyyPdH5oaQDuhs5xxxzs2cre4Ngu5U+sLS0CcwUtMiqfR
         Od9JdLKaOSW4E5GvMUeIUCQUiYY6f9j6qGTUICXVKUqYgTt7dT2cFwxd+T9e/ep9iKYz
         c+3S9BsbTlTXX84tNv6OwEuOMfyF7YISJORi9YLC24+yGbAEl1k7CsKc+B8ge/lZek4v
         urhYqOPSWs459sch9iFLLbwSpSHJc6JcekXkLKskPDsDY+Q3+axBPgiibugQZC2MUMqz
         YSNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJf2NLdJAw7FGcQNMkLkS5lC/f/63swyfmK2+asEZBun7x6IurulXgQb3cZfNb1rIDH5ZsTK1Hqcsp26DJDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcc7RijnIg1IeyTdT02og9CO4dIlI5SXf27t7XISz3f3I1V7TH
	TujOhZb0Dzb0bsJrIndcJih8PBSk6jOuiVYOJu0Db+r4SAFnsYiyMEpu9qTsGD535yqu6dayS50
	yrY5JKU/Q2L6QT0G/cVExt16gQyxFjgzJY+pqqjNTR/FdR9QT82YsV1YHA8eGA37xAff/1A==
X-Gm-Gg: ATEYQzzgcraR6I8VCD2pK60XHTlecikcr6eNDy5i06OuxGRTlowD8MPhNG1kPLEvUZk
	r0DC3b7Csp3gNJApeTk9EPb2TgjhBvj7mdVvQ7YKTCWidi0846AEfdhZkENciQeLe3DDZ6B0y+A
	WYmgimm9kYe5xVQacyT3WuCxrPd6JkyvnDUCeiK21IsCU3kQE4ErbYNogBWSMm+bAxKI+uGOHVB
	7C5IOaxD0XfgMSIiLC8cWmTKUZqYaDpQYTZsOVSWpsES+8HdoFwzQjMbaD7o+FvGXhjP9/yzpNl
	UP+XSaQqYne5WtzYZ+DCcH9I4EpHqA4BvgDiWZ+keiRjqHiLjFOApgrvDbcXtV17kD9GHQ9csoe
	djZ26EDRjrvu0HU2OiUa17zcdv7Jf+wqbiIAlM4ATxS9g2HXL
X-Received: by 2002:a05:620a:1906:b0:8c5:c99d:b2c with SMTP id af79cd13be357-8cbc8da27eamr1582746785a.34.1772468098604;
        Mon, 02 Mar 2026 08:14:58 -0800 (PST)
X-Received: by 2002:a05:620a:1906:b0:8c5:c99d:b2c with SMTP id af79cd13be357-8cbc8da27eamr1582741985a.34.1772468098058;
        Mon, 02 Mar 2026 08:14:58 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9a5esm291822565e9.4.2026.03.02.08.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:14:57 -0800 (PST)
Message-ID: <964b56dc-035e-4d7a-b9a0-5ac5dc6c5787@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 17:14:55 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CMA allocation fails with default 128M on X1E80100 (Lenovo
 21N1CT01WW) for ath12k
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: =?UTF-8?B?UmVuw6kgTcOpcm91?= <eldeinformatica@pm.me>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <7pJkV7xouk-7S77gIvCwPj5EAAVe0JWdkD5Dc4Q7Y77_gPr5m7jMA2om7AyEN6RKBmEyFbIDJceHFstXFuzPJWPNhqafLXOu2O0uCDZEFcY=@pm.me>
 <05ff4122-1a8b-4728-81ac-33a7ca542461@oss.qualcomm.com>
 <d71ef31a-d7dd-4350-a784-a77e63be96ec@oss.qualcomm.com>
 <ornmlrnmwzpxusdv7e5d27zvqn5ey73dt4gsh7kjrzvcbrrlrp@r5gaj7dphh4l>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <ornmlrnmwzpxusdv7e5d27zvqn5ey73dt4gsh7kjrzvcbrrlrp@r5gaj7dphh4l>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a5b783 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=HDQugdir0DPcGmOLpZkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 10z56QbmCIDRm0zQsCjvTNDNKVlPXEpW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzNSBTYWx0ZWRfX+Q0E+NcJYAXi
 Ax4gKAFPWAGfzML/9aCjtoJoPAFPrjFvUWfUV+ucMhWQE0nHhHe1yrB6IbOZNqiGsxNvjzZxt7h
 kxCL+kpfndhM8GABU+sMzt03wh9MyGQBRpiy37rJDrR7D9qSAEuLL1mkVTPN6zqzyiJ5dL2Fu2C
 v7rqXFQ741/aztWGCH7k7uMIJsw2DbSHbe/kX8L6lQLbXt18b4F7ElOVpt+kIqNYZKXsyQPmLrQ
 R0waWMQlxu2iKgyz/XqaiRqNxB6VnlogtamBs9X7ef53WTTA+rQ2OTZG0wlHeU/iM282zfdRmzL
 sine2mAu18VghWsHDdqUYmZ2GZApcL1gDFdFt5bo5O0bvthHB0Kk6PMetZGjbFdITDRrJmfQ0mb
 8NthuHisM+6yunfPIYw1JYBuudcpMEL0uQVpFSTzGzEigfC8GM7VsI9/oV6cq7UDjW+i4u0elfx
 +uy8XRcWZ8odEWc0q1Q==
X-Proofpoint-ORIG-GUID: 10z56QbmCIDRm0zQsCjvTNDNKVlPXEpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020135
X-Rspamd-Queue-Id: E240C1DC877
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32354-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 02/03/2026 14:17, Dmitry Baryshkov wrote:
> On Mon, Mar 02, 2026 at 12:20:17PM +0100, Konrad Dybcio wrote:
>> On 3/2/26 12:19 PM, Konrad Dybcio wrote:
>>> On 2/28/26 10:29 AM, René Mérou wrote:
>>>> Hi,
>>>> I'm experiencing CMA allocation failures with the ath12k WiFi driver on my new Lenovo 21N1CT01WW (Snapdragon X1E80100).
>>>>
>>>> Error in dmesg
>>>>   cma: __cma_alloc: reserved: alloc failed, req-size: 257 pages, ret: -16
>>>>   cma: => 1042 free of 32768 total pages
>>>>
>>>> System details
>>>>     Kernel: 6.17.0-8-qcom-x1e (Ubuntu)
>>>>     Default CMA size: 128M (set by the distribution for this hardware)
>>>>     WiFi chip: ath12k_pci (Qualcomm WCN685x)
>>>>
>>>> What I found
>>>>     With the default 128M CMA, the allocation of 257 pages (~1MB) fails
>>>>     After increasing CMA to 256M (by adding cma=256M to the kernel command line), the error disappears and WiFi works correctly
>>>>
>>>> My questions
>>>>     Is 128M expected to be sufficient for ath12k on this platform?
>>>>     Could the driver be optimized to need less contiguous memory?
>>>>     Should the default CMA size be increased to 256M for X1E80100 devices?
>>>
>>> The default value in the arm64 defconfig is CONFIG_CMA_SIZE_MBYTES=32,
>>> although most laptop DTs individually add a 128M zone under /reserved-memory
>>>
>>> We should probably enlarge this value in either of those places, although I
>>> don't know whether changing the defconfig is going to be welcomed..
> 
> Can we change DT instead of changing defconfig?
> 

I don't think this is a DT property, because it depends how the driver
behaves. If driver allocates smaller or bigger memory, then you keep
changing the DT. And then if other OS does not use CMA, but "TrulyCMA",
then we need to keep this growing, so just propose a change to defconfig.

You can as well fix the drivers to use proper size, based on that DT,
not cmdline argument.

Best regards,
Krzysztof

