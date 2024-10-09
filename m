Return-Path: <linux-wireless+bounces-13824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF599733B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 19:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EF21F258D8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115321DE4CE;
	Wed,  9 Oct 2024 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iA2ouilW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205415C15E;
	Wed,  9 Oct 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495376; cv=none; b=t8Mw8hqplU1nKmFZhM4vQCWlprB02iRxTFyHogzg+Hv9QyN3VY+1GvQ7KGomn1udMsvgqOytI/Wcg5cJsjqA5b4FMT2vMdpRx7KeBKXoKAlN5ggtEHPKSlkyDb2Vl7DIIy9BGC5dQlm+PalO/OSoKccN6SEwA+xDFw1GTFnfqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495376; c=relaxed/simple;
	bh=yM+9MYhcC/LrfN+4uwSC0m7ARGtLPOp6sYd+2I1ACW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvjnJEq3nds1FCg6umcrQllqePNcd6qPf/x3H6QZjOQD7fmzYjrbG7yhIXk3S9LmQdpM3AvmvGDpFyKL3gg12kHSnWCoxmTZwbUOE3MBi/WjJMYHqMjDXgHS/htffgwjb+dlAqA/34w/5B8heIDddaJWxnfg5TBirkXu3A7QHR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iA2ouilW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yM+9MYhcC/LrfN+4uwSC0m7ARGtLPOp6sYd+2I1ACW4=;
	t=1728495374; x=1729704974; b=iA2ouilWmjQPCtkstRPLqRfnCYn6wif9XVKMqksq5dYuYpl
	01XIhqfHIPeKQ980UuSF+BliyE2KNvyw0wrjIVQOkk+z/AIVx9Zuyg+6lQHc5AmwjsfIwyozM7h4A
	abYU+jBSGyOuFFyofwBn1p8ZU+GovG/M0wYJ/on4qUm3uEtZwnLKVv7he8+HsLkFo/HQuUirzvaAP
	mD3AE76fLcoCzikmrv5ekc8NHgZNjGLVni3aPz3YMRQM2mPTHJKemLPPQIw6gQszQxpxDXs7dK5Hy
	r9tg72kTNKECqLBPZ27nzDMqDPfqvMadt/DLigVZ7WgkbMa/YlRQn6kTIm1rGyeQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syabb-00000005GYM-3zji;
	Wed, 09 Oct 2024 19:36:12 +0200
Message-ID: <3cb6afa964a629c6457e44dd3222ee7ebaace8f0.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] debugfs: add small file operations for most
 files
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Date: Wed, 09 Oct 2024 19:36:11 +0200
In-Reply-To: <2024100943-snuggle-undoing-811b@gregkh>
References: 
	<20241009181339.0b1a6eaef573.Ia80b55e934bbfc45ce0df42a3233d34b35508046@changeid>
	 <2024100943-snuggle-undoing-811b@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-10-09 at 19:33 +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 09, 2024 at 06:13:39PM +0200, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > As struct file_operations is really big, but (most) debugfs
> > files only use simple_open, read and write, and don't need
> > anything else, this wastes a lot of space for NULL pointers.
>=20
> You added llseek too, I'm guessing you need/want that?

Oh, right. I had it without llseek originally, but then I thought we
might be worried about breaking the API on debugfs files, even if most
of the time really it's not used. But if people were worried that'd
severely limit where this could be used, vs. another pointer.

Just forgot to add it above when I edited the commit message.

> > Add a struct debugfs_short_fops and some bookkeeping code in
> > debugfs so that users can use that with debugfs_create_file()
> > using _Generic to figure out which function to use.
>=20
> That's crazy, but nice work!

Yeah it's a bit crazy, I agree. With _Generic() it's actually nice to
use though, and the conversions are mostly trivial as you can see in the
other patch. So glad we moved to C11 :-)

johannes

