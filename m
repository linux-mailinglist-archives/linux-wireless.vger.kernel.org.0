Return-Path: <linux-wireless+bounces-22976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED5AB7CE9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 07:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C26F8C3C45
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0B617A316;
	Thu, 15 May 2025 05:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FHy1rlnf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B301A841E
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747286363; cv=none; b=uAdqGc41tETq9qUKzNT0lL3Cn5GRS3NJNPKMM3px/VQcdTPtNIjgTFb6Zw8Oi16RvHnh3rh5tom5E9APV2Ilw99pOdG+fBOips+iRRgOjV344K42g9ovlHIbrxSLNxAaE+VwMcoLH6+RjIg3mTxNLfwBEiaALsgHZjrDdhs0DmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747286363; c=relaxed/simple;
	bh=+ViT5eTOJj3GGcWmhx/xiIEv5f/DFR18F43L6P3jRng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N+R2Ju4dnZ7OBFCiu2x0fOx+XNaL92/O0NzeEU1PTzXzOOTM+R5Z8tVM6TnukgTft4kNne3q9GjOL1eOdV4tEv0aL50odLzGMgzNeeaQx4iY8fvEH/QlxPHb2CXNMqpNcRgKbvBPnDXm0JN6q6NlXsOlCbDvRFtPmgGeCAC60cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FHy1rlnf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJfsXZ012639;
	Thu, 15 May 2025 05:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4fTSUm4prASJQGe/U1VMnOf8GUbfh/JWQIm+eazzcWw=; b=FHy1rlnfT3Iq8R3d
	GW9x/VdDDt4/DqzG/zqBZSAiBP8WCzkX7jDI1aBqE/sAR7Iy9cAAFOzF0sgsvx+W
	cJDAbK/5p9qwkFPaKCOMUv4tXQw0vhnZmV0K82MOR29tkCBKIVTc+DNzMI51f4mk
	r9uklbWVUy62CNm0nBNkAFB/n41tYsuspGfYfPccC3vYIsr0erTHZtwa6nyClWGI
	idWv+nJwITrqN3hHR+0LR+qIRPZhKmU22YKrI07QPETpJxO+GmswGhQJR+CXAZ9c
	IhN0ro7rc6o7xj20ll16+mjS/fNUG4JhSjZlpNwvUAB55fwSwPR4xF6Elb+UkyoT
	CEKEWw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyn2ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:19:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F5JGIx025364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 05:19:16 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 May
 2025 22:19:15 -0700
Message-ID: <e8a2d899-134c-4203-b153-6e74f37cf504@quicinc.com>
Date: Thu, 15 May 2025 10:49:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v7 05/10] wifi: cfg80211: allocate memory
 for link_station info structure
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
 <20250514164857.227540-6-quic_sarishar@quicinc.com>
 <25b89deed3bb6871109fa94c3c967a27a35e3d90.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <25b89deed3bb6871109fa94c3c967a27a35e3d90.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RIVjYvKe7qNFnuKffEhWqJxQVsHqV9Tl
X-Proofpoint-ORIG-GUID: RIVjYvKe7qNFnuKffEhWqJxQVsHqV9Tl
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=68257954 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=stkexhm8AAAA:8
 a=EeR8soJtryZRNb31oUQA:9 a=QEXdDO2ut3YA:10 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA1MCBTYWx0ZWRfX/jmTSoAPLxkx
 CZ7h1YCfTwZNoartcpVi9ai9F5urC+OxJcH2abJSGDj3Wqh+vnrKFaxaGQOk6wMrIK32BpJvoTY
 IHfLA2MdHvrkAOkTTPJlAdNS4gtp+ofcJJe9ZV+w4npqtZogXs9FcXTnRoOYC6TqNcQUkSR0BTj
 CyWZVX0OCs70/NXzOykMoj8CrZZY8Dca//x4zX+DsbwfWUWqWm9uoUICPQj8/tdV3rttB4/XOfJ
 5LjAOv9Pj3eMSNAAMszE7HubTYNW5loNEFMFfguRHb6sMmXgFpRqx2da69mTcLJ7a0mPoBQiHns
 eT80V3BGJJuEppPK74PAh1VLdOlkrR8MIzRFPL78w9CZ3GISpaeUt1ilYbnvdPH88T/A4py0sIy
 D9cM3FzFb7zsi7i/DLJMG8ELoVcvWXUp4/FbTuVmZMlGyOyzAhJirK1c5VBhPRAtpit4bujK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_02,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=951 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150050

On 5/15/2025 1:23 AM, Johannes Berg wrote:
> On Wed, 2025-05-14 at 22:18 +0530, Sarika Sharma wrote:
>> Currently, station_info structure is passed to fill station statistics
>> from mac80211/drivers. After NL message send to user space for requested
>> station statistics, memory for station statistics is freed in cfg80211.
>> Therefore, memory allocation/free for link station statistics should
>> also happen in cfg80211 only.
>>
>> Hence, allocate the memory for link_station structure for all
>> possible links and free in cfg80211_sinfo_release_content().
> 
> I'll probably take a look myself tomorrow in the interest of getting all
> things lined up for 6.16 quickly, but chances are you'll be at work a
> couple of hours before me (and I'm not really all that awake now), so
> pointer to this bug report from the bot:
> 
> http://wifibot.sipsolutions.net/results/962902/14088291/build_allmodconfig_warn/summary
> 
> Says some locking issue.
> 
> 
> Also, is there any specific reason to want to allocate each link
> individually? Why not allocate them all together in one bigger
> allocation? Doesn't matter much though I guess.
> 

Also, while implementing I think this way looks clean and easy to parse 
the links using link_id, also while allocating/de-allocating pertid for 
link level, at least to me.
So I would keep this like this only?

> johannes


