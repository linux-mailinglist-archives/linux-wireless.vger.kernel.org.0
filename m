Return-Path: <linux-wireless+bounces-3524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4CB852DB5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 11:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD011B27028
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0A225D2;
	Tue, 13 Feb 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oJLYkq2g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D10225CF
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819508; cv=none; b=sG80AohcSwDcWi57MdyoGqSuW7sh+muGwqds8gpBRkSReGtoSSI0e5wIAC694rPSTmPj8Lm9pSXfEQssDXtTF0JtTLR2hjHthEykyt/7oSau1ejofRLPO4qSKDIZrOr/CpTHKvFFZ7MWGK8mVhmwmZ6C+Jf8c/C9mFSKr/kd7Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819508; c=relaxed/simple;
	bh=n9wGJdijYAozAXxgkyFQCpoAMQDV+lyeIl70Kp0R+1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s03ArYcl+2wjg+7+EPIvNqIpPKNap2FkXsKCC1ZzVPCWuGbwxSbsdNLf37fMlnkeAkNdpmYU7Un/oigmkMnag6IxeXwHhOw+x2IkBLkOt/+IdjyiWwi0jvkbQhcb3qFLZ4D2uAEqAMk8PBmZnzJbipiLzU8GZd4RZx81ql5cIxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oJLYkq2g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D9TBoj026957;
	Tue, 13 Feb 2024 10:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=a6rey6KF36Q+MG51A51CqJ0hUW3qz4YXTYrKcbvvOGM=; b=oJ
	LYkq2gdZEvSmKzgD3eaCLVCy9OWn96JzKhK2hjLnk/ICXI5e8wS4u8A32USwDsTu
	m7qV01vAMmWyHbGwyVl4yQixK/e/x8Es7J3C8Gis7N4YgPNEFutlo1cmwsuRPC7T
	ySjZW6O9sl9mLCqaQ9H/2Jt5QzbKbx6iJSgRrTi8Tyn9KSiC//hj6f5BivjnEKbT
	AanK4sPmEZlZvklHZMxBaBCJN04n7jQtrzdb7h2K7m04PM/7af5sEycWmk1Rk2fp
	UkHP/fKl18rPb+VSphcm5QmsxZHWfGEa7SUKKGVrWyXTvulpndcAdV1eQFcYEGuR
	z3Deet/qW+7MNgeBIuzA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gse2n1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:18:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DAIDSP031289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 10:18:13 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 02:18:11 -0800
Message-ID: <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
Date: Tue, 13 Feb 2024 15:48:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
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
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ejAdLbQex41F6O8mSdH8C5GbjFOShoZz
X-Proofpoint-ORIG-GUID: ejAdLbQex41F6O8mSdH8C5GbjFOShoZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130081

On 2/13/24 14:12, Johannes Berg wrote:
> On Tue, 2024-02-13 at 10:46 +0530, Aditya Kumar Singh wrote:
>> On 2/12/24 20:16, Johannes Berg wrote:
>>> So ... I'm looking at the client side, and thinking about that.
>>> According to the spec, multi-link element should be present in beacons
>>> of APs affiliated with the same MLD if one of the (other) links is doing
>>> CSA, and then have also the CSA counters of course, relative to the
>>> target link's TBTT (of course.)
>>
>> Yes correct, you are referring to critical update(s) right?
> 
> I was actually thinking the critical update flag is rather not all that
> interesting, but the inclusion of the CSA-related elements in a
> (partial) per-STA profile in the Multi-Link Element is. Those contain
> the countdown fields, so need to be updated - according to the TBTT of
> the link doing the CSA, not the link sending it.
> 

Yes correct, this CSA thing is interesting but there is one more thing - 
handling of the BSS param change count (BPCC). Let's say the affected 
link undergoes CSA, then in its Basic Multi Link IE, BPCC should be 
incremented. But at the same time, in RNR of its partner links, where 
this affected link is there, the BPCC should also be incremented.
All though here it is not incremented with every beacon Tx, but still 
change in one affects beacon of other partner link(s) at least once.


