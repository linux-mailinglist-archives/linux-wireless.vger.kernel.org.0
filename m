Return-Path: <linux-wireless+bounces-3532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5506C8530B1
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C16A281DC0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FD143AD6;
	Tue, 13 Feb 2024 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d1iUs7ve"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E040BFE
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828120; cv=none; b=LMObXNP7/YvoEuKlHi+uWcPy0uHYclMYx99HYFQbhffYVn5iWETk1zhF7cU2a+i742EDOtqsSF0v4z3NM8sIlr0M5Y6KZFL/bVn4kjGd5sv+y8I4O8wGKUde0kuCgbK0yJqXv+0t7Rd8kwtHf6Jqu8/DExn4OysBzkcKdeTd19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828120; c=relaxed/simple;
	bh=aIr/HJaRhxEaE0JhF2bNjSkQ5hh0/JSjwnVZoJIMIeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dw3NtDHV/ZlJOkYSZ8dLjHkmw13UoQQe5FyBvP6dT+eYLw+C2JBVh1Kz5Ps8ea2CdbWZPuYjZM2IxCghs4f7N6IFUScgUbmRc/8SELmH0uUHNvQ+Wu8d4qWuJNBDsIphRZ46YSwGHHIpe/JWT9Rv+dytB/h9G/BOVcDb/9YZcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d1iUs7ve; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D6QHmA014021;
	Tue, 13 Feb 2024 12:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=U/KetsFy7eqFliG6BF0F6zQ1d5ow562NqrtnGX07+X4=; b=d1
	iUs7veDMOL90Krl2hr+khoSPmt/m/PQWGJR5bmLVwZbf3ZQ3wuSlZ9JJ2svtz2pd
	yLtVjm/uHcr8W5q86jB0abJCfgjnT40vcaTPLZVRCPP7KVBfddyV1xKB4M0dLUDw
	coXSW26wDArVlHM3kjpvq2OQALczr1zC1cYjhyisxa1qtSkzqB5BuhoourFW8P3g
	gzGY0i0wDqMUHa1eUqshxsoCkM5M7a9r4jnNeCdy9zK/Tmy4ByNGEmnGoPydpIcy
	CvAh5os4+0yvHVD2/oXVvLAtv4m9V7WiGPE91rvXCCMH7rtH4s+LFRIbYzBCzkKK
	liiSaBZzCWx63ETProTg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7s391pyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 12:41:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DCfi9Y004276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 12:41:44 GMT
