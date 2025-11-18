Return-Path: <linux-wireless+bounces-29104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E9C6A1F8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 15:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F27B94EC279
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF1A18A6D4;
	Tue, 18 Nov 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lI3H+w/G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6728E299943
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476922; cv=none; b=E0V7Uxp3aljo4lIyRlq+1hoNbpaKUHsVpoYv/85tSnPr8GNdzca6PSbOKIv/MUIzQWgDL7sYDd0KqMSDLq7rmEBZYB291OriX60cIb4QCwkXRToyIlY3DOmeT7CKDwwIJo/FgjYsUHLDwg5wKScltBPlyeV/qfL+Wmip2AcQZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476922; c=relaxed/simple;
	bh=7TklI9Wzz2HZZWq3NThZpz5cB081ymmhNW9W8F4xgVE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u68VUDh3GoiKYT/o4AC2Qgm5+S7yDgr19hfKSs/OctTnxHKuFBVUzYVg8MVEFKakHN0sq5Toqo9bbnujztv9wo/W1IeXRkd7jKZme0hfp7UILnzWRtsVyHnqr5ZRIOfxTW9mYtZ2YnDFZO2Wk7VzIKqSFs2uUR9M8yM9qRAJKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lI3H+w/G; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1EMJoKrp9gTol5/2U6Q/jFQ0a+c8jFuUYGHA8ucC44U=;
	t=1763476920; x=1764686520; b=lI3H+w/G+UcjxqRXqZfUoOiRJRZgNapZvAUHOsIetipIXaF
	Ov+74jJWTgXKcd3ohT1SlkqiUg2aRYktTYwoCwWhFeQVy8REpjL0/ZaOJhwNK15r26+mX/3z0WXLx
	Gt1TlEyFYPMQt0kb1nbAEX1M7bIwCkIp/o6blqvazNXMHHR/fKvXWp1tHc/9FjnSDNZUuin7oYfxu
	w6yOM1GmwLI/bFaRU0oWA93jt3JsTFVzb1notUzxIv75HrnofbeWGTxy1GH0h177l46R6T4/ti9tp
	dNxo1zc+BKiNdzVfM239f9ef8EpN0SXfK8r51GCvyVCxBH0XVLu3tAQzFSGlNDqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vLMu0-0000000HQmt-0kPH
	for linux-wireless@vger.kernel.org;
	Tue, 18 Nov 2025 15:41:52 +0100
Message-ID: <dd57945cae41bde3f271187db349ea7c2b7a2485.camel@sipsolutions.net>
Subject: Re: NPCA/DSO configuration
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Tue, 18 Nov 2025 15:41:51 +0100
In-Reply-To: <f071f05beba11fe51f5517f3cc9890dc379273f5.camel@sipsolutions.net>
References: 
	<f071f05beba11fe51f5517f3cc9890dc379273f5.camel@sipsolutions.net>
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

On Wed, 2025-08-27 at 18:40 +0200, Johannes Berg wrote:
> Hi,
>=20
> So I'm looking at UHR NPCA and DSO, mostly wrt. the configuration in
> mac80211 (and perhaps to some extent cfg80211, for sniffer.)
>=20
> Let me look at NPCA first. For NPCA with a device that's capable of
> supporting the full channel width (e.g. 320 MHz with non-primary 160 MHz
> being used in that case, or non-primary 80 MHz out of overall 160 MHz)
> this seems fairly straight-forward:
>  - the chandef or chanreq can simply contain a value/pointer for the
>    non-primary control channel location, if any
>  - the channel context in mac80211 cannot be shared any more, since
>    transmissions on the other vif would be seen as OBSS for NCPA
>    purposes, and the AP might try to use NPCA with the station that's
>    actually doing the OBSS transmission on the other vif
>=20
> That's about it for the simple case? Not sure if it should be in the
> chandef like puncturing or in the chanreq like the full AP channel for
> EHT triggering, what does the AP side for NPCA look like in terms of
> configuration? Seems like probably it would be configured via hostapd
> and then it should be in the chandef?
>=20
> However, there's another case, say you have a device that only supports
> 160 MHz, but then connects to an AP with 320 MHz. In this case, it's
> meant to still support NPCA. This is not relevant for an AP, I believe.

That's indeed not allowed:

   An NPCA AP shall indicate a value in the NPCA Primary Channel field
   of transmitted NPCA Operation Parameters fields that corresponds to a
   channel that is located within the secondary 40 MHz of the BSS
   operating channel wif the BSS is an 80 MHz BSS, that corresponds to a
   channel that is located within the secondary 80 MHz of the BSS
   operating channel if the BSS is a 160 MHz BSS and that corresponds to
   a channel that is located within the secondary 160 MHz of the BSS
   operating channel if the BSS is a 320 MHz BSS.

> But this case is more tricky:
>  - Should we set the chandef to 320 MHz, but indicate somehow separately
>    that only the two 160 MHz channels are really used, since the HW is
>    incapable of 320 MHz? That seems ... strange.
>  - Should instead the chandef be for 160 MHz, and the non-primary
>    control channel is actually outside the 160 MHz channel? That's
>    somewhat plausible, but hard to decode?

I now think neither.

>  - Intel firmware is going to require two PHY contexts, but should that
>    really be reflected in mac80211 as two channel contexts? Right now my
>    gut feeling is no, and the second channel context also couldn't be
>    shared with other vifs since the device really isn't active there.

(putting that aside - it's not necessarily that relevant)

> Or maybe in this case we only put the non-primary control channel into
> the *AP* chandef inside the chanreq (struct ieee80211_chan_req::ap) and
> not into struct ieee80211_chan_req::oper, since that actually reflects
> the full 320 MHz, and let the driver figure out the rest? I think right
> now I'd probably consider this option most sane, since this case doesn't
> apply to AP mode? And in the "easy" case above obviously the non-primary
> control channel would be in both then in the channel request.

After reconsidering all this, I basically arrived at this conclusion
again. :)

So as such then a chandef would get two new fields:
 - npca_chan: the channel pointer for the chandef, and basically a
   chandef has to be valid with chan/npca_chan transposed
 - npca_punctured: another puncturing bitmap that indicates which 20 MHz
   subchannels are disabled for NPCA transmissions, always (by spec)
     (punctured & npca_punctured) =3D=3D punctured
   (if NPCA is used at all.)

> As for DSO, that's only relevant for the second kind of device (which
> connects to an AP with a higher bandwidth than it can support), so maybe
> if the struct ieee80211_chan_req::ap gives the information, the driver
> can sort it out just like I was outlining in the previous paragraph for
> NPCA?

Still with that ...

johannes

