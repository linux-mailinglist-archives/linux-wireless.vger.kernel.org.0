Return-Path: <linux-wireless+bounces-16664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803AD9F9C8C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 23:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC4618930FC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953E1B0F0B;
	Fri, 20 Dec 2024 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jM4tac5B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25522653E
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732310; cv=none; b=eiy2g5M5A5Zig3rFe0/oNMU6aSv9676HqyRhT8EmEtC+IqLa/VeESbYf6535ZdWQscl3eP7GSNZBQBbcPmtVYJCb+YH8pVSB0mzw2qvsRZ76pEB37xXRHhhNxfuoWusP2+M6o53+XRz9VU02rjfSjoXowdGepD4TBipygy8++a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732310; c=relaxed/simple;
	bh=gvkrV9GXj0wRQAp2oIxV5+RD+MUdz/v8NjP/GVR/DY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unZyEOTVTvFhXBmBwnnjJ0VWxfY3InD/APxjWKXQtGWl+nikAkiLJVuPOXWgK/yB/aJQdYCh9CcrDECwkarn38S3UrX6CHr1bLcJ96ibErnoqXestxly2SPAkeGav75TShNFNra+/SIIcaDMTzigcTElU+vkZ89sACcvp/Ukr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jM4tac5B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKEgBpL004301
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 22:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4nXlmOB68+QOEFBXeep/xRRq4DE+UR1z1GZdCojJSEE=; b=jM4tac5BpDylR9/B
	rf26wgMUoNCUHR6nLjoRVZ5ivHx1uNfXax3XRQ4xQ6PUyIcYK6GeNT3Kd5DfieP6
	XoY0eRyA4KsIsFMjiSgkHTwqLpBvqY/WkjHXt+Z74g6GmNJxacaBalHz4eUsxOXY
	aZSnpQsG4wM2qDzXIbMIjN9gRrzAUtxbtFLemYEiUMBeQ35FdXGvtyVUx0PyUzLE
	qiXxmHW+g/dPjtCQ5c9ajnfN6FI4Gv97admJU0p/SXG/YPACp9hB32v/kJr+efJY
	1+zJgiviAoS84JXyOkmBVal8QMh0Wf7d092U2726zS5b4iDpmeDGiPvaebkIemJ1
	bufTsA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43najt1195-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 22:05:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b704c982eeso9496985a.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 14:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734732306; x=1735337106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nXlmOB68+QOEFBXeep/xRRq4DE+UR1z1GZdCojJSEE=;
        b=KSS+m38H9HBXZKQunbek+n9NB+5ZHhWsJVu8DiUV6R9Ey+Gr20C58L2wp3FdZmx66u
         sVtuZmKkBe5qDpf+24jR6fc45FEaTA3XEkKvsnm430hQowiCKT0LZe2KVSv0Haa03gE5
         6gRY2mjo9uL1lYWJ5R6MHiuKmppCKoy+29Kee1/q1KTo4dFPJdtW82WQCPgMDiWwJmeW
         nSkW1LIKNGywcsipyoDx/LasHnWzIsAFFHoRlhE7L18T4CSka2qvgYP4l7z0prL3/FMh
         kOX01qBqj0zXwbr2T8L27U7/Zz/yUrqsd5BFFDSznX44QdO6muhyT0Qzv4K2RDATewKW
         NiuA==
X-Gm-Message-State: AOJu0YznFjqql8k0ZaXHpHT1xN/O4nablN9kAhm2DNHYFBZ2tQud8pFz
	MVDyLg2HuCUDIxt06AqrYZPlk7OKpxIyk++mFzYt6ZnaoYaI4whH0fY+84mtXrihcn8IINkUWsC
	qxumCWpQbGvXa869ftg3bWirdziPEaqLDWBtRg9D1j/CWKU+mNz10NW9SCgr7K4de1Q==
