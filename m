Return-Path: <linux-wireless+bounces-22731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98CAAF624
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 10:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248F13AEFF7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EA32144BF;
	Thu,  8 May 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ar0k2c1s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A26BFC0
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694645; cv=none; b=u9G8DKp+JD+7949uQmj2Yws9hFcw5OW2CMUmlGQDI68kFgcZN0GpGTpEuG0ioHXO4Wb0ALszo7ZVBDxSIFlDdXEjbA0KVku/FLD/oHfZ3gsPnb9SsLIUi4sqNKkJf/68W+4E/n5wrGW16f0KsmCBiYgTdXqrprKRuZ9jU9PLSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694645; c=relaxed/simple;
	bh=9Ca0KS5ewuxp7V7c9EoE0menWu537F5vHlkYGKrmjd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WFRNQGmfhCfI6hNZmGmaOv9XFeGlleFtUQWWzDGm2iaUZjuTDlLSJ+McAf00Cb7cTk935x/UiXey+mvjTTwXw/l1k4zm10jBJ1SR6iJApiUaej/yz+PR4JvKzn2XvsrthpUc/BScJu2mSigEJpHikpLCZVsSyrjczf7Y6LQ0D8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ar0k2c1s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484XwZQ031542;
	Thu, 8 May 2025 08:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7h5JwkDUramCOmxdBnLWHBi3rTcTcerEAw7A+yy5974=; b=ar0k2c1sRdFMXcCr
	X+rq2mXer1ufMng1lOc2Fz80V/XdsyevNpX+X/ddEMkNqtQeZXeJdrw1vaJVLHyS
	XgwctpyXIRGiRS/7mkyRxTEfs0mat9L9xEYG+clKUbameLE3hFVWMQJMwSfJfbur
	XWXoGUFfiVPjPe4zdLyzhAbZ++osbhQz2ArbuHgy28y6V7kzYzYyYJuOTL9VhBdf
	ZIFS6alX9H6HwPtppABMZSLVZqHStbIBVu5LPze48+WD9Z7GWWf6ISfqjR3haHGc
	tCtL6iwTVHdBwUDNVgxj2NB0LDx/bfVaILd/5WPD1nmhw5VH9v0Lhae/yiIrssaK
	XmtSBQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnpggnrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 08:57:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5488vJVV022837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 May 2025 08:57:19 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 May 2025
 01:57:18 -0700
Message-ID: <6a9b8f49-3a0d-49d9-82cd-d48b0c0930b8@quicinc.com>
Date: Thu, 8 May 2025 14:27:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 06/11] wifi: cfg80211: add flag to
 indicate driver supports ML station statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-7-quic_sarishar@quicinc.com>
 <3311a7a3afac8c9b5f5e5df16dec23c33df90af4.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <3311a7a3afac8c9b5f5e5df16dec23c33df90af4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=681c71f0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=KUbI630WRPLX7WkGJ_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA4MCBTYWx0ZWRfX41yYfiS4aD37
 z4GTEjMD5uzNxPZJGuEjTAOWT3sot+Zifem2btDifHcoHQo4FtXNZd9HVrdyXhUT8ZBNuY/Yxj8
 VTmPZxhuYCR7L/diVPBRHCFmgONLQtF4EqqQqzcjhL33oijB2kgCawP8NeyqSyv+y5qElxMBX8k
 J+qgXO52HG+oivFcit9AoCbq5p+Vc1ypfHJ/edqvaA6YBNz7N8WoauXyJaKPeu6yAcpTVkPeTZ5
 mwKiZfHb/vCvff5MJrcTeAC1eL1AWciU5Hlz1FqNcrwnjookngfgDSLh46k48u/h4M10X6vu5AM
 ltQWP7l9VzOGYm0+FZoCQGzweu6jjDEJHFYDXLOB3NJUD5nvQZY9dy8yHFTDiTAKQjnmY0VPE3u
 /J+u6DWdoFhIfNpcedtY9K6KwOWUWTXC/czQ0k2dntY7FHahEQizjZzKgYy4C7JW16pNEMiG
X-Proofpoint-GUID: AZjTkHZv_wNYIKvWjAUonEIh9WQ0Exlj
X-Proofpoint-ORIG-GUID: AZjTkHZv_wNYIKvWjAUonEIh9WQ0Exlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 mlxlogscore=791 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=1 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080080

On 5/7/2025 6:24 PM, Johannes Berg wrote:
> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>> Currently, while filling NL attributes for the link level station
>> statistics, valid_links is checked. There might be the case when
>> driver offload link station statistics and does not provide per-link
>> statistics.
>>
>> Hence, add flag WIPHY_FLAG_SUPPORTS_MLO_STA_PER_LINK_STATS in wiphy
>> structure to indicate that driver supports per link station statistics.
>> Set this flag if driver supports per-link station statistics and
>> check this flag while filling the station_info structure
>> for MLO and while embedding the info into NL message.
>>
> 
> I don't really see a need for this flag?

This is added, to indicate driver supports link level stats.

With upcoming changes, I believe for allocating memory for links[15] in 
cfg80211, can use this flag?

> 
> johannes


