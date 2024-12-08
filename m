Return-Path: <linux-wireless+bounces-15997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341CE9E8585
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2024 14:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF40928147F
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2024 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E9146A9B;
	Sun,  8 Dec 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QJMLWZNU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F09A4A3C;
	Sun,  8 Dec 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733665821; cv=none; b=ZpV3wOduRqyUluHrTRwm3m5WRIDH+jC9/lHvvMUMLsWjWAeNgdHgSIoK1YXlDPJzciCFonGDszSS7L70NZjl77HPQ0N7JENDPTjNvdj+P5dAcWxN9gT6vI5BCFV+w9ZCwwVclNR+Q+tjWhloCXBeN5dyU7Jv/KRiEttn7MGe34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733665821; c=relaxed/simple;
	bh=LxmDDqYbaja4yoa1NRmDWttnyg7U8BpMJIm0fa6JNkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nlbo3vlYppQjgAKWPlHD91E0XFoSmBHWijGdfE0qpXu9xwUAQliMdC3o6p6jDuD1t8EJ+iYfGaurfesZvdg8Y2309xyN45fAFu15Qyyr8cjdQOKJAbxusRJ++fFxlvB+g8HiwFZ5VWuedasx+gOE+FzQYCi73PkIUA8TrRXIo9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QJMLWZNU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8BcCQj025532;
	Sun, 8 Dec 2024 13:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kSY3DabKpvKQm1e3Iv1xKNvSWSQ2t4BSi/1v6tcaeG4=; b=QJMLWZNUDdKw6K2a
	6zhlWdHX7MeZ4nHCluBQWzMG/AQUr/gJaeeiGjibg52gq1qZHscaRlJ8YmxC2wNt
	rINLgY02GEqFSUoryHfYuRPnIxsTIYOK0vQcnUNB3m3fkGxPO6Y3bwT+SgBlrhMp
	mD+UGDj8Oh3GVJfmhu2XHvIIgEDrNeo5yT+hCwNw6lB4vehRJKb6wXbXei1K87sf
	Ztoh+MbYNO7Hrn3iQaE2iUNZbCWbN17OmWnyM6ytK6S9fQZ18RU4clSxjgdu5SJH
	PcWYA+dfRymvvu/7fJLTNbInI5d2qsOyORjTRMjrvXBSJb0iktI3W9c7zDDuFD7h
	O1pfEw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cfhka59n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Dec 2024 13:50:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B8Dnx2F012911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 8 Dec 2024 13:49:59 GMT
Received: from [10.216.28.219] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 05:49:55 -0800
Message-ID: <ef4d978d-f530-4988-8da9-9b32a5f16c21@quicinc.com>
Date: Sun, 8 Dec 2024 19:15:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/22] wifi: ath12k: add Ath12k AHB driver support for
 IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <ou5kgedz5aga4dtda6k23uhybcjy7mfwie74p6q3qyn5bdajz7@ftejp7lqrise>
 <0b2f8734-f502-42d7-bdc5-b0d382d2aa70@quicinc.com>
 <cda109c9-a1e2-42cb-b830-6764c6eef519@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <cda109c9-a1e2-42cb-b830-6764c6eef519@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 83HwiWuzEg6npDPjLJZef7u1Beekarbe
X-Proofpoint-GUID: 83HwiWuzEg6npDPjLJZef7u1Beekarbe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412080115

On 12/6/2024 6:25 PM, Krzysztof Kozlowski wrote:
> On 06/12/2024 12:07, Raj Kumar Bhagat wrote:
>> On 10/16/2024 12:27 PM, Krzysztof Kozlowski wrote:
>>> On Tue, Oct 15, 2024 at 11:56:15PM +0530, Raj Kumar Bhagat wrote:
>>>> Currently, Ath12k driver only supports WiFi devices that are based on
>>>> PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
>>>> Ath12k AHB support for IPQ5332.
>>>>
>>>> IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
>>>> device:
>>>> - Add hardware parameters for IPQ5332.
>>>> - CE and CMEM register address space in IPQ5332 is separate from WCSS
>>>>   register space. Hence, add logic to remap CE and CMEM register
>>>>   address.
>>>> - Add support for fixed QMI firmware memory for IPQ5332.
>>>> - Support userPD handling for WCSS secure PIL driver to enable ath12k
>>>>   AHB support.
>>>>
>>>> Depends-On: [PATCH V7 0/5] remove unnecessary q6 clocks
>>>> Depends-On: [PATCH V2 0/4] Add new driver for WCSS secure PIL loading
>>>> Link: https://lore.kernel.org/all/20240820055618.267554-1-quic_gokulsri@quicinc.com/
>>>> Link: https://lore.kernel.org/all/20240829134021.1452711-1-quic_gokulsri@quicinc.com/
>>>
>>> These are series targetting other subsystems. I do not understand why
>>> you created such dependency. It does not look needed and for sure is not
>>> good: nothing here can be tested, nothing can be applied.
>>
>> To validate this series, the dependencies mentioned above were necessary, which
>> is why they were included.
> 
> What does it mean "validate"? You are supposed to describe how upstream
> can consume this.
> 

"validate" here means building an image, bring-up DUT in AP, STA or Mesh mode,
associate Station and run bi-directional data traffic.

