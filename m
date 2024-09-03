Return-Path: <linux-wireless+bounces-12381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2149699D0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3042853DA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F9219CC27;
	Tue,  3 Sep 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w0OhV3rN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569871B9823
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358442; cv=none; b=Iw/XkBs3jCmr5T/73Uxb6Fv2NtCvr6xvpI0kkoRhA+NJnwBTFFSQ7qLU+0wWaUKDsAIoBLQZM7KN+64qRJO4eEf4eD2mHRYbEX9PXyfRQ6tXEMYx3WtUtRs+TDjDamOS8O1hVm3/A8A/pB/nqKRSo1pifziHkYdLSNwvPKvyT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358442; c=relaxed/simple;
	bh=HfxrSvy9u8NqrBWaw8cEWus/YrbzwujbJAjwXt0A700=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eW3x96cKihgK+ueDRZGtWm/w5zKLQL50JGFGHKzP7XpkcKR7ntqYNLFwFQsIv7NeKBMpelqO+VRGYA99XVt4nRo7WkI8f9Dx3pm99BBQY3EI8PcdoTbI4wALUZbKJrcjgVNLRsFMJ5VFkMSxrwT/5ThH3tiIcL7W2kk9UcpbSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w0OhV3rN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=91emzW2qeyd5Us1+Qbz4TmYHR6wKjU1lKFwHDoVieKU=;
	t=1725358441; x=1726568041; b=w0OhV3rN0IBGYa9U6KxDLE6eZ8gWXiivVb9I+8vL8iT2mR5
	VJlAYNA+aY2MaB5D4GWYQTTqtY/xuEc8C/LirCYbD/1/BN2/4sNUpEj49XixBIWLSTH5GD6bNWCR4
	kqeM/XXOWZ83W51+nIQdgcNrlrkxuXhIAliurit8LqABFA6wJRp2DqEVdgbf7V3t6F9Gq6k7RVxNh
	+vitPVSPBIxCefVKcQz5jPl5VsyuGebIpsXG5p2/hL5eIHIfNorf+/phntaK85Pgx9dg6/onGYRWz
	GMxQzeEjosst02d2RSxleL7Swd0+J3lp4BnS1YhZxgMZNTGe7SxNn88nU5VuRy6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slQXt-00000002DO5-4A7T;
	Tue, 03 Sep 2024 12:13:58 +0200
Message-ID: <ff685160d8d3c09db31fc8a77963eae2b0eca5b3.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] wifi: mac80211:  Assign tx-stats to the proper
 link.
From: Johannes Berg <johannes@sipsolutions.net>
To: greearb@candelatech.com, linux-wireless@vger.kernel.org
Date: Tue, 03 Sep 2024 12:13:57 +0200
In-Reply-To: <20240828155458.1990497-2-greearb@candelatech.com>
References: <20240828155458.1990497-1-greearb@candelatech.com>
	 <20240828155458.1990497-2-greearb@candelatech.com>
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

On Wed, 2024-08-28 at 08:54 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> For drivers that can report the tx link-id, account tx
> stats against that link.  If we cannot determine tx link,
> then use deflink.

Strictly speaking, that's not what happens, since the link bits in the
SKB CB might be set on outgoing frames, and then will still be there on
the status.

Also using deflink is totally useless for MLO, so maybe just don't do
anything at all? But might be simpler to just do deflink and document
that the driver must set this? But not sure that really works so well
for drivers now.

> +static struct link_sta_info*
> +ieee80211_get_tx_link_sta(struct sta_info *sta, struct ieee80211_tx_info=
 *info)
> +{
> +	u8 link_id =3D u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_=
LINK);
> +	struct link_sta_info *l_sta_info;

We usually call that 'link_sta' ...

> @@ -48,6 +65,7 @@ static void ieee80211_handle_filtered_frame(struct ieee=
80211_local *local,
>  	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
>  	struct ieee80211_hdr *hdr =3D (void *)skb->data;
>  	int ac;
> +	struct link_sta_info *link_sta =3D ieee80211_get_tx_link_sta(sta, info)=
;

and even you do, please be consistent with existing code and yourself.

>=20
> +		link_sta =3D ieee80211_get_tx_link_sta(sta, info);

Does it really make sense to keep repeating this, rather than passing an
argument?

johannes

