Return-Path: <linux-wireless+bounces-3533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14F88530B3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8EEB23473
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D863D99E;
	Tue, 13 Feb 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rSqKDuoH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CA482C5
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828123; cv=none; b=cJMAywRepL+4/d9W8PNj3TxJJWKFKuw22SJNsVSzJzvsrn6/hM672WOqLo/tSZeRAhJTJPnzYZUx27o7AAHr650zrtUqeJdZeHe72YCyZcqJgU2t8uNt18FS6XpG4qNN3/R8VNkFMeFYJnlEFcYrX4qs8dfFgbI5//55Cs2CpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828123; c=relaxed/simple;
	bh=ZdeeZxLJsoAUVQzjz0w5zPbeK+afXCDMCdLewEQJGIo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7uUIgbjXDF8UzKEKY8gqaDNePjQSP5Cv5J3Oy3aVicwr+An4BcDSdLeW760z1FK3Osz8QeCgCrAr9nD9WJHn3xfaaSnESG0Pm74QAcnAr0Voq8Zajmd6BrM/oeJVoR2uIJvqxJjHjBz4PyFP09jM7edUWNzySFAvAO83jol3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rSqKDuoH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZdeeZxLJsoAUVQzjz0w5zPbeK+afXCDMCdLewEQJGIo=;
	t=1707828122; x=1709037722; b=rSqKDuoHf+Qebf9hkTSW1WGzVFubEVLp6sI3qiyPArMt5zn
	y6fpU5DMTDkFbX96z4EG3YEeoqyu6y6lGrmU9XtznjR7vnoxyDvzsMOl8P+Dlk+jcenxQmzRGlkXP
	oQRyKtrYKByCqLtHMTH8cd5vYbNgfyi1AEEELxbNy0RykWAzumxf0JXnQelDVwp0snPCm8YFNiJcD
	WPCplxx0/NB9muoSDqbR37DF+XBTfHN3t748GGRWPUylTXPw1HXzhB8IwfNbtYdYuMHZ4OaDY+9Lb
	U67P+5Eep0I3i8NLBGHkIqvHuovVh7C94Qaz/eJa4McpknckF+5MABsYNepsF/xA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZs6p-00000007gqT-0RZ7;
	Tue, 13 Feb 2024 13:41:59 +0100
Message-ID: <e50e2336dd2717e7271e7e6f341437637192f717.camel@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Date: Tue, 13 Feb 2024 13:41:58 +0100
In-Reply-To: <a17862ae423422b636c76f116e712e7ebed51c09.camel@realtek.com>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
	 <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
	 <f489a916f416cb37b527868c4be0c59547bdeb4d.camel@realtek.com>
	 <94bd67a6f261d945917067334b633c78be665c6b.camel@sipsolutions.net>
	 <a17862ae423422b636c76f116e712e7ebed51c09.camel@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> > The other thing here is that I'm not entirely sure how the driver works=
,
> > chances are that this was previously a bug, and now is still a bug,
> > unless the driver doesn't really support channel contexts, or any form
> > of concurrency.
>=20
> This function is to initialize a station instance in firmware while
> associating, and the field of firmware command is to tell MAC hardware
> the sub-channels it can use to transmit, which should rely on=20
> bitmap of puncturing. Initially, we just wanted the field value to
> be ~0 (0xFFFF) to prevent TX stuck, but not fully implemented puncturing
> feature.
>=20
> I think this is the reason you are confused.

Not sure that explanations helps ;-)

If you have this per station how do you handle CCA? Which was kind of
the reason I moved it all back to the chandef? Not that this didn't make
the code simpler (in mac80211) either as a nice side effect :-)

> Thanks for this hint. I will check my colleagues about the detail of=20
> puncturing behavior next week, because people are offline for the lunar
> new year.=C2=A0

Right.

> I will also check people about the beacon CSA mentioned in
> another discussion thread.

Thanks!

> > Though it _looks_ like you only support one channel context there, so
> > maybe also only one vif, and it doesn't matter? I'd probably still move
> > it over to the chan.c code though, it really does belong there more as
> > discussed in the commit message of this change.
> >=20
> > But I didn't want to make those more semantic changes because I don't
> > know what logic your device applies here.
>=20
> We are going to support MCC and MLO, so we will/must consider more than
> one channel context. Currently, rtw89 just consider 'deflink' not actuall=
y
> 'links' that is the next main work we are doing.=20

For MLO you have just one vif still, so it doesn't matter.

Looks like MCC is something with multi-vif (looking at your other
patchset) so there that makes sense. Not that I know what "MCC" means :)

> > And sorry about the locking bug! Not sure how that happened :(
> >=20
>=20
> I will send a patch to fix locking ahead.=20
>=20

Great, thanks a lot!

johannes

