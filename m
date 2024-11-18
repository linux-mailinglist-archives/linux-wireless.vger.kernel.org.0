Return-Path: <linux-wireless+bounces-15458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611859D11DA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 14:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2845028401B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F438192B79;
	Mon, 18 Nov 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="W2THjwn2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B919ABB6
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936513; cv=none; b=uXT2XcLNBrTqFRXqxDrUImgpy915PmT/6YgXhUxuRG17v4bP6U+PTJvK3qO5W30wyVdh7d2DVHqx5A8YwCbqgxMrLN6CWOYrIZ3lE88ga7VcUw+tS4XWJHS9wRgdLgpriyQxw5JZ/u3FBSvDymDF6nDoms3YhIaI0ROy4nO9wI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936513; c=relaxed/simple;
	bh=4SK7ote8cNyNFQgpTUSWFq72KPKkoEyWlEulH55zzo4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PF1t8By44FYG4zJwiDi6cGyl/s5I/bNU/41VBUXwV3buzEUeRCB2/g3UMFlMCnxj1C2v970b/lxyyXn499f5HjVxkxPXqLmYrJVCB3wn5ZenElLUb78KXMJ6beVMAJxczG6C3SqjBsJBQkAd0ZfePEz0e9CDsU4TPxOuyUuPu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=W2THjwn2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BoKgedustos3Kv9zIRtLB088XLOgAwhYc+p/zYeAzzM=;
	t=1731936511; x=1733146111; b=W2THjwn2KA6fmQp1VJ4yaLaTCbiv0IsFN3CwiIme/b34y5t
	rXGLirwW/A/Qp3BgJcEWdYFBhjBvO8PLrqWSaQfHyri8oDLez3sXFQj9ki8qkhLHfA0feacRcsiWs
	y01DTHRCAv+cEMnREc86dLlNbpQY41LQhEVNPbI8j+ApGWHfdU7rpa5DgW8lPIXcyyWPw2thSyB4b
	PyodZPlzKmDFcYEb1iZLtm1YJh46EMu3TQtVKZcww5Gpi10+eVuhKWEZ5bbbPG6XVRImsh0DKO3fv
	2Yz1S0XT+Cnua4ShwM5SdSvQafg4ZFfoNFpS5kGEJND4r57PUDksDDdw8Xs2WcLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tD1nj-00000007ygv-2FE0;
	Mon, 18 Nov 2024 14:28:23 +0100
Message-ID: <338a2b7e26318588053be79f44fe3a76c1881236.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: fix mbss changed flags corruption on
 32 bit systems
From: Johannes Berg <johannes@sipsolutions.net>
To: James Dutton <james.dutton@gmail.com>, Issam Hamdi
 <ih@simonwunderlich.de>
Cc: linux-wireless@vger.kernel.org, mathias.kretschmer@fit.fraunhofer.de, 
	sw@simonwunderlich.de
Date: Mon, 18 Nov 2024 14:28:22 +0100
In-Reply-To: <CAAMvbhEy9CtTN4-sw1jEb5Y+4gEdaKE3OR839xA-4nL2WZ9FpQ@mail.gmail.com>
References: <20241104172415.3790038-1-ih@simonwunderlich.de>
	 <20241118125640.1110502-1-ih@simonwunderlich.de>
	 <CAAMvbhEy9CtTN4-sw1jEb5Y+4gEdaKE3OR839xA-4nL2WZ9FpQ@mail.gmail.com>
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

On Mon, 2024-11-18 at 13:26 +0000, James Dutton wrote:
>=20
> > @@ -1157,14 +1157,14 @@ void ieee80211_mbss_info_change_notify(struct i=
eee80211_sub_if_data *sdata,
> >                                        u64 changed)
> >  {
> >         struct ieee80211_if_mesh *ifmsh =3D &sdata->u.mesh;
> > -       unsigned long bits =3D changed;
> > +       unsigned long bits[] =3D { BITMAP_FROM_U64(changed) };
>=20
> Wouldn't it be easier to use this instead:
> -       unsigned long bits =3D changed;
> +       u64 bits =3D changed;

No, that's incorrect for set_bit() etc. at least on 32-bit big-endian
systems. Then you can't use for_each_set_bit() etc.

johannes

