Return-Path: <linux-wireless+bounces-6325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3848A5279
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C311C2295A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761AD33080;
	Mon, 15 Apr 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="fa6i1thD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092B73527
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189568; cv=none; b=OusuPlX7uizKccA0E3MDEpPJvlni9gbDP7kDefl2uY6qZEq6ePTxfJF3GjQCR7fLxGOP2hKHYZfAdYxgzGt9fcXo6H2KOG02A51SAlIk44iutm2QX5+VIOPtM8tjq3EXeIE0uwD3potE1tzDebecP9h8fgYaNWENlgU5kxuSY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189568; c=relaxed/simple;
	bh=dYGBAYVMcyF9m+bXfaVqlfW+2TEu/zOy8GIbiXDkQwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QI1qQ/VyDpWXADxAUtc1NAV04bTDfU2+Iz7VTae5YR+1L7TXmJULZIACFqPQaT6xwcqX8tQwMMGbbGpt6EeC3u/GQ0hnX49ILVZPYliIIprKo7NbBYp50YfspQAW4LdyWASqrBiWS2Hy8pj90GtaTW1ez/d41MJ5ZeyYyhOzgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=fa6i1thD; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 06151500D6B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 13:59:20 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2160C6C0083;
	Mon, 15 Apr 2024 13:59:12 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.34.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 1A8C713C2B0;
	Mon, 15 Apr 2024 06:59:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1A8C713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1713189550;
	bh=dYGBAYVMcyF9m+bXfaVqlfW+2TEu/zOy8GIbiXDkQwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fa6i1thD1sD0mp9OhKWv1W4KG0L8J9K/3yfDkv+36F3iDFMJFaftOnmEeM9keCQv3
	 Y/p1ZoCo386FUtS1dHodnCOoJPAeoR8i+JVwXfkNNBI9PbeB6zpcWJFTqnZ2DsHE7h
	 Yc/l/BZFEFs14VHWq80lmVQ6vKSLcJjJugTub8K8=
Message-ID: <5d689308-8104-406d-87b4-5f2ffe836d94@candelatech.com>
Date: Mon, 15 Apr 2024 06:59:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <dbd51b99-8472-2641-7493-6b91e384b4b6@candelatech.com>
 <54807acb-b7dc-851e-27ce-49e09df5e1e4@candelatech.com>
 <a97ebd67-4a6b-c9bd-f325-da05c9af0a38@quicinc.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <a97ebd67-4a6b-c9bd-f325-da05c9af0a38@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1713189553-fTbtfkeRA3Br
X-MDID-O:
 us5;at1;1713189553;fTbtfkeRA3Br;<greearb@candelatech.com>;e45dbe21c4fc86b950914d8831baea70

On 4/14/24 09:02, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 4/13/2024 9:10 PM, Ben Greear wrote:
>> On 4/12/24 08:58, Ben Greear wrote:
>>> On 4/12/24 07:31, Vasanthakumar Thiagarajan wrote:
>>
>>>> As said, please feel free to propose an alternate solution to address the issue.
>>>
>>> I do not know the particulars of your driver or driver's needs, but at high level:
>>>
>>> *  Leave existing wiphy mapping as is.
>>> *  Allow adding new combined wiphy(s) on top of groups of underlying physical wiphys. Sort of
>>>     like bridges on top of Eth ports.
>>> *  The combined wiphy would report underlying wiphy's capabilities (for instance, a combined wiphy on top of
>>>     3 single band phys would report itself as tri-band).
>>> *  The combined wiphy would add new netlink field listing of its underlying wiphys. User-space wanting to control the combined
>>>     wiphy would generally configure the underlying phys (to set 2.4g channel to 6, you'd set the underlying 2.4g
>>>     wiphy to channel 6)
>>> *  This should require very minimal changes to user space, except of course for new code to actually utilize
>>>     the new combined wiphy.
>>> *  MLO links and any other logic that needs the combined view would live on the combined wiphy (I understand
>>>     from Johannes' comments this is a needed feature.)
>>> *  Or user can ignore that combined wiphy entirely and directly use underlying wiphys like we use them currently
>>>     for sniffers, stations, aps, combinations thereof.
>>> *  Advanced use case could allow combined wiphy to use subset of underlying radios (add combined wiphy on 2.4 and 5g, use 6g for
>>>     dedicated mesh backhaul/whatever).
>>> *  Interesting logic would be needed to deal with constraints to properly share the underlying resources (you could not
>>>     add 16 ap bssid to 2.4 wiphy and also add 16 other ones to the combined wiphy that also uses 2.4 radio most likely,
>>>     for instance).  But I think that logic has to be written
>>>     either way and is not overly worse with this approach.
>>
>> I had some further thoughts on this approach:
>>
>> *  If someone has 2 QCA radio cards, and each radio card has 3 phys, would it be possible to have a 6-link MLO
>>     setup?
>>
> 
> As long as supported frequencies of the radios are not overlapping , it is technically possible to register 6 radios under one wiphy

Couldn't you have MLO links where one is on 5ghz channel 36 and second is on 5ghz channel 149?
Underlying radios could support entire 5ghz band, but would use non-overlapping channels.

> 
>> *  Could two be200 be combined into a multi-channel concurrent MLO setup with this approach?
>>
> 
> By nature, MLO device is multi-channel concurrent. Not quite sure about the
> be200 capability.

be200 is eMLSR, I'm wondering if two be200 could be combined to make an STR MLMR
link.

> 
>>
>> *  For multi-phy arrangements like QCA ath12k and MTK7996, I think the default configuration when the driver
>>     loads should just be the physical phys by themselves (as mt7996, at least, does it now).  This would be fully backwards compatible with
>>     current user-space and operation. 
> 
> There can be configuration knobs in the driver to register it differently...

This is where I'd like to dynamically create them in user-space.

> 
>   But the phys would have netlink attributes that
>> lets user-space
>>     know combined phys (cphys?) can be created on top of them.  User-space that knows about MLO can then
>>     create the cphy(s) as wanted and build sta/vap/whatever on top of the cphys.
>>
> 
> Not quite positive on the combined_phy+legacy_phy design as mentioned in the previous mail.
> 
>> *  For radios like be200 that are already designed to show a single phy to userspace, they would not
>>     need any significant change.
> 
> As mentioned, it is not lot of changes in hostapd/wpa_s. We'll post them once kernel
> part is concluded.

Thanks,
Ben

> 
> Vasanth
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


