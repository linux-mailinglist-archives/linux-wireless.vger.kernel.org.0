Return-Path: <linux-wireless+bounces-27763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD1BAF57D
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Oct 2025 09:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C725E16F381
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Oct 2025 07:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA0239072;
	Wed,  1 Oct 2025 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ORbo/EDx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55D537E9
	for <linux-wireless@vger.kernel.org>; Wed,  1 Oct 2025 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302052; cv=none; b=Dyq0vpxSeRJZAeMB6NZJahbUj+AtEoRIrrjUWdbhRiw/A6Rpz1Btkas1RvQfdo5dY2qA7AB4WD1I82VihXsI2dPgYZF/o48Mb0uBUVpB9pMIIC3h/FZY330YmJMw+kCv7MQMfRo+GdV31MUpN5YOBV8WgmxunUGWCyNBFxaxqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302052; c=relaxed/simple;
	bh=6e8C6OXkvduiC+LunGmHritoWKV+2gepVdM5FCPA52w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tz+u1YXmXQgkpYqJt+5STvkTfGIJ2Q2TVEVEjZb8/LIgA7XoOeQ3G3v1iyWlwZ7brc+uZJ/LtZCEbqHi6DW/U/fnsBDtVAGySexynwF/MsMl6rEvuhubleWcAxRRQVBGnqmW7ireaCu1iUK6dQkUotjOsii3814bySe0lz0iHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ORbo/EDx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ztq162zVtWq3k21Yz2f4tsJnfZMVphkl0grRqYfVZ8o=;
	t=1759302050; x=1760511650; b=ORbo/EDxTezP1623W1BL4QNckwCgw2btvJ0GvOu+NDAoUvB
	k222UYdY88HdqjAvrCTXowm1rmEZJCWiYIG7lQVHeOYbTjhyvgTbozf80imQdqmGRNHSrT444h2U5
	vAtWN3noCmw6FLtE1woY/CEGiwrLlYvM2SKlTL3+iEnMbldHRdxdcFVKvt+89d+Zanr2TeOHZ1mEI
	gckS/QvbDFwJV6AC4rWcnfEEzwyut6jc7l2cVz51tx+UBuzzXv6D7KETk339aTpohpyOpi9KjcXdV
	CH5z7OHPg+OYwj9JSEHiLSZ1tZknChFqEXpg+Q5C2APd72uybWiaRQw2ZvE8J7eQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v3qpT-00000005SUv-3HbF;
	Wed, 01 Oct 2025 09:00:47 +0200
Message-ID: <64ac5b780b412f9a663e86d2745e580a7db6b8e3.camel@sipsolutions.net>
Subject: Re: [Bug Report] Intel AX1775 / AX1790 / BE20 / BE401 / BE1750 2x2
 (Wi-Fi 7) fails to resume after suspend (s2idle)
From: Johannes Berg <johannes@sipsolutions.net>
To: Francesco Bergesio <francescobergesio1@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 01 Oct 2025 09:00:47 +0200
In-Reply-To: <CAFXXzTZD3Wfywo2Mug8=3TrV2b0hsFSMERyd8YpzUgnBzP4uDA@mail.gmail.com> (sfid-20250930_153512_261503_49300BC0)
References: 
	<CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
	 <76fa4cd8d3598c771f5e1c8bb305c241907edc77.camel@sipsolutions.net>
	 <CAFXXzTZD3Wfywo2Mug8=3TrV2b0hsFSMERyd8YpzUgnBzP4uDA@mail.gmail.com>
	 (sfid-20250930_153512_261503_49300BC0)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> iwconfig
> lo        no wireless extensions.
>=20
> enp45s0   no wireless extensions.
>=20
> docker0   no wireless extensions.
>=20
> br-3558f493dc1a  no wireless extensions.
>=20
> wlp44s0f0  no wireless extensions.

This is totally expected, FWIW, since you have a Wi-Fi 7 device. It's
always this way.

> set 30 14:48:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
> nl80211: deinit ifname=3Dwlp44s0f0 disabled_11b_rates=3D0
> set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
> nl80211: deinit ifname=3Dwlp44s0f0 disabled_11b_rates=3D0
> set 30 14:48:42 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1656]:
> ioctl[SIOCSIWMODE]: Operation not supported

Evidently, for whatever reason, something in the system decided that
wext instead of nl80211 should be used even though it's not even
supported for that device ... but I really don't know how that might
happen, I think you need to look further up the stack perhaps?

This probably wasn't the _full_ wpa_s log, maybe you could increase the
logging verbosity as well, and then show from boot over suspend/resume?

johannes

