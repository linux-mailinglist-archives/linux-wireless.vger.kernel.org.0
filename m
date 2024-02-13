Return-Path: <linux-wireless+bounces-3543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE368532B5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F1A2863C4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554C15810D;
	Tue, 13 Feb 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qeiqwYs3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CA5810C
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833403; cv=none; b=SDzDy4Q06zU3BT0CDvpqSDDh19dKOs//kxFI7BWLKs3YWO6cJ/GAQVPqE05DJI72hAvhdgf04l5lyEcUzEDtDatRRo+8lwdO0EEipM5y0pM7VmRVomL2iQ6HA8uW6npC/IX4gn/yjYqp2Q+p2Y+yRrkwDC9L0nuPpS6Hbru/WM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833403; c=relaxed/simple;
	bh=4b93OmBFRGH45JwFvmddE7HU12/lMdg3AGrS8abWjiw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAVvODfYAtFc+oty+buWJ7b8cN/oaafbYJ5nSslumttGfApklIyjL8DhnBLegoQVsAAm17KMIZRaLiNYkB5fVDLr9l5KCVw+8C7Sqc0hWTXZ8zgKLzzBNhJxAlGKSV9E3pR80KvK4tsZkaCh3R49944Xh24O3sanjMnAh0FcyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qeiqwYs3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4b93OmBFRGH45JwFvmddE7HU12/lMdg3AGrS8abWjiw=;
	t=1707833401; x=1709043001; b=qeiqwYs3BUDFQLQctolMWtTO1DuVSG0PWjSbVYFafdPCbuT
	axmf7g12FYRTM6kHJbYZ8LHsWE65gWPzWZF8tygoLEsk/cm4KrzOfIm3E54dF3wkqsXOLIX+P+7BH
	TSCNJGrAg0SdIuXDfTUFJbgeXfarD02yvR3tisYPdp+pd96c2f/CpmfN/SrMw1FZKGDFhllKC/BVP
	sOOwefozJKES+MV3rWao0O+AAQAYQNFs0WuWNIK4daV2csDNjzbsVGSTSHwmvAAon54OBctCchaCf
	u/3bNpoj+nmkaob4ymUW3RNV11Ffl9Ngb3zksexc159aIPofxsrG9xmyqGAVM9wg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZtTy-00000007k2T-1u8n;
	Tue, 13 Feb 2024 15:09:58 +0100
Message-ID: <4d9d10ce2866467ae545507a99662eba70c2ad6e.camel@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Date: Tue, 13 Feb 2024 15:09:57 +0100
In-Reply-To: <d2b42434af3c81e467b0b2f24feb1b142686d35f.camel@realtek.com>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
	 <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
	 <f489a916f416cb37b527868c4be0c59547bdeb4d.camel@realtek.com>
	 <94bd67a6f261d945917067334b633c78be665c6b.camel@sipsolutions.net>
	 <a17862ae423422b636c76f116e712e7ebed51c09.camel@realtek.com>
	 <e50e2336dd2717e7271e7e6f341437637192f717.camel@sipsolutions.net>
	 <d2b42434af3c81e467b0b2f24feb1b142686d35f.camel@realtek.com>
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

On Tue, 2024-02-13 at 14:05 +0000, Ping-Ke Shih wrote:
> On Tue, 2024-02-13 at 13:41 +0100, Johannes Berg wrote:
> >=20
> > > > The other thing here is that I'm not entirely sure how the driver w=
orks,
> > > > chances are that this was previously a bug, and now is still a bug,
> > > > unless the driver doesn't really support channel contexts, or any f=
orm
> > > > of concurrency.
> > >=20
> > > This function is to initialize a station instance in firmware while
> > > associating, and the field of firmware command is to tell MAC hardwar=
e
> > > the sub-channels it can use to transmit, which should rely on
> > > bitmap of puncturing. Initially, we just wanted the field value to
> > > be ~0 (0xFFFF) to prevent TX stuck, but not fully implemented punctur=
ing
> > > feature.
> > >=20
> > > I think this is the reason you are confused.
> >=20
> > Not sure that explanations helps ;-)
>=20
> Oops. I assumed you want to know "how did it work to you?", and my answer
> was that we just wanted to fix TX stuck problem. But this story isn't=20
> interesting at all. XD

Ah, sorry! I thought you were talking about the HW/FW :)

> > If you have this per station how do you handle CCA? Which was kind of
> > the reason I moved it all back to the chandef? Not that this didn't mak=
e
> > the code simpler (in mac80211) either as a nice side effect :-)
>=20
> Do you mean CCA should consider punctured sub-channels? (CCA doesn't
> need to consider energy of punctured ones)

Yeah, I agree it _shouldn't_ consider energy of punctured sub-channels,
but then you can't really do it per station or even per vif since you'd
be listening without really knowing which peer/interface you're going to
transmit to/from.

Hence all the work of making it part of the channel context.

> The firmware command mentioned in this patch is used to control
> TX sub-channels from MAC to BB layers, and I think BB layer has another
> control registers related CCA I missed. Thanks for pointing this, I=20
> will check our BB team.

Heh. I have no idea :)

> > > > Though it _looks_ like you only support one channel context there, =
so
> > > > maybe also only one vif, and it doesn't matter? I'd probably still =
move
> > > > it over to the chan.c code though, it really does belong there more=
 as
> > > > discussed in the commit message of this change.
> > > >=20
> > > > But I didn't want to make those more semantic changes because I don=
't
> > > > know what logic your device applies here.
> > >=20
> > > We are going to support MCC and MLO, so we will/must consider more th=
an
> > > one channel context. Currently, rtw89 just consider 'deflink' not act=
ually
> > > 'links' that is the next main work we are doing.
> >=20
> > For MLO you have just one vif still, so it doesn't matter.
>=20
> I feel theoretically one MLO vif can consist of two links that use
> two channel contexts. Please correct me if this is wrong.=20

Yes, but I wouldn't think they're on the same (control) channel, but
usually two different bands? So you do get two chanctx indeed (sorry)
but they're pretty separate, never would I expect two links on a single
vif to share a chanctx, even though I guess technically it's not
impossible.

> But, yes currently we just have one vif. We will have two later.=20

Right.

> MCC is short for multi-channel concurrency that is a TDMA based concurren=
cy
> of STA + P2P using standard ieee802.11 power saving protocol and P2P GO N=
oA.

Aha! Sure, everyone implements things that way and has to, but the
acronym was new to me :)

johannes

