Return-Path: <linux-wireless+bounces-20101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C2FA58C75
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 08:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BC03A8D11
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 07:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075F1D5162;
	Mon, 10 Mar 2025 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fJVdeZmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768911D5145
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590303; cv=none; b=REAY8sgBqw8+m2W1SVQpe/GvcVO5oYzANFzO7xUSNJARacg9dsf0zSCUvFQJ8+VnChuwAWdiJ8p38fMWHqfg9XSkVFTbyN/VJsutd+7b/Oad7npY9f/0l9kztWQYTZDAeq3WaDvwOt3pBX+OyisWpTROOjuBsutcwAgpWmWjdb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590303; c=relaxed/simple;
	bh=mfGK6pmUBDZzi3sIoRl6HdqKrfSZ+H+yWbOXGOw4Pww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=freYtaUpuBraLD8VgpIAiQXkyniGRQdBWqFvu7cDkPxM0bMnud9kxh+javu3PQsH8n1vanxSe3j0Y3V6wBFaO9uvKG53dJZMyL3rUgHRX9RNtG9g2sz4YSrktTJKumdtj34qskZ/oFuCATHhl80nPGVLlq8Fk/9U8hB1/hG3CHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fJVdeZmh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529MmQ5T012249;
	Mon, 10 Mar 2025 07:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vneYlfy0R7FV2LZdyGeUfqwxEoWE7Edat95mE+5Q82c=; b=fJVdeZmhXsBYYyeZ
	K1ume16hy/jYU6w1DrnJ+pOv2KSThyH6pUKWAu8uzT0zvQ3QllSuKi9BtJpX6x6F
	cXaJQmzSJU9/O6fSVqszltvEn6noWuNK6PeguvuXN1m0vWriAKFIVamxEx8ot065
	JpyMRX3v3DUmF/3gSpCvmJFQ4DM9zTWH6NFFulOZRP4591XxDWDIaRPaKNo9RObw
	WvQ5GW8TnBCvjR9NWDtkeHQkRed4dL10gRIGld9fdzkzCyNYrKHJZq7yEL6oRjDn
	xghjQYUCg0I4bB16NRb6LCovPRhvamJz3PV7ihrksiA3C1R5SLerO2xo3Newc69z
	Xd5fcQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyubsyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 07:04:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52A74tTC018688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 07:04:55 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Mar
 2025 00:04:54 -0700
Message-ID: <41e32704-6a68-4255-b922-ffec0f8a29db@quicinc.com>
Date: Mon, 10 Mar 2025 12:34:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] wifi: cfg80211: extend statistics for link level
 in sinfo
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
 <20250213171632.1646538-8-quic_sarishar@quicinc.com>
 <6c6be5e9552d32d0598af6aee55ceae450209f7e.camel@sipsolutions.net>
 <e989f3fb-4fa7-4839-9b98-d9a8c7341b1d@quicinc.com>
 <8456af3fea13b3a6696bbda042f8dea140ab26c7.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <8456af3fea13b3a6696bbda042f8dea140ab26c7.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=cbIormDM c=1 sm=1 tr=0 ts=67ce8f18 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=1xdCTR79KF1Sqvxw5EYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n81xzKjfS67-IPSvOCdSPPTuaxXpEBjm
X-Proofpoint-GUID: n81xzKjfS67-IPSvOCdSPPTuaxXpEBjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=657
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100054

On 3/6/2025 5:38 PM, Johannes Berg wrote:
> On Mon, 2025-03-03 at 21:37 +0530, Sarika Sharma wrote:
>>> This looks like it's missing the roll-up to the global counters and
>>> timestamps? Why would that not break backward compatibility?
>>
>> For non-MLO it will not effect, for MLO I have added accumulated stats
>> for packets, bytes and signal, rates at mld level.
>>
>> For inactive time, DTIM period, beacon interval can I add least of the
>> values among links ? and add as a separate patch?
> 
> I guess some like DTIM period / beacon interval don't really make sense,
> but for some others we should have it it?

Sure, since we are not sure what application wants, so will keep the 
entry there as well.

> 
> Not sure why it should be a separate patch but I guess it doesn't matter
> _too_ much, hopefully nobody will need to bisect this specific feature
> ...
> 
> But honestly you could almost just add the roll-up support in cfg80211
> *before* you even split it in mac80211, it just won't do anything until
> mac80211 reports per-link values?

Okay, may be I can include these changes in patch "add additional MLO 
statistics" itself and add that patch before 07/12 patch.


