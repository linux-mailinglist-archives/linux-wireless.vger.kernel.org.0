Return-Path: <linux-wireless+bounces-13803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6D996542
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 11:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6998281F0B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E918E028;
	Wed,  9 Oct 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VnZXh9Pl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCA18DF9B;
	Wed,  9 Oct 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465856; cv=none; b=umX9dahKiJR2/2NWcZR+q4Ks89NU27QE6IhxSQYEzSnwIWDXiytBD23en7S4gGGKtNcDHWj+Ki9l3v3e7djsFwWhPQu92nmCjgptf2B3RNxk5lKond7la3NguatbnHE2pc3h5xGorz3xudg8jXuQvbxD2R+V3rwnBDdE8kY3aQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465856; c=relaxed/simple;
	bh=CeAcCFSG0upiX0sX8oPnUv4FroqjC4xoAZb4ww6hE4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjNDbZpeJfwFSJckwKYNqvs3trJ6zbqwCiGpKjSlvcplvUVl9gSDTimkeGDtP3WRELXdX9jmdMQz1i4oQTnOwsZSxvTgY0i66Lx7cvpTs6ca6gteEB8GUr2NNARpM01D+YXL9Ye/52e1a6oNE+RSIek9APoCd0A1oH4bcMDcJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VnZXh9Pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB039C4CEC5;
	Wed,  9 Oct 2024 09:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728465855;
	bh=CeAcCFSG0upiX0sX8oPnUv4FroqjC4xoAZb4ww6hE4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnZXh9PlavE2pdP76iGTSNwmJc8hDYzG+Y+4bSTpEdREplm5vPLgqy4MAt5Pc5FWC
	 0gDTJ6+BwWhrnDy46rByfRHf2nTjPRMY/pSnFcb9+SnZYJGrCYbuhomA5PiVUwjfjT
	 4LlumT1vdqgc4HJnMi725mj1g+cXH0y7+QPz8QeM=
Date: Wed, 9 Oct 2024 11:24:12 +0200
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
Message-ID: <2024100941-gulp-tasty-f969@gregkh>
References: <20241009114455.52db31ad@canb.auug.org.au>
 <2024100945-engross-appraisal-d1f0@gregkh>
 <317aeb02110105be1483d13c204bfb48d4d19c61.camel@sipsolutions.net>
 <2024100917-footsie-anatomist-fd06@gregkh>
 <e572bee3a1c2600b09cb2fd5d09a2e95b4e0faa0.camel@sipsolutions.net>
 <2024100941-gaining-sprang-826b@gregkh>
 <287ad9eeb94f1e326c22fdcb74c94ef3fde84115.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <287ad9eeb94f1e326c22fdcb74c94ef3fde84115.camel@sipsolutions.net>

On Wed, Oct 09, 2024 at 10:30:12AM +0200, Johannes Berg wrote:
> On Wed, 2024-10-09 at 09:27 +0200, Greg Kroah-Hartman wrote:
> > > 
> > > I can push out the net-next merge (& revert) soon, and then it'll all be
> > > cleaner?
> > 
> > Sure, I'll wait, just let me know what commit to merge at, from what
> > tree, whenever you have it ready.
> > 
> 
> I've done all that now, so you could merge wireless-next/main up to its
> head, which right now is a0efa2f362a6 ("Merge net-next/main to resolve
> conflicts").

Sure, will do so now.  That branch has a lot of non-staging stuff in it
but git can figure it out when it's all merged together so all is good!

thanks,

greg k-h

