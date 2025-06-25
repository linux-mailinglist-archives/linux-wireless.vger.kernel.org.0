Return-Path: <linux-wireless+bounces-24456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E95A2AE7593
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 05:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639B11896529
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 03:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1BC1DF252;
	Wed, 25 Jun 2025 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NiiVRrnF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9C33E4;
	Wed, 25 Jun 2025 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750823938; cv=none; b=ZiilqfrEUC6hkeg9h+77W/NCEiqi+n2KE1IlJqFW9ZVkT1bVYvHs4w77pMQzxcQHtcJgitiwA3GyACxu/UZbZa+fi0vsSsr/0/LbPqjFmUddxPN7hYD+tRslIWEmfPxO0+ihi1GObv4syBCAY1IqHcN/5BCkUaRFee5ePyMZ8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750823938; c=relaxed/simple;
	bh=vQvEGEgNZHjufc6H7ZluamjlZegYWHN2U9pEK2MhR14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j3EUsTrvHQnMk4agKCOe9xZ5w/lfshKlHs2B8rLdO/txdqwLKqAz4PXExp/t/L8FsExb2a9682/JnHhQ5Fnf2HQvMGdGN+4YQgX/UhJVtSLnaCYZfWZQ8E2FEi0nMk51QeZwKKu3D+x4bF1kQgqcKr5EiRPAna4VR9O5IWG9SZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NiiVRrnF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P0hS4d007242;
	Wed, 25 Jun 2025 03:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fkzOHQ3GrBw0pkjCENP+zm3ZoGnq0r3YejL6OMja85c=; b=NiiVRrnFlm334I0Z
	Enbxzan8T84xt+OXz94CkQjutXUGeshQfb8jXqN3GYP1+7LqMafE6daBpIl9OZ6n
	DFUgYbsmtGYMpGK/ZVa/fZTLxQ630sPgHhY6npiMlyBBylOAwkmrW3hqHMo5eACq
	z0K6CjGr5awW2/UhrY2hBfpdDg2vUI9CYbAcm2wR7f7gAjhdvnaoqDDQrPYI2fUe
	L/H+Xcdx+cwNvOt7aMWBltV5af5cxUsN1z++I+2MP+lXA7l2Vc/yMBuTQYPPEsw1
	/rr7Ds8ZxBsLOtSRTcl/5FFqIwpTk1vUtIRQbz0sDFIOo2e2xN3NVgudtM55OxEV
	ILYTMQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec268m74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 03:58:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P3wa1v011457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 03:58:36 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Jun
 2025 20:58:35 -0700
Message-ID: <d63e5f8a-8e0a-4619-98a8-e73c80e307cd@quicinc.com>
Date: Wed, 25 Jun 2025 11:58:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: mac80211: Prevent disconnect reports when no AP
 is associated
To: Johannes Berg <johannes@sipsolutions.net>,
        <miriam.rachel.korenblit@intel.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com>
References: <20250620032011.1102373-1-quic_zhonhan@quicinc.com>
 <a5078d3c7f3d1c2281a3f5a50386fdb7072935bb.camel@sipsolutions.net>
 <5e378fe7-90ec-4453-b549-1106f9d0cfef@quicinc.com>
 <89dd111db62029f1575f7a7113e2a0cb5a1a8d5f.camel@sipsolutions.net>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <89dd111db62029f1575f7a7113e2a0cb5a1a8d5f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAyOCBTYWx0ZWRfX4GKinQWaAyzu
 WSrrKm4Bov3nUfLPUnMlKWhU8ly9HQO+mQRhxWyyyLY7ouzjCgbs2Szr4PbgTqFUR94lIyHqBKd
 48xUEmT8NqGTBgnsfwoK1Tmxki9LaXf97kZ76tW9/V9re+HkZos2m5kXkJgj8Iobv4GcyKUj5ow
 YNO7/kXKMhNXxMmjKC219Bh5+Nq//gBeK+3SRjGqwGZGtbfzDh3CBeGqF6cm/l2abbvZn4ek1g7
 RXIjMq+tEmmgeM+sHNwZl3NpoIG1nJOpTaO3QI+4Qnfz4GFDwG+eSZNgoS2U0EmdxFgb2RzWr0E
 +46TIyAr1+uZxMqOu2BvR2TaApKfWAxUuC5k4NRfn9zFIF/BWQz/Y83Vr8xn8z1u30YJPOzMN5K
 5fSGBnICNkStkNQVWR++3HiwzRIde1WGFoUDSFu18BCS3srG48niNTbOoV6ZooWFXEQVtu57
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=685b73ed cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=bZMOsnj5FEY3cgoaLesA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MWrzvsTm1B5xF65pUdneLkMXGaLDDbk7
X-Proofpoint-ORIG-GUID: MWrzvsTm1B5xF65pUdneLkMXGaLDDbk7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250028

