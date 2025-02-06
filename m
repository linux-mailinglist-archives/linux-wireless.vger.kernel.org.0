Return-Path: <linux-wireless+bounces-18592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1544FA2A51B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6023A3B15
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A37225A25;
	Thu,  6 Feb 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="X0UJRU2P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67E1FDE08;
	Thu,  6 Feb 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835450; cv=none; b=V2AmiO2h1yQ9/UfM0lo7+uJjr3SWSxhZiA4knc2yF4quTEccjydXw99ERl8qON6E6hqWkepxe3N5qAGuMieXknSGEntEM4CuDhT9ApEXWHbQ/0Cb364makuCXsPLp8db8XlIS0XZsRYkTWoj1PJ75JDsuy1EH8g7DVfRFbIb6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835450; c=relaxed/simple;
	bh=itpKQpCOiq01Bdaito4FooOWsxu62KH60EMfJ0aSCaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tbb/SbUcIzJnIoPXPVkt+BJCTY8yHfMFqfT4ihMcDVXBmCnysRV8s14Kj/p3SVJV0CmamipDGU3J93ro9VRuKXVgeHN+yAOyP+6zA9DnviaO6NlPimo8tZobi4DWrRnXs3/8FwijzpfbjOjcPNcIbSscdekOs0q17xaLjzjWmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=X0UJRU2P; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ziKVTMMA/mlYZVJuZda3dTpHoy6EjxMZx7k7VgkUGGc=;
	t=1738835448; x=1740045048; b=X0UJRU2P5ks7EWOL5sQBl5twzbihPL3A+F+Z1tA8cdHeTi7
	lvvOmeFHVoUHEnCRSsAWYdOZ0tDtKd2KAueWWoUurWhdUOPUiuj7Og5pyaqKkvq7H+rpc4MubFWjD
	vfbtim9R2HVs9XJWJlDOHYO2MdpqKmldDwtO4cwBLoeypIBslHYQEy62zUuV8UJIFiADlDEZMV3pu
	FsG+eXm1rhHMH3BOf3H6+t8XHNd/8SxodeM9fY5k4Q01dB7BZIMhRyUooZ5kasOKxyOuCrecnfQLG
	UXnpNOSFF3oweMo0hIa+/gFI2YFv45mvXzEZrvci3ed3wKmZSXhhCUO/iW+ot8iQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfyWr-00000004y1Y-1HxM;
	Thu, 06 Feb 2025 10:50:37 +0100
Message-ID: <a2a26c7eaf20bb972289a804ecfe0e532f0f85ae.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] net, treewide: define and use MAC_ADDR_STR_LEN
From: Johannes Berg <johannes@sipsolutions.net>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Uday Shankar
	 <ushankar@purestorage.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=	 <rafal@milecki.pl>, Simon Horman
 <horms@kernel.org>, Andrew Morton	 <akpm@linux-foundation.org>, Jonathan
 Corbet <corbet@lwn.net>, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-wireless@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Thu, 06 Feb 2025 10:50:36 +0100
In-Reply-To: <Z6SEeO0QFx9Y52LJ@mev-dev.igk.intel.com>
References: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
	 <20250205-netconsole-v3-1-132a31f17199@purestorage.com>
	 <Z6SEeO0QFx9Y52LJ@mev-dev.igk.intel.com>
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

On Thu, 2025-02-06 at 10:44 +0100, Michal Swiatkowski wrote:
>=20
> >  net/mac80211/debugfs_sta.c         | 5 +++--
>=20
> What about ieee80211_sta_debugfs_add()? (net/mac80211/debugfs_sta.c)

What about it? It's modified accordingly, just needs a bit more +/-1
now.

For that:
Acked-by: Johannes Berg <johannes@sipsolutions.net>

Thanks for the rename, per the robot report that just came in it looks
like that also saved you from some hassle in drivers that have their own
MAC_ADDR_LEN for some reason :)

johannes

