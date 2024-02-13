Return-Path: <linux-wireless+bounces-3523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E411D852DA3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 11:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2274C1C216C9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE11225B2;
	Tue, 13 Feb 2024 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kVgxh25w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6149225A6
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819315; cv=none; b=frGvPW4YIS6HqPog4ESyZlH0xUXPoF04nJAZ23LD7lTB1A6FTjzy9wsEn/jyifC9un/IKbsg/1a5lBgziEzVkkXW6qhz3EauDOkb8VYRidiW+vOhyWfJccg6BT+LLXsYasi0tQ/JVy0H9FyvmukYkjuB0KUgvRxwxnmLFkb+ZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819315; c=relaxed/simple;
	bh=SwCoVSlg6C5C5+y9/+vHXLpb+ntTbTZz7l2ypfFbNtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tr1jgDls19CqyVgr1N/Fc8zd+UWXGqnIbJ1LTSR/yyGFAU/ZKE9YlkCw4gpRLF4wNZ9yPK6OqOOxjvlAJCbMEdYSph/GqVhZRVw3gEQHrU1RfXwoYUaU9bWg3XZki+uDtCXHQBbKH33dJK5QobXQzVgjRr2Qph6/RzsH4JsQu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kVgxh25w; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yWZqjrq6iHQd2stRNdIHt1+ySF68RurJqP3wNOW4ANk=;
	t=1707819313; x=1709028913; b=kVgxh25wJRtNYTM1RxeWMlK8CSD1BvZNdPq+2LaQuzZf/0F
	UfqGAb/Gm44/ceQjPMgO2LFi9OcAILU+cFJor5GF9QAxKzH54zrl/QVnDP1sexSiIz2D1EQdIYinj
	046uuWsgr2jRTSjj3CQe/8Pu4elFfLOItCsIyfn+KtJVnR8xrXNalnPbzs55WC60CAK8cF0nv9Nsy
	/lqaPB4Xui4Wqg2v4kaUsLoI43thZnLjbmF8cBWAJ9rtnahNbEskWcA9izc327WwcjyJ64M/n9ZfL
	F9NgyMEv5TxwGUHIFxCIVNSM7tFccJEXR7MEoQ9ZqqToIOVEkBKlJGBJk50wv42g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZpok-00000007bd1-39ur;
	Tue, 13 Feb 2024 11:15:10 +0100
Message-ID: <99977c876429f33d8dbab18d7c3e71590585263b.camel@sipsolutions.net>
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022
 fail, reason -52 - Part 2
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, Stefan Wahren
	 <wahrenst@gmx.net>, Arend van Spriel <aspriel@gmail.com>, Franky Lin
	 <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
 SHA-cyfmac-dev-list@infineon.com, Hector Martin <marcan@marcan.st>, Kalle
 Valo <kvalo@kernel.org>
Date: Tue, 13 Feb 2024 11:15:09 +0100
In-Reply-To: <18d1388fbe8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <d9c9336a-6314-4de9-aead-8b865bb30f05@gmx.net>
	 <18bbf6acf10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <cb07408d-af14-4b01-bd96-15c480989643@gmx.net>
	 <5c462fac-b27d-41c0-a62c-a8951bf445d2@gmx.net>
	 <d8f7dc94-40f5-4544-9693-01d7cbc6fefb@broadcom.com>
	 <ca0fd1c5-380d-4756-a33a-cb6c84014ce4@gmx.net>
	 <89d3f34a-3427-4871-971c-d960a16918ac@broadcom.com>
	 <004dabc3-c345-4d90-9348-5caa9b1f3849@gmx.net>
	 <c3996f70-bb2a-4d26-a7e9-a1b062fa0474@broadcom.com>
	 <0e5eba2f-e524-4f0d-8217-2770c57ad5ed@gmx.net>
	 <18c8d7da558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <f3af378f-fae4-4a98-a5b1-24173d17b64e@gmx.net>
	 <18c921b1690.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <18c9224abb0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	 <d90cc093-e3fc-4af4-9a4a-5f4bd9a7cb1f@gmx.net>
	 <19541618e400c95a448f7e8c79590c01df214782.camel@sipsolutions.net>
	 <18d1388fbe8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-16 at 19:29 +0100, Arend Van Spriel wrote:
> > >=20
> > > I modified brcmf_construct_chaninfo() to store the
> > > IEEE80211_CHAN_DISABLED flag within orig_flags in case the flags had =
it.
> > > This avoid the issue. Not sure this is the proper solution.
> >=20
> > orig_flags are from when the wiphy is registered - does the driver only
> > set up proper flags after that?
>=20
> Long time ago we discussed about this. So brcmfmac provides a superset of=
=20
> channels during wiphy_register() and none of them are disabled as they=
=20
> could never be enabled. After that the driver may disable a subset as it=
=20
> syncs with the device. I think we used strict custom reg flag, but that=
=20
> seems to have gone. Could that have the result Stefan is observing?
>=20

All this confuses me way more than it should, I guess.

We do still have REGULATORY_STRICT_REG, no? And that sets even
orig_flags:

        if (lr->initiator =3D=3D NL80211_REGDOM_SET_BY_DRIVER &&
            request_wiphy && request_wiphy =3D=3D wiphy &&
            request_wiphy->regulatory_flags & REGULATORY_STRICT_REG) {
                /*
                 * This guarantees the driver's requested regulatory domain
                 * will always be used as a base for further regulatory
                 * settings
                 */
                chan->flags =3D chan->orig_flags =3D
                        map_regdom_flags(reg_rule->flags) | bw_flags;


But brcmf_construct_chaninfo() looks a bit more like it really should be
setting a custom regulatory with all the channels listed, a bit like
what iwlwifi/mvm does, with REGULATORY_WIPHY_SELF_MANAGED?

Maybe we should start from the beginning: what does this actually
_want_?

johannes

