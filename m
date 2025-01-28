Return-Path: <linux-wireless+bounces-18057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798AEA2070E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 10:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F7A18862D2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B61F6663;
	Tue, 28 Jan 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EGpKASGH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E261E0DEA;
	Tue, 28 Jan 2025 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738055800; cv=none; b=sz+ORJ3zN3Ud7bSeU55iCnyFLKqwLTbcXJUXI65MlYFzl2aoLfRMmJwt52rweMHUijmnLFD7aDE2JHsiiCPGlkkO4GSHaXAkL+OOowqS4y+U4tYmA75x0d60tPDpGoqF95bmbeXJBerQPdj0oLXlke9XbZBRoqfFHQ/7qSrNjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738055800; c=relaxed/simple;
	bh=8X2d8yAB0710R5cSUdUEeUdKbAxss0pvQdv4R1dFniI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IkqR91f4RME69+V7hTg5W2ltKLDEezwmCJvdsFOuqGRhtP+w4lj/eENjDuOExJQcgUvLx8RC30SJIKAe9QW+EhHcLfeOx8ZFHfOISd9psNPFjHoMPtewnKFyhv8k0AsyDCHzjbmSjpqIX4k2WhtM6ZJFH2NsjpAvaytfXddnGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EGpKASGH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RNmNrK006090;
	Tue, 28 Jan 2025 09:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xezB8n6Rfd+/Rmbbwa/0KA+P+sdz/ttAlpqai6xIpfM=; b=EGpKASGH6QYI1yQm
	ZbM2r5HKW3YfyTSHiDzCC83yiwfVFmlXf00W8ieh78k/v2g5zPNXzEdhpFQb7uwB
	/oZ4bq/xDONFWI4Bbd14ZcfIPVoTnB1itSDM3NE0el4KRrWlIQvtTBQy8cNdYvge
	ArggHuoqGEbsU0wb7gfctRkCwloKlfomkHf3qzKz4IQ9qFS7WHhNi9E1lH29VFpQ
	yBB5gxGxAFVBRVPgnzRUc3+TQr9IKkz6vz15bRxEyvt6UUyeYBQ3ekAd66rTBH3z
	CbjwIR+vmqEaPpJcCOBKJ3TGvMREAh2+W/FcYi/Mydj9VdVMYrWpLcrF1V2patw4
	qb/EuQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ed5g9v7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:16:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S9GYlm021541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:16:34 GMT
Received: from [10.151.40.239] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 01:16:30 -0800
Message-ID: <af926bd7-730c-4465-a206-4168bb93d01a@quicinc.com>
Date: Tue, 28 Jan 2025 14:46:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] wifi: ath12k: add Ath12k AHB driver support for
 IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20241210074159.2637933-1-quic_rajkbhag@quicinc.com>
 <fd338dd5-db11-4439-835d-b6641f3feb78@kernel.org>
 <001ae2e4-bba8-4b76-a4b6-eda8533c5fc5@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <001ae2e4-bba8-4b76-a4b6-eda8533c5fc5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zay7V2AeBkp-PpnWsfpemkreFXgINVju
X-Proofpoint-ORIG-GUID: zay7V2AeBkp-PpnWsfpemkreFXgINVju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=976 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501280071

On 12/10/2024 8:42 PM, Krzysztof Kozlowski wrote:
> On 10/12/2024 16:08, Krzysztof Kozlowski wrote:
>> On 10/12/2024 08:41, Raj Kumar Bhagat wrote:
>>> Currently, Ath12k driver only supports WiFi devices that are based on
>>> PCI bus. New Ath12k device IPQ5332 is based on AHB bus. Hence, add
>>> Ath12k AHB support for IPQ5332.
>>>
>>> IPQ5332 is IEEE802.11be 2 GHz 2x2 Wifi device. To bring-up IPQ5332
>>> device:
>>> - Add hardware parameters for IPQ5332.
>>> - CE register address space in IPQ5332 is separate from WCSS register
>>>   space. Hence, add logic to remap CE register address.
>>> - Add support for fixed QMI firmware memory for IPQ5332.
>>> - Support userPD handling for WCSS secure PIL driver to enable ath12k
>>>   AHB support.
>>>
>>> v4:
>>> - Missed to include some review list in v3. Hence sending v4 with
>>>   all review list as per - scripts/get_maintainers.pl
>>>
>> The amount of undocumented ABI you add here, points to the problem that
>> either your drivers don't work or your drivers would never work with
>> upstream. Why? Because either you would have wrong DTS or drivers not
>> matching DTS, thus not working.
>>
>> Please point us to your upstream DTS implementing (and working 100%)
>> this ABI, so we can review that you do not sneak more broken or
>> undocumented things. I will NAK also future submissions without above,
>> because I believe you usptream something which will not work.
> 
> 
> I dug a bit and I found your earlier v2:
> https://lore.kernel.org/all/20241015182637.955753-3-quic_rajkbhag@quicinc.com/
> 
> which confirms:
> 1. DTS not following coding style, so not possible to accept
> 2. Driver relying on that exact DTS, so not really working.
> 
> Please post in separate series updated DTS, after fixing all the issues
> pointed out by DTS coding style.
> 

To fix all the issues in DTS (including undocumented ABIs) we did changes in
dt-binding as well.

The dt-binding and working DTS are now posted as separate series -
https://lore.kernel.org/lkml/20250128091012.2574478-1-quic_rajkbhag@quicinc.com/

