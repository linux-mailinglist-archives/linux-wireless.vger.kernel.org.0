Return-Path: <linux-wireless+bounces-19409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C15A435F8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 08:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F037A7342
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 07:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC425744E;
	Tue, 25 Feb 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kf59STFB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A214D2BB;
	Tue, 25 Feb 2025 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740467712; cv=none; b=BfLEjMExRPbfQuKLd59ONjpPt1TPvrqUaBHNsr4+AxW8gildEHeagbnW0hfrmMrJkzCAl5nhGNP+X4nuo02r7kb/w28OxAWJVLkiaEfuc6DuwMaOWMJiJP3HQdSVmYjEsBIqEwt0nr9yJJaqv4GtRylabjRJIiMNsXnXeHBUna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740467712; c=relaxed/simple;
	bh=LRD6OoMszjMiec2Df0s5N0O9u11A0kShWiGsRHii9Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=figAuYefziUrBuqYFIwxUTYE3BX5cRlZIP3Tf2L6cawM5Jvi3WAd88mzt+GhGPPZR6Tpy+XvTEY06aRfZN/xUmgFCvudTrtfTs00gTdwqwLu2kTOhYiZ4X9ygaaureIAcq5v+PjAFz7jm1KABkysdMO7tMvbAkr4kKJG3+2uB8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kf59STFB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKOmHh017362;
	Tue, 25 Feb 2025 07:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RiLylepOzLfAIOw4jKJU+nrVaR7OZmn5yTHoeXsQJCg=; b=kf59STFB4/Ufka3f
	WqTH9aP7ptFmLWdTTU/q+r2lTll6ZE/aUQkFmNSiRF/4X8ZXoW4t+pqP/O0X6gil
	8Zp4/U53QKXoaKhMx1hZUwtPuk0SUNuBlTTO6Xe4I3d3tbYO7kv6GhD5eVQfDZk/
	Kp/ueW3p+mi4lHEICdW2VqlI5MghXgE6YIasc55cz0OZ2805Lm5KqAtNfQhQ84Th
	KQgLi27CeyFy0JPSX/fHR/Lbgw76qHWmpUVpnJAlCvgk3+1ilG0Ud+SnInqxPtT2
	9Z9T92nnMPR8WTAt6vbTMVWGGifcnNHwf55wKVLAZxtsQGNz0+KxhCGjbenSRXOl
	JJAyjQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5k681j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:15:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51P7F3Rs008153
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:15:03 GMT
Received: from [10.216.5.11] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Feb
 2025 23:15:00 -0800
Message-ID: <1989fdc2-453d-48f2-a89a-f0ab5bf582fb@quicinc.com>
Date: Tue, 25 Feb 2025 12:44:02 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] dt-bindings: net: wireless: describe the ath12k
 wifi device IPQ5424
To: Conor Dooley <conor@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
 <20250130051838.1924079-2-quic_rajkbhag@quicinc.com>
 <20250130-divisible-chrome-3f9c5d1aff11@spud>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20250130-divisible-chrome-3f9c5d1aff11@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DaHTu8TE7Mh2Uzc3QpY7kpxbRvFl1S62
X-Proofpoint-GUID: DaHTu8TE7Mh2Uzc3QpY7kpxbRvFl1S62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250047

On 1/31/2025 12:20 AM, Conor Dooley wrote:
> On Thu, Jan 30, 2025 at 10:48:34AM +0530, Raj Kumar Bhagat wrote:
>> Describe and add the device-tree bindings for the ATH12K AHB wifi device
>> IPQ5424.
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>  .../net/wireless/qcom,ath12k-ahb.yaml         | 119 ++++++++++++++++++
>>  1 file changed, 119 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>> index bd953a028dc3..1d24389a0ab3 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>> @@ -18,6 +18,7 @@ properties:
>>    compatible:
>>      enum:
>>        - qcom,ipq5332-wifi
>> +      - qcom,ipq5424-wifi
> Patch should end here, another example for something that doesn't have
> different properties etc is pointless.


Thanks, will update in next version.

