Return-Path: <linux-wireless+bounces-15963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9B79E6B4A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 11:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21009281DCA
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8071EBFF8;
	Fri,  6 Dec 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="swZuT8S2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8E1DFDAE;
	Fri,  6 Dec 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479645; cv=none; b=dhk7O+OSf7iP4WRdEwhaosPT+56oN+FjepRk/yL0+JoQ08CpOBoUmIW5i6vDLV1g7P9QOtxmtRIVbYoBQtgncpxheeab5dCjxX/NbPnQOjk1lbAarXU4ma2PDJutvFedu3JfDCqbt+E/zSamSe8of+Fnr5Z6yQyBuRil28tLvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479645; c=relaxed/simple;
	bh=Q+WgJFQIhR1yawGidZ9ieAKZHDqGm8OzxV2oFsZQ8Xs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7+JzbS64X37uW4znAYqCsik77Hp13JySdHOgBDvDy/3HlLBOXaZxi6sfjkRssdCtYLYABcgHAB4ur+YW2FRfO5V/K/lL8HR30P1CaTr0Nzl/Wom+xrZAPw9nKXKulmnO3znFNagyxTe9hwkzxy0hvb1DVDCL8Y7uHhamlRw8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=swZuT8S2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q+WgJFQIhR1yawGidZ9ieAKZHDqGm8OzxV2oFsZQ8Xs=;
	t=1733479643; x=1734689243; b=swZuT8S2jVch4gEzY8WcB18lOa9Apo7coZ1QYtqE+u+gd3O
	oC0QZu+O08q7nWG00WsuL1IewBIutVMgZuoP7zgt6wQyYNnyJihJbrg0kdMcoLltwyMVjcbJay1QY
	HmLW9pfVWiQ4mIWABMus3lGDP4LrqHfJXPcsMP/o5HAZLP/h6WV1bOP2QRhMrXabV5mwFNnegKTUe
	aXAG5j/VF1TVHtJve75PuO/HEpbgnIwbVegrAv+XfV3673Ipz5BdgubD/k8vQ3e7MVWMQqoPiBvEn
	+LtTru2L+R8TBh6BTL4dmFP4xFV8UFteXcYcI3sAaU0krKhKHWCEsoA9Tfo1KH1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tJVF1-0000000FS3O-44ek;
	Fri, 06 Dec 2024 11:07:20 +0100
Message-ID: <9c497dca795ed9f62f0505daf7f9311a803334c8.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: re-order unassigning channel in
 activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 06 Dec 2024 11:07:19 +0100
In-Reply-To: <a60eb1a7-9739-4dbc-a683-417ac6d47adc@quicinc.com>
References: <20241205-unassign_activate_links-v2-1-ba3f0a2bb4a4@quicinc.com>
	 <d0acd2178504d76770e9267ef6e7f5c04b50eab3.camel@sipsolutions.net>
	 <d421f8067ea54bcfc38a9b021ebda13515145c45.camel@sipsolutions.net>
	 <a60eb1a7-9739-4dbc-a683-417ac6d47adc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-12-05 at 20:43 +0530, Aditya Kumar Singh wrote:
> On 12/5/24 18:30, Johannes Berg wrote:
> > On Thu, 2024-12-05 at 12:43 +0100, Johannes Berg wrote:
> > > >=20
> > > > Therefore, re-order the logic so that stations are handled first an=
d then
> > > > channel is unassigned.
> > > >=20
> > >=20
> > > This causes memory leaks in my tests with iwlwifi.
> > >=20
> >=20
> > And also firmware crashes because the station is removed while it's
> > still being used.
> >=20
>=20
> So is this exposing some underlying issue with iwlwifi?

I don't think so?

> Or this change=20
> will break drivers which does not group multiple hardware into single=20
> wiphy?

Not necessarily, but it breaks iwlwifi because of the changed order of
operations, and what it does with the firmware.

I think the issue here is that we treat link active =3D=3D link has channel
context in iwlwifi, and an active link in client mode requires a station
in firmware. Otherwise you cannot even deactivate a link, since that
requires sending an NDP to the AP, but if you don't have the AP STA you
can't do that ...

I guess the driver could be changed to treat station links as active
when they have the AP STA entry, but that seems ... difficult and
strange, it would make it different between AP and client modes?

Looking at your commit message more, I wonder if it really even makes
sense to *delete* the link when the channel context is unassigned,
rather than (similarly to iwlwifi) deactivating it and deleting it later
when it's actually removed (change_vif_links)? You do know which
hardware it is/was on, after all. And these two operations can *never*
be atomic. Removing the STAs first might be something that's appropriate
for AP mode, but I guess I'm more with iwlwifi here in that it doesn't
seem quite right for client mode?

> Also, how about non-ML scenario in iwlwifi? There, first station is=20
> removed and then the interface goes down right?

It's not so much about the interface but the link, it seems.

johannes

