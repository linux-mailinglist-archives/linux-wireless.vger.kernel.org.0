Return-Path: <linux-wireless+bounces-6263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9420B8A3301
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 17:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED0B0B22D22
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD98C148823;
	Fri, 12 Apr 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="k+iXYXxd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DD148829
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937536; cv=none; b=BNy5TJ83V0RI6vaPFtk5b9gciswi3waBy7cUprannB3+e2ZXZv6stAOngVFXrxVjRRdWfXlTqi5cwQpxuEEANYuvfInCbqmT1BBSbwoiq6WXoFb6Yq7ZVWu+FFsMEV+RHJc9JcldIPW3kL2Mtk9qpP+/sfAmvkBhPjInTOC6Xnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937536; c=relaxed/simple;
	bh=lC7qfRnRYrZ1lqblWSWO66MJ19IoysQe93+DAH5MJq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MN53LwUbv8NXdvoGvI4WgwKryW0Sau72iAWGTVj+xQVu0hhozF955f5D7+3ebDsFDtyksyTtOLaGBiNVO9PiQ5ODdtjuaYKj/RmjrEwseo8ZkDJCREFSnZBe+p1UxBj2hbgKiLJk2j4IiYHuX0i+69Ki2gI7Z7MPJwW12sO9KDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=k+iXYXxd; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C6E7CB80079;
	Fri, 12 Apr 2024 15:58:46 +0000 (UTC)
