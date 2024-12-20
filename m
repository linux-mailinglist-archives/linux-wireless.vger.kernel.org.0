Return-Path: <linux-wireless+bounces-16665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F689F9C91
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 23:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE30A7A2782
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 22:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70DD22655D;
	Fri, 20 Dec 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OX6qF5HN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA3226548
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732363; cv=none; b=JsIGhh8LplzpRSdACwk8G+NVxn02x5+qexhXcVp6cPqofTvYGlxP3JzcBw91+wCQytDoPLyT2Ygc+a8OXmN+F/46Tgtmc2vaAqVna4IhJAw9N9gee9S0I9Y687OB7/0Mr4Qi/u7vUBPKmFOpXlOt4iU/fHljJajizozDYm3S7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732363; c=relaxed/simple;
	bh=PYfMyDqg17kslvPPraNVn6LtPqttUcrIdvQB0jDY3cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suRX6qoLw9PXV9cYYmHV8dolLP2y55T33Isfb9wpaXUqkf5bXT9rzG1I/7axu8sw1vv02J+AfvrTL2wMcW6+Ky3qpJAgX/LrusgfFx5WaEhCErkU9saOUuvo7E4u7yYWUF5B+3KACb7xGaPvd+agIZ216NUExrsHO9jdkFKW34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OX6qF5HN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKCilHX013463
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 22:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9LkFprxiUsD1tk8g3pSzxnZakkpVhYTWUC5dUvvw9cU=; b=OX6qF5HNDalc8WsU
	j1l+fCGALZntBY47aJJj/THHl+B7bxzD94dCk8um1GMoOrr92fRm9RLRh/nsGZNN
	x6zNnGIhaQjZC1Rfvg6TFDqHZgejTEHTtdhD2eHIf4X4c8qTpYwRAD8hvq2Cr9d0
	W2huSD4ejU53l7/ToTzgNE/1VfoAuR30ZbK2T6G5XCwuhZwjqqqEwtVa74xOuAfk
	DAXqXsVf4fXjRm8iL44FPC0eOiFPiADkmyLTOEJoIP6DeZEAhus6lCameWkKP22x
	i3BQOYf9JISQPokSXU0dqGglf/wJHUSXHGbhdv3eb4xcZr1mh2QCePY5Xcqwu3QL
	yr1Ldw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n8uvhar8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 22:06:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6ee03d7d9so7189185a.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 14:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734732360; x=1735337160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LkFprxiUsD1tk8g3pSzxnZakkpVhYTWUC5dUvvw9cU=;
        b=IvPX02tbCPGYIVUoqKKPpJguvnveyL85y040TXRGgEsEoViHXbFYmrxuQoqs1Mz3Zu
         b2m13Pi/A1Eh8wtV5l1DxPxpDfmG1S4XXuSUQfCBKAWbykMVOWRWbzM6tjBWZArqOf8E
         IFDd0Fq/iyamhszTt/GVj8Kg2+tOwmNZ3tWQlzKpbMV08RtiHS3X21YYMf54sh0C/Ls3
         7dElK4d/cYLW4kG70FDMbGcrV+Nr5b4U3CbJF1yGO8gqP+fgg8MqHvx9KqtGrSWPmJQ3
         8EOYkn+egOdX7bLjHVtR+CAwkBXb7NPr/oDN4SM/dEoe9SmQ8zQqstmLU6e0rw1Xg8Sj
         Focw==
X-Gm-Message-State: AOJu0YzuWMWcsn0F0+0CyPEOrIpfRmL+wkr5AdAqZg30hNFK6sh/y/hl
	D0hgCFjoGb0jttA7A8IFcfY2dx4Bh9yCrS0tlkjx66HoTNnmeLrvTAj2hJ3MJgUwoVpWLF2nWI3
	cDaxkSnZx5KEb1exIQdyF4VKR9sWbytOkpQhGAo6Wr4aOZQa7iveRkNxcSAdPhUqusA==
