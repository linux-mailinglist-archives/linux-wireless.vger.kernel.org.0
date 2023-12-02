Return-Path: <linux-wireless+bounces-323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4FC801C23
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 11:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50758B20C71
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6FB15ACE;
	Sat,  2 Dec 2023 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wSmehsPW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0C4D67;
	Sat,  2 Dec 2023 02:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=o45hdsTEGxCn0t+rxCqz3d1GuoH4T/qGAEWkFyx+Odg=;
	t=1701511600; x=1702721200; b=wSmehsPWm3+GGZlale9ITHw5TzablTSPziSGSvbGAUlynhY
	TA1dRhGa013lnCDdpgnaZblCX6N9s4VAle8vEjvM257LAf+KVlnVMJCJtcXKHXcYVGaEbI8zgoU+n
	GIGLqaVbKAL9/d68XRdv/Hls70O46k4/vw1IQlrJ2l23TlcdpZptv9YjQW4LieXF7sc1R+m3VCHA6
	BPL4Hx6AczsBbjPAk8SodMpk/Q8ogc2vOmQI/zBH0i5xD3It/RzcPj9IBXYnfnAnlbnRt/+2GqDjp
	RK7ddV+qL/cKOfw/kNz+vUnjrqMzWGk7AjaeMeZvWhEhPqUguXo6jnogRCvMpkPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r9MtR-0000000CPtN-3yIk;
	Sat, 02 Dec 2023 11:06:38 +0100
Message-ID: <339c73a6318bf94803a821d5e8ea7d4c736dc78e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/3] netlink carrier race workaround
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Sat, 02 Dec 2023 11:06:36 +0100
In-Reply-To: <20231201162844.14d1bbb0@kernel.org>
References: 
	<346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
	 <20231201104329.25898-5-johannes@sipsolutions.net>
	 <20231201162844.14d1bbb0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2023-12-01 at 16:28 -0800, Jakub Kicinski wrote:
> On Fri,  1 Dec 2023 11:41:14 +0100 Johannes Berg wrote:
> > So I had put this aside for a while, but really got annoyed by all
> > the test failures now ... thinking about this again I basically now
> > arrived at a variant of solution #3 previously outlined, and I've
> > kind of convinced myself that userspace should always get an event
> > with a new carrier_up_count as it does today.
>=20
> Would it work if we exposed "linkwatch is pending" / "link is
> transitioning" bit to user space?

Not sure, not by much or more than what this did? It's basically the
same, I think: I exposed the carrier_up_count at the kernel time, so if
userspace hasn't seen an event with a value >=3D that it knows the link is
transitioning.

> Even crazier, would it help if we had rtnl_getlink() run
> linkwatch for the target link if linkwatch is pending?

Sure, if we were to just synchronize that at the right time (doesn't
even need to be rtnl_getlink, could be a new operation) that'd solve the
issue too, perhaps more easily.

johannes

