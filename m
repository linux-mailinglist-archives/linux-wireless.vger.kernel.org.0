Return-Path: <linux-wireless+bounces-8166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D588D14D4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 08:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0354E1C221E4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D236F08A;
	Tue, 28 May 2024 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="X4At9wt6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2F7175B
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879564; cv=none; b=gmEosnevCvauDWbX26fsseDJV4ys1aCm5JZ49spvEwvH7cQjx784vwFNYIETQLZM9sNdZ/eXYMUprc82jICCCBls2OIWs9OeGYv2DAdRCj5ib14j2vPp+9CELbo/voSYiBr4lFZM4n/H8LvY5t20nVbjr5cVmlJTGlfTvPiTZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879564; c=relaxed/simple;
	bh=6noOou4FhPDIRIOEgVyAlRb/9NpMU9BeNGR/9Wx7u80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxUo1VoYRTSBAsEE3olhTMprA+Plxaqn4QsZqJXvu6B8iq32+21KylBSjJCRXrJcfpab3OwdhalNL8S6SU3vP98mHE8rpjiDvmfyRgo+OEjivO1GzLIAk4Lp/vGORXCdVEYzCuYK8+h16mqo9ksZfvVbtDRwLY5jk0sGyjDAyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=X4At9wt6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZDYINnK6bm/PfblsKhcifQ7sShTjvOl+WU+vxSMS6U8=;
	t=1716879556; x=1718089156; b=X4At9wt6mqGInNUQA9eh0MMh1hVIuzIW0ZCgYXko5XGIxe8
	CGcOzaD84+8dqjYS0C4OPs2dv1QHC2UefSlbaQ9WcM3brKYzuCHGcS189fTAEHMXYaOpHsW4kdzkV
	BIwYlD/Wq4W+ZrsMENe+lGAbyPmLktAU6YExxaHwztIwDz4Y5+PMn645uwV4J3oeVgN3kvG/53rOn
	xQadE/psWT140dmqF0SPZN2kzS/6PbbcLQ5kN08J3Nzia+aT5LwVs57Kv63IDi8p04O+Ntp3aFcnY
	xH4lbnANTy+TrJaSy4K5Z6972MvFVopBhQ7SylOja57KEJ8itYsOpE1MohSYdxCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sBqna-0000000E3td-1ssg;
	Tue, 28 May 2024 08:59:06 +0200
Message-ID: <edb8cf11187349003b2d61c8cc71e4bed28c31f2.camel@sipsolutions.net>
Subject: Re: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Bitterblue Smith
	 <rtl8821cerfe2@gmail.com>, Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
 Larry Finger <Larry.Finger@lwfinger.net>, Christian Hewitt
 <chewitt@libreelec.tv>
Date: Tue, 28 May 2024 08:59:05 +0200
In-Reply-To: <ee442840754e4afba8388951f56c5e82@realtek.com>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
	 <5f2da7ee-876a-42fc-8fec-ec5386fa8c26@gmail.com>
	 <0002749a3b584bc39fa18b3137153fdf@realtek.com>
	 <20240527112534.4dbcdf75@mir>
	 <29f850c5-4f61-466f-9a7a-437b05bc8251@gmail.com>
	 <ee442840754e4afba8388951f56c5e82@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-05-28 at 02:39 +0000, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> > Johannes suggested that we should set hw->wiphy->retry_{long,short}
> > before ieee80211_register_hw(). So that would go in
> > _rtl_init_mac80211(). That has the added benefit of making the
> > true retry limits visible to userspace ("iw phy").
> >=20
> > The problem is that setting hw->wiphy->retry_{long,short} is
> > not enough. rtlwifi still gets the default retry limits of 4
> > and 7, because ieee80211_register_hw() doesn't set
> > hw->conf.long_frame_max_tx_count (and hw->conf.short_frame_max_tx_count=
).
> > Johannes suggested moving this code from ieee80211_alloc_hw_nm()
> > to ieee80211_register_hw():
> >=20
> >         local->hw.conf.long_frame_max_tx_count =3D wiphy->retry_long;
> >         local->hw.conf.short_frame_max_tx_count =3D wiphy->retry_short;

Right, so I suggested that because then driver changes between alloc and
register can take effect=C2=A0rather than being overwritten, and these are
the retry limits that are actually visible to userspace.

> > I didn't do this yet partly because I don't want to compile
> > the entire kernel, and partly because I'm not sure how to handle
> > the different retry limits for AP/IBSS mode and station mode.
> >=20
> > Can we change hw->wiphy->retry_{long,short} any time, not just
> > before ieee80211_register_hw()? If yes, what is even the point
> > of hw->conf.{short,long}_frame_max_tx_count ? It would be simpler
> > if we can ignore them and use hw->wiphy->retry_{long,short}
> > directly.
> >=20
> > What do y'all think?
>=20
> Logically I think you can change hw->wiphy->retry_{long,short} any time,
> because cfg80211/mac80211 seemingly just bypass the values to driver.=20

Not quite, I think there's some additional layer of thing in mac80211?

> But we can't know if user space has set the value, right?

You can't check from the value, but that's why I said to change the
defaults before registering etc.

> One thing is that should we honor the values set by user space?
>=20
> If user space has not set, driver wants to control this value by itself
> according to AP/IBSS/station modes.
> If user space has set, driver fully follows the value from user space.
> Is above the behavior you want?

Honestly, is it? I think most drivers these days probably ignore the
values from userspace for lesser reasons (e.g. iwlwifi always has a
firmware-internal limit of 16 IIRC.)

This API also comes from the dawn of wireless in Linux, and was just
ported from wireless extensions to nl80211. So I wouldn't feel too bad
about simply ignoring it either.

johannes


