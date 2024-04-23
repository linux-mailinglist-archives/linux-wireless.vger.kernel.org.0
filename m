Return-Path: <linux-wireless+bounces-6698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0BF8ADB8F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 03:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594E8285105
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 01:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747DCDDB8;
	Tue, 23 Apr 2024 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kz+fRnVG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8F17BAF
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 01:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836079; cv=none; b=np4etq+eS4WYv3lQ0qqYPKkvDFmmsQSS4XNm/TpaKoT3/VkIap3lpy/snYTn65X+xKZMPoaOGjRgfeSgtpi+0FB5tAE6NuHD8fbn7F0TckBOa6xLFKHJvaUnHY5EyBY2tJmv9Q4E6qMiNlLWixqS3w44XVgAEHkl/oko75zswyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836079; c=relaxed/simple;
	bh=QbXpKA8zQmdE9YlyrDAz9476PnF+IhRx3OHiHozBe9E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=W+bvqu62Cx+XQAneuDPvf8uprivIf9is3DPEcIvFxPTJMN5uHQfQVoA8bABPyzV76++XPt0gd/QBh+jEXzrMmneTIbJqP5rtUsP8RkeKaTAAkLF9xV7EdlPfdp0dTmdHiY8e1fTRV9QPVtTwFxJyJ2z9WaRjHpwdc5qEI+BWudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kz+fRnVG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N0BUel004134;
	Tue, 23 Apr 2024 01:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eeCbp/i0jilK+AX4TsbSb6tiPamKPX/I2lPWXDZ7yFE=; b=kz
	+fRnVGQTPjYGO6dIubcp8HwnGo++FbzR4TICYhPZOC630Qa5BnYNXxnPgY3iEV3B
	Tms8rXpFYtALCeJ+c6c/kurah5vbZk+J3opt3vU4752zM8KdOkmoU+5BK8YPGmbb
	yJ6qLVnWCHQAFu2ITY9emBLX6xtJECawNgoW9h1ftNd6guRUqnCDCZ+R3isZnqnk
	MIoFjqq0FxBss0v2KGU6KlUaktGMse+mtACh/5EH5SAEXrBr5tnWzpB2rYc9o5+4
	A36ouu05BkL2/Me/ulOyRjG0QgHMrprVIslCPwbT292SBg0ue+1+8C55W4FpTP7o
	Vn2HF3sOo0lx4By4kZaw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xmxq4v493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 01:34:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43N1YHM5020299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 01:34:17 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 18:34:17 -0700
Message-ID: <e409e282-3f6d-42e2-ac6d-7602e3ef1b87@quicinc.com>
Date: Mon, 22 Apr 2024 18:34:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix kernel crash during resume
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240419034034.2842-1-quic_bqiang@quicinc.com>
 <87cyqmhtoi.fsf@kernel.org> <87frvivufg.fsf@kernel.org>
 <87h6ftv8w6.fsf@kernel.org>
 <5f63982a-eba9-4c5d-8ac0-52970316f940@quicinc.com>
 <88a1ab50-3dea-406e-adcb-b02786ce7f30@quicinc.com>
In-Reply-To: <88a1ab50-3dea-406e-adcb-b02786ce7f30@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VopR5qD8tO8Zci2_-W_Pa6wfA1vgtQ10
X-Proofpoint-ORIG-GUID: VopR5qD8tO8Zci2_-W_Pa6wfA1vgtQ10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 mlxlogscore=845 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230003

On 4/22/2024 11:41 AM, Jeff Johnson wrote:
> On 4/22/2024 8:41 AM, Jeff Johnson wrote:
>> On 4/22/2024 6:12 AM, Kalle Valo wrote:
>>> To avoid breaking git bisect I now reshuffled the pending branch so that
>>> 'wifi: ath12k: fix kernel crash during resume' is before the suspend
>>> patchset and my plan is to commit the patches in same order. Does this
>>> make sense for everyone?
>>>
>>> I had a simple conflict in ath12k_core_reset() in these commits:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=052a6a7c74ae4f20a31a632184f4439edcb0f40c
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6bc740619993535cb64c4dcebb83c66acd506763
>>>
>>> Please check my changes.
>>>
>> These look OK to me.
>> I'll test the pending branch on my laptop
> 
> pending branch crashes on my laptop
> let me bisect

ok, that was user error.

I had updated my workspace on my VM but not on my actual laptop, and the old
pending branch on my laptop contained the follow patch which I've already
flagged as bad (and is not present in the current pending branch):

wifi: ath12k: Fix Tx Completion Ring(WBM2SW) Setup Failure

I updated my laptop to:
5085843538af (origin/pending, pending) wifi: ath12k: report station mode
signal strength

And everything in that pending branch works fine, including hotspot.

/jeff

