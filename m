Return-Path: <linux-wireless+bounces-18077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5BEA20FA4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245A41885BA0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12131581F1;
	Tue, 28 Jan 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FRP5Xavk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BAE1EEE6;
	Tue, 28 Jan 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738085685; cv=none; b=RmzRC5FLK8wAxoOqaZeb+lWSo3ZD6/6uWkiO7FqBBkPWAh/gL4qjn062IKty1F8GZnMlmv82OKKcskblBow77QfvuNlRhpHONlASZoqqHKPdEBPlMnE3hfTmQjoOcfcBeMPvHvDHPcy4TM5bPEGq7Hq2twNYsJq726kk0AnVPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738085685; c=relaxed/simple;
	bh=Z3hziaJj19jRiKHPij/W67cwPZ0GjZ6AHXjd8gMHN0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=emNRBsK1afs04a34f+7T0im/cqFsBxC14AIzI1KYoqaTR9mHfJ3nnXKUMJ96d6GMm+/JL7/JXqZhOV2zUfkw1ew/f3XpjvbX161Wf8GC9spNjqqIsGkmEamJnle6XkZI0m8BdKRYVmAuNh1Zl28rQQD2cg6iOTROWpOZV+ijRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FRP5Xavk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SFqVbj032373;
	Tue, 28 Jan 2025 17:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4E/11L6bTr/abK1jSaUDzqcbdGdMmdVqWMAVsWUG+4E=; b=FRP5Xavkct1J9Pvz
	gUSLKTIu2z9q+uhaaQ3tMvvYYaUz/20xU10LcUQ5TUbalMWsEuwQGJsuJIhPsxic
	HXOny3uNV3E6f3wbft52DYuUsfri2UZFqBeAsfVDNleJlaGtU9pzOfv/CRhQ6QkC
	mew70Ob7aSvPY+H/a54Up/xcq47q+54f+8mZykqAhvs2+y6Rmc+DvNLdw9V4hb6Q
	57Bkq6QaQQjCSvsW99egU1yUeFwNQHTJ2eXSQZat4s3Cs4gODMphgKoVd9vwZdf9
	aqNtLqf4FsFh/eUfSCl+o8X9FcU7762NT4yxd74513SYrYzsTcxXwvXowlJIcyDW
	ztxPtQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44f28y084n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 17:34:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50SHYbjV024257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 17:34:37 GMT
Received: from [10.216.5.143] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 09:34:33 -0800
Message-ID: <0de7039c-d94e-4857-922f-29274d8632d9@quicinc.com>
Date: Tue, 28 Jan 2025 23:04:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: describe the ath12k AHB
 module
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
References: <20250128091012.2574478-1-quic_rajkbhag@quicinc.com>
 <20250128091012.2574478-2-quic_rajkbhag@quicinc.com>
 <0ca970e7-cc9a-4853-86de-5f01dc6d82a2@kernel.org>
 <1bd2dca3-1fa0-424d-95e8-cdb887f1d9e2@quicinc.com>
 <112fe636-1328-49f0-8f0a-395764e118c7@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <112fe636-1328-49f0-8f0a-395764e118c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: duoJqxOjIVtVhRNbowjgCOArEyuFRZEA
X-Proofpoint-ORIG-GUID: duoJqxOjIVtVhRNbowjgCOArEyuFRZEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280129

On 1/28/2025 3:51 PM, Krzysztof Kozlowski wrote:
> On 28/01/2025 10:29, Raj Kumar Bhagat wrote:
>> On 1/28/2025 2:47 PM, Krzysztof Kozlowski wrote:
>>> On 28/01/2025 10:10, Raj Kumar Bhagat wrote:
>>>> Add device-tree bindings for the ATH12K module found in the IPQ5332
>>>> device.
>>>>
>>>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>>>> ---
>>>>  .../net/wireless/qcom,ath12k-ahb.yaml         | 317 ++++++++++++++++++
>>>>  1 file changed, 317 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>>
>>> It was v4, now v1? So entire previous discussion and feedback is
>>> missing? Go to previous series and implement entire feedback. Then use
>>> proper versioning, proper changelog and make it obvious/understandable
>>> to us, instead of sending v1 after v4 in entirely separate thread.
>>>
>>
>> I was asked to send DTS as a separate series, this is a new series for
>> DTS hence stated with v1.
> 
> 
> But we do not talk about DTS here, but bindings.
> 
> 
>> To address the undocumented ABIs we have changes in dt-binding and hence
> 
> That's v1 so how it could have changes in the first place? Unless this
> is v5?
> 

Sure, I understand your point now.
I shouldn't have sent dt-binding here along with DTS as v1. dt-binding should
go with wireless patch-set in v5.

Let me know your thoughts on the next steps:
1. I will send v5 for 'wifi: ath12k: add Ath12k AHB driver support for IPQ5332'
   along with dt-binding.

2. In a separate series, I will send only DTS changes as v2, considering the
   review comments in this version as v1 for DTS.

