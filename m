Return-Path: <linux-wireless+bounces-18063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCFAA2078C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 10:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDE1188491A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1898E199385;
	Tue, 28 Jan 2025 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EGTg2eQl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C7C2ED;
	Tue, 28 Jan 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057292; cv=none; b=oNXAE7XoddN+NFPWM6yRtBg6MAnQBzd0X3tTohcnDg70PKYOK0LOgoMXP3pqy9Qz5DedrlM8jkULUNGF7nPBlLBUo9wZN/LDUAJX/LPIWrdHyodog3xOFymdwpndyhGh6xLhC6n3bScAhsuQ7n8xfAI4xOawuNPWIqV4mmVj9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057292; c=relaxed/simple;
	bh=uBJKX/d+0J/YgvDZkVAOZ/0xe4feKJ3rGDkSkrVnI7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Obt3O6MDLVxY0pq6pkdzITnb2dtr4v0w0CjHgYSzcxEQTt3QgyKSJTrID+yFv6o8l7seeAOVq9UgSkXwlq68fI8FFbUyevRIkvVSD5Eff3EpK28UGP36JS9BMZMWU/9SpKYJcXT4rXiAHgiLt3eghmWK92qEkdDKJSCRpq7uuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EGTg2eQl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S0Vod2002950;
	Tue, 28 Jan 2025 09:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qGkukPgangna9iKZ9EqZRIQO3/75FNBNDmH6yVQC8Yc=; b=EGTg2eQlc6xnjhih
	2GBoYy6TdK902JddumNFzFOxWA7HXkRqpQWiRMuSoJeZmrop2Q1PIBuKLipReuJE
	MWQAFl1QpI3GJPYlWUsAN4SZ+JF+zl40g4N9a+FLSfI7mqaLa5RJa1JXadVlRsTu
	dEPYoPMDD+OOc4Mhq8A7AVMi5VxJ6ne/uksGm39UPlqm2xLuctq89ZtLCOLmY/VR
	KGcmHZATLwxhNaCq9aRGDQTRcBmWNArFip13HB5jbr44mfxuOmY5LwcI8s34Ukko
	DGinNueCpQqyy967BTwJhQ5bovwqmiiETvmqSGne2jA3xUQpqFo6BQSVUjAGjcIX
	k/E9UQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44emry0xk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:41:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50S9f8kr014863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:41:08 GMT
Received: from [10.151.40.239] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 01:41:04 -0800
Message-ID: <a752a135-9cd0-402b-b0fb-967491cfdaee@quicinc.com>
Date: Tue, 28 Jan 2025 15:11:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: add wifi node for IPQ5332 based
 RDP441
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
 <20250128091012.2574478-3-quic_rajkbhag@quicinc.com>
 <b3ff05c1-6424-4ace-a873-ddf1a0d3d07d@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <b3ff05c1-6424-4ace-a873-ddf1a0d3d07d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: przWctJGitIxmfNxgpsBrbJOG3EQ-dX2
X-Proofpoint-GUID: przWctJGitIxmfNxgpsBrbJOG3EQ-dX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280075

On 1/28/2025 2:52 PM, Krzysztof Kozlowski wrote:
> On 28/01/2025 10:10, Raj Kumar Bhagat wrote:
>> +	/*                 Default Profile
>> +	 * +============+==============+=====================+
>> +	 * |            |              |                     |
>> +	 * | Region     | Start Offset |       Size          |
>> +	 * |            |              |                     |
>> +	 * +------------+--------------+---------------------+
>> +	 * |            |              |                     |
>> +	 * |            |              |                     |
>> +	 * |            |              |                     |
>> +	 * | WLAN Q6    |  0x4A900000  |       43MB          |
>> +	 * |            |              |                     |
>> +	 * |            |              |                     |
>> +	 * +------------+--------------+---------------------+
>> +	 * | M3 Dump    |  0x4D400000  |       1MB           |
>> +	 * +============+==============+=====================+
>> +	 * |                                                 |
>> +	 * |                                                 |
>> +	 * |                                                 |
>> +	 * |            Rest of memory for Linux             |
>> +	 * |                                                 |
>> +	 * |                                                 |
>> +	 * |                                                 |
>> +	 * +=================================================+
>> +	 */
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		q6_region: wcss@4a900000 {
>> +			reg = <0x0 0x4a900000 0x0 0x02b00000>;
>> +			no-map;
>> +		};
>> +
>> +		m3_dump: m3-dump@4d400000 {
> 
> This fails with your wireless patchset.
> 

Yes, this will fail with v4 wireless patch.
We have v5 (yet to be sent) to read the correct reserved memory. Since,
in v4 I was asked to address and send DTS patch separately, The corresponding
driver patches are yet to be sent.

>> +			reg = <0x0 0x4D400000 0x0 0x100000>;
>> +			no-map;
>> +		};
>> +	};
>>  };
>>  
>>  &blsp1_i2c1 {
>> @@ -63,3 +104,16 @@ data-pins {
>>  		};
>>  	};
>>  };
>> +
>> +&wifi0 {
>> +	memory-region = <&q6_region>, <&m3_dump>;
>> +	memory-region-names = "q6-region", "m3-dump";
> 
> Binding said you have four items. I don't understand why this varies and
> why this is 2 items instead.
> 

In total we have 4 items, with minItems as 2.
The other 2 items (q6-caldb & mlo-global-mem) functionalities are not yet enabled
in ath12k driver. Hence these memory are not reserved yet.

