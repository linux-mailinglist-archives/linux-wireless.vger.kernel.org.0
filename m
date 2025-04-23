Return-Path: <linux-wireless+bounces-21914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C7A98C47
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3D51624D5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B6C27A10A;
	Wed, 23 Apr 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NErA9wOa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FB2797B8;
	Wed, 23 Apr 2025 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417050; cv=none; b=t9iOEktozQmKnB0HoY2nvAH4QRXkr83scSkHnUmv6ritAGyG2/DMG/tIbbvCvmaOtFmhZrBDFNyDpoiXWR1/Y0weviYGMeeM1UKySQ77SMbPISpB4pBOyTQH+H8Dw9nU9de/qu4uf9Q5kC37sS2ZSobvxXMnRV99BWHBVPH5+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417050; c=relaxed/simple;
	bh=IE9+QhGjstZ+dXjDylZNdtZWhXj8gUk7kwoxYglND5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/8P0afwX0BdJRrknzu7/5q98GAOYKkMAqab3BP16nxiF1tQFVvLqLKfx66LBmDBdq5R40aeg1qUTOlhwUsU5v9gqoVkGeGyt5QYVd85JyueafwBAW+OBy/Bg2yq15HLChySSzkyc7Cj2PPQeqIIXJuhZgk16ZP2rBIEZaqqnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NErA9wOa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oaGiHzShZ+7Se81JoQaFP8hejDedRsEVccoTeyzc4dw=;
	t=1745417049; x=1746626649; b=NErA9wOauBzLnyJ1h7Ns/jH0B6mcuYXQnm/MjDb7+KkTK5N
	W7YnpftsMJvRXEVwEGvZWHzdNAPx+vn2dPqDsMyqu70sTRQ7uh/HtJIuFeXwF/DZ+E8Hk6Copl7Zp
	hjJeaZ1+koGDwAC2fPR+uqLvZZHOjw/HcdJEfXczFlhcL+2EvbsHaoFTlZJ1C3FX+5N2X17fEkrrR
	9fUBChg7JxhKOP2IN5wRFNuEClEUDqNHWdn38isSb9AjmCnRsK5jwljR1i/PXNsNVwzYvtEQcmaE4
	UbeshGkJ+XwjRsJQybjcWyvrH79tcpabm3PNzzE6+5Q/6LmIsT3wYc9Ak4wz/7vw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7ahp-0000000Ej6j-2iEm;
	Wed, 23 Apr 2025 16:04:05 +0200
Message-ID: <ff63580712b8f20b4be7b38a31bc3bb9d69a4820.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: Prevent tsf from setting if
 beacon is disabled
From: Johannes Berg <johannes@sipsolutions.net>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org,
 syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Wed, 23 Apr 2025 16:04:04 +0200
In-Reply-To: <tencent_6FF36BC379E97AE3ADC450776CD77EA6C405@qq.com>
References: 
	<b30cc04676a031db8c36df243160992094b3848d.camel@sipsolutions.net>
	 <tencent_6FF36BC379E97AE3ADC450776CD77EA6C405@qq.com>
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

On Wed, 2025-04-23 at 21:56 +0800, Edward Adam Davis wrote:
> On Wed, 23 Apr 2025 14:53:53 +0200, Johannes Berg wrote:
> > > --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> > > +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> > > @@ -1226,6 +1226,11 @@ static void mac80211_hwsim_set_tsf(struct ieee=
80211_hw *hw,
> > >  {
> > >  	struct mac80211_hwsim_data *data =3D hw->priv;
> > >  	u64 now =3D mac80211_hwsim_get_tsf(hw, vif);
> > > +	struct ieee80211_bss_conf *conf =3D link_conf_dereference_protected=
(vif,
> > > +			data->link_data[0].link_id);
> > > +
> > > +	if (conf && !conf->enable_beacon)
> > > +		return;
> > >  	/* MLD not supported here */
> > >  	u32 bcn_int =3D data->link_data[0].beacon_int;
> > >  	u64 delta =3D abs(tsf - now);
> >=20
> > Please keep kernel coding style - the line break there is awful (but
> > with "conf =3D ..." on a line by itself it can be just one line), and y=
ou
> > shouldn't have code before variable declarations.
> like this?

Looks good I guess, not sure you wanted bcn_int/delta to be calculated
before or after.

> > The comment should probably also move because it's relevant for your ne=
w
> > [0] as well.
> I don't understand what you mean.

The "/* MLD not supported here */" comment refers to the [0] - it
explains why the [0] (rather than link id) is OK. So it also applies to
your [0], if you're going to put it before the comment then IMHO it
makes sense to move the comment. With what you did now the comment is
still earlier though, of course.

johannes

