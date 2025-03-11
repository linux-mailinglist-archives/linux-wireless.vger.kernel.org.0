Return-Path: <linux-wireless+bounces-20178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D518AA5C93C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 16:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AA81886D20
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E13B25F971;
	Tue, 11 Mar 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R4nsn2wa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6225F986
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708500; cv=none; b=aBNjlAyHNslSo4UpwK0wVILTCaC5kS55BtvfkGRgSUizOZb1kM+j/0I/GOEtKm92agI3mvTfuXAkZP5FfUrhg1dA663OnAdfuCKOyfQVYxLmPN1denbQfwYnilnNh3zOO5CmOwGNsTk/T15wq3sMeCpOYWMGDaE9FhKUTWVFslU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708500; c=relaxed/simple;
	bh=kWCfVHnwN1VnR8ZNUFsAM4MdG822ndE2ICfozs5zXdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZjRk8GjW/KDvTnbam0SBuEKgdUABKWgwIq2nYcs39bsdZW1+kyWfoyXLzWi7NIVe6WmxCzCcFgJAy5CZF8w7gS6fzmC/0nNjE/DnxiC4k3sg3Ze7Tp7tidQ0DpeLpcvKMxabjLQsKD+odgY54XR69Apr/j70ZhqBmecc6hJRQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R4nsn2wa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7oiM6027925;
	Tue, 11 Mar 2025 15:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y2L/cjP+xW3ezqn+dhCx1N3mGJFQq5iYjKgqQzdfP6E=; b=R4nsn2waJJVonBoW
	9zUH/MLuoaqck97WfuyuRlj2qyW2twjzHmh2hRRjjwo3mtrgUaUWJRGBrhn3tYX4
	uIKJMq+Xui6HmRIEoza5AdMlD4cH6uwR9FtWMiSrM6IJTCwnryvZqdRsUhbshCt7
	49USFFOi6ewsXmTfyXGa3u85KudWg7ETsbGTB29b8uIkYCgQ7KnYYqGLnHbd0uuR
	py2pJLHmOsp1TbbIXWqFHZbF1htG/YJnzocWSPz+3CcbZDzqANyy57rm0bGHoiP8
	07WX7CxUm9CyBrDP6g20EFIbv7KlLpOGh8zdbo7CqjsLrgL0MPrWqkYsD2cpx2us
	ZyG/Cw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ah529gqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:54:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52BFsoaG003754
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 15:54:50 GMT
Received: from [10.50.36.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Mar
 2025 08:54:48 -0700
Message-ID: <7938b66f-974e-4ff1-97e1-7904ca802a7d@quicinc.com>
Date: Tue, 11 Mar 2025 21:24:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 3/4] wifi: mac80211: Add helpers to fetch
 EMLSR delay and timeout values
To: Johannes Berg <johannes@sipsolutions.net>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20250306062157.1185769-1-quic_ramess@quicinc.com>
 <20250306062157.1185769-4-quic_ramess@quicinc.com>
 <9a2d609041f3797c48080ca8a2a63b56be94c358.camel@sipsolutions.net>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <9a2d609041f3797c48080ca8a2a63b56be94c358.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XMHZGISvfNBse3i83JXmPlekz8lHZuLZ
X-Proofpoint-ORIG-GUID: XMHZGISvfNBse3i83JXmPlekz8lHZuLZ
X-Authority-Analysis: v=2.4 cv=DfTtqutW c=1 sm=1 tr=0 ts=67d05ccb cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=0xUlOXijzjPc6a2fhUIA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110101



On 3/11/2025 3:16 PM, Johannes Berg wrote:
> On Thu, 2025-03-06 at 11:51 +0530, Rameshkumar Sundaram wrote:
>> Add helpers to get EMLSR transition delay, padding delay and transition
>> timeout values from EML capabilities field of Multi-link Element.
>>
>> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>> ---
>>   include/linux/ieee80211.h | 74 +++++++++++++++++++++++++++++++++++++++
>>
> That's not really mac80211, but not sure what we usually do here.
> 
> johannes
> 

I checked the last change went in ieee80211.h and that had mac80211 so 
thought of putting it, but digging deeper, seems its wifi: ieee80211: 
(https://lore.kernel.org/all/20240318184907.00bb0b20ed60.I8c41dd6fc14c4b187ab901dea15ade73c79fb98c@changeid/)
Thanks for pointing out, will update it in next version.


-- 
Ramesh


