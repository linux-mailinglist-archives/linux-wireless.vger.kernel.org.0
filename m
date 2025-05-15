Return-Path: <linux-wireless+bounces-22988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89708AB7DA2
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 08:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3CE8C009A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 06:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42721DC998;
	Thu, 15 May 2025 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RNI7iPPQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E131F09AD
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289734; cv=none; b=bfTDB9HNQmMWKcXwtfyIqjzbhjyopM9eo8HIwif7KF5Tux8OBOMrzjs+0pAJB5JA35DhuQuzNe8jjzDhI3odO1SyWw4094ro18ZrsP/aqJCj7VV6HnrezlW3L2HrjdIOWygKmFQ0MpOgUgx6RPp7W/rP/dRxd9+qJttzITjH7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289734; c=relaxed/simple;
	bh=smFuyIfQ34+TbFMQjv7/1rTZ6gSmuqhxM0xeEmPq6KM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rLqIkhhniv4w+t4FdI9VEu7NVMAFbKYQw7rMm9QIr7sUD+0gCQfDQfDCZt+c0udPBn+V94adn55XpYEq70xABw5jdkngpE+J/w2k1BSvXJT0D66XzFSFrF1qZh5Wmd0DujsnrcB1uRC1afbrSR4gpOW6vjvMkbtKc49ap2NnJoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RNI7iPPQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=smFuyIfQ34+TbFMQjv7/1rTZ6gSmuqhxM0xeEmPq6KM=;
	t=1747289733; x=1748499333; b=RNI7iPPQtFWbMzBfdxNACRqImnXRKnDyZv783ziRSSn6Boa
	BDVuj6g4Y9RSVaCMXwP2z4FXcHRScxskbQdYWC3E24lU6LGC+XDMY3KnBtw90OgcHeZkYZyxTjzrH
	qwOq6IJsPVllc/UPYZ/suoQGx7nEA6sVptcv+BJOMcbguRAjvQMwgDO4hr2wnU3XXew4B3aIdOxSp
	UPpTJE5D8S1sg29/AFeTUmUNj/oawP92GIZ3cL70MYDq01+dYeQ1H/dKHuwSJsCiSTX9CD4RqpDZ6
	RKMILxEjdCXYE0+DwKtjajQ5oeiLQLcmCGG/YbTo5a7J7J5NOdTTqwPbvP/sAY4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFRsP-0000000ASUm-04lt;
	Thu, 15 May 2025 08:15:29 +0200
Message-ID: <4491c53e669382136c4458b53e2055c1d122f391.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v7 05/10] wifi: cfg80211: allocate memory
 for link_station info structure
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 08:15:27 +0200
In-Reply-To: <e8a2d899-134c-4203-b153-6e74f37cf504@quicinc.com>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
	 <20250514164857.227540-6-quic_sarishar@quicinc.com>
	 <25b89deed3bb6871109fa94c3c967a27a35e3d90.camel@sipsolutions.net>
	 <e8a2d899-134c-4203-b153-6e74f37cf504@quicinc.com>
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

On Thu, 2025-05-15 at 10:49 +0530, Sarika Sharma wrote:
> >=20
> > Also, is there any specific reason to want to allocate each link
> > individually? Why not allocate them all together in one bigger
> > allocation? Doesn't matter much though I guess.
> >=20
>=20
> Also, while implementing I think this way looks clean and easy to parse=
=20
> the links using link_id, also while allocating/de-allocating pertid for=
=20
> link level, at least to me.
> So I would keep this like this only?
>=20

OK sure, whatever? I like I said before, we can change these internal
details later too.

johannes

