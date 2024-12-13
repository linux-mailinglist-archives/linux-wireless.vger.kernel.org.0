Return-Path: <linux-wireless+bounces-16343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA1D9F03D5
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 05:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446C71885A0A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 04:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01818452C;
	Fri, 13 Dec 2024 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OYLiRB8Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB28199B8;
	Fri, 13 Dec 2024 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734064162; cv=none; b=LRh+Xfo2AhPck5dpv65TAKQ0ie+you/bLG9EkCkOq7Z/DBFXhxGY2zy7qef+aqtOQUXoHRrfVpjtp3JfvC2j5m2Y87+sG2lJXAqiS7t91Q1X9/++qXLfaNamu8op4Ze/+no+6OEDINXEtXJ+TKfGzZ/njHiEigPJkmLIrfbLrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734064162; c=relaxed/simple;
	bh=SPORDt2xpifl4rMMTZ5+F0WP+3OGnwZtF678L0XEiug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eKqqjbOislh0ukd0YDHur23Hl/8XNey/in3ner/hvbLhDPUS+kKZh0yrifS6b5TV+jmaCdYNXCQ56CfnBgoF0KU3EWUGHJZzJvwMuFjYEyXHlTP+mm1EonRY/bvZq/WAcwc5Oz7Cb5ll0bI/xIt8CJkHRglDB0A6JUJ8/+7cIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OYLiRB8Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCHaiT9026866;
	Fri, 13 Dec 2024 04:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VRtKfWOTxHgeaHEN5DPAcru9H3wyqs+TXKFWq0Pxzcg=; b=OYLiRB8Z6xuLGRWW
	NxKQ8ai6SDFev3SX4cDN5c0ez0sW45yyBhJtPc/5Atc5NHdrmq/xHLiP4B9DNroa
	cw6RETUvNzVbeR2zO3vUIGsz2w/Xjh37VyD2Is3BYtxLXw8cmCIcHZhfw30d9Cfz
	xPorKLaNE4eHKqbpXdcTdsNG5YmVGMv2ClwmXW/SID3klT92YzXkBSrQixRjuBH2
	04dOwxipjw5stOvmC/T9voQLdF/1mbNYra5m/vnXskvx81RXXOtHIedCa2xLl1Lk
	QIO/QEjQHNTwCeEs2AGdSvIlDQiXEC7x1JPy4Bki3l8l6ZQ7rxo9PneUfGRaoOP+
	aNjBNQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40n2px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 04:29:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD4TAgm001630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 04:29:10 GMT
Received: from [10.216.12.63] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 20:29:06 -0800
Message-ID: <980d4a8f-2ea8-4138-8885-5ace5d87e0d2@quicinc.com>
Date: Fri, 13 Dec 2024 09:59:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] wifi: ath12k: add BDF address in hardware
 parameter
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-16-quic_rajkbhag@quicinc.com>
 <142f92d7-72e1-433b-948d-2c7e7d37ecfc@oss.qualcomm.com>
 <0796510c-20bd-4a81-bd60-40aacbcf61c0@quicinc.com>
 <83d216c4-bf9e-4eb4-86d3-e189602f37cc@oss.qualcomm.com>
 <30e5d714-2e52-4a0e-9dc8-b6cacf6ad382@quicinc.com>
 <e63af513-5fd8-40b0-a1b2-daa9821ebf5a@oss.qualcomm.com>
 <b3581663-8dc0-44d4-9395-df385316bb09@quicinc.com>
 <e3dff1d0-989c-48db-9fd6-6b3c209d1452@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <e3dff1d0-989c-48db-9fd6-6b3c209d1452@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cBaRtzOHvgnCQAhClYx1Ulc7ewwG_TwU
X-Proofpoint-ORIG-GUID: cBaRtzOHvgnCQAhClYx1Ulc7ewwG_TwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130031

On 12/13/2024 5:48 AM, Konrad Dybcio wrote:
> On 9.12.2024 5:23 AM, Raj Kumar Bhagat wrote:
>> On 12/6/2024 4:19 PM, Konrad Dybcio wrote:
>>> On 6.12.2024 5:34 AM, Raj Kumar Bhagat wrote:
>>>> On 12/5/2024 11:12 PM, Konrad Dybcio wrote:
>>>>> On 3.12.2024 10:18 AM, Raj Kumar Bhagat wrote:
>>>>>> On 11/4/2024 7:46 PM, Konrad Dybcio wrote:
>>>>>>> On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
>>>>>>>> The Ath2k AHB device (IPQ5332) firmware requests BDF_MEM_REGION_TYPE
>>>>>>>> memory during QMI memory requests. This memory is part of the
>>>>>>>> HOST_DDR_REGION_TYPE. Therefore, add the BDF memory address to the
>>>>>>>> hardware parameter and provide this memory address to the firmware
>>>>>>>> during QMI memory requests.
>>>>>>>
>>>>>>> Sounds like something to put in the device tree, no?
>>>>>>>
>>>>>>
>>>>>> This BDF memory address is the RAM offset. We did add this in device tree in
>>>>>> version 1. This is removed from device tree in v2 based on the review comment that
>>>>>> DT should not store RAM offset.
>>>>>>
>>>>>> refer below link:
>>>>>> Link: https://lore.kernel.org/all/f8cd9c3d-47e1-4709-9334-78e4790acef0@kernel.org/
>>>>>
>>>>> Right, I think this could be something under /reserved-memory instead
>>>>>
>>>>
>>>> Thanks for the suggestion. However, the BDF_MEM_REGION_TYPE is already within the
>>>> memory reserved for HOST_DDR_REGION_TYPE through /reserved-memory. Therefore, reserving
>>>> the memory for BDF_MEM_REGION_TYPE again in the Device Tree (DT) will cause a warning
>>>> for 'overlapping memory reservation'.
>>>
>>> Then you can grab a handle to it with of_reserved_mem_lookup()
>>> and of_reserved_mem_device_init_by_idx()
>>>
>>
>> The memory HOST_DDR_REGION_TYPE is a bigger memory around 43MB, while the memory
>> BDF_MEM_REGION_TYPE is smaller around 256KB within HOST_DDR_REGION_TYPE, Using the
>> above mentioned API we still have to store the offset in ath12k to point at memory
>> BDF_MEM_REGION_TYPE from the start of HOST_DDR_REGION_TYPE.
> 
> That's still way better than hardcoding platform specifics in the common
> driver
> 

Sure, I agree. I'll update in latest version to store the offset for BDF_MEM_REGION_TYPE.
Thanks!

