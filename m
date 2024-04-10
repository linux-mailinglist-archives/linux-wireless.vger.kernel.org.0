Return-Path: <linux-wireless+bounces-6118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13F89FA1B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 16:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF3C28724E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED46116DECA;
	Wed, 10 Apr 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="JJnZGYAN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7FB16DEC3
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759875; cv=none; b=o7Ev9x4iPNWqxvC244N9tqWugFpU+8cPUO2lygHz9Rkjxb0bR6RtI9Wcaxpy8Z2+36/GaDm4uRk+ygrEVqzLgOQ4wHWjJI8aXOllJ3IUQ/0DDhiqXfwf4zH26nVyfiHsVQ/mQLvbCADzSg/cZCeCkgokyZlZ0GLbRljqb1Ss6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759875; c=relaxed/simple;
	bh=HcjnHx29WXxDY+v7VWf1kZtucG8fOj8atDSMokCNb1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0hEZUWbSzfJoiZeVDmTGCBRB2NjojTTxdqkk67Pwhq6XLbb5kfnXmGDEV2k1+gPH5l4kng5jT3otUiPNaqX7SJIMeaSsIxkzzxTZDRs4wXXNXI07kHn+kDD4/cuzraStuY88IF/fmHZX/VgOSADLD1xl+q1J5d082bmr3LHSWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=JJnZGYAN; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9731B30163C
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 14:37:47 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1139C3C0073;
	Wed, 10 Apr 2024 14:37:40 +0000 (UTC)
Received: from [172.20.4.169] (unknown [69.170.33.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 1CC6813C2B0;
	Wed, 10 Apr 2024 07:37:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1CC6813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1712759858;
	bh=HcjnHx29WXxDY+v7VWf1kZtucG8fOj8atDSMokCNb1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JJnZGYANtK1l7D1hbkjx3zOUOTm4r/XaVktUQXEOwOPtuTgUPiEQGYFzHnqEsaWON
	 YCL8/vfKdylC+xn87PdCc7oGskBwhNmdf3VlAgZw1dshlr8vigM42NX9YfxwjDM0aG
	 +7pC7ylDnjbMzwnqcEvsEXQcJjH1S5hN9wR85EMM=
Message-ID: <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
Date: Wed, 10 Apr 2024 07:37:37 -0700
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
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1712759861-AjslrQx6Mflk
X-MDID-O:
 us5;at1;1712759861;AjslrQx6Mflk;<greearb@candelatech.com>;e45dbe21c4fc86b950914d8831baea70

On 4/10/24 00:56, Johannes Berg wrote:
> On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
>> On 3/29/24 07:30, Johannes Berg wrote:
>>> On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
>>>>>
>>>>>> + * @hw_chans: list of the channels supported by every constituent underlying
>>>>>> + *	hardware. Drivers abstracting multiple discrete hardware (radio) under
>>>>>> + *	one wiphy can advertise the list of channels supported by each physical
>>>>>> + *	hardware in this list. Underlying hardware specific channel list can be
>>>>>> + *	used while describing interface combination for each of them.
>>>>>
>>>>> I'd expect there to be a limit on channels being within a single band on
>>>>> a single "hardware"?
>>>>>
>>>>
>>>> There are ath12k hardware supporting multiple band which need to be
>>>> registered under one mac80211_hw/wiphy. This design is to support such
>>>> hardware.
>>>
>>> Oh OK, that was something that I didn't have in mind any more, or never
>>> knew or paid attention to.
>>
>> Would it work to leave the phy reporting pretty much as it is now, but add
>> a 'associated_peer_radios' list section, so that each phy could report the phys
>> associated with it?  Then user-space, driver, mac80211 etc could look up the
>> other phys as needed to get a full picture?
>>
> 
> There's not really a good way to _do_ that short of creating multiple
> wiphys, but that causes _massive_ complexity in the stack (both cfg80211
> and mac80211) so we rejected it years ago.

I thought the problem ath12k is trying to fix is that there are currently multiple phys (radios) that needed to be made to
look like a single phy?

For dual and tri-concurrent radios, I think we will need them to look like 3 individual radios for non-MLO use
cases, but I guess there will be also some way to treat them as a single entity when using MLO.

For instance, mt7996 currently reports 3 single-band wiphys, and each can be used independently.
But assuming it starts supporting MLO, then those 3 single band wiphys will need to start acting
at least somewhat like a single entity (while also concurrently being able to act as individual
wiphys so that one can do a mix of MLO and non MLO sta/AP.)

Maybe I'm missing the entire point of the ath12k patches though...

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

