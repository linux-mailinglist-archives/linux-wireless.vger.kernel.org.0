Return-Path: <linux-wireless+bounces-12457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ED496B2E2
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 09:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2211A1C23630
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A5F14659B;
	Wed,  4 Sep 2024 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p7Dp7xyi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189F145A05
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434900; cv=none; b=rokP9WHoQdI9L0mHcfWff7OGXGi5QLbQgLJoz6oEG3iPlpHL3zXVOM9mBBlIObLW0ED405fHRds7h51QVsttYEZPhr8fQw7NPF3qm8ts26EXLH6kitGPw1Z3pKjYqbhHHn13YSz7iDKtXB8/EVVoaMnT6fzmZeU9GoEdY442lmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434900; c=relaxed/simple;
	bh=D0Y+5y+Z251GNEEVwnNxqC6pzj+Y93wJOnm/mroVsZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aiXJvSRzQzsRhSmUfkLe0Wxmr7ehvu3Z8o2QygDHCYgvswK8Bn3+oRkWh9oHV5BoG90WHcsXOC5kjDisS2n4a4xzdmxNJlMDnjbpcxDqNj2oglO7eM5sn8p+JMnlMmPkZ0r2S7cc/9OmModNf7sw9Y43+yTse6VrJ6XtFzJ8Qec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p7Dp7xyi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LhY2n004948;
	Wed, 4 Sep 2024 07:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DZPHPgFE2y2jIq87+7Pqn8sjg0KCVwLtQG7t58n9728=; b=p7Dp7xyiCvLD94pP
	nlNbtH4O7Qqf3D3BtpfPJQg8naO7lQ8nWBUxTi4MahasrTBhnY4j0m96CY3AE2xM
	BPSpgUDX/VGuhEUBq5VbfOjZDQ4Fg1DnOlzAu/UKs0sFQW0cVNPz6dJurO8vOlR5
	fvx30NNs369apZqPfKXTUFFYzpHNHLqsQedubbc2ia6dKAtJeDGAHZsF1XIrpAu2
	0DSxMKHr1idCTGhfbTCi47+zwwhGAY33Z+YHzWXQLcrYavBMB4IIdv87XWC1Wc6+
	3JzFhMX795JP/R+ylqZ/M8TtEjsc/XY4SRC35ME5S58iCUKUHU1Afo2kEr6jc2qY
	jsRzxA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41drqe45k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 07:28:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4847S0uj005917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 07:28:00 GMT
Received: from [10.216.28.224] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 00:27:58 -0700
Message-ID: <3555f0cc-2177-4afc-9879-6a78850d2bc2@quicinc.com>
Date: Wed, 4 Sep 2024 12:57:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/18] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
 <20240814094323.3927603-2-quic_rajkbhag@quicinc.com>
 <f8cd9c3d-47e1-4709-9334-78e4790acef0@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <f8cd9c3d-47e1-4709-9334-78e4790acef0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YN0bEnjcaZL8b0Mqdzn6-wlfk_A4mhrq
X-Proofpoint-ORIG-GUID: YN0bEnjcaZL8b0Mqdzn6-wlfk_A4mhrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=904 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040056

On 8/16/2024 11:14 AM, Krzysztof Kozlowski wrote:
> On 14/08/2024 11:43, Raj Kumar Bhagat wrote:
>> +  qcom,bdf-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      System RAM memory address reserved for board data.
> 
> Also drop. We do not store RAM offsets in DT.
> 

Sure, we will move this to driver hardware parameter.

> Best regards,
> Krzysztof
> 
> 


