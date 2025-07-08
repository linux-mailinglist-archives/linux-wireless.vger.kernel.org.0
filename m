Return-Path: <linux-wireless+bounces-24951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4803AFCDA9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 16:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949293B5721
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BED14883F;
	Tue,  8 Jul 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="b69jtPoQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB05E2F85B
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985147; cv=none; b=fOanLCzXTSSCZnIi4E8BDcOayXWVEthZsMgs/yRpX84eVhJVnHhkvdy4J/TG3xu6OhkcLlizBwAJPtKiSXCl43J7i5n6VEKa6hJV3TQE1eFM3I85cjviN1VLCgT14K7psqX5I6bsgbbxOh0h1ZK3ajQh7pisa8/ffk4ovhXNakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985147; c=relaxed/simple;
	bh=andfVfZehIP0SzesDkK31bWeUUG1PyNr+73ANLQOn/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OIE3hqd+HoWwnopAMBiMVfRqG5ox/n6CoCeng0YjNDzuSVRssyW2lO4II7z/4IkfC/fxTMLPtVgMgAvOQ6GZAKsfsMgQ1nq0344Hu7FTUkzZ6iZlT/mJDz2tCd2FjkYMyhLxjZm+eeURDD3i4KL8RtLwMutdgQkFD+f5/Y6Etik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=b69jtPoQ; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 34CC924008A;
	Tue,  8 Jul 2025 14:32:17 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.36.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id BE46113C2B0;
	Tue,  8 Jul 2025 07:32:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BE46113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1751985125;
	bh=andfVfZehIP0SzesDkK31bWeUUG1PyNr+73ANLQOn/E=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=b69jtPoQmJkHlTIrZGdcBSKq6QrgBMcvYoQUFJtO15up7MSCL6T8Hp3eTWw5j5uru
	 fGPa+6zIpGuBVXWoxpjFGaV+C3yb+zquExjVjP7ivkyGKr6zD48OjDehCQAvy8dhwo
	 i3SvSIVLPImfHBCAVgBRCENjYTv4chdlE+moiUo4=
Message-ID: <5d0ee94c-88b0-41c3-a850-e5942a2982ca@candelatech.com>
Date: Tue, 8 Jul 2025 07:32:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] wifi: mac80211: Assign tx-stats to the proper
 link.
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20241218232519.3156080-1-greearb@candelatech.com>
 <54ede5f58c3abc7de58010e492283c7930a2495f.camel@sipsolutions.net>
 <de881905-a708-4f96-b3dc-16d950322218@candelatech.com>
 <dfc23d5813928b138ff531734f75d7190d7450db.camel@sipsolutions.net>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <dfc23d5813928b138ff531734f75d7190d7450db.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1751985138-mTGLbtqHn-7D
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1751985138;mTGLbtqHn-7D;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 7/8/25 07:21, Johannes Berg wrote:
> On Tue, 2025-07-08 at 06:58 -0700, Ben Greear wrote:
>> On 7/8/25 05:31, Johannes Berg wrote:
>>> On Wed, 2024-12-18 at 15:25 -0800, greearb@candelatech.com wrote:
>>>> From: Ben Greear <greearb@candelatech.com>
>>>>
>>>> For drivers that can report the tx link-id, account tx
>>>> stats against that link.  If we cannot determine tx link,
>>>> then use deflink.
>>>
>>> According to all the RX stats discussion [1] you need some changes here,
>>> so I'd appreciate if you could take a look and rebase/resend.
>>>
>>> [1] https://lore.kernel.org/linux-wireless/c22a9e7e-d0f7-477b-b732-c2454a0ac904@quicinc.com/
>>>
>>>
>>> And please, as I very frequently keep asking you, don't mix different
>>> things into a single patch (such as 'rep_packets'/'rep_bytes' in this
>>> patch). By insisting on not splitting your patches properly before
>>> submitting them you're effectively saying your time is more important
>>> than mine, and I don't appreciate that. All that achieves is that I
>>> don't even want to look at your patches.
>>
>> As far as I can tell, I split them properly.  I added new counters in one
>> patch you reference above, and I named them as I think they should be named.
>> In another patch, I renamed existing variables with a commit message as to why.
> 
> This patch said:
> 
>> For drivers that can report the tx link-id, account tx
>> stats against that link.  If we cannot determine tx link,
>> then use deflink.
> 
> which I think we can agree should be only a refactoring/fix of the link
> that the counters go on?
> 
> But you also have
> 
>> +		/* Packets and bytes reported transmitted (per link) */
>> +		u64 rep_packets;
>> +		u64 rep_bytes;
> 
> which was probably meant to be in the third patch?

In today's linus tree, the code looks like this:

        /* Updated from TX path only, no locking requirements */
         struct {
                 u64 packets[IEEE80211_NUM_ACS];
                 u64 bytes[IEEE80211_NUM_ACS];
                 struct ieee80211_tx_rate last_rate;
                 struct rate_info last_rate_info;
                 u64 msdu[IEEE80211_NUM_TIDS + 1];
         } tx_stats;

There are no counters for tx bytes or tx packets (I think the ACS classification
counters are already used for other purposes).

So I added new counters, and I wanted them named to indicate it is what is reported by
the driver, not something specified by the mac80211 stack.

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


