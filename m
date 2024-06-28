Return-Path: <linux-wireless+bounces-9699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD491C381
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 18:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FC11C23034
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2277F1C8FD4;
	Fri, 28 Jun 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J5zUkhsY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044E158DDC
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591227; cv=none; b=qxaNN51wa69h1HiUup1iAPbJbswJxzwlBG3q/uj+xVQB9jXUjRyVPPRwQ//VhM8PYKAN7bByc3MVupm62fEiScNzDApS12GURUGxmSwnvoKNgZNPiHulQSYq/UbBNLiezWhpug0eALewOgWnL0svCjjw9Lr2xAznuAPasuPogJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591227; c=relaxed/simple;
	bh=/YYNb5zn0ghTMV/nvxfnHiMCUJ9GffxHq4i4qEqD6NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ULoJVR2BqgJY455CKx+mKRyJICRoVX1Q2kHmxfWtGNRX0vqzh9RJbqOn6BqLEStdODFlrpWcpBHwi//1vCWEXp8S4GKbZMTdMf2It3ssf0H8zcXfoG8UXwaBvFEHc+2WnEhQdRx3x5Bbdml5155L4EXFgPi0YhxPsq7kITLjpLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J5zUkhsY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SFCDYX018783;
	Fri, 28 Jun 2024 16:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GDK0APNzMJOM3stE4dmEyVIecpSQDIf+9uW9cjzWdUw=; b=J5zUkhsYwMUIyxLE
	eF5nZCc15H7ShYzcixTiQj738TyRNx0BlrXFNr+6b9gSNkfijeSvSD10fTvLUUnS
	WRFhKN7wOXA0gFoLaogDp9R0uIksi92fdA+uEoo6AiwzCopYoqfeQCJlizhtceeX
	wwnya0e1TXvtJD0nFq5O1ADkL9eMvpU8NrrJvtERyfleBEZOR1XxVNViz69Q8XRB
	ovBGwyHz96Ry6h8Y2NNynsfeI/t4tgn+hNvshorfj501+1MSUFhfkImBsLc8dHxG
	yHIbvHD8pqjG2lUJ2uwy70oBFwp6u1aIAcVgxMmWhXXHRL3093ATesnOIMyKYr5z
	EqXyug==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400f90qp6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 16:13:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SGDeUK020435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 16:13:40 GMT
Received: from [10.216.49.26] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 09:13:39 -0700
Message-ID: <ed6dccf3-2361-481b-8794-0f3805536ed4@quicinc.com>
Date: Fri, 28 Jun 2024 21:43:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] wifi: mac80211: abort active CAC while freeing the
 links during MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
 <20240626045216.3754013-10-quic_adisi@quicinc.com>
 <2670d8e27e9c296e3c0de0572f6387aa9ea3ff93.camel@sipsolutions.net>
 <0fe59d00-e911-4eea-af37-e8cdde116c69@quicinc.com>
 <4719e2dc79a3c423f28664e263e038ee2103bb71.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <4719e2dc79a3c423f28664e263e038ee2103bb71.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2kEbc7fBTYCkR-w9dBgQXzPpxw0oqJPo
X-Proofpoint-GUID: 2kEbc7fBTYCkR-w9dBgQXzPpxw0oqJPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_11,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=924 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280120

On 6/28/24 14:30, Johannes Berg wrote:
> On Thu, 2024-06-27 at 09:47 +0530, Aditya Kumar Singh wrote:
> 
>>> Not sure I buy that argument though, it feels wrong. Clearly you should
>>> be able to stop this from even cfg80211, it tracks whether radar
>>> detection is running, so whenever the link is removed, you can also stop
>>> it there? Doing it on free seems much too late.
>>>
>>
>> Actually if cfg80211_remove_link() is called, then it is aborted during
>> stop_ap handler. So that path is fine only. This was done in situations
>> where properly interface is not brought down or abruptly brought down.
>> For example AP is started and then directly iw wlanX del is issued.
> 
> Still cfg80211 should clean up the link and call stop_ap() etc. If
> that's broken we need to fix it.

Got it.

> 
>> Ideally the normal deinit flow should have taken care but just in case
>> if still somehow by passes it then ultimately while freeing the links it
>> will be aborted. May be should I rephrase the commit message?
> 
> I think we need to fix the cases where it doesn't clean up properly
> instead.
> 

Okay. Let me have a look again properly and comeback.

- Aditya


