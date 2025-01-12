Return-Path: <linux-wireless+bounces-17378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D7A0A7A1
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A117164D6A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 08:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255A1494A3;
	Sun, 12 Jan 2025 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ko/c307W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666C379E1
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736669427; cv=none; b=KBZHI0nVHqgOa6SBL0x698cl6A/9rHrTTrr3OelyDmSuTHcDhMJ2dZDzW2lMK6lkMSWxn6871669yaGgpiHIn9TuwBseIkEhANy8q/kukSOSFcNkpASqfcXs77vbLUxhX11C5NtcgWR94KylT8pzmJHnGb0nqQ7rgYZwSmG338I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736669427; c=relaxed/simple;
	bh=0uw+uxRSUUC8RKzaWONVsbyPXdbGgW9IVgIMP6wTI/w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=bAdiZ8CdwyWPqLSLDawC/5svyOFxCBzc4lksYmRL3GEdXdHvzQABvsXshU4kje4yRJsTsywfLJFKO+vVmITXo6iVsQoovYBkbnbFSM4FyH6aZqNEIKjbLcWQRioM9JElU+zFGLMwqVHLUVEZGSgmavSX3kuTSh2IRRRdfsTxiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ko/c307W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C7Dehi018365;
	Sun, 12 Jan 2025 08:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6zlyJRBffHMQ35i+rlst5wE1/BEeJYDIyg5n+TBLKrA=; b=ko/c307W/ABEIvFQ
	3SjzuZSkKy/lAa7t2hZ84T96ONj4aIbBnHbbc+4/l/YXhUSFyRiN/8nn2M2876jR
	/8cXzZA1ohwiCC3CjPXZ0i1U4VOlPfOivr7qR9lCy8BMhi0HBvvWXKlmflXQqc28
	ZC2cU5gNUI3RpVGGF1ZsvUMWmyLbcPoM3asAllqqmrjeEso/Z70UIEC+Lxkg4tgv
	CZjhx/AY9rEPfIN92a4C7736Obo+xYGU3zRf942GU+62YwiaxiEdz5mB1fV+T8ho
	AVTSVxZJw0K5Z8eIPnXSTsAb+B9GpAy0VPEQbWADCcJudSOmDJwhqOz/imD1vyHk
	MaTzeg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hjk9rag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:10:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C8AAP5019580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 08:10:10 GMT
Received: from [10.50.34.183] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 12 Jan
 2025 00:10:08 -0800
Message-ID: <3d18b02c-3f70-43a5-b825-0d191336a3e4@quicinc.com>
Date: Sun, 12 Jan 2025 13:40:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sarika Sharma <quic_sarishar@quicinc.com>
Subject: Re: [PATCH RFC 2/7] wifi: cfg80211: reorg sinfo structure elements
 for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
 <20250110042449.1158789-3-quic_sarishar@quicinc.com>
 <2f3a8f1c5e9dd41ef38e7dc7cf9411d00313a806.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <2f3a8f1c5e9dd41ef38e7dc7cf9411d00313a806.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: peeUBSpwwaFxiG5wIybka1Sd0aCXZWMC
X-Proofpoint-ORIG-GUID: peeUBSpwwaFxiG5wIybka1Sd0aCXZWMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=732
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501120070

On 1/10/2025 2:49 PM, Johannes Berg wrote:
> On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>>
>>   struct station_info {
>>
>> +	struct link_station_info deflink;
> 
> Having a deflink here seems kind of questionable?

ohh! why so? In other structures like vif, sdata, sta, we did the same 
way. So why can't we have the same way here as well?

> 
> Why not pass multiple pointers?

Sorry, I didn't get you.
Did you mean keep the sinfo structure and call this for filling all link 
level, non-mL, ML information?

> 
> Also here I'd say you should split this better. Probably the whole
> series needs some reorg for cfg80211/mac80211.

Sure, let me check what I can do here.

>> -	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
>> +	if (!(link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_BITRATE)) &&
>>
> 
> A little less renaming would probably also make this easier to review.

Sure, but this is corresponding to filling link level data, that's why 
just renaming sinfo to link_sinfo.

> 
> johannes


