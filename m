Return-Path: <linux-wireless+bounces-14878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727F99BB47F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 13:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFD41F21649
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA2B1AF4F6;
	Mon,  4 Nov 2024 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YYbXTARY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883D715C139;
	Mon,  4 Nov 2024 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722734; cv=none; b=LpIjj66qXnP8fgkv4Cydvj1cxdE1i6yrLHpsQGqhC2z+jWeu6Q31TEjEB6YwL/pcQbPwpBQmcUbaoHar6QXJYN4HYMTO7jUHfgn4xpMmADmNxk7vg1FFLYpCCkIe4COFUyIEiFGjUrdiANafFIl2bIZIh4JHDWEF0X0yPBw09fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722734; c=relaxed/simple;
	bh=0wU/mOeGBSXQvL1zr16K+fQX67NFBzutKsAV7pS87/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XD+h+tWsDxZp++9h25izBaAhNvuX0lIb5Om2f+EYlGGK8WnhjWdwmYU9M6B87n8ntvVzSHOlYdcCoQQyqswUTS8Ba3lm81PkWq9aqhq1EjSWMp2XXld+/vSqR+TTYmUpVHgULbf0L2Yi1flT7l/3waB3qtXq0LkyMR2W8pFaYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YYbXTARY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=69bTC+EMb920Iep0ovZqBEqdnYSK2ZjOc0yGiCxmjP4=;
	t=1730722732; x=1731932332; b=YYbXTARY/yqii0MYcz+UPznqC3bI0rR55RE64/PHZCG2heY
	TKRigOpN9JNWggdACEHFrEiENZ0hZO17mNxixqSeJGPOaaP5xNX3YV7kUH33xsIoDj+b/dX7IFr0z
	dSALp5TATP3OJ/z2h60T3MMd56rM9t0tXSZLISxvitLPkmxGIveWfXYF0+iMhYoZKxqUvwO42iF70
	34TaTZebyrUbMPtNNQM34ui8l4EFOpDK7xtABCyZEI7THMCFISP3Nj9FWNRj1XKxFSCf5Dn2Je0fO
	/RIGZ+JamA8h36m+7i1vd9WQiv6bJDcvoeo0JDGZFI2CYteQajS2vv5waJu1Au8Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t7w2d-0000000Dv6P-0PSC;
	Mon, 04 Nov 2024 13:18:43 +0100
Message-ID: <89888eab44b7b431ac7fedcd573db325e07b935d.camel@sipsolutions.net>
Subject: Re: brcmfmac: error messages while entering suspend
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Wahren <wahrenst@gmx.net>, Arend van Spriel
	 <arend.vanspriel@broadcom.com>, Arend van Spriel <aspriel@gmail.com>, Ulf
 Hansson <ulf.hansson@linaro.org>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
	SHA-cyfmac-dev-list@infineon.com, Kalle Valo <kvalo@kernel.org>, linux-mmc
	 <linux-mmc@vger.kernel.org>
Date: Mon, 04 Nov 2024 13:18:41 +0100
In-Reply-To: <86ef2465-3b5c-47c8-9e81-ad5b545bcfe4@gmx.net>
References: <a825587c-e6f6-45f8-8ac0-a1a5642a5333@gmx.net>
	 <16169285-d838-46f3-8be1-3639f573062e@broadcom.com>
	 <86ef2465-3b5c-47c8-9e81-ad5b545bcfe4@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-11-04 at 12:59 +0100, Stefan Wahren wrote:
>=20
> > > [=C2=A0 384.292071] ieee80211 phy0: brcmf_fil_cmd_data: bus is down. =
we have
> > > nothing to do.
> > > [=C2=A0 384.292079] ieee80211 phy0: brcmf_cfg80211_get_tx_power: erro=
r (-5)
> > >=20
> > > These errors are not new and I assume they have always been there. I'=
m
> > > not an expert here, so I want to know is the problem here that the SD=
IO
> > > interface is shutdown before brcmfmac is suspended or lies the issue
> > > within brcmfmac suspend itself?

> > Upon suspend we execute the remove path and cleaning the interfaces.
> > We notify cfg80211 about the removal, which in turn will notify
> > userspace, but is tries to obtain the tx power from brcmfmac.

I guess "it tries to obtain" is some sort of event path that wants to
include the TX power in an event. That doesn't seem to make all that
much sense on removal events though, so perhaps we could remove the
get_channel and get_tx_power calls for NL80211_CMD_DEL_INTERFACE.


> >  However,
> > at this stage the communication with the dongle is already gone. These
> > messages are also seen in the module unload scenario. It seems a bit
> > redundant to query a device that is going to be removed. So it could
> > be fixed by chiming down those message or avoid it completely by
> > changing the behavior in cfg80211.

> chiming down all the affected messages (i reported only one example
> here) sounds strange to me. Maybe Johannes has also a opinion about this.

Dunno about the messages, I mean it's still possible to get those
messages when e.g. userspace manages to query just while it died, so
perhaps you wouldn't want to print it for all cases, but OTOH that's not
going to happen all the time.

But I don't have much opinion on driver messages :)

johannes

