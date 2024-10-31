Return-Path: <linux-wireless+bounces-14774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE019B7907
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 11:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C05285DF4
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF913A25F;
	Thu, 31 Oct 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Woq3mUpq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94E198E86
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371923; cv=none; b=Lk71gxK6mrB9IoSoqL5KQ9l4rR3pQ1S6M3smrzbreYHxTdfkdQL1dXgEC3/5CNf6icUq5MHyvUyiPME3vDr91786ncqMYwgHjlUE2hV2RzNpi5HduCde4AEfPkTvyXVKwYxVm5NYDvpGq109tWCDnumxZaHIx7GuduuK/2kiPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371923; c=relaxed/simple;
	bh=QBG3zwdFRkA7gQZzG9im6tB/sPz+NHokuMS3w9dhVjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oIKTHxVquC+DGAB1CP6E+XaJTkuEMpVVp979IcRUibR5yQe4SArOxjaZYT6DbVb9kv0Djm1yy2BqOFgCJcFA8MkkU56/bZPTT4qtt5MC/O6JhxsJwDlqxyds7Tc/QjuwMMra6AA2tCPSD9at8L7V3GMWI2nEc/Y0GoR2+nJEAh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Woq3mUpq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V9tfhG009563;
	Thu, 31 Oct 2024 10:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g9nDCjxtZPLloaBBRNv4yrOUXwySIfTJ/Uiv5uIJ0DU=; b=Woq3mUpq5fi4k2Ay
	0LAM/BJHG9QhIrLuhzi2etGpgEWR1UvyoeQMLlI+QhuNnzJrWaM+CXeWWzsI0D9r
	FXcrO1FB6XiFLk0Ux5eA9ESarU8ZNhWfZS6LFFjqbMXYwYJ7fR75I1oV2Wp/7Ca5
	ijcokXTY7N6sLCEzlfTOejdbVAvHrAIyZT9j2fXQzzgSRQZ/E2ZPL9cmMH9Ujh/f
	tuCfHl9MkgXYKG+Gdwz08a+MalJ7byzhcCWnruUvv1k6hrffaLzr2LbWOWA2Qtn4
	SxoEc7mr/kblSjr9x/6Afm/6iN9GcADNUX1s/MOPyDGDx2VVgc8odZKlXSPsRTf4
	4dN3AQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kjm1bqjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:51:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49VAprfH003301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 10:51:53 GMT
Received: from [10.253.79.17] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 31 Oct
 2024 03:51:52 -0700
Message-ID: <a921cfb6-3877-4364-9c55-cc89c3d97535@quicinc.com>
Date: Thu, 31 Oct 2024 18:51:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: Correctly handle Medium Synchronization
 Delay
To: Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Berg
	<benjamin@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241030025515.16004-1-quic_lingbok@quicinc.com>
 <e56621b7a8b229f726d644ffde7b98ba0c11b06b.camel@sipsolutions.net>
 <3a74f2f1-fd9f-46a5-87c1-fdc0235a50e5@quicinc.com>
 <b07102047bf2f076c090948b1a06ae4f22a881ff.camel@sipsolutions.net>
 <f6ec91977050f6a1f08d995b4e36ef4067ad3de2.camel@sipsolutions.net>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <f6ec91977050f6a1f08d995b4e36ef4067ad3de2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PzLF0uwkLl85BtITYk8EQBCwpUY1Kgb5
X-Proofpoint-ORIG-GUID: PzLF0uwkLl85BtITYk8EQBCwpUY1Kgb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 mlxlogscore=687 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410310081



On 2024/10/31 18:47, Johannes Berg wrote:
> On Thu, 2024-10-31 at 10:25 +0100, Benjamin Berg wrote:
>>
>> Right, which does seem to imply that a non-NSTR AP can very well set a
>> Medium Delay Synchronization.
> 
> Yes, we also pass it to the firmware in iwlwifi, so definitely.
> 
>>> Regarding the statement “Could it be that this is intended to be used by
>>> NSTR APs only,” I did not find any explicit indication in the spec that
>>> the multi-link probe response carrying the medium sync delay subfield is
>>> solely applicable to NSTR APs.
>>>
>>> Additionally, do you have any suggestions on how to address this issue?🙂
>>
>> Not really. I don't grasp the intention of the specification here. But
>> if an AP may include the field in an ML Probe Response, then we
>> obviously cannot rely on the value to be consistent.
>>
>> Seems to me that the option to remove the check is still the best way
>> forward right now.
> 
> Agree, let's just remove it - Lingbo do you want to send a patch?
> 
> We should probably compare "extended MLD capabilities and ops" though,
> haha.
> 
> johannes

hi, johannes,

I completely agree with your perspective. I will resend a revised patch 
that removes this validity check.🙂

/lingbok

