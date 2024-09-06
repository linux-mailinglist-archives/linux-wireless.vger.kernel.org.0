Return-Path: <linux-wireless+bounces-12578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7696EA17
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 08:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828731C2218A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E423B13D52C;
	Fri,  6 Sep 2024 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YEylByc3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CFB27450
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603827; cv=none; b=XHBgVu+pgv9UkECFsBTa1EY784UESRRLdeRG2rq/LfjuHN9x1h7ZOpRnQBgU6Mq3Kdhbav37pyDPB3n0g2/Pi5ejOgDLDHiTHPwfRj8CvuhcA6JQEGzaYgeN9HKTdlocb4oTVM8OuTxS8Nrp3ddtXI6r55o2kXG4ZQzck1KyzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603827; c=relaxed/simple;
	bh=s5zDZWWQMBZHC0k+URPscyoo8gKZdat+rTJTtP3+NFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YvDx5AWI9pTALFZxD/kYUfQn++bOoAioUiuQlCkIAAMjaGyk3MQinpCHZdXtoU37Hh9J6f7VNHm0ujy2lWiG8VZRv0l8n7Z1iOgzAZ9yz6D8GlPp7iMfP2Hk3TzDUxrt9jfvvzr1GmhESuRuuwIOrlbiZNKfGSk6fWNsCSa1FsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YEylByc3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQ7l5021803;
	Fri, 6 Sep 2024 06:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fhZ4iY2Db1rIDo8wA8kVm3LXbIrAyIrgDRtr/h2dcS0=; b=YEylByc3uPo/3hwB
	GkVlO1d05x2CFJ4Fj7ZcRCmagDnEc22XXLG1lEjLfGdLyYQGUeLdUdcgi4JkvMWx
	KRLdb/R+EZuIaWfC1WMIXGUVY028UNuzNKOw7nO0sBQmHa3kwRH8Hb+BUOZc30I3
	v/+cygqwo5Q1lWBdoLCxOSH3ZscRt9+SDKRSkiiPanBQSCQgdAUL5m+9i6FXIQXm
	L6ugFTT3cE9HIhzGYnFy2VaV6ZzGp2VvXAsOXeeq6/xUois10m1I1M4HWIBirIFC
	5fpPsMWIYAb+qoUtJgXToIr5VfGtRORulgtRoqeAeMnN375nrE+fbPBzAWomWjqe
	KcFhxA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu19rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 06:23:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4866NfOe008672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 06:23:41 GMT
Received: from [10.216.27.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 23:23:39 -0700
Message-ID: <8ad1aec1-a90c-4fba-afa1-f3ce8766f30e@quicinc.com>
Date: Fri, 6 Sep 2024 11:53:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] wifi: mac80211: handle ieee80211_radar_detected()
 for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240902064847.2506090-1-quic_adisi@quicinc.com>
 <20240902064847.2506090-9-quic_adisi@quicinc.com>
 <807fe0b60e727ea927cb12a75f874698a1798723.camel@sipsolutions.net>
 <6446af26-4605-4f76-9c09-2d40e3919e5b@quicinc.com>
 <a9e1c8ce6c4826e019ac96b832ee72e257225ca3.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <a9e1c8ce6c4826e019ac96b832ee72e257225ca3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -LOCRc9gFlT_nRiSNsX_xaXsQkW3A27E
X-Proofpoint-ORIG-GUID: -LOCRc9gFlT_nRiSNsX_xaXsQkW3A27E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=901 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060045

On 9/4/24 13:18, Johannes Berg wrote:
> On Wed, 2024-09-04 at 09:03 +0530, Aditya Kumar Singh wrote:
>>
>>>> +			if (!chanctx_conf)
>>>> +				continue;
>>>
>>> This changes the previous behaviour, is that OK?
>>
>> As in? The only behavior change is previously, cac_cancel() will cancel
>> all CACs going on all sdata's. However, with MLO, if let's say link X on
>> MLD A detects radar, why link B on MLD Y should also cancel the radar?
> 
> I was just going by the fact that this didn't even care about the
> chanctx conf before. It was just using the link_conf->chanreq.oper.
> That's with patch 6, but before patch 6 it was just using
> deflink.chanreq.oper and assuming you had a chanctx I think?
> 
> So I guess it's fine?

Yes, cause the comparison is now needed. Before MLO things were simpler.

> 
>>> The cast isn't needed. But you don't even really need the "itr_data"
>>> variable since you never dereference it.
>>
>> That's true but we are using it to compare it. If we don't type cast
>> then pointer comparison later would be problematic right?
> 
> No, why? It's void * so it's compatible with anything anyway. You don't
> even need the cast for the assignment, why should you need one for a
> comparison then?

okay yeah true that. Will remove. Thanks for the comments.

> 
> johannes

-- 
Aditya


