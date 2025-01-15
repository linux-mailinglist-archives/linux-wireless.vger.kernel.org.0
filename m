Return-Path: <linux-wireless+bounces-17533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FFA1191D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 06:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7428B163808
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 05:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91D22DF93;
	Wed, 15 Jan 2025 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CS6o1Yue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797822DFA4
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919690; cv=none; b=YROAMvNj38kQEc3E4GtxwjEKly1B8lslZo1uwQ7/3n4L9tqSoMYVajmLF5UCO+hrv9aUSN9deWS338IVF7mVgbE2qM7kXKM8NYDWkeaWMgbds2x0YC3fg2mDCbyt7T2OPHRhF/T6O3xWJ0ANTE+hZiU7nWlJRO9ATzOBQlFQAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919690; c=relaxed/simple;
	bh=Vr4UOrO/PxpbMKnxv7G2mmfuiDEqDIdXsvLNELwJ+Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J6N8qI7Uc1VaJgKVcTYOQI8D82g2sV07EDE7FU7/EbZRSFMciBYp2X7CmsRKE/C/B0lU0McOZF8y1yKyUjvMHnkgX5ksgpJPN9jqFVc3z4Ej8SQRqkdMAr2WZiLySJpDkutlV3kHMdEFuWMX8J88KetHSMfVsFmSZBvuFci1Xes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CS6o1Yue; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EGkFM8025067;
	Wed, 15 Jan 2025 05:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sMj2RNmiJY/Q4ueJpTHPqQggjBFI7kQDylXfCy57y84=; b=CS6o1Yue3suZLyUN
	43IpFun4M+1L1AgkyspbLPoGivma9aiogAQyIFTr1ED3h1zCaSC6uqiQug8mq4Jw
	JVThg2t2ZFdIrMtOxhF39sbMAOfxq3yAIyQAfnw74EHIS2+JWMgrgCxEtXdwVtaW
	suzazvLNVaatxn6TB6WijhcoatrrwNW2s1dddLfmi3D4Kc7ppjnrCTHhj/yKk2j/
	YhcnXZld0B5ALiIcG5XOVwpMGPYHNE/UZSxhqT5Bc96UtQ4WsKkpu64zrr9xf10C
	RfbKmFMhPwQnF7Ldt8dzlviUBBUQvEt9o18XS5+Q9Qu9ifRk0He5hTCKz48+fgZW
	JiC0fA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445uqs1hkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 05:41:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F5fPmX021707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 05:41:25 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 21:41:23 -0800
Message-ID: <c51886be-3f4e-45b6-a7c6-19596ce9b24d@quicinc.com>
Date: Wed, 15 Jan 2025 11:11:20 +0530
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
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <d2b317e0-dccc-4683-8964-3878ef61d4fb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6s-0t6PObuxSk9hE6sL1LQeBZz2O_cPb
X-Proofpoint-ORIG-GUID: 6s-0t6PObuxSk9hE6sL1LQeBZz2O_cPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150039



On 1/15/2025 10:56 AM, Aditya Kumar Singh wrote:
> On 1/15/25 09:55, Aaradhana Sahu wrote:
>> Currently pdev id is not set properly. That can cause a crash
>> if pdev id is not equal to the pdev id when firmware test
>> command is run during AP bring up or ping.
>>
>> Set pdev id in function ath12k_tm_cmd_wmi to resolve this
>> issue.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
>> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
>> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/testmode.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
> 
> Previous patch "[PATCH v9 3/5] wifi: ath12k: add factory test mode support" only added testmode.c file isn't it? So can't we squash this patch in that?
> 
> Let's not introduce a bug in patch X and then in same series fix it at patch Y.
> 

This patch does not address any issues related to Factory Test Mode (FTM).
Instead, it focuses only on the ath11k-fwtest command, which is used for
certification testing and is distinct from FTM.

Initially, this patch was submitted independently as '[PATCH v2] wifi: ath12k: Fill pdev id for fw test cmd'
during the internal review.
However, Kalle suggested incorporating this patch with the FTM patches.

As this patch addresses ath11k-fwtest command issue, that's why this is not merge with [PATCH v9 3/5].


