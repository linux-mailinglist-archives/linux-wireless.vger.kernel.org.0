Return-Path: <linux-wireless+bounces-23221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB9ABF0B2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 12:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492814A7421
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E425B69A;
	Wed, 21 May 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XqgoKQB3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5E25B666
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821776; cv=none; b=Gj+ag2TwNxUJe2SejZ+yYJYEun6ZoG8XbbKrrGGEMISshHkDzp3IiQdqfrIystzE7Li2wSek3ghCO0PQXsRGIN8TtQGvGbkLHLysKnHXqBkh4Pc2seLg/w5ox0hjGqqAzes1AByrvW3U0DF5TJBoyOoyfzBOkv1+DBdySh4FV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821776; c=relaxed/simple;
	bh=wJ7DL0HqWmUjD1n7F3tZRjI2c2GkhOAVGDx3imk7vM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tri1ots27EreW64CmYRXstk3cmd+tvS/JlnbsSAwKN1fjR2RxMgrKHZgtSwsbxvQE8SWImrtiTNWyAqT6PWISgdx8+BgBR8nW7iYMIfpYOADumBpb8rQNQYkuQZLz0+SyZjIbTPzV6v8f7KRQBoTIDtoH4W7UcBsFxrBaAaYfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XqgoKQB3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XSiV016644;
	Wed, 21 May 2025 10:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/JI/W3g4p8IYME0zi4Q+xvcgzIYNeBtvj2TZ2du2E9w=; b=XqgoKQB3PnQzVBFC
	1QA9dQGNKcpRylJbBlq8oksSyRNgPe8M0Dtxx9uc6xWlOKJhpyOsogt0kgqHWhFS
	4MW9zJCudwDy1C5Swqg5vA5hFZGQ91iWWaAkxxYJXz+zBv9GgXEx91pWuSP4tmHV
	jx+QBKfGbvNsx2iIGHAbgzJn1swn8rtgtafR6n0ywgZLWpBw04imBAE6RvWyTQOO
	zmstQrLJl5RLiectxukIeA69Z9YXeg5WSi3tmRMVAovu5zyTpCrhjyAlh5Zi+IxL
	ElOz42V1Iyb98g+QfFdLjRkO/2rgXdlYShWPv9hH6Am5U4KKn3cHjbv6zkKds3Vy
	BznaEw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9tgeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:02:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LA2kJs011493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:02:46 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 03:02:45 -0700
Message-ID: <233b62f2-1cf6-4492-9053-eb6efdf51787@quicinc.com>
Date: Wed, 21 May 2025 15:32:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v9 1/3] wifi: cfg80211: Add Support to Set
 RTS Threshold for each Radio
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
 <20250429040048.3356960-2-quic_rdevanat@quicinc.com>
 <accbd6fc15d4a22ec66fc67b4bc8f97c7b24d7fd.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <accbd6fc15d4a22ec66fc67b4bc8f97c7b24d7fd.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682da4c7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=stkexhm8AAAA:8 a=IcepAnfWZxy4S1riAngA:9 a=QEXdDO2ut3YA:10
 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-ORIG-GUID: jZam_jNbUKPZgB7fP2OZ7NYmDNi6PFtu
X-Proofpoint-GUID: jZam_jNbUKPZgB7fP2OZ7NYmDNi6PFtu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5OCBTYWx0ZWRfX+98n82LeBrty
 I7X5a4xQ0jlhV3QTDdXaDPqbMSnbshiiR42X7WIzgVFR8tf88W/B+UOyoDbaO3RrsZcIcYXcVhf
 S3bcIW8AGnPaIaVYCgqrZnLoRIAVXGYX8rL5ADGee180mkZzlxp91WeRnW12VKw2dASjOEUxVv+
 +MYGPxYuP8FhKL+RTzHaCBdm0bJnD0ojjzesnobOGSZC7IpT9UPPFOHkxFArfOka0iUamWEAIW0
 IJrNRPF2xV1IXo5Ps3uDfzLvt3zTkwNxvFzfBKzp2qNg3NrNLU5+VTgFhRnoNsqqHI8ikIwjUTK
 0JKk0Bg06VpWFLmmmSElckkCcab1EE89LG5RXwvGq74hqXKrwIsED7oBXsgvbIx3qMLWf58BOdG
 T3s1CUiVWaxzZjqKiLSgKlaxKalg+Z6Lkh9saNiR1qpo6aR34Pnkn5yWe0xh7A7EeoqTeWYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=554 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210098



On 5/21/2025 12:47 PM, Johannes Berg wrote:
> On Tue, 2025-04-29 at 09:30 +0530, Roopni Devanathan wrote:
>>
>>  #define NL80211_WIPHY_NAME_MAXLEN		64
>> +#define NL80211_WIPHY_RADIO_ID_DEFAULT		-1
> 
> I pointed this out before, that doesn't belong to the API.
> 
> https://lore.kernel.org/linux-wireless/bef48349364854ba2ec42262e91b747028310a1c.camel@sipsolutions.net/
> 
> Please address comments or tell me why you disagree.
> 
As discussed, I'll remove the define in next version.

>> +	if (info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]) {
>> +		rts_threshold = nla_get_u32(
>> +				info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]);
>> +		changed |= WIPHY_PARAM_RTS_THRESHOLD;
>> +	}
>> +
>> +	if (changed) {
>> +		old_rts_threshold = rdev->wiphy.radio_cfg[radio_id].rts_threshold;
>> +
>> +		rdev->wiphy.radio_cfg[radio_id].rts_threshold = rts_threshold;
>> +
>> +		result = rdev_set_wiphy_params(rdev, radio_id, changed);
>> +		if (result)
>> +			rdev->wiphy.radio_cfg[radio_id].rts_threshold = old_rts_threshold;
>> +	}
>> +
>> +	return result;
> 
> nit: you could invert the "changed" test and save some indentation,
> those lines are pretty long. Then you can also not initialize "result=0"
> and "return 0" for the !changed case, which is more readable.
> 
Sure, will do this in next version.

>> +		old_radio_rts_threshold = kcalloc(rdev->wiphy.n_radio,
>> +						  sizeof(u32),
>> +						  GFP_KERNEL);
>> +		if (!old_radio_rts_threshold) {
>> +			kfree(old_radio_rts_threshold);
>> +			return -ENOMEM;
> 
> Hmm?
> 
> Also doesn't that leak?
>I'll remove kfree() from within the if() condition and free old_radio_rts_threshold
towards the end of its usage.
 
> johannes

