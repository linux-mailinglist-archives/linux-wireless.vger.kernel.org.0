Return-Path: <linux-wireless+bounces-14375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C69AC7F8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 12:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4028D28A09F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 10:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1681A0BE5;
	Wed, 23 Oct 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HrfzTN9S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39714F108;
	Wed, 23 Oct 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679297; cv=none; b=IHaGXEbERVgdQbMpYWhbyDMt5L4EcFDTQBUWyg2CikD2Kb8viVJOqFenuvrGVbMFWq5Qr86SgFkGfQJLXoH+6CficlSjVKL81nKLGv5T8QKUtwE27cFe+6ttSvqLP5OSCZjEiySzwk9RsUnWfrYlx3Os77E0QSEuusjCQzIVfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679297; c=relaxed/simple;
	bh=iHOp32SFkBd7m82e8yskiq+ewhqH5uFRQqMZdB2NOvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ibcC1y8Fn6sVHP5yPjM8K4aWRU2Gw65X7I3eOuSIuIwxiuJzCgZVFIleQ0RfBbD+zpvUjDaLNfKJxD9KlNgCYWHNRfzO8oDk4dnRVIsXPveVOid5MiTHrF4VOZKajhF8NEjLH8t5XT4Ar9FCExbGrFt4UTE28EuzFuLBorvrFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HrfzTN9S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9v1hK025427;
	Wed, 23 Oct 2024 10:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/1RhKFk91LwuJ9KLrEjUapOT6KTyBjv1q2UPl2OI9ss=; b=HrfzTN9SIVYgQddQ
	0/QZ6JuHxOPEaVDaikTe7Z7MQXhpuTRaWdKFYnKB0fPbmrhVYc/yocx2gHmTNsrR
	Qnzuoliysc8w+/D2CvTb3uhThBDm0qmpgcDGh5xNnHbbET5kUwsURoYFIPVFzfBe
	1u+Qv2RNFCtnaDW13iNlntO2e36kjg4/C+RWBJlTs2MXS7agetDwRlVKqkio1Xly
	zVdLXkFdWicXprdDIgbBrJHxXmC87TejTm2sN6Yp2NS65cWZ6rHwb+aePq5ezkK1
	g1YIVTQg843QAcJUveCC4vVLdZZONZzEwDivW/iLg54oHn/qOfPvq7lAkhksjPQg
	kC24gA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em409uq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 10:28:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NAS9aK007187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 10:28:09 GMT
Received: from [10.151.40.160] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 03:28:05 -0700
Message-ID: <94defe49-c87a-44f6-8768-03f3d6687ac3@quicinc.com>
Date: Wed, 23 Oct 2024 15:58:02 +0530
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
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <606083d8-4332-45e4-be41-08ca5425cc03@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7nlqLKTs3YYANTZf9zjWISYTedC-DO5Y
X-Proofpoint-GUID: 7nlqLKTs3YYANTZf9zjWISYTedC-DO5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=598
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230064

On 10/23/2024 12:29 PM, Krzysztof Kozlowski wrote:
> On 23/10/2024 08:53, Raj Kumar Bhagat wrote:
>> On 10/23/2024 12:17 PM, Krzysztof Kozlowski wrote:
>>> On 23/10/2024 08:45, Raj Kumar Bhagat wrote:
>>>> On 10/23/2024 12:05 PM, Krzysztof Kozlowski wrote:
>>>>> On 23/10/2024 08:03, Raj Kumar Bhagat wrote:
>>>>>> The current device-tree bindings for the Ath12K module list many
>>>>>> WCN7850-specific properties as required. However, these properties are
>>>>>> not applicable to other Ath12K devices.
>>>>>>
>>>>>> Hence, remove WCN7850-specific properties from the required section,
>>>>>> retaining only generic properties valid across all Ath12K devices.
>>>>>> WCN7850-specific properties will remain required based on the device's
>>>>>> compatible enum.
>>>>> Just not true. These apply to all devices described in this binding.
>>>>>
>>>>> NAK.
>>>>>
>>>>> Don't send patches for your downstream stuff.
>>>> This is not for downstream. This series is the per-requisite for ath12k
>>>> MLO support in upstream.
>>>>
>>>> In the subsequent patch [2/6] we are adding new device (QCN9274) in this
>>>> binding that do not require the WCN7850 specific properties.
>>>>
>>>> This is a refactoring patch for the next patch [2/6].
>>> It's just wrong. Not true. At this point of patch there are no other
>>> devices. Don't refactor uselessly introducing incorrect hardware
>> Ok then, If we squash this patch with the next patch [2/6], that actually adding
>> the new device, then this patch changes are valid right?
> Yes, except I asked to have separate binding for devices with different
> interface (WSI). You add unrelated devices to same binding, growing it
> into something tricky to manage. Your second patch misses if:then
> disallwing all this WSI stuff for existing device... and then you should
> notice there is absolutely *nothing* in common.
> 

I understand your point about having separate bindings if there are no common
properties. However, the title and description of this binding indicate that it
is intended for Qualcomm ath12k wireless devices with a PCI bus. Given this, the
QCN9274 seems to fit within the same binding.

Additionally, there will likely be more properties added in the future that could
be common. For example, the “qcom,ath12k-calibration-variant” property (which the
ath12k host currently doesn’t support reading and using, hence we are not adding it
now) could be a common property.

If you still recommend creating a separate binding for the QCN9274, we are open to
working on that.

Thank you for your guidance.


