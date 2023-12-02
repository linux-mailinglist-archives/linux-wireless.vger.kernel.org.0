Return-Path: <linux-wireless+bounces-332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F79D801E1C
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 19:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600AA1C20860
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619D08833;
	Sat,  2 Dec 2023 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDRYe9Ec"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408322F3E;
	Sat,  2 Dec 2023 18:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD5EC433C7;
	Sat,  2 Dec 2023 18:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701542816;
	bh=Rgi3ddaSq/HnZV4GLA+Aa7G8rUV64eKojW6PMPBNtlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NDRYe9EcyY7hvm5QXWy+l2EWvYbBCj/Tqx08098S/0f8IFTnSYllNmnPhOI1twK8i
	 roGybv/M+fJk5vg0Nvr8vx5t6eCFNqeVb8jRtvAYXBtxligNPo5pk9jcyDHkSzRMG0
	 dJb1t51kj3qsBQc1NtEpeAWzv5pf1ZZtuRROopMUBvFiwyWYJLhHEmr7c8a+N6Ecot
	 neh8uVaH4V4z/ul/8nNp1PTkRSfeqnC68KB3l7am/fwIDmxHooSnh6jZlUHQdno8e+
	 T1FtyAU4V/4O+4do9ly+ppNIVniyDdED1Pzu7GinmiLaIlda8LKeKRfhvW4JCMp35v
	 Qw8C9pVLoviEQ==
Date: Sat, 2 Dec 2023 10:46:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] netlink carrier race workaround
Message-ID: <20231202104655.68138ab4@kernel.org>
In-Reply-To: <339c73a6318bf94803a821d5e8ea7d4c736dc78e.camel@sipsolutions.net>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
	<20231201104329.25898-5-johannes@sipsolutions.net>
	<20231201162844.14d1bbb0@kernel.org>
	<339c73a6318bf94803a821d5e8ea7d4c736dc78e.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 02 Dec 2023 11:06:36 +0100 Johannes Berg wrote:
> > Would it work if we exposed "linkwatch is pending" / "link is
> > transitioning" bit to user space?  
> 
> Not sure, not by much or more than what this did? It's basically the
> same, I think: I exposed the carrier_up_count at the kernel time, so if
> userspace hasn't seen an event with a value >= that it knows the link is
> transitioning.

The benefit being that it'd work for everyone, without having to add
the carrier count in random events?

> > Even crazier, would it help if we had rtnl_getlink() run
> > linkwatch for the target link if linkwatch is pending?  
> 
> Sure, if we were to just synchronize that at the right time (doesn't
> even need to be rtnl_getlink, could be a new operation) that'd solve the
> issue too, perhaps more easily.

I was wondering about the new op, too, but "synchronize things please"
op feels a little hacky. rtnl_getlink returns link state, so it feels
somewhat natural for it to do the sync, to make sure that what it
returns is in fact correct information. No strong feelings, tho.
rtnl_getlink does return a lot, so maybe a new rtnl_getcarrier op?
Or we can make reading sysfs "carrier" do the sync?

