Return-Path: <linux-wireless+bounces-25805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C327B0D37D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 09:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CC217A986
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC262271454;
	Tue, 22 Jul 2025 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EdsZUodD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD12C1584
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169695; cv=none; b=sS2cnA4xp3xV6srlgGIfIhIVQhaowOkslTh9CeS6SISHopiIJtf8Y6d2MWiZm8Ks3OVJvhYjBQ+JD+Khezhmd5ibQylXgABl7JNhwiU5B4n8Bw0U3BNSq9hIL2oFaIAsUhpphJ/cINb+ZT7sPRYxAvaZjx3SMg7VQUTWa3AZ/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169695; c=relaxed/simple;
	bh=V8OLQ4jv44OLs52S6xMrB2CMkcE97UFaQJMLJULcr6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KE4OEEz4QrE3nSLy0JQ6y/wKpCgQtjZPKB83MqPcT2Pyj0eAIDqmMQ2XXNZG92nUp11Zhld5nXHY3TEjXtquWgJQXtyz1PEWi0KLmlo9iSYuymtUUCykoekIwL3Qq95YWxWMzb8g2tOG0xVq5/PaRdi1/s8avrqNjEJrcIm6qKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EdsZUodD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ncoMt+sfYGjRW0C2UdSd0aDJxoLcZnsHIiCMWholuuw=;
	t=1753169694; x=1754379294; b=EdsZUodDI2THTcMAfz0uhjtr1uxE1Vjzo6udYGH8Gjn9vhi
	bhJEqkGAho5RosQwcj2iYGPWHdj0IKym1h/kFPzDu56y1yW5bSlw8AtI6/AapvkHGC3BPePK6NDJy
	k0rOvjCzAKS+Vf+1hUi0CbYP9gOxN9q2qQteKb9/SYelen3IIGsblB4dRWiUxRiMvLiLM2f11ptre
	d83xGNPdHWRAjAxSLXkRVik5jzuiPxF8H3wrHkvi2pLb2NOVY5vc0nlEQ6aagsMAJ2FvxxlCtZQ1p
	OemWsnyrfwBkcNJi3ePoTBPJ4Jjg4eXSKnNujG93XcwCLJmyaOe6t5URJiQRbsDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ue7WE-00000001jV6-2vqH;
	Tue, 22 Jul 2025 09:34:39 +0200
Message-ID: <c420f02a76d17e44c7f207e64278d3da8e4f03f7.camel@sipsolutions.net>
Subject: Re: [wireless-next 0/2] wifi: support S1G TIM encoding
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 22 Jul 2025 09:34:30 +0200
In-Reply-To: <tx3gim4qbf6qmwd4u6kqspzu7n37cih42elgbnwedxogvpkxcn@vmzo7fiyrshw> (sfid-20250722_092312_540750_0DB38E5E)
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
	 <tx3gim4qbf6qmwd4u6kqspzu7n37cih42elgbnwedxogvpkxcn@vmzo7fiyrshw>
	 (sfid-20250722_092312_540750_0DB38E5E)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-22 at 17:22 +1000, Lachlan Hodges wrote:
> On Tue, Jul 22, 2025 at 05:16:38PM +1000, Lachlan Hodges wrote:
> > (1) I've run hwsim tests and (obviously) tested the S1G power save path=
,
> >     but the 2 hwsim power save tests only check multicast traffic and
> >     even then only 1 sta. So would be good for someone to confirm that =
this
> >     hasn't broken non-S1G tim encoding. Even though it's only code bein=
g
> >     shuffled around, that wouldn't be ideal :)
>=20
> Something I forgot to mention (my file didn't save ._.) is that I aim to =
get
> some S1G hwsim tests up and running soon as S1G is almost fully functiona=
l
> within mac80211 (1 maybe 2 more patchsets left) such that there is some
> standardised testing utilising hwsim.

That's awesome :-)

A question on that topic: In your experience - since surely you also
work with real hardware - is it plausible that hardware has both S1G and
"regular" WiFi support (2.4/5/6 GHz)? Because hwsim does that and it's
caused some issues with the large number of channels and such before, so
I wonder if we shouldn't be more realistic and at least make the default
not be that, unless we ever expect real HW to exist that does all of
S1G/2.4/5/6 combined?

johannes

