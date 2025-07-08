Return-Path: <linux-wireless+bounces-24968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5FCAFD55B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAA41BC2DF5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027C2E36FE;
	Tue,  8 Jul 2025 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Z10IAwa/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A223DE
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995943; cv=none; b=n9VH+IF4K6O0mmMjfKPW9uiKb8APQNAS2CYLkwXlsi5zjEmsJWmuFVYR+UwVFGgwrYq0rFd23rIHbKgcuq9oToIC7yCDaRO3jWsKiPBPObQ09qmKzLnwebanVw3PG3sAWRivOjMYrG+1yrfhxYrdT4DhnH1wqrTRWCrAqAtklD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995943; c=relaxed/simple;
	bh=glHPRruJ807y2ZLzo9q3PnxAzQv6b48se2k1OBmxgvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ehzLHlbfwnhYPfYXL9XlPzj/FnTe10NQxTPYryNiFu7L1luBXx4cJuUW5kIqMobQXWi2CAQlx1PGX2h7AE7xu2oGTd+4StORt30EZwDgubzJjQrt1Ety5DuHT4Ot9xa1i0+eOBTgq24sfqphj1ZbA9lU7Ye0OL+h3Hxl1aj4pJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Z10IAwa/; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 064672C5F0B
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 17:32:21 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 43C141C0078;
	Tue,  8 Jul 2025 17:32:12 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 25D4F13C2B0;
	Tue,  8 Jul 2025 10:32:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 25D4F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1751995924;
	bh=glHPRruJ807y2ZLzo9q3PnxAzQv6b48se2k1OBmxgvc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Z10IAwa/4RI/gg1JCVDnT570Wtold2UfS/7PcQ1Rs/mmcWy6OIQBrB0ts2fRMW6tx
	 ZYDLHPxGwkvsngHZuzXYbJOhGRofgK9/nOPCICN+gMA4esboZXxy7kXe4JacB0pdyk
	 r9GXA4h/HXQdY1yG0kLqEwFJ6R4cGx6I1AoPCuN8=
Message-ID: <1ce17d3b-90cc-c0d0-6146-bcd5de0c5ba9@candelatech.com>
Date: Tue, 8 Jul 2025 10:32:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 1/3] wifi: mac80211: Assign tx-stats to the proper
 link.
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20241218232519.3156080-1-greearb@candelatech.com>
 <54ede5f58c3abc7de58010e492283c7930a2495f.camel@sipsolutions.net>
 <de881905-a708-4f96-b3dc-16d950322218@candelatech.com>
 <dfc23d5813928b138ff531734f75d7190d7450db.camel@sipsolutions.net>
 <5d0ee94c-88b0-41c3-a850-e5942a2982ca@candelatech.com>
 <ca3395ac1d47fe25b57df7da692a7891f02d88d2.camel@sipsolutions.net>
 <9161a3ba-e5b7-4cbf-ae1e-242e1baf5040@candelatech.com>
 <b1d4ec44d7ce817ffb98db7293578c6a9b1351fe.camel@sipsolutions.net>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <b1d4ec44d7ce817ffb98db7293578c6a9b1351fe.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1751995933-4OXPnZKAz-Zl
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1751995933;4OXPnZKAz-Zl;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 7/8/25 08:26, Johannes Berg wrote:
> On Tue, 2025-07-08 at 08:16 -0700, Ben Greear wrote:
>> On 7/8/25 07:46, Johannes Berg wrote:
>>> On Tue, 2025-07-08 at 07:32 -0700, Ben Greear wrote:
>>>>
>>>>
>>>> So I added new counters, and I wanted them named to indicate it is what is reported by
>>>> the driver, not something specified by the mac80211 stack.
>>>
>>> I'm not sure what you're arguing. I know you did. I'm saying you
>>> shouldn't have done it in this 1/3 patch, but rather in 3/3 or maybe
>>> 4/4...
>>
>> So you want this moved out of the first patch too?  That makes no sense
>> to me, but if you want it moved, let me know to what patch so I don't
>> have to guess and go through all of this again.
> 
> Of _course_ I do, I don't know why this is controversial to you. Don't
> actively _hide_ something in a patch that purports to change something
> else entirely. This is a whole new feature, completely unrelated to
> "assign tx-stats to the proper link".

I feel we are not communicating well at all and that your complaint about
the patch is without technical merit.  Accusing me of trying to hide something
is just pure insult.  I am going to take a break from this,
and will re-post a new series later if I can find the motivation.
Anyone else that wants to deal with this is welcome to it.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



