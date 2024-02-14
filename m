Return-Path: <linux-wireless+bounces-3592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC45A854DB2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DE51F2AEF9
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5705F845;
	Wed, 14 Feb 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD1VNGcg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553395EE7E;
	Wed, 14 Feb 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926912; cv=none; b=LAosxdQ1O7Mp1zMTO3J8DLUQzg3DKYc96YEnrXv0dJ6ZRmtZIuyMPV6BC3aL8yl5B8Db5o0+tPnBh7iSTwZ6VEVZOFH6uoP/Og0FiweqjOjnLK2hoTD1tpEAnO4ATQt1vJAfJkEplA6XRU1Kf1DukHwb1e0ZyeXu4HlqPOeHjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926912; c=relaxed/simple;
	bh=Keqc0+cgPcB6PjYjiWxkVk/Y5Lw2I720GhazT5VZGrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0wftpzV5vfZXRnGivHoiU5Gt+5FuFJfXEjvqnAj/nSjnybvp2hI5UEjl5u9EbtOvEn6Z3KRkNAbpbpgMZmTDrFMxMv/BeXdoHrUOP5P8KHr7yLD/0M+jetCBvaFvoAF0w7JX+GKkefhaxL9ce6CiWKDHMrgE8C7msg4VCe0hnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD1VNGcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A43C433C7;
	Wed, 14 Feb 2024 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707926911;
	bh=Keqc0+cgPcB6PjYjiWxkVk/Y5Lw2I720GhazT5VZGrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oD1VNGcgZd2xVXjigkrAxO02r5CpaErkSiS0mgkG/iy3pbXiTaruTBolsBIFZpUSW
	 jMQFYHEEAfGGMFT6kHIPKsLWC1zu4Jpi86pUX1gKzGMxrq26uJ/bNeD9WsmMjd7Izh
	 wsloL+StkMG6x5N/U37yiM8h6t35uaM253zVoViSDWPRPtZD8GABst8oj3ANVsyka1
	 5HBxPKnh3+LKwa8hWrU8BvCYPllaqXr71usYSe3BgMeUqZDAKiX8Md6vkE/+OLKh5B
	 w0HHq3Ii8Pzh/dc/dMFYkJeVaMWDvQq9AHAwW+21GL/fG9Zx3AAKQAnAaGnpyhvJ/s
	 THdGimyL1qGnA==
Date: Wed, 14 Feb 2024 08:08:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>, Vinayak Yadawad 
 <vinayak.yadawad@broadcom.com>, linux-wireless@vger.kernel.org,
 jithu.jance@broadcom.com, Arend van Spriel <arend.vanspriel@broadcom.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
Message-ID: <20240214080830.65f6d649@kernel.org>
In-Reply-To: <6641f3f90bdc1d24f3a7fd795be672ce02685630.camel@sipsolutions.net>
References: <309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	<87mss6f8jh.fsf@kernel.org>
	<2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
	<20240213174314.26982cd8@kernel.org>
	<6641f3f90bdc1d24f3a7fd795be672ce02685630.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 11:27:42 +0100 Johannes Berg wrote:
> > It doesn't seem like Arend is afforded much paid time "to look after
> > this".  
> 
> I don't know if that's even the core of my complaint. I don't know if
> it's true, but let's assume Arend _does_ get sufficient time to take
> care of the driver.

Right, right, I know that's not the core of your complaint. More of an
adjacent question about somehow reflecting the "vendor engagement level"

> The core of the complaint here is that regardless of that, Broadcom is
> treating the driver as a dead end, a fork in the road they're no longer
> travelling. So "supporting" that driver may all be well, in the sense
> that it's there for the existing hardware/firmware that it supports.
> 
> But! It's not getting new features nor support for new devices, I don't
> even know if it still supports newer firmware images for the devices it
> already supports. Some new driver support is coming in by way of the
> Apple-support folks, but you saw how that's going ...

To a large extent I think it's on us to define what "paid to look after
a driver" means. Any line we draw, no matter how arbitrary, can be used
by the developers to justify the time spent working upstream to their
management. Or so I hope.

Since Broadcom didn't abandon client WiFi chipsets, wouldn't it be
reasonable to expect someone to work on the upstream driver at least
half time?

> Yet at the same time Broadcom _are_ sending patches to the core wifi
> stack, in order to support new features/offloads for their new firmware
> builds etc. on some/other/new devices. New features for the stack where
> we cannot actually see the driver implementation, maintain it, etc. Not
> that in many cases the driver implementation would be all that
> interesting, but it's still pushing code and work into upstream that it
> will never benefit from.
> 
> So this disconnect really is the complaint: Broadcom want us to maintain
> the stack for them, do things for them like in this patch in support of
> their latest firmware builds, but they definitely do _not_ want to do
> anything upstream that would actually support these new things they
> have.
> 
> At which point, yeah, I'm putting my foot down and saying this has to
> stop. I really don't (**) care about Broadcom doing their own vendor-
> specific APIs if there's zero chance the things they're needed for will
> ever land upstream anyway.
> 
> (**) No longer. I used to think that being more open about this would
> encourage folks to start a journey of contributing more upstream, but
> clearly that hasn't worked out.
> 
> Now this is why I used to be more open: I will also most definitely not
> accept all the vendor APIs upstream if someone later decides they do
> want an upstream driver, and then push all the vendor stuff on grounds
> that "it's used now and we have to support it" ... We don't, at least
> not upstream, what you sell to your customers really isn't our problem.
> 
> (And to be honest, if customers cared, we'd not be in this position)
> 
> > On the Ethernet side I have a nebulous hope to require vendors who want
> > the "Supported" status to run our in-tree tests against their HW daily.
> > As a way to trigger the loss of status. Otherwise it's hard to catch
> > people drifting away.  
> 
> Every day seems a bit excessive? OTOH, every day is a good way of saying
> "you really have to automate this", but then once you do that, maybe you
> don't need to pay anyone to really maintain it, beyond trying to keep
> the tests running?

Ack, I'm curious what would end up happening. It's not the primary
reason for working on a shared test pool just a potential side benefit.

> Also not sure what that status really implies, I think Broadcom would be
> quite happy to just mark the driver as orphaned...

