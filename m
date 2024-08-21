Return-Path: <linux-wireless+bounces-11746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5270E959F45
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 16:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E317282863
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4001AF4EE;
	Wed, 21 Aug 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KdGfy99k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127711AF4D3;
	Wed, 21 Aug 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249164; cv=none; b=dRA1LVpQh7P8LFndfIh7iKGetzMP79JO19BDQy1VNMA/NqWk8LVJtztN333u1++EKYEe2HSO5eqYmuamb3YgZ5u5ZyMYYkKJt26rR/o6UEgibeI+OUgc4e0LFOVZGge6Z1mH5v3pIE97Wd1evNr8P/71yR+roWeJsSzID9Ow2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249164; c=relaxed/simple;
	bh=OupUKgDix1Aqr3zi3FS/NJ/qh5GuwXL1qcjGy7ucROc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPb5j7Gx6IH4hN862wrBt8uxiX6u9Ct2wVNXc7Sy04/8p37P0fvyoS84v/oejfnhmoUKW4NFLR0Oon+RuRnF1pVXVY452PlwyACvpx8l1q8BkkBmZ0/r9OVxJAEIjU3KTK6MCH+yousqcOCZVXQL0veIyWkyf0Ln+rt8K12Fb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KdGfy99k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19848C32781;
	Wed, 21 Aug 2024 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724249163;
	bh=OupUKgDix1Aqr3zi3FS/NJ/qh5GuwXL1qcjGy7ucROc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KdGfy99kVEc5kLY88y0BjKR7uoOnoihZLogWULGzyhcMjrDxUKN6MUJ3HltR9/9af
	 IGVFQxQ+zXp9SRQihUjVKPpHubWm6zEo6e1tX0hsmVo7X53u/wjrn/O5i9uAcyV5/i
	 k+kJP3OityZyhIGgFqUnyFFn4YF9NceoMub0eWWo=
Date: Wed, 21 Aug 2024 22:06:00 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: color Ice <wirelessdonghack@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, mark.esler@canonical.com,
	stf_xl@wp.pl, tytso@mit.edu
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <2024082106-flagman-plausible-cb40@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240814055816.2786467-1-wirelessdonghack@gmail.com>
 <91e19cf3-216b-48ac-a93d-f920dd2a7668@rowland.harvard.edu>
 <CAOV16XEsgkLWz3rOQsAdve-qKsPEDw-QxJNoo4hJfXdLnowHfw@mail.gmail.com>
 <2024081946-designate-dioxide-c59d@gregkh>
 <CAOV16XFYeWdT4tSpLWoE+pCVsNERXKJQCJvJovrfsgMn1PMzbA@mail.gmail.com>
 <2024081904-encircle-crayon-8d16@gregkh>
 <CAOV16XEjJT6Oe7PX7HjqEaT5tpX0MqTOZy6=akEKFhtk0emOzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOV16XEjJT6Oe7PX7HjqEaT5tpX0MqTOZy6=akEKFhtk0emOzg@mail.gmail.com>

On Wed, Aug 21, 2024 at 04:25:36PM +0800, color Ice wrote:
> Dear Ubuntu Team,

We are not affiliated with Ubuntu at all, sorry.  Please be kind.

> I have encountered a race condition issue in the RT2X00 driver,
> specifically related to the function rt2x00usb_work_rxdone. The issue
> manifests as a kernel NULL pointer dereference, which causes the
> system to crash. Below is the detailed analysis and my suggestions for
> addressing the issue.
> 
> Problem Analysis

<snip>

This mostly looks like it was created with chatgpt or something like
that, please do not send us things like that.

Again, work with your professor at school who has assigned you this task
to complete it, don't force us to do the work for you :)

If we get a chance, we'll look at it, but note it's way down the
priority list for most of us.

thanks,

greg k-h

