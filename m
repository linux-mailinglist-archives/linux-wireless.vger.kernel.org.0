Return-Path: <linux-wireless+bounces-13765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E99960CD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 09:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E93CB21A30
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 07:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA6617C7CA;
	Wed,  9 Oct 2024 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qq4cMrRA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08142070;
	Wed,  9 Oct 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458827; cv=none; b=QDuyKg5yLffE1MKW3vDA/Hb6iCY4GdBMpO/HsVLW+adD17bd15sY9z7yFJeUZo9OzEna8RQ4arZWCQ7jqH6WeYI6w6Sk9kZErPGoI8Qzu7jwE9bS/hJX2lgzqOEKPWFYjEJItAgfvD/dEdCVY1MIYAlM1BMxopkWa4BiBSFut7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458827; c=relaxed/simple;
	bh=GBFBg0sEKBmtN4hXfjdfnCUTzVJ67hl4jwYYPj+Qp0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsNQfqyBR6UvGPFhNhzqcE5XxGbr/6cr31c3Xzom8Xg/rO0BXNJk8Pf9esQ8vdspSFIjMrM/uoPzBNkFirwDEnmBkmbSnHA05Qj7sUSOWoBAtbgsv0U3cXd/xODg1g65iYAYki8rMwAr6xwQhi5bVKHnhD3aJ3wq9q0rplVK2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qq4cMrRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E2DC4CEC5;
	Wed,  9 Oct 2024 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728458826;
	bh=GBFBg0sEKBmtN4hXfjdfnCUTzVJ67hl4jwYYPj+Qp0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qq4cMrRAGTdRgs57WxeBmft29M4EL2YMExW3S5DG0GJUiAIvYSOgSrufz64z93NI3
	 C8ItshSY4ql3gfl29enhHT2JpEL7yc0doud3K5nccK5jP4ZYLbi7z8pPATHbWnxj3U
	 TUljyw2TbhI4LZIqyI8X3X54jbZz6s/Nk98zQ860=
Date: Wed, 9 Oct 2024 09:27:03 +0200
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
Message-ID: <2024100941-gaining-sprang-826b@gregkh>
References: <20241009114455.52db31ad@canb.auug.org.au>
 <2024100945-engross-appraisal-d1f0@gregkh>
 <317aeb02110105be1483d13c204bfb48d4d19c61.camel@sipsolutions.net>
 <2024100917-footsie-anatomist-fd06@gregkh>
 <e572bee3a1c2600b09cb2fd5d09a2e95b4e0faa0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e572bee3a1c2600b09cb2fd5d09a2e95b4e0faa0.camel@sipsolutions.net>

On Wed, Oct 09, 2024 at 09:19:40AM +0200, Johannes Berg wrote:
> On Wed, 2024-10-09 at 09:13 +0200, Greg Kroah-Hartman wrote:
> 
> > > But if the conflict is to Linus's tree, is that even going to help?
> > > Seems like I should pull in -rc2 and solve this one and the ks7010 one
> > > that way? Just need to check with net-next?
> > 
> > I'm not worried about the conflict with Linus's tree, sorry, I now see
> > that that's what was being reported here also.
> 
> Ah OK. But I checked, and I can just pull in net-next to resolve this
> and two other conflicts (where one appears to be due to git getting
> confused between moving a file and deleting another copy of it in
> staging), so I'll probably just do that, just need to sync with Kalle.
> 
> > I just want to get your
> > staging driver changes, so I'll pull in up to commit 4991d2e7ad38, which
> > is all I really care about :)
> 
> Oh OK, so that's mostly unrelated then. Sure, you can pull that in so
> you have the staging changes I've made in case other staging patches
> want to touch the files.
> 
> 
> Although ... maybe wait with that too. If you merge that now you'll have
> to resolve (some of) the conflicts, and if I'm merging net-next now as
> well we'll have two conflict resolutions for the same thing? That seems
> a bit strange, even if the resolutions are almost certainly going to be
> identical.
> 
> I can push out the net-next merge (& revert) soon, and then it'll all be
> cleaner?

Sure, I'll wait, just let me know what commit to merge at, from what
tree, whenever you have it ready.

thanks!

greg k-h

