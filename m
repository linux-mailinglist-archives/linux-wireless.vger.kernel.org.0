Return-Path: <linux-wireless+bounces-6125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5789FCC0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1411C21F2A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658A17A920;
	Wed, 10 Apr 2024 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="VRy+DwW2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF316D9CC
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766221; cv=none; b=XpBmbdZf6xafQD7SkxEryrldsN6vPoopvGe3vfoNDZHNEvmapgSqLRirtbQrLc+K6IxhFfcAHWz5HTSwhctAsKYRZLor6QgT8XA0nSZvfc1ivxFeuFTosGBokBeuhF2VUCyp4UgPEObFUbs+cdW1gmfxjghvH/WH6R+d5p3rA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766221; c=relaxed/simple;
	bh=FksxrBE85wsNCkcWJSuKiJY1x/2Or6Zy6+YkRSQef3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMYS7tD62JmnWJVj+UMwrPY8HGBk9wXtwfaEax3J5Yctx+EDVMgvu71ri4pJi+Zy6DpncS7FgUwdtcc+twuX3wRdTUg3fU5Nk2+hjjPAP0zu1ybOSpuWiZ0ftteufQFnixLMtFLCd2jnHpyU+WIRzMl4GT6HAPxmeqGLVt7w83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=VRy+DwW2; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 90B2E8009C;
	Wed, 10 Apr 2024 16:23:36 +0000 (UTC)
Received: from [IPV6:2a00:79e1:abc:12b:612f:d396:1826:730f] (unknown [104.133.8.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E7AC113C2B0;
	Wed, 10 Apr 2024 09:23:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E7AC113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1712766215;
	bh=FksxrBE85wsNCkcWJSuKiJY1x/2Or6Zy6+YkRSQef3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VRy+DwW2WWLEQ/Dy8GaWJMu+X7JlpcyItUER8s9DQ1UnRs7Lf1J4EeQ6zpXSJ2IUC
	 uk3Vi81U31/OtJgPU/eSednFuqIWHhlvTndH0SHfZxMXEIjVOsxX67x7Fp/sBe2olu
	 I9REMA1P1DSno9+WN9vOPhbLVbcMhjR+qT0YnEB4=
Message-ID: <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com>
Date: Wed, 10 Apr 2024 09:23:34 -0700
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
X-MDID: 1712766217-ecBzFAlbZ_xB
X-MDID-O:
 us5;at1;1712766217;ecBzFAlbZ_xB;<greearb@candelatech.com>;e45dbe21c4fc86b950914d8831baea70

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

If phy0 told user-space that phy1 and phy2 were 'mlo peers', and phy1 and phy2
gave similar mapping, couldn't user-space just notice the peer group and then
have all the info it needed without the bulk of the patch set in question?

So then if hostapd wants to have 3 radios in an mlo grouping, it can do so.

And if instead it wants three old-style wifi-6 AP interfaces, it could do that
as well.  I don't see why it would need any module option, and I also do not
see why it could not do both behaviours concurrently (one BSSID being MLO, second one
being non MLO, for instance).

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

How will you allow all three bands/phys to host bssids that can talk to
wifi-6 and earlier stations if there is only a single phy seen by hostapd?

I definitely want to put STA vdevs on the three individual 7996 phys and have them
be able to talk to non MLO APs. This currently works.

I suspect other use cases, such as meshing with non MLO APs may also want
this sort of ability.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

