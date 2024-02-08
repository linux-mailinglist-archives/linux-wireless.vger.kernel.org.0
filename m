Return-Path: <linux-wireless+bounces-3339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F18BE84E2F0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 15:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C7CB2342C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54D78696;
	Thu,  8 Feb 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NHolznpL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B50768E9
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401728; cv=none; b=kOsszSvVUwzKTDuxgLM3dq+iwd2HzKRrO6eUAknxvEc+PISsdG9DaMzVLUSMnZP7BcbezYX+C9fpY91+s31Y+wnbH81I3h41evV5T8yM074QTa/8mDwb3r1Qx+mkK/ui3pBDZd350d9fJWZ5ySrhUdvm7ICJLuAr2xlmOTngcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401728; c=relaxed/simple;
	bh=9AIBb3iZHa1191UrOwMgj9ffYgrh7mCXUXRtu6cVm7Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VijrwYwUyUz2Qf6z8TXP4I4xp2YInDgMT3b20rIaa6NP8JB2GdmhPry9V+6Q0WCHLtdiSCYONo3HiM5l9PSRJDwB3efFy5GD+8B2Miw+2xPaGIM29eyFKnxohxDHr6ljsLkZSrdgF90qMhqwrv79B2oaRbXZZkytj4gPZHGGAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NHolznpL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5wjaga5xoExEujSbT0Acktc+XrWkfwDH2yfFbAKwyB0=;
	t=1707401727; x=1708611327; b=NHolznpL/W8UqOdoevXmkXtoP3PdpnqoPVLc79fpnfPJ7fh
	x0z5zbA/80BlPpaxKbo2SgMQN4Wb6LyYjOCNzHXNcS3fFpEdsgfmSi/AWqJDPXhM22fP9OaSqUsbj
	BlTgOswMHCbZkGYhF4b/6LKBvhuvE0lkyYHOskgUPmJKgD8/rserdE2wpF25CILGPChnJstz09HXp
	51m40j4TZeleAYHytB7ynE5ntOmKdLwCPEzIe9IBR5E48zu6EEZ1SfFFjPgHnRCMjCla8q83qjdqD
	aMjKIZGY+j45Xk1ZJQzTSkuYgIPSsujStMTu8XQJmZJpvP4qSAYR3aPMomSPaT7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rY5BT-0000000HW84-2LXh;
	Thu, 08 Feb 2024 15:15:23 +0100
Message-ID: <4e3b72023f30d8765154805816e6eb1f4e73593c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: brcmfmac: do not cast hidden SSID attribute value
 to boolean
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Alexey Berezhok
	 <a@bayrepo.ru>, Arend van Spriel <aspriel@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	lvc-project@linuxtesting.org
Date: Thu, 08 Feb 2024 15:15:22 +0100
In-Reply-To: <1bc49c2a-1f62-4801-90c3-048b27f6475c@broadcom.com>
References: <20240208085121.2430-1-a@bayrepo.ru>
	 <1bc49c2a-1f62-4801-90c3-048b27f6475c@broadcom.com>
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

On Thu, 2024-02-08 at 15:06 +0100, Arend van Spriel wrote:
>=20
> settings->hidden_ssid has already been used above in following call:
>=20
> 		err =3D brcmf_fil_iovar_int_set(ifp, "closednet",
> 					      settings->hidden_ssid);
>=20
> So we pass the value as is to firmware using the same assumption, ie.=20
> NL80211_HIDDEN_SSID_NOT_IN_USE. Is this not ABI thus very unlikely to=20
> change?

The ABI won't change, that'd break all the users of nl80211 that use
this :-)

> @Johannes:
> Actually not quite understanding the reason for having this setting in=
=20
> nl80211. hidden_ssid means SSID element length is zero, right?
>=20

Well, there at least _were_ APs doing the correct SSID length but
setting all octets to zero ... Not sure that's still a thing though.

johannes

