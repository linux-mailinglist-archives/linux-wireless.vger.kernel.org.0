Return-Path: <linux-wireless+bounces-23214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E83FABEFC1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC0F17CDE6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5B524166D;
	Wed, 21 May 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FZlG1GSo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1067523FC6B
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819728; cv=none; b=IA7XiPfuKi5y39dENSdbCaeKy1mAH61YiSlGkIo3o/JReAigUxXJzHn2Vj9uESsbruDY95hirOOPQH9fKBlUwQO06Nrz6W514OEVoCV3JPstZgpnnSUVCNYwuZ2C9FmWxm+Ujhoa0fr2Rwe1rYXcVsnLRQzBNsZTTgCtB64dkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819728; c=relaxed/simple;
	bh=aMFZu8bc2cDPinbSLSYMyV+T8OKjGvdSlwVu2EZJLh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NB37XGUgi6dlvUk9dTJUcjtKXhgbpaTydSoZbujzERCAGp2C98sakkXwpdRcXreGlVPrM/OVB5WRP/uHQJWOhxLdMxmIZOGOSBQSr9BGsH1eRofAGzYSKg71CF0V09MLoblW/o/WsrQC56rjKTZqdPp6015CVxABi7KQuve/9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FZlG1GSo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L54qvX003320;
	Wed, 21 May 2025 09:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YTySPMIAA4tpvu4IjkcaNpy/KRq8epJX+9UhuJqd59Y=; b=FZlG1GSoBI6K5Vm7
	XPDGFpjipx3MclI9S+6yqed49mvuiOYCTWAUq7Xlh2vMBsSfOQRHRSCaLVPK+/DI
	jjG7M1n1fZJBpFax0qXrmaKFlFzjbdIoGy9gBCAZcrdODHrM6ABITn8quvFN0v2q
	/oSflD/j3YVFyFn+6Hpi7tOzC7a+/0yFdvHjKEwvnD0aVhvAgQdGckf14FYYvpe7
	XJ14FdLzsHMsY6mfJGhMW7HByCsSU+Ej2B12qcAlnXbTlXeRH4wXe6ijRv3Lf0RM
	CM90QEwNuUliPPP5sZgLio/4NIGg3TMp3YLOBn10d2b2I7xQqBci/LncrtCyDqKN
	RaiaTg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c20vk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:28:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54L9SeaV008987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:28:40 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 02:28:39 -0700
Message-ID: <5ea169b9-8f63-46b7-8f48-40d8caf97ac4@quicinc.com>
Date: Wed, 21 May 2025 14:58:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold on
 per-radio basis
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
 <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
 <6ae5c6bd10fd7eade50bba846a701ba5846bf811.camel@sipsolutions.net>
 <6c4fd852-c70a-4d7e-ac34-3a7f375b98ab@quicinc.com>
 <78e46648e8bbaec139df2a3d11a2408fe5973afb.camel@sipsolutions.net>
 <694e3a16-c2d9-41b1-8f6f-033c6b1ef0f3@quicinc.com>
 <157dd058a06a2f111c52459610b0de7057a5d557.camel@sipsolutions.net>
 <c2c54fbf-c9d5-4a4c-982c-dfcd5b6d9624@quicinc.com>
 <4c9a74c436bd14b49fc9a15e7f9c68cb446baa84.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <4c9a74c436bd14b49fc9a15e7f9c68cb446baa84.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MyBTYWx0ZWRfXxGjz3l/3xU/N
 lHbECurLegFlKOJtTaSOSXYz7ECeZyv6ZoHA+xf2qXrOi3sAEz6P6Nr67ySRKYULrgrlZRzhSN1
 LPRZHpo1PS9n2HmhifpdLnNsvg/enH0PkXDZOoRqsucFcmvLLjpJfHFFG1GXx9VOKHHOadSpaZo
 d+mw8Vqyddz7WtiOT6FDfgHgMmWEz1R8mMeS7fUz7DZLKj46xjxjQw6YMeD+Dio5bx437C2/nrC
 Q3sHBg7wdvGnwryTFMHZv4lUI6Az+hmYOQfuF/O2vYMlV/KR6N9KyLAopd62RlQ6rsQEchY12JW
 DWmMOvv57YTrGPqsDNkzVMuKwmaPppMZP9uJjN0SkRTrU9Ufc1ufJxfPk1cSjFJ1i9jFQ6MC+XJ
 tQaZDwsrnJzBVCsKebOzjrya59bxHqGmY3ABiKJRUAqQVt9AILGZ9/6YeaQ1PGpij7TRET6U
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682d9ccb cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=9vh4OKAwXhW-q596_iAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6a-5g3RDJCuxXPhi-b-YX78pcTQ9WvKY
X-Proofpoint-GUID: 6a-5g3RDJCuxXPhi-b-YX78pcTQ9WvKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=751 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210093



On 5/21/2025 2:56 PM, Johannes Berg wrote:
> On Wed, 2025-05-21 at 14:55 +0530, Roopni Devanathan wrote:
>>
>> I think so, too. As mentioned already, I can change the datatype of radio_id to
>> int, retain the NL80211_WIPHY_RADIO_ID_INVALID value at -1. This would mean that
>> passing default value to individual drivers will set RTS threshold to all the radios
>> in a wiphy, or it will be the case of single wiphy architecture.
>>
>> I hope this change will be sound and standing?
> 
> Right, that sounds good. Except it still shouldn't be
> NL80211_WIPHY_RADIO_ID_INVALID since negative values are not part of the
> nl80211 API :)
> 
So, why not, we give a value of 255 to NL80211_WIPHY_RADIO_ID_DEFAULT? Then, we can
retain u8 datatype of radio_id.

> johannes

