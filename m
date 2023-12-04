Return-Path: <linux-wireless+bounces-390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16BA803E26
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2241C2090C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A631594;
	Mon,  4 Dec 2023 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="a0pHQDJQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E00D5;
	Mon,  4 Dec 2023 11:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cNlMeT3xAHKdW5JqeRIRrQRlGuoKFvLyZE2ObsR7G6Y=;
	t=1701717253; x=1702926853; b=a0pHQDJQkW4r4666hNmHRVdEy/0nNcV9SbfekuJMguYjHHE
	vo+8mNYgl6ZvDjBdEUCMchTNV7/QQibjqd5TrfDoR6tlrNGNKSpx8kc/mRhXlCTdbCANJJjxdzojk
	B8CzNycm4Q5sGvMwMZU738JVUKJZ9XnUzmCJPizrr68mF5fG72408jcs2yXQRFmFszc2v7Rv0ZdZ2
	B4kwrR69dITmOVvOuF6q9qg6rKu4uKiD3R0/IFdGIsMquHC8VYUg8v+BUM5HfCQSaioq+Tdiow9Sm
	Czy3t+3Ps9FI8UJDHxnMwaRqZLzfJBIMVFQGx8NabyZ31rTLPYWGKQ19IXEHStoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAEOR-0000000FCrb-3biE;
	Mon, 04 Dec 2023 20:14:12 +0100
Message-ID: <d918321ab519800018a9fed71eb8e43d64cd934a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/3] netlink carrier race workaround
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 04 Dec 2023 20:14:10 +0100
In-Reply-To: <20231204082354.78122161@kernel.org>
References: 
	<346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
	 <20231201104329.25898-5-johannes@sipsolutions.net>
	 <20231201162844.14d1bbb0@kernel.org>
	 <339c73a6318bf94803a821d5e8ea7d4c736dc78e.camel@sipsolutions.net>
	 <20231202104655.68138ab4@kernel.org>
	 <efd89dee78a4c42b7825fa55bbceafad9bb9df36.camel@sipsolutions.net>
	 <20231204082354.78122161@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-04 at 08:23 -0800, Jakub Kicinski wrote:
> On Sun, 03 Dec 2023 19:51:28 +0100 Johannes Berg wrote:
> > I think I wouldn't mind now, and perhaps if we want to sync in netlink
> > we should also do this here so that it's consistent, but I'm not sure
> > I'd want this to be the only way to do it, I might imagine that someone
> > might want this in some kind of container that doesn't necessarily have
> > (full) access there? Dunno.
>=20
> Also dunno :) We can add a "sync" version of netif_carrier_ok()
> and then call if from whatever places we need.

[note: netif_carrier_ok(), not netif_carrier_on(), almost confused that]

Yeah I guess we can have a netif_carrier_ok_sync(), though it feels kind
of dubious to hide such an important detail in the middle of a netlink
message building:

        if (nla_put_string(skb, IFLA_IFNAME, dev->name) ||
...
#ifdef CONFIG_RPS
            nla_put_u32(skb, IFLA_NUM_RX_QUEUES, dev->num_rx_queues) ||
#endif
            put_master_ifindex(skb, dev) ||
            nla_put_u8(skb, IFLA_CARRIER, netif_carrier_ok(dev)) ||
...

Also, if we ever _do_ want to make it optional, then it's problematic,
do we do netif_carrier_ok_maybe_sync(dev, sync)? ;-)

> > We _could_ also use an input attribute on the rtnl_getlink() call to
> > have userspace explicitly opt in to doing the sync before returning
> > information?
>=20
> Yeah, maybe.. IMHO a more "Rusty Russell API levels" thing to do would
> be to allow opting out, as those who set the magic flag "know what they
> are doing" and returning unsync'ed carrier may be surprising.
> Also a "don't sync flag" we can add later, once someone who actually
> cares appears, avoiding uAPI growth =F0=9F=98=81=EF=B8=8F
>=20
> Anyway, up to you :)

Heh. But do I want to get blamed for the (perhaps inevitable?)
performance regression? I guess I'll try ...


Actually I could even still combine this with the netif carrier up count
in the wireless events, so we only have to do the rtnl_getlink if we
haven't seen an event yet, and - in the likely common case - save the
extra roundtrip? Though I guess it's not a huge problem, it's once per
connection basically.

johannes


