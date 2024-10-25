Return-Path: <linux-wireless+bounces-14520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2629AFF88
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 12:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB712824B4
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C51D54EA;
	Fri, 25 Oct 2024 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kc9hnEmm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59681D3584;
	Fri, 25 Oct 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850831; cv=none; b=fClYzla8PRjo/U2USi8DjIxCuDMyxchX+ysQgrJWhtbW377nHPW4k6neyum9OU0ViQ4yO0byumPaQH2OWsibO3ZIqkQ7Nc733rbjG4kWejGP9B8s/wIPPmXK8/5K0puAVPQqpYbGC1XiI68MmB5jFGZQj1KG+AJWqtsTKzGs1RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850831; c=relaxed/simple;
	bh=sRyJ4KdlL76hUgZEKBnCoraiUwdtgySzvQfaKZrpBYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N1EQH1A1PS49vtNzciqKXqvFgNJ/sSptuxHBygjXQ7/TtaVpkmNN0wcSO9ZnamnikDOc+tMxMLAtCyCJdaKe9KU1Izb5j+nZ2JBnWvRXz8GaPUbnBofOmgZiXdWJVP1+yFrirpDKo2elvoioJf30bpk12WRXvUILf2mBH2lPDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kc9hnEmm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OKTs2E007551;
	Fri, 25 Oct 2024 10:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	06IkTi//D5tgGoX99HX3f2NLiU6Qz5QmsybYsvP4yx4=; b=kc9hnEmmI6kMNPiM
	Lns4TJrZ0xpa4dY8PIXKRCaM+eDcUE7ehigiiNRcUslUsjkuKtN2zagk1vUvv64K
	Z3Y0LMnBy9ZHYX9KaaRXP9wzmF+tZWq+oSp69SsT8uMq+DGmZGQ4haRvU5GXN/1R
	aIu4J5E0vvDItSioR0Sb12KJ3IU31DrYqmdXLF9bgzmVcER0esrpoKcRHtkrV2oQ
	lPVUevsjbMhSFaaZ34+zKaLUQg3vbcNwqG+VLFqVkbxQKYA3c3iIDIWDvIXwqyYB
	3vLxMAcBChNXxTO4BjYRtZwWzXnVi/ryRfuSZTPOWE1+3STE/we/3cxIMVJyLA/X
	V8d03Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fk52keer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:07:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PA72Jf016166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:07:02 GMT
Received: from [10.151.41.25] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 03:06:58 -0700
Message-ID: <88489191-2dbd-4018-b35b-84f43f8eb55e@quicinc.com>
Date: Fri, 25 Oct 2024 15:36:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] dt-bindings: net: wireless: ath12k: describe WSI
 property for QCN9274
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
 <20241023060352.605019-3-quic_rajkbhag@quicinc.com>
 <b42da7f0-2034-467b-ab17-fb13ef7800c4@kernel.org>
 <9c06fdac-df4f-449c-8d58-b57c375c1751@quicinc.com>
 <808cfb83-a80f-431c-be69-ee3da964482a@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <808cfb83-a80f-431c-be69-ee3da964482a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: arokTUZefxQ1lTB77yWMn0wb53_-RvuU
X-Proofpoint-ORIG-GUID: arokTUZefxQ1lTB77yWMn0wb53_-RvuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250077

On 10/23/2024 11:27 PM, Krzysztof Kozlowski wrote:
> On 23/10/2024 14:22, Raj Kumar Bhagat wrote:
>> The above three blocks represent the QCN9274 WiFi devices connected to their
>> respective PCI slots. The dotted line represents the WSI connection that connects
>> these three devices together. Hence, the WSI interface is part of the QCN9274 device.
>>
>> To describe this WSI hardware connection in the device tree, we are adding three
>> properties inside the WSI object:
>>
>> 1. qcom,wsi-group-id:
>>    In the above diagram, we have one WSI connection connecting all three devices.
>>    Hence, “qcom,wsi-group-id” for all three devices can be 0.
>>
>>    This cannot be implied by the compatible property, as explained below:
>>    Let’s take the case of a platform that can have four QCN9274 WiFi devices. Below
>>    is one possibility of a WSI connection:
>>
>>          +-------+       +-------+          +-------+      +-------+
>>          | pcie2 |       | pcie3 |          | pcie1 |      | pcie0 |
>>          |       |       |       |          |       |      |       |
>>    +---->|  wsi  |------>|  wsi  |--+   +-->|  wsi  |----->|  wsi  |----+
>>    |     | idx 0 |       | idx 1 |  |   |   | idx 0 |      | idx 1 |    |
>>    |     +-------+       +-------+  |   |   +-------+      +-------+    |
>>    +--------------------------------+   +-------------------------------+
>>
>>    In this case, QCN9274 devices connected in PCIe2 and PCIe3 will have the same
>>    “qcom,wsi-group-id”. This group-id will be different from the “qcom,wsi-group-id”
>>    of QCN9274 devices connected at PCIe1 and PCIe0.
> Thanks, this explains why group-id cannot be same...
> 
>> 2. qcom,wsi-index:
>>    This is a unique identifier of the device within the same group. The value of
>>    wsi-idx is represented in both the above cases (RDP433 and the 4 WiFi device
>>    platform) in the diagram itself.
> But still any device-indexing is in general not accepted (and was
> mentioned during reviews multiple times).
> 
> This looks like circular list, so phandle will be enough. You only need
> to mark devices being part of the same chain.
> 
> Actually graph with endpoints would be more suitable, assuming above
> diagram represents connections.
> 

Thanks for suggesting "graph will endpoints" approach for representing WSI
connections.

I will check on this and come back.

> Please include that diagram in binding description.
> 

Sure will include the above diagram in next version.

>> 3. qcom,wsi-num-devices:
>>    Represents the number of devices connected through WSI within the same WSI group to
>>    which the device belongs.
>>    
>>    In the case of RDP433, all devices will have this number as 3.
>>    For the second example with four WiFi devices but with two WSI connections, the
>>    value of “qcom,wsi-num-devices” for each device will be 2.
> Not needed, just iterate over the graph children.

Thanks, based on "graph with endpoints" implementation will have this as well.

