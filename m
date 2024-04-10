Return-Path: <linux-wireless+bounces-6126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE3C89FD5E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 18:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5988D1F282FD
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E91A17BB02;
	Wed, 10 Apr 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pQlmwK6d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5B17B50C
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767486; cv=none; b=PPd+rJLAEuo0kOybiJ4+CS8hOl1a3KYxgc3LCwPBn7Xvi5j5MOJFJM+yKIGiNvwkYtZUoe0fVGHg47KaIqaW/euklkE7KVHKMWXIMd8uWdVdHqp1XZmi6aLAznhAW5Z9ccDFJ0rwX+yJFMpA0AZHPOraFpFD5+ZaiWzlRv08GjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767486; c=relaxed/simple;
	bh=7AfnkYRRdGWP5zy0kZZAOE6zwhGmSCl/vGVNYc/0bL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QYDM4gl+Yugoa3B4jS+hCRsEsB8Ha+UH3VfzsMFzSJagsq8DFkdmdDZszEmCN6kxisMGZAnzCZsXW0B789Ri3FGSAWM70/EdJuWApIUS/QHuWl5t5fEegM8pIKD1LnqDBoxcG9oA7BvugQZFOHIEySnHSZXxY9mTNw6T4YHwie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pQlmwK6d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ABqRqV026347;
	Wed, 10 Apr 2024 16:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DVcdRZ6eqz+T3w22YHI59T7kAHIRAD7xVI8539GYqXI=; b=pQ
	lmwK6decJ2Npp0PDXMh3/PJsO82k+/9NVgW7yRL0HH8bAf6uRE1/y2sOG72Shmtn
	03hc2YKWw5hdhDJl3gyJ/wIS2/0W4aKXo2HMJq2gjnxSAFC13nLg4eglSxPi7vFG
	XXgm14zlIMf6q/OqnCTY0sDBM8GRYXY0PGDDccR277zGP1MmIeuSaH+c0PXr19Cw
	Ss/JeleuZc3SeinUODbsNqJwY2nxNzzeJFQf/Ku6QHx1oL9LtiERVptb0sOOQT7j
	BI9kj1AAW+lhytNN9pIgqktF29LFkepkQ27v95Vfpi1ILEuHoEFbXjQd8ILpgoqu
	5O+dDaNk0ETiPV0biNag==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdjtmv41x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:44:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AGi0IB018974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:44:00 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 09:44:00 -0700
Message-ID: <0cfe990b-182b-4ceb-b5b4-2989fefedb2f@quicinc.com>
Date: Wed, 10 Apr 2024 09:43:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
 <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
 <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
 <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B91KCFTd9RwWLgkAcKdn3SK7FDjhGDo4
X-Proofpoint-ORIG-GUID: B91KCFTd9RwWLgkAcKdn3SK7FDjhGDo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=783
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404100123

On 4/10/2024 9:23 AM, Ben Greear wrote:
> On 4/10/24 08:42, Johannes Berg wrote:
>> On Wed, 2024-04-10 at 07:37 -0700, Ben Greear wrote:
>>> On 4/10/24 00:56, Johannes Berg wrote:
>>>> On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
>>>>> On 3/29/24 07:30, Johannes Berg wrote:
>>>>>> On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
>>>>>>>>
>>>>>>>>> + * @hw_chans: list of the channels supported by every constituent underlying
>>>>>>>>> + *	hardware. Drivers abstracting multiple discrete hardware (radio) under
>>>>>>>>> + *	one wiphy can advertise the list of channels supported by each physical
>>>>>>>>> + *	hardware in this list. Underlying hardware specific channel list can be
>>>>>>>>> + *	used while describing interface combination for each of them.
>>>>>>>>
>>>>>>>> I'd expect there to be a limit on channels being within a single band on
>>>>>>>> a single "hardware"?
>>>>>>>>
>>>>>>>
>>>>>>> There are ath12k hardware supporting multiple band which need to be
>>>>>>> registered under one mac80211_hw/wiphy. This design is to support such
>>>>>>> hardware.
>>>>>>
>>>>>> Oh OK, that was something that I didn't have in mind any more, or never
>>>>>> knew or paid attention to.
>>>>>
>>>>> Would it work to leave the phy reporting pretty much as it is now, but add
>>>>> a 'associated_peer_radios' list section, so that each phy could report the phys
>>>>> associated with it?  Then user-space, driver, mac80211 etc could look up the
>>>>> other phys as needed to get a full picture?
>>>>>
>>>>
>>>> There's not really a good way to _do_ that short of creating multiple
>>>> wiphys, but that causes _massive_ complexity in the stack (both cfg80211
>>>> and mac80211) so we rejected it years ago.
>>>
>>> I thought the problem ath12k is trying to fix is that there are currently multiple phys (radios) that needed to be made to
>>> look like a single phy?
>>
>> Correct.
>>
>>> For dual and tri-concurrent radios, I think we will need them to look like 3 individual radios for non-MLO use
>>> cases
>>
>> No, I don't see why, and if you want that we wouldn't support it anyway,
>> you'd have to have a module option or something to decide which way to
>> go.
>>
>> But it really ought to not be needed - the point of these patches is to
>> give userspace enough information to know how to (and where) to create
>> separate BSSes, with or without MLO between them.
> 
> If phy0 told user-space that phy1 and phy2 were 'mlo peers', and phy1 and phy2
> gave similar mapping, couldn't user-space just notice the peer group and then
> have all the info it needed without the bulk of the patch set in question?
> 
> So then if hostapd wants to have 3 radios in an mlo grouping, it can do so.
> 
> And if instead it wants three old-style wifi-6 AP interfaces, it could do that
> as well.  I don't see why it would need any module option, and I also do not
> see why it could not do both behaviours concurrently (one BSSID being MLO, second one
> being non MLO, for instance).
> 
>>> For instance, mt7996 currently reports 3 single-band wiphys, and each can be used independently.
>>> But assuming it starts supporting MLO, then those 3 single band wiphys will need to start acting
>>> at least somewhat like a single entity
>>
>> Yes.
>>
>>> (while also concurrently being able to act as individual
>>> wiphys so that one can do a mix of MLO and non MLO sta/AP.)
>>
>> No.
> 
> How will you allow all three bands/phys to host bssids that can talk to
> wifi-6 and earlier stations if there is only a single phy seen by hostapd?
> 
> I definitely want to put STA vdevs on the three individual 7996 phys and have them
> be able to talk to non MLO APs. This currently works.
> 
> I suspect other use cases, such as meshing with non MLO APs may also want
> this sort of ability.
> 
> Thanks,
> Ben
> 

Ben, the patches we have posted so far allow ath12k to either have each phy
assigned to a separate wiphy (legacy operation) or have multiple phys assigned
to a single wiphy (required for MLO operation). In an upcoming patch we'll
introduce a DT-driven mechanism to perform the mapping of phys to wiphys. So
the goal is to be able to support both modes of operation.

/jeff

/jeff

