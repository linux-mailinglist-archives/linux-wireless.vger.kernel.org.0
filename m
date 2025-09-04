Return-Path: <linux-wireless+bounces-27003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F214B438A0
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 12:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F252D162A6C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB161A76BB;
	Thu,  4 Sep 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P7G8r9pF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846022E3E9
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981457; cv=none; b=d9iAMZ+PNiseiBgLay7oDcFViIfUw7huKowlotcLcpqVCUzxAw3T0DhR4StJt4arFvFBST/nnLTeHzTbB7Mz669jaqG6XdsnU7RhULO1xEU1wx3QvP4kUtP5ZltzPfv0Y893j4PbVKoTRvlu/F9oC2jYYAIE/eucB1qrZVR4GjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981457; c=relaxed/simple;
	bh=u+WzvRHx8wYrMhhnqP+v2bfajFxkKTIbpKs+QdcP4Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gDRdHETjn59H3/IDQ5kh48O6TgRNkEa0ItCjVBWAgkJNcLwXUXAgmcddgvsWqmVSvg8dKGnn2B1rKfuvVvmOOLMb1vSsk+p27NRe2/GS3FET/JKN1yBEGiEYE8Qj0wo0Y6YeTFPBiobkezZX/LyGkq1v/mtv2z7ujP63efrd700=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P7G8r9pF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7bO012111;
	Thu, 4 Sep 2025 10:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uiHPjJUBmUu3NouL+v0ViHJ3nqdo23fLDgBTDDBOhOk=; b=P7G8r9pFyZtwebYB
	LHZBpvnEXBTLzwZE/ooM8hA2eJDX+N9Xjd+7o42+ARxCZqWqrHo/avQ8q4dxZWRd
	/reZpR3uVMzK+/78ZXpj3Oa+31AZiBnNLEXMVjpDsHIX/DxpKcMWsyqqNCRPjS5C
	x9R56yyd+nGe2Ayn/qlvsd7ooc2DuTRx1DHx9oUyYSNT7PxUV7bNyjWr7quHWNAp
	yx8BTI54S9qN2AqngzmKyQCvu08i9G8ZkYqBHpUNEviU6IfVbp60Cpxqf5kF3lyP
	CBbWFGKFfN4wb8ktcAO0HCJF8G6EV1wmXkywV5Dyx9y+lPPhkuAqrqf0Z6wKwG4g
	V4P3ww==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj3nuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 10:24:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 584AOA2o022496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Sep 2025 10:24:10 GMT
Received: from [10.50.62.147] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 4 Sep
 2025 03:24:08 -0700
Message-ID: <f1bb82aa-539a-4a91-8786-d6926ae404d4@quicinc.com>
Date: Thu, 4 Sep 2025 15:54:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: fix reporting of all valid
 links in sta_set_sinfo()
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250822053229.519836-1-quic_sarishar@quicinc.com>
 <b8eb835bb73e348c331e008408159a8026d28870.camel@sipsolutions.net>
 <c3312127-0b87-4825-bf73-05351f8eb55e@oss.qualcomm.com>
 <6644d4195e003b5d4c7c1cfaf61c55c7e3d3c942.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <6644d4195e003b5d4c7c1cfaf61c55c7e3d3c942.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX1ZRHWBIpfn8G
 EyPDjypF+pnd7QyRXqdKtE07RDkSklOP/7aKyvO4UI7ZyyaWUigrrqx4DVzykPER6NSRKOyEjkf
 +hk22b8XUFRwNBVUcxmhf+S9FfF01GNpBgUwnTbBtn74/OehlnTPt33oW+7VSN14km3kXNC5iYE
 OtCBcRnVfYpH+5K1Z3xpz2C9ezNBudQRjI8xLb0Ncki2/RLXQ86Uno2RaEzauJPXqk0s5evDXBT
 J5OYJJ+aoSuMxYvmY5FJ6F+xlckAKDKGeTmRLwoXTiDnYm9Blyi4LIAHEXyTNODHW9ZwGRhND+a
 4mqi1Ii0wcdxQi9+l1GKXLCTPpE/yD1Hka44v71dE9U6FadNB44+CV71V2vlBcSA45QanvF7DXp
 l9Dls/jp
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b968ca cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=SkCZGkUBNUiyBjf3SQ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XZqfnwgN2xCvbCjMwVSRbA64V-L4pJsl
X-Proofpoint-ORIG-GUID: XZqfnwgN2xCvbCjMwVSRbA64V-L4pJsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/3/2025 8:27 PM, Johannes Berg wrote:
> On Wed, 2025-09-03 at 07:22 -0700, Jeff Johnson wrote:
>> On 9/3/2025 1:01 AM, Johannes Berg wrote:
>>> On Fri, 2025-08-22 at 11:02 +0530, Sarika Sharma wrote:
>>>> Currently, sta_set_sinfo() fails to populate link-level station info
>>>> when sinfo->valid_links is initially 0 and sta->sta.valid_links has
>>>> bits set for links other than link 0. This typically occurs when
>>>> association happens on a non-zero link or link 0 deleted dynamically.
>>>> In such cases, the for_each_valid_link(sinfo, link_id) loop only
>>>> executes for link 0 and terminates early, since sinfo->valid_links
>>>> remains 0. As a result, only MLD-level information is reported to
>>>> userspace.
>>>>
>>>> Hence to fix, initialize sinfo->valid_links with sta->sta.valid_links
>>>> before entering the loop to ensure loop executes for each valid link.
>>>> During iteration, mask out invalid links from sinfo->valid_links if
>>>> any of sta->link[link_id], sdata->link[link_id], or sinfo->links[link_id]
>>>> are not present, to report only valid link information.
>>>>
>>>> Fixes: 505991fba9ec ("wifi: mac80211: extend support to fill link level sinfo structure")
>>>
>>> With a Fixes: tag for a commit in 6.17-rc, why should this not also go
>>> to wireless for 6.17?
>>
>> Concur this should go through wireless instead of wireless-next. That was a
>> miss on my part during internal review.
> 
> Sounds good. Hopefully I'll remember when I apply patches after wireless
> gets pulled, maybe resend if you want to make sure :)

Sure, let me resend for wireless.

> 
> johannes


