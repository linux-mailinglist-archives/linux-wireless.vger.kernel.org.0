Return-Path: <linux-wireless+bounces-6673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44F8AD11D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78CE1F231F1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0442F152509;
	Mon, 22 Apr 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bi21P3t/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9281514E2
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800477; cv=none; b=NJgbGYNoNORuDv3FPgQF8LYgBH/dsVHyyrmjJnHdVgviCKq5fQoUlWKPlPZ07iybJgT3bwFvUfmmxQ7eWI1IjShLCCDuLnq4VGXjB1w6DEi1u2CzO1gpLjJQnUjqpb7mklVJam2xE0CB9COqxXEPFf6Ysf90nz8b5wEZN+Ie2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800477; c=relaxed/simple;
	bh=yX4+Wz/YmQJM1yXsq0IVLgta4SOLGYClqGbSsnLrd8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Zyf4EwsTwp7CAa03Hi/22l6nLgHUYi3ztoKUXJMNgaXyew9oHgoGdcsIR3XweR2PtFPlXMAb8qm6HX/AVxVC9BDFVZxHHiAdsECTp0IvNQa0udyaNiMf+D5EK2fv623K+wZ5qwJL7bDNfr1/YFRqI7nQa4DrLSgtd7FzB6hlg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bi21P3t/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9P02m026628;
	Mon, 22 Apr 2024 15:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=x6/TvoTpI/IEOQ8fdz/kQj4fOdnmlQAAoqC0Qu4RtWY=; b=bi
	21P3t/d+sooxaYp0mfwgn94KIT98yjiK5TZVC559bgglEWuQoKzov4fd/yKod+Pz
	c5aV/SLsBlb6XkTl48H+EATQgJKcvk0sqAJZU7K7A0NM8rWv1IbSWRyNv3jGjz3o
	OR/610nu2jxDe0xicpF58sHUFG3oNdSTv0y+UYIQ1R9KVvgsyQr5EhHUGoAQYtAy
	BM2NtWOnemBSy2Bf92U6kRUs9+gTOyAGvUQksvigWzMsZ8UHLiiDHrBdsKvSM3gy
	szX7fRE39lY0aXiQg/8iLAjb/cY44e6ocRgXfJfmeW2ctoUw9Gr2nCgbDdwzn//p
	nozsVkzGJF8IvnuCMZCw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82gxgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:41:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MFfBSc006803
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:41:11 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 08:41:11 -0700
Message-ID: <5f63982a-eba9-4c5d-8ac0-52970316f940@quicinc.com>
Date: Mon, 22 Apr 2024 08:41:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix kernel crash during resume
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240419034034.2842-1-quic_bqiang@quicinc.com>
 <87cyqmhtoi.fsf@kernel.org> <87frvivufg.fsf@kernel.org>
 <87h6ftv8w6.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87h6ftv8w6.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6u3Z31HmjNFpErWWDKIvVYlwtNxiZdIk
X-Proofpoint-ORIG-GUID: 6u3Z31HmjNFpErWWDKIvVYlwtNxiZdIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=827 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220066

On 4/22/2024 6:12 AM, Kalle Valo wrote:
> To avoid breaking git bisect I now reshuffled the pending branch so that
> 'wifi: ath12k: fix kernel crash during resume' is before the suspend
> patchset and my plan is to commit the patches in same order. Does this
> make sense for everyone?
> 
> I had a simple conflict in ath12k_core_reset() in these commits:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=052a6a7c74ae4f20a31a632184f4439edcb0f40c
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6bc740619993535cb64c4dcebb83c66acd506763
> 
> Please check my changes.
> 
These look OK to me.
I'll test the pending branch on my laptop

