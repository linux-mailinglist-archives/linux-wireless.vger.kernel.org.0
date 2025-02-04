Return-Path: <linux-wireless+bounces-18419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F99A273DE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 15:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53854188B10E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BED20C03F;
	Tue,  4 Feb 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="d1wvsW8o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075F828399
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677077; cv=none; b=j0J7nt8VMTTfb+O8XEXAadt0g7erZnDcOETKaqS7DDz+l2+hPE0jeNg6C4VM3HuBcBRyfb+q3a2PiDmm7ZbGpuzTvzZffWhssQBd5Oei39K1WBPZvkzbbRliX/uA381oFBgggOW2J1fydSFl8zDJVw2HO8a6lFTVQ8FILrUCOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677077; c=relaxed/simple;
	bh=pRGEMj6CwdcFufaXMJ1MOBH64jly4NY/HgxRe38gmMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YTsJo1YkzDDLNOJ0DUP4jkRcOJ8HRgglNhnW+PagJ9qHI0PzyDT7ySmk9CQQfM1OFlRLCSyMfaBamQoRPHAgi3QWrvf8L+u/3msj3kIuUGfTZzu6TQe4jyhIZAZuQgZy7REYPaHT7LSUl7ZJTTCnUN0joa7pksAi2HTqWZL/c3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=d1wvsW8o; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <955d9e2b-17d4-4679-8886-30db6e376763@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1738677070;
	bh=pRGEMj6CwdcFufaXMJ1MOBH64jly4NY/HgxRe38gmMM=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=d1wvsW8oiFcxin6qElmSwPMdUBEW6qgWQktg81AREDX8jUqih9dkARKCAT+MLgPJV
	 TTv2yEoFrn4197r2zQUNZ9oEclFQXBo6JsxWP7T6Ebxdgzyg4nZFNbtrYkenu337UD
	 5PqQiupFVB3TJpedlpO/tA6hVmCA0d5qyEWegwBk=
Date: Tue, 4 Feb 2025 14:51:10 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Debugfs handling for virtual monitor
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20250204122617.8976-1-Alexander@wetzel-home.de>
 <9e60d3a81e87649eb25e9bbeb599e1ed24050134.camel@sipsolutions.net>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <9e60d3a81e87649eb25e9bbeb599e1ed24050134.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.02.25 13:53, Johannes Berg wrote:
> On Tue, 2025-02-04 at 13:26 +0100, Alexander Wetzel wrote:
>> Create/delete debugfs entry for the virtual monitor interface according
>> to the state of the virtual monitor interface.
>>
>> This fixes the following issues:
>>   1) Debugfs is not getting an entry when the virtual monitor interface
>>      is created.
>>   2) Instead debugfs gets an entry when it's deleted.
>>   3) And debugfs warns, that it already has directory for the virtual
>>      monitor interface every time the virtual monitor interface is
>>      removed again after the first time.
>>
> 
> Started wondering, maybe it should just not have debugfs at all? That'd
> also avoid the potential name clash, and there isn't really anything of
> value there in the first place?

Knowing that we do have an internal virtual monitor interface may be 
interesting in itself. But that's hardly something we can call "real 
value":-) And that way we would solve any name conflict...

Not creating it would just require us to skip 
ieee80211_debugfs_recreate_netdev() in drv_remove_interface() for 
virtual monitor.

When you prefer that, I can send an alternate patch doing that.
Do you want that as standalone patch or as a v2 of with a new name?

Alexander