>>> Theoretically, both mac80211 and hostapd today support different beacon
>>> interval on different links, I believe.
>>>
>>> This makes the whole thing of including CSA for link A on beacons/probe
>>> responses transmitted on link B very tricky, because you have to know
>>> the timing, etc.
>>
>> At least handling for probe response seems to be a bit easier since
>> there we need not maintain any timer as such (as you have said too - we
>> need not be perfect there).
> 
> OTOH, if we already need some infrastructure for beacons, we can also
> use that infrastructure to fill in probe responses? Might be easier
> overall, because otherwise you'd have to start timers in hostapd etc. if
> you actually wanted to fill that in hostapd, and that's messy ...
> 

Correct!

> And as a complete aside: link removal _also_ has a countdown, but I'm
> not sure that affects cross-link, but if it does we might want a more
> general cross-link counter infrastructure? Though that might not mesh
> well with how (your) firmware handles it?
> 

Yes.

>> But beacons, as you said, it is indeed bit
>> tricky to handle full support considering both links could beacon at
>> different intervals.
> 
> Indeed.
> 
>>> For the CSA counter of a link _itself_ we have counter_offsets_beacon
>>> and counter_offsets_presp (for probe response offload) in struct
>>> cfg80211_csa_settings, and also counter offsets in struct
>>> cfg80211_mgmt_tx_params for sending probe responses.
>>>
>>> But ... for the cross-link information in the MLE this gets way more
>>> tricky? Especially if the beacon interval is different - we couldn't
>>> just count down, we'd have to fill in the information when we know where
>>> the frame is transmitted. For probe responses maybe we can afford to not
>>> be perfect, but for beacons it better be right - so we have to calculate
>>> the right counter value(s) for (all of) the switching link(s) according
>>> to the current TSF, TSF offset and TBTT - not all of which we even have
>>> in the driver?
>>>
>>
>> Yes correct :)
> 
> :)
> 
>>> I can see a few ways of implementing this:
>>>
>>>    a) Punt to firmware and it parses the multi-link element etc. to
>>>       find the places to update. But that's awful, it requires parsing
>>>       possibly fragmented MLE with fragmented subelements containing the
>>>       CSA elements inside ...
>>>
>>>    b) Punt to firmware and give it a (possibly long) list of offsets K_N
>>>       where to put the N'th counter for link K when transmitting the
>>>       frame.
>>>
>>
>> At least for beacons if firmware takes care of it then it will be good.
> 
> Note that I'm basically asking you, Mediatek and Realtek how this should
> work. We're almost certainly not going to support multi-link AP in our
> device any time soon, and we could adjust the firmware to it anyway if
> needed.
> 
> So while I agree that punting it to firmware would be somewhat nice, we
> still have to agree on (a) or (b), because (b) requires more information
> from hostapd etc., but (a) requires _substantially_ more (and very
> complex) parsing in firmware... If you wanted to support multi-BSSID,
> then it's even more complex, which would argue for (b)?
> 

Correct. Both has got its own advantages and disadvantages. Need to 
agree on any one so that all can be benefited. Let's hear from other folks.


> I was trying to keep opinions out of this, but personally, I really
> don't like (a), it puts too much complexity in the hands of firmware
> engineers ;-)
> 
>> Firmware could maintain the counter (for the affected link) and (I
>> assume it will be aware of the partner links) so whenever partner link
>> transmits a beacon it could add the CSA (or such IEs) in per STA profile
>> of the reporting link. It could get the contents from the affected link
>> but actual value of the counter could be filled from the global counter
>> being maintained. But not sure whether we can force every driver's
>> firmware to do so?
> 
> I'm not sure I understand that description - how would firmware even
> know which elements to take from what partner link etc.? I think hostapd
> still has to add the elements, and firmware would just populate the
> counter field(s)? But yeah that requires knowing from which partner link
> to populate.
> 

Yeah so underlying assumption/thought was -
1. Firmware is aware of partner links
2. Host driver just needs to update the beacon template of the affected 
link and some how indicate to firmware that this is critical update.
3. As per spec, there are around 21-22 changes classified as critical 
update and among those only handful of those which has adding the IE in 
per STA profile. So firmware could possibly maintain a table to see if 
the affected link's beacon template has such IEs which if present needs 
to be added in partner links, it could add it as and when partner link 
transmits a beacon.
4. Once CSA is finished, the host would update the beacon template which 
will not have CSA/ECSA IE... such IEs. Then firmware can stop adding to 
per STA profile as well of the reporting links.

