Return-Path: <linux-wireless+bounces-6256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98FD8A302A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC89B21ECC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE250241;
	Fri, 12 Apr 2024 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="JhJHs4zp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F20284DF6
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930906; cv=none; b=lZN63oo7wngIbHXdhqYMYd1dF1/ZGgdWXBNqRJ+iK+Z07qywAbQzVJzKmu7ods84Qpdcqc024Q/QWeStbD7NFKgT6JwKwI80s8hRp3jkh31ZXwO/uS0RRXnTphalj8KCs5A8NWxs5+40T0TunOPRAfCB/gVHV+KBr9AbdYe4FOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930906; c=relaxed/simple;
	bh=ncLXrYpIYQhHN17O5DiMgzrK4eT7Tan/ljpIttpbmp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bY6e6DDiHk06OX2hWIr6RaAFuT6MoBpdGtu+RNpr0C1blqll1Na0oZ7Ds+soxxe9u/IJH02PW9P7t0ZAeZ0xdoKqMEmiPxG/17hEt8O2i9tnK751sc9ZieWlvQc0QU4EF6JlCHL25h2g22KrHlDZTgqMr1Bji66Faw4kg9SBDro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=JhJHs4zp; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4328CB80079;
	Fri, 12 Apr 2024 14:08:16 +0000 (UTC)
Received: from [172.20.4.169] (unknown [69.170.33.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 18FD413C2B0;
	Fri, 12 Apr 2024 07:08:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 18FD413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1712930895;
	bh=ncLXrYpIYQhHN17O5DiMgzrK4eT7Tan/ljpIttpbmp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JhJHs4zp7nMAxKc1/I5IGXyJtE/hmEF1dCAoNby8CI9b+La3nwWS10X0TxQn4D21n
	 3XTTQripLn7+DMqIo0JhR4DmbeELKhvwcIT0dNAHZgRzxeOJD7ih4Sy2wUGGTFxUTc
	 VYI/WM7oQOLzDhuag6Piea2UQFIdswfGGGPpdeCE=
Message-ID: <87de72e9-1d3b-b401-a712-9fe8734515b6@candelatech.com>
Date: Fri, 12 Apr 2024 07:08:14 -0700
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
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <cb991a00-fce2-5a3d-c03f-579b44f922f5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1712930897-Q87u6QB21xs3
X-MDID-O:
 us5;at1;1712930897;Q87u6QB21xs3;<greearb@candelatech.com>;e45dbe21c4fc86b950914d8831baea70

On 4/11/24 21:11, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 4/11/2024 2:33 AM, Ben Greear wrote:
>> On 4/10/24 08:42, Johannes Berg wrote:
>>> On Wed, 2024-04-10 at 07:37 -0700, Ben Greear wrote:
>>>> On 4/10/24 00:56, Johannes Berg wrote:
>>>>> On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
>>>>>> On 3/29/24 07:30, Johannes Berg wrote:
>>>>>>> On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
>>>>>>>>>
>>>>>>>>>> + * @hw_chans: list of the channels supported by every constituent underlying
>>>>>>>>>> + *    hardware. Drivers abstracting multiple discrete hardware (radio) under
>>>>>>>>>> + *    one wiphy can advertise the list of channels supported by each physical
>>>>>>>>>> + *    hardware in this list. Underlying hardware specific channel list can be
>>>>>>>>>> + *    used while describing interface combination for each of them.
>>>>>>>>>
>>>>>>>>> I'd expect there to be a limit on channels being within a single band on
>>>>>>>>> a single "hardware"?
>>>>>>>>>
>>>>>>>>
>>>>>>>> There are ath12k hardware supporting multiple band which need to be
>>>>>>>> registered under one mac80211_hw/wiphy. This design is to support such
>>>>>>>> hardware.
>>>>>>>
>>>>>>> Oh OK, that was something that I didn't have in mind any more, or never
>>>>>>> knew or paid attention to.
>>>>>>
>>>>>> Would it work to leave the phy reporting pretty much as it is now, but add
>>>>>> a 'associated_peer_radios' list section, so that each phy could report the phys
>>>>>> associated with it?  Then user-space, driver, mac80211 etc could look up the
>>>>>> other phys as needed to get a full picture?
>>>>>>
>>>>>
>>>>> There's not really a good way to _do_ that short of creating multiple
>>>>> wiphys, but that causes _massive_ complexity in the stack (both cfg80211
>>>>> and mac80211) so we rejected it years ago.
>>>>
>>>> I thought the problem ath12k is trying to fix is that there are currently multiple phys (radios) that needed to be made to
>>>> look like a single phy?
>>>
>>> Correct.
>>>
>>>> For dual and tri-concurrent radios, I think we will need them to look like 3 individual radios for non-MLO use
>>>> cases
>>>
>>> No, I don't see why, and if you want that we wouldn't support it anyway,
>>> you'd have to have a module option or something to decide which way to
>>> go.
>>>
>>> But it really ought to not be needed - the point of these patches is to
>>> give userspace enough information to know how to (and where) to create
>>> separate BSSes, with or without MLO between them.
>>>
>>>> For instance, mt7996 currently reports 3 single-band wiphys, and each can be used independently.
>>>> But assuming it starts supporting MLO, then those 3 single band wiphys will need to start acting
>>>> at least somewhat like a single entity
>>>
>>> Yes.
>>>
>>>> (while also concurrently being able to act as individual
>>>> wiphys so that one can do a mix of MLO and non MLO sta/AP.)
>>>
>>> No.
>>
>> Hello Johannes,
>>
>> Is there any design document for the combined phy approach somewhere publicly available?
>>
>> It is hard to understand the over all goals by just reading patches as they show up on
>> the public mailing lists...
>>
> 
> Hi Ben,
> 
> I dont think there is a document for this composite phy approach. But we try to clarify
> as much as possible in the commit log and kernel-doc. Pls let us know the area which
> is more appropriate to be clarified in the path.
> 
> Vasanth

I am worried that the whole approach has problems that would be better solved with different
architecture.  I understand that someone has made a decision to go with the combined approach,
and I am sure they have reasons.  It would be good to see some details about how this combined
approach can work in lots of different use cases, including with un-modified user-space, and
including what changes *are* required in user-space to keep current features and control working
with combined wiphy approach.

My over-all concerns are that I feel user-space is still going to need to understand the individual
underlying phys and be able to read/modify them individually.  Older radios will continue to have single phy
mappings, so that must be supported pretty much forever.  So it seems there is going to be a huge amount
of duplicated code up and down the stack and user-space.

Having your team grind on a large patch set that turns out to have fundamental flaws would be
a huge waste of time for all involved.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

