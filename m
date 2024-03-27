Return-Path: <linux-wireless+bounces-5364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A288E867
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 16:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF95B1C2F21F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891783717F;
	Wed, 27 Mar 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fC4xPg1/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869E12F36F
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551765; cv=none; b=VThKm/teGjuTe0PlgsGlGLAM6sdoGujJFcM8kM00yb3CQbWjRBaUef0Rjtuo++v0MOGLFqSMgAcXorasH7p5w0JEf51nZAlTHyF2xq9lYK4cNDImD9Kb3HHNMugLgvrycYJqoYEXhUjeRJC3AZPbBsYfbpDVZLYXhxOEN8Quk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551765; c=relaxed/simple;
	bh=/HOFC4NMzQLH+fZipOwDqlkFH7ZST9l+6racndSRpZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hoGfXeFlrrCjGH9Io0ATW9zWQaxG2XmGuIAWxz2ycw0Jvl357ybbvlAy0a8i5Sf7JKzOubM4Q72Mmu7B+qaud3MAuiYM9yseZEcBAlsJ7fwMWj6rUBV9KP0lUOzMLvXU51x+Yr1smmq8OlLMHYlKQ0ChYKCSi+yQDVYzXBEfAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fC4xPg1/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RDdPX5004238;
	Wed, 27 Mar 2024 15:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3N1FmIYiPH53Ka4MptREjaALirR4n0ouCVqaY1qOPtU=; b=fC
	4xPg1/KbDFhkdpH1mbJUHMYoT1plAb9ZwVKVh4YsDs92UbRHqmDUFq+/yzM847u6
	YlqTPJMhdNX9FDN9Y4M7oxkNP3HijVyZaigoEifpPyqjt5ApOj+bkzhHpIxsPN10
	04VX0+XqbI1kM33aYQp/ya0w2ZR4PWujjCW7aDzUpop3rsytU4iHhrZIU6khE9H1
	QNRk92KJy25eiqyaOxP1wxsvG6zYVTXgsAYbZ52qjdsQUpXPwXBhppo805ZdX/xS
	xz0AfH78wI9ZQgoFozeYvNNg14Bigqgaoxr09n1lOae+kFlAnh9cPMeN8/BkSMF5
	8wogyBwyfzIJyW2oE9EA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4mh9g7bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 15:02:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RF2Xfk014545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 15:02:33 GMT
Received: from [10.110.28.48] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 08:02:32 -0700
Message-ID: <68c6fcbd-0aaa-43b2-b5e2-08367c11e79d@quicinc.com>
Date: Wed, 27 Mar 2024 08:02:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry
 stats
To: Johannes Berg <johannes@sipsolutions.net>,
        Hari Chandrakanthan
	<quic_haric@quicinc.com>,
        <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
 <20240319134522.4021062-2-quic_haric@quicinc.com>
 <d364e872eb29f03236630bab49a3243e2118ab22.camel@sipsolutions.net>
 <14699537-99b2-e468-6a7b-7b721193400e@quicinc.com>
 <b9dfab64822bacf0cc72380c0de034b79d489668.camel@sipsolutions.net>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <b9dfab64822bacf0cc72380c0de034b79d489668.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dzcq6EVj_P6iDDnJd7NywHEMWer9ggaI
X-Proofpoint-ORIG-GUID: dzcq6EVj_P6iDDnJd7NywHEMWer9ggaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=979
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270103

On 3/27/2024 3:32 AM, Johannes Berg wrote:
> On Wed, 2024-03-27 at 15:39 +0530, Hari Chandrakanthan wrote:
> 
>> Fields such packet count, retries etc can be summed up for the MLD 
>> representation and the existing NL attribute can be used for exposing
>> the summed up value.
> 
> I think the existing attributes can also be used for per-link STA?
> 
> I'm kind of imagining that - once we actually do all of this properly -
> the representation in nl80211 would be something like
> 
> 
> STA 00:00:00:00:00:00
>  - TX bytes: 123456
>  - RX bytes: 654321
>  - signal avg: -60 dBm     // picking the best of all links?
>  ...
>  - LINK 00:00:00:00:00:01
>     - link ID: 10
>     - TX bytes: 100000
>     - RX bytes: 600000
>     - signal avg: -60 dBm
>  - LINK 00:00:00:00:00:02
>     - link ID: 11
>     - TX bytes: 23456
>     - RX bytes: 54321
>     - signal avg: -70 dBm
> 
> etc.
> 
>> But there are fields such as signal avg, bitrate etc which cannot be 
>> summed up.
> 
> Right, but I guess we can pick 'best' for those, to at least have a
> value? Or we could just not emit those attributes I guess, but not sure
> if that's then all that useful?
> 
>> Should we expose such fields of each link STA through NL?
> 
> All of them, I guess?
> 
> I'm also imagining that we change the API from cfg80211 to the drivers
> to get the *link* STA information, and do the summing up and/or "best"
> selection there in cfg80211 itself. However, I am prepared to accept the
> possibility that we may do _both_ in the API, if not all drivers can
> even do all of the statistics per link. We should probably still have
> the link STAs in the statistics in nl80211, but then they may not be
> populated?

First remember that there are a lot of statistics, and each driver is free to
return as many or as few as they support, indicating the ones they are
returning using the "filled" bitmap. I would expect MLO-capable drivers to
provide the same information on a per-link basis that they previously provided
on a per-interface basis, but the "filled" bitmap leaves that to the drivers.

But I think a fundamental question needs to be answered: To what extent do we
need to support legacy userspace applications that are not MLO-aware?

My expectation is that MLO-aware applications only need the per-link
information, and from that they can derive their own "aggregate" of the
per-link information. So to support that we'd need per-link nesting of the
associated attributes. And if we don't need to support legacy userspace we
could completely remove populating the top-level statistic attributes. Non-MLO
interfaces would have a single link nest that contains the same information
that is now in the top-level of the NL message.

But if we need to support legacy userspace then we would indeed need to
continue to populate those top-level attributes with some form of aggregate data.

And even for the MLO-aware case there is the issue of how do we want to handle
the case that links may come and go, and hence aggregate counters would appear
to have huge fluctuations in values when links are added or removed if the
aggregate values are only calculated by adding the values from the
currently-attached links.

/jeff

