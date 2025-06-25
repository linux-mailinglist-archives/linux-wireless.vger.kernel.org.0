Return-Path: <linux-wireless+bounces-24499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9CAE8BE6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 20:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64124A3DA5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D6A17A2E3;
	Wed, 25 Jun 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lRjliZ/F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C61A238F
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874464; cv=none; b=c+Wi+iRUsHqYkqUoayQNx1/qKVPrN4aJepCj7HFPf5B5T3xl2Q/Q0uxAZaO5PT74r44CcS7ouKqKp/cJtPL/x2uoLX9uXMsS+kIPDEEHSf/RZ+xELpIHq6ePoChuhHvMIP8Y7JrI40jfOyOnZFiLmXL40Nlk4qanPzH5V/QYS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874464; c=relaxed/simple;
	bh=4ailiyco0jlx6XFrvECOxDqWFxXEAVzKa4c/8Pc7mlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=il5bTfO070q5CBVzmO4yVL9DvDcngpmw+se982YXfn0DYlU4oHckr23DQJVkvDCsaEJzfkotvxoqlB1vJRZYxNrVaVJdgrY22m/Y/EurnOH04Tp49DovSF+yj2+qiMHWAJIUQ7Oj+k57wI5YtNiNULtX5fO1fTRR6Bg9mAfDjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lRjliZ/F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PBgSRm020695;
	Wed, 25 Jun 2025 18:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JGgMYPfju+kM/79SsM+/iRosb+LE06ubjIvLF1JziIY=; b=lRjliZ/FpAwl+YNk
	MlxSdrP46FSAJZJL+csUh6gaiuosO4krmZATzQDbPFbszWtwvdGaDU2YZIMQEOJs
	3vhoQT6/cne8JWiwqbdUE2Uhoa4NLpIG47lZER1oZOrqZvB7QimVeuuXdFNUImkC
	lc8O3Vb7Kg9/Qm2O7lcGgeadjTSDIVkZ0kykX/R1j9IxZjPhADKqQoHu26c9yXeg
	Td4asZ9ZY1liM0/cQFOFbszeCZ+qltogu1ypoWfcpncTfcMfnkqxkGHqhNR+yt2e
	kIgh3JMpxIuDq/extF+oaVV2VJHKK+wgNcmNDfZ4i9YonOjkTn8mXPZ1QOjbwMbl
	wXG9oA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ec26b1qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 18:00:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55PI0tDC006721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 18:00:55 GMT
Received: from [10.216.0.176] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 11:00:54 -0700
Message-ID: <d8adfa98-a11b-42ee-b0db-7075f7424690@quicinc.com>
Date: Wed, 25 Jun 2025 23:30:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: extend beacon
 monitoring for MLO
To: Johannes Berg <johannes@sipsolutions.net>,
        Maharaja Kennadyrajan
	<maharaja.kennadyrajan@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250609070319.1033874-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <20250609070319.1033874-2-maharaja.kennadyrajan@oss.qualcomm.com>
 <292dd6c29502868b0397e66eb3cb450dfa0e71df.camel@sipsolutions.net>
Content-Language: en-US
From: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <292dd6c29502868b0397e66eb3cb450dfa0e71df.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEzMyBTYWx0ZWRfXwscq2BtQCd45
 ZPOA4M9d5kt/UB4+JYIYSfjBgJT7mnKleDOJD80OApqrfEYrgIwJhc82ytykj3/sNzg2LtgojjH
 l83ntuLjvzkLwboES5+gOySy8pirB5SM7LwKSqSe6rslLrOY03Vs/J/AstChO/IfsbYURJa2BBn
 zQNFHX70q5Hw+UeWltVzoZYi9IP//eUO4mDIXW2qp35Ot6851O/bYgNmeRRQn/jK1fX1rLoyhsI
 tkvV+bNxXt7c8Xb2L0Ti58Or/1XExw3F4ZVaevSlFNCoEsrTDYUptS1rli9uHDM9aB5e0VF1reo
 EaPv2dh+ErGeHSSzvlkj1SSH9GBIY4ITZdDW/KYsN8/10/UXvLwB17L5QWQqyisjzprjCd6uaNL
 mUGMHc9wJomco05YWKiYMtI6951Y9CXhm4trebdmx3AseQOFUd2sLBg3CON37Y9P9xjthazl
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=685c3958 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=j6ABP9cFcp9d3wJsn1cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: awejTx2Xn21nLN_wNmKtDhl2h7lJEk0r
X-Proofpoint-ORIG-GUID: awejTx2Xn21nLN_wNmKtDhl2h7lJEk0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=573 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250133


On 6/24/2025 9:16 PM, Johannes Berg wrote:
> On Mon, 2025-06-09 at 12:33 +0530, Maharaja Kennadyrajan wrote:
>> +++ b/net/mac80211/mlme.c
>> @@ -2439,6 +2439,19 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
>>   		}
>>   	}
>>   
>> +	/* It is not necessary to reset these timers if any link does not
> nit: I think we should start/continue using normal "non-networking"
> comment style. I even removed the special style from the networking
> style guide, and it was never a good idea (IMHO) to start with ... but I
> know we've not been super consistent either way.


Sure.. I will change the comment accordingly in the next version.


>
> Anyway that wasn't why I was commenting, rather:
>
>
>> +	for_each_link_data(sdata, link) {
>> +		if (!(link->conf && link->conf->csa_active))
> That condition, and other code later, really seemed confusing to me, and
> when I carefully thought about it I realised that you were afraid that
> link->conf would be NULL? However, it can't, that just doesn't make any
> sense.
>
> Now then I thought _further_ about it and sent/applied this patch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=d87c3ca0f8f1ca4c25f2ed819e954952f4d8d709
>
> but that's not even relevant for your changes since you have full wiphy
> lock held, not just RCU protection.
>
> So please let's not be overly paranoid with this, and remove the
> unnecessary "link->conf != NULL" checks.


will remove the link->conf NULL check.


>
>> +static bool
>> +ieee80211_is_csa_in_progress(struct ieee80211_sub_if_data *sdata)
>> +{
>> +	/* In MLO, check the CSA flags 'active' and 'waiting_bcn' for all
>> +	 * the links.
>> +	 */
>> +	unsigned int link_id;
>> +
>> +	guard(rcu)();
>> +	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link);
>> +	     link_id++) {
> maybe add a blank line there, the guard is pretty hidden this way


will take this in the next version.


>
>> +		struct ieee80211_link_data *link =
>> +			rcu_dereference(sdata->link[link_id]);
>> +
>> +		if (!link)
>> +			continue;
>> +
>> +		if (!(link->conf && link->conf->csa_active &&
>> +		      !link->u.mgd.csa.waiting_bcn))
>> +			return false;
> here, technically, it _is_ just with RCU, and I guess we can wait until
> I merge the other patch, but it's pretty unlikely to get into any issues
> even without it.
>
> johannes
>

