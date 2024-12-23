Return-Path: <linux-wireless+bounces-16710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714B9FA9E1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 05:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824077A2461
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 04:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED414F9CF;
	Mon, 23 Dec 2024 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QFdkfx8G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655C85270;
	Mon, 23 Dec 2024 04:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734927880; cv=none; b=j/j/xIVyY7EEIVVBGvXboW1p2b/W4DWI+iAzRMvvaVyiYmqTXfAA3wlQYI0unK/uwNG2OJZtcOOk2vzcx7qkSlyauBrBPuhjd8c00cnnexjba0YGZKSDdqECJg8NDRa2u+RhFW9sm3GtIe3xJ+7R45pmODUdyDdeQjChuoK6OpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734927880; c=relaxed/simple;
	bh=zFgLApFNMhAUyw2nOibAlkeaJEy+7t+pRx1G3mbd8fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vhr7pfAXLeNsCAKF0xX0KUdkulp5MtkH7zeG7M7mEYMkopsPEnu0dS2/QvFHdgOBn0Xi4bDZ1Cx8AQJhbNQWPAndobtrqaEIq8i8pk0p2X8sdq1Wt7Tcoaio6rkF5EZGlm601fHmEF/6udyPe4zowZax+t7sUftdoykYRe6gK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QFdkfx8G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN3CT71007799;
	Mon, 23 Dec 2024 04:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	07KN7FjkG/mIIcZlvzIW/LaKGeNa/Ht1lAI/yHaqYko=; b=QFdkfx8G/9BDbO4e
	mG5cIyfXbplpz177i/pqRTATrunZidav/0XdkxfeDSGae6r9r2rmJ6kehOjyTi7q
	rRjqqwJRY6ebBVXEnrwAJPctZSOub/Cp5wtJnYvH6tlV2/UhALWxndlwOZovXdMF
	Iua6Oab+GAyF/1Ailitq3rGa7WGKgEnEwQCvfh9GbsJAl6Yhg+1nOCSdBE7ZnzYA
	zI2yDJ4Azg5sUB1BJbwXdFkezT6CeCida6rem/V7uIgBl3lJ/WPa4lfjAgAfq1Mz
	tiL86W3uXJCXpxmzDzrf/Y071NQeQaZpYnWl6xpu4a0d9wj4IV6JbBkkiY5AcLUO
	9DMlbw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43pyrpr797-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 04:24:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN4OTAR014780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 04:24:29 GMT
Received: from [10.151.41.196] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 22 Dec
 2024 20:24:25 -0800
Message-ID: <de313b43-4e90-4b3a-a233-917a963810c8@quicinc.com>
Date: Mon, 23 Dec 2024 09:53:59 +0530
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
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
 <20241105180444.770951-2-quic_rajkbhag@quicinc.com>
 <9cbdca90-e76c-4ebb-a236-a0edbd94a629@oss.qualcomm.com>
 <62c599b5-20b2-4e1e-810d-e4502abbc682@oss.qualcomm.com>
 <768ef22a-855b-472d-9432-49db7daaf2df@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <768ef22a-855b-472d-9432-49db7daaf2df@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: le6esRrgP00FhDPFggP_x5IMCb6Eqw9a
X-Proofpoint-GUID: le6esRrgP00FhDPFggP_x5IMCb6Eqw9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230036

On 12/21/2024 3:35 AM, Konrad Dybcio wrote:
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
> 

Sure, will submit an update to the description.

