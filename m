Return-Path: <linux-wireless+bounces-23024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E926AB8DE0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5DF17C8B8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D032571B4;
	Thu, 15 May 2025 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="azI9fVBx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C7207DE2
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330530; cv=none; b=mOYpZWdn3+wCr6MQSwUt9phb+P45Uu6uqn/aeVcsDYxa7QYdiYC+Yzp+TyddkMYnaFP3ZMzdJg4RBYqr+edBLkoaydDhWrXlb0XLBrkfsMgtwuzWcNUgp0k7oW62hgg4yw/lzQkVW/ZjD1hRIfPEaUghIjWEj7/4Ll7a/Qr8FgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330530; c=relaxed/simple;
	bh=sF0Tv4h9rRpuFIKwvlxGyGcLkGkdqHh9q7Jazwngt2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZE7YT+ASHkHFrYsG8V24ZxBGkYdRsfkCpQ3zcM4rzLSjHp20bIua4fH0ywiQwsvR8wdWjGwKXnfcLwr7XuDMH7cmkDXZ3XrDoxam2FdSxG9D2EJ4+sGWB+cA+UI6mOhVrUAKLxF5Wbm9+gC29kjhSk9R1CndbHVXDyXTwcz0SJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=azI9fVBx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFPgO031652;
	Thu, 15 May 2025 17:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rufEIK8Td9yKFphPQHzXUnOPWnRbdcUKhS+CfTQM5H8=; b=azI9fVBxRgz4LvU/
	SIrcTgoWmdMqLbMx+so88Pc6Q4/jq4Mr32sJJ+2UOIfHWMg/2zy+qDhdqk75gvr+
	mZc7qlfRhIqqtCvTsb/5TS+dVeKHBnYO2dDlfS4DLD3YlYkiEgIIs7tT+q+dgboz
	gpFAlIyFNaYTJu+6z1vP94coEgnhBRpPF2dSq+92kAAW1GIBWPuMLDiRCCKYBOAk
	DX1zQBirGTRAJW0hqKV2RM6wGzlesozTE4CBgK6iP1t9cWyNfmKW6NdBO/Jv9Gpp
	unjr4wmN9Fyz0QmF0tjQm1MArIwDN0IZSjOv4hvxo0VP62UiHX/tZ9vFqLQvC5kD
	/XZv2A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr6xfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:35:23 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FHZNZR007020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:35:23 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 10:35:21 -0700
Message-ID: <f6d6ed3c-54de-4dcb-bea3-8a420f001c9a@quicinc.com>
Date: Thu, 15 May 2025 23:05:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
 <52d96a61f56cd37b297e12b7ffb2936a479607ea.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <52d96a61f56cd37b297e12b7ffb2936a479607ea.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KEPVnS3c6BymUxvUOECuw2YdRGzcmCIj
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=682625dc cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=hgXNV1NmBLrj5xg9TToA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KEPVnS3c6BymUxvUOECuw2YdRGzcmCIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3MyBTYWx0ZWRfX/HYbGWS+kgxg
 1MRnhp66SqWqTg7gXuUJGVdNB3s8LVSkybf89+g+XaiVE7M0yWqTlMXszsKvgJoqdXQg/D6DTN6
 CDBfTCk9YEzKYC0UdeyWxnwk05pJzZLYXxuJ5kN/1GFDEVRh02yX6pUnv6Izvfl582sguIgg0Vw
 AD4owUiwX/7ZobB/CyyAYOQFxXfV+SAopluHYrwTndabPNAHAtxFp6bX5cFnRWQ665uQBMzxGxG
 u8rJC9+MMB8gt3hG19WUy+OykDWwckIIY/4hzPn4vv/qQmnnvxMGeRV4ZAsetOKC9MqNm7x84gV
 HPfK08iyD8cQ7cQUjH9CaWUueqMzXM+8y8DsS9dBUCMvgYeaRaU2Bei6+SvbPxT84OGw07RSmiA
 AG88erbahqT6aUc6PItz2EtGhGmz14wbA760G1fmi/zBpl3jQWEnt6CM7nfZvjXGxFG6DqUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=989
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150173

On 5/15/2025 5:00 PM, Johannes Berg wrote:
> On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>>
>> +void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
>> +					     struct station_info *sinfo)
>> +{
>> +	/* Resetting the MLO statistics for accumulated fields, to
>> +	 * avoid duplication.
>> +	 */
>> +	sinfo->tx_packets = 0;
>> +	sinfo->rx_packets = 0;
>> +	sinfo->tx_bytes = 0;
>> +	sinfo->rx_bytes = 0;
>> +	sinfo->tx_retries = 0;
>> +	sinfo->tx_failed = 0;
>> +	sinfo->rx_dropped_misc = 0;
>> +	sinfo->beacon_loss_count = 0;
>> +	sinfo->expected_throughput = 0;
>> +	sinfo->rx_mpdu_count = 0;
>> +	sinfo->fcs_err_count = 0;
>> +	sinfo->rx_beacon = 0;
>> +	sinfo->rx_duration = 0;
>> +	sinfo->tx_duration = 0;
>> +
>> +	/* Accumulating the removed link statistics. */
>> +	sinfo->tx_packets += sta->rem_link_stats.tx_packets;
>> +	sinfo->rx_packets += sta->rem_link_stats.rx_packets;
>> +	sinfo->tx_bytes += sta->rem_link_stats.tx_bytes;
>> +	sinfo->rx_bytes += sta->rem_link_stats.rx_bytes;
>> +	sinfo->tx_retries += sta->rem_link_stats.tx_retries;
>> +	sinfo->tx_failed += sta->rem_link_stats.tx_failed;
>> +	sinfo->rx_dropped_misc += sta->rem_link_stats.rx_dropped_misc;
> 
> Setting something to 0 just to += it seems silly?
>
> However I think it also needs a bit more explanation - it's sinfo, so
> it's zeroed at allocation, where would non-zero numbers come from?

Currently, the station information for MLO is populated with some values 
from sta->deflink, as the sta_set_sinfo() call is common for both 
non-MLO and MLO.

When updating the station_info structure in 
cfg80211_sta_set_mld_sinfo(), the accumulated fields (such as packets, 
bytes, etc.) will already contain values set by mac80211 (from the 
deflink fields).

Therefore, directly adding to these fields would be incorrect, so they 
should be reset to zero.

May be this, resetting can be done directly in cfg80211 during 
cfg80211_sta_set_mld_sinfo(), will correct this.

> 
> johannes
> 


