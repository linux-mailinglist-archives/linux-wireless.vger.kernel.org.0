Return-Path: <linux-wireless+bounces-3277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52884C73A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 10:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EFBDB241E5
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 09:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5352562E;
	Wed,  7 Feb 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K6zhLUvr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6BC25622
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297777; cv=none; b=U7D6MsJvqVEzgA7OdqTqEc8Ok17wrKDPVyH8RHVFgKKvOSGME24gsFC+huooLl6hy3KziItsymNpF5VvrOKLKAfGxQ0yzoFAD3StPR6V5Y3+D4L30lJAE1qBKmonvNoYjbVySj/fduhRNySdkPxsrZxgIGKNBkQXevJpAwc5c30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297777; c=relaxed/simple;
	bh=vFcTWhGIh+fBs9c5Dk/S/smjHpUrl+Mx+Fv/zVJJBt0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFByLLJIekq6m3nY/29PiNUgUxqYKI9GZ5ctF6wpbfRReHYW9OiKGeCllrW6q4jHgToxtTqFxH0pG8TfJCr9NDV3AzxsSN0dS2yvuD90S2upvUuAASfOTYYfGZslHdbSgYmFB8bXtkD9fmDVM2tCFxT21Y8/aTLdqU6yN/OC8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K6zhLUvr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vFcTWhGIh+fBs9c5Dk/S/smjHpUrl+Mx+Fv/zVJJBt0=;
	t=1707297775; x=1708507375; b=K6zhLUvrZtoeiOxsN6nN251yFNX8ePrAJP0C5XOG5mdq17Z
	NSa5JHcWyyYkcMVrNJkm/0toZYIuEQeJe16xWDLKOIQzl7wtXj2VRHvhrf1ndMxml0NeGv1uvTJhg
	t26EB6b4vZxsVw+fnsccb8Tn8GGguTKvl4zwerrERvFcUT4JRRqr20vjSe1qmiEQ+4nNjT3zBy7N0
	ZYd/aAq1t6ALyzQKGBqowjuzQZY0qDc6xvHwdN3DdU3q23fd4iHSEoKtslnoLPh+g4Xd+wxuAghcF
	1p/mwnXoqzKF2XMVTnhrJBPk3T+ufoeCBchYl9irRbH3bKAsDiAh4D8CkNSgOfZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rXe8q-0000000Fptg-26K6;
	Wed, 07 Feb 2024 10:22:52 +0100
Message-ID: <ad425d92a0e3e8c7952d9528f23ed2eb7f34a1e1.camel@sipsolutions.net>
Subject: Re: wireless-regdb key change broke crda tests after 37dcea0e6e5
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: Sergei Trofimovich <slyich@gmail.com>, linux-wireless@vger.kernel.org, 
 wireless-regdb@lists.infradead.org, Chen-Yu Tsai <wens@kernel.org>, Seth
 Forshee <sforshee@kernel.org>
Date: Wed, 07 Feb 2024 10:22:51 +0100
In-Reply-To: <87v870hbsg.fsf@kernel.org>
References: <ZcIXGjzrZrXPCBcp@nz.home>
	 <455bafff0d609eb182ba30a5fbf319888e0e961d.camel@sipsolutions.net>
	 <20240206222757.238a24f8@nz.home>
	 <240506b19c6671cfce2587f4c1152359066146c7.camel@sipsolutions.net>
	 <87v870hbsg.fsf@kernel.org>
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

On Wed, 2024-02-07 at 11:19 +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > On Tue, 2024-02-06 at 22:27 +0000, Sergei Trofimovich wrote:
> > >=20
> > > Great point! `nixpkgs` uses `crda` only as a `hostapd` depend and
> > > looking at modern `hostapd` it does not use it at all. I'll spend som=
e
> > > time removing it downstream. Thank you!
> >=20
> > Note that hostapd never directly depended on crda, it just needs/wants
> > it to have the correct regulatory information in the kernel (crda puts
> > it there) after switching the country (hostapd can do that if possible)
> > and then hostapd retrieves the information.
> >=20
> > But in any case, the whole step with crda is no longer needed if you
> > have the regulatory file (and possibly signature) in place, the firmwar=
e
> > will load them as firmware files.
>=20
> I assume you mean: the kernel will load them as firmware files.
>=20
Haha, indeed, sorry.

johannes

