Return-Path: <linux-wireless+bounces-30541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E875AD0467B
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A996E31F23F5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD0486943;
	Thu,  8 Jan 2026 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="usZprcgd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8042846D;
	Thu,  8 Jan 2026 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870095; cv=none; b=qKHw5uykK67S24zhYt6LupTIpAzz7zrXNOOw+RyRN/zOUh4ghhdPCbCbTADUlHiCPTYS7Yf8r8wXwCJvHJLKfYIPDlXEx1zCSZ8JqA0VILC8Z2sM9d/7zF7XTKsrhffiGA0Kw9NOP77ty/tTmkpH4JuqjAj7dF56Y37HHT6A4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870095; c=relaxed/simple;
	bh=kifWMDUcjyoNqnma7UqgQlLZbT3dPAVcD7eeu3dSDNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XB7Kb5fTFw4RcgahAbUwHy6E9C+nKXez6rvRXH2FjwZY1Q9jK5XGvsYqg6ekf5IYWUZP1Xh7H1jPyZbaC+E7808UBy6LQoFAMWprByvq1zCqOFuoL5ko0YjksKkLMnSaZ2+Fl7QKXdOD980kZ2qlqmHrb+vWriwFAqXk26xKQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=usZprcgd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QXBd9eAoJBUhCI7owVszPAap9fsVDbLgy/vELqg02I8=;
	t=1767870087; x=1769079687; b=usZprcgdYHAmiySm1ZuQiBSLSJM24eEwZSnb7cxWW35EIKC
	eAWWfArgoGD12FBx9IBlkMAY6F7eyqUxrFjbugYdi7dSHguyUSn6cgHL35KrqVrtIokFsVhnVP5Vn
	FuCwuMCvRBLbRVhHDLRRK9BYxBgwN3iItbU0y+rVw83q69Rrg8nz6arZSbi/ymK0PJHykIP+AdPDw
	1yao9jvGZ9O98Uxd7BovHh075h+UktgXwvdKnUT3su+y0CH3pllQZVR/Nny2C+PyOsjHg4MXZWIL0
	bZN6/nkefjSZvN5DIYfpWepcxF/aOe/jFVznPgeg8XEUBmKJ0RzxW0fWAJ/9Lraw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdnlU-00000006SZl-25oB;
	Thu, 08 Jan 2026 12:01:16 +0100
Message-ID: <0e3af232f15f62f2540a307ccb967c1ae5fdadbf.camel@sipsolutions.net>
Subject: Re: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com,
 syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Date: Thu, 08 Jan 2026 12:01:15 +0100
In-Reply-To: <20260108101927.857582-1-edumazet@google.com> (sfid-20260108_112630_391137_9C1D2E9D)
References: <20260108101927.857582-1-edumazet@google.com>
	 (sfid-20260108_112630_391137_9C1D2E9D)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2026-01-08 at 10:19 +0000, Eric Dumazet wrote:
>=20
> https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@google.c=
om/T/#u

That wasn't the easiest bit to follow (for me anyway), so for anyone
else wanting to follow along, here's my interpretation of what happens:

> +++ b/net/wireless/wext-core.c
> @@ -1101,6 +1101,10 @@ static int compat_standard_call(struct net_device	=
*dev,
>  		return ioctl_standard_call(dev, iwr, cmd, info, handler);
> =20
>  	iwp_compat =3D (struct compat_iw_point *) &iwr->u.data;
> +
> +	/* struct iw_point has a 32bit hole on 64bit arches. */
> +	memset(&iwp, 0, sizeof(iwp));
> +
>  	iwp.pointer =3D compat_ptr(iwp_compat->pointer);
>  	iwp.length =3D iwp_compat->length;
>  	iwp.flags =3D iwp_compat->flags;

This all looks mostly fine locally, even for the compat code, i.e. for a
32-bit task on the 64-bit machine. The iwp is created here and is given
to ioctl_standard_iw_point(), which crucially then for some requests
(according to IW_DESCR_FLAG_EVENT) passes it to wireless_send_event().

This then can creates _two_ events, one for 32-bit tasks and one for 64-
bit tasks, and the 64-bit one will have the "struct iw_point" starting
from "length", excluding "pointer" but including the padding at the
end... The layout is further described in the "The problem for 64/32
bit." comment in wext-core.c

I don't think this can happen for the compat_private_call() part since
no events are generated there, but fixing it there as well is definitely
better (and who knows what random drivers might do in priv ioctls.)

johannes

