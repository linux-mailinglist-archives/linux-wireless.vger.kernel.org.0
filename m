Return-Path: <linux-wireless+bounces-2807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A184225C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 12:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7152A1C24DA3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32132664AE;
	Tue, 30 Jan 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cd8o/JWX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED3664A2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613123; cv=none; b=biBynm4QqocbDs0nwFxo84cZiAjD56FNnre2kKHQHa6Pzl317qSr/cT56tiOvuKoLcjBsyMvCJqyvh93mc4DCKitFYH22PUe7+/7ejU6CehhST+cGZMNY7WEkQGzLukqG4NkGAebbxWc61+QcDwFokzI0GukNlxH8riyHl/7xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613123; c=relaxed/simple;
	bh=hRa8PrtGNpqEAC2SwmCJ5tAE+9CJ3xOXGmbX37SBwbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qzul72pcj/gKe6ag7I/FhCkWE15oXtONzuuHmC/GKJWx8wMu+5ubxrGVlK4nGmSI5+xgpG1FzTOSL74ALz4ZonddASqZ2U0KzVTr5lzDcAj/9n/NrEaeY61avyEsdf063XjetbUTce/JJISjCvXL9KBo0sFyEfB6iSU1J+dUGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cd8o/JWX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9SFkd008520;
	Tue, 30 Jan 2024 11:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cOyF71ZY3JMiVZ+p9yQdIi64ZLYnOwQpvamc553FQiA=; b=Cd
	8o/JWXiCy9Kh8DFNvr2PoSYQ3WA05dfGhBHyaJaI0d0HdKwuNnXYuept4EIOQ77F
	3N4QIlftsbY1uzq9ETnEi0dRheK/p59ZJjsA3afSPTVjqaeWXT+/pN8CTkqBGXB4
	gaJgT7z9tVrHxRt75hxLtzVtGSnM9TOam0QIfEGs0RLVbucK/n7KnAcd9UCoovWI
	aaHRYdnvi+uLoh/iMNy7oiWLeKx4NMYssXYzMNBaXleHIfLY3AkPAU31uZkSlpjx
	bmzNyLsNI3QprtBkxNyEbuOhy8zfwNMx7tURPa+GBUDC2bpbXGce6X122GGhokPU
	PDmyh2djQxVMjbn40dtg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvwqrdxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:11:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UBBtgG020014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:11:55 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 03:11:54 -0800
Message-ID: <a9e53f21-82f8-450e-bb73-84735e919bee@quicinc.com>
Date: Tue, 30 Jan 2024 16:41:51 +0530
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
 <307eaecc-fd88-4fd8-8857-dd3910257d34@quicinc.com>
 <52287b3162cf6632e7999216cf1ad97b2280b584.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <52287b3162cf6632e7999216cf1ad97b2280b584.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2qC37vywI74Xmo_47vVSIyXlVsG9t1ak
X-Proofpoint-GUID: 2qC37vywI74Xmo_47vVSIyXlVsG9t1ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300081

On 1/30/24 16:16, Johannes Berg wrote:
> On Sat, 2024-01-27 at 11:14 +0530, Aditya Kumar Singh wrote:
>> On 1/26/24 14:36, Johannes Berg wrote:
>>> On Thu, 2024-01-25 at 18:28 +0530, Aditya Kumar Singh wrote:
>>>> Currently whenever NL80211_CMD_DEL_STATION command is called without any
>>>> MAC address, all stations present on that interface are flushed.
>>>
>>> True.
>>>
>>>> However with MLO there is a need to flush the stations from a particular
>>>> link in the interface, and not from all the links associated with the MLD
>>>> interface.
>>>
>>> Fair enough, I can get behind that.
>>>
>>> Edit: reading the code - I think I misunderstand that ... you're
>>> actually trying to remove all MLDs ("STATION") that have an active link
>>> on this link?
>>
>> Yes correct. The station might not be MLD station. It could be a legacy
>> station (non EHT) as well.
> 
> We pretty much treat that the same though as an MLD station with a
> single link, with some caveats of translations, no?
> 

