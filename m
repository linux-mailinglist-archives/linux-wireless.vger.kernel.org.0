Return-Path: <linux-wireless+bounces-24954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BC0AFCECD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA1E561A2E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04E2E093D;
	Tue,  8 Jul 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="h1eT13hA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C5202C38
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987782; cv=none; b=dexo0nqYmz8Rj7QCI7+8X6/yjYhq/qd/HuvhaYNBVukyto3yNcf5MePYhT9EzZO6gNjkmslvYCAlxgUTyj2HC6oC0dNZuujdfA6F083jUKE1upOHsco4piFnEW/CaKMMveZvzgcUyiIDKbPmfY6VAKVDt59nrORDegLSl6o0gLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987782; c=relaxed/simple;
	bh=FxYfBA+4YGzsQghRuAWNtRTm8g7IxswchT5tHQGJ2WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EpFk/ozzbHkQ8L1fstyIIZrogq2ej5MVS4bQ1YQLAGZDBYqpBCgtQT97nSwTP0By1p6WTEBDEayW+RKrRitTUNrgmMMeByuLbn/Uykjo16ohuL467HiDSyalscCVQriuDptALNaEHJZoYqw8Lik3nTp3Bdr3as+IIkJyPZg7l3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=h1eT13hA; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7B4F72A5C34
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 15:16:20 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ED4C31000B0;
	Tue,  8 Jul 2025 15:16:11 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.36.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4EF7613C2B1;
	Tue,  8 Jul 2025 08:16:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4EF7613C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1751987771;
	bh=FxYfBA+4YGzsQghRuAWNtRTm8g7IxswchT5tHQGJ2WY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=h1eT13hAqOGqJYjDqgerRZSGjPfaOfHRk15OH39CFCccnr776v6nBxkxvnnm2dqxq
	 OdTXk0ANZF3bkEcLu2mUsoyAgBS9iczx7+3WjunCrAQaqI+EMmHc7BQGTWI/6AG+TB
	 ZVZNaQ4fF2CPpXo+xJ2wRL7jLlV+BgCAdF6DiJCQ=
Message-ID: <9161a3ba-e5b7-4cbf-ae1e-242e1baf5040@candelatech.com>
Date: Tue, 8 Jul 2025 08:16:10 -0700
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
 <5d0ee94c-88b0-41c3-a850-e5942a2982ca@candelatech.com>
 <ca3395ac1d47fe25b57df7da692a7891f02d88d2.camel@sipsolutions.net>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ca3395ac1d47fe25b57df7da692a7891f02d88d2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1751987772-4H5_Bj06pI98
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1751987772;4H5_Bj06pI98;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 7/8/25 07:46, Johannes Berg wrote:
> On Tue, 2025-07-08 at 07:32 -0700, Ben Greear wrote:
>>
>>
>> So I added new counters, and I wanted them named to indicate it is what is reported by
>> the driver, not something specified by the mac80211 stack.
> 
> I'm not sure what you're arguing. I know you did. I'm saying you
> shouldn't have done it in this 1/3 patch, but rather in 3/3 or maybe
> 4/4...

So you want this moved out of the first patch too?  That makes no sense
to me, but if you want it moved, let me know to what patch so I don't
have to guess and go through all of this again.

+		if (acked || noack_success) {
+			link_sta->tx_stats.rep_packets++;
+			link_sta->tx_stats.rep_bytes += skb->len;
+		}
+

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


