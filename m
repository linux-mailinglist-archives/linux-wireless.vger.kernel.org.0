Return-Path: <linux-wireless+bounces-17539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63922A119D1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 07:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8531C16134A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC8A1E04BE;
	Wed, 15 Jan 2025 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c532LagF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517822F395
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923272; cv=none; b=b448zoLf6IqzDjVxb91l0VV7ZlIcoHfHaYBA1wwPL5ffHSAw4qfhBERriCJ4nrpHZ6nLoE/0AguIZDXZvzvXPMavD+Bt0IRHjnO9tDouOAwunP+ObkAO7NbMJJzgfsHzIrVZN5ZxLQq/19Pqd3aY3Tv1Ma8ak38268lr/Y9P52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923272; c=relaxed/simple;
	bh=T3KV0Ho1s3lFi7b29xg++r4Tdo6UVUypWBlDSMQry1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jLSmrkXINXqGIOT5KHZT52HSWnuUk1MHQf8Ho12r1mA1CS4mAPgby5azszZkDumbTXsH6YRGA8KyXvENQU/bwc/SJOe4BNUYfG/APwtDgMzLwU6pUi9/+tbz9G+xdLrPhKvOuN89fo+Z+a7xKzns5+wgfu+/8Vqgyas/ToJbd0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c532LagF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F2ihZm011368;
	Wed, 15 Jan 2025 06:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xQK6wvnZB1E+geozWcWMafIkL6YXB+ODUC84pVAObfM=; b=c532LagFsCfmLsg6
	h0TuLEI6q7lxz3M3HETG2z6mtDX+JCqdw/v+AsjxHe4q9hfXLw14SQ02P+bX015J
	XrBn2E6TgE+ZlJEmYIVGNc73gJkI8UOgT+gsjdhgnArvJsU+Fp2wO/rhhYJYxOBJ
	FMiG3LBpGcQBPgx40vFJ4KRJFFrxZhlM9U3yhW+nEkKQPJwzZ1nQhbkDvdNq33jp
	/Rs+VGvXorDUhme3m8OrKsdfshMYI3K1YM8G3oDqt09mR5H8GUIPgLQaStZQLBvQ
	3TB2/9VJ9w+iXzCOjUM/Oqffdij1ndnzm64wfwbpW4CwIYmilgOoya/H3wnFQu2t
	4o5SnQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4464gp8fan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:41:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F6f4kv007645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:41:04 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 22:41:02 -0800
Message-ID: <50547012-1679-4ce6-a457-f16ce58484e4@quicinc.com>
Date: Wed, 15 Jan 2025 12:10:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] wifi: ath12k: Fill pdev id for fw test cmd
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
References: <20250115042532.1509956-1-quic_aarasahu@quicinc.com>
 <20250115042532.1509956-5-quic_aarasahu@quicinc.com>
 <d2b317e0-dccc-4683-8964-3878ef61d4fb@quicinc.com>
 <c51886be-3f4e-45b6-a7c6-19596ce9b24d@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <c51886be-3f4e-45b6-a7c6-19596ce9b24d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vqOW33gUspdjGMTCG1OStkXUro9aWTSJ
X-Proofpoint-ORIG-GUID: vqOW33gUspdjGMTCG1OStkXUro9aWTSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150047

On 1/15/25 11:11, Aaradhana Sahu wrote:
> 
> 
> On 1/15/2025 10:56 AM, Aditya Kumar Singh wrote:
>> On 1/15/25 09:55, Aaradhana Sahu wrote:
>>> Currently pdev id is not set properly. That can cause a crash
>>> if pdev id is not equal to the pdev id when firmware test
>>> command is run during AP bring up or ping.
>>>
>>> Set pdev id in function ath12k_tm_cmd_wmi to resolve this
>>> issue.
>>>
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>>
>>> Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
>>> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
>>> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
>>> ---
>>>    drivers/net/wireless/ath/ath12k/testmode.c | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>
>> Previous patch "[PATCH v9 3/5] wifi: ath12k: add factory test mode support" only added testmode.c file isn't it? So can't we squash this patch in that?
>>
>> Let's not introduce a bug in patch X and then in same series fix it at patch Y.
>>
> 
> This patch does not address any issues related to Factory Test Mode (FTM).
> Instead, it focuses only on the ath11k-fwtest command, which is used for
> certification testing and is distinct from FTM.
> 
> Initially, this patch was submitted independently as '[PATCH v2] wifi: ath12k: Fill pdev id for fw test cmd'
> during the internal review.
> However, Kalle suggested incorporating this patch with the FTM patches.

That is good. But that comment does not mean it needs to be a *separate* 
patch? It should be in this series that's what Kalle wanted to ensure.

> 
> As this patch addresses ath11k-fwtest command issue, that's why this is not merge with [PATCH v9 3/5].
> 

That is fine, but you are adding the file in 3/5 so why not have this 
part as well in same patch only? And let me ask this way, if you don't 
apply 3/5, will your issue exist? Probably No? Since ath12k/testmode.c 
file itself is not there before 3/5. So if you know something is 
incorrect, why introduce it in the first place?


-- 
Aditya

