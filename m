Return-Path: <linux-wireless+bounces-18289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA42A254AF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 09:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF2E161B22
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388601FBEB3;
	Mon,  3 Feb 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="moU2QYT4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB51FBC92;
	Mon,  3 Feb 2025 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572201; cv=none; b=KGe252LYa6EuVRBj3AQS2kL4TSVAcHwDUn9K7FIyi0gPKNIWWgPNLhOmxlAy8Jt6i+V8EowpSeZ4ara0yhC1Mz7hJ7dWGI6pqM8uVJigPW0PLBoHWGDghYzRhy2hpgbitvAJppl7gqThIuhWM6L1QsjjOxfhOXiKA+X5AxqVZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572201; c=relaxed/simple;
	bh=bc1imZ392wL8wBviv+l/3GFL8qfrorBj1RgtEI1IFNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JZKMR//ihOmAGlDHC+rLzLRE27JswV0mBVgEnFeoNU0+W0U+r4BFn7WElXHbsPxktnRJHilvPfy+eYXjFQg+/K679FhlGi/qscvaF0S6+cIKAYh14plhEhKM9YAXEBzedeE5wECi5yw0TUvpEyd3PV2qGxFlkFeqCmTSvwdzGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=moU2QYT4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5135kj5x006360;
	Mon, 3 Feb 2025 08:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0KFPGyBP8cFud5VuycCONVstDIPld15I4GQjTCSxAiM=; b=moU2QYT4a/pEO839
	qWSTwy7IR3/Ztry758QifN065S8qqKp5pSdoFbxOWqNUEgYGzxaApeFO21taw+qO
	xg2XCL12xdamXvsJ+gf6em/JMGmsZjI4ioy0LnxpkJROCAyrpg+jLF4pI9Hb/elr
	scRfvd8uiRMDBGCU8eHcoV9r1zwkN8jc1faim6AR4k441wMcgyprprer+wVytWDM
	4/JGewvP4LRwirm2jbo0JuHzJGqUtNaniqToCbphZHCDdQVOzJHx81a7+MMv585n
	rK/zr3R6zMTToin39wNSS2DZmU4U7j13aRAK6fT2Ik9n3ULk8TJF9w16fwEGzVl6
	9HCbbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jqxw0c8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 08:43:13 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5138hCWu017000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 08:43:12 GMT
Received: from [10.216.42.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 00:43:09 -0800
Message-ID: <a3c7b0e6-a440-4452-83a2-eb95de0de9bc@quicinc.com>
Date: Mon, 3 Feb 2025 14:13:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/13] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-2-quic_rajkbhag@quicinc.com>
 <20250130-cunning-quail-of-opportunity-76d0ad@krzk-bin>
 <104e6b6f-3c1e-4a00-8822-aa6fb4562411@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <104e6b6f-3c1e-4a00-8822-aa6fb4562411@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lj1rFYiMu8IQ3m0ApuY4ljvBmZW9USKk
X-Proofpoint-GUID: Lj1rFYiMu8IQ3m0ApuY4ljvBmZW9USKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030069

On 1/30/2025 2:10 PM, Krzysztof Kozlowski wrote:
> On 30/01/2025 09:28, Krzysztof Kozlowski wrote:
>> On Thu, Jan 30, 2025 at 10:04:56AM +0530, Raj Kumar Bhagat wrote:
>>> Add device-tree bindings for the ATH12K module found in the IPQ5332
>>> device.
>>>
>>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>>> ---
>>>  .../net/wireless/qcom,ath12k-ahb.yaml         | 319 ++++++++++++++++++
>>>  1 file changed, 319 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>> new file mode 100644
>>> index 000000000000..bd953a028dc3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>
>> Filename should match compatible. This binding does not look like
>> supporting more devices, so there is no much benefit calling it by generic name.
> 
> 
> I saw now your other patchset, so you have here two devices, but I still
> do not understand why this cannot follow standard naming practice like
> most bindings supporting one or more devices. Like every review we give.
> 

Sure, we can rename the filename to match the compatibles - "qcom,ipq5x-wifi.yaml".

