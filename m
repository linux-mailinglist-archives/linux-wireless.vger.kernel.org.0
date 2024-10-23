Return-Path: <linux-wireless+bounces-14363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B09ABF59
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2111C21278
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 06:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715814AD3A;
	Wed, 23 Oct 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A3ba63Y7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBD6EB7C;
	Wed, 23 Oct 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666425; cv=none; b=akprxsbAUxK0N7Pm93DW3jajdGj9hQCSWG977LCfbx8KOAZ7PlPMMz8LKGUSIYUOJg9DTidAC7ij/iHAzoy+XLWZPwhFCxnkpKq+kDIrzXKZH15fGS7xgrgYtIq4P248s7yznNNcLpRYZyfReacDXn/L1jz0LnHuuMMPOH3xnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666425; c=relaxed/simple;
	bh=Q/xcJ+iRdj0rrmryaUY02+UfmDoPLuPn1s6lQnZEVL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GWP0k8VY1/wTzNBJQD0X2DnVWHTtxkAiXsEkLuFZ8aulMNQO4/CanINH2ZdWv+izKkMmVP78SB9ChSmamvU6BaQinYjW3SXRPKyPJ3f4/WDratlxAoD6ppBf7IgqwQwRnZNuDWlqhugdCEhNnHU5UX+UoYVqh2rfZU27guNd1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A3ba63Y7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLZuoV017391;
	Wed, 23 Oct 2024 06:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q/xcJ+iRdj0rrmryaUY02+UfmDoPLuPn1s6lQnZEVL0=; b=A3ba63Y7IpxUpHdp
	m2pX4rZ/yDW9Ud6BFxYh37iyUymih3YluvYR3lupNYQfxOU812tEyqnngwfPXZA8
	xuuIb8SJnXnInx2Aox6XYsa4vnNpq2Ib3sio99FjgDy+ij0uNKQuHdaABDWm97ue
	2iXo1sH/QdUY93BhuRn+HpVUI6uYyCI5NbjCRj3EQnV+DFDBNeao5wE6n+/0B5mZ
	xT9pp9e9EqtxZw8N2HliRlXM3XYhmrCfr7AvNTsYSr5fm/Tx0zGmn9bY7/aJbb9S
	aJQLzIao5OONdeph+VHyB0ArL4FCx7XKQwT3XzVcTqH67XWjNa+nAgehUJ6xDvdw
	+uShXw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3w94s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:53:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N6racb031862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:53:36 GMT
Received: from [10.151.40.160] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Oct
 2024 23:53:32 -0700
Message-ID: <e7b27f57-efb2-45ea-bbe0-e5aeb90cbff9@quicinc.com>
Date: Wed, 23 Oct 2024 12:23:29 +0530
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
 <e2c1ce1a-89af-4feb-a21a-9ca2578430e7@quicinc.com>
 <b97b8350-3925-40b0-8f87-f89df429a52a@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <b97b8350-3925-40b0-8f87-f89df429a52a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DMGvM9A_59mrmXjV_SF-turbPRBobcxQ
X-Proofpoint-ORIG-GUID: DMGvM9A_59mrmXjV_SF-turbPRBobcxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=680 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230040

On 10/23/2024 12:17 PM, Krzysztof Kozlowski wrote:
> On 23/10/2024 08:45, Raj Kumar Bhagat wrote:
>> On 10/23/2024 12:05 PM, Krzysztof Kozlowski wrote:
>>> On 23/10/2024 08:03, Raj Kumar Bhagat wrote:
>>>> The current device-tree bindings for the Ath12K module list many
>>>> WCN7850-specific properties as required. However, these properties are
>>>> not applicable to other Ath12K devices.
>>>>
>>>> Hence, remove WCN7850-specific properties from the required section,
>>>> retaining only generic properties valid across all Ath12K devices.
>>>> WCN7850-specific properties will remain required based on the device's
>>>> compatible enum.
>>> Just not true. These apply to all devices described in this binding.
>>>
>>> NAK.
>>>
>>> Don't send patches for your downstream stuff.
>> This is not for downstream. This series is the per-requisite for ath12k
>> MLO support in upstream.
>>
>> In the subsequent patch [2/6] we are adding new device (QCN9274) in this
>> binding that do not require the WCN7850 specific properties.
>>
>> This is a refactoring patch for the next patch [2/6].
> It's just wrong. Not true. At this point of patch there are no other
> devices. Don't refactor uselessly introducing incorrect hardware

Ok then, If we squash this patch with the next patch [2/6], that actually adding
the new device, then this patch changes are valid right?

