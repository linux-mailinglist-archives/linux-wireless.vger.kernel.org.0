Return-Path: <linux-wireless+bounces-18292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7D2A25573
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 10:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2746B188503C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326CF1FF60F;
	Mon,  3 Feb 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CwOv10Rz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329D1E0B9C;
	Mon,  3 Feb 2025 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573664; cv=none; b=J4FX/9NMjpN81J6k9tsjmcxj8S3vf0AA5xqXJbwIeTivuD+7rH+4uBW/AHgJdeYLBj9ndrvY5Uha8h9pLSZkhes73JYEy6tXmzANfiqmHt1NFwMAhVBZFd5cNQ1DL21Ba+zDBxFuxb8FLt7KQpi92KkA63gHI9c9CKv5pttRcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573664; c=relaxed/simple;
	bh=LrNaaAN8CgnFf01cXAm64Gx08zjhLQl+u8QYVB21upg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M8dnnbsxz5RnnrVwkqBJOqdOq4Ki1sVG/3TT+molL0SGtqQyhpZFCT8IDQkm4WG4SekhNGc42x0i7tEv4LqHR390mR5bCg8Qnwqm3MHsjkxCKhIV5T7ATN9dF0K9O+4MPVNoY+q/Kh5l6o0qkohP3zDjhe2P8vXUdjRmp4iEx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CwOv10Rz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 512LjB2r002355;
	Mon, 3 Feb 2025 09:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5IFJybb1pcE7296a9/K0sJwN2gUdU48QFivEoX0a/tA=; b=CwOv10Rz0A8i3B2d
	eDMBndMgXdyaiBCA2LYnmFNjBYqpDf5BOa6iHHk6RFb81eTMEN01BOswJzfrYnHZ
	Lfs7jVgYKAaosoumrx9MjCgNKOyVea255LAIo2mbs6yYjaPoxYdOsrscpNc76bj0
	054frG6ObWkqA9OIz+WXFAkPpwZQIDS9kX7XOUHdcFa3EOhQPH1zGAWfOsndfRYk
	tjJQGOR5S6QQgiZDbuY+vmDTyuP4dpuCPxvFKfiuHc5Zu+mdgU68vMzjN04tt9Ji
	dOSiFNBVZiGBVWUFWaWMPtdADQEk1iY24ojvzszVYdIeGqxhyryRag9RZvwyhVYu
	G/jHZA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jc0t18tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 09:07:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51397UwK005999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 09:07:30 GMT
Received: from [10.216.42.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 01:07:26 -0800
Message-ID: <2f0b8022-c04d-4375-af47-b3f7d4cb9ba2@quicinc.com>
Date: Mon, 3 Feb 2025 14:37:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/13] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
 <20250130043508.1885026-2-quic_rajkbhag@quicinc.com>
 <b3637222-d79a-4019-8155-d14abbadd6f7@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <b3637222-d79a-4019-8155-d14abbadd6f7@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JdTKmWgd7-duw_WL0P8Do8ZpM87UROdj
X-Proofpoint-GUID: JdTKmWgd7-duw_WL0P8Do8ZpM87UROdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=884 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030072

On 1/31/2025 12:37 AM, Jeff Johnson wrote:
> On 1/29/2025 8:34 PM, Raj Kumar Bhagat wrote:
>> Add device-tree bindings for the ATH12K module found in the IPQ5332
>> device.
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>  .../net/wireless/qcom,ath12k-ahb.yaml         | 319 ++++++++++++++++++
>>  1 file changed, 319 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>> new file mode 100644
>> index 000000000000..bd953a028dc3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>> @@ -0,0 +1,319 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-ahb.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies ath12k wireless devices (AHB)
>> +
>> +maintainers:
>> +  - Kalle Valo <kvalo@kernel.org>
> 
> sadly, you should remove Kalle since he resigned as a maintainer this week
> 

Will update.

