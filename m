Return-Path: <linux-wireless+bounces-23299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C5AC09FE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957571BC3431
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D84265633;
	Thu, 22 May 2025 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lk9YGNsD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529533DB;
	Thu, 22 May 2025 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910441; cv=none; b=U7I3o1hmXj69ccLKrfvLRwbJhzCGQM3NJ11pzuz9mF40r21QcBxzEAuBdQKU/B9zOMeCEYN0ueusdYuFfH/Nv1gFukCc9lM6J1ujwYeePhk4DOgT6zn+D32SgwGjGkwZewNExcGR4169E6iNan3oAn3Uxxt5extbDf9wbqVg5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910441; c=relaxed/simple;
	bh=BgI6icr/Wjiood84lPLJ77Ndk+DhQIJrzqbCfTO20xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JpDEqhHfBHHaN/c2QObX1D/xMV4XhaArwJA+BA/mTdlEFVPThwKt9XeeRpC/7HS4Dk1HUfsrFMumFpWmTDHYr3qkI83bKXvQZqhp8QUBO8abtW5rXHQDy2w/Uk3p6L+xZcGM44Cdqu3lP/H4nrJUEtHdkL3baernFM/wA/wx+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lk9YGNsD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7Q9wN020593;
	Thu, 22 May 2025 10:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1f15688sGbNBnKnMsnfoeokx+C9510AIGo/wviO5yks=; b=lk9YGNsDcgEyYm6V
	FTQDC7EUQHC6olQxoQxeq3bmG05nmlDrpMOEfFW86mW/btRE786RmYFVhi+Gcpj3
	3BO0+5mcQX4xc7B55yVWYdTWfJJHooddEn5XQY+lxU1V8Fc2+R9X1dJqpxXb/N96
	IXhTIrN5fF4c7JsVrUc1FxVgIE4BUcnTF/dei4Vkj5pafnFf2grkSliURVLym1bQ
	EJs10ZtG0uXw4f+nICddRNE2zi2wrhuwWCVbrhZ5Cwwd9YEJbzLFWZH8s3kzWEVk
	GK1mQkMNwje6T4aYcUDOBAd770JQLpjo+0+KkVRtJeRnXIrBmvtTJmr04jpfffAz
	zgp08A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s9pb4cby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 10:40:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54MAeYv8026388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 10:40:34 GMT
Received: from [10.152.207.135] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 03:40:32 -0700
Message-ID: <a91c82f1-df99-4938-8f41-ce90e9e08ad8@quicinc.com>
Date: Thu, 22 May 2025 16:10:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/3] wifi: mac80211: Allow scan on a radio
 while operating on DFS on another radio
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
 <20250514-mlo-dfs-acs-v1-2-74e42a5583c6@quicinc.com>
 <d23e55879c6d8b6cabcc8357f153ae0622a4c53a.camel@sipsolutions.net>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <d23e55879c6d8b6cabcc8357f153ae0622a4c53a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WJl/XmsR c=1 sm=1 tr=0 ts=682eff22 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=jKTSB5wdZoaetGI8vLUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CEqPU29Ul2iFxOjZXS0u-9-PTIYEK9Ip
X-Proofpoint-GUID: CEqPU29Ul2iFxOjZXS0u-9-PTIYEK9Ip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEwNyBTYWx0ZWRfXzlznalKl1ErT
 GLcZUrd/5GQGFXUM/h9IVCXajBcnZw3AH3td7/jBREoT/vKchyt0Mb/MicPACJh+Z9UvxD8XJmn
 rYptjqR/ZXOq2hsehnHZf7wpz5uhxyqhGO4AqyHtNNiWoJfqk/RUk1qtvHwd5qwW8LfcfsuA9WX
 Wq4jitsBIiZ55ptjuKdR5iJzqIjKoKCrfggkMS+KyOYJG53O+4yhgcbP2W9ecvmOII2AEjLXZrh
 kUVuKpmYH1BHTfEiIFp/iv+chANTd2TkObAx5ROvm3801jfgJb9aL6peuHL3GkkB8h+los7ecuf
 amhDEa2IYhBCUbM8MjrH1wrFm3p6On+RKDCAvMCO4t5oe7nJn9KIGI9W3wJNlJWHi/TSJPWphID
 SyOZSVuOZT1pRgoGzX+YxJW1r9KgqgSUKV+PYzjJ9JUcsw6Xc/12lj2Dl5Pe078Z/AHO0RRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220107

