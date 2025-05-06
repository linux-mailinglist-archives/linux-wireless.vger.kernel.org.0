Return-Path: <linux-wireless+bounces-22651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91582AAB9E8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 09:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3D14657AE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FA528DF35;
	Tue,  6 May 2025 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aXlRXfo5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9942C0873
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746503543; cv=none; b=uiJD7PvlDvyE3tvRc7/hNr8B8jkV9V1SWi+ojRMx9KG/zvro3tBSLVljRY+HyE8gDJH4NRMstdQxRILd46Iqb2EU0qjsT9yBuR/CEgk7acypaPqe7P1wcgyoqF/w1UsJ9TeOBGcUaA0B+FS5PeRPMrO/ZHIi8CjV3pPdMhTbzHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746503543; c=relaxed/simple;
	bh=nfG9vmwHPr/jeLnYHHrVVHxTx/FPKnHTFTGNJsOxhHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FBVCtkmWu0syxauUiMIj/ZrCvUfFR6H1ByFLW+k/rcbPkKc7VKw87dOWNE4XcXAZ03GudAwgE0bLUCqoXZh3tR6hK3KLfeSZR0f9mwSAQT43agNvas45KYuK4j6dT0H7GlvG+TT5j5GbsCb4n2y7Uxwe3L6CycohL9Qeb2q2e90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aXlRXfo5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545M3kSH026989;
	Tue, 6 May 2025 03:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KqljhjdOnDoKKCcCgJP7ffgrtZoJ3f8812dirBUJvPc=; b=aXlRXfo59SGHSpXg
	uTXsdjBOLmvXoo+r4I/V01NHTow55WQpUbgWG6pWxf8mGsWsQGNWp2Uk/TcV8UHi
	qGDxWiVlOP3k5HwyfZPx3WGo9xk26VtdLJaZ6KKLl4FyFFMgoghwhbXL01eUPyK7
	iGVBVT89gHGf4+/9GrECAlc7P4HtC5p3Gx38Gv12OedbZdEiE/kVVp4FqdhLT+pQ
	8itFNW8AHg1j/Ie0fwJ7oVEf9mKj9t5XwWE9XTPDnLuO/YriYX5NFsJbxSefq6p/
	A64Sbxn/2l9MfpFN12WSscNBWFWmS84Bd0HreFdKG/DwYOLyJFUS7M31lRE8Cc2T
	FuU1Tw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5sv0s4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 03:52:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5463qGcq024798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 03:52:16 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 May 2025
 20:52:15 -0700
Message-ID: <cc89028a-c785-4f83-9c17-8c98b087748c@quicinc.com>
Date: Tue, 6 May 2025 09:22:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-5-quic_sarishar@quicinc.com>
 <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PnRNydxPu78I5OD6VoN1D8FjRLkJJ-LZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDAzMyBTYWx0ZWRfXw6i6kpau207n
 HAzlh3KneinkpflAxheWAZxhAsziW+JZD/2xD6uq453ufIj66Fw4r3g8CjQYe33nszl9IbPjdhj
 0h4OTx5QABMeMvmTU/UrSKYQ2qdvJQ5zRpaWUZo4jUDInU/QQCSO7th9WMqQQ+zeimrzU1XV5MF
 CFwHlct3kJl21SPV7cr6OM+evyxf8etTK9tScVMJZFtfJ/J43GkusvN84MbgzgOPCl9xyFclVSw
 9hlPZmdQJ2qb2MNsqyikQ4xCillJ/zKX7TTPPEocqtizc6NKQ3vHjccA6cyFOpJWYl2zdjWWV86
 vqws8SIvZNr+X3FPTo2ojGLv3lDYaJnynuYocAZD2Vkz5RTr1vH+7Bn0s42KsFTTTXnDDOxB2eR
 L9+FeI+sDZYP6eyga44hJ3TZyTUpMOsLv45ttY0cjPZoUcE+L9a0Sz0PyM2b1IgWSKze0RjC
X-Authority-Analysis: v=2.4 cv=cOXgskeN c=1 sm=1 tr=0 ts=68198771 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=P5okVFmjc5It1HWUgqEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PnRNydxPu78I5OD6VoN1D8FjRLkJJ-LZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_02,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060033

On 4/23/2025 10:22 PM, Johannes Berg wrote:
> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>> Current implementation of NL80211_GET_STATION does not work for
>> multi-link operation(MLO) since in case of MLO only deflink (or one
>> of the links) is considered and not all links.
>>
>> Therefore to support for MLO, start reorganizing sinfo structure
>> related data elements and add link_sinfo structure for link-level
>> statistics and keep station related data at sinfo structure.
>> Currently, changes are done at the deflink(or one of the links) level.
>> Actual link-level changes will be added in subsequent changes.
>>
>> Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
>> structure. But to add support for station statistics at link level,
>> change the ops to .link_sta_statistics() to fill link_sinfo structure.
>>
>> Additionally, move connected_time before assoc_at in station_info
>> structure to get minimal holes.
>> pahole summary before this change:
>>   - size: 232, cachelines: 4, members: 23
>>   - sum members: 223, holes: 3, sum holes: 9
>>   - forced alignments: 1
>>   - last cacheline: 40 bytes
>>
>> pahole summary after this change:
>>   - size: 224, cachelines: 4, members: 23
>>   - sum members: 223, holes: 1, sum holes: 1
>>   - forced alignments: 1
>>   - last cacheline: 32 bytes
>>
>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>> ---
>> NOTE:
>>   - Included driver changes for fixing compilation issue.
> 
> Does this really need to do all the changes in mac80211 and the drivers?
> 
> OTOH maybe if not then it would cause much more back and forth?
> 
>> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>> @@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct wiphy *wiphy, struct net_device *dev,
>>   	else if (left < 0)
>>   		return left;
>>   
>> +	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
>> +	if (!sinfo->links[0])
>> +		return -ENOMEM;
>>
> 
> This seems rather error-prone to me.
> 
> We already have sinfo->pertid today, allocated and freed by cfg80211,
> and here you've added something that's allocated by the driver and freed
> by mac80211. That seems odd in comparison?
> 
> I'm not sure what the choices are, but I can't say I like this one ;-)
> Maybe it's still the least bad option.
> 

Will allocate memory during get_station() call only, in
cfg80211 for all possible links(sinfo->links[]).

Going to implement that approach and send V7 for review.


