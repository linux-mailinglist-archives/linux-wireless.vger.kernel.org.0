Return-Path: <linux-wireless+bounces-7856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B568CA5F9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 03:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1ABFB2200B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 01:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2322BA47;
	Tue, 21 May 2024 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ioAkHrhE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25602DDD7;
	Tue, 21 May 2024 01:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716256339; cv=none; b=GBKP2oWZgW+xumMnt938kK+icvusgPzk/e20jzkh7q/InalcGRvAkx+F3iRw5qNKm1LMMRhG2uMf5p9XUSwTnoAuHMss6m3i9nV5rlItUWlw/hhfZ9im9Tu9rDBfSon3ASk7azN4s7RIuek6QWpZS7qU2n9sTwWGtuPHJz+uYzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716256339; c=relaxed/simple;
	bh=9W8zhc+dgfcfb0rBog1zP1w/IruObcuWpyooKFQuGsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z6JUGF35NOXlOb70Oq6C/97djivI4JuxD3qZIYjUeBSq6wWPU0Iowvd17cscR4dYM3Dp9x8sZr0zhGuR2+FoJBBzHlMKEEgldF0FsLaYs7ue8ShTcVh7p6glmsH5TCJ8uwQNQRqphGvOayD/5Ea4VcIkVlNnQ5wHe/UI1JP6ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ioAkHrhE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KDT005002246;
	Tue, 21 May 2024 01:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TWjzaiPWRuE3Vzeje4HCkWx7RJMXwE1DcD52t2iq+IE=; b=io
	AkHrhEq+H0QhA5ginnabSrRj7x1+AQ2gwBp4xUE/LuQImKwxfpUuwdvVkw8a42jj
	G5t5fjRxcfV9mrq3D+FcDf7QP64/no3lj4OgvMFIzU+k8sxzicgAimnFfD/yzeOr
	RUYYIc8Kblet5VT1k6jJhK/W0SwujE6mjsxP8PIeM7+ohoUXhJCSUCJ1FrH68T/w
	HzU7Tt2XxTEbWp8Bsso7PmQjFp6gQqbdqOhfgf/X3tYz25a0qSzqI5dimEfWvhPd
	eWCJcolq9dvBv+AjeYQsRl6hy1CaK1QfxYTl+pncXUTtOHL/o3fjxtdQx3Cglu1v
	pSiTYD/UosJmc1BsMX8w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gcphc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 01:52:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44L1q9AZ019088
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 01:52:10 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 18:52:08 -0700
Message-ID: <b6b23a29-78ef-4e4f-8042-e13833fcb1ec@quicinc.com>
Date: Tue, 21 May 2024 09:52:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: move power type check to ASSOC stage
 when connecting to 6 GHz AP
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <regressions@lists.linux.dev>
References: <20240424064019.4847-1-quic_bqiang@quicinc.com>
 <87wmo0k71i.fsf@kernel.org>
 <3dc28f34-45cc-4e14-b9ea-1f7b78a6a591@quicinc.com>
 <87h6esebu8.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87h6esebu8.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2hWElVs2tP-fpMHWuJBzUgjqxBzoLjQO
X-Proofpoint-ORIG-GUID: 2hWElVs2tP-fpMHWuJBzUgjqxBzoLjQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210014



On 5/20/2024 11:34 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> On 5/11/2024 5:54 PM, Kalle Valo wrote:
>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>
>>>> With commit bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>>>> ath11k fails to connect to 6 GHz AP.
>>>>
>>>> This is because currently ath11k checks AP's power type in
>>>> ath11k_mac_op_assign_vif_chanctx() which would be called in AUTH stage.
>>>> However with above commit power type is not available until ASSOC stage.
>>>> As a result power type check fails and therefore connection fails.
>>>>
>>>> Fix this by moving power type check to ASSOC stage, also move regulatory
>>>> rules update there because it depends on power type.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI
>>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>>
>>>> Fixes: bc8a0fac8677 ("wifi: mac80211: don't set bss_conf in parsing")
>>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>>
>>> Oh, this fell through the cracks. Commit bc8a0fac8677 was introduced in
>>> v6.9-rc1 so I should have sent this to v6.9 but it's too late now. I'll
>>> need to queue this for v6.10 via wireless tree.
>>>
>>> Adding the regression also to regzbot:
>>>
>>> #regzbot introduced: bc8a0fac8677
>>> #regzbot title: ath11k: connection to 6 GHz AP fails
>>>
>> Hi Kalle, with an upcoming patch this regression is expected to be fixed:
>>
>> https://lore.kernel.org/all/20240506214536.310434f55f76.I6aca291ee06265e3f63e0f9024ba19a850b53a33@changeid/#t
>>
>> So here the ath11k fix would not be needed any more once above patch got merged.
> 
> What happens if we apply both patch 'wifi: ath11k: move power type check
> to ASSOC stage when connecting to 6 GHz AP' and patchset 'wifi:
> mac80211: build TPE handling'? In other words, do they conflict from
> functionality point of view?
No functional conflict, 6 GHz AP connection would also succeed with both of them applied.

> 
> I ask because I suspect Johannes is planning to take patchset 'wifi:
> mac80211: build TPE handling' to v6.11 but we should fix the ath11k bug
> in v6.10.
> 
>> But I don't have time to test this, so suggest keeping it pending. We
>> could drop it once above analysis got verified.
> 
> BTW for some this patch wasn't in the pending branch but it's there now.
> 

