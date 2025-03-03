Return-Path: <linux-wireless+bounces-19689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15308A4B9E9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 09:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4FF169324
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940821F03EC;
	Mon,  3 Mar 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Csj5v03e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F421EE014
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991763; cv=none; b=uGtAYLt/NzZm7mlqbzySyT/RJn22PeTqa4zC43zkBdfLBVv1vnz/JpS2FQURBqaSADNwzPWrncwX+8/f3NYs7InKoK6mGE/BsNH069sFGAHLZgjD9eeYxMtWhiaXSoUNwMcZbNDwHhXJBDmDitYUDglP1aiKWnQUT9ZaTI4EQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991763; c=relaxed/simple;
	bh=0/SsFGDU+QhftTZQ4mjCriY+f3qjb4exvmDZuRGv2Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QUc6v4T4Epqklvbrt1B0LWc6KgDLtRCNKv09dGuKL6dwWGkgB8Cdi4bHXKMbKXklda20V7DjAc9UqyAtUoGbzg9mzN+yM1VGBmcha0vYaw0QdLXgpbOvVIPNW5ROSP1uJTXgs9UHuBTxv+7aHnmRvNpl5CJVBSGQFklZqp+XLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Csj5v03e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237iUFM025431;
	Mon, 3 Mar 2025 08:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QMrqIuM9ega6SwNKQRGpCl1xtpCY+5cNBKvReHZk/5w=; b=Csj5v03eQIkH+1s4
	Nq/6XrvhjtQB8iXVDtDRj0URI+RWnJTu/cnJ1g3aShHt4d06DvP9OrygntM6yWDN
	jywrOjXWAuUaenTlffkADaLniIpp6PgScwnnWndLF4tIU9G2Bar7sb80uJ98hHEw
	OLxz9gqNaGTMou7oPigbWOwyyd+h+n6xUWtG6OaXL85qkiPYDQ30ZUgPe/Ku76n9
	iTTDdzbqTIxBQ7AJYVGUL4OaDokB131Y3l6yLxagYvEIQd7JbiKZCrU64sP3ERhp
	M9h9xyfHchlWDBp7LRIw9Y8u0IuhtUXJbnVJaBLqBMptJtaD6zhTm+vd2VcZLi5T
	fLVpqQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4558a609ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:49:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5238nGeS012085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 08:49:16 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 00:49:14 -0800
Message-ID: <e0c7082f-194c-4969-833d-b297a22eccf2@quicinc.com>
Date: Mon, 3 Mar 2025 14:19:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] wifi: cfg80211: add flag to indicate driver
 supports ML station statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
 <20250213171632.1646538-9-quic_sarishar@quicinc.com>
 <a43e6d8c29765d063e05d5c31bd0ee305a9d2a45.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <a43e6d8c29765d063e05d5c31bd0ee305a9d2a45.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iVoc5tMVEsfLlWE4T3AsGSeIZrFCDdFb
X-Proofpoint-ORIG-GUID: iVoc5tMVEsfLlWE4T3AsGSeIZrFCDdFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030067

On 2/28/2025 6:54 PM, Johannes Berg wrote:
> 
>> +++ b/include/net/cfg80211.h
>> @@ -2158,6 +2158,9 @@ struct link_station_info {
>>    * @local_pm: local mesh STA power save mode
>>    * @peer_pm: peer mesh STA power save mode
>>    * @nonpeer_pm: non-peer mesh STA power save mode
>> + * @is_per_link_stats_support: 0- for non-ML STA and for ML STA,if driver
>> + *	offload link decisions and do not provide per-link statistics.
>> + *	1- if driver provides per-link statistics.
> 
> Seems like that should be false/true since it's bool, but I also don't
> really see why you need to list the values at all.

I intended for true-1, false-0, will add actual true/false as it's 
misleading.

> 
> Or even need this extra value at all since you have
> WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS?? And perhaps that should
> rather be an nl80211 flag so userspace knows what to expect? Not sure it
> would care though.

Yes, Flag directly can be used everywhere but at some use case we are 
not having wiphy structure, there either we have to pass an extra 
argument, or need to fetch back wiphy structure and check.
So instead, added a boolean in sinfo structure.

For eg: in cfg80211_sinfo_release_content() only sinfo is passed, so 
instead of passing an additional argument everywhere, added a flag in 
sinfo itself.

> 
>> +++ b/net/mac80211/sta_info.c
> 
> Don't mix that in where not needed for API changes.

Sure, will split this patch.

> 
> johannes