But yeah adding to per STA profile when already elements are there and 
then first de-fragment and then add and then later fragment would be a 
tedious job :)


> If you really wanted the firmware to handle the partner link information
> completely it'd not only have to parse the Multi-Link Element on other
> links but also _modify_, and know what to do, etc. - I don't think
> that'll really work so well.
> 
> Think about it some more: On the link doing the CSA you'd have to parse
> the beacon template and understand where the CSA-related elements are
> (CSA, ECSA, Channel Switch Wrapper, possibly more?), and copy them
> aside. Then on the partner link(s) parse the Multi-Link Element, see if
> there's a partial STA profile already for some reason, merge the CSA-
> related elements into that, update the counters; all while first
> removing the 2 levels of fragmentation, and then re-doing them ...
> 

Yeah complex on firmware level. But even if we solve this on kernel 
level, existing drivers who have offloaded beacon to firmware from 11ax 
or before itself, still need to handle it? It would looks ugly that till 
11ax it is offloaded and from 11be it is again put back to kernel?

> I'm not even sure how I'd implement that in hwsim, and there I already
> have all the helper functions and pretty much unlimited memory/code
> size, so doing it in firmware seems awful?
> 

Yes.

> Not to mention that it would never extend for future stuff, since new
> elements wouldn't be copied over, firmware wouldn't necessarily know the
> right order to merge them with existing elements in the per-STA profile,
> etc.
> 

Yeah so if we go with handle on firmware level, as and when spec 
changes, firmware changes are required too.

> 
>> Let aside actual drivers, adding the test case for mac80211_hw_sim would
>> also be tricky since there beacon Tx is handled in software only.
> 
> Yeah but that's easy, especially if we go with (b) approach, even
> mac80211 basically has all the necessary information to handle hwsim's
> model of beacon transmission, we could add a little bit of additional
> help there too (e.g. pass the TBTT to beacon_get).
> 
>>>    c) Require the get_tsf operation and add an operation to retrieve TSF
>>>       offset (**), and then calculate the TBTT for each link when
>>>       beacon_get is called with the per-link beacon intervals and update
>>>       the values correctly if CSA is in progress on any link ... requires
>>>       against parsing like in (a) or offset information like in (b), but
>>>       at least now it's in software?
>>>       For probe responses this could be a bit off I guess, but maybe that
>>>       doesn't matter as much - probe responses are not authenticated so a
>>>       client probably shouldn't use them for real CSA anyway.
>>>
>>>       (**) which I guess we need anyway for hostapd to put it into beacons
>>>       etc.?
>>
>> Yes I'm too anticipating hostapd changes to support the critical update.
> 
> Oh hostapd will have to make changes here for everything - the (**)
> footnote was about how hostapd knows the TSF offset between links?
> Unless we're planning to always keep the TSF offset zero?
> 
>>> Do you have any plans for any of this?
>>
>> I do have some idea (possibly half baked code) for handling critical
>> updates in probe responses. Beacons, I assume firmware takes care hence
>> I have changes to mark it in the link_conf so that drivers could read
>> that and give it to its firmware.
>> Handling in beacon at kernel level, I need to think of it since anyways
>> hw_sim test case is good to have :)
>>
>> Do we have any data right now, how many actual drivers have offloaded
>> beacon Tx to its firmware (at least those who are supporting Wi-Fi 7)?
>> If we could see majority are using firmware then we could first add
>> support for such drivers then we can think about handling it in kernel?
> 
> I agree that we can go with one approach for now, but I think we should
> agree on the first model of how firmware does this. I'm not convinced
> that your description above where firmware even magically handles
> propagating the CSA elements to partner links will really work? But see
> above.
> 
>>> I'm mostly asking right now because I want a reliable way to test the
>>> work I'm trying to do on the client side though, so I could also live
>>> with some hacks (inject through debugfs?), but having it for real would
>>> be nice.
>>
>> Okay. I'm right now working to add basic test case in hw_sim for MLO CSA
>> (on first link) as we discussed. There is need of a few mac80211 changes
>> in order to support for other links. I'm checking those now. Once done
>> with these, then I'll take up critical updates.
>>
>>
>>