Yes correct!

>> Correct, for the first bring up not required but one use case I see is -
>> the hostapd interface was disabled for some reason. While going down, it
>> would have cleared the stations on the kernel but what if for some
>> reason kernel did not clear the station entries and there are some stale
>> entries present? So at next bring up (during enable) it would send the
>> command without any MAC address to flush all stale entries (probably as
>> a safety so that kernel and hostapd would now be on par).
> 
> I don't think this really makes much sense. The kernel can't keep track
> of those stations properly if they're there, and anyway that'd be a
> (pretty massive!) kernel bug?
> 

Yeah :). Even I haven't seen kernel not removing the entries while the 
interface was going down. Was just thinking out loud here. Tbh, even I 
don't know the exact reason it was written in that way. Was guessing.

> Anyway, I think there probably _is_ justification for this (link
> removal?), I'm just not sure this bringup flow really is a good
> justification.
> 

Yes we have.

>>>> Hence, add an option to pass link ID as well in the command so that if link
>>>> ID is passed, station using that passed link ID alone would be deleted
>>>> and others will not be removed.
>>>
>>> So first: Do you want some feature flag that indicates this? Or will we
>>> just eat the cost of kicking out everyone (without even sending deauth
>>> though, I think?) when running on older kernels?
>>>
>>
>> If what I said above was the actual intention, then kicking out everyone
>> without even sending deauth makes sense? Yes? If yes then we don't need
>> a feature flag.
> 
> Does it though? Even if you're talking about init, you could have init
> of one link much delayed for CSA, for example, with stations already
> connected on the other(s).
> 
hmm.. correct.

>>> Secondly: why is this part of NL80211_CMD_DEL_STATION? I'm not convinced
>>> that makes sense. I actually kind of get why you're doing that - it's
>>> easier to retrofit into the existing hostapd, but I don't necessarily
>>> think that the hostap design (problems?) should influence this too much.
>>>
>>> IOW, it would feel much more appropriate to have this as part of
>>> NL80211_CMD_REMOVE_LINK_STA? After all, when going to MLD then "STATION"
>>> now represents a "peer MLD", and "LINK_STA" now represents an affiliated
>>> STA. And flushing all affiliated STAs is what you want.
>>>
>>> So I think it should be NL80211_CMD_REMOVE_LINK_STA without a
>>> NL80211_ATTR_MLD_ADDR.
>>>
>>
>> At least as per the current way of NL80211_CMD_REMOVE_LINK_STA
>> implementation, it did not made any sense to delete all link STAs if
>> MLD_ADDR is not passed. So probably the command should be called as many
>> times as there are active links in the STA?
> 
> Not sure I understand this, we're doing a kind of flush here, so you
> could (conceptually) say "flush all link STAs on link 5", no? And
> obviously stations that have no link left after this need to be removed
> completely.
> 
> Note this raises an interesting point in mac80211, in that there's one
> link ('deflink', the link the STA used to assoc) that cannot be removed
> from an MLD station even.
> 

Good point :) I did not think about this. Let me think again how to 
handle this case. Thanks.


