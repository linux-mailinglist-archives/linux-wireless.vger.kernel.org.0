Return-Path: <linux-wireless+bounces-7395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C38C1261
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CFF28364D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8A516F856;
	Thu,  9 May 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AsulzHJp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F616F844
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270480; cv=none; b=ZeniOwzcGi3MctL9mxCNGe9NVuddYxHIU7bl4czTL9nulcQSIGfthKBp4WnAW7Mc1eLUpgm0CXaJh/rZEUzi6n2o1LBqmfuoQ5RpnfHWJZapZdy6gyz++9TuC8qOI1Ce61VHrBl9r70e9J+nmQ7iKHr98M0zfXXb4mSyxN7MEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270480; c=relaxed/simple;
	bh=OJ5Kfyjd/swOPO0PkrC2I1zIRLh5YTl/TVWDhPZsVbM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Nnf/qwooLxttlwvvr00e5IcBPI9W+MJvRTfHzppTQjpo860MvPQj9T77z3xgv98s6R+AWKX+XsyhlnZpMb5Y0eTNk+uF9KdryUnYYoAqIpysiAahBSJGsJH3xfmJFJwcamFjmodWCmph0p09T8chgBZfwihkP2atr4Pe4WJQ+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AsulzHJp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449E2fbP011391;
	Thu, 9 May 2024 16:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3EEhUKWd5c4fSrPq5vSy7n9bU4HdSuxZObxt29tu6T8=; b=As
	ulzHJpnEhcsBUq5vi8KZ0fiJeaLU63VbGt1Avq/ZVsSGx4pxcBXEv5jvBkiYkAj7
	pHJvmnprz2n4oGU9YD5593rQD4NRtVdadVd++Py7YtDwfIyGoHdUKOe1CiBB8fej
	DkB4jqxpbnD4aHkA74P2F+nde4PkfzFWsXKn0+63D1M6Y8DPsT1U9GNPioUJwh3k
	xm+3RE9YgGHzLc3G04hXoGBYtECzucRkp8SkCcdxKquqklPlb1iR0vxFsPYbApvV
	7lhClkp/JJRksf/j//qm+OYqe43ie35B5fHxi/dxKEBhzLCR17Iqo6fvJtBmjTQ+
	m/qKgfhsVKrZUAuCusKQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09nqk0m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 16:01:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 449G1Adi025014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 16:01:10 GMT
Received: from [10.110.102.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 09:01:10 -0700
Message-ID: <a0e50b38-cd84-4798-8224-b8a80f148a9f@quicinc.com>
Date: Thu, 9 May 2024 09:01:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup
 Failure
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240409190922.4180631-1-quic_nithp@quicinc.com>
 <c5dec609-493a-4246-b006-aa905edfdac3@quicinc.com>
 <514da0bc-f9f6-41fb-9e3e-72677394695f@quicinc.com>
 <b96ae3ec-44e0-42e1-8b3f-89144f01c272@quicinc.com>
In-Reply-To: <b96ae3ec-44e0-42e1-8b3f-89144f01c272@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mMU3UelxEeyU9ecZuigr54pCul7RjuOH
X-Proofpoint-GUID: mMU3UelxEeyU9ecZuigr54pCul7RjuOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_08,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=671
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090108

On 5/9/2024 7:39 AM, Jeff Johnson wrote:
> On 4/18/2024 10:52 AM, Jeff Johnson wrote:
>> On 4/10/2024 1:25 PM, Jeff Johnson wrote:
>>> On 4/9/2024 12:09 PM, Nithyanantham Paramasivam wrote:
>>>> We observe intermittent ping failures from the access point (AP) to
>>>> station (STA) in any mode(AP-STA or Mesh) configured. Specifically,
>>>> the transmission completion status is not received at Tx completion
>>>> ring id-4(WBM2SW ring4) for the packets transmitted via TCL DATA
>>>> ring id-3. This prevents freeing up Tx descriptors and leads
>>>> to buffer exhaustion.
>>>>
>>>> Currently, during initialization of the WBM2SW ring, we are directly
>>>> mapping the ring number to the ring mask to obtain the ring mask
>>>> group index. This approach is causing setup failures for WBM2SW
>>>> ring-4. Similarly, during runtime, when receiving incoming
>>>> transmission completion status, the validation of the ring number by
>>>> mapping the interrupted ring mask. This is resulting in
>>>> validation failure. Thereby preventing entry into the completion
>>>> handler(ath12k_dp_tx_completion_handler()).
>>>>
>>>> The existing design assumed that the ring numbers would always be
>>>> sequential and could be directly mapped with the ring mask. However,
>>>> this assumption does not hold true for WBM2SW ring-4. Therefore,
>>>> modify the design such that, instead of mapping the ring number,
>>>> the ring ID is mapped with the ring mask.
>>>>
>>>> According to this design:
>>>> 1. During initialization of the WBM2SW ring, mapping the ring ID
>>>> to the ring mask will ensure obtaining the correct ring mask group
>>>> ID.
>>>> 2. During runtime, validating the interrupted ring mask group ID
>>>> within the transmission completion group is sufficient. This
>>>> approach allows the ring ID to be derived from the interrupted ring
>>>> mask and enables entry into the completion handler.
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>>>> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
>>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>
>>>
>> Please remove my Acked-by.
>>
>> I've bisected a kernel crash on my laptop to this patch
> 
> While debugging my crash I've determined the issue isn't with this patch, so
> restore my:
> 
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> /jeff
> 
OK, I got confused between testing public patches & internal patches. It turns
out this version actually does have an issue, and there is a respin coming.

So reinstate the NAK on this version.


