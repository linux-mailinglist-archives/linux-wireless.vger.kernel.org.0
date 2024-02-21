Return-Path: <linux-wireless+bounces-3844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B49F85D29F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8586B1C21370
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4867C3C064;
	Wed, 21 Feb 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oK6wqkIb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EFD3BB4D
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504529; cv=none; b=QB77q1K1CLh4UGGTKA9lW7m//lguPU/4LA9bODuycuro4FDdPd2Fgs2GY9LRaxe0tgki393mMP3YLqoboTqmeVQV1BBOh09ipCzadDY8grvYUk6rufxWOgOItPkM8RftUtUy0wfzCa8L4MEMLerYrv1zyJoET5C22xDKaRGiyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504529; c=relaxed/simple;
	bh=rV7ai5MnTpLm18GUFMNDN0KkQRdeHq8c7G+215EJw/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n1KqkSma1n6wJCnFo77uPLtL6J5kfMIMtLCxdt/DC2j4x0dsxFOsEmchZZIlLMTSyDtc4ldsJMGW571Te03v17icuwzNnZRiafat6PIRRFGzeSU5kTrtSFfuPaJY/YeftsRjYoyECeFerRaQbjWNoGyyHS5FUpfYuHXKaKcjFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oK6wqkIb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rV7ai5MnTpLm18GUFMNDN0KkQRdeHq8c7G+215EJw/Y=;
	t=1708504527; x=1709714127; b=oK6wqkIbFx8fWMAOuIfpUEKqi9rvKIUbvXgcoIEK90K363Y
	xVGuQvX2NnOl1q5KZWPwoJZsS8UuDUHNQB0cOsUSkZQiRynaD9kNHvx7aRLTI8RDapfepWjgxUpqo
	ID6nYzw80W6mubW6b+5qGO5BgjCXvM1yhrion3ynePaH+Nt7sPLcFm/Ze///lN4+27SfVHdhGQ5it
	mE6nShUczXj0jkgg7/8K9Pdr3YBLIV/R4RQm+Cq03R+NzG66AvShlbLxrKriyTrR4IJHKWtYExwxu
	ddSSjB9ZU/V/c+ghnEd/H02qtstXliGo2LoUCvIl+24ehxBbchiezmXRdsOzIIsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rci4Y-000000026tv-1SJq;
	Wed, 21 Feb 2024 09:35:22 +0100
Message-ID: <08a989730bbc456df481aee8ae278a5cd9b35f85.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Aditya Kumar Singh
	 <quic_adisi@quicinc.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>, Ilan Peer <ilan.peer@intel.com>, Jouni
 Malinen <j@w1.fi>, Ryder Lee <ryder.lee@mediatek.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Felix Fietkau <nbd@nbd.name>
Date: Wed, 21 Feb 2024 09:35:21 +0100
In-Reply-To: <9d3bea8152fe49278fe9804167ec8871@realtek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
	 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
	 <5a89e63fb7644d12be72154c90c96199@realtek.com>
	 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
	 <00094ae0ca73461c88799c070ad9b55a@realtek.com>
	 <db8508eddbeb78bb59671b8c453588428e16f27b.camel@sipsolutions.net>
	 <9d3bea8152fe49278fe9804167ec8871@realtek.com>
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

On Wed, 2024-02-21 at 08:28 +0000, Ping-Ke Shih wrote:
>=20
> > -----Original Message-----
> > From: Johannes Berg <johannes@sipsolutions.net>
> > Sent: Wednesday, February 21, 2024 4:20 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>; Aditya Kumar Singh <quic_adisi@q=
uicinc.com>
> > Cc: linux-wireless@vger.kernel.org; Jeff Johnson <quic_jjohnson@quicinc=
.com>; Ilan Peer
> > <ilan.peer@intel.com>; Jouni Malinen <j@w1.fi>; Ryder Lee <ryder.lee@me=
diatek.com>; Arend van Spriel
> > <arend.vanspriel@broadcom.com>; Felix Fietkau <nbd@openwrt.org>
> > Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel =
switch on link basis
> >=20
> > On Wed, 2024-02-21 at 08:19 +0000, Ping-Ke Shih wrote:
> > > > -----Original Message-----
> > > > From: Johannes Berg <johannes@sipsolutions.net>
> > > > Sent: Wednesday, February 21, 2024 4:10 PM
> > > > To: Ping-Ke Shih <pkshih@realtek.com>; Aditya Kumar Singh <quic_adi=
si@quicinc.com>
> > > > Cc: linux-wireless@vger.kernel.org; Jeff Johnson <quic_jjohnson@qui=
cinc.com>; Ilan Peer
> > > > <ilan.peer@intel.com>; Jouni Malinen <j@w1.fi>; Ryder Lee <ryder.le=
e@mediatek.com>; Arend van Spriel
> > > > <arend.vanspriel@broadcom.com>; Felix Fietkau <nbd@openwrt.org>
> > > > Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize chan=
nel switch on link basis
> > > >=20
> > > > I guess that'd also apply to probe responses? Or does it not send t=
hose
> > > > at all? But we discussed before that maybe we don't have to be perf=
ect
> > > > there, so I guess we can find some solution to that.
> > >=20
> > > Unfortunately, Realtek firmware doesn't send probe responses at all. =
Still
> > > need hostapd to reply those.
> > >=20
> >=20
> > Right, but filling in the CSA counters?
> >=20
>=20
> No, firmware doesn't modify content of probe response frame.
>=20

Can you get that fixed? ;-)

With differing beacon intervals etc., I don't know there's a good way to
keep the counters even with a semblance of correctness, especially if we
don't know when the beacon was transmitted?

Or maybe just fill it in the driver since you probably have some beacon
timing data more easily accessible?

johannes

