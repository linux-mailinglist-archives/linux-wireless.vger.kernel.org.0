Return-Path: <linux-wireless+bounces-30831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCDD20FCF
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 20:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B793033712
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D74308F03;
	Wed, 14 Jan 2026 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tYyySsep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2842BE64A;
	Wed, 14 Jan 2026 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418127; cv=none; b=h5cJctwTss/OcO79NVCxKxQxlWREF7/RL8ZeKXmMucF0wytfJx0qvWKKcZCGb2vT+PxiiCAv4pUkdr61CpVQ+BMfLRldnBlAeiDEkECTNoSKttF60zra4wmuZqzvHIcVWMVsnl+wFasGVftU0+g4xZQ6UkDc1EoN8l/O2dGxwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418127; c=relaxed/simple;
	bh=eHQT2XiH/Hn4kXqGCKx+RQZ3zir8LXmWrAHWs12I3Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=depclzLb36pWAiqYRFCJ03KbE/+DwZN0G2XKbq6V6qZFudLi1XOW4Js6JJl+PVLHFa4ZP5LGP4DjClfj2ZTU+LJsOd8i5+jUpVRdNgvay3h9ywp/ejW+VYxf4qPGCtwV8jklYAC0bCL4cqcUJ+6Iw9BUszGMKtuZZxIHLpGlWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tYyySsep; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ohUDHpsnMco4Xgo3XSm0EfBYp3A9TL5K/dhQ/vb/yM8=; b=tYyySsepYrZU3aHlr8hprCJPM1
	wmxjpsisNsFntxxiKjikUG5ZHeNBUEBPE98LAdplMyQSjcun2jc68T6t6qZCnWRGE73grbuG/IB+Z
	zgDEOvrYmHXCuOFAcc00HqtNfJ3OotCQJJgw3C5eWw7CfcBDjDtuj63ekx9hBqV6OuKkRLOzgCO0s
	Tu1tLbsScbDBH8goYXPETk4lrV8EZkdZChE8602Qt5UZ4OrzidTtiz0tZj5LocXKGdsxFzqPwz8Cc
	/oa81Bu3J5ycpAnBbWleUOSIMf4EYBr+2Pq4yx7nZP/4V6x91O1Y6Fu7K7Ri0wpF9O3Wxpin1YzWO
	/iP9f0SA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg6Kz-0000000ARnD-2UOU;
	Wed, 14 Jan 2026 19:15:25 +0000
Message-ID: <df90c466-a28a-49ea-8f34-895bf50c1cfb@infradead.org>
Date: Wed, 14 Jan 2026 11:15:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath9k: debug.h: fix kernel-doc bad lines and struct
 ath_tx_stats
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20251117020304.448687-1-rdunlap@infradead.org>
 <cf6b81ea-3ab2-420a-ac10-e847be54c9c3@oss.qualcomm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cf6b81ea-3ab2-420a-ac10-e847be54c9c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/14/26 7:53 AM, Jeff Johnson wrote:
> On 11/16/2025 6:03 PM, Randy Dunlap wrote:
>> Repair "bad line" warnings by starting each line with " *".
>> Add or correct kernel-doc entries for missing struct members in
>> struct ath_tx_stats.
>>
>> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:144 bad line:
>>   may have had errors.
>> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:146 bad line:
>>   may have had errors.
>> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:156 bad line:
>>   Valid only for:
>> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:157 bad line:
>>   - non-aggregate condition.
>> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:158 bad line:
>>   - first packet of aggregate.
>> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>>  'xretries' not described in 'ath_tx_stats'
>> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>>  'data_underrun' not described in 'ath_tx_stats'
>> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>>  'delim_underrun' not described in 'ath_tx_stats'
>>
>> Fixes: 99c15bf575b1 ("ath9k: Report total tx/rx bytes and packets in debugfs.")
>> Fixes: fec247c0d5bf ("ath9k: Add debug counters for TX")
>> Fixes: 5a6f78afdabe ("ath9k: show excessive-retry MPDUs in debugfs")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Toke Høiland-Jørgensen <toke@toke.dk>
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: linux-wireless@vger.kernel.org
> 
> I'm picking this up, but my automation noticed there are still kdoc issues:
> Warning: drivers/net/wireless/ath/ath9k/debug.h:138 struct member 'txeol' not described in 'ath_interrupt_stats'
> ...
> Warning: drivers/net/wireless/ath/ath9k/debug.h:138 struct member 'mac_sleep_access' not described in 'ath_interrupt_stats'
> 19 warnings as errors
> 
> Are these handled elsewhere, or will they need to be handled later?
> 
> /jeff

Hi Jeff,
I didn't attempt to address those warnings. They need to be handled
later by someone who knows that they are.

-- 
~Randy


