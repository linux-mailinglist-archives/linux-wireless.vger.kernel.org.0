Return-Path: <linux-wireless+bounces-18062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E901A20754
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112F63A32B6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD531E0489;
	Tue, 28 Jan 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K5N5u7lQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A41DFE1D;
	Tue, 28 Jan 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056564; cv=none; b=GbL5ZvRf1pZf+WUTpsP85fK6IspnNif3aNLD6xk9H76tnJSRYkJu2fB2z/JfkoW5NCW9XO+vq9tnZ5hnXGBDQjYzpL58urqvTGYLiRwKdpyFfxmxpCkpe9xKIThnWNbsW1q2sxYuYysmuA5gaMW9qa1+lI1DAVdXR9JBEJuj9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056564; c=relaxed/simple;
	bh=efk1dgvlYW88vIHhxfjxNBZTM8CdBATup+ASwZsHJ2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fd9JbvOtA0+pKqP8Dx07CZtOhm3DC52LCGYFzYjjxcHTD9nnwj+rLC5oX/48tjcegFV1pfg7kPkGE/aXoAuAdfNqgKHIyaAgaTgpDHdf/F+jH9loNvbhRuKsB3zU4ISYLrLYbwiui9KoHkPR+KcEw0FdjCY1wQBUKxM1n26nl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K5N5u7lQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S0VocD002950;
	Tue, 28 Jan 2025 09:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	claHLXbH5lmJ3EZDLUdZVqkZ81FgUMtb2qbwvcKR/tA=; b=K5N5u7lQvCwlwJOo
	BQBzHL0v09pQ9KBzSWq+FDxrBAZtlK6xqv7a6A72oK7fzXcNzTMM4Te63cFTLfVg
	R7ZRrqiIm0ne0ctJHDs+jrKRoT21rAZaKnV8+QlYFtGJvHAfUs8QXWEtlXjFLMwW
	mfOwjs5AM/vAkiU9P+yI27oeNtcnBkvYgolobDFwuMJ3WxMyXcJi3ToGrDTQ5bAh
	mqnyTjbpAGnpj0Go4oTADRfzZDNPQbAb2M7Kdt7aoXRuD02Q0l0CpZXqz+VdwNBr
	yJwLLEryAahjX4yyxjqU+rToX1ZN089Bpiv30HFmfWjYjyhuY7CA55nnmHBjWTgS
	y/eTpA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44emry0ws2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:29:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S9TGxY001567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:29:16 GMT
Received: from [10.151.40.239] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 01:29:11 -0800
Message-ID: <1bd2dca3-1fa0-424d-95e8-cdb887f1d9e2@quicinc.com>
Date: Tue, 28 Jan 2025 14:59:08 +0530
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
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <0ca970e7-cc9a-4853-86de-5f01dc6d82a2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: whHjXphh8AbHOZkHJhbuJxESvrcjNOY5
X-Proofpoint-GUID: whHjXphh8AbHOZkHJhbuJxESvrcjNOY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280073

On 1/28/2025 2:47 PM, Krzysztof Kozlowski wrote:
> On 28/01/2025 10:10, Raj Kumar Bhagat wrote:
>> Add device-tree bindings for the ATH12K module found in the IPQ5332
>> device.
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>  .../net/wireless/qcom,ath12k-ahb.yaml         | 317 ++++++++++++++++++
>>  1 file changed, 317 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> 
> It was v4, now v1? So entire previous discussion and feedback is
> missing? Go to previous series and implement entire feedback. Then use
> proper versioning, proper changelog and make it obvious/understandable
> to us, instead of sending v1 after v4 in entirely separate thread.
> 

I was asked to send DTS as a separate series, this is a new series for
DTS hence stated with v1.

To address the undocumented ABIs we have changes in dt-binding and hence
corresponding changes in driver as well. Let me know If we could send the
complete series as v5.

> I also do not understand why this is sent to arm soc. That's wireless patch.
> 

All the email list are as per - './scripts/get_maintainer.pl'

