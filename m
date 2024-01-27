Return-Path: <linux-wireless+bounces-2596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3BE83EB57
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 06:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C685B282A3E
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 05:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5547E2F32;
	Sat, 27 Jan 2024 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T1Du9r+L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F057F
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706334274; cv=none; b=B47JLxC/+YI83Qz3AB1Z4SW49jlyQostG83yOgqqHwOsVeVa/+hGpUse/PBeGkYADaCiTcw+XEzdGd+52o0Z6eP6FiBHeVgd+gjXsOdA5ttMXgXYD3dYNxIcxkJMs4i7UYyYOcNZ9TpADvjRGfIKgJyYHkTk1GFTECsnUIWx1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706334274; c=relaxed/simple;
	bh=XgT2ycECn/dHrxHiJVw8AU/YGOP7AS2weZNOM/z7Mc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SKTGFQkDpImRmkmB/Hds/4gBoQhkhkCzAI9l36Uw7ELx5NCANn4+FgIimayiUXDYfdw3Inm/1w3T2dLJWI6MhqrKBUuMDbTdBNfjn6LfSrV2++Za5cvzao/l/S+fmgcwbZe0MUm9fNYNprsoHRiXUUv96KcwbvF85//hxQxTyZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T1Du9r+L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R5iSFT030430;
	Sat, 27 Jan 2024 05:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bzlsd9nuC/PfjPMz/m68XLpgms11ERaL25OXJictqgE=; b=T1
	Du9r+LyjNZCdkjLdQp8r8Wmn45gIFjU8EdHYbfHwybRcVwUuM47/h1BqD5umGArF
	MGICVsx7vnApeJkfn4u3woqJCJfN3hQn86RAj/Z4861QNd1rSsBnGJ/0IyBS0Jkd
	EVWtWHapiFjLkL89NqFNSoO8/4VfehER4TL6kEq/xflqxMiG1PMZAWEBAfoNGKoL
	5qGft0BhJv5W2jmUKniLqX+Hk8rMNO7I7a3zvt670IpQKpnoBMXe9ldN2EZtV7zV
	5zr7PnBUfTJWAOi5xTQx+hf2ipZBVDmmE+BXXEW+tVUideT7zii9i4U5xSPOPO0y
	pPAaAGQKk3iH7xN6JU6Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvse4r59c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 05:44:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R5iRPM001342
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 05:44:27 GMT
Received: from [10.216.58.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 21:44:25 -0800
Message-ID: <307eaecc-fd88-4fd8-8857-dd3910257d34@quicinc.com>
Date: Sat, 27 Jan 2024 11:14:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: cfg80211: add support for link id attribute in
 NL80211_CMD_DEL_STATION
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
 <20240125125855.827619-2-quic_adisi@quicinc.com>
 <61ad9e10e42c9f114c2a7de534690f8c0133bf58.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <61ad9e10e42c9f114c2a7de534690f8c0133bf58.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yXbIzqNOJA1UEQAPIhxmobzJwJdoK5s6
X-Proofpoint-GUID: yXbIzqNOJA1UEQAPIhxmobzJwJdoK5s6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270041

On 1/26/24 14:36, Johannes Berg wrote:
> On Thu, 2024-01-25 at 18:28 +0530, Aditya Kumar Singh wrote:
>> Currently whenever NL80211_CMD_DEL_STATION command is called without any
>> MAC address, all stations present on that interface are flushed.
> 
> True.
> 
>> However with MLO there is a need to flush the stations from a particular
>> link in the interface, and not from all the links associated with the MLD
>> interface.
> 
> Fair enough, I can get behind that.
> 
> Edit: reading the code - I think I misunderstand that ... you're
> actually trying to remove all MLDs ("STATION") that have an active link
> on this link? 

Yes correct. The station might not be MLD station. It could be a legacy 
station (non EHT) as well.

> So then maybe disregard all the below, and just write a
> better commit message?
> But I'll leave the below because I'm not really sure what you're trying
> to do here.
> 

Sure.

> 
>> For example - 2 GHz and 5 GHz are part of an AP MLD. When 2 GHz BSS is
>> brought up, it sends flush command on the interface (MLD). Then eventually
>> 5 GHZ links comes up and that also sends the command on the same interface.
>> Now by the time 5 GHz link comes up, if any station gets connected to 2 GHz
>> link, it would be flushed while 5 GHz link is started which is wrong.
> 
> Right. Though in this case - after bringup - you wouldn't really have to
> flush anyway, so it could just not do that, I guess? Feels a bit like a
> broken flow which is a bad justification, but I do understand there's
> justification for this.
> 

Correct, for the first bring up not required but one use case I see is - 
the hostapd interface was disabled for some reason. While going down, it 
would have cleared the stations on the kernel but what if for some 
reason kernel did not clear the station entries and there are some stale 
entries present? So at next bring up (during enable) it would send the 
command without any MAC address to flush all stale entries (probably as 
a safety so that kernel and hostapd would now be on par).


>> Hence, add an option to pass link ID as well in the command so that if link
>> ID is passed, station using that passed link ID alone would be deleted
>> and others will not be removed.
> 
> So first: Do you want some feature flag that indicates this? Or will we
> just eat the cost of kicking out everyone (without even sending deauth
> though, I think?) when running on older kernels?
> 

If what I said above was the actual intention, then kicking out everyone 
without even sending deauth makes sense? Yes? If yes then we don't need 
a feature flag.

> 
> Secondly: why is this part of NL80211_CMD_DEL_STATION? I'm not convinced
> that makes sense. I actually kind of get why you're doing that - it's
> easier to retrofit into the existing hostapd, but I don't necessarily
> think that the hostap design (problems?) should influence this too much.
> 
> IOW, it would feel much more appropriate to have this as part of
> NL80211_CMD_REMOVE_LINK_STA? After all, when going to MLD then "STATION"
> now represents a "peer MLD", and "LINK_STA" now represents an affiliated
> STA. And flushing all affiliated STAs is what you want.
> 
> So I think it should be NL80211_CMD_REMOVE_LINK_STA without a
> NL80211_ATTR_MLD_ADDR.
> 

At least as per the current way of NL80211_CMD_REMOVE_LINK_STA 
implementation, it did not made any sense to delete all link STAs if 
MLD_ADDR is not passed. So probably the command should be called as many 
times as there are active links in the STA?

Still I feel that NL80211_CMD_DEL_STATION is the proper place to put 
this? Without the current change also, it used to flush all STAs 
whenever MAC address is not passed. With MLO, now we need to flush STAs 
only if it is using the given link ID. So that link STAs from other 
affiliated links of AP would not be flushed.

Scenario I'm targeting is this -

Pre-MLO
----------------------------

sdata -> 2 GHz AP interface
sta_lists ->
	1. sta -> connected 2 GHz AP sdata
	2. sta -> connected 2 GHz AP sdata

After NL80211_CMD_DEL_STATION is given without any MAC address,

sta_lists ->
	No entry(ies)

With MLO
-----------------------------
sdata ->
	link_data -> 2 GHz AP link (link ID 0)
	link_data -> 5 GHz AP link (link ID 1)
	link_data -> 6 GHz AP link (link ID 2)
sta_lists ->
	1. sta -> connected AP MLD sdata
		link_sta 0 -> connected to 2 GHz link
	2. sta -> connected AP MLD sdata
		link_sta 1 -> connected to 5 GHz link
	3. sta -> connected AP MLD sdata
		link_sta 2 -> connected to 6 GHz link
	4. sta -> connected AP MLD sdata
		link_sta 0 -> connected to 2 GHz link
		link_sta 1 -> connected to 5 GHz link
		link_sta 2 -> connected to 6 GHz link

Assume 5 GHz goes down and it gives NL80211_CMD_DEL_STATION without any 
MAC address,

sta_lists ->
	No entry(ies)

This is not desirable since 5 GHz link went down, why 2/6 GHz STA also 
got flushed.

Hence with the proposed change, only sta #2 and #4 would be flushed 
since only these two are using passed link ID (which would be 1).
Hence after the command,

sta_lists ->
	1. sta -> connected AP MLD sdata
		link_sta 0 -> connected to 2 GHz link
	3. sta -> connected AP MLD sdata
		link_sta 2 -> connected to 6 GHz link

Now, if ML re-config support is present, then hostapd (or the user space 
controller for that matters), could first issue 
NL80211_CMD_REMOVE_LINK_STA for the MLD STA (#4) and remove link sta 
with ID 1 from it. So that when NL80211_CMD_DEL_STATION comes, it would 
not remove the 2/6 GHz link STA as well from the MLD STA and hence flush 
the whole entry.

The above change is not there yet in hostapd, so for the time being, 
whole MLD STA would be flushed.

>> A subsequent patch would add logic to delete only the station using the
>> passed link ID.
> 
> Not sure I'd say that here - I mean, (1) yeah obviously, otherwise we
> won't apply this patch? and (2) it's not related to cfg80211.

Sure got it.

> 
>>   	case NL80211_IFTYPE_MESH_POINT:
>> @@ -7675,6 +7677,17 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
>>   		params.reason_code = WLAN_REASON_PREV_AUTH_NOT_VALID;
>>   	}
>>   
>> +	/* Link ID not expected in case of non-ML operation */
>> +	if (!wdev->valid_links && link_id != -1)
>> +		return -EINVAL;
>> +
>> +	/* If given, a valid link ID should be passed during MLO */
>> +	if (wdev->valid_links && link_id >= 0 &&
>> +	    !(wdev->valid_links & BIT(link_id)))
>> +		return -EINVAL;
> 
> Maybe refactor this with the NL80211_FLAG_MLO_VALID_LINK_ID checks?

See comment below -

> 
>> @@ -16827,6 +16840,9 @@ static const struct genl_small_ops nl80211_small_ops[] = {
>>   		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>   		.doit = nl80211_del_station,
>>   		.flags = GENL_UNS_ADMIN_PERM,
>> +		/* cannot use NL80211_FLAG_MLO_VALID_LINK_ID, depends on
>> +		 * MAC address
>> +		 */
>>   		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
> 
> Hmm? How does NL80211_FLAG_MLO_VALID_LINK_ID depend on the MAC address?!
> It ... doesn't?
> 
I mean intention was that if MAC addresses is passed then no need of 
link ID. That is why did not add the valid link flag since it would 
expect the link ID even when MAC address is passed.

