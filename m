Return-Path: <linux-wireless+bounces-5467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3AE8902BE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 16:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF3628F852
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB4E12DDA6;
	Thu, 28 Mar 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DC1mmQls"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9A12A154;
	Thu, 28 Mar 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638680; cv=none; b=qG6o1nhNuaHk1OdbTponimXknjDsx6ZBFKA1flatq/FrBbsYmEi4akr8siSUI02PPP3eLzwY1f0WeMKX2TbLxWSjPf6CoX5EEr/iFnI37JAONrnacEkn2yMJ4GBA170Qk98DNIblGpDHhXjQ++A4PE0Em/vu3DTvwqCZ0Aarz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638680; c=relaxed/simple;
	bh=39mlhyxBKQOXxiWS656Ol19WFtjbnxzPLcE94DGj/8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eMNMSV9V4NLVqwFP5XvQcFJMGLFcHLm+SO66HH08UWB6UduWtKR2gZEsjUMO5ma/SXJkVGH8lPA8NPdIYaQWaI/ZDBI7vNHYCHu/xg7uu70DCmOaLa8obYaSGnqpL3K83BGRRAv1XhMS/lViQ7kcLfC55pPKaWFb+5448xK2npw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DC1mmQls; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SEt1gl003007;
	Thu, 28 Mar 2024 15:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=93YM5qXrGBXdDNyLUklgisAaCVZ+0WF+yRUbnOKQ9iA=; b=DC
	1mmQlsjBD2WIZMJVE0CMMWz/4XCpSxvcUaRLY8KHQyqtJEgS+1pf9beJOB5BnEE8
	AaVHYp8AyP1/g0oYMfVCcyzFrB5y+hy0DS6+SNvwmDPbo1mHnGSYha8d1FE2A0Kp
	cgirEkINQ0E7ecJkGKy5HX6YjwQrjeaQ/HAFR4pZ3z6LQ8OF35iQoxXWgZx5qSc4
	Qegn1q3grt4K5ecZswKg+LuEzOEfuu4KUjbxBO6iYXAjifbdyvq3KrophEgIsyfB
	7nJ8D2Ji3waiKWtzmznQgiVNsWM5PgI7q3yJTz0oBrhpelqPBbXDto9HWQFbWRxK
	qI0ojZyjxcEXhYDQ+bYA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5aqug1je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:11:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SFB5Pn024319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:11:05 GMT
Received: from [10.50.27.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 08:11:02 -0700
Message-ID: <14b739c9-18da-0d58-b58d-cccebc505950@quicinc.com>
Date: Thu, 28 Mar 2024 20:40:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
 <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rIhQfC8DJ_4OyzryFmkwTIs1-_dnuRQd
X-Proofpoint-GUID: rIhQfC8DJ_4OyzryFmkwTIs1-_dnuRQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_15,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1011 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403280104


On 3/28/2024 5:31 PM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 15:48 +0530, Karthikeyan Periyasamy wrote:
>> On 3/28/2024 1:19 PM, Johannes Berg wrote:
>>> On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>>>> +/**
>>>> + * nl80211_multi_hw_attrs - multi-hw attributes
>>>> + *
>>>> + * @NL80211_MULTI_HW_ATTR_INVALID: invalid
>>>> + * @NL80211_MULTI_HW_ATTR_IDX: (u8) multi-HW index to refer the underlying HW
>>>> + *	for which the supported channel list is advertised. Internally refer
>>>> + *	the index of the wiphy's @hw_chans array.
>>> Is there a good reason to expose this? Seems pretty internal to me, and
>>> not sure what userspace would do with it?
>> Hostapd use this hw index for the channel switch cmd.
> What, where? I don't see that in this patchset? And why??
>
> In any case, unless I just missed it and you're going to tell me to look
> at patch N, we don't need it here, and then I'd prefer to keep it an
> internal detail until it's needed.
>
>> The hw index used as a sanity check to identify whether the user
>> requested channel fall under the different hw or not.
> You mean within hostapd itself? That doesn't make sense, it can derive
> that information differently.
>
>> In split-phy hardware, 5GHz band supported by two physical hardware's.
>> First supports 5GHz Low band and second supports 5GHz High band.
> In your hardware design anyway, but yeah, I get it.
>
>> In this case, user space cannot use band vise check here to identify
>> given channel or freq supported in the given hardware.
> No, but it also doesn't need an index assigned by the kernel for that.

Yes


>>>> +	for (i = 0; i < wiphy->num_hw; i++) {
>>>> +		hw_mac = nla_nest_start(msg, i + 1);
>>> And you kind of even have it here already ...
>> Then user and kernel have to make an assumption that implicit index used
>> in the life cycle.
> Agree that's maybe not a great idea, for all we care this could just use
> 0 as the index anyway.
>
> Which reminds me ...
>
> Right now, the way you have it, we have the following structure:
>
> NL80211_ATTR_MULTI_HW
> - 1
>    - NL80211_MULTI_HW_ATTR_IDX: 0
>    - NL80211_MULTI_HW_ATTR_FREQS
>      - 0: 2412
>      - 1: 2417
>      ...
> - 2
>    - NL80211_MULTI_HW_ATTR_IDX: 1
>    - NL80211_MULTI_HW_ATTR_FREQS
>      - ... as above with 5 GHz etc.
> ...
>
>
> Netlink is kind of moving away from nested arrays though:
>
> https://kernel.org/doc/html/latest/userspace-api/netlink/specs.html#multi-attr-arrays
> https://kernel.org/doc/html/latest/userspace-api/netlink/genetlink-legacy.html#attribute-type-nests
>
> This talks about families, but maybe we shouldn't read that literally
> and do the new style for new arrays in existing families as well, not
> just new families.
>
> If we do that, including NL80211_MULTI_HW_ATTR_IDX for illustrative
> purposes though I think it should be removed, we'd end up with:
>
> NL80211_ATTR_MULTI_HW
>   - NL80211_MULTI_HW_ATTR_IDX: 0
>   - NL80211_MULTI_HW_ATTR_FREQ: 2412
>   - NL80211_MULTI_HW_ATTR_FREQ: 2417
>   ...
> NL80211_ATTR_MULTI_HW
>   - NL80211_MULTI_HW_ATTR_IDX: 1
>   - NL80211_MULTI_HW_ATTR_FREQ: 5180
>   - NL80211_MULTI_HW_ATTR_FREQ: 5200
>   ...
>
> which _is_ a lot more compact, and removes all the uninteresting mid-
> level indexing.

Can you point to any attribute constructed in this way from kernelspace 
for the reference to explore more ?

-- 

Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி


