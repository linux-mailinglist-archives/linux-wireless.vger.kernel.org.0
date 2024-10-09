Return-Path: <linux-wireless+bounces-13762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C9996060
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 09:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E721F24BEE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18917BB0F;
	Wed,  9 Oct 2024 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qW/vRzj7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917217B506;
	Wed,  9 Oct 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458001; cv=none; b=fkBxFS2FnjC3DAamutk8VO+iyAwHX+rwZegOYTKThNGFsRwBKyjs0LtXFyWU1WzlqcaUfH2bsw3eFpyagmT1A3m9OG2dbyyH1M+KnrN5dk29MZXOQkeZWugzldiGupu6hG3nCEUL5yKKliI3rPH8hXbbWsApgnAgpmT6VvlHTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458001; c=relaxed/simple;
	bh=RsO051i68RM/hO4AIJbtVJAuXg3I94seG9q9/uPMUUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=madQkOlSH0VarIeEArhB6agY3cjOIOTvdoIu3IJ9/yFggmw3u4ziSaVBPEm+Kpp91+3AVWieE7fYgOLEXlyOXOoJrE2DmFDh8BkkWvuEx6udox8cOm63R9dwwRhIqckcr+UY9MokIgYOwtE05B0JTT3E8ihn+0Uam3LlHxoiuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qW/vRzj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4D9C4CECE;
	Wed,  9 Oct 2024 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728458000;
	bh=RsO051i68RM/hO4AIJbtVJAuXg3I94seG9q9/uPMUUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qW/vRzj7Ons1fsWRV4F+R2dfpOxn53r2NObJh8T69+Mn7g1R8+pKKSl5CRcaMEzg+
	 553r7KupnP8wVL/4uLn5K4aBqmFI6N1ZAvkYc+rMcCzJZrBN7HfTIy2Rbam0hu4rEZ
	 xo5/kq6W2yEyQliVN3UC2++wSWyquFGRkLSkzOao=
Date: Wed, 9 Oct 2024 09:13:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Wireless <linux-wireless@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Tree Davies <tdavies@darkphysics.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus'
 tree
Message-ID: <2024100917-footsie-anatomist-fd06@gregkh>
References: <20241009114455.52db31ad@canb.auug.org.au>
 <2024100945-engross-appraisal-d1f0@gregkh>
 <317aeb02110105be1483d13c204bfb48d4d19c61.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317aeb02110105be1483d13c204bfb48d4d19c61.camel@sipsolutions.net>

On Wed, Oct 09, 2024 at 08:51:22AM +0200, Johannes Berg wrote:
> On Wed, 2024-10-09 at 08:43 +0200, Greg Kroah-Hartman wrote:
> > 
> > Johannes, any objection if I just pull in your wireless-next tree into
> > my staging-next branch so that we don't get these issues going forward?
> > 
> > It's not going to be rebased, right?
> > 
> 
> It's not.
> 
> However, Stephen also reported a build failure that you don't want to
> pull in, so you can either
> 
>  * pull in commit 836265d31631 ("wifi: remove iw_public_data from struct
>    net_device") from before the build failure,
> 
>  * pull in commit 4991d2e7ad38 ("staging: don't recommend using
>    lib80211") which is really all you care about (both staging
>    patches I had are included at that point), or
> 
>  * give me an hour or so to revert commit aee809aaa2d1 ("wifi: cfg80211:
>    unexport wireless_nlevent_flush()") which caused a build failure.
> 
> 
> But if the conflict is to Linus's tree, is that even going to help?
> Seems like I should pull in -rc2 and solve this one and the ks7010 one
> that way? Just need to check with net-next?

I'm not worried about the conflict with Linus's tree, sorry, I now see
that that's what was being reported here also.  I just want to get your
staging driver changes, so I'll pull in up to commit 4991d2e7ad38, which
is all I really care about :)

thanks,

greg k-h