> But again this comes down to what you actually _want_, I think, so I'll
> keep reading for now.
> 
>> Still I feel that NL80211_CMD_DEL_STATION is the proper place to put
>> this? Without the current change also, it used to flush all STAs
>> whenever MAC address is not passed. With MLO, now we need to flush STAs
>> only if it is using the given link ID. So that link STAs from other
>> affiliated links of AP would not be flushed.
> 
> 
> Right so this is coming to the point where I wasn't sure earlier what
> you actually meant, and I'm still not entirely positive I've understood
> it. Let me read on ...
> 
>> Scenario I'm targeting is this -
>>
>> Pre-MLO
>> ----------------------------
>>
>> sdata -> 2 GHz AP interface
>> sta_lists ->
>> 	1. sta -> connected 2 GHz AP sdata
>> 	2. sta -> connected 2 GHz AP sdata
>>
>> After NL80211_CMD_DEL_STATION is given without any MAC address,
>>
>> sta_lists ->
>> 	No entry(ies)
> 
> Right.
> 
>> With MLO
>> -----------------------------
>> sdata ->
>> 	link_data -> 2 GHz AP link (link ID 0)
>> 	link_data -> 5 GHz AP link (link ID 1)
>> 	link_data -> 6 GHz AP link (link ID 2)
>> sta_lists ->
>> 	1. sta -> connected AP MLD sdata
>> 		link_sta 0 -> connected to 2 GHz link
>> 	2. sta -> connected AP MLD sdata
>> 		link_sta 1 -> connected to 5 GHz link
>> 	3. sta -> connected AP MLD sdata
>> 		link_sta 2 -> connected to 6 GHz link
>> 	4. sta -> connected AP MLD sdata
>> 		link_sta 0 -> connected to 2 GHz link
>> 		link_sta 1 -> connected to 5 GHz link
>> 		link_sta 2 -> connected to 6 GHz link
>>
>> Assume 5 GHz goes down and it gives NL80211_CMD_DEL_STATION without any
>> MAC address,
>>
>> sta_lists ->
>> 	No entry(ies)
>>
>> This is not desirable since 5 GHz link went down, why 2/6 GHz STA also
>> got flushed.
>>
>> Hence with the proposed change, only sta #2 and #4 would be flushed
>> since only these two are using passed link ID (which would be 1).
>> Hence after the command,
>>
>> sta_lists ->
>> 	1. sta -> connected AP MLD sdata
>> 		link_sta 0 -> connected to 2 GHz link
>> 	3. sta -> connected AP MLD sdata
>> 		link_sta 2 -> connected to 6 GHz link
> 
> Right, OK.
> 
> So you _are_ indeed wanting to remove all MLDs *entirely*, if they use a
> specific link.
> 

Yes correct.

> Agree that in this case, NL80211_CMD_DEL_STATION with link ID makes
> sense as implemented, but probably need to clarify a little bit overall
> that this is the operation, seeing how I was confused about whether you
> want to remove only the link STAs on on those links, or the entire MLD
> stations.
> 

okay sure, I will try to explain in the commit message as well as in 
code if needed.

> (and yeah, our terminology here is confusing and doesn't help either,
> but that's because we didn't rename STATION to MLD or something
> everywhere)
> 
>> Now, if ML re-config support is present, then hostapd (or the user space
>> controller for that matters), could first issue
>> NL80211_CMD_REMOVE_LINK_STA for the MLD STA (#4) and remove link sta
>> with ID 1 from it. So that when NL80211_CMD_DEL_STATION comes, it would
>> not remove the 2/6 GHz link STA as well from the MLD STA and hence flush
>> the whole entry.
> 
> Right, OK!
> But see above - that NL80211_CMD_REMOVE_LINK_STA as described here may
> or may not be possible today in mac80211.

Sure will check that.

> 
>> The above change is not there yet in hostapd, so for the time being,
>> whole MLD STA would be flushed.
> 
> OK.
> 
>>>> @@ -16827,6 +16840,9 @@ static const struct genl_small_ops nl80211_small_ops[] = {
>>>>    		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>>>>    		.doit = nl80211_del_station,
>>>>    		.flags = GENL_UNS_ADMIN_PERM,
>>>> +		/* cannot use NL80211_FLAG_MLO_VALID_LINK_ID, depends on
>>>> +		 * MAC address
>>>> +		 */
>>>>    		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
>>>
>>> Hmm? How does NL80211_FLAG_MLO_VALID_LINK_ID depend on the MAC address?!
>>> It ... doesn't?
>>>
>> I mean intention was that if MAC addresses is passed then no need of
>> link ID. That is why did not add the valid link flag since it would
>> expect the link ID even when MAC address is passed.
>>
> 
> Ah, OK, that makes sense.
> 
> Maybe rephrase that comment? I was also thinking of just refactoring the
> logic into a helper function, but that may be difficult, not sure. It
> just looked similar.
> 

Sure, I will see what I can do here. Thanks for your inputs. Will send 
v2 soon :)



