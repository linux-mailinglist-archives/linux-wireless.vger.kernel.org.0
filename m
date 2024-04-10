Return-Path: <linux-wireless+bounces-6122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9984589FBE4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FFC1F223EB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928FE1E878;
	Wed, 10 Apr 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GrwJowSR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78A15444A
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763739; cv=none; b=iTKRvDBZGeSXx01wO3M30by76BNyjFp7cEqhBfwGpwy5tCdHZriaZw7WiaEeypSMhH8E9KnZRUQEbEdLzrmaikehCFeIVQDZELNE5MK7OzVWmZJEFW/NCNmhOLIon8l6fKZt89U/7MPQww04v+o2nCNsY2LqAtpMgKUZ6c38GE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763739; c=relaxed/simple;
	bh=x/M3yzOkbzwkoPErO/45O/soCl66PnndHvdAt/vqp2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CovPICTMWOPfwpfpuFzP4Ql9ftDJUW7RrnW8c7CLHUeAmvbi5h+XeKdHRGPoSPWLXAYuwgV6mqGdBK2QPOdYa2ktFzpWPnc0Pd7ENE2mSVZ1pu30egchP7qHXp+kJJMc4lvjHxUF8ZsAoF/24vlqhhiBRWl+CefYerhZ/HcGSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GrwJowSR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HwTqnHnJJ2QLV1zJVZUgS64ZDJVq53r7OiGOg7qIs9Y=;
	t=1712763734; x=1713973334; b=GrwJowSRg+euSnctYfTBvk+tB/6VOPWPrLTfiqmdk3d8k5/
	34RVhIUQiw3uuGI3A6Wq7xNQuJcUi9geIY/gaT3KEOjX+U5K8AzM0PYiHB+cuQKDJsKbtUJhol+T9
	aD8V/tGBhZM7YXkn/NBgDrdxClZmGWJkIB/QFSqZ8Sf9HfaqDCt5HGi1PEHzWdBdI2ly4kv/cSlEv
	N5T5JfHvhIeUB0ePyEtJMbr8y05fufLrqAfTaNhhkNjNB/qbt1kgoW+E1Cn80qT2OVFSwhuSoYtl6
	gUV3VKT25ZclA3eqBb1xuAsss0zddx6624I5y/dSqJxWKYolVWa05yNXy4DZ1Rsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rua5S-00000001VfA-2SeY;
	Wed, 10 Apr 2024 17:42:10 +0200
Message-ID: <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise
 multiple radio in one wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, Vasanthakumar Thiagarajan
 <quic_vthiagar@quicinc.com>, Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>,  ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 10 Apr 2024 17:42:09 +0200
In-Reply-To: <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
	 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
	 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
	 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
	 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
	 <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
	 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
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

On Wed, 2024-04-10 at 07:37 -0700, Ben Greear wrote:
> On 4/10/24 00:56, Johannes Berg wrote:
> > On Fri, 2024-03-29 at 07:47 -0700, Ben Greear wrote:
> > > On 3/29/24 07:30, Johannes Berg wrote:
> > > > On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
> > > > > >=20
> > > > > > > + * @hw_chans: list of the channels supported by every consti=
tuent underlying
> > > > > > > + *	hardware. Drivers abstracting multiple discrete hardware =
(radio) under
> > > > > > > + *	one wiphy can advertise the list of channels supported by=
 each physical
> > > > > > > + *	hardware in this list. Underlying hardware specific chann=
el list can be
> > > > > > > + *	used while describing interface combination for each of t=
hem.
> > > > > >=20
> > > > > > I'd expect there to be a limit on channels being within a singl=
e band on
> > > > > > a single "hardware"?
> > > > > >=20
> > > > >=20
> > > > > There are ath12k hardware supporting multiple band which need to =
be
> > > > > registered under one mac80211_hw/wiphy. This design is to support=
 such
> > > > > hardware.
> > > >=20
> > > > Oh OK, that was something that I didn't have in mind any more, or n=
ever
> > > > knew or paid attention to.
> > >=20
> > > Would it work to leave the phy reporting pretty much as it is now, bu=
t add
> > > a 'associated_peer_radios' list section, so that each phy could repor=
t the phys
> > > associated with it?  Then user-space, driver, mac80211 etc could look=
 up the
> > > other phys as needed to get a full picture?
> > >=20
> >=20
> > There's not really a good way to _do_ that short of creating multiple
> > wiphys, but that causes _massive_ complexity in the stack (both cfg8021=
1
> > and mac80211) so we rejected it years ago.
>=20
> I thought the problem ath12k is trying to fix is that there are currently=
 multiple phys (radios) that needed to be made to
> look like a single phy?

Correct.

> For dual and tri-concurrent radios, I think we will need them to look lik=
e 3 individual radios for non-MLO use
> cases

No, I don't see why, and if you want that we wouldn't support it anyway,
you'd have to have a module option or something to decide which way to
go.

But it really ought to not be needed - the point of these patches is to
give userspace enough information to know how to (and where) to create
separate BSSes, with or without MLO between them.

> For instance, mt7996 currently reports 3 single-band wiphys, and each can=
 be used independently.
> But assuming it starts supporting MLO, then those 3 single band wiphys wi=
ll need to start acting
> at least somewhat like a single entity

Yes.

> (while also concurrently being able to act as individual
> wiphys so that one can do a mix of MLO and non MLO sta/AP.)

No.

johannes

