Return-Path: <linux-wireless+bounces-24500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B00AE8BEA
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 20:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0DC7AF12C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B771DE3CA;
	Wed, 25 Jun 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kK3UZDU7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A301DDA3E
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874604; cv=none; b=nR6bKO2n/0Vw/EucDjnuWvDApAFTgaQ1+72mfCst4Pcp0DmgArKEXzM+Yi9aIoPmKlJ6pv/eCHdfys3ACSreN+BnW5k2aJenlpb/MwLLj7KMBTAGcIqp0L35+nCoKIc2v3LuaXl6t/FUIoDmTTfTreXAp6A5s01ARO5N09/pRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874604; c=relaxed/simple;
	bh=cL85MMb01BDM9klW67sc3YpkKq7zDg3nfFQJHnrm5XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=caMHgQg0vqVxSgjf/XClXBXvE3C3uKz6FqHvuv2FSSQvIP3+Ewo1T3O5v1cF89B+cczGQxRf+69xBzj949R7lCSRR+wo08/b1GNAtq/GKx8bS7A994d9f4Rii8Zj5Bm5X/CQr47MMgPqYwEheMkec8iwclTKnBdBj+CbgUFV0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kK3UZDU7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PDKS12022985;
	Wed, 25 Jun 2025 18:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nu5f2Bm06WrkazM8CT1/2HVDvWvDKVERBIiiQIqyP9Q=; b=kK3UZDU7DeAO+BrL
	RATY82bo1l0BYyiYc+JFp3Gv4a7rUniubGbgX3vnIuU5WgMBCZWSANDhGfUKyDKD
	hm+9yq3fdPVhmTwZq5LKOXMxsKjkJiNdLwh+APdR3gWfl5JhhNpx3nOBdDSp4fdj
	83RGhBKjGl3EHTChhpz2ECr/yMHpRjo7w+JFKiWVtScsA7JcN/hP+dyLuZRPGXLe
	rPYebxfxIXKo52l+DRr5f28+kokb/GJ1Ueb4E8kTPE+TWFMkT7DNIghhb5dxAeLj
	dazLTwX44phL0K845iHNg+570Wh6S+CP5UsExJP6t+d+cSC4nySsyYZOsHraD3qx
	tmhk0Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bggu18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 18:03:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55PI3I5b011671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 18:03:18 GMT
Received: from [10.216.0.176] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 11:03:16 -0700
Message-ID: <52b3dc13-4a83-4942-b36f-57b45c3fb00d@quicinc.com>
Date: Wed, 25 Jun 2025 23:33:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/2] wifi: mac80211: extend connection
 monitoring for MLO
To: Johannes Berg <johannes@sipsolutions.net>,
        Maharaja Kennadyrajan
	<maharaja.kennadyrajan@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20250609070319.1033874-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <20250609070319.1033874-3-maharaja.kennadyrajan@oss.qualcomm.com>
 <45e4d1feb87dc75dbc634c811e5553567f3aa6e8.camel@sipsolutions.net>
Content-Language: en-US
From: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
In-Reply-To: <45e4d1feb87dc75dbc634c811e5553567f3aa6e8.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aeSpK6LDtonv8SLhsYzUls-OIg4khRmY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEzNCBTYWx0ZWRfX8YN9qJB876h+
 QuN6lhed2wGuGCeZBd+VS/SCCei/jPuPBVDAFKbPVXuGjK3afNMAGgjByy/dFH0pLxj3g3mtULs
 72ByUfBSCDjvQrECvOazTzql5AszGYWXgXoADthhu5kBV/rEnJv7xkYW5YgnQn14OPkhjp1m6CB
 PW8R5fSafKA1McPCsBvPRAsGoddjL/k+aFq30Lj5cFQQN+OAeZM771vgDvrt7XaN9UqF/7N4kp+
 spr9+15kmtcrPs3ZvvCNJBlD8cE6iJA0kY3lfmRnn2rY8jFWr3lNGOV8ocOlNiOz6fYpFtSmbPS
 MkCpTkG30EIZjl2wD9ulMsxubQtdfZyaEUVKOCqN/VZ2xfYLkff24XsQyj7xK3/0zZQHaGNgAiv
 v4f3hS8IvLcPSALQjPSrvZAycRQ1o/vbwva3TtzjmitAapJ8D2OLsfPDxgihrjS38t04YtJ1
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685c39e6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=h3NK9NHfiguZWBouwjIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aeSpK6LDtonv8SLhsYzUls-OIg4khRmY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=935 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250134


On 6/24/2025 9:19 PM, Johannes Berg wrote:
> On Mon, 2025-06-09 at 12:33 +0530, Maharaja Kennadyrajan wrote:
>> +static bool
>> +ieee80211_is_all_links_timed_out(struct ieee80211_sub_if_data *sdata,
>> +				 unsigned long *latest_timeout)
> That really could use a better name - "are all links timed out", at
> least, but what does it even mean that "a link timed out"? You mean
> something more specific, surely?


I will rename the function name in the next patchset.


>
> Also maybe we can encode the bool return value in a special timeout
> value, say 0, and just make sure 0 is never otherwise returned by
> adjusting by a jiffy or so? Not sure, just seems a bit annoying to have
> both, but maybe it's worth it.


sure. I will change the return value instead of bool.


>
>> -	if (sdata->vif.bss_conf.csa_active &&
>> -	    !sdata->deflink.u.mgd.csa.waiting_bcn)
>> -		return;
>> +	unsigned long latest_timeout = 0;
>> +	bool all_links_timed_out = true;
> You don't need to initialise something


will take care this as well.


>
>> -	/* If timeout is after now, then update timer to fire at
>> +	all_links_timed_out = ieee80211_is_all_links_timed_out(sdata,
>> +							       &latest_timeout);
> that you're going to unconditionally initialise anyway
>
> johannes
>

