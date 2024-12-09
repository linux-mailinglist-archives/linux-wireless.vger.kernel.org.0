Return-Path: <linux-wireless+bounces-16015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8A9E8AF2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 06:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B29280E67
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD9C15A85E;
	Mon,  9 Dec 2024 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gloKXBXB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954537BB1D;
	Mon,  9 Dec 2024 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733721143; cv=none; b=CgerfCKCKu0r762XFqEhN//wHJ5wndaI09WvAAEfZhqbkL0OZdv7Ygj4ToEODJTJJjK3kasCWGWnocbwpfpb5xgxMa+woMhtzLqzvEoXUquwjnH+waSfLa3/woIiH1+xy/xZ8Pq4G9fNrwsZNRvLqo1N+t6XRfloZdRXFfWy3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733721143; c=relaxed/simple;
	bh=+p1+Lly/BJl98UA+ewGdoNGEBOUllQSEubwfsLcVyfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OcuAwaqdvIEN9Fa9D7rbbaiMcF8YiTeaca6plnYY2AA82edGdFD2vBvkRHIOw5aA7jG4PVqVoeLmaM02sEV3Tom+fVQmorUgMAZbK26aUMZs5yN9G5LmtnK9rDwwebwPRNY2a4n3lfdpfu5GGktK38zk1v5mZFjH0l825T0BnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gloKXBXB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8McVGB026370;
	Mon, 9 Dec 2024 05:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3dODJF6D5lrf04DsAPoK2qZT0I7ShTbOVXYS0+WSISM=; b=gloKXBXBRemO+cIH
	94tSiiy/OoU7Mnmw3Q/s9cgPfWzB5Hr1FJegOM6ma0KcO8XmyDkIJ7U/+9kUz4+V
	iEMnjHCjoczF+KPorP/bxIAUkUR8HRMmZrffVDXeS2gIRDOxF/gAB+4li72NgGqD
	IGXzsmZm9Q7TUuHlOWJgwtzfuu+U9ZPADAQegR1/VFgv2trsTd+IDtjPZLt/AEzL
	iyoM/5+5i8TT/rEz+QtfSOThe1DO+X/gX+tmjQi/VuCsaVwQrhsQsIZQoVe0n4Z4
	CVwp77FFDHqiBkxoLUSnFCjnqlMMjt5VyrvXUeIjI9pw4OfA9tlWVpSFkgiSmYR0
	ELlD2Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdxxbcup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 05:12:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B95CFKZ024058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 05:12:15 GMT
Received: from [10.216.53.59] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 21:12:13 -0800
Message-ID: <8d9fdf00-8c04-430d-b5a5-edcdccbd21e7@quicinc.com>
Date: Mon, 9 Dec 2024 10:42:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mac80211: re-order unassigning channel in
 activate links
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241205-unassign_activate_links-v2-1-ba3f0a2bb4a4@quicinc.com>
 <d0acd2178504d76770e9267ef6e7f5c04b50eab3.camel@sipsolutions.net>
 <d421f8067ea54bcfc38a9b021ebda13515145c45.camel@sipsolutions.net>
 <a60eb1a7-9739-4dbc-a683-417ac6d47adc@quicinc.com>
 <9c497dca795ed9f62f0505daf7f9311a803334c8.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <9c497dca795ed9f62f0505daf7f9311a803334c8.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -UrC0Q3M0YRT1pdPlja0Bev0bzx08MOu
X-Proofpoint-GUID: -UrC0Q3M0YRT1pdPlja0Bev0bzx08MOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090041

On 12/6/24 15:37, Johannes Berg wrote:
> On Thu, 2024-12-05 at 20:43 +0530, Aditya Kumar Singh wrote:
>> On 12/5/24 18:30, Johannes Berg wrote:
>>> On Thu, 2024-12-05 at 12:43 +0100, Johannes Berg wrote:
>>>>>
>>>>> Therefore, re-order the logic so that stations are handled first and then
>>>>> channel is unassigned.
>>>>>
>>>>
>>>> This causes memory leaks in my tests with iwlwifi.
>>>>
>>>
>>> And also firmware crashes because the station is removed while it's
>>> still being used.
>>>
>>
>> So is this exposing some underlying issue with iwlwifi?
> 
> I don't think so?
> 
>> Or this change
>> will break drivers which does not group multiple hardware into single
>> wiphy?
> 
> Not necessarily, but it breaks iwlwifi because of the changed order of
> operations, and what it does with the firmware.
> 
> I think the issue here is that we treat link active == link has channel
> context in iwlwifi, and an active link in client mode requires a station
> in firmware. Otherwise you cannot even deactivate a link, since that
> requires sending an NDP to the AP, but if you don't have the AP STA you
> can't do that ...

Fair enough ...

> 
> I guess the driver could be changed to treat station links as active
> when they have the AP STA entry, but that seems ... difficult and
> strange, it would make it different between AP and client modes?
> 
> Looking at your commit message more, I wonder if it really even makes
> sense to *delete* the link when the channel context is unassigned,
> rather than (similarly to iwlwifi) deactivating it and deleting it later
> when it's actually removed (change_vif_links)? You do know which
> hardware it is/was on, after all. And these two operations can *never*
> be atomic. Removing the STAs first might be something that's appropriate
> for AP mode, but I guess I'm more with iwlwifi here in that it doesn't
> seem quite right for client mode?

I see your point. I need to experiment and see whether this way works or 
not for ath12k. Let me try that out.

> 
>> Also, how about non-ML scenario in iwlwifi? There, first station is
>> removed and then the interface goes down right?
> 
> It's not so much about the interface but the link, it seems.
> 

Sure..


-- 
Aditya

