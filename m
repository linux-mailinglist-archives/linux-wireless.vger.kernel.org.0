Return-Path: <linux-wireless+bounces-2813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F5F84266D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B5E1C2618D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0852C6773D;
	Tue, 30 Jan 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P/MlIzHV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF56D1B3
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622568; cv=none; b=RotAcGnz0IDKWzK2mhWbgwVz3yErX+P5GdzvLzI2IO47+83YMIsaXfVjca7RIELkZIHAhqNtT+P/XC4VuU7ScM3UR17PWOygaZusOOFwYMEp0pD2fT1Xwscfpb3sdAFAfFWOMw3vnY2AGITT96P1CzhJufARuIFXkuuCI1yZ7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622568; c=relaxed/simple;
	bh=860nobGDweSu8T5DZjNtQ7GXPgRFpSCuJKoI87zpmMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tAsCD9neX9CvrMOnx6Op3fr5bPOmwVFqiDO0RUq7OnmY1YZtnOhfn6u73t0iWZnJoJvpZv8CZSgPgodwzk/5fJkJ3XO8GuL66nfV6HTCw2GJaZ1KkvJrXN2gdRji6WW/Nyns1eBPci8ZszV71CsppLL4cJt+i1ZMZcWtkyIcfVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P/MlIzHV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UDAYCf004247;
	Tue, 30 Jan 2024 13:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DEcHJ3X7ysFGHGu/hkKpAuq/CPD2AF2z/YvqSGfGpSE=; b=P/
	MlIzHVTG+9oVuEJfyS7Z4rttzo6OAmxZS/EhSaen/XWaul3Gwx+7mr6LGT6ie/8Z
	OBO5rZwzbOZgTFw4IVZwGaw780DziognAyJWUt0KAL/v31Lt/nIzdm+s2Ta9sbTG
	AWpLfZsV8X5xWRuYTR/iVAneWwhRUDifpaqVImjXv5PThYkmU2708RNafbTlee6t
	jspCDUnezFfGFzN8VkhY5brZXOLdDusf7yX8PcPWba0dtQF1gfWI21ouUr0IUWH2
	FLmbLievmb6PCHe+od1zSTqRK9ZEgeCw6uCF46mAz/u4o2LpmL6bedDwer9pJjRk
	enV1dD3W00+K+gOIw0aQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxr2v19du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 13:49:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UDnMrP015592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 13:49:22 GMT
Received: from [10.216.2.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 05:49:21 -0800
Message-ID: <d04c6d82-b667-451d-a52f-ccf715a13d32@quicinc.com>
Date: Tue, 30 Jan 2024 19:19:17 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: cfg80211: add support for link id attribute in
 NL80211_CMD_DEL_STATION
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
 <20240125125855.827619-2-quic_adisi@quicinc.com>
 <61ad9e10e42c9f114c2a7de534690f8c0133bf58.camel@sipsolutions.net>
 <307eaecc-fd88-4fd8-8857-dd3910257d34@quicinc.com>
 <52287b3162cf6632e7999216cf1ad97b2280b584.camel@sipsolutions.net>
 <a9e53f21-82f8-450e-bb73-84735e919bee@quicinc.com>
 <c67b618f9e40c2629c3eef825788dcf07da76479.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <c67b618f9e40c2629c3eef825788dcf07da76479.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 91dzh134gdjhiRi8efL1De-F2Z6fQGfK
X-Proofpoint-ORIG-GUID: 91dzh134gdjhiRi8efL1De-F2Z6fQGfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=611
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300101

On 1/30/24 17:24, Johannes Berg wrote:
> On Tue, 2024-01-30 at 16:41 +0530, Aditya Kumar Singh wrote:
> 
>> Yeah :). Even I haven't seen kernel not removing the entries while the
>> interface was going down. Was just thinking out loud here. Tbh, even I
>> don't know the exact reason it was written in that way. Was guessing.
> 
> It's probably just old ... :)
> 
>>> Note this raises an interesting point in mac80211, in that there's one
>>> link ('deflink', the link the STA used to assoc) that cannot be removed
>>> from an MLD station even.
>>>
>>
>> Good point :) I did not think about this. Let me think again how to
>> handle this case. Thanks.
> 
> You don't actually have to now though - you're _not_ removing just
> links, you're removing the whole station with all links, as long as it
> has a link with the relevant link ID.
> 

Yeah that is true. Not for this change. But the other one I'm working on 
is the link removal area. So there I need to be care full.


