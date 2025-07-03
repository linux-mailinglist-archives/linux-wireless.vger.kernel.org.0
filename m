Return-Path: <linux-wireless+bounces-24795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E490AF7AAF
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 17:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2966B17C179
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jul 2025 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1402F0C53;
	Thu,  3 Jul 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kZ7FIOn3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6772EE97A;
	Thu,  3 Jul 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555483; cv=none; b=roYDYzSquBZg+t2diL/q8jy6y4EUgLFTnBcQsrLPwiCskOmq3MOXQFrxUGeyCUQh58MvgKJfLNYwR7nZcWb1GEGQ6bPBiuJTvAzYsYbN/TqFwHGZaD6+SBEm7TDDk24sltFTw94FoTMJ8sSmpIHdn3ieTg5G4oaNcs8TmxUdvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555483; c=relaxed/simple;
	bh=YOrVNoAD6vv/nBY0LzvyDWsjUUSZ20BfmbxL9gSwJlg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CzhfWdYCB9K7bqd03oyOO37O2OCtNo5wAdIwPAtOy76gbjQvX3ut5JUa/GiMqgYbZ4DGBroXWY8fRWeUAOfz9Wep1N7sCjuOp/lgXskMhGHlW+ge5fwELWSSYQgwYKWwaZ+upwriRDoe4DRLdivpjIgUUhpZVJqlC4oyPczcBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kZ7FIOn3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YOrVNoAD6vv/nBY0LzvyDWsjUUSZ20BfmbxL9gSwJlg=;
	t=1751555482; x=1752765082; b=kZ7FIOn3nd0E88h2EuXCG8bMRlzNOD+OGz65lQlKFH2CGe+
	L+eFs91QJ2zWbgIbk5CiL8DgZYwXR+T/ysFBDgyMKmB5Bs5s9GtOrTPr7JmghuHyHwDAtdjEk+6oH
	1GIiKjgOLl4IsICx2IULvjNHwue6IX3W6Sc5tmIHQi8tUvo1eCFSW9XbL8G/wtoMJ8diC9+AMbOZa
	B81zjrt6O5burRe9Qb/H2y/1AlwHfAg9013PSsC64+hj/y0/PNZ4UPGnv9ZzRfsFrXVnXUKplYlKR
	tWWjwdSu+hmD7gvuIHPEB4HMth58mOVe/XuSduD/fs5Ew58yKnbUNSndR9xrUERQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uXLap-00000005Sg7-1Z0m;
	Thu, 03 Jul 2025 17:11:19 +0200
Message-ID: <6ecced8b962cf3a6f5056a87aa3442c49941e74c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: reject VHT opmode for
 unsupported channel widths
From: Johannes Berg <johannes@sipsolutions.net>
To: Moonhee Lee <moonhee.lee.ca@gmail.com>, Nicolas Escande
	 <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, 
	syzbot+ededba317ddeca8b3f08@syzkaller.appspotmail.com
Date: Thu, 03 Jul 2025 17:11:18 +0200
In-Reply-To: <1f13328a55c54fb49d8ca1dd72bc5de23f161ac8.camel@sipsolutions.net>
References: <20250702065908.430229-2-moonhee.lee.ca@gmail.com>
		 <DB29OMQH4W9Z.1GPKEZBBIRSTS@gmail.com>
		 <CAF3JpA7wM4JBdd6OvGS+hmv0UahcW=h4HrPNDwRNhduk8iKsWw@mail.gmail.com>
		 (sfid-20250703_110226_928227_85F0E8E1) <1f13328a55c54fb49d8ca1dd72bc5de23f161ac8.camel@sipsolutions.net>
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

On Thu, 2025-07-03 at 17:09 +0200, Johannes Berg wrote:
>=20
> How did syzbot even manage to get a 10 MHz thing running though?
>=20

n/m, it just did that quite explicitly. I really want to get rid of all
that 5/10 MHz code, but we still have S1G so that might still happen
anyway, and I expect for S1G VHT operating mode notification frames
_are_ invalid.

johannes

