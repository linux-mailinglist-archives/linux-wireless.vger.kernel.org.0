Return-Path: <linux-wireless+bounces-23366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF453AC2339
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB93A277AB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 12:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D9145B25;
	Fri, 23 May 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NvYLIz3P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C686334
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005061; cv=none; b=r1me11kFlWQvz+YWIGCbgBPXWF8LV+YLvafyL3vv0Jgrxq0u36HLRdpppIpYRMJ5eMBgSIleJ6nLeVH5ZO8GwuHvBkHzsK904/HP7KVZ3Sd+BOupl0XK/arsbOu4xtnla0aqgmcDtMjyHFVXERbQdBgE8Ywu6P652CplnoaWgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005061; c=relaxed/simple;
	bh=kscfiwa4BwyWVoQHpMO+eVcZwqP+0c5jN1nxAbW+qiQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=obG7pBr69+QWZ3CoMsnL/XVVvOqmjCtRy9nGXhdKTy+tBQPIdgbRxARiMpZbCeZY37WB8p8tOxY84Y02P325vpy3lln8j6HXV7mfXiY/iGYxJgGJ/HG7tUz1RdQm/Q8mibVB1IR+JjmTJzDq4YINC3sZTxbxZKO+6Bfy8upt3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NvYLIz3P; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0CGwiRx+mRRc5XRKfoUQAgu7KbBkk9ByuqyW6f2PiAk=;
	t=1748005060; x=1749214660; b=NvYLIz3PwZRPjsmTUmA32lGNTUCdV3vtMdnyN6ACZdDvAGJ
	ZuQlTJ6Zk9SE/Nsp2r+DNA/xmBn4IipwqcZrOKYlAAqIyUitVXtaKNEnmGHXwuAR5jtcgTJwtu1cI
	TOpdcRGiq2I3t9ywtkw/jp920nX+IKJaQi81LC7HZ5cOtTpqrV9I0uEYDFKPK5RGnC+KqsZCQoLY6
	F2mo0q55E3yjRIcf1Q0kTAnIUYjUNrikslpz/gfHttizQs1hvOAlCUZ3rp1OJcYQybDH9zdrK7tYX
	226HkZXNSL8j7KEahwThQCNNZRK2c8VBhqTbWVmZ3vKovGBv5xPCHuoqxffYeUVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uIRxx-00000001enS-2Mty;
	Fri, 23 May 2025 14:57:37 +0200
Message-ID: <17ba3b94c5c5ced1d77ad457beedb57b0815820d.camel@sipsolutions.net>
Subject: Re: Association comeback delay behavior
From: Johannes Berg <johannes@sipsolutions.net>
To: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org
Date: Fri, 23 May 2025 14:57:36 +0200
In-Reply-To: <1b442183-1b73-4461-a9ad-14c1980bbc43@gmail.com> (sfid-20250523_145418_071620_DE9C8A9D)
References: <ba82ab00-ecf7-44fe-95db-355795c3520e@gmail.com>
	 <2e1fdb77f2ed5f381323f6a493c62ea1bdec19a7.camel@sipsolutions.net>
	 <56bcd608-bda2-40a8-9314-d978a39bf90f@gmail.com>
	 <e5241e83e7675a3db309c9bdab378549ee27ee45.camel@sipsolutions.net>
	 <1b442183-1b73-4461-a9ad-14c1980bbc43@gmail.com>
	 (sfid-20250523_145418_071620_DE9C8A9D)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-05-23 at 05:54 -0700, James Prestwood wrote:
>=20
> It logs and returns:
>=20
> static void nl80211_assoc_comeback(struct wpa_driver_nl80211_data *drv,
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0 struct nlattr *mac, struct nlattr *timeout)
> {
>  =C2=A0=C2=A0 =C2=A0if (!mac || !timeout)
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 return;
>  =C2=A0=C2=A0 =C2=A0wpa_printf(MSG_DEBUG, "nl80211: Association comeback =
requested by "
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 MACSTR " (timeout: %u=
 ms)",
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 MAC2STR((u8 *) nla_da=
ta(mac)), nla_get_u32(timeout));
> }
>=20
> Its relying on its connection timer though, which is why it "works".=20
> Opt-in or userspace providing a maximum is definitely a step in the=20
> right direction IMO.

Hah, ok, I only saw it doing something other than "get stuck" in the
explicit tests :)

> I'll admit, from a single AP use-case if the AP _REALLY_ needs you to=20
> wait that long you are right in that we have no other choice. I question=
=20
> under what circumstances the AP would need that though; when your=20
> talking on the order of minutes or even 10-15 seconds the AP feels=20
> broken at that point. I'm also not a vendor and don't know what=20
> conditions would even trigger this in the first place. Maybe this piece=
=20
> of information is what I need to convince me either direction, a=20
> legitimate reason for an AP to tell the station to wait, and an amount=
=20
> of time that would be for.

I don't really have that either, but simply looking at hostapd says 1
second is even default. So where do you draw the line? 10x that? 100x
that? Who knows? Why bother?

>  From a user-experience point of view I think most people watching their=
=20
> device trying to connect for more than about 20-30 seconds is going to=
=20
> trigger a "wtf, this is broken" response. And I know if my router was=20
> taking that long to accept connections it would be promptly rebooted.=20
> Its a long way of saying that I think there is some reasonable value here=
.

We don't just implement wifi for laptops though. I mean we, Intel, do,
but generally the stack gets used elsewhere. The random IOT device out
in my garage? I don't really care where it waits, it only gets a single
BSSID it could ever use.

johannes

