Return-Path: <linux-wireless+bounces-13727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D7995659
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 20:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8111F223FC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F5F20ADDB;
	Tue,  8 Oct 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Q13Rmxep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FA1E0DD1;
	Tue,  8 Oct 2024 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411765; cv=none; b=n0x+MFcYY99H0jOMJOH93AZccHQpe36rK4Iv31Sx5Fq4+1DlscqMsKjMskcQgImZ+SrVPRk2a17n8JW+pznDPJxm9pHnOlUIMCmp73hLJZeUMoAZ0M8iKN/kBK1QcGZQoOoiD4mtXuJM0bNsyD5428SUAowCyj2zkvEQSWBi0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411765; c=relaxed/simple;
	bh=Bw7tHAzRnNX9JlhTidWbpwRPbZZIBq1pJaHcu3O/D9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlUg59z87Msl1w+d3imZrzNg/mqk7NBFva5MTT41HeE+UStJIVna8u/t+i92tRxvPaARJVyjVBbsWwsPH3jRHmhtcGZNGmggg6LIr0qYPfTzPb2lVekp6XTxjVyEpRUqbAdUHvItQCZdoZJQPNxWl6DZdT355QpPAR2lj9UE8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Q13Rmxep; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FYiFRoNGJ9hNi3r1QAXGk4nUc9gJVOt2/pUqvZG6Z1I=;
	t=1728411763; x=1729621363; b=Q13Rmxeph9LEnojOeMNCBQNrlvP6R1WzWh48UP0b7qNhsOi
	5CrvV7w//aaAbUCPmywvsToWXaM47M86JqVtUtNqqaP4sLyvoxB82h/iOSnD0seII4ftvVRVIxl/q
	g1e5NB0l8XaNrFy3OA2zsewCPgtLfr42An4h0k8EpPgMlMJGqyylUoQgltUAhqjU60ripYucXO/6D
	j92cupL6ydqmxxOH7GxEflfclTwC7QJ65MkYuGV4rL0WsFpmetwcslr/gb9kSoyX4EuW3nvT/ZMZ1
	ZTjLpbcJL4Iw8aoudAtRQelW9xfDR7bRtO5sJ9qiAysGGqv1Tf0t93XhLJ3YrTLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1syEr1-00000004LXn-1si8;
	Tue, 08 Oct 2024 20:22:39 +0200
Message-ID: <cd8045c03573a012f71a1afdcfb5d9c108b6fefa.camel@sipsolutions.net>
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, alexandre.ferrieux@gmail.com
Cc: alexandre.ferrieux@orange.com, edumazet@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Tue, 08 Oct 2024 20:22:38 +0200
In-Reply-To: <20241008174751.2995-1-kuniyu@amazon.com>
References: 
	<CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
	 <20241008174751.2995-1-kuniyu@amazon.com>
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

On Tue, 2024-10-08 at 10:47 -0700, Kuniyuki Iwashima wrote:

> > 1. The "netdevice notifier" from the Wireless Extensions subsystem
> > insists on scanning the whole list regardless of the nature of the
> > change, nor wondering whether all these namespaces hold any wireless
> > interface, nor even whether the system has _any_ wireless hardware...
> >=20
> >         for_each_net(net) {
> >                 while ((skb =3D skb_dequeue(&net->wext_nlevents)))
> >                         rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
> >                                     GFP_KERNEL);
> >         }
> >=20
>=20
> Alex forwarded this mail to me and asked about 1.
>=20
> I checked 8bf862739a778, but I didn't see why wext_netdev_notifier_call()
> needs to iterate all netns.

Agree. That code is ancient, and I don't remember why, but I'd think
it's just because I was lazy then.

> diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
> index 838ad6541a17..d4b613fc650c 100644
> --- a/net/wireless/wext-core.c
> +++ b/net/wireless/wext-core.c
> @@ -343,17 +343,22 @@ static const int compat_event_type_size[] =3D {
> =20
>  /* IW event code */
> =20
> -void wireless_nlevent_flush(void)
> +static void wireless_nlevent_flush_net(struct net *net)
>  {
>  	struct sk_buff *skb;
> +
> +	while ((skb =3D skb_dequeue(&net->wext_nlevents)))
> +		rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
> +			    GFP_KERNEL);
> +}
> +
> +void wireless_nlevent_flush(void)
> +{
>  	struct net *net;
> =20
>  	down_read(&net_rwsem);
> -	for_each_net(net) {
> -		while ((skb =3D skb_dequeue(&net->wext_nlevents)))
> -			rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
> -				    GFP_KERNEL);
> -	}
> +	for_each_net(net)
> +		wireless_nlevent_flush_net(net);
>  	up_read(&net_rwsem);
>  }
>  EXPORT_SYMBOL_GPL(wireless_nlevent_flush);

Note 1: I just posted this patch yesterday:
https://lore.kernel.org/linux-wireless/20241007214715.3dd736dc3ac0.I1388536=
e99c37f28a007dd753c473ad21513d9a9@changeid/

so that would conflict here, I'd think.

Note 2: the only other caller to wireless_nlevent_flush() is from
wireless_nlevent_process()/wireless_nlevent_work, and that work could
easily be made per netns since it comes along with net->wext_nlevents,
and then we don't need any global function at all. Seems this could be
implemented in wext_pernet_init()/wext_pernet_exit() pretty easily?

johannes