On 5/16/2025 1:31 PM, Johannes Berg wrote:
> On Wed, 2025-05-14 at 16:58 +0530, Raj Kumar Bhagat wrote:
>> Currently, in multi-radio wiphy cases, if one radio is operating on a DFS
>> channel, -EBUSY is returned even when a scan is requested on a different
>> radio. Because of this, an MLD AP with one radio (link) on a DFS channel
>> and Automatic Channel Selection (ACS) on another radio (link) cannot be
>> brought up.
>>
>> In multi-radio wiphy cases, multiple radios are grouped under a single
>> wiphy. Hence, if a radio is operating on a DFS channel and a scan is
>> requested on a different radio of the same wiphy, the scan can be allowed
>> simultaneously without impacting the DFS operations.
>>
>> Add logic to check the underlying radio used for the requested scan. If the
>> radio on which DFS is already running is not being used, allow the scan
>> operation; otherwise, return -EBUSY.
> 
> So while I agree in principle, I think this needs to be more carefully
> constructed because it relies on an unstated (?) assumption that each
> radio is going to ever be used for scanning on a certain band. That
> seems to make sense, and a radio will certainly only ever be able to
> _operate_ on the frequencies listed for it (due to chanctx etc.), but is
> it really true that it will never be able to operate at all on other
> frequencies?
> 

I'm not sure If I fully understood the this comment.

This patch assumes that multiple radios are grouped under a single wiphy.
Each radio has its own list of frequencies it can scan, and there is no overlap
in frequencies between any two radios within the same wiphy.

If this assumption holds, then if one radio is operating on a DFS channel and a
new scan request does not include any frequencies from that radio's list, the
scan should be allowed—since the DFS radio wouldn't be involved in handling that
scan request.

> I'm not sure I find the notion of e.g. having a 5 and 6 GHz radio that
> are used for operating on those bands, but being able to scan 5 GHz
> channels using the 6 GHz radio completely unimaginable? Maybe it is
> though and I'm just overly paranoid?
> 
> We could also just leave that up to the drivers, of course, but then I
> think we should _state_ this assumption somewhere in the docs/header
> file(s)?
> 
>> +bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
>> +					struct cfg80211_scan_request *scan_req,
>> +					int radio_idx)
>> +{
>> +	struct ieee80211_channel *chan;
>> +	int i, chan_radio_idx;
>> +
>> +	if (!scan_req)
>> +		return false;
> 
> That seems overly paranoid, or maybe it should be WARN_ON()? I mean,
> asking something about a scan request and then not giving one is just
> the wrong thing to do in the first place, no?
> 
> And if you're going to be paranoid then this probably shouldn't be
> called with an invalid/negative radio_idx either :)
> 

sure, this function should not be called with NULL scan_req and invalid
radio_idx. Better will remove the check: if (!scan_req).

> 
>> +	for (i = 0; i < scan_req->n_channels; i++) {
>> +		chan = scan_req->channels[i];
>> +		chan_radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
>> +		/*
>> +		 * Skip channels with an invalid radio index and continue
>> +		 * checking. If any channel in the scan request matches the
>> +		 * given radio index, return true.
>> +		 */
>> +		if (chan_radio_idx < 0)
>> +			continue;
> 
> This seems ... wrong? If there's a channel in the scan request that
> didn't map to _any_ radio then how are we even scanning there? And the
> comment seems even stranger, why would we _want_ to ignore it (which it
> conveniently doesn't answer)?
> 

It seems, (chan_radio_idx < 0) should never be true because the chan is
taken from the valid scan request. I should remove this check in next version?

