Return-Path: <linux-wireless+bounces-23012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D252AB8695
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 14:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501C53A9BD2
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE461298C31;
	Thu, 15 May 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KcOAVZFP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E621FAC54;
	Thu, 15 May 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312855; cv=none; b=RxLX7hsYf3e6kO2f+ptdT2AV8LrRvRl2+i+zdimnevo5+Svz2arxZIvQlSkDR7WEKjQ5JrqfIaC8oxXqeWzbHgUiTqeE3NRlXPCY9kJXUv+no005UR/brLjyQeGpFk88xYf/4pgcYvllGaTCYA/J11zN+Gy6SZTrEiKDus6dMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312855; c=relaxed/simple;
	bh=wz0Mbb6Uh6Xj0sa8P47kdV3BnJ5XRFO/7tkjWrKPQnA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b90XRiT3QHpmTP71qw8AL/raR0SzzNCbFqM2AirZIz1RsIIwubsPq45GphTewf6u+GPh79UFLtd0Jlt7W8vVq2YQ4kcqvQ6tezpybOFHk2A52tmuR/izNsIX/fDRlE+sJ7FMQZwPpdF9NOnwCvTkVJ4s7NKg7jJfT27kAT7L57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KcOAVZFP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wz0Mbb6Uh6Xj0sa8P47kdV3BnJ5XRFO/7tkjWrKPQnA=;
	t=1747312854; x=1748522454; b=KcOAVZFPTTz09uB8n/hs1rUFgXuaVRpiEFjAItbH8iVeLuT
	nddIcVBGtXu8VDnMJQXwh2i2kRZknXzn1O+h/CWarIYo4m1F1c4cW8ZuL0KlYnuvencK3r+AV44Sv
	ih5XIQamoNXt0HZQfm7bX1KSgl0C7BmZjMhQLVz9FHkYObLmXTY/5yGcloA5ZIRNTnCdOapiWE6Q6
	N6cKuL0LRfejTCkTWWhwVaYlFgjzk+C2NuzPBQBRT3Je5ZYAx3Nj/VFTyzSyS2I+99V0t6TUp0JR1
	cD1fpJRsxs3P4HUt1c+wQmglCHxmBp/F9p8ovd9yTUK5LyYHYQXzNgZ6zoSI/V0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFXtL-0000000BG5h-0WPH;
	Thu, 15 May 2025 14:40:51 +0200
Message-ID: <31ff7d1bbc5a66e18dc0b92a9c0e6963ce73167a.camel@sipsolutions.net>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
From: Johannes Berg <johannes@sipsolutions.net>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev,
 Denis Kenzior <denkenz@gmail.com>
Date: Thu, 15 May 2025 14:40:50 +0200
In-Reply-To: <aCXfy0Uqx6wH32DR@archlinux>
References: <aB4hMsBfyawYatoj@archlinux>
	 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
	 <aB5onavenLymR-QJ@archlinux>
	 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
	 <aCMtCCYtNNl4dL5Q@archlinux>
	 <e1b26ee842bc60cfa939874f467a03531871807e.camel@sipsolutions.net>
	 <aCN0Tjwu-yS2mzi_@archlinux>
	 <047456d40bc42248a6ba1b76d630d5d82b857bf1.camel@sipsolutions.net>
	 <aCODE231NMCQ48xu@archlinux>
	 <1a6ee5fb05b32e290fc45e66af4b7dc719f06ed8.camel@sipsolutions.net>
	 <aCXfy0Uqx6wH32DR@archlinux>
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

On Thu, 2025-05-15 at 14:36 +0200, Jan Hendrik Farr wrote:
> On 13 19:45:45, Johannes Berg wrote:
> > On Tue, 2025-05-13 at 19:36 +0200, Jan Hendrik Farr wrote:
> >=20
> > > So this test doesn't proof that it would work with the order the othe=
r way
> > > around. Maybe I should try making iwd sleep while generating the comm=
it.
> >=20
> > I guess you could, right.
>=20
> Just to report back on this:
>=20
> I added a 20ms delay in iwd's generation of the confirm message and
> everything is working as expected with your patch applied.
> Connection is succesful with the following order of frames
> confirmed by external capture:
>=20
> 1. client sends SAE commit
> 2. AP sends SAE commit
> 3. AP sends SAE confirm
> 4. client sends SAE confirm
>=20

Cool, good to know. I still think we shouldn't really do this unpaired
(prepare/complete), but of course almost nothing except iwlwifi cares.
But also iwlwifi shouldn't abort session protection for auth in this
case anyway (or in the unlikely case of WEP shared key auth), unless the
process is suspended/finished.

johannes

