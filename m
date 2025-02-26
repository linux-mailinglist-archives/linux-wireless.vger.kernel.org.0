Return-Path: <linux-wireless+bounces-19485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39277A462F0
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5DD188FA0B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B1192D63;
	Wed, 26 Feb 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lySje9g5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310BD218AAB
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580427; cv=none; b=izVAT5/vHNTqSsa7pnL9Be5IJqIiVdBXn/+LWoTN6VocB9nSaHgcSxscowAOsu1w1kXoiv3Ox7eLGbSoWhtAI1DHVxo9klod/Vl9U7B8n8T0ETMRYyeWBc9G33oJ0D2wAzaP84MoXvHSN6oWYvF7RtYAYcrKX/xWXA0KJYNvjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580427; c=relaxed/simple;
	bh=iSTFAqddkxX57KpwURYD+ZPd+Ly2+U871z7rX/le7us=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtoeqiD0Hns917YVXs/W35TGbCG9Kz8Ppv13rro0+84Apho3wAPLZtEltn5caHmuIOH8mMaIrmKA3k8HpA8QKhnuVnytYQCL97gIZHHyVUmEjg9E/k1FXZwZhzsm2QfTb9YidHUeOrqjfT1aW8SeUXH5zm0cUDBL1++1GOvP5Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lySje9g5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7DjMDMzGqE/T/CaXOgtdW4es3mmmM/eTAL/ijbBaRz8=;
	t=1740580426; x=1741790026; b=lySje9g5lZX2qNSU5zZzk+GdDLA+G5seM7qRmyGQlRoYQ1l
	fd4kFdyk9e2klxpzPgdrsKCk08xJ+RGEJPSq55rRlyO6s0ADUcbeogpRZSmhMrNSKRBkiDt89y2aG
	GSVxzO+Qb3w6tCmfkmlakTEflXUUxByZ3tUEt9fbj6g7ncNbiDzt0FUHbU2ZZetF4ufr4jEJ+yvQq
	uUbpi9upaW0Lnbep0c+w+DpotRuZFiMa8PppT/FYtn3BGicByo0sf/gFtNsP3GpFSAHMoIgNQEakS
	M5u+RZCfayCEKoQ5z3asiy80c1dIzDXw3SrIHzcZAHzjCt8V9seJpk+QsxTtpbxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnITm-0000000BXO1-3j0V;
	Wed, 26 Feb 2025 15:33:43 +0100
Message-ID: <e3b99a7bbba8b22b3ce091ad79a271c85dc261de.camel@sipsolutions.net>
Subject: Re: [PATCH] ieee80211: fix interopt issue with MT7927 chipset
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 26 Feb 2025 15:33:42 +0100
In-Reply-To: <17a9044d-4bab-40df-a119-8c43ebd60bc2@freebox.fr>
References: <20250120114551.1542812-1-pmartin-gomez@freebox.fr>
	 <17a9044d-4bab-40df-a119-8c43ebd60bc2@freebox.fr>
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

On Mon, 2025-02-10 at 10:48 +0100, Pablo MARTIN-GOMEZ wrote:
> On 20/01/2025 12:45, Pablo Martin-Gomez wrote:
> > -	/* on 2.4 GHz, if it supports 40 MHz, the result is 3 */
> > -	if (he_cap->phy_cap_info[0] &
> > -	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
> > -		return 3;
> > +	/* 20 MHz-only non-AP STA */
> > +	if (!from_ap && (he_cap->phy_cap_info[0] &
> > +	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
> > +	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
> > +	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
> > +	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)) =3D=
=3D 0)
> > +		return 4;
> >  =20
> > -	/* on 2.4 GHz, these three bits are reserved, so should be 0 */
> >   	if (he_cap->phy_cap_info[0] &
> > -	    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
> > +	    (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
> > +	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
> >   		count +=3D 3;
> >  =20
> >   	if (he_cap->phy_cap_info[0] &
>=20
> This patch is still reading reserved bits depending on the band being=20
> used. I wanted to do a new version of the patch to avoid doing that by=
=20
> passing the current band to ieee80211_eht_mcs_nss_size(). Unfortunately,=
=20
> ieee80211_eht_mcs_nss_size() is called by ieee80211_eht_capa_size_ok()=
=20
> which itself is called in places where the band is not known. So I'm not=
=20
> sure I can do better than this.
>=20

Took me some time to look into this, but I don't think the band needs to
be unknown. I'd still split this and use the existing version for
*local* data, such as callers in net/wireless/nl80211.c, and have the
band used for parsing in net/mac80211/parse.c. We already pass e.g.
"from_ap" in the parsing context, so we can have the band too. Most
callers aren't even affected since they don't need to parse this, it'd
only be those in net/mac80211/mlme.c, and we can default to
NUM_NL80211_BANDS (unknown) for ieee802_11_parse_elems_crc().

Want to take a stab at that?

johannes

