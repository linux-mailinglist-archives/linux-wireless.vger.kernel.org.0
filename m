Return-Path: <linux-wireless+bounces-23020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E51AB8CBD
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 18:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C440E4C84EA
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E27230D0D;
	Thu, 15 May 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p7xO2Dov"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B8231839
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327470; cv=none; b=XnL3t37ZaVOtWlxK5LWKHl2u0Wm0rVCXJeA6PYeC27XJ6uuBZDqEEe+VGJLV7oYN9veD7fjVj/dcOMWXryuR2St3VxaxQsIVMn9/4/eFMhvo1p1nj0FlmJ+vrzVA47Xh/JNEuknNQg+BbBsXsZG64/QuxvN40X4YckGhmG26be0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327470; c=relaxed/simple;
	bh=L0USba64ivwHKxLddNlw7oPcwWnzTlfwkrIOMhiJAeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E7pjmKYTsDc1L0kTUNrOotr34A4StcA6eHXQVLIdrVmKX7diZgr48pIW9yi6eKvYp4Wkev8ukpJGmjWJ7gXApBPCu2ChCWna+9nrVxpFeonaqPqNd6u6uemyZhs1+F1B1/5G2p4jCyRJoc4oa24sVZoulv41uwlWUWvGa/ItvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p7xO2Dov; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFFkp031488;
	Thu, 15 May 2025 16:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uge/ek2W4FFED5eunShM3VkpajOpwLNW8iIHaG7irwE=; b=p7xO2DovgPvH6qo0
	lLW5DYLnNI8QlekmhVvKSwrk6o4O1MgctvxHvi5SInPPKQykdlUIuaPyKpUAIvq/
	Fi/VT8xDSUclbLi+CW33MFnZ5CKDUy4Sux9Y58qsav5GJhmh/TustWkag72+TcXc
	Wg8GhZokTxV8r9l+sipAtaYyCee6Tg5/tks0zusA3V1OTYewe+2jQ8zuwv7iwv41
	VggWi+A+rckf57Za0ed5v3qOpYsM7E5aNfn9+DuT5Z5b+4sgh46h2APlKy9ZbPXy
	i4gkxOZ66VczT6I3ptsQie3pJN/7+EihWXqeAcTdf3G1NQeJuQWsHaK/ihuqULUx
	shUNzg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr6sd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:44:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FGiNhq020947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 16:44:23 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 09:44:22 -0700
Message-ID: <a8fa827e-a043-451b-a51d-5b841bc71637@quicinc.com>
Date: Thu, 15 May 2025 22:14:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 02/10] wifi: cfg80211: add
 link_station_info structure to support MLO statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-3-quic_sarishar@quicinc.com>
 <d8631594b48d7a60d92e2e07e71d312bc49072a2.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <d8631594b48d7a60d92e2e07e71d312bc49072a2.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HeRgGbiQZEIpI4s7dtfqquoFVni9FKXB
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=682619e8 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=B8Ei7M1d8sA_4JOXtkMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HeRgGbiQZEIpI4s7dtfqquoFVni9FKXB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NiBTYWx0ZWRfX36k1iX06LuQe
 kRqysVcydf1X+B319P9wuM5cGwwZh3fU8+xNvZmW77zkEr9z0bY9F39BojCWctO31cV2p0tX20i
 M9/7lHvNXq3OnXjyV2/3WSiZZgTbGkwvzAn/Y/UVB0hJg8jROIE1W1ThNsKOds3Gu0mDI/ZyT1T
 DPMHNcSGSQ5kSfH2doacce6XcD+oS1HC1nakihT0bGO29C+6GUI3VZh1eyJR2Ap0E67JsqwCgeh
 9zMTP2hKdj5DOS9jR7rnModjBf9b6LsDWAOv9JuHaakqdFDIrRIDRU315C25Q7NTc4GVW1eTFzn
 R1YqX2NcR1z1E+9wO4TM0TC5MOWr2+dXEUN1OeV9d3LJ3a1xIB1XYKU6N+bdG/dpxegUghHuEVZ
 Sw4lVgJQHo0HkzNjekXw2C8vva2EbUtvKcEb0QJHg/DkOYbsd890lZKYuYSa7ckYXof/wcdP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150166

On 5/15/2025 4:56 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>>
>> +/**
>> + * struct link_station_info - link station information
>> + *
>> + * Link station information filled by driver for get_station() and
>> + *	dump_station().
>> + * @link_id: Link ID uniquely identifying the link STA. This is -1 for non-ML
> 
> Oh also, the link_id shouldn't be in here, the documentation is wrong (-
> 1 is never used that way), and it's already indexed by link ID so it's
> just a source of errors to have two values that should be the same...
> 

Sure, was using in previous design to check for deflink, here we can 
directly use from link_sta.
Let me remove it and use existing link_id.

> And yes this implies changes to patch 9, but those are _good_, having
> the link ID implicit in the output structure seems awkward.

Okay, sure.

> 
> johannes


