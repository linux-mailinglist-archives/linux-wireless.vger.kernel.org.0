Return-Path: <linux-wireless+bounces-8893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D7905B93
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 20:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EEA281995
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 18:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6765FB8A;
	Wed, 12 Jun 2024 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kljoqS+M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4664F8BB
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218610; cv=none; b=PM/AXTZpSAgysDkF5+HQpReAff2+VKYYNHzy/EEXFMw79nYkHu20Gv9jDq2EVTdB5mpr7dJS59YXLAxD1ypP1L7UmxYjismEk2yYl+Nm9V6HoHYlD6bpByRVyOdcsj+/aGrMV7bmCir3qSCoQ8bPGYzVNiD5aOm8A+mX6XWIogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218610; c=relaxed/simple;
	bh=fXGhLpktRPNNpqRjKKvFK8vMQ7ar2yOLBMl+eC8xjUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1V5JdPQUJaHZw9Wv+xKAPCz5cQJ5qBWF2BocHIi7FqD85ZGv5GOp9dvik6RdWrwoze/cCxaNPZop3hnTOxfnRsiCqJrg+RiWkm1SLFhAcmDK8Yrg3rCfm+W+gqkB3tYWNRQruxJwiVT3HWu50otShQnTwD9IvX5+3rZSoyWhSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kljoqS+M; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fXGhLpktRPNNpqRjKKvFK8vMQ7ar2yOLBMl+eC8xjUY=;
	t=1718218608; x=1719428208; b=kljoqS+MogoG0fdXsrXQpnmPI+2I1Db/kzuxY/S5ulqbVGW
	VUlMYzeCisqABptlP8lP7PGvqFA/+HAOAGNGTSkGlrOuKnCZxuh9KrC3wGREHeWLmuX+LXQVA2FnW
	sRXOc1hd1QKVhPYAlren1HJ7Ch3WJI72Z0eWnK8ois3WeRGhbqHe8kXqBjayA/d39Bc9X3WYfNFIQ
	5WSp8JyR0HNa6rcqRNFNpUlXP7r+A3YQv/DxuHYa48k+y036DsSe38rIoZ/AzyQwULcQ9Z3qMU6NF
	FjnELWKi9xcP7X/Q723lGiAEnMWZE0sZ9XH9Jkg1HSJcvkEoF2GuMpFsad1Cd/VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHT9I-0000000Aao3-3kyK;
	Wed, 12 Jun 2024 20:56:45 +0200
Message-ID: <a648b5b187e2d01cd1dc47b6737c95ddc25259ae.camel@sipsolutions.net>
Subject: Re: WPA3 support for mac80211 drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Larry Finger
	 <Larry.Finger@lwfinger.net>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Wed, 12 Jun 2024 20:56:44 +0200
In-Reply-To: <9b10768c-9fe7-40d9-a0b9-27d11a5e0e48@broadcom.com>
References: <9b10768c-9fe7-40d9-a0b9-27d11a5e0e48@broadcom.com>
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

On Wed, 2024-06-12 at 20:51 +0200, Arend van Spriel wrote:
> Hi Johannes, Larry,
>=20
> I got a query from a brcmsmac user about support for WPA3. I had no idea=
=20
> what would be needed and actually assumed/hoped mac80211 would take care=
=20
> of it. My first attempt was looking in patchwork for other mac80211=20
> drivers adding WPA3 and found this one interesting enough:
>=20
> https://patchwork.kernel.org/project/linux-wireless/patch/20200526155909.=
5807-2-Larry.Finger@lwfinger.net/
>=20
> It only sets flag IEEE80211_HW_MFP_CAPABLE in hw->flags. So I suggested=
=20
> to do the same in brcmsmac. Unfortunately no success so can you think of=
=20
> anything else that would be required from brcmsmac.

You need the correct ciphers too (at least BIP, possibly GMAC)

johannes

