Return-Path: <linux-wireless+bounces-29249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBB0C7C7F1
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 06:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD66035AE73
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Nov 2025 05:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94F296BBB;
	Sat, 22 Nov 2025 05:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KpIMLLJT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1E8248C;
	Sat, 22 Nov 2025 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763789171; cv=none; b=fH/pTx7DCnqpAU8h+vjaJ/s2POIjJJU3b7ARGi3LCN43xGigSMSZx5HYcVmVeL8Z20Es/Qxkufs1IqBkBAQWROrkgHfPbBg1BDXuhvbt5RQB/5V70uPaau+0hhXWgBzTmr7uFj/Xggr90L3Rxmi1Er17JRVQXLLMFozi4L1yV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763789171; c=relaxed/simple;
	bh=kwljizUI98j6FDC5giRb816TYPaeHDktNIIy6PsqgNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeLWRs+Hh5gYoPBmhK1FXe42ShOR65Z5bSk9zI7drqnxdE1XJflvRbUmZHDBaCrtCorvYl838UsM23QPdS4NWw4ucStriRTm00ULyfmRXFXHyGXQNzEC8P9ytrafk1fXZNwAzIuvVUUipz6QGXchPwDNldgN1cC2Z2bHq9Mh53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KpIMLLJT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=c5V9J0beKdgdfQfPkvHz2sh9GzdYtkBFfZSbSS2wzd4=; b=KpIMLLJTRTnIsWNcdPxySN5uo8
	ui1H2aRsIHhXcYELwUFyXWRTSL1I0+tsjz5wflP0Wo7Q9esjveURT/Ppn0TuiNzR5LJORBHbVon/8
	WZl428j9WvlX7ll7tCBTRUWx9mtBdStjwbuWqWjAwZVH7O7hxeB0wkzWt3jKO+JYUdHFORRpmBYjA
	UC60IMyJqsQ6MgNQOHLHgLnxsPSVbyfPlLy7uUibBkzZEeR9bL5Trdu6d/XZnfdlvwxFIBUzuCLn2
	9KKc73M3cH7wlvX1hTC5S6lMNI4Yyu0Sd2CuLUSn9mnt+gAyL11sWYoYuEzImUddaTNxXRZHDBDZu
	jAaE5Tlw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMg8P-00000009HTv-0gTg;
	Sat, 22 Nov 2025 05:26:09 +0000
Message-ID: <2c849887-ce85-4f1a-b180-5f29211aa625@infradead.org>
Date: Fri, 21 Nov 2025 21:26:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath: wil6210: fix a bunch of kernel-doc warnings
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
References: <20251117020213.443126-1-rdunlap@infradead.org>
 <aSBjbqQtQFgRTDS0@horms.kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aSBjbqQtQFgRTDS0@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/25 5:04 AM, Simon Horman wrote:
> On Sun, Nov 16, 2025 at 06:02:13PM -0800, Randy Dunlap wrote:
>> scripts/kernel-doc.py reports 51 kernel-doc warnings in wil6210.h.
>> Fix all kernel-doc warnings reported in wil6210.h.
>>
>> Several comments are changed from "/**" to "/*" since it appears that
>> "/**" was used for many non-kernel-doc comments.
>>
>> - add kernel-doc for missing function parameters
>> - add one function "Returns:"
>> - correct kernel-doc struct name to match actual struct name in 2 places
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> ...
> 
>> @@ -444,8 +444,7 @@ static inline u8 mk_cidxtid(u8 cid, u8 t
>>   * parse_cidxtid - parse @cidxtid field
>>   * @cid: store CID value here
>>   * @tid: store TID value here
>> - *
>> - * @cidxtid field encoded as bits 0..3 - CID; 4..7 - TID
>> + * @cidxtid: field encoded as bits 0..3 - CID; 4..7 - TID
> 
> Hi Randy,
> 
> I wonder if it would make sense to move the @cidxtid line
> so it is above the @cid line. In which case the order of
> the documentation of the parameters would match their order
> in the subject.

I've looked at a lot of kernel-doc comments. I prefer in-order
comments, but so many of them are out of order that I don't bother
with them.

> But either way, this patch looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>>   */
>>  static inline void parse_cidxtid(u8 cidxtid, u8 *cid, u8 *tid)
>>  {
> 
> ...
> 

thanks.
-- 
~Randy


