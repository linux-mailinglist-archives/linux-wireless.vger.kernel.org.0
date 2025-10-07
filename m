Return-Path: <linux-wireless+bounces-27855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F14BC10CF
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 12:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710E13C05B9
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 10:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB63E1FAC4B;
	Tue,  7 Oct 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nlBExech"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8F2877EA
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834300; cv=none; b=TLibgZspzibK2IvSHzJNn8++OSY4aPcZIXtB+Kt9M5oFSJNwUCYT8Hp9FSWVkpX9K0+NMFPVs/5kGvrhLvFojanm69jYNP9BLyOheRVH/IjqPsYSK1U3npbx8JREDE3pKpb2RpDnKPVhp0cxKXpSn4+aTYZ2yUtNQODn0BnVOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834300; c=relaxed/simple;
	bh=2F+hElUvoNUO28aasZ/kgbYMSImtUevHZ463v6IIEpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VOUh6VvE/hDYJlH6wmADNKx98iPU4s1LEHTi64Gs1nWPJSFd5nbQ5a9f237UGRoZ7cqDsvYW3K/5nkEMKLHpgiiXcL1ksslCRRx32CdXESGmcCRdNYh5ml1NjMYunebVkR3UagXlyFJ1PO0usf0WxwrkuP5V+4RBvf3G0LfaZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nlBExech; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59723sGL024045;
	Tue, 7 Oct 2025 10:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FKo4XAQ/YejZpDeOnyRcLxlYrhxvye+avHHVh8CYdEY=; b=nlBExechTz8ctr4m
	grCzJjL4AelsHNjRw/PT01aSqrFRmLxR2POWMo5aSqE70F9QVnhIHEz3CjXS+sA9
	gf2mv3BMu/I/d6ug1Y/vvYAJvd0fX0J5NU7+yTT1dk8PNcxBjNdLaxOLRsHzrCxO
	Z4DngsoSviv4pYvrylQJlYWcyS4Eb8O0y3s/QNuG/VafCc3xoDoxWEy8V2u7k/YB
	YF//ReRySq2z/Gav3tvNuLRHW+gOLETG9f30RrK/HI1GfjgtNcQ3SC6F1AlLsXmr
	XG8CGAtlAXrs1xsMD+vsW4s6qi+DTVKesrEUph7s91BcTBF+ldPyansZuL5kXbEm
	kjn/yg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhps8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 10:51:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 597ApY42005898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Oct 2025 10:51:34 GMT
Received: from [10.79.125.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Tue, 7 Oct
 2025 03:51:32 -0700
Message-ID: <9039c05a-8ba1-4bb4-946c-956583586dba@quicinc.com>
Date: Tue, 7 Oct 2025 16:21:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 1/2] wifi: ath12k: Refactor data path pdev
 struct
Content-Language: en-GB
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250930181848.3386271-1-quic_rdeuri@quicinc.com>
 <20250930181848.3386271-2-quic_rdeuri@quicinc.com>
 <b3c4ab9c-317c-4b68-b00a-d91c1d47b0d6@oss.qualcomm.com>
From: Ripan Deuri <quic_rdeuri@quicinc.com>
In-Reply-To: <b3c4ab9c-317c-4b68-b00a-d91c1d47b0d6@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX2A/doRSsmhPU
 tw49EjYVxU9Bto3V8FVdKUH3RPH1GICnzdgkmM1g27lSnwkUH9yJ2qFP9CXdHT6KRkALrIvLhA4
 gAXs+cdM5CtxcH54o9ZRl5ycRa+dwaoux+MB9YC2yMElFEa/Yvs5/Bi/nG7OYx5t7itfNJxBl27
 nnyMHfMj5UZXi6OaqHSHvcY9SF1/g08d/p3FUKY6S8QL+eCJt8ebudAWs+2JoQ1CCg11LhRGwMP
 10yIn7pcyV3d0l8z9ANpzAuiq8DA9paliHAftdeddLbpJot++KntvxzgvgXnw/dxpgK3EC3xgUo
 v7XjIBaZEDaHrPm7OUa4d/6nxTJtn9GajbHlgour6o8hyQm4HvxpWmw93fjDXJBtr4toj0F7imM
 3QO6h/S5Hg34lwLmzZ87bBxjzaeDRQ==
X-Proofpoint-GUID: e4Q3LDy24F4vxgHP_WZP1va94xXENbHC
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e4f0b6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=5ZzUHON1g4zuXFNfCSEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e4Q3LDy24F4vxgHP_WZP1va94xXENbHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036



On 10/1/2025 10:02 PM, Jeff Johnson wrote:
> On 9/30/2025 11:18 AM, Ripan Deuri wrote:
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
>> index 1bca998117b7..98af9a17dea2 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> ...> +struct ath12k *ath12k_pdev_dp_to_ar(struct ath12k_pdev_dp *dp)
>> +{
>> +	return container_of(dp, struct ath12k, dp);
>> +}
> 
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
>> index 546f73e46c41..084e0a3c1bbb 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp.h
>> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> ...> +struct ath12k *ath12k_pdev_dp_to_ar(struct ath12k_pdev_dp *dp);
> 
> is there a reason this isn't a static inline?
> 
> the implementation is trivial and this seems like an example where inlining
> would always produce a "better" executable.

It’s not static inline right now is to avoid introducing a core.h
dependency in dp.h (and prevent potential circular dependencies between
headers).  Ideally, it can reside in dp_cmn.h, but struct ath12k_pdev_dp
depends on monitor-related structures, which will be refactored in a
later series. That said, it can be made static inline in core.h for now;
I’ll make this change in the next revision.

