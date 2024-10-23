Return-Path: <linux-wireless+bounces-14359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BE69ABF22
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F91F24CB2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 06:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEFA14F10E;
	Wed, 23 Oct 2024 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="em1ummYv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710A1459FD;
	Wed, 23 Oct 2024 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665928; cv=none; b=BdOCiOn6q/71n1SZBwrNKxlSwGnbzzeAo23A4SMaRHvNtsUuI2m3Kf1Ri1ENkkBq1REAlbM5ISAVrP7oN5hLJTxpbBc3OlOpDd6RggIaCYfdl6TxZ//5G79kRU4bcSHQv7468tkxyHYc7tPzMyiUJvCx1xA+bFenySIJpC20I2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665928; c=relaxed/simple;
	bh=j8MoC15b1OPA0J9S9VLK2gdBsI8MGpapT/XVO/GvLr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N7Ycnd/7Gc7pgPZl4AZJx8wpYxa0COSINELav6Dde9R7USxzr8/kANyhtKGD0Jq4DzwofuTm2BUflyildXtuvtzCwzdd/DHsw8pjcoQl61qIOFqjZzb+9xsKQVi5nHK9+bNIfWL8wruzseRhxJf1+IMPIn4tfm03uk7BKGlK/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=em1ummYv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLasTt019397;
	Wed, 23 Oct 2024 06:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WKer+qmsX85eCHTIFwvdJ15J6kE+HZrwwYYsPxb0rqE=; b=em1ummYvKwdsqeZ6
	cil+dhFZaQQ2kXKRyh3tchblFvNkQ5pugpJNSolVjPq91xu1QSDJ0qrjuNBqk8Kw
	4S67tM0wY0XUcf2qUsjaH5RKV09KZUtFi6pKQvCfKFx44TUlb+20EavIBbLISTrd
	WC+v+AmF0LLSBCHeu/EYz+gi5nnl97f3IsMEFXsadBBZvZgMuVZjm4ireYyReW7P
	4WH20XPjCZ/ZEf2kq8l23/BTsqytgzn5GWnR0eNSF3tePR3dc0r8XAD5/MUZkhOn
	m9LEVGlYJyn36pxvNNpLrWlU91Zfx4idXTP1FjunBPBTeXThQbtP0Y3rANALF+5r
	UGSDtA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3w945u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:45:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N6jJLk020788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:45:19 GMT
Received: from [10.151.40.160] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Oct
 2024 23:45:15 -0700
Message-ID: <e2c1ce1a-89af-4feb-a21a-9ca2578430e7@quicinc.com>
Date: Wed, 23 Oct 2024 12:15:12 +0530
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
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <87db3d68-ab1a-4cc4-9857-416de39cea0f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9iAiefvrxc4lCyFXutX_lbqBdZ0e_L1y
X-Proofpoint-ORIG-GUID: 9iAiefvrxc4lCyFXutX_lbqBdZ0e_L1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=707 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230040

On 10/23/2024 12:05 PM, Krzysztof Kozlowski wrote:
> On 23/10/2024 08:03, Raj Kumar Bhagat wrote:
>> The current device-tree bindings for the Ath12K module list many
>> WCN7850-specific properties as required. However, these properties are
>> not applicable to other Ath12K devices.
>>
>> Hence, remove WCN7850-specific properties from the required section,
>> retaining only generic properties valid across all Ath12K devices.
>> WCN7850-specific properties will remain required based on the device's
>> compatible enum.
> Just not true. These apply to all devices described in this binding.
> 
> NAK.
> 
> Don't send patches for your downstream stuff.

This is not for downstream. This series is the per-requisite for ath12k
MLO support in upstream.

In the subsequent patch [2/6] we are adding new device (QCN9274) in this
binding that do not require the WCN7850 specific properties.

This is a refactoring patch for the next patch [2/6].

