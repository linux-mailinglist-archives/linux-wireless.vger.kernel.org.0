Return-Path: <linux-wireless+bounces-17542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED075A11ABD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 08:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314C718874F4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB6D22FE03;
	Wed, 15 Jan 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UeqPe5UC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34199234CE0
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925317; cv=none; b=ZkXmeZ1kXpPU0E31zF8IFku8of8xkF3nxqqx/8TFELwZ2o5W0mEg4OnGwGy9CfNLCmxDIm/OABRqB6wiiJX6Om3w6efkEqhuwAIBtKCg12uiuZMIZQ9FkCuzJ1lKPXics8M7VTyZndzSWunSDnpMADmpcTFSo+CSsEUT7GlC8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925317; c=relaxed/simple;
	bh=2+bqb2cJFfNYppDlICjpEHnHGWnBsSmyyFIa0mTIrIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RGJPyjoUMG4yzIC71j2834fPLrP1SS79aXC0aCrYhPJiR+d5V9sjt2MoiyB0dw+yMb7tj3E08KV+ispbczLrkv54Lsp3RPjZuFquoh4SWRFdZGeATstMU5zTLOMTAEh8bU4xjat+4v4VuVBOcyJZWuvrfbaQjGKUnXET1/QuuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UeqPe5UC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ELN9M2005070;
	Wed, 15 Jan 2025 07:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wOpMrqUVRiCuUCgcx/abcPO446kOAWWuQyuxxXgU9w4=; b=UeqPe5UCqUizRfPg
	KiT2N+FPGD/6/bjCdpVepwka5CvWntAsBwwFW17SUKWF1jyhLkP3ZIIQkDGnP+Fc
	eEP62m2PmwhpwrVEEvN94wBYYKwHTitx9EnGumgv5wMrUPf2zkeGsCSj2kBOKfmL
	iXJmh/P2uCwtdIAYHMK6HcRFezMn1xPfpKIgQ9tCpfcGfWidtOkBsptvHNnimoIe
	iPfeBdwpDIwQNu/8k8haH+fDurc/p1NZPO5RBihGzw0D1v0KXbcWQOPl4wVltNgy
	j0Ak2NK3riHAcE/AVbZ6m0sxYd+1+NGQiToL78xoj/CSYvpsvhQHnuKHvmeg43bC
	ivtDTg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445ysr94qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 07:15:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F7FALC018457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 07:15:10 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 23:15:08 -0800
Message-ID: <f7f44058-d566-4022-a4e9-6cbec9a6c997@quicinc.com>
Date: Wed, 15 Jan 2025 12:45:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] wifi: ath12k: Fill pdev id for fw test cmd
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
References: <20250115042532.1509956-1-quic_aarasahu@quicinc.com>
 <20250115042532.1509956-5-quic_aarasahu@quicinc.com>
 <d2b317e0-dccc-4683-8964-3878ef61d4fb@quicinc.com>
 <c51886be-3f4e-45b6-a7c6-19596ce9b24d@quicinc.com>
 <50547012-1679-4ce6-a457-f16ce58484e4@quicinc.com>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <50547012-1679-4ce6-a457-f16ce58484e4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8gO0dm-KdGsx3G4V810n51MytRU0pDtJ
X-Proofpoint-ORIG-GUID: 8gO0dm-KdGsx3G4V810n51MytRU0pDtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150051



On 1/15/2025 12:10 PM, Aditya Kumar Singh wrote:
> On 1/15/25 11:11, Aaradhana Sahu wrote:
>>
>>
>> On 1/15/2025 10:56 AM, Aditya Kumar Singh wrote:
>>> On 1/15/25 09:55, Aaradhana Sahu wrote:
>>>> Currently pdev id is not set properly. That can cause a crash
>>>> if pdev id is not equal to the pdev id when firmware test
>>>> command is run during AP bring up or ping.
>>>>
>>>> Set pdev id in function ath12k_tm_cmd_wmi to resolve this
>>>> issue.
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
>>>> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
>>>> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
>>>> ---
>>>>    drivers/net/wireless/ath/ath12k/testmode.c | 11 +++++++++--
>>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>
>>> Previous patch "[PATCH v9 3/5] wifi: ath12k: add factory test mode support" only added testmode.c file isn't it? So can't we squash this patch in that?
>>>
>>> Let's not introduce a bug in patch X and then in same series fix it at patch Y.
>>>
>>
>> This patch does not address any issues related to Factory Test Mode (FTM).
>> Instead, it focuses only on the ath11k-fwtest command, which is used for
>> certification testing and is distinct from FTM.
>>
>> Initially, this patch was submitted independently as '[PATCH v2] wifi: ath12k: Fill pdev id for fw test cmd'
>> during the internal review.
>> However, Kalle suggested incorporating this patch with the FTM patches.
> 
> That is good. But that comment does not mean it needs to be a *separate* patch? It should be in this series that's what Kalle wanted to ensure.
> 
>>
>> As this patch addresses ath11k-fwtest command issue, that's why this is not merge with [PATCH v9 3/5].
>>
> 
> That is fine, but you are adding the file in 3/5 so why not have this part as well in same patch only? And let me ask this way, if you don't apply 3/5, will your issue exist? Probably No? Since ath12k/testmode.c file itself is not there before 3/5. So if you know something is incorrect, why introduce it in the first place?
> 
> 
During the internal review of this patch, the leads explicitly stated that it should be separate.
Based on their feedback, I made the necessary changes. Since this was previously discussed, I would prefer to keep this patch separate.





