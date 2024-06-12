Return-Path: <linux-wireless+bounces-8894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE3A905BB1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 21:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3432B240B0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769D39FCF;
	Wed, 12 Jun 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sA3rInCL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BC381AF
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219295; cv=none; b=kd6skaxZfQZ+VW3FyB5e6gecBEv9s1aOUBYdzGKPRqal9AfayJmlHIHqqZPVfAoouzUYPNytlKzD1iTYwU3U2ICg4gi/fTODPOBwoa95YbSUSrcr6lac8wbWlaGOHHUPiT6AErw3rxbluxsh+wE/pDgTEDlmBBDbDNQhFGq/6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219295; c=relaxed/simple;
	bh=dRIMkVGUGLrh7TdgkcOEeQ6AVWNjblmn8FtzhySnMOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ucPiaxp49WmHci5Dn6zLvwWPKxgAPj06PUqSevK6weI7JBTl2OhUmCudmHGJRDKBLRbHWoEtqPTWwjaV4P1RLhV0qgA1lQBX8WikHAI2rAo0ZsifGRcwaqhKZ4lVjFOe8GOtcizKIxFDLz6O0yaGrj3N7mJuE4yX/qpgdY7k5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sA3rInCL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dRIMkVGUGLrh7TdgkcOEeQ6AVWNjblmn8FtzhySnMOM=;
	t=1718219293; x=1719428893; b=sA3rInCLK889DQ9+NNL9TpjF1dDn1ohtT7OnFil3mTEKHoB
	TFwqdKS0a5Zae0uoIkLEaoY45JWOJUy1wAcjHoNGimHMVyG1kXbmOLquZVBNaXMQ1PNepPPIIKeh5
	0rmJUMImbCR0qrR2uXvNSR3UXsQwa5Z8Bg/mLq1O/sEGLFqVDM4quUQocjxn+0jnARi8tjWGcmYLt
	fWW6Tg+oqystaTNkflUeFdlcamFZkTmBLsnP1mpU43N+TVgPdkBBUcjyEuzu1aCzDGQJO3wkodcXQ
	NOxO1yxhjUoOHgEqYEY0WYSdyqgsS6OqHMtmu7l0RTBdRlVoYOgI5HOvphcRdkKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHTKM-0000000AbLn-0wLP;
	Wed, 12 Jun 2024 21:08:10 +0200
Message-ID: <a7a5655f6a62c5795fdfa02e528cc1d93fb6949c.camel@sipsolutions.net>
Subject: Re: WPA3 support for mac80211 drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Larry Finger
	 <Larry.Finger@lwfinger.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Wed, 12 Jun 2024 21:08:09 +0200
In-Reply-To: <a648b5b187e2d01cd1dc47b6737c95ddc25259ae.camel@sipsolutions.net>
References: <9b10768c-9fe7-40d9-a0b9-27d11a5e0e48@broadcom.com>
	 <a648b5b187e2d01cd1dc47b6737c95ddc25259ae.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-12 at 20:56 +0200, Johannes Berg wrote:
> On Wed, 2024-06-12 at 20:51 +0200, Arend van Spriel wrote:
> > Hi Johannes, Larry,
> >=20
> > I got a query from a brcmsmac user about support for WPA3. I had no ide=
a=20
> > what would be needed and actually assumed/hoped mac80211 would take car=
e=20
> > of it. My first attempt was looking in patchwork for other mac80211=20
> > drivers adding WPA3 and found this one interesting enough:
> >=20
> > https://patchwork.kernel.org/project/linux-wireless/patch/2020052615590=
9.5807-2-Larry.Finger@lwfinger.net/
> >=20
> > It only sets flag IEEE80211_HW_MFP_CAPABLE in hw->flags. So I suggested=
=20
> > to do the same in brcmsmac. Unfortunately no success so can you think o=
f=20
> > anything else that would be required from brcmsmac.
>=20
> You need the correct ciphers too (at least BIP, possibly GMAC)

No wait, you said brcmsmac, and it doesn't even have HW crypto?!

Then it seems like it should just work, does wpa_s have errors?

johannes

