Return-Path: <linux-wireless+bounces-12005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AF95F98D
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 21:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164791C21B4E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 19:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6F3198838;
	Mon, 26 Aug 2024 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uKsh5P/u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1F7A15A
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699993; cv=none; b=faR7E5AyC33rMo6aPs6yljfATyDE+yMj1dGN7NkdF0gKPchYlZvbKTLqFiBq+sJk8b0hV7YHbhDgKIHZ6RUsr8yiQGnYYurIt/NI1fsEt0hZVAH8oVdgXsH9J+ZI/Kt81h1tamBqfl110kmxokiIpN/6jJgmxUILbW0kxmf5uk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699993; c=relaxed/simple;
	bh=HMSEQEemfIVvu6MWhPydZwc3XZqJSSQPzTr5WlqcMXY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3Cm/TnAIpXjLBTLqaEuOOIVyMoksHoFQt9P2dabYGGkpNkY3hv4lg1o26pnam8yPB3zxPcAsycgzf1gApVPxX2TN96WSa9KWB6fWxPnF7b6IRHRzOhLx4hxmxG0eGBIQNw3gSt3Gxtpb/JkxOKVRqLyqh1AZrdf5RQRl78g3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uKsh5P/u; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HMSEQEemfIVvu6MWhPydZwc3XZqJSSQPzTr5WlqcMXY=;
	t=1724699991; x=1725909591; b=uKsh5P/u1d3MvTvhNPx1l9+c6VJNNWj91Yz4MhVWcJgBJNf
	5Ke3sQP7XrLl9htqRHvbiI8wiYAEFMmpFq6Ezyc+WtvOsve8/5HXHbRGSif42txOaxhbe5qTbrWOD
	nuuDC6AciQ+lzZmN2yTslaJZvrofda44fEoC1ZR2/wzDpaD2tE7Le7YVSbc4hn6q9oJNarVDSqz5+
	ubJTLLx47wBEHaOB2yz2yiitDly8bnMwM4H+Kvj/k7LJIx4/Km9MaFRIIxPgUudz4tdIyl0accdwP
	+Z0I3m9dKqz1WeYN12JClfWGMED6L3QRY9AZtk2RJGtdHmwdl9M0QOjkzBqbT+GA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sifFk-00000003POc-3TUf;
	Mon, 26 Aug 2024 21:19:49 +0200
Message-ID: <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>
Subject: Re: WiFi constantly changes association
From: Johannes Berg <johannes@sipsolutions.net>
To: Alan Stern <stern@rowland.harvard.edu>, linux-wireless@vger.kernel.org
Cc: hostap@lists.infradead.org
Date: Mon, 26 Aug 2024 21:19:46 +0200
In-Reply-To: <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
	 <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
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

On Mon, 2024-08-26 at 21:14 +0200, Johannes Berg wrote:
> On Mon, 2024-08-26 at 15:06 -0400, Alan Stern wrote:
> >=20
> > Is there any way to debug those INVALID_TE and PREV_AUTH_NOT_VALID erro=
rs?
> >=20
>=20
> The kernel doesn't use those codes for its own deauth, if that were to
> happen, so you'll want to look at the wpa_supplicant log, perhaps
> increasing the logging verbosity for it (I think how to do that probably
> depends on the distro, and I don't know off the top of my head.)
>=20

Then again, while what I said is still true, reading the log more
carefully shows that wpa_s decided to roam and then got into those bad
situations that caused it to deauth. So you'd want to figure out why it
decides to roam there.

Or perhaps roaming would be OK, if it weren't for the failures during
it.

johannes

