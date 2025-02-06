Return-Path: <linux-wireless+bounces-18594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D48A2A5D2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 11:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206DE1888800
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498A22686F;
	Thu,  6 Feb 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PacvTEnv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3069F215F52;
	Thu,  6 Feb 2025 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738837750; cv=none; b=AS87eQ+va9wlCsT3X/MT3b7yo3wLpnRGyyzkQZ/RkK0RsBP1WYFLYwexCRLLcRwsffCab1Q4+bgLJ/rHpyDPcUmLkQG3KtWlvWs3BDAXnfD7Uv0OygEl/GDRV1q/V+ggk+tHGGy0sHWlGJVFJFPxfNsMQirqLm6dq+TeYF7GflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738837750; c=relaxed/simple;
	bh=S7P6lVDUiM8BkwNZyEPAIeV/qXqEvPpGQZH6A/FLfSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JMlz6A7GzVgCOS8FTmIp7t1VlSUuWf/JPDR8x38XkE0jhJbanLqlWdo4M2kx/IrOVcD9w+/MAc5KfUcHRXo7scT3PnC+n2ttmuYaXustQOzABJEEbopnRZp2+PYn6180umscQ5mj7H5jMGZ0WC38vXGz0TiYkxngUv60DVJusVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PacvTEnv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8lEz4PZA3e6wBA7eHEmBgEXubre6UC4Pm/7j8argqZw=;
	t=1738837749; x=1740047349; b=PacvTEnvoOY8gAlKBWsCqZ/Idw0yYEsO7z5e0clCvDBmgRa
	NfZLCn9Mh3gJWDmjvXiOLhenrS/BilGBFtdEsrhLvB/jne5aaG+2wsZZSq4DbzltUBdXSvjwygw2T
	RghTCwg8HcyEIl/YzixLjgtlb5Amn9n6meghOu2qBSFoKsgt5WSs4QIFi573hPWqZBN27Sg4NwR4M
	eoionr/5Od39ND3rFlNvX3fbAJmIg1YyuX+VJgFGRqwyBlp7xS1QS7B7s5zGgMuAA2cjc5kLD8esy
	Aq7uhAr6glJaswwx/bKDpvV8H0kfUd/OTQYw4hTgEeR6ALo0OEuRheqGPAk8ydUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfz7z-00000004zMd-04fP;
	Thu, 06 Feb 2025 11:28:59 +0100
Message-ID: <da5a789176b6a4c3e7c6d5f40dd75e50c9fbae39.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] net, treewide: define and use MAC_ADDR_STR_LEN
From: Johannes Berg <johannes@sipsolutions.net>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Uday Shankar <ushankar@purestorage.com>, Breno Leitao
 <leitao@debian.org>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=	 <rafal@milecki.pl>, Simon Horman
 <horms@kernel.org>, Andrew Morton	 <akpm@linux-foundation.org>, Jonathan
 Corbet <corbet@lwn.net>, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-wireless@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Thu, 06 Feb 2025 11:28:57 +0100
In-Reply-To: <Z6SNxrEteMx0/0sb@mev-dev.igk.intel.com>
References: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
	 <20250205-netconsole-v3-1-132a31f17199@purestorage.com>
	 <Z6SEeO0QFx9Y52LJ@mev-dev.igk.intel.com>
	 <a2a26c7eaf20bb972289a804ecfe0e532f0f85ae.camel@sipsolutions.net>
	 <Z6SNxrEteMx0/0sb@mev-dev.igk.intel.com>
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

On Thu, 2025-02-06 at 11:24 +0100, Michal Swiatkowski wrote:
> On Thu, Feb 06, 2025 at 10:50:36AM +0100, Johannes Berg wrote:
> > On Thu, 2025-02-06 at 10:44 +0100, Michal Swiatkowski wrote:
> > >=20
> > > >  net/mac80211/debugfs_sta.c         | 5 +++--
> > >=20
> > > What about ieee80211_sta_debugfs_add()? (net/mac80211/debugfs_sta.c)
> >=20
> > What about it? It's modified accordingly, just needs a bit more +/-1
> > now.
>=20
> I meant that it can be done in this patch too.=20

Oh, oops, right. I thought it _was_ done here, because I didn't pay
enough attention to the actual change. Either way is fine to me though.

johannes

