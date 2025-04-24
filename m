Return-Path: <linux-wireless+bounces-21997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09805A9AEF4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 15:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369251B6069E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74827C16D;
	Thu, 24 Apr 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PhWqsnpi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AA14B06C
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501272; cv=none; b=RtDB7G5daGrQC4FAP6s+7zKcApuBQ/ryKad7h9Dy7L1qKIgwIyeJoilMGZT4MXBCmr/u5y56GksnxCbaqrFCVG64xDS22Ubp4kF718eDUGmHq/fpUlpr4ZKxF7Nas8mKyLyU7fOj50FKAD/3Gz4qgTJSC8YnGG8MZqXn5MoPOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501272; c=relaxed/simple;
	bh=BGa6WbAieYsTyuR7AfmQINzwGLtJt1K/24Zr1a/z15Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dM+GE5q9sbLL0TyIlXax6Lk6JbbVzttgoD+ge25DfY34vH9By0Kv27MhMfw+mCqhtTWE4dGgTRMkOPpNQER/VL9msIU1S2ky6vHXptA7SQ0BRmvA8MCC4TSr9FFT5YvRrO3jW4fIK17gP7RxPExYviT0ESbi3DKlmi34LGoYpS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PhWqsnpi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OC3DSk011282;
	Thu, 24 Apr 2025 13:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oXp7v9P8XxHZIyGogFrTdJixmlm1Js4Nv9SP59bPNos=; b=PhWqsnpiJ6gjITXK
	FsIzCqmUiet/+tvdkJBgNm6bXQvyzgeJ2/QuZb67t+d7Xdqq+33y8US1ATbay9Md
	PBfvZZUa+R3sHdwUM6ls1bAtcresXefEcHv8FLpiX1r1VE9EC14jPHwA5w6kn1bM
	TO1OnFnTaCMujkckjPKveGkgZq/yh9lODNojJXGjQKMN2bSuu8HcIUSHEEZsaG6v
	hSoeZ9KCnaVFhCj0eus0Hl9ij6Tfkr8Vby9tVkM2NyCfu/UmE1PMy9hcqO6wgpeu
	5BUD63Ehs41e44D2C7+faRKCdLDZ2wPvSva177l84mt5jZVGfpSsQDeRxnOHmldM
	mg7Xcg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3dppq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:27:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53ODRkLC007804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:27:46 GMT
Received: from [10.50.43.121] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 06:27:14 -0700
Message-ID: <097f0aa3-997a-453f-a2b4-c6126ed5e606@quicinc.com>
Date: Thu, 24 Apr 2025 18:57:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 5/5] wifi: mac80211: set tx power per
 radio in a wiphy
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
 <20250328122519.1946729-6-quic_rdevanat@quicinc.com>
 <3719131760bb5070378e397d716edde394256933.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <3719131760bb5070378e397d716edde394256933.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AdW8pLdNy8-NdgfjdHHdxQTTAslOZcRa
X-Proofpoint-GUID: AdW8pLdNy8-NdgfjdHHdxQTTAslOZcRa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MSBTYWx0ZWRfXwBt38yFHDD6M KE3A7m3jY6dTyDapO87BaPBh1GCTwkZ1Wi0Ork/qfI11cvFzjtTHKPQaI7BLU0xgD9MB+VuPdHY gYXk5jX5jFZu0n5I5M7a6nkHBkx2Uh9U4f5bXps26fYnFhePQA3KJvaw88xldJERQxwY8O6y4Rl
 BNrNKoKIbw8z720+s2xFSRvWcoQtv9zeXhgnv1R23q+wMSeil4RUK+tv7/e3ZZMagKgdz/az/L2 BAzOchzXlniwvi/KvBkYxGcxUiXGMrpxxFqWcHPdbk1To5wokzP9XXK/3Su4verFmoN8rnZDMbz 5MPKMOFE/6/8ZT3XJl4v7iCeea5JXGtcw+jzw/ukZO8LFwsaj7F1RUGVentZhdI0jpIsXP0ORaL
 ctcaciN+SptN90Q6p6noHg/pLLf63btpcK3SgoTKDWpEVtJBajputqHq9+yDU8I7XiSbNgbM
X-Authority-Analysis: v=2.4 cv=Mepsu4/f c=1 sm=1 tr=0 ts=680a3c52 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=d4PKXbG23iaDKRvSrVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=859 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240091



On 4/23/2025 9:11 PM, Johannes Berg wrote:
> 
>> +++ b/net/mac80211/cfg.c
>> @@ -3080,6 +3080,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
>>  	struct ieee80211_local *local = wiphy_priv(wiphy);
>>  	struct ieee80211_sub_if_data *sdata;
>>  	enum nl80211_tx_power_setting txp_type = type;
>> +	struct ieee80211_chanctx_conf *conf;
>>  	bool update_txp_type = false;
>>  	bool has_monitor = false;
>>  	int user_power_level;
>> @@ -3155,6 +3156,12 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
>>  			if (!link)
>>  				continue;
>>  
>> +			if (radio_id >= 0 && radio_id < wiphy->n_radio) {
>> +				conf = wiphy_dereference(wiphy, link->conf->chanctx_conf);
>> +				if (!conf || conf->radio_idx != radio_id)
>> +					continue;
>> +			}
>> +
>>  			link->user_power_level = local->user_power_level;
>>  			if (txp_type != link->conf->txpower_type)
>>  				update_txp_type = true;
>> @@ -3175,6 +3182,12 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
>>  			if (!link)
>>  				continue;
>>  
>> +			if (radio_id >= 0 && radio_id < wiphy->n_radio) {
>> +				conf = wiphy_dereference(wiphy, link->conf->chanctx_conf);
>> +				if (!conf || conf->radio_idx != radio_id)
>> +					continue;
>> +			}
>> +
>>
> 
> 
> Hmm. Is this really enough? What if the link gets disabled and re-
> enabled on a whole different chanctx on a different radio? Or other
> things like that?
> 
> Seems like we may need to change how the TX power is stored in mac80211,
> rather than just paper over it like this?
> 
This means that get_tx_power handling should also be changed. So I might have to work
on resigning this. I'll handle this parallelly. Meanwhile, can I send out the first three
patches handling get/set RTS threshold in a separate patch series? I will re-design
tx-power patches and send separately.

> johannes

