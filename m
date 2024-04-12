Return-Path: <linux-wireless+bounces-6257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1129C8A30B7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D7B1C21EB5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DE113BACC;
	Fri, 12 Apr 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KJys+b6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2567613AD1C
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932326; cv=none; b=gu34AA6KbEkt3qszd+P3wsTOyrQtrN8yOIVsa+LiedUpyu3LyzDQdi27NbGPFc8XrfihAgcYKSC993olZculXfS0Dw14nsVg96R8P82hxZYLMCVfwelp7WeBgFNB5nUjXD0VmpO3ZXAKS/iTWuxgzoaNbw3SuvVTUvT+XnJRdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932326; c=relaxed/simple;
	bh=udFsBLe0yjdugxDeTX8oFKUsgcz/1hJEsODAS8xngiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iLqbpRXRhAbpmhYfIkFVpK04KDSuvHIEO9PHHkhdHsI2B0CUD++dgMF2CY42Ymzy/Rm8aN42152uoW4sljtiXwBtQNTAkKRFeG+kuVaYpT7Rhe33RVd0mHihKXnetgflRYWia0AIj4l1fU1gV2WaWyllWjfRShbF++dxXsq74Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KJys+b6Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CCq57B022897;
	Fri, 12 Apr 2024 14:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=grh9w8fkAtKE/sJUoPqydvr/JSiuHGgn68RddSsdcEM=; b=KJ
	ys+b6QNTqPOBmJ6O6F+peQgNDKZNF5Ifl4HokgqWG69V3GyFum7S73ljAwKrFmu5
	lcxlCUeMvxhVcZJxQYnQ852kndGp79DbhSeFJU7kPaBdN2tQLWUC/LbcXsOD638Q
	/E/KAwhn2KxMhywloAJQ1WDHOhoyMkiQVXCOUDcrY+BwyI38qbvQk1osiQgJh52c
	GgCKUzkQ/R06WNaxBHtlxwhjDx9CcukJgLtuo6GVwPiNN1errWUtfdZUnH2FpnBh
	JKYdIE3tzy3zzME44Ga230Tr+VwWYli7xvFAqexS4OXNiR7ibgD/0/7hs7+jZnA1
	zALw+N0a7bzlLvoLFAlA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xewr3966x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:31:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CEVsmY028514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:31:54 GMT
