Return-Path: <linux-wireless+bounces-7865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D008CA7A1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 07:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11805282CCF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 05:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6753F8F1;
	Tue, 21 May 2024 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eG4X2s67"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF5376E0;
	Tue, 21 May 2024 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716269248; cv=none; b=YMuY89tJXIKLmAarvDvMN6FGQ3gMdUaQHfLZxnRL0PxRnQN6qxZn4KvUk33tDR23T/09Ka7YfQGVGgBhjFWS3fWVeHTSc6Gj93kVPLFe7ZX0aAif8JAeG91yPLYLv8EUB/CjkkN+VRJWLCA98fhWCJyyHtCM+nH02h/LXX4SJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716269248; c=relaxed/simple;
	bh=hMg1zfXWLmGmMw3i9U3OSYp7Ju8y/hu6FFILPNZWYPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rQXTfRSBfDwuPf39H6vWfup8/ExzZVgZ8oxRok+FjdinBssWRLaZL09+HFFXxvXk/MR3aRdP20S87vySlXeaM+HcOxc7X9uyn7SZOAJL6nWWrE65ozhZNSVoG+Y1SPqyrXoh2/ghM+jfCAr2u5hdJxum/VsbkTxX5qgEz1/ba/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eG4X2s67; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KDT0EA002246;
	Tue, 21 May 2024 05:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JREW06SdLY3MILYWLRTbIYz79fFIBlYyZXtTtmnCKag=; b=eG
	4X2s67vb5ojA3Ishu9CXWuBWLX6r8PqOX6S+3rsvZ8aAYQjUhu59QrdxLt9CKpbj
	KgJZfYgdDhSH0hDpTw+nVD0YEmmPf7Dtv702f7h2/S/mu05flk0eYktiPxzcDozX
	2sSdxpnr4MwYYEJ2mobdFpGPxKw3OHgzjb+eT26xvWxot81IUM/PLp8hX8avsXdG
	r7gCzcoS2o2JL/KWA/rZ4A5e6oK3nk1oj1gOi6bjNb/mmD4bmmXnoOYlpHi4AqCo
	j6QcNVGXsg/LTDi0aPX9pnGI53WLBD3jxuFgwoVdoY1ji5NdUpFNfflAsKfYVAmK
	QyFoalYf19SJzvLjrkcQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gd09y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 05:27:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44L5R4DS001997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 05:27:04 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 May
 2024 22:27:02 -0700
Message-ID: <e235c2f1-4d52-4a89-9d1b-9d63d0ff4c6f@quicinc.com>
Date: Tue, 21 May 2024 13:27:00 +0800
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
 <b6b23a29-78ef-4e4f-8042-e13833fcb1ec@quicinc.com>
 <878r03eoka.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <878r03eoka.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: flibLBs4Wi3LKPuW5C7mk-tPWh3R-3F7
X-Proofpoint-ORIG-GUID: flibLBs4Wi3LKPuW5C7mk-tPWh3R-3F7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_03,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=942
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210041



On 5/21/2024 1:12 PM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>> On 5/20/2024 11:34 PM, Kalle Valo wrote:
>>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>>> On 5/11/2024 5:54 PM, Kalle Valo wrote:
>>>>
>>>>> Oh, this fell through the cracks. Commit bc8a0fac8677 was introduced in
>>>>> v6.9-rc1 so I should have sent this to v6.9 but it's too late now. I'll
>>>>> need to queue this for v6.10 via wireless tree.
>>>>>
>>>>> Adding the regression also to regzbot:
>>>>>
>>>>> #regzbot introduced: bc8a0fac8677
>>>>> #regzbot title: ath11k: connection to 6 GHz AP fails
>>>>>
>>>> Hi Kalle, with an upcoming patch this regression is expected to be fixed:
>>>>
>>>> https://lore.kernel.org/all/20240506214536.310434f55f76.I6aca291ee06265e3f63e0f9024ba19a850b53a33@changeid/#t
>>>>
>>>> So here the ath11k fix would not be needed any more once above patch got merged.
>>>
>>> What happens if we apply both patch 'wifi: ath11k: move power type check
>>> to ASSOC stage when connecting to 6 GHz AP' and patchset 'wifi:
>>> mac80211: build TPE handling'? In other words, do they conflict from
>>> functionality point of view?
>>
>> No functional conflict, 6 GHz AP connection would also succeed with
>> both of them applied.
> 
> Ok, thanks. In that case I would like take patch 'wifi: ath11k: move
> power type check to ASSOC stage when connecting to 6 GHz AP' to
> ath-current branch from which it will go to v6.10. Is that ok for
> everyone?
Good to me.
> 

