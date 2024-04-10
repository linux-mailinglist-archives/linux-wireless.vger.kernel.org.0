Return-Path: <linux-wireless+bounces-6072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A689ECCF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 09:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CA8B24B83
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88D113D60F;
	Wed, 10 Apr 2024 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MSLZUtIY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89913D535
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735800; cv=none; b=qinryYJv2n1/5nx2Yshp5V3/GxXFw2w0GFDeh5SPuicL+FH8LwzktwB+hLrXZS8DIbI0axL/GPiBOj0y9bElHhn2CLJO2d/cYxhsTJ257KNZaq9tKTQzCiToM54d42d6FET3AELTOo7Zz8P4v2z3ONksyMnpUNQi9vx8C16MwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735800; c=relaxed/simple;
	bh=EyCsOjvYWcw8ZMkgSOdW3Hs9mwR7vIMqzLHXKwNDIik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rB/AAYUPpoHQ8eFBwdwQJP8lQrpksBEQVIqfPvW8IiVXOvxrjMzcM38aLP9wlv6U8QADUcWOvFJEX8OY6x5fk1GD1JWijEmGsCkBrqT3FVW4Dzw73Bb6jSN5fY1FhmAjrnIVOQDQLMz7Y9lnFuIlLxWyCXe2R2bBpLHQKZ0wPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MSLZUtIY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=m0scYqStgxZbWMDUaVHUNB5CmHlQnGVtrgSLw2qoU8g=;
	t=1712735799; x=1713945399; b=MSLZUtIYGIffbXlasvPeE2ZtnLONCN3crmZhAKIfeuVKc9u
	Kl52XCI8WEWKS8X25ZnI5F+u2FqOU49pOcg0DK/5WJHRMboBuE5kCnyq08kQaZ/URpQSGkUwkccPb
	x5mrmSKN5dslWYQCjpgiC1u8gzZZDpp7ZOc8vskON5X0Tf2+CzF3i4cT8ea3zkn9P9iVRAY2BZQvO
	1CweJUKzdeqh8wVCXgeSm0dodomy+iTPTkz+F8oHdjAGe0/HjqFgFdsvGZ6BUno2IXJAJHZYU4PTu
	NhFN2eS6F4svfSqso2dpX192FwzVR3BM5K6k2CZ9o4OTJFI+ryJcTRN4r259MtHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ruSos-00000001Ei3-1Y5e;
	Wed, 10 Apr 2024 09:56:34 +0200
Message-ID: <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise
 multiple radio in one wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, Vasanthakumar Thiagarajan
 <quic_vthiagar@quicinc.com>, Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>,  ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 10 Apr 2024 09:56:33 +0200
In-Reply-To: <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
	 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
	 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
	 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
	 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
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

On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
> On 3/29/24 07:30, Johannes Berg wrote:
> > On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
> > > >=20
> > > > > + * @hw_chans: list of the channels supported by every constituen=
t underlying
> > > > > + *	hardware. Drivers abstracting multiple discrete hardware (rad=
io) under
> > > > > + *	one wiphy can advertise the list of channels supported by eac=
h physical
> > > > > + *	hardware in this list. Underlying hardware specific channel l=
ist can be
> > > > > + *	used while describing interface combination for each of them.
> > > >=20
> > > > I'd expect there to be a limit on channels being within a single ba=
nd on
> > > > a single "hardware"?
> > > >=20
> > >=20
> > > There are ath12k hardware supporting multiple band which need to be
> > > registered under one mac80211_hw/wiphy. This design is to support suc=
h
> > > hardware.
> >=20
> > Oh OK, that was something that I didn't have in mind any more, or never
> > knew or paid attention to.
>=20
> Would it work to leave the phy reporting pretty much as it is now, but ad=
d
> a 'associated_peer_radios' list section, so that each phy could report th=
e phys
> associated with it?  Then user-space, driver, mac80211 etc could look up =
the
> other phys as needed to get a full picture?
>=20

There's not really a good way to _do_ that short of creating multiple
wiphys, but that causes _massive_ complexity in the stack (both cfg80211
and mac80211) so we rejected it years ago.

johannes