Received: from [10.216.58.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 04:41:40 -0800
Message-ID: <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
Date: Tue, 13 Feb 2024 18:11:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, Jouni Malinen
	<j@w1.fi>,
        Ping-Ke Shih <pkshih@realtek.com>, Ryder Lee
	<ryder.lee@mediatek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
 <20240130140918.1172387-5-quic_adisi@quicinc.com>
 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aPT-oqmJWE-gku6kyjWnDLXwbxZ90irs
X-Proofpoint-GUID: aPT-oqmJWE-gku6kyjWnDLXwbxZ90irs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402130100

On 2/13/24 16:25, Johannes Berg wrote:
> On Tue, 2024-02-13 at 15:48 +0530, Aditya Kumar Singh wrote:
>> On 2/13/24 14:12, Johannes Berg wrote:
>>> On Tue, 2024-02-13 at 10:46 +0530, Aditya Kumar Singh wrote:
>>>> On 2/12/24 20:16, Johannes Berg wrote:
>>>>> So ... I'm looking at the client side, and thinking about that.
>>>>> According to the spec, multi-link element should be present in beacons
>>>>> of APs affiliated with the same MLD if one of the (other) links is doing
>>>>> CSA, and then have also the CSA counters of course, relative to the
>>>>> target link's TBTT (of course.)
>>>>
>>>> Yes correct, you are referring to critical update(s) right?
>>>
>>> I was actually thinking the critical update flag is rather not all that
>>> interesting, but the inclusion of the CSA-related elements in a
>>> (partial) per-STA profile in the Multi-Link Element is. Those contain
>>> the countdown fields, so need to be updated - according to the TBTT of
>>> the link doing the CSA, not the link sending it.
>>>
>>
>> Yes correct, this CSA thing is interesting but there is one more thing -
>> handling of the BSS param change count (BPCC). Let's say the affected
>> link undergoes CSA, then in its Basic Multi Link IE, BPCC should be
>> incremented. But at the same time, in RNR of its partner links, where
>> this affected link is there, the BPCC should also be incremented.
>> All though here it is not incremented with every beacon Tx, but still
>> change in one affects beacon of other partner link(s) at least once.
> 
> Yes, I know, but IMHO that's not all that interesting, I'd think hostapd
> could handle that.
> 
>>> Note that I'm basically asking you, Mediatek and Realtek how this should
>>> work. We're almost certainly not going to support multi-link AP in our
>>> device any time soon, and we could adjust the firmware to it anyway if
>>> needed.
>>>
>>> So while I agree that punting it to firmware would be somewhat nice, we
>>> still have to agree on (a) or (b), because (b) requires more information
>>> from hostapd etc., but (a) requires _substantially_ more (and very
>>> complex) parsing in firmware... If you wanted to support multi-BSSID,
>>> then it's even more complex, which would argue for (b)?
>>>
>>
>> Correct. Both has got its own advantages and disadvantages. Need to
>> agree on any one so that all can be benefited. Let's hear from other folks.
> 
> Do you _have_ firmware for this already, perhaps?
> 

Yes, private firmware is there. Not yet upstreamed since the 
infrastructure in mac80211 and driver is not there. AFAIK it is in 
pipeline. Internal testing have so far been good and did not see any 
issues. So at least from Qualcomm perspective, we are fine with 
offloading (the above we discussed) to firmware.


> I mean, I'm happy to be designing this "greenfield", but ... it seems
> unlikely at this point?
> 
> Also what about ath12k with the multi-device changes, would the driver
> have to handle it? Or I guess you have to sync the TSF somehow anyway,
> so you could handle it based on TSF/TBTT?
> 

Ath12k firmware also supports beacon offload and hence firmware is 
taking care to add the respective IEs in per-STA profile of the 
reporting links while host just sends the template for the affected link 
via beacon template update and indicating that critical update has happened.

> 
>>> I was trying to keep opinions out of this, but personally, I really
>>> don't like (a), it puts too much complexity in the hands of firmware
>>> engineers ;-)
>>>
>>>> Firmware could maintain the counter (for the affected link) and (I
>>>> assume it will be aware of the partner links) so whenever partner link
>>>> transmits a beacon it could add the CSA (or such IEs) in per STA profile
>>>> of the reporting link. It could get the contents from the affected link
>>>> but actual value of the counter could be filled from the global counter
>>>> being maintained. But not sure whether we can force every driver's
>>>> firmware to do so?
>>>
>>> I'm not sure I understand that description - how would firmware even
>>> know which elements to take from what partner link etc.? I think hostapd
>>> still has to add the elements, and firmware would just populate the
>>> counter field(s)? But yeah that requires knowing from which partner link
>>> to populate.
>>>
>>
>> Yeah so underlying assumption/thought was -
>> 1. Firmware is aware of partner links
> 
> Sure.
> 
>> 2. Host driver just needs to update the beacon template of the affected
>> link and some how indicate to firmware that this is critical update.
> 
> Sure.
> 
>> 3. As per spec, there are around 21-22 changes classified as critical
>> update and among those only handful of those which has adding the IE in
>> per STA profile. So firmware could possibly maintain a table to see if
>> the affected link's beacon template has such IEs which if present needs
>> to be added in partner links, it could add it as and when partner link
>> transmits a beacon.
> 
> That seems messy for all the reasons I mentioned, since it involves
> parsing/defragmenting/merging/fragmenting per-STA profiles etc.
> 
> Do you really want to go there?
> 

