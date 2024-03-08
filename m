Return-Path: <linux-wireless+bounces-4487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEC187642E
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 13:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CDA285798
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6E92110E;
	Fri,  8 Mar 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GpNPf/Di"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD356464
	for <linux-wireless@vger.kernel.org>; Fri,  8 Mar 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900410; cv=none; b=PwkaW8QiWzj/9kTVUSFESN/gwMWGBy641s7bxwnvpWBGYNGlcA5OoC5P8Pzywyuk1CjOEB4JmfJ5YN6u1xHwE7lK6zxfGl6FTaewtDOyPFmpeJpHzg3Go0h0p0PvsBmxoioR0BgyYSf4WaPfGgeIqzBjcQgjAAuJ/DBR1ad0LWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900410; c=relaxed/simple;
	bh=cYFjiRix+ABBSuAwdsHr1pGc9HQUSZQpyc6DPOTWQD0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akzvgLQnCq2XbXZ13mL4uydTQHyTAj0s+E+ODYIgfN+59lEuVaq62iS70rhN8oRh5W/EPBg/Oink/rtqVPe/l6Pqjv8A5JWuRnPfROkibj2CycbOZKXtUQn1t6Wb+HfSzJ37mz2aWOGJys6m43Ye6ZYsNw44/NEadpJUFd7aclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GpNPf/Di; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cYFjiRix+ABBSuAwdsHr1pGc9HQUSZQpyc6DPOTWQD0=;
	t=1709900404; x=1711110004; b=GpNPf/DiOEvamwSbJc2fPDIZOedNo5vJrRnCKL6lAb5xL1X
	ljrtubhdx2MiO4yULgiWn3esYlKHMFXWrlTtCdd0Oii20faZ8AdTLEBlzlvQes7hdehHsVLrzRsQG
	WL6dxqF1fF7s0BOVzBAsCdaRxf7xI/xJXQ/YPOt0M/fMy7ICLbPVll5X8f2FBBYqtcbFRB3uII+ob
	hrLTPdy3a8xtcoySD071Ryy7UWRQwUeBdCpkVfGt7turR4SioRFe27sdfj6J5+G9FXpXu31I8U52P
	Kbo2Sj8Sw+ZJwBc9dK/LW9mQBogEzCRWiAXMqUAQIgOMmqMe2W/iEUEtAQ6RpP+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1riZCd-00000007ZTx-2u1E;
	Fri, 08 Mar 2024 13:19:55 +0100
Message-ID: <29f7aa2c233277ab4bb56bcff8e228036ee96a2e.camel@sipsolutions.net>
Subject: Re: regression: [PATCH] wifi: mac80211: set station RX-NSS on
 reconfig
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Tobler <andreas.tobler@onway.ch>, linux-wireless@vger.kernel.org
Date: Fri, 08 Mar 2024 13:19:54 +0100
In-Reply-To: <014a25e4-5609-4e3e-a593-8a2bf1bd5568@onway.ch>
References: <014a25e4-5609-4e3e-a593-8a2bf1bd5568@onway.ch>
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

On Fri, 2024-03-08 at 12:58 +0100, Andreas Tobler wrote:
> Hello Johannes, all.
>=20
> with this commit[0] we encounter a performance regression in one of our=
=20
> AP/STA tests. The performance drop is about 100Mbps+
>=20
> Our setup is a hostap (2.10) configured AP on 802.11ac, channel 46.=20
> (40MHz). The client connects via wpa (2.10) and then we produce traffic.=
=20
> Before this commit, the throughput was around 250 Mbps, with this commit=
=20
> the performance is now down to 135 Mbps.
>=20
> The wifi cards we use are WLE600VX from compex, a ath10k based one. The=
=20
> kernel we're on is 6.1.80. We've seen it on 6.6 too but didn't investigat=
e.
>=20
> Now, the ieee80211_sta_set_rx_nss() function has two FIXME comments. One=
=20
> in where it handles the ht capability and one in the vht part. Both=20
> FIXME's are: 'consider rx_highest?'
>=20

I think you'll find that all that is unrelated, and this fixes it:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/=
commit/?id=3Da8bca3e9371dc5e276af4168be099b2a05554c2a

johannes

