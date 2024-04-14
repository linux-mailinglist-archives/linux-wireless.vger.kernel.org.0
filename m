Return-Path: <linux-wireless+bounces-6288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1994E8A4397
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD43E281CFB
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14F56771;
	Sun, 14 Apr 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HCQl4p95"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE291946B
	for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109994; cv=none; b=IhnnZNNkmggPfKDVDJsLITzRb0m24XbjC/tPhhqXkZAUUGwPiKpRgBh0tHPjr42sEDwkPwdxsnSeEhAAbXt5abDUigZZySfGGq37fSAaHai4J4iy3PIkSsM1TSx0LpdpF1i3nHk1IcsIE2IpUak+BnWL8EUqXFXlrXOaNQat2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109994; c=relaxed/simple;
	bh=GZ/SPKfv0d4iWEX19zpyJd8hekhyGNK5OtSCsl1f0ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K47WHmoUIWQqj8eal7NrTcUVmUmuadjAVy7K/Tg8h1oHzmUPnnMhlz5YQXCzAFEonaVo/YZCuIz67djym4RHpUbdEaLKZXxrjWt9voAiIgQpG5gxZTA+rET3RR6TXrY/egHHHrxb371RtC9LgvnUV0XmtfZtO2fq6toeyqny3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HCQl4p95; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EFUFHb019268;
	Sun, 14 Apr 2024 15:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=O9zQO9BEj05xn+edrNpuhfNEFuBalkuFNt8yLa6d7jY=; b=HC
	Ql4p95qjIXBSSv+YHPao8UamwA0xS7rGj2bCvwsbujn9zA1A8JyMjXmGJ9Mm8r3X
	RsjKIJnoJOop4IxgsuCCspKU7y5tJwoDMhfHlbSJeq7bhRGqo3Pswl7KWkKaNcmZ
	98sXI13IV+57ICfkUgUcyDEY7vVjen+xrhPCExk1HKYlQ9Eqb9uxashK2QM8UyNA
	uXk8v/HqrpqgK55itDHvilnnZ3vLBfO6unhIdZb6WyRXop4mCZDqlN1ZombMl5qr
	VlPEcGNQZGbcL/bc5iSYfMfinCdYNZLI35EuNF6cLu3zwQI3N/uMcy2ng2cn+Ko6
	v46H6yL9/MmGAVccFZWw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfh2ct1vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 15:52:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EFqtR6027281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 15:52:55 GMT
