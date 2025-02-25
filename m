Return-Path: <linux-wireless+bounces-19421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A31BA43C12
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8225216560F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2170266F0B;
	Tue, 25 Feb 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WOINB3oy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F1265637;
	Tue, 25 Feb 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480180; cv=none; b=NUQT5SsdE0XQZ+At7kemCvETb9kZwWXm+qSxDzV3d0c1OResXDp8tW9n6mR+FpCCDV7X2PohdU7u0y8ODV+McvyKtt5RTICa6ySQKAvuec1fvz0D+oxS7n0dWo6ZAgos8u6LBneo+O76nXyaNCVlqi8LLvaYzVkfk9Nh3eZeNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480180; c=relaxed/simple;
	bh=fEBg/wU5mCbR2itM6RkNe6Unw48Z+L+8Q0sFIEbBF98=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P+D1D6FQAjTNULSVcud32dp/Ee/F1r9zOc3mrdzF0k3fpFtTRBLj20bzWyKjxWyQzMgI7cX/5yK803ZChF+LbEWMijVP9WC4bIrHJsSv9XL9WMlXyOWVY6mY+HSrjk6o4AyWHCbp00KY1GClJ6QRR2ayJSuMtZmZBMxL+ivQ2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WOINB3oy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8RAXA012887;
	Tue, 25 Feb 2025 10:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	16XU88wAD+XphURLR0i0WLhnTgmgnb4ci4H9C5ic2GE=; b=WOINB3oynodIxR+1
	Tiy55TMVPqtf5Eya4G0C9EfOHY8nE/8i5P6VQyUpo+Hi8WAuACFTS6V11ekdyevn
	Msz/He9edUBaC/wyDfp3ZaTzbaWHCjyjvy3BThDremLlVFOwACqsOWDqzqcbMSLS
	xoDF0y8trv3rcHRxaOd4JHR1IRHW+RpiPc5qCWqv4ah87ISmOsSgkL3YPjxmrZaN
	wGrMhpZ2u9/EBd2w3wx7cZVInkb3FOkhyeHpfd469y53cUYMV91dQeUlDoOsIsue
	zEzNpc/xgp+1emmcCsXEf1V4ES/6EVxDqDQBuKbjBR4TrF3D9rZBOXHn/HsJxKqO
	wC5T8g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y65y0j1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:42:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51PAgmpi007418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:42:48 GMT
Received: from [10.216.5.11] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Feb
 2025 02:42:44 -0800
Message-ID: <57cd7335-3f13-46ea-bf93-7b5fb0f10973@quicinc.com>
Date: Tue, 25 Feb 2025 16:12:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dt-bindings: net: wireless: describe the ath12k
 AHB module for IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ath12k@lists.infradead.org>, Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250225064834.2002499-1-quic_rajkbhag@quicinc.com>
 <20250225064834.2002499-2-quic_rajkbhag@quicinc.com>
 <20250225-abstract-arcane-chimpanzee-ca7e4f@krzk-bin>
 <4c3009e1-6cd8-4477-95f9-b0fb35b7dc4e@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <4c3009e1-6cd8-4477-95f9-b0fb35b7dc4e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SsZahpdsqZziBCZNNAPfFzIqLtbw8OlC
X-Proofpoint-ORIG-GUID: SsZahpdsqZziBCZNNAPfFzIqLtbw8OlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250075

On 2/25/2025 4:04 PM, Krzysztof Kozlowski wrote:
> On 25/02/2025 09:47, Krzysztof Kozlowski wrote:
>> On Tue, Feb 25, 2025 at 12:18:22PM +0530, Raj Kumar Bhagat wrote:
>>> +  memory-region:
>>> +    description:
>>> +      Memory regions used by the ath12k firmware.
>>> +    items:
>>> +      - description: Q6 memory region
>>> +      - description: m3 dump memory region
>>> +      - description: Q6 caldata memory region
>>> +      - description: Multi Link Operation (MLO) Global memory region
>>> +
>>> +  memory-region-names:
>>> +    items:
>>> +      - const: q6-region
>>> +      - const: m3-dump
>>> +      - const: q6-caldb
>>> +      - const: mlo-global-mem
>>> +
>>> +  qcom,ath12k-calibration-variant:
>>
>> qcom,calibration-variant
> 
> FYI:
> 
> https://lore.kernel.org/linux-devicetree/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org/
> 

Thanks, will update in next version.