On 6/24/2025 9:35 PM, Johannes Berg wrote:
>>>
>>>>     - Remove WARN_ON and early return in ieee80211_report_disconnect()
>>>>     - Change the return type of ieee80211_set_disassoc(). If
>>>>       ieee80211_report_disconnect() uses the frame_buf initialized by
>>>>       ieee80211_set_disassoc(), its invocation is now conditional based
>>>>       on the return value of ieee80211_set_disassoc().
>>>
>>> I don't understand this change ... surely syzbot couldn't have run into
>>> an uninitialized buffer after the WARN_ON since it has panic_on_warn. So
>>> why all these changes:
>>
>> yes, syzbot couldn't have run into an uninitialized buffer after the
>> WARN_ON on **patch v2** such as:
>>
>> --- a/net/mac80211/mlme.c
>> +++ b/net/mac80211/mlme.c
>> @@ -4433,6 +4433,10 @@ static void ieee80211_report_disconnect(struct
>> ieee80211_sub_if_data *sdata,
>>    		.u.mlme.data = tx ? DEAUTH_TX_EVENT : DEAUTH_RX_EVENT,
>>    		.u.mlme.reason = reason,
>>    	};
>> +	struct sta_info *ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
>> +
>> +	if (WARN_ON(!ap_sta))
>> +		return;
> 
> I think you misunderstood ... We have this WARN_ON since 687a7c8a7227
> ("wifi: mac80211: change disassoc sequence a bit"). Therefore, !ap_sta
> cannot be the cause of syzbot complaints, since WARN_ON would panic it
In my experience, WARN_ON is rarely configured to trigger a panic.
> before it ever gets to the uninitialized memory use.
> 
Hi johannes
Thanks a lot for your discussion and review~

 >>>
We have this WARN_ON since 687a7c8a7227
("wifi: mac80211: change disassoc sequence a bit")
 >>>

this WARN_ON was added in func ieee80211_set_disassoc() but not 
ieee80211_report_disconnect()
I add WARN_ON on ieee80211_report_disconnect() on my patch v2,

It was precisely because of the WARN_ON at 687a7c8a7227 that caused
ieee80211_set_disassoc to return early(when panic_on_warn is not
enabled). As a result, ieee80211_set_disassoc failed to properly
initialize frame_buf. Then, when ieee80211_report_disconnect was called,
it ended up using an uninitialized value.

> 
>> "You're adding a WARN_ON() that's now guaranteed to trigger, no
> 
> so now it's no longer your WARN_ON, I guess, but how did it trigger? I
> really think we need to figure out how it triggered and fix _that_.
> 

The bug was triggered as follow:

Commit 687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit") 
introduced a code path where ieee80211_set_disassoc may return early if 
WARN_ON(!ap_sta) is triggered(panic_on_warn is not enabled). In this 
case, frame_buf is not initialized.

Later, when ieee80211_report_disconnect is called, it attempts to use 
the uninitialized frame_buf, resulting in a bug.

This is the reason I tagged:
Fixes: 687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit")


In my patch v2, I want to fix the bug by adding "WARN_ON(!ap_sta) and 
return" on  ieee80211_report_disconnect() to avoid continue use frame_buf.

In my patch v3, I plan to fix the bug by avoid calling 
ieee80211_report_disconnect() when frame_buf is not initialized by 
ieee80211_set_disassoc()


> johannes


-- 
Thx and BRs,
Zhongqiu Han

