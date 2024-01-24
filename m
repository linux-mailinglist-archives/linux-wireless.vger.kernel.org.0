Return-Path: <linux-wireless+bounces-2457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5B483B5A7
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 00:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E405B228C9
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3F12C532;
	Wed, 24 Jan 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HTUeA/U0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408691350E0
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139617; cv=none; b=uc/gOwyWABbQn38a6KSTOQpiFPTKuXhItQxSVs+Ta5bPm2I38jGWKVjOTtJGCrgL8Ly7c4DK4NNH2SfOfe/ZzTG2T+4xZRJAAbSWVxa2BI2VJmT38aN7uqsFPIYav4kQ4F3DjgoA1MAeUsCBb8zMqoiD6LpU4z7/dukhWvU0Huo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139617; c=relaxed/simple;
	bh=72Hpcig7gYEoODvx2hEpvgOAptqEz7vEa7fuMCEwiUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yi2YxdlWN3o+ljCne5XFSOetapyYaYiDTVc4BRvIr917aGhimXeGkBugCDraw/x13rkzp3294A1F9kNfncn8fiPYFppiL3zGR8BTqRyl3k6d0ZKZaw65Xa0ZzOBaIFqaRAWYyV1O5LN6ZzqKq9rKNah2qQzjtOc6AzaYjD2r6/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HTUeA/U0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40ONZL0B009835;
	Wed, 24 Jan 2024 23:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sHxGkSarEJ6IlmdXksur6Pv2HYrbvaLZkrq/Qy3deMg=; b=HT
	UeA/U0qOZ3AgQ4AX4GWHKKsaJdBOLrj9qiN2Ih/br1rrC3NGULLfGja3L00xoZjP
	1OOJGWbNwrg6uTfbvr4mi8NuYV9I3bRw1BJEqZKsSzkvR67KQvy9MUn+dpJ1Tzi+
	eKWE4kF4tGVj7oR7EF3k4PryoXn9Wb4MJnotfssJZ6XMiLVAtxg/bUaNu0mDkd3e
	g5wRtSMLIvcp2VL8YxiNrgg4eX996vgNwenUckovld8LiyTU7GFkGW4rF4gKXzNl
	kVmV4dbqwvMZTPi4pKYXV9zwn9dcr6DXXa6lEjXXir59jFSegyHyBqYf9XoqjeTV
	Okmwt8iFcVii9ok1hWVA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu19ghmpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 23:40:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ONeAl5005909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 23:40:10 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:40:09 -0800
Message-ID: <a12579b4-7596-4b1d-aa3c-133e635b7ec9@quicinc.com>
Date: Wed, 24 Jan 2024 15:40:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: cfg80211: add support for link id attribute in
 NL80211_CMD_DEL_STATION
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240124132814.802018-1-quic_adisi@quicinc.com>
 <20240124132814.802018-2-quic_adisi@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240124132814.802018-2-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: e1W61tDO03OLZUItZkypAXcqoZjAhbIH
X-Proofpoint-ORIG-GUID: e1W61tDO03OLZUItZkypAXcqoZjAhbIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=677 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401240171

On 1/24/2024 5:28 AM, Aditya Kumar Singh wrote:
> Currently whenever NL80211_CMD_DEL_STATION command is called without any
> MAC address, all stations present on that interface are flushed.
> However with MLO there is a need to flush the stations from a particular
> link in the interface, and not from all the links associated with the MLD
> interface.
> 
> For example - 2 GHz and 5 GHz are part of an AP MLD. When 2 GHz BSS is
> brought up, it sends flush command on the interface (MLD). Then eventually

"it sends": can you please clarify what "it" is

> 5 GHZ links comes up and that also sends the command on the same interface.

"that also sends": likewise what is "that"

> Now by the time 5 GHz link comes up, if any station gets connected to 2 GHz
> link, it would be flushed while 5 GHz link is started which is wrong.
> 
> Hence, add an option to pass link ID as well in the command so that if link
> ID is passed, station using that passed link ID alone would be deleted
> and others will not be removed.
> 
> A subsequent patch would add logic to delete only the station using the
> passed link ID.
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Actual code change LGTM

