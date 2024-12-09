Return-Path: <linux-wireless+bounces-16009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953969E8A3E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E80F1884978
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D60815855E;
	Mon,  9 Dec 2024 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KeT3E5bH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A08A156F41;
	Mon,  9 Dec 2024 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718203; cv=none; b=ewpHhSUUvlct4HPvSioD9+H6EOFzSGpLQqyNPIfMvbzwKPzF5KLXzzG1AkX6kpkg8ZVW/CkYpHlH1tOK65qKsDsl/14lWT5oah0DR1xlHynfHXaswHESANIP38baXdIWgBCojqXkTh6zVEJ5j6slD96QZ1Yp0O/tGR3LFUe8igM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718203; c=relaxed/simple;
	bh=iWrUKN2aAIMeQCc+f8mhS9L9J24f9TNKMDk7qd5tRwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cZOGgI+6FHhcbtXrQQxwYOu6UmY7l6eUp75zg/jSFM1euHMJ84T+59ZS3xM2Gc82u6I0usNllNr6/so1Im62yecWQaFdsiU9U+agN5XXv7VSX2yoJHv1ZDj5lQnKQ9nhO7awomcyonPpnLPsQvKwoJUgFnelEx2e8kjccn2tlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KeT3E5bH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B90tFrZ024799;
	Mon, 9 Dec 2024 04:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fsdp49+n36T9gPJ9WNOXXAF+BlRo3wPP4MmbMN7btik=; b=KeT3E5bHaP3nFa3Y
	gZ7gYePeXa5x0s5Nx7vCvVxGmmEUXMThKzqZnUDmqw8r6UQrvrnu1zYJwJKAs2F9
	GaDHKuQyu0bmCNyuud5goLyAMZEKpRWQJ8irCHHWJj5IjvjSbOplNS+VMKqf3Tdk
	GtDNHCS6n0jI1O9qaPCy17ZHEAEdohx1iZoZZzkrc16EO/96Jtn3gR0rVEk/FPhi
	QFycPP54Dmj34sjIvU0lmcFAA1eBtWQ3JDKQ3eTULs9j5tqM9mWQl1y3fDjeExGf
	NMYE0etN7hEEosKwyA61Vvv0I/U4FBwbTFIRXxqx7Y6YCAjzpabTDBtZIZIsaBHs
	5x94QA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdpgkbk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 04:23:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B94ND30018215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 04:23:13 GMT
Received: from [10.216.28.219] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 20:23:09 -0800
Message-ID: <b3581663-8dc0-44d4-9395-df385316bb09@quicinc.com>
Date: Mon, 9 Dec 2024 09:53:05 +0530
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
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <e63af513-5fd8-40b0-a1b2-daa9821ebf5a@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MsHpbs_igXCvaoRxMGflt1-jYkn0HTdc
X-Proofpoint-ORIG-GUID: MsHpbs_igXCvaoRxMGflt1-jYkn0HTdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090033

On 12/6/2024 4:19 PM, Konrad Dybcio wrote:
> On 6.12.2024 5:34 AM, Raj Kumar Bhagat wrote:
>> On 12/5/2024 11:12 PM, Konrad Dybcio wrote:
>>> On 3.12.2024 10:18 AM, Raj Kumar Bhagat wrote:
>>>> On 11/4/2024 7:46 PM, Konrad Dybcio wrote:
>>>>> On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
>>>>>> The Ath2k AHB device (IPQ5332) firmware requests BDF_MEM_REGION_TYPE
>>>>>> memory during QMI memory requests. This memory is part of the
>>>>>> HOST_DDR_REGION_TYPE. Therefore, add the BDF memory address to the
>>>>>> hardware parameter and provide this memory address to the firmware
>>>>>> during QMI memory requests.
>>>>>
>>>>> Sounds like something to put in the device tree, no?
>>>>>
>>>>
>>>> This BDF memory address is the RAM offset. We did add this in device tree in
>>>> version 1. This is removed from device tree in v2 based on the review comment that
>>>> DT should not store RAM offset.
>>>>
>>>> refer below link:
>>>> Link: https://lore.kernel.org/all/f8cd9c3d-47e1-4709-9334-78e4790acef0@kernel.org/
>>>
>>> Right, I think this could be something under /reserved-memory instead
>>>
>>
>> Thanks for the suggestion. However, the BDF_MEM_REGION_TYPE is already within the
>> memory reserved for HOST_DDR_REGION_TYPE through /reserved-memory. Therefore, reserving
>> the memory for BDF_MEM_REGION_TYPE again in the Device Tree (DT) will cause a warning
>> for 'overlapping memory reservation'.
> 
> Then you can grab a handle to it with of_reserved_mem_lookup()
> and of_reserved_mem_device_init_by_idx()
> 

The memory HOST_DDR_REGION_TYPE is a bigger memory around 43MB, while the memory
BDF_MEM_REGION_TYPE is smaller around 256KB within HOST_DDR_REGION_TYPE, Using the
above mentioned API we still have to store the offset in ath12k to point at memory
BDF_MEM_REGION_TYPE from the start of HOST_DDR_REGION_TYPE.

