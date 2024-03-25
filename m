Return-Path: <linux-wireless+bounces-5226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF9888AD13
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0E31C28D55
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4028737145;
	Mon, 25 Mar 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="M9PQwdDY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ABD50272
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387837; cv=none; b=HlW637Dfm//NPcI0wabDpQm2a8Plhettjma5QK4U0Hl2B4sLUwMur582/C9zbHj/of0XeqVhLCMjArwJs/12tTv3eCdV+JXZY0OEhXAFuZLAv+x1RBBWn4OMViONcz3i+B9VI2yfYFAnEscBDvtcbIG80cxZ9mebfgF5LEW4Nfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387837; c=relaxed/simple;
	bh=XN6jSiwUYPrnwlVKoMqbblGFuCTk19zWzlzhzTpPRj0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JI9CT37lCS8zPbMpwpbUrYHMuW6ZozRiA6/X8TIS6dlELcXcthXkpPKWXq68KDc4gRQl1cv5srEgJiJMlZqRmAGaWlEiLsiqAKd7eCmIziTMFv2SVvyikJFbZB/RLpRJjknmKLcF5NAOACm0iGAEpmChR681Vj2Iex+ADaB/MyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=M9PQwdDY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nnKY1T08A15M6+1Z34Dh4uInNkexLpDJIf7Y4hljiKU=;
	t=1711387835; x=1712597435; b=M9PQwdDYn0M447Upu3Frfy0DREuvBtfOPwXD6HeNY8ZC7SI
	U5u2QX0h5C0dg3Fyqnzd6NM3llRbmMEd0tNB+QzBk6hHq5HdprOYqDoMNJjLgmEHp9cp8bz3pDMAf
	+tHO4DKy0H+ESxT+DyiPFDUOqvaP9Wyv6ir9EDEdHn0Hb21n6YV6sNoobawyHBqfW0WJIPdaNL5lM
	tkcCD3PFGAnTV9GjbJWE/snEp3ZjXdRzQmaZUoNSG5/Bl9uR/bsROYVh4Kho5GDhVqhIGTOTAty2Q
	WMxUs4TBjWvL+mLBafI6aHhsJb18yiajvns7pZYqoH9zXijZztwcSRT3jp/EcSTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1roo9Z-0000000DzFW-0yRT;
	Mon, 25 Mar 2024 18:30:33 +0100
Message-ID: <449f6afbc20c57f704dbeabc3a8eac8fec676405.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Ensure links are cleaned up when driver
 fails.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Mon, 25 Mar 2024 18:30:32 +0100
In-Reply-To: <5fe480c4-fa39-1d29-a5e9-ba2447b08dd2@candelatech.com>
References: <20231111001023.1335122-1-greearb@candelatech.com>
	 <5fe480c4-fa39-1d29-a5e9-ba2447b08dd2@candelatech.com>
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

On Mon, 2024-03-25 at 09:10 -0700, Ben Greear wrote:
> On 11/10/23 16:10, greearb@candelatech.com wrote:
> > From: Ben Greear <greearb@candelatech.com>
> >=20
> > On cleanup paths, links need to be deleted even if the driver fails
> > to do so.  Add a flag to cause driver errors to be ignored in
> > appropriate cases.
> >=20
> > This appears to fix some kernel warnings and crashes.
>=20
> Hello Johannes,
>=20
> Any interest in this patch?

Well, you threw a bunch of unrelated stuff into it, and didn't even
really explain why it's needed ... so not really?

johannes

