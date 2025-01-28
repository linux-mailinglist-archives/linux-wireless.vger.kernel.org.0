Return-Path: <linux-wireless+bounces-18075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CBCA20F5A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB293A9621
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD691B21AA;
	Tue, 28 Jan 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a6J4Kzym"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BF1A7249;
	Tue, 28 Jan 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083671; cv=none; b=eUq4bmyfIcW7TJuzlwjw1GMvKbHI4kHP/Mm5QyNuTublZcxdakYKfl3AQVJYa44J60brpRXDrMV5WD3F8LNccOq5OW38W8rCMaTEv0F+rKi/Q0Hg0YON4ZHLf3Zr2rqcmrwJc33z5aqMAagkIF5wVTtvVsLj+Jqur1DjnOmXDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083671; c=relaxed/simple;
	bh=mF05j41uzO5AxIr0Ne4o7R1QcFWIE4/Zp6PanRtvlqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A/nVfLM5jcLt+6ZSDEN7iU5DyfrZB54RpqqTH/qP5MD3j0bcvOgXpyeDrreIqX0VArFQwvjG5K2WMHFbKw55BpwVsBNXKpkQPeaCl99cg6ferqQvogi3nQGWoX/0I0xtXJEF5cm58VRflsheaFghFxpSV7w1mE87lAedyD0U3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a6J4Kzym; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SDnwHQ013084;
	Tue, 28 Jan 2025 17:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2OUjp/zwujNr5r3x6a5AB+/OVSf9RqiUYrcvyBEc3to=; b=a6J4Kzym7I7lXk6a
	CyTUOCmHQeLWm4losU79xPsMWqPdcqMalHzqcoDNtk/IHs42500lRjhgdSlUAzdy
	NRc92Tjc3dBSxlVrpjbDhXzyl6TXHPciT1OQAxrfmSlJmg0DfnTIfLhacSSdf1+9
	1FCancfAwd1aSiYvRR6iesC8Q5LbCu64AJTTD4XOrEyMEoxOj3XtUg9YaqtlZiQ9
	Swl266f6EPMo1howaaiFEQNbjL1dnfMIM6s+LkWIwVX0UWrH6cUQSkamwI2zGQYN
	UarkrF0HGCduLfwg3E17BfhW1ERx8WqVsqBPS9FUpD1rfTFX+Rjx6tKpfI5wrivK
	APuvtg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44f0fcrff0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 17:01:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50SH12mp000765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 17:01:02 GMT
Received: from [10.216.5.143] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 09:00:57 -0800
Message-ID: <f69fea6c-c6a3-461f-96e5-2e6ccd76cf73@quicinc.com>
Date: Tue, 28 Jan 2025 22:30:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: add wifi node for IPQ5332 based
 RDP441
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>, <ath12k@lists.infradead.org>
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
References: <20250128091012.2574478-1-quic_rajkbhag@quicinc.com>
 <20250128091012.2574478-3-quic_rajkbhag@quicinc.com>
 <b3ff05c1-6424-4ace-a873-ddf1a0d3d07d@kernel.org>
 <a752a135-9cd0-402b-b0fb-967491cfdaee@quicinc.com>
 <fd55ba36-d90d-4507-9c52-912f667c4193@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <fd55ba36-d90d-4507-9c52-912f667c4193@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qZFjIMZSZTtvCrogJ-hSiNS9lYNfIUZR
X-Proofpoint-ORIG-GUID: qZFjIMZSZTtvCrogJ-hSiNS9lYNfIUZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280125

On 1/28/2025 5:02 PM, Konrad Dybcio wrote:
> On 28.01.2025 10:41 AM, Raj Kumar Bhagat wrote:
>> On 1/28/2025 2:52 PM, Krzysztof Kozlowski wrote:
>>> On 28/01/2025 10:10, Raj Kumar Bhagat wrote:
>>>> +	/*                 Default Profile
>>>> +	 * +============+==============+=====================+
>>>> +	 * |            |              |                     |
>>>> +	 * | Region     | Start Offset |       Size          |
>>>> +	 * |            |              |                     |
>>>> +	 * +------------+--------------+---------------------+
>>>> +	 * |            |              |                     |
>>>> +	 * |            |              |                     |
>>>> +	 * |            |              |                     |
>>>> +	 * | WLAN Q6    |  0x4A900000  |       43MB          |
>>>> +	 * |            |              |                     |
>>>> +	 * |            |              |                     |
>>>> +	 * +------------+--------------+---------------------+
>>>> +	 * | M3 Dump    |  0x4D400000  |       1MB           |
>>>> +	 * +============+==============+=====================+
>>>> +	 * |                                                 |
>>>> +	 * |                                                 |
>>>> +	 * |                                                 |
>>>> +	 * |            Rest of memory for Linux             |
>>>> +	 * |                                                 |
>>>> +	 * |                                                 |
>>>> +	 * |                                                 |
>>>> +	 * +=================================================+
>>>> +	 */
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
> I think the intention was to send them separately, but together time-wise, so
> that the large set of net changes is somewhat shrunk, but the reviewers can
> cross-reference both series if/as needed
> 

Yes, the intention is similar: to get DT related reviews before posting the next
version (v5) of the driver changes.

>>
>>>> +			reg = <0x0 0x4D400000 0x0 0x100000>;
> 
> Please use lowercase hex
> 

Thanks, will do in next version.

