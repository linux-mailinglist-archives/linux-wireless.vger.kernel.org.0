Return-Path: <linux-wireless+bounces-23556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF7ACC6B2
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B5A188FDB5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072422B8AA;
	Tue,  3 Jun 2025 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N+EL1vXj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2C1E480;
	Tue,  3 Jun 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953797; cv=none; b=kDNUdok5IorE4lSJ+yj4r3vJkBc5M1Tb5YlO+uBJ250/4f3VrOnmYfBoFW9kzhFWSk4Ju63wCmcg0YQAuuvZTn1NugvHGbaLiWmZUguJx6SwppU7EgvqQZ2wWxLiNC/FQ8sQKz4lCBtmrk6ssmkjzcV2NYPBiDnqZ95ijCCyxxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953797; c=relaxed/simple;
	bh=EJ3vtLMRE9nU34HrJtlVLrn7CTWssh0N/Iuw9ClKjxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XFYPJSzdXGOFTKxtnAM7HWpMGnsdCSct+Fenzm74zq7wMZbNA8eZ2eA1lHQ75jlLGs8lchVyQ3wZ7M+0XenrJ5oaht/SzLkK3wZBD47hTqspzDcnT1bXQsmmB9xgzlO4zgf3GMOCICrCRjllmq0UJnxdZwN14nB7eE+nWkg4QMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N+EL1vXj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1wFv4E4H4+ITr6cUWlDT7dX1EXLjbJF+/Xd3l7yPvSc=;
	t=1748953795; x=1750163395; b=N+EL1vXjetDFTMOI1vMFh+0nQ7PniEkluP/MoX1xdTQzl+I
	o+GO4QgPlGkVFTejVRqWq2yBWlG+qzTAZkyXCS3dqrEFlYfSF98VmKWpO1hX9lfH1FxslBS90Vhme
	vjAStFySSpFjmlwRsP4LCLpjGBbJMeWsNAFKKiSnZa1UsG/bqscI84bFTFub9hr6JCcowBYsOcl2T
	aL8km1fHIWVYhSxMnPdA+twiP/sVfzJeZj2KbffIKWr7ejM/scHoF/shTWm2VCxMq0Yli27eRReX+
	1GcuAE45vL9ik0O74HVksNyF1ZkTB3mahSrFSQNipunAFtwDoaZQ49SetYM0rAXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uMQm8-0000000AODd-1p4O;
	Tue, 03 Jun 2025 14:29:52 +0200
Message-ID: <5095079184a282ae552c50c8c121a632d51b0419.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 0/5] wifi: cfg80211: Add support to
 indicate changed AP BSS parameters to drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Ajay Singh
	 <ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	wlan-kernel-dev-list@infineon.com
Date: Tue, 03 Jun 2025 14:29:51 +0200
In-Reply-To: <aD7mpkhmQXuN9tMT@ISCN5CG14747PP.infineon.com>
References: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
	 <e36c8a9149f85383b4f3e8793381842088853dbe.camel@sipsolutions.net>
	 <aD7mpkhmQXuN9tMT@ISCN5CG14747PP.infineon.com>
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

On Tue, 2025-06-03 at 17:42 +0530, Gokul Sivakumar wrote:
> >=20
> > > In AP mode, the "ap_isolate" value from the cfg80211 layer represents=
,
> > >  0 =3D allow low-level bridging of frames between associated stations
> > >  1 =3D restrict low-level bridging of frames to isolate associated st=
ations
> > > -1 =3D do not change existing setting
> >=20
> > Is that -1 still true? Seems like now it should just be that
> > CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE isn't set and then you don't touc=
h
> > it?
>=20

> Kindly note that the driver is rejecting the SET_BSS operation if an
> unsupported AP BSS param is passed by userspace, while the opposite is no=
t
> true. ie. the operation would not be rejected by the driver, when a
> supported AP BSS param is not passed by the userspace.

Sure. That's a different question though.

> So yes, the significance of "-1" still holds true, because if suppose the
> userspace skipped this param in the SET_BSS request, the driver when
> receiving the request will have the ap_isolate param with the default
> value "-1". The driver is checking if the param value is >=3D0 before
> proceeding with handling it. And will ignore the param, only if it is -1.

Why though? It seems odd. Basically in this case cfg80211 is saying "I'm
not changing this parameter" but then anyway you check it's value, why?

While we're changing all the drivers, it would seem better to me to just
change them in a way that they don't look at the value if the
corresponding change flag isn't set?

johannes

