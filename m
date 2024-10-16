Return-Path: <linux-wireless+bounces-14062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373BD9A04D8
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D481C22D1F
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AA8203707;
	Wed, 16 Oct 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sXGqCQ5k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807531F80D7;
	Wed, 16 Oct 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069015; cv=none; b=VYgkXxx3JHz/1flDW1x8ea9OPZ2kj0bJr7uNyNp7PZhn7wsAxhwLGQNBGite5NdlyySATWT5/aep8oXz4jzmfKM44MmKb6GELCmmEPAA8+offqRkdzTJfZ67VdkcTpqQoCWQeHVaVpmJGTUOK/QdHc7Q93QVuBYoLuW+MJvo+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069015; c=relaxed/simple;
	bh=22B7n2tEpTaog8YTqPjwr1prW1s7g6l0XYXO/2g84aA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFCenU7ZEYu1W2nbtKlyXajYQjr5GMA+XaXCVhRBvwvBgoIvgxcJo+ZhuNfBkJVbXCDj3c6a7Mhgk5iRomcjHwblSLPjd9DtNrO8llXW2EJof5nRNnsCi6N62mK20M6MmxXJsySDfLPLDiUnNvYz1UayWQ+aCaFPUQL6jQbR2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sXGqCQ5k; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I98jfzHhq9YBAqa3c7f1CrjuxTK1ORerQc0awb8MEq4=;
	t=1729069013; x=1730278613; b=sXGqCQ5kLiTMeb971Ix84uGveqGLd09e/VCODexsIYL10JX
	HfVxbR8pipnuEBO9w2QVVxhjWIWgxknfpvnmiTXSq8IWSMTiM34B2RRQLO1qJjCCqe65EzebafNi+
	AC+1d5COU/fFAsSTkdwaiQSINz8FAv8q/1wnerxrgLlnevxR/xHSWv2BQOSZZerSUeJMn7i5hDck5
	iZF2Cda2FvJ5cwGwb+CcuglQD0dQCUe3f6/AhsBNRfp9vSvsyRWB9ey2FkRdOrwDOIoli9XFbLIIs
	K6UJ99fjMX6u6gROH9E3gz5cXa3B5z5YkEKS5T8nu5vgEpEPVt3nUCNfl/+XmW3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t0zpk-0000000CiMw-3wpx;
	Wed, 16 Oct 2024 10:56:45 +0200
Message-ID: <f677361da9e1e4bb032e62301255ab705252e016.camel@sipsolutions.net>
Subject: Re: [PATCH v1 wl-next 1/3] wifi: wext: Move wext_nlevents to
 net->gen[].
From: Johannes Berg <johannes@sipsolutions.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexandre.ferrieux@gmail.com, kuni1840@gmail.com, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 16 Oct 2024 10:56:44 +0200
In-Reply-To: <20241016004956.74702-1-kuniyu@amazon.com>
References: 
	<2d4bc83dffef3b773312aa08d55bb310f2dcead9.camel@sipsolutions.net>
	 <20241016004956.74702-1-kuniyu@amazon.com>
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

+netdev, I think we're starting to discuss more general things :)

On Tue, 2024-10-15 at 17:49 -0700, Kuniyuki Iwashima wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> Date: Tue, 15 Oct 2024 08:36:24 +0200
> > On Mon, 2024-10-14 at 13:55 -0700, Kuniyuki Iwashima wrote:
> > > CONFIG_WEXT_CORE cannot be built as a module
> >=20
> > Isn't that precisely an argument for _not_ using net->gen[] with all th=
e
> > additional dynamic allocations that implies?
>=20
> Exactly...
>=20
> Recently I was thinking most of the structs in struct net (except for
> first-class citizens like ipv4/ipv6) should use net->gen[] given the
> distro kernel enables most configs.

Wait I'm confused, to me it seems you're contradicting yourself? :)

If we agree that making it use net->gen[] is more overhead since it
requires additional allocations (which necessarily require more memory
due to alignment etc., but even without that because now you needed
wext_net->net too) ...

Then why do you think more should use net->gen[] if it's built-in?

> But yes, WEXT is always built-in.

I can see an argument for things that aren't always present, obviously,
like bonding and pktgen, but I don't see much of an argument for things
like wext that are either present or not?

> Probably because wext_nlevents was just before a cacheline
> on my setup ?
>=20
> $ pahole -EC net vmlinux | grep net_generic -C 30
> ...
> 	} wext_nlevents; /*  2536    24 */
> 	/* --- cacheline 40 boundary (2560 bytes) --- */
> 	struct net_generic *       gen;                                         =
         /*  2560     8 */

I'd argue that doesn't really mean it makes sense to pull it into
net->gen (where it gets accessed via two indirect pointers)?

That's an argument for reordering things there perhaps, but in struct
net that's probably not too much of an issue unless it shares a
cacheline with something that's used all the time?

johannes

