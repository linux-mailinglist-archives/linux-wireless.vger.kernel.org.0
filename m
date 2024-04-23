Return-Path: <linux-wireless+bounces-6704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B48ADD0C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 07:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79DDB2157F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 05:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66997200C7;
	Tue, 23 Apr 2024 05:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y6X/RtlG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34541CA82
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848985; cv=none; b=n399+ULTQsPM56NjkBamzLhZoOodwNrgTw8FvhmiZVEMbqXZPXx30JZ8q8OIdIu6OME1fpE8liLNVvm9dakekRwg/ipkK22onMYHoI7Pt9NFr/TW8GhvNg+du+kfS6PwsLQ7D3i2w9w7Xgx33TSsxuetA9052yrQ/Z2bcTxFXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848985; c=relaxed/simple;
	bh=76zFPKayLt9p86r1q65wqtDVU+MJLwkIJ8SSaV6s7qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SSNzDNr+kbK9vfZwMouja3JptWBStL61564mLZkIR1n1UErgOwEbM/mchB/GBGNsm9eqr1feveZLGHByu+iQpigido+gdfveCnGPzpiFBLoYgYqaIILJFWUEWwK/Bd+0jp61iYH22LtFekA5/VAsWjF/BpVAxatbyJhY1pT/gKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y6X/RtlG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N59RpL016427;
	Tue, 23 Apr 2024 05:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fjfZQ+j1LmSBlFJ3VFT7nHwKfB3EHWUMJJqY8bMYWEQ=; b=Y6
	X/RtlGuDrKwBdskmDqM8COEx+m5GybdV0mYE+4GPknde8ZWYvoAmyfbV6Dj7IhhD
	wfHg1rDYAmzRC2D8rHelY63Mp2H3tJ1JPbBLcrVfbSE42q8g2sp4+2WZkOsdK/zv
	zhEZhb7uFXxNHUKomUOEem47i6WgyDjw6v/tD0w3Kk2StpNf5d+x8e+74Xu3MLcx
	baSvWrcaWTJkiJM8t1Z0ehQqyw394EH9/mAJhlOD4vk+yDSI7X9ElaqPoKfAxUFN
	8tg+DjEW3hpZN6OP0ZDUEJYECgvRxH4YXiEK5YrC/CID9A5sfMJtUK7HKtB9zjaG
	y+rKarmyeOwok+M+Jh+g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnvtn92je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 05:09:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43N59Pqo007453
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 05:09:25 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 22:09:24 -0700
Message-ID: <c87b00a7-4890-4a96-8242-95d52c16f4d2@quicinc.com>
Date: Tue, 23 Apr 2024 13:09:22 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix kernel crash during resume
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240419034034.2842-1-quic_bqiang@quicinc.com>
 <87cyqmhtoi.fsf@kernel.org> <87frvivufg.fsf@kernel.org>
 <87h6ftv8w6.fsf@kernel.org>
 <5f63982a-eba9-4c5d-8ac0-52970316f940@quicinc.com>
 <88a1ab50-3dea-406e-adcb-b02786ce7f30@quicinc.com>
 <e409e282-3f6d-42e2-ac6d-7602e3ef1b87@quicinc.com>
 <87cyqgvhv7.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87cyqgvhv7.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a9BCVn8ZQTBM9_M7pvC7anPhl_u6hSjB
X-Proofpoint-ORIG-GUID: a9BCVn8ZQTBM9_M7pvC7anPhl_u6hSjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_02,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=969 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230013



On 4/23/2024 12:10 PM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 4/22/2024 11:41 AM, Jeff Johnson wrote:
>>> On 4/22/2024 8:41 AM, Jeff Johnson wrote:
>>>> On 4/22/2024 6:12 AM, Kalle Valo wrote:
>>>>> To avoid breaking git bisect I now reshuffled the pending branch so that
>>>>> 'wifi: ath12k: fix kernel crash during resume' is before the suspend
>>>>> patchset and my plan is to commit the patches in same order. Does this
>>>>> make sense for everyone?
>>>>>
>>>>> I had a simple conflict in ath12k_core_reset() in these commits:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=052a6a7c74ae4f20a31a632184f4439edcb0f40c
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6bc740619993535cb64c4dcebb83c66acd506763
>>>>>
>>>>> Please check my changes.
Looks good to me.

>>>>>
>>>> These look OK to me.
>>>> I'll test the pending branch on my laptop
>>>
>>> pending branch crashes on my laptop
>>> let me bisect
>>
>> ok, that was user error.
>>
>> I had updated my workspace on my VM but not on my actual laptop, and the old
>> pending branch on my laptop contained the follow patch which I've already
>> flagged as bad (and is not present in the current pending branch):
>>
>> wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup Failure
>>
>> I updated my laptop to:
>> 5085843538af (origin/pending, pending) wifi: ath12k: report station mode
>> signal strength
>>
>> And everything in that pending branch works fine, including hotspot.
> 
> Thanks for testing. Unless no objections from Baochen I'll then apply
> this fix and the suspend patches.
No objection from me, kalle.
> 

