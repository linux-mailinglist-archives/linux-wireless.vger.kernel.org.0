Return-Path: <linux-wireless+bounces-2806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0638D8421FE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395341C24083
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA5664D3;
	Tue, 30 Jan 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SvX+qaWu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB01664A6
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612009; cv=none; b=qPezh0v6Vk3sp/5ls+A/17J+Oj1Wy37LkdXd3ckgFuMynpRPZmKWdMeis3aS4DCQbk1mRZ6dkBxP8LwJ/LmoOc2gd6oFtXTA23+DiPHhSPoHJs/AklyW9UERj/DzqVeOBAyjPBWllLkkgr5/97iBD+bJbNMZ8Hxcskf3syNnE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612009; c=relaxed/simple;
	bh=d0cjwGW51U7PFcAsBfDKb9L+d/WrVDkixAVsJGhHPvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SISPMVNhU6uewP8G+E4TO6FfCHz+HQ0ceZx0fGKHphGGr+BAhijiQ8OPdtEq33ZrbA57iNRD0bOeR8HDmtoUUa6mSGxHUBFhGGsLD9X+ywruq4d4+4Sr56WMeExOZhadkicMfGlFKTGw120DByZtzehDtgZoZKIfnPf723jiHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SvX+qaWu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9S9Ya013248;
	Tue, 30 Jan 2024 10:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RFy1ssQwISR0T5HUlF1R2LnWwOqq+i12xa0ONfkHQTc=; b=Sv
	X+qaWuLe1v+0PDSjoRSbFEqeSvaUBHXfRwdrwBTSVn3W+QWZIbDZfXdFSJg9CvsW
	j9SnXdvUGzwnUJMJdP58ius0iCMro3bZsdml5OHIVFTkgoLoG7fF6b/iK/uKkWTo
	+4vcG7XNXyLBwMQ6D8vPFv/sU2asTzwDg9w66R0AvJJBNQUGVX1xYrZdtcxMScx0
	s4oGM6sxfMD8UdChr9ItYDq66W/lrFiUD2dL6YAR4YOXlmMbchrQ6qOIsLo+pBm5
	TZBBmVMmmoxH7gVjIk852tu81Le/HzONblAw/8EQrYSvrTdWEdHptw7HBMLWr0V8
	0bY74odX3vajpdv+GQiQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvve0cg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:53:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UArMPx025947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 10:53:22 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 02:53:21 -0800
Message-ID: <a04f47b4-b3fb-4cff-b9de-b7af89f1ff98@quicinc.com>
Date: Tue, 30 Jan 2024 16:23:17 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] wifi: mac80211: add support to call csa_finish on
 a link
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
 <20240130043225.942202-6-quic_adisi@quicinc.com>
 <e19c796c9ffe3170e34543c95c6d74ced5b1429f.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <e19c796c9ffe3170e34543c95c6d74ced5b1429f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KrKIFEAxEvPs-yTYzRKNgETQ87TIGW73
X-Proofpoint-ORIG-GUID: KrKIFEAxEvPs-yTYzRKNgETQ87TIGW73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300079

On 1/30/24 15:51, Johannes Berg wrote:
> On Tue, 2024-01-30 at 10:02 +0530, Aditya Kumar Singh wrote:
>> Currently ieee80211_csa_finish() function finalizes CSA by scheduling a
>> finalizing worker using the deflink. With MLO, there is a need to do it
>> on a given link basis.
>>
>> Add changes to pass link ID of the link on which CSA needs to be finalized.
> 
> Why not just directly say
> 
> "Pass the link ID of ..."
> 
> To me at least it seems obvious that a commit makes changes :)
> 
> Anyway .. I'll stop nit-picking too much about your commit messages I
> guess, and worst case just rephrase them later.
> 
> (I'm kind of working on this area of CSA too right now, though with a
> focus on client.)
> 
>> +	/* TODO: MBSSID with MLO changes */
>>   	if (vif->mbssid_tx_vif == vif) {
> 
> Could you say (even here) more precisely what'd be needed?
> 

We are checking right now "vif->mbssid_tx_vif == vif" for mbssid check. 
However, with MLO, one single vif can have multiple links and among 
those 1 or more could be mbssid enabled. Hence, changes are needed to 
store this mbssid related info on link basis instead of vif directly.

>>   		/* Trigger ieee80211_csa_finish() on the non-transmitting
>>   		 * interfaces when channel switch is received on

Then later where we are iterating over all interfaces, there also we 
need to handle it on link basis. Including all these would make this 
patch a lot bigger. Hence planned to address the whole MBSSID+MLO 
changes in a separate series overall.


>> @@ -3568,7 +3579,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif)
>>   					 &iter->deflink.csa_finalize_work);
> 
> that still seems to use deflink there, for sure.
> 

Yeah since MBSSID currently would work without MLO, it is safe to use 
deflink of the non tx vaps while we are iterating.