I understand things looks to be messy. But at least internally we have 
done in that way and things look simpler (on kernel level). Not sure 
whether all firmwares would agree to that.

>> 4. Once CSA is finished, the host would update the beacon template which
>> will not have CSA/ECSA IE... such IEs. Then firmware can stop adding to
>> per STA profile as well of the reporting links.
> 
> Yeah I guess that's just a corollary of 3 :)
> 
>> But yeah adding to per STA profile when already elements are there and
>> then first de-fragment and then add and then later fragment would be a
>> tedious job :)
> 
> Yeah...
> 
>>> If you really wanted the firmware to handle the partner link information
>>> completely it'd not only have to parse the Multi-Link Element on other
>>> links but also _modify_, and know what to do, etc. - I don't think
>>> that'll really work so well.
>>>
>>> Think about it some more: On the link doing the CSA you'd have to parse
>>> the beacon template and understand where the CSA-related elements are
>>> (CSA, ECSA, Channel Switch Wrapper, possibly more?), and copy them
>>> aside. Then on the partner link(s) parse the Multi-Link Element, see if
>>> there's a partial STA profile already for some reason, merge the CSA-
>>> related elements into that, update the counters; all while first
>>> removing the 2 levels of fragmentation, and then re-doing them ...
>>>
>>
>> Yeah complex on firmware level. But even if we solve this on kernel
>> level, existing drivers who have offloaded beacon to firmware from 11ax
>> or before itself, still need to handle it? It would looks ugly that till
>> 11ax it is offloaded and from 11be it is again put back to kernel?
> 
> Not sure what you mean here - we can still offload beaconing with a
> template, just have to fill in the template a bit more (with partner
> link CSA counters rather than just own CSA counters)?
> > I'm basically thinking this:
> 
> 1. Firmware is aware of partner link CSA counters/TSF offset/TBTT
> 
> 2. Host driver (hostapd) sets beacon template of affected link to
> include CSA elements, and already today we include in the setting the
> offset to the countdown fields, so it doesn't matter where those are.
> 
> 3. Host driver (hostapd) *also* updates beacon templates of partner
> links, but instead of saying "here's the CSA counter to update" it says
> "here's the CSA counter for your partner link M to set" (OK, so there
> potentially are multiple of those, but that's OK)
> 
> 4. Firmware doesn't need to parse anything, it just needs to go through
> the beacon when transmitting it (for any link) and set the CSA counter
> fields for the link itself and/or for the partner links according to
> what the correct counter is per TBTT rules, TSF offset, beacon interval
> etc.
> 

Hmm.. I see your point. So basically there is tradeoff - complexity of 
handling the parsing and all in firmware or complexity of handling those 
many offsets in kernel. I believe when hostapd updates the templates for 
the partner links, it would have to send offsets so we may need to 
extend our NL infrastructure for MLO in order to accommodate all those 
list of offsets during beacon template update.

> 
> Note that this could easily be implemented even in software for hwsim or
> drivers that don't offload beacon template to the device (like ath9k
> though obviously that has no multi-link), *iff* you know the TSF offset
> and TBTT of the beacon being created.
> Currently the CSA counters are just decremented every time you request a
> beacon, but the partner link counters would have to be calculated - but
> if you know
>   - the intended TBTT of the beacon to transmit
>   - the TSF offset to the link undergoing CSA
>   - the beacon interval of the link undergoing CSA
> you can calculate
>   - the TSF of the link undergoing CSA at the TBTT of the beacon we're
>     creating,
>   - the previous TBTT of the link undergoing CSA by the TSF (some
>     calculation involving TSF modulo the beacon interval)
>   - therefore the CSA counter of the link undergoing CSA to fill in
> 
> In hwsim it's even easier because we only request the beacon at the
> TBTT, and the TSF offset is 0 ...
> 

Yep, agree.