Received: from [10.216.26.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 07:31:51 -0700
Message-ID: <31aa6b18-8ca4-e4ce-f693-e818fc7e6932@quicinc.com>
Date: Fri, 12 Apr 2024 20:01:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
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
 <72f491f8-dd3a-0c9e-7490-4d51c86f2102@candelatech.com>
 <cb991a00-fce2-5a3d-c03f-579b44f922f5@quicinc.com>
 <87de72e9-1d3b-b401-a712-9fe8734515b6@candelatech.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <87de72e9-1d3b-b401-a712-9fe8734515b6@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wa-A6Ywbxn5pPrsKmItSRbxF8yqI7WG5
X-Proofpoint-GUID: wa-A6Ywbxn5pPrsKmItSRbxF8yqI7WG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120105



On 4/12/2024 7:38 PM, Ben Greear wrote:
> On 4/11/24 21:11, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 4/11/2024 2:33 AM, Ben Greear wrote:
>>> On 4/10/24 08:42, Johannes Berg wrote:
>>>> On Wed, 2024-04-10 at 07:37 -0700, Ben Greear wrote:
>>>>> On 4/10/24 00:56, Johannes Berg wrote:
>>>>>> On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
>>>>>>> On 3/29/24 07:30, Johannes Berg wrote:
>>>>>>>> On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
>>>>>>>>>>
>>>>>>>>>>> + * @hw_chans: list of the channels supported by every constituent underlying
>>>>>>>>>>> + *    hardware. Drivers abstracting multiple discrete hardware (radio) under
>>>>>>>>>>> + *    one wiphy can advertise the list of channels supported by each physical
>>>>>>>>>>> + *    hardware in this list. Underlying hardware specific channel list can be
>>>>>>>>>>> + *    used while describing interface combination for each of them.
>>>>>>>>>>
>>>>>>>>>> I'd expect there to be a limit on channels being within a single band on
>>>>>>>>>> a single "hardware"?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> There are ath12k hardware supporting multiple band which need to be
>>>>>>>>> registered under one mac80211_hw/wiphy. This design is to support such
>>>>>>>>> hardware.
>>>>>>>>
>>>>>>>> Oh OK, that was something that I didn't have in mind any more, or never
>>>>>>>> knew or paid attention to.
>>>>>>>
>>>>>>> Would it work to leave the phy reporting pretty much as it is now, but add
>>>>>>> a 'associated_peer_radios' list section, so that each phy could report the phys
>>>>>>> associated with it?  Then user-space, driver, mac80211 etc could look up the
>>>>>>> other phys as needed to get a full picture?
>>>>>>>
>>>>>>
>>>>>> There's not really a good way to _do_ that short of creating multiple
>>>>>> wiphys, but that causes _massive_ complexity in the stack (both cfg80211
>>>>>> and mac80211) so we rejected it years ago.
>>>>>
>>>>> I thought the problem ath12k is trying to fix is that there are currently multiple 
>>>>> phys (radios) that needed to be made to
>>>>> look like a single phy?
>>>>
>>>> Correct.
>>>>
>>>>> For dual and tri-concurrent radios, I think we will need them to look like 3 
>>>>> individual radios for non-MLO use
>>>>> cases
>>>>
>>>> No, I don't see why, and if you want that we wouldn't support it anyway,
>>>> you'd have to have a module option or something to decide which way to
>>>> go.
>>>>
>>>> But it really ought to not be needed - the point of these patches is to
>>>> give userspace enough information to know how to (and where) to create
>>>> separate BSSes, with or without MLO between them.
>>>>
>>>>> For instance, mt7996 currently reports 3 single-band wiphys, and each can be used 
>>>>> independently.
>>>>> But assuming it starts supporting MLO, then those 3 single band wiphys will need to 
>>>>> start acting
>>>>> at least somewhat like a single entity
>>>>
>>>> Yes.
>>>>
>>>>> (while also concurrently being able to act as individual
>>>>> wiphys so that one can do a mix of MLO and non MLO sta/AP.)
>>>>
>>>> No.
>>>
>>> Hello Johannes,
>>>
>>> Is there any design document for the combined phy approach somewhere publicly available?
>>>
>>> It is hard to understand the over all goals by just reading patches as they show up on
>>> the public mailing lists...
>>>
>>
>> Hi Ben,
>>
>> I dont think there is a document for this composite phy approach. But we try to clarify
>> as much as possible in the commit log and kernel-doc. Pls let us know the area which
>> is more appropriate to be clarified in the path.
>>
>> Vasanth
> 
> I am worried that the whole approach has problems that would be better solved with different
> architecture.


If you see a better approach, please feel free to propose one (preferably some RFC) to 
solve the problem.

   I understand that someone has made a decision to go with the combined
> approach,
> and I am sure they have reasons.  It would be good to see some details about how this 
> combined
> approach can work in lots of different use cases, including with un-modified user-space,

Unmodified user space sees all bands from same radio. I guess, driver can probably provide
some configuration knob to turn this off so that everything works a before but will not
be able to operate in MLO. Please note that, user space has to updated to get MLO
support anyway.

  and
> including what changes *are* required in user-space to keep current features and control 
> working
> with combined wiphy approach.
> 
> My over-all concerns are that I feel user-space is still going to need to understand the 
> individual
> underlying phys and be able to read/modify them individually.  Older radios will continue 
> to have single phy
> mappings, so that must be supported pretty much forever.  So it seems there is going to be 
> a huge amount
> of duplicated code up and down the stack and user-space.
> 

Not sure why there should be any duplication, perhaps when corresponding user space
(hostapd) changes will clarify most of these concerns.

> Having your team grind on a large patch set that turns out to have fundamental flaws would be
> a huge waste of time for all involved.
> 

As said, please feel free to propose an alternate solution to address the issue.

Vasanth

