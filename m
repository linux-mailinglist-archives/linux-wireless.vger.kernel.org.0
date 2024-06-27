Return-Path: <linux-wireless+bounces-9641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F57D919E1E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 06:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CB91F23E8C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 04:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164021BF24;
	Thu, 27 Jun 2024 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Woi5CdtQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3A1BF3A
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719461886; cv=none; b=N78Bn3hlSZAGs08wIV/W9BcbX1iur0KUE1dqvM9XYaBrltQiUi3+SUF5d3P3epRjojSJdGMQIjzzJkc+Xi7xfjitCH86qbbDiF/d4mCIxTPIH7VRKEiR6LMrO5Qwr3UFpOjM11/qUF8UJodiu8quZWtT9rj951qROv9yjC9i0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719461886; c=relaxed/simple;
	bh=3B+tCTuhjKDXvjm5tsN6ROteaQ4LtXVfapnLuLpK81A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lc7bJOw0fg+raFPwq1DvD7FQ4mRg0f9YLSy5DdembCIetdC+UhNC7FucfAPncYsg3BybnTkQi810fmO/USiO36FEzcs29UgPhejCYhKzi6A+J4819qDnDCF7VAyR6lwJSPmngStE7qH3Z+crP99P6wxQtRM/LuXpgdE+HvAMSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Woi5CdtQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R15Wth015329;
	Thu, 27 Jun 2024 04:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	45fD0uWbBp1TvwvefjOINb9quvl89I97caEk8Bv5hgA=; b=Woi5CdtQlewGZ80B
	b3wxSYu/YLmWTdXFXLPnjD9SIi/xCmPXMHFK/RTeD29l4mamiyfPMDQK1YaE2TqL
	h1S7R/EaCK9LlB5Rchsh4YvpsrjbEBwykB5lzdE4JStBYbIvMjn72Nf8MNhEkcNr
	B17xFHWyrzzLCYhx+wWeuDIHVj2Z2T2QsEo6+DJYqICQT3Ow2ASuT4r3jkm8Ofd7
	CpsiQB7hc5/uzK4SwvO5Dt/Z6NoPb4PRJ0p9Rv55Vx/9bxEaxH6SyRh71KiMSX5N
	x1kXnIBu2wWAL+0nXCFt1IptSuQXcVM/OLFPU36z3PImSvWfniR6ODh5OrGRXQfo
	zm2B4w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400gcma8hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 04:18:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45R4I0ju019093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 04:18:00 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 21:17:58 -0700
Message-ID: <0fe59d00-e911-4eea-af37-e8cdde116c69@quicinc.com>
Date: Thu, 27 Jun 2024 09:47:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] wifi: mac80211: abort active CAC while freeing the
 links during MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
 <20240626045216.3754013-10-quic_adisi@quicinc.com>
 <2670d8e27e9c296e3c0de0572f6387aa9ea3ff93.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <2670d8e27e9c296e3c0de0572f6387aa9ea3ff93.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7ES8fn85upTl5hPjdXL39EYnmTJ0E2fM
X-Proofpoint-ORIG-GUID: 7ES8fn85upTl5hPjdXL39EYnmTJ0E2fM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=2
 mlxlogscore=834 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=2 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270029

On 6/26/24 18:07, Johannes Berg wrote:
> On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
>> If CAC is started and the interface is brought down, currently, CAC
>> started on link 0 is aborted in function ieee80211_do_stop(). Technically,
>> by the time execution reaches the above function, all links are already
>> teared down and hence link 0 (or deflink) alone is handled. Also, since
> 
> nit: torn down

Okay.

> 
>> links are teared down, information on other links is also not available.
> 
> same here

Sure.

> 
>> Hence there is a need to handle this in function ieee80211_free_links().
> 
> Not sure I buy that argument though, it feels wrong. Clearly you should
> be able to stop this from even cfg80211, it tracks whether radar
> detection is running, so whenever the link is removed, you can also stop
> it there? Doing it on free seems much too late.
> 

Actually if cfg80211_remove_link() is called, then it is aborted during 
stop_ap handler. So that path is fine only. This was done in situations 
where properly interface is not brought down or abruptly brought down.
For example AP is started and then directly iw wlanX del is issued.

Ideally the normal deinit flow should have taken care but just in case 
if still somehow by passes it then ultimately while freeing the links it 
will be aborted. May be should I rephrase the commit message?


