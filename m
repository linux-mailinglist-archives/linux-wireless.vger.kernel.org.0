Return-Path: <linux-wireless+bounces-8685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF8900149
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 12:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BCD288C1D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEFB61FCE;
	Fri,  7 Jun 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cUAaXVdE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFD16F291
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757655; cv=none; b=KCcGyrNy93FPfeQPE6BYehbtYss7DFhrcBLWgLmrrbsga8emn78LYTrYQtgQ02uP7Di49kH1hHxLlEkVP+8O8PRnDFNjD+k8MQ+OEWnq7bVq3ZdLjYnq5cDSj6SSx6fdvRQHFF7GO/Qrkyi9FXsC9U9Ge32CYgzj2DNyrSCpz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757655; c=relaxed/simple;
	bh=FhZY2kJbauioaoK7VTw7Jpjp9vTz+tFTdCHvYujrvlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G00aiskFDe7bbn8W38G+j8eA5cL9xe9RkqcR1NanoXCTs7VwsOfEYSwPYBrIfhTzsEaS/bx2GkEAB+1MuFR0YKGBljrBN3GywsPfk7DTSldgKln0o2IPs4xZ2DvaitbBXdhiTOAHPIDaPlUTPCLe062h0N06mkg9GzhXYWgAZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cUAaXVdE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4573smrS005110;
	Fri, 7 Jun 2024 10:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MLjRyFZvABbimdq+0skb07AjOJ/EOU+r7LoUC5u9r94=; b=cUAaXVdEXdI0V8Zn
	tSN66ZZjQR7Kvqsnr6Vy4a6FA3esvZnqBzrEyIQcESfCA/DiudGwiRcUfgSvSj3G
	9z+h/CxJu1NuktuSm4GnwRZTyZaQ+YwH9+44X0rmIe3moKaCOJe7rVBprCm7Uq35
	fMeEfbOdMZh7K1fAeXG42w8+QGl3sXXzqBcALxfnvPt+VcCGRlqgEFONUe+01VMf
	nVwoRajLObcrR3YcZEs8w4Qvxy6a9kYmJhOHI34XE2Zv7crIbIjRHFxtXYddeO4w
	u4cwzGVLLlqMSxU6M6Bx05mv9i/NLjYmMDlL2NTi3Kt/4oB+LZfqBBNYZZ0Bi5qB
	P98Akg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjq2tngfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 10:54:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457As0aF028432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 10:54:00 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 03:53:58 -0700
Message-ID: <479752f5-221d-746b-7513-ba27ef547ac1@quicinc.com>
Date: Fri, 7 Jun 2024 16:23:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v3 6/8] wifi: mac80211: extend ifcomb check functions for
 multi-radio
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <bc603fc671010bb720e75881ef0e22d81ec6e2eb.1717696995.git-series.nbd@nbd.name>
 <a337de2e-fe3e-18ed-b55b-9ea2cd21baed@quicinc.com>
 <1f32cb6c-6be8-4e3d-8e8f-2d3c728875a9@nbd.name>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <1f32cb6c-6be8-4e3d-8e8f-2d3c728875a9@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: icognQ9Ic54dwplhKoCE2ZSNit5uEZqJ
X-Proofpoint-ORIG-GUID: icognQ9Ic54dwplhKoCE2ZSNit5uEZqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_05,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=803 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070079



On 6/7/2024 3:52 PM, Felix Fietkau wrote:
> On 07.06.24 12:07, Karthikeyan Periyasamy wrote:
>>
>>
>> On 6/6/2024 11:37 PM, Felix Fietkau wrote:
>>> Add support for counting global and per-radio max/current number of
>>> channels, as well as checking radio-specific interface combinations.
>>>
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>> ---
>>>   net/mac80211/cfg.c         |   7 +-
>>>   net/mac80211/chan.c        |  17 +++--
>>>   net/mac80211/ibss.c        |   2 +-
>>>   net/mac80211/ieee80211_i.h |   6 +-
>>>   net/mac80211/iface.c       |   2 +-
>>>   net/mac80211/util.c        | 131 
>>> +++++++++++++++++++++++++++-----------
>>>   6 files changed, 116 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>>> index 62119e957cd8..950b7b72f0b8 100644
>>> --- a/net/mac80211/cfg.c
>>> +++ b/net/mac80211/cfg.c
>>> @@ -263,7 +263,7 @@ static int ieee80211_start_p2p_device(struct 
>>> wiphy *wiphy,
>>>       lockdep_assert_wiphy(sdata->local->hw.wiphy);
>>> -    ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
>>> +    ret = ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
>>>       if (ret < 0)
>>>           return ret;
>>> @@ -285,7 +285,7 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
>>>       lockdep_assert_wiphy(sdata->local->hw.wiphy);
>>> -    ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
>>> +    ret = ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
>>>       if (ret < 0)
>>>           return ret;
>>> @@ -4001,7 +4001,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, 
>>> struct net_device *dev,
>>>           goto out;
>>>       /* if reservation is invalid then this will fail */
>>> -    err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
>>> +    err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 
>>> 0, -1);
>>
>> Once we reach the global limit, all the -1 passing caller get fail
>> becuase the iface check param (existing and new) is validated against
>> the global limit. since global limt as a sort of union of all per-radio
>> limits.
>>
>> Ex:
>> Global iface = 6 (Radio iface 2GHz:4, 5GHz:4, 6GHz:6)
>>
>>
>> So far 6 iface created (Radio iface 2GHz:2, 5GHz:3, 6GHz:1)
>>
>> In this case, new iface creation get fail because caller uses
>> ieee80211_check_combinations() with -1 as radio idx, so it checked
>> against global limit
> 
> Use the sum of the number of interfaces from each radio instead of the 
> maximum.

Oh, then legacy user have misconception of the global interfaces 
advertised and try to fail for the allowed limits.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