X-Gm-Gg: ASbGncsYRDbRBssq/ly+b0DWDPMPQP9mIX4VDw0t7eQRBmorzRwkMcYO893q3Y+5Mu/
	MDn9vZ56veuv9ASYi5oHmW9ys9j6g/C4nrAeu6XYhfPrhpCIJbIh1ubcbWXmxRr99QbCkJAnAq+
	oVb6QI5T3mQC9gpZLcO9H4HwVrWEpQNhQIMA5Q7HLD0FdcSomcwtX/wrRPUXITvzz288dbM2kBV
	e94OU4LsPILdOowSJx626oWhe6ubZebG6Igemr6nUYjf4iHc+19+w/0tubSRJycjKRjQsoKXW2B
	Su6UZhtMWF0YLOSed5KFANMm4f3FDKpIXus=
X-Received: by 2002:a05:620a:17a0:b0:7b6:e126:3dee with SMTP id af79cd13be357-7b9ba71292cmr244461785a.3.1734732360445;
        Fri, 20 Dec 2024 14:06:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHDi1i1hytvqYgiaDYCCC63bgwu6iKUJ6GlNcbQHn3uxugwlsISW/jSe1exPxzhd8K+GSWew==
X-Received: by 2002:a05:620a:17a0:b0:7b6:e126:3dee with SMTP id af79cd13be357-7b9ba71292cmr244459385a.3.1734732360111;
        Fri, 20 Dec 2024 14:06:00 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a3ebsm2100297a12.7.2024.12.20.14.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 14:05:58 -0800 (PST)
Message-ID: <2d1570a2-511a-4200-b4cc-60f56cfe4423@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 23:05:56 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/5] dt-bindings: net: wireless: Describe ath12k
 PCI module with WSI
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
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
 <768ef22a-855b-472d-9432-49db7daaf2df@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <768ef22a-855b-472d-9432-49db7daaf2df@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FJwXqBML2_2Ba5ut3EMtBRYccLHnoIOA
X-Proofpoint-ORIG-GUID: FJwXqBML2_2Ba5ut3EMtBRYccLHnoIOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200178

On 20.12.2024 11:05 PM, Konrad Dybcio wrote:
> On 20.12.2024 10:47 PM, Jeff Johnson wrote:
>> On 12/20/2024 12:03 PM, Konrad Dybcio wrote:
>>> On 5.11.2024 7:04 PM, Raj Kumar Bhagat wrote:
>>>> The QCN9274 WiFi device supports WSI (WLAN Serial Interface). WSI is used
>>>> to exchange specific control information across radios using a doorbell
>>>> mechanism. This WSI connection is essential for exchanging control
>>>> information among these devices. The WSI interface in the QCN9274 includes
>>>> TX and RX ports, which are used to connect multiple WSI-supported devices
>>>> together, forming a WSI group.
>>>>
>>>> Describe QCN9274 PCI wifi device with WSI interface.
>>>>
>>>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>>>> ---
>>>
>>> I think this description is missing the key points:
>>>
>>> * what is that control information (power, data, radio stuff?)
>>> * what happens when the OS is unaware of all of this (i.e. what happens when
>>>   we don't send any configuration)
>>> * is this configurable, or does this describe a physical wiring topology
>>>   (what/who decides which of the group configurations detailed below take
>>>    effect)
>>>
>>> And the ultimate question:
>>> * can the devices not just talk among themselves and negotiate that?
>>>
>>> Though AFAICU PCIe P2P communication is a shaky topic, so perhaps the answer
>>> to the last question is 'no'
>>>
>>> Konrad
>>
>> We already pushed the non-RFC version to our -next tree so we cannot update
>> the commit description without a forced push.
>>
>> https://lore.kernel.org/all/20241211153432.775335-2-kvalo@kernel.org/
>>
>> However, Raj Kumar can submit an update to the description in the file, which
>> is probably the better place to have this information anyway.
> 
> Sounds good

(although bindings usually land with Krzysztof's or Rob's review tags,
but that's between you and them to talk about now)

Konrad

