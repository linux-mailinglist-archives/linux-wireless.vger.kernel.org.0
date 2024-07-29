Return-Path: <linux-wireless+bounces-10614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B193F326
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44114B20AEC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5BA13A258;
	Mon, 29 Jul 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qdG7V54A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811025F873;
	Mon, 29 Jul 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250242; cv=none; b=EE2GXg4eYW3wgzShemalSa4B0dpKZXBxki7kf5bocMKgMZiK1sXVFnJm83YUtbprlD8K6tib1qVBNzjNuTe0Zlgg/nSSt8xSKRoQW0ktnu+60T4jhYT61pFuSz54/D+kof6lr56FPo9bswMRHf05eNTm0zvsPY9IuxBkaZ58W3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250242; c=relaxed/simple;
	bh=LnRwNbodf/bqj7+CHx905Rbrn2Ad1v38MIm4mDrcPxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBpSV46pR1OyvmaXlQqWe4Nhyi70q4fBQ+9h5rDt7XXezDg/Hf8Ax7iwiaag9BDAmf3QeYS9U0cDbIvqI6O+5OpV6mjZ/M5UmA4OqICm7bSGNJW2+9Zo9LDpv7tNqsaRkLwlfj2ENizPjNNZIf8oC1hAIaaYyJcmaH/PPI7qZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdG7V54A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DE1C32786;
	Mon, 29 Jul 2024 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250242;
	bh=LnRwNbodf/bqj7+CHx905Rbrn2Ad1v38MIm4mDrcPxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdG7V54A0NCu3D7ECvsW95BYaNil3nLn6yOVAz8JxRBPAilEeSk/LKgiDhXrjd/eH
	 K7Q4Q29lbjpYmFBOhphTXjYnjlFjwBjwU5lD8bc0LvfJ8ynnYQoYZwZ+ClWUh9UXkU
	 9rkbgnTjXEqOUijYWDxw6RQtprBqW3aoHvi1zlhU=
Date: Mon, 29 Jul 2024 12:50:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: johannes@sipsolutions.net, sashal@kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org,
	stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
Subject: Re: [PATCH v5.15] wifi: mac80211: check basic rates validity
Message-ID: <2024072903-chihuahua-contrite-c1a6@gregkh>
References: <20240727125033.1774143-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727125033.1774143-1-vincenzo.mezzela@gmail.com>

On Sat, Jul 27, 2024 at 02:50:33PM +0200, Vincenzo Mezzela wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28 upstream.
> 
> When userspace sets basic rates, it might send us some rates
> list that's empty or consists of invalid values only. We're
> currently ignoring invalid values and then may end up with a
> rates bitmap that's empty, which later results in a warning.
> 
> Reject the call if there were no valid rates.
> 
> [ Conflict resolution involved adjusting the patch to accommodate
> changes in the function signature of ieee80211_parse_bitrates,
> specifically the updated first parameter ]
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reported-by: syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
> Tested-by: syzbot+19013115c9786bfd0c4e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=19013115c9786bfd0c4e
> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> ---
>  net/mac80211/cfg.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 

We can't take a patch for 5.15 without it also being in 6.1.y for
obvious reasons.  Please provide a working version for that branch
first, and then resend this backport and we will be glad to queue it up.

thanks,

greg k-h

