Return-Path: <linux-wireless+bounces-24947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03592AFCCD4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 15:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7D2483FE1
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B672DE6FB;
	Tue,  8 Jul 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="RsqmkiKy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5757E0FF
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983124; cv=none; b=HDivkr2NzrRt4nhR54glbx/xbVCzEAhsEQWcuElPmeaEA3fJM91QIetGDefcrDOMCTa1VltDD2P72NxyJs0zyy9zoMm/tS1Q90wJUVLKNoshLa5FDNoCjnBxAtP6lppJDqQlu9xWecNgHkyoovWhJMoMILGZcttPV+b7dwYkKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983124; c=relaxed/simple;
	bh=4umMAHuU5IHfjKXbq/rvqDMamj4cd1a/Joo8IC7y3y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YdHMK0pE49Nlnq4SOR8TLOHzex9zK2fTLb/M69XF1eTqp1IYLm+NpQKzQ0ArWQUg0gbL7yCgEeOrJtKWK0HEmAhprP5XU9kWEABi2rf5V98nJRb4j/rvsyfXD1eesMvri1ZFROs0BBdde1l3xkcwh27rq953vqFOTR5824Xhj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=RsqmkiKy; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 943362C5DBC
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 13:58:41 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7D9D01000F1;
	Tue,  8 Jul 2025 13:58:34 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.36.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6F0F113C2B1;
	Tue,  8 Jul 2025 06:58:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6F0F113C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1751983113;
	bh=4umMAHuU5IHfjKXbq/rvqDMamj4cd1a/Joo8IC7y3y8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RsqmkiKyStWI1julADaVgbwkw8R9UC2XsdZBA9QWsMiKr9oYif7b5ZBTEJpFNqXEQ
	 2xpKOm/g8QBfaPgjwosYe730XyhHHJvT7EPrY1cIIc7pahPmLg2R3SWBSRGfxaJBPd
	 jPYB2nfw5zdaFi32QPKO5pFl7xAiHy18hJDEIwqE=
Message-ID: <de881905-a708-4f96-b3dc-16d950322218@candelatech.com>
Date: Tue, 8 Jul 2025 06:58:33 -0700
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
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <54ede5f58c3abc7de58010e492283c7930a2495f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1751983115-qbrcMmWTA4q2
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1751983115;qbrcMmWTA4q2;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 7/8/25 05:31, Johannes Berg wrote:
> On Wed, 2024-12-18 at 15:25 -0800, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> For drivers that can report the tx link-id, account tx
>> stats against that link.  If we cannot determine tx link,
>> then use deflink.
> 
> According to all the RX stats discussion [1] you need some changes here,
> so I'd appreciate if you could take a look and rebase/resend.
> 
> [1] https://lore.kernel.org/linux-wireless/c22a9e7e-d0f7-477b-b732-c2454a0ac904@quicinc.com/
> 
> 
> And please, as I very frequently keep asking you, don't mix different
> things into a single patch (such as 'rep_packets'/'rep_bytes' in this
> patch). By insisting on not splitting your patches properly before
> submitting them you're effectively saying your time is more important
> than mine, and I don't appreciate that. All that achieves is that I
> don't even want to look at your patches.

As far as I can tell, I split them properly.  I added new counters in one
patch you reference above, and I named them as I think they should be named.
In another patch, I renamed existing variables with a commit message as to why.

I am currently working to rebase our patches on 6.16, and can post a new
stats series once we can verify that the patches work on 6.16.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