Received: from [10.216.32.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Apr
 2024 08:52:52 -0700
Message-ID: <c44e6c1e-431b-1641-3ecd-18c49a902170@quicinc.com>
Date: Sun, 14 Apr 2024 21:22:46 +0530
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
 <31aa6b18-8ca4-e4ce-f693-e818fc7e6932@quicinc.com>
 <dbd51b99-8472-2641-7493-6b91e384b4b6@candelatech.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <dbd51b99-8472-2641-7493-6b91e384b4b6@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9Lrr378yP5yYFgzMeTp4J7hgd_dO4Me2
X-Proofpoint-GUID: 9Lrr378yP5yYFgzMeTp4J7hgd_dO4Me2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_05,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140114



On 4/12/2024 9:28 PM, Ben Greear wrote:
> On 4/12/24 07:31, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 4/12/2024 7:38 PM, Ben Greear wrote:
>>> On 4/11/24 21:11, Vasanthakumar Thiagarajan wrote:
>>>>
>>>>
>>>> On 4/11/2024 2:33 AM, Ben Greear wrote:
>>>>> On 4/10/24 08:42, Johannes Berg wrote:
>>>>>> On Wed, 2024-04-10 at 07:37 -0700, Ben Greear wrote:
>>>>>>> On 4/10/24 00:56, Johannes Berg wrote:
>>>>>>>> On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
>>>>>>>>> On 3/29/24 07:30, Johannes Berg wrote:
>>>>>>>>>> On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> + * @hw_chans: list of the channels supported by every constituent underlying
>>>>>>>>>>>>> + *    hardware. Drivers abstracting multiple discrete hardware (radio) under
>>>>>>>>>>>>> + *    one wiphy can advertise the list of channels supported by each physical
>>>>>>>>>>>>> + *    hardware in this list. Underlying hardware specific channel list can be
>>>>>>>>>>>>> + *    used while describing interface combination for each of them.
>>>>>>>>>>>>
>>>>>>>>>>>> I'd expect there to be a limit on channels being within a single band on
>>>>>>>>>>>> a single "hardware"?
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> There are ath12k hardware supporting multiple band which need to be
>>>>>>>>>>> registered under one mac80211_hw/wiphy. This design is to support such
>>>>>>>>>>> hardware.
>>>>>>>>>>
>>>>>>>>>> Oh OK, that was something that I didn't have in mind any more, or never
>>>>>>>>>> knew or paid attention to.
>>>>>>>>>
>>>>>>>>> Would it work to leave the phy reporting pretty much as it is now, but add
>>>>>>>>> a 'associated_peer_radios' list section, so that each phy could report the phys
>>>>>>>>> associated with it?  Then user-space, driver, mac80211 etc could look up the
>>>>>>>>> other phys as needed to get a full picture?
>>>>>>>>>
>>>>>>>>
>>>>>>>> There's not really a good way to _do_ that short of creating multiple
>>>>>>>> wiphys, but that causes _massive_ complexity in the stack (both cfg80211
>>>>>>>> and mac80211) so we rejected it years ago.
>>>>>>>
>>>>>>> I thought the problem ath12k is trying to fix is that there are currently multiple 
>>>>>>> phys (radios) that needed to be made to
>>>>>>> look like a single phy?
>>>>>>
>>>>>> Correct.
>>>>>>
>>>>>>> For dual and tri-concurrent radios, I think we will need them to look like 3 
>>>>>>> individual radios for non-MLO use
>>>>>>> cases
>>>>>>
>>>>>> No, I don't see why, and if you want that we wouldn't support it anyway,
>>>>>> you'd have to have a module option or something to decide which way to
>>>>>> go.
>>>>>>
>>>>>> But it really ought to not be needed - the point of these patches is to
>>>>>> give userspace enough information to know how to (and where) to create
>>>>>> separate BSSes, with or without MLO between them.
>>>>>>
>>>>>>> For instance, mt7996 currently reports 3 single-band wiphys, and each can be used 
>>>>>>> independently.
>>>>>>> But assuming it starts supporting MLO, then those 3 single band wiphys will need to 
>>>>>>> start acting
>>>>>>> at least somewhat like a single entity
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>> (while also concurrently being able to act as individual
>>>>>>> wiphys so that one can do a mix of MLO and non MLO sta/AP.)
>>>>>>
>>>>>> No.
>>>>>
>>>>> Hello Johannes,
>>>>>
>>>>> Is there any design document for the combined phy approach somewhere publicly available?
>>>>>
>>>>> It is hard to understand the over all goals by just reading patches as they show up on
>>>>> the public mailing lists...
>>>>>
>>>>
>>>> Hi Ben,
>>>>
>>>> I dont think there is a document for this composite phy approach. But we try to clarify
>>>> as much as possible in the commit log and kernel-doc. Pls let us know the area which
>>>> is more appropriate to be clarified in the path.
>>>>
>>>> Vasanth
>>>
>>> I am worried that the whole approach has problems that would be better solved with 
>>> different
>>> architecture.
>>
>>
>> If you see a better approach, please feel free to propose one (preferably some RFC) to 
>> solve the problem.
>>
>>    I understand that someone has made a decision to go with the combined
>>> approach,
>>> and I am sure they have reasons.  It would be good to see some details about how this 
>>> combined
>>> approach can work in lots of different use cases, including with un-modified user-space,
>>
>> Unmodified user space sees all bands from same radio. I guess, driver can probably provide
>> some configuration knob to turn this off so that everything works a before but will not
>> be able to operate in MLO. Please note that, user space has to updated to get MLO
>> support anyway.
>>
>>   and
>>> including what changes *are* required in user-space to keep current features and 
>>> control working
>>> with combined wiphy approach.
>>>
>>> My over-all concerns are that I feel user-space is still going to need to understand 
>>> the individual
>>> underlying phys and be able to read/modify them individually.  Older radios will 
>>> continue to have single phy
>>> mappings, so that must be supported pretty much forever.  So it seems there is going to 
>>> be a huge amount
>>> of duplicated code up and down the stack and user-space.
>>>
>>
>> Not sure why there should be any duplication, perhaps when corresponding user space
>> (hostapd) changes will clarify most of these concerns.
>>
>>> Having your team grind on a large patch set that turns out to have fundamental flaws 
>>> would be
>>> a huge waste of time for all involved.
>>>
>>
>> As said, please feel free to propose an alternate solution to address the issue.
> 
> I do not know the particulars of your driver or driver's needs, but at high level:
> > *  Leave existing wiphy mapping as is.
> *  Allow adding new combined wiphy(s) on top of groups of underlying physical wiphys.  
> Sort of
>     like bridges on top of Eth ports.
> *  The combined wiphy would report underlying wiphy's capabilities (for instance, a 
> combined wiphy on top of
>     3 single band phys would report itself as tri-band).
> *  The combined wiphy would add new netlink field listing of its underlying wiphys.  
> User-space wanting to control the combined
>     wiphy would generally configure the underlying phys (to set 2.4g channel to 6, you'd 
> set the underlying 2.4g
>     wiphy to channel 6)
> *  This should require very minimal changes to user space, except of course for new code 
> to actually utilize
>     the new combined wiphy.
> *  MLO links and any other logic that needs the combined view would live on the combined 
> wiphy (I understand

Having MLO links on top of thins combined wiphy will not work because there is no 
difference in the way MLO and legacy interfaces are created. More over, at a given
time same STA can be either MLO or legacy based on the AP the STA is connected with.

>     from Johannes' comments this is a needed feature.)
> *  Or user can ignore that combined wiphy entirely and directly use underlying wiphys like 
> we use them currently

But old user space will get confused with this new combined wiphy...

>     for sniffers, stations, aps, combinations thereof.
> *  Advanced use case could allow combined wiphy to use subset of underlying radios (add 
> combined wiphy on 2.4 and 5g, use 6g for
>     dedicated mesh backhaul/whatever).

Not sure having parallel path one for legacy and the other one for advanced use cases
may not be a clean solution...

> *  Interesting logic would be needed to deal with constraints to properly share the 
> underlying resources (you could not
>     add 16 ap bssid to 2.4 wiphy and also add 16 other ones to the combined wiphy that 
> also uses 2.4 radio most likely,
>     for instance).  But I think that logic has to be written
>     either way and is not overly worse with this approach.
> 

Anyway, similar approach was considered before coming up the with the one that
this patch series implements. Due to complexities in cfg80211 and mac80211 all
options building MLO on top of multiple wiphy was rejected. Im not planning
to look into such approaches. Instead, the approach implemented in this patch
series has gone into extensive testings with corresponding changes in ath12k
driver and hostapd. Other than few items (concurrent scan is one additional
not mentioned explicitly) as mentioned in the cover letter to do list, things
look fine. But all these pending items can be addressed in follow-on patches.
We dont really see much complexities in hostapd implementations , we'll post
them once the kernel part is concluded.

Other than ability to run interface on multiple supported bands concurrently,
this patches series does not change anything else.

Vasanth

