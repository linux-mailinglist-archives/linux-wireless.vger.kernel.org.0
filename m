Return-Path: <linux-wireless+bounces-13521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AE1990FAB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C6B1C2303A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 20:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46D1D90AC;
	Fri,  4 Oct 2024 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="VI3TTj1u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A91D8DFD
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069544; cv=none; b=Rc1xZdkoeZqBuMSrzu3mctCph4i0f7iTYqQjNzUCIrl67bguJ1gyb0Z/6VjCIzGdEwErdip8RuS6O3+LOw1gSbZDpyfO1TSH7PNZ0S5KsiPfzRf2xCakpEeMuIy8nJk4NfwkAgt9qOrJEkOydJBuxH38zmMA7Jz5QvzQgQhGh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069544; c=relaxed/simple;
	bh=I6dS25FZ6+z7FaVOKobmQQ+yIGb8HYVDKgWBNaLgutk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meIEbwGFP7aaIwQJ6YuVnIAXD2iUUAlxbdAU/xZ2mj1Ttm8bosUHr41RyNZxHBHWeXGvXgnhLBvS6KXnetaw0seBS04iwKaTqDWCmsz7n2tteFUCO3XjkxG7sSKv+5cX5Y2n/c0I/wRBkGRYedtjHbBARsXKvFtrFwxEVx0nBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=VI3TTj1u; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 46AA034006F;
	Fri,  4 Oct 2024 19:18:55 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id AB32913C2B0;
	Fri,  4 Oct 2024 12:18:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AB32913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728069534;
	bh=I6dS25FZ6+z7FaVOKobmQQ+yIGb8HYVDKgWBNaLgutk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VI3TTj1uWI/r3iz0u/wzVd3uLGxDghzj5V3Jeq8FbC37fKXL5Sa3U8qikFx/UshbV
	 PhQyGTvcDrd1dXj9J4ycW0RRdd3iergp5YeE+iP7o8sE76/V4IqnJeeec4PI6/oYLZ
	 24p0K90Dy6Mhlvnzx9nlSE3OhhnrCQoyimeiJEs4=
Message-ID: <d1e75a08-047d-7947-d51a-2e486efead77@candelatech.com>
Date: Fri, 4 Oct 2024 12:18:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Missing scan results with SCAN_FLAG_COLOCATED_6GHZ set
 (Ath11k/WCN6855)
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <cfb00919-678f-408d-9fb9-83fc24fee197@gmail.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <cfb00919-678f-408d-9fb9-83fc24fee197@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1728069536-ex0oB6e5GI3J
X-MDID-O:
 us5;ut7;1728069536;ex0oB6e5GI3J;<greearb@candelatech.com>;aae89045ff394e1bf2215a139f564027
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/4/24 11:46, James Prestwood wrote:
> Hi,
> 
> I've noticed that when setting the colocated flag much of the scan results are not appearing when they should be. This was seen in a large warehouse where our 
> network/SSID was using only the 6ghz band. There were other networks on 2.4/5ghz though, which maybe is having some effect, but those networks are not 
> broadcasting on 6ghz.
> 
> This first came to my attention when the majority of our clients were experiencing horrible signal quality. Upon looking at the logs and nl80211 messages to the 
> kernel IWD was issuing both limited 6ghz scans as well as full spectrum scans and only showing a few 6ghz results, like 1-2 BSS's which should not have been the 
> case. I was able to scan manually using "iw scan" and I saw all the expected BSS's. I isolated it to the fact that IWD was setting the SCAN_FLAG_COLOCATED_6GHZ 
> and removing that flag resulted in all the BSS's showing up in scan results. Note, that with or without the flag all the 2.4/5ghz BSS's were showing up without 
> a problem, it seems completely isolated to the 6ghz band.
> 
> The NEW_SCAN_RESULTS event was indicating the kernel had scanned all the expected frequencies we were asking to scan, but the results were mostly empty for 
> 6ghz. Only ever the connected BSS would show up and _sometimes_ another BSS, but generally not.
> 
> I'm trying to read through the code associated with the COLOCATED flag, but its not exactly intuitive (to me at least). I'm not sure if this is something with 
> mac80211 or at the driver level. I really don't have anything to compare it to as ath11k is the only hardware available at this warehouse with many APs around.
> 
> I'm looking for some guidance on if this is expected behavior with the colocated flag, and if there is any concern with including it unconditionally on every 
> scan. If it has unintended consequences like this, generally, across multiple drivers I'd like to re-think its use in IWD.

I had some similar issues using hostap, and hacked it to do every 4th or so scan with that
flag set differently.  Hopefully that lets the 'fast' scan work when it can, but still lets one
scan the hard way...

Possibly there are driver concerns too, I was using Intel be200 when debugging this.

Thanks,
Ben

> 
> Thanks,
> 
> James
> 
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



