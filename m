Return-Path: <linux-wireless+bounces-6135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D7E8A01E0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 23:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48CC1C21777
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92F31836CE;
	Wed, 10 Apr 2024 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="oDq5+6x5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30217BB2F
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784046; cv=none; b=JrrXSYcGGxSl25eU/Wb0Y1k6Errv1QArStePeYzg3avszgZuBy+VcHPeZ9qHfPMZxupojzBOQNc0MMlSy1o8KiqUeRHN5Tscrs9fBgTV53TkJBgiA4mBUyoUqRO+YhFMcyAKwLm/kFkaymhfxkXxrd3PHVs6s7r2L0e7bxJk0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784046; c=relaxed/simple;
	bh=qeon5nMw9hqtoeOdYCIVQbMLKMGgy2yvGMQDmRWCUHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmcnE29TsxQ+o5fYHCALSltbVolFHOBELoDi28zVmUxwSDDchdrsPTXLAfBkOb/Ajfv7O2xk7K1tNlMd9doCh8iYrCmGdocwtfc+IXeH2Q3+8Xy/FleXNIlzReJjCZ+tMkM/vDm7HILz/a/eiV0KBBnYyY938lHWv2ddkKAArtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=oDq5+6x5; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A2CC52A224A
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 21:03:48 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D0E7C100073;
	Wed, 10 Apr 2024 21:03:40 +0000 (UTC)
Received: from [192.168.1.148] (unknown [136.42.28.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 1540013C2B0;
	Wed, 10 Apr 2024 14:03:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1540013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1712783020;
	bh=qeon5nMw9hqtoeOdYCIVQbMLKMGgy2yvGMQDmRWCUHg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oDq5+6x5DT3Hso4hgUSMB2AbNbo5LpS7AGpau6Pfmk/ymlq5x03+AE9dFb9wxA1Lx
	 ws6vMNSdzt7YqcG8Nfh0GvzNqY79fFjuBrAJVj9rDLUa2N+6YpP4RtGMff+sT4y1Uw
	 fxC8VBspFi1F8/nGS40dKi057Bwk3NMrZmkAKSNE=
Message-ID: <72f491f8-dd3a-0c9e-7490-4d51c86f2102@candelatech.com>
Date: Wed, 10 Apr 2024 14:03:39 -0700
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
To: Johannes Berg <johannes@sipsolutions.net>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
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
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1712783022-zT9Y6Rwlr8VG
X-MDID-O:
 us5;ut7;1712783022;zT9Y6Rwlr8VG;<greearb@candelatech.com>;e45dbe21c4fc86b950914d8831baea70

On 4/10/24 08:42, Johannes Berg wrote:
> On Wed, 2024-04-10 at 07:37 -0700, Ben Greear wrote:
>> On 4/10/24 00:56, Johannes Berg wrote:
>>> On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
>>>> On 3/29/24 07:30, Johannes Berg wrote:
>>>>> On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
>>>>>>>
>>>>>>>> + * @hw_chans: list of the channels supported by every constituent underlying
>>>>>>>> + *	hardware. Drivers abstracting multiple discrete hardware (radio) under
>>>>>>>> + *	one wiphy can advertise the list of channels supported by each physical
>>>>>>>> + *	hardware in this list. Underlying hardware specific channel list can be
>>>>>>>> + *	used while describing interface combination for each of them.
>>>>>>>
>>>>>>> I'd expect there to be a limit on channels being within a single band on
>>>>>>> a single "hardware"?
>>>>>>>
>>>>>>
>>>>>> There are ath12k hardware supporting multiple band which need to be
>>>>>> registered under one mac80211_hw/wiphy. This design is to support such
>>>>>> hardware.
>>>>>
>>>>> Oh OK, that was something that I didn't have in mind any more, or never
>>>>> knew or paid attention to.
>>>>
>>>> Would it work to leave the phy reporting pretty much as it is now, but add
>>>> a 'associated_peer_radios' list section, so that each phy could report the phys
>>>> associated with it?  Then user-space, driver, mac80211 etc could look up the
>>>> other phys as needed to get a full picture?
>>>>
>>>
>>> There's not really a good way to _do_ that short of creating multiple
>>> wiphys, but that causes _massive_ complexity in the stack (both cfg80211
>>> and mac80211) so we rejected it years ago.
>>
>> I thought the problem ath12k is trying to fix is that there are currently multiple phys (radios) that needed to be made to
>> look like a single phy?
> 
> Correct.
> 
>> For dual and tri-concurrent radios, I think we will need them to look like 3 individual radios for non-MLO use
>> cases
> 
> No, I don't see why, and if you want that we wouldn't support it anyway,
> you'd have to have a module option or something to decide which way to
> go.
> 
> But it really ought to not be needed - the point of these patches is to
> give userspace enough information to know how to (and where) to create
> separate BSSes, with or without MLO between them.
> 
>> For instance, mt7996 currently reports 3 single-band wiphys, and each can be used independently.
>> But assuming it starts supporting MLO, then those 3 single band wiphys will need to start acting
>> at least somewhat like a single entity
> 
> Yes.
> 
>> (while also concurrently being able to act as individual
>> wiphys so that one can do a mix of MLO and non MLO sta/AP.)
> 
> No.

Hello Johannes,

Is there any design document for the combined phy approach somewhere publicly available?

It is hard to understand the over all goals by just reading patches as they show up on
the public mailing lists...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

