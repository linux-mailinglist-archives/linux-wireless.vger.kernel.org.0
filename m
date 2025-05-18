Return-Path: <linux-wireless+bounces-23125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083FAABB0DA
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 18:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F61A7A60DE
	for <lists+linux-wireless@lfdr.de>; Sun, 18 May 2025 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B61854;
	Sun, 18 May 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q6SoPhoF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CD7FD
	for <linux-wireless@vger.kernel.org>; Sun, 18 May 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747586083; cv=none; b=Hp8PCv0gBH5LVk1R2X1Yd85ILG+LkG4FNrN01JDoLoYiFfbz289EzSELzdr+QoOvke+cxVNetqgNRBxMXxW14PtfUwrY3uPp1fBYZWGVmlMeBqBbJxqHiz0LRwcHzmTlSaFyvo/xqV7uV5ygkyKKEtZULit0+6Z/g49FFVAuR3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747586083; c=relaxed/simple;
	bh=BiAgXi9VLy9RCP9OpMkCWbXv2MAqEgdXWKdfegtaMpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OblT9nak17pbBAk/Y4QrpTWvM255zH0iysjxqB4QU9kr4c/BhHsMO7CVY01fPjnR3pUEgaT0kp4fk73oIJDD9BtOA276oZ+YKiMjLhBCqIN52qEGMU7bTd7yQ7LbTBXds5m53XXVSXcnegmvNEpG+tWO2PevXRfk7VUqWa41ezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q6SoPhoF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54IDGKVl015197;
	Sun, 18 May 2025 16:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k9Z9Gr2mgOlle51seq/zHssCJ+O4nOGQ6KDmRLN95gs=; b=Q6SoPhoFc4v87IsZ
	USocdAKlZw/zA0qlhNVB8NQSkbgzFTtWIv2O6F26QRITIgj4fjkVLV0l6mOa9+Ny
	AHB2bgKd+eEwdqyRFuKDjl0LrlJZR28FVLAjxZdqtNc+iDZTaylLu1xtvzTQhnY+
	kOUDPmHT8FmAyIpJ1R/dWLEjZIyNbbMScPrDaNXYVEwEuulNqcp4cLkiW+DE7eBz
	G4zHSA42pTVmGjSGz086HtsHPlp/cQaAde317y5xmghWhtH5UcTpAtLuFv9XoXFX
	0tvRFcqZAKLNRIJA/V8SU7IxSTJ5gkOJY9jsfMOr4sDKDgOFQiesMNyr0vgW0W59
	JTk60g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjjst67j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 16:34:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54IGYapb028812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 16:34:36 GMT
Received: from [10.50.4.209] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 18 May
 2025 09:34:35 -0700
Message-ID: <dd416225-2302-4f50-a980-a76c7e541fe4@quicinc.com>
Date: Sun, 18 May 2025 22:04:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 07/10] wifi: cfg80211: reset
 sinfo->filled for MLO station statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-8-quic_sarishar@quicinc.com>
 <b6aa1823646f6911c6dab8db973398bda8526a9a.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <b6aa1823646f6911c6dab8db973398bda8526a9a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A21FMItXCW8dzaiR9y6Io1Tpz3r3Oej5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDE2MiBTYWx0ZWRfX28ZdKIFVtQYN
 /6ZB1sKGYVIlNI4WZuYaki8EPZ9Bl2/B31gWH5Vx/312bneW7F5oJ+C31jcfd7874NmJDyy276V
 ytdrspnH1mINUIGGwYuk8a0jiuG/40r21ne6gkE62OQWYYBqzdzYWNwVJZYe8f0SEyRnoIDgs2d
 P48NUBBAEy+4PU/qfWZSQ0z0mxzvNaoGSHGTkUKk/5x69bs1Sx0Lo4CXsNE9Xpx1du/8mPnE+A1
 eApdsvnjJaQ7yYfklrIMLpCb52zkvspxMavisfOOIyUKsIah2bAp7nk08VOaVs0LQl0EQrgRuuY
 LIGkurAwWrjmFX/E9M4HjIsQ42pRI6tNHccwbf4lqMv857NDC9RizYlTL6afpja9RDqbW8qs3vi
 uosSZlF5I1EaqWcmJy/Sc02UOFhzLMwbSTORbMKE9okUrK2T/j0fUT7NE0CNhSedbMy2FVzl
X-Authority-Analysis: v=2.4 cv=K4giHzWI c=1 sm=1 tr=0 ts=682a0c1d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=AQnfCzUfGodVWXXiQbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: A21FMItXCW8dzaiR9y6Io1Tpz3r3Oej5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 mlxlogscore=849 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505180162

On 5/15/2025 5:06 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>> Currently, sinfo->filled is for set in sta_set_sinfo() after filling
>> the corresponding fields in station_info structure for station statistics.
>>
>> For non-ML stations, the fields are correctly filled from sta->deflink
>> and corresponding sinfo->filled bit are set, but for MLO any one of
>> link's data is filled and corresponding sinfo->filled bit is set.
>>
>> For MLO before embed NL message, fields of sinfo structure like
>> bytes, packets, signal are updated with accumulated, best, least of all
>> links data. But some of fields like rssi, pertid don't make much sense
>> at MLO level.
>>
>> Hence, to prevent misinterpretation, reset sinfo->filled for fields
> 
>                                         ^^^^^ clear?
> 
>> which don't make much sense at MLO level. This will prevent filling the
>> unnecessary values in NL message.
> 
> Not sure I'd say "unnecessary" but perhaps misleading? I'm also not sure
> this shouldn't be WARN_ON, we're throwing away data that was provided.
> In mac80211 it even allocates tidstats memory for nothing, in this case,
> that's super weird?
> 

I reviewed the code again to check for pertid and realized that it is 
applicable at the MLO level as well. The rx, tx fields are reported per 
link (which can be accumulated for the MLO level), while the TXQ_STATS 
related fields are applicable for station level meaning MLO level.

Therefore, pertid is applicable at MLO level and also at link level for 
rx/tx fields.

Let me add code for it and send the version 9?

> johannes