X-Gm-Gg: ASbGncsJnc1cMh3xTGvkJZ/vTIIcLa36uKcpaR4RhLcSjpZZe0LmAHSRZcE5uEZkpx7
	L7ZjseG6S/JOjCYNVhMZE4mvEZsZ/40l5s7reGrWbp68abPI1N/uF9EfIMwzv0E9469uP7glkyA
	R+mpDGtseDZr+QxPwgj6XRQCRuUnvoIjl7wcv+LUgadPWtrn6qsg0eQ8ulgzxzKtfcG2AYIm6T2
	WgBLYrhZ/4vLRbszG+h+oiuRc0NNdPMxwn6FAcq8q4GgwZPnrkFkO8S+OXZQUYIOzNgdLWwi+o6
	wR2v+KJYYWsGsRHABVYBi0tRdy+LRdfETfY=
X-Received: by 2002:a05:6214:2a4e:b0:6d8:ae7b:6b3 with SMTP id 6a1803df08f44-6dd233b3944mr28522306d6.12.1734732306277;
        Fri, 20 Dec 2024 14:05:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmjK+yjXoyEKenhMrKpOs87S43uRGWsCZ/F/zqhyQ4b6IznVFNEJlW+armIOoWtpiVDZsBVA==
X-Received: by 2002:a05:6214:2a4e:b0:6d8:ae7b:6b3 with SMTP id 6a1803df08f44-6dd233b3944mr28521986d6.12.1734732305820;
        Fri, 20 Dec 2024 14:05:05 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8961a6sm214801166b.57.2024.12.20.14.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 14:05:05 -0800 (PST)
Message-ID: <768ef22a-855b-472d-9432-49db7daaf2df@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 23:05:03 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/5] dt-bindings: net: wireless: Describe ath12k
 PCI module with WSI
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
 <20241105180444.770951-2-quic_rajkbhag@quicinc.com>
 <9cbdca90-e76c-4ebb-a236-a0edbd94a629@oss.qualcomm.com>
 <62c599b5-20b2-4e1e-810d-e4502abbc682@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <62c599b5-20b2-4e1e-810d-e4502abbc682@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QA9x68JeYJA829e26l7xI7toQslHaFG6
X-Proofpoint-ORIG-GUID: QA9x68JeYJA829e26l7xI7toQslHaFG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200178

On 20.12.2024 10:47 PM, Jeff Johnson wrote:
> On 12/20/2024 12:03 PM, Konrad Dybcio wrote:
>> On 5.11.2024 7:04 PM, Raj Kumar Bhagat wrote:
>>> The QCN9274 WiFi device supports WSI (WLAN Serial Interface). WSI is used
>>> to exchange specific control information across radios using a doorbell
>>> mechanism. This WSI connection is essential for exchanging control
>>> information among these devices. The WSI interface in the QCN9274 includes
>>> TX and RX ports, which are used to connect multiple WSI-supported devices
>>> together, forming a WSI group.
>>>
>>> Describe QCN9274 PCI wifi device with WSI interface.
>>>
>>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>>> ---
>>
>> I think this description is missing the key points:
>>
>> * what is that control information (power, data, radio stuff?)
>> * what happens when the OS is unaware of all of this (i.e. what happens when
>>   we don't send any configuration)
>> * is this configurable, or does this describe a physical wiring topology
>>   (what/who decides which of the group configurations detailed below take
>>    effect)
>>
>> And the ultimate question:
>> * can the devices not just talk among themselves and negotiate that?
>>
>> Though AFAICU PCIe P2P communication is a shaky topic, so perhaps the answer
>> to the last question is 'no'
>>
>> Konrad
> 
> We already pushed the non-RFC version to our -next tree so we cannot update
> the commit description without a forced push.
> 
> https://lore.kernel.org/all/20241211153432.775335-2-kvalo@kernel.org/
> 
> However, Raj Kumar can submit an update to the description in the file, which
> is probably the better place to have this information anyway.

Sounds good

Konrad