Received: from [IPV6:2a00:79e1:abc:12b:612f:d396:1826:730f] (unknown [104.133.8.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 051C813C2B0;
	Fri, 12 Apr 2024 08:58:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 051C813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1712937526;
	bh=lC7qfRnRYrZ1lqblWSWO66MJ19IoysQe93+DAH5MJq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k+iXYXxd0JenXP1I1FCrUryQGaFFcBsaCOYDHprsotRqXwxuvV0lECOgxQ+DqF4Wc
	 yRjTZ18Avp5DTVJyjB1dB1wNr3GKzX5gXEZxUfl7i2kloqZXdTivpUpHNJPI6QsfR+
	 eo+BhQ9Ri2qvZkV35uJa9AoysJ31+IY7WV0rsou8=
Message-ID: <dbd51b99-8472-2641-7493-6b91e384b4b6@candelatech.com>
Date: Fri, 12 Apr 2024 08:58:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-MW
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
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
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <31aa6b18-8ca4-e4ce-f693-e818fc7e6932@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1712937527-yy6_EIqw-mDM
X-MDID-O:
 us5;ut7;1712937527;yy6_EIqw-mDM;<greearb@candelatech.com>;e45dbe21c4fc86b950914d8831baea70

On 4/12/24 07:31, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 4/12/2024 7:38 PM, Ben Greear wrote:
>> On 4/11/24 21:11, Vasanthakumar Thiagarajan wrote:
>>>
>>>
>>> On 4/11/2024 2:33 AM, Ben Greear wrote:
>>>> On 4/10/24 08:42, Johannes Berg wrote:
>>>>> On Wed, 2024-04-10 at 07:37 -0700, Ben Greear wrote:
>>>>>> On 4/10/24 00:56, Johannes Berg wrote:
>>>>>>> On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
>>>>>>>> On 3/29/24 07:30, Johannes Berg wrote:
>>>>>>>>> On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
>>>>>>>>>>>
>>>>>>>>>>>> + * @hw_chans: list of the channels supported by every constituent underlying
>>>>>>>>>>>> + *    hardware. Drivers abstracting multiple discrete hardware (radio) under
>>>>>>>>>>>> + *    one wiphy can advertise the list of channels supported by each physical
>>>>>>>>>>>> + *    hardware in this list. Underlying hardware specific channel list can be
>>>>>>>>>>>> + *    used while describing interface combination for each of them.
>>>>>>>>>>>
>>>>>>>>>>> I'd expect there to be a limit on channels being within a single band on
>>>>>>>>>>> a single "hardware"?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> There are ath12k hardware supporting multiple band which need to be
>>>>>>>>>> registered under one mac80211_hw/wiphy. This design is to support such
>>>>>>>>>> hardware.
>>>>>>>>>
>>>>>>>>> Oh OK, that was something that I didn't have in mind any more, or never
>>>>>>>>> knew or paid attention to.
>>>>>>>>
>>>>>>>> Would it work to leave the phy reporting pretty much as it is now, but add
>>>>>>>> a 'associated_peer_radios' list section, so that each phy could report the phys
>>>>>>>> associated with it?  Then user-space, driver, mac80211 etc could look up the
>>>>>>>> other phys as needed to get a full picture?
>>>>>>>>
>>>>>>>
>>>>>>> There's not really a good way to _do_ that short of creating multiple
>>>>>>> wiphys, but that causes _massive_ complexity in the stack (both cfg80211
>>>>>>> and mac80211) so we rejected it years ago.
>>>>>>
>>>>>> I thought the problem ath12k is trying to fix is that there are currently multiple phys (radios) that needed to be made to
>>>>>> look like a single phy?
>>>>>
>>>>> Correct.
>>>>>
>>>>>> For dual and tri-concurrent radios, I think we will need them to look like 3 individual radios for non-MLO use
>>>>>> cases
>>>>>
>>>>> No, I don't see why, and if you want that we wouldn't support it anyway,
>>>>> you'd have to have a module option or something to decide which way to
>>>>> go.
>>>>>
>>>>> But it really ought to not be needed - the point of these patches is to
>>>>> give userspace enough information to know how to (and where) to create
>>>>> separate BSSes, with or without MLO between them.
>>>>>
>>>>>> For instance, mt7996 currently reports 3 single-band wiphys, and each can be used independently.
>>>>>> But assuming it starts supporting MLO, then those 3 single band wiphys will need to start acting
>>>>>> at least somewhat like a single entity
>>>>>
>>>>> Yes.
>>>>>
>>>>>> (while also concurrently being able to act as individual
>>>>>> wiphys so that one can do a mix of MLO and non MLO sta/AP.)
>>>>>
>>>>> No.
>>>>
>>>> Hello Johannes,
>>>>
>>>> Is there any design document for the combined phy approach somewhere publicly available?
>>>>
>>>> It is hard to understand the over all goals by just reading patches as they show up on
>>>> the public mailing lists...
>>>>
>>>
>>> Hi Ben,
>>>
>>> I dont think there is a document for this composite phy approach. But we try to clarify
>>> as much as possible in the commit log and kernel-doc. Pls let us know the area which
>>> is more appropriate to be clarified in the path.
>>>
>>> Vasanth
>>
>> I am worried that the whole approach has problems that would be better solved with different
>> architecture.
> 
> 
> If you see a better approach, please feel free to propose one (preferably some RFC) to solve the problem.
> 
>    I understand that someone has made a decision to go with the combined
>> approach,
>> and I am sure they have reasons.  It would be good to see some details about how this combined
>> approach can work in lots of different use cases, including with un-modified user-space,
> 
> Unmodified user space sees all bands from same radio. I guess, driver can probably provide
> some configuration knob to turn this off so that everything works a before but will not
> be able to operate in MLO. Please note that, user space has to updated to get MLO
> support anyway.
> 
>   and
>> including what changes *are* required in user-space to keep current features and control working
>> with combined wiphy approach.
>>
>> My over-all concerns are that I feel user-space is still going to need to understand the individual
>> underlying phys and be able to read/modify them individually.  Older radios will continue to have single phy
>> mappings, so that must be supported pretty much forever.  So it seems there is going to be a huge amount
>> of duplicated code up and down the stack and user-space.
>>
> 
> Not sure why there should be any duplication, perhaps when corresponding user space
> (hostapd) changes will clarify most of these concerns.
> 
>> Having your team grind on a large patch set that turns out to have fundamental flaws would be
>> a huge waste of time for all involved.
>>
> 
> As said, please feel free to propose an alternate solution to address the issue.

I do not know the particulars of your driver or driver's needs, but at high level:

*  Leave existing wiphy mapping as is.
*  Allow adding new combined wiphy(s) on top of groups of underlying physical wiphys.  Sort of
    like bridges on top of Eth ports.
*  The combined wiphy would report underlying wiphy's capabilities (for instance, a combined wiphy on top of
    3 single band phys would report itself as tri-band).
*  The combined wiphy would add new netlink field listing of its underlying wiphys.  User-space wanting to control the combined
    wiphy would generally configure the underlying phys (to set 2.4g channel to 6, you'd set the underlying 2.4g
    wiphy to channel 6)
*  This should require very minimal changes to user space, except of course for new code to actually utilize
    the new combined wiphy.
*  MLO links and any other logic that needs the combined view would live on the combined wiphy (I understand
    from Johannes' comments this is a needed feature.)
*  Or user can ignore that combined wiphy entirely and directly use underlying wiphys like we use them currently
    for sniffers, stations, aps, combinations thereof.
*  Advanced use case could allow combined wiphy to use subset of underlying radios (add combined wiphy on 2.4 and 5g, use 6g for
    dedicated mesh backhaul/whatever).
*  Interesting logic would be needed to deal with constraints to properly share the underlying resources (you could not
    add 16 ap bssid to 2.4 wiphy and also add 16 other ones to the combined wiphy that also uses 2.4 radio most likely,
    for instance).  But I think that logic has to be written
    either way and is not overly worse with this approach.

Thanks,
Ben


> 
> Vasanth
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

