Return-Path: <linux-wireless+bounces-26994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3AB43641
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 10:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5973A1E6A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A42C11EC;
	Thu,  4 Sep 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dFhJNWtC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915152264B1
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975796; cv=none; b=EV+TtpdHbmEOINBkTs+1zYJJItWXF21G009cci+wRgbs5OKI/wAb7Kgmwt2ySJx54ca5uu1LYvSaW2hTVa5HwDNTXqRgjpPUNv/u4jUg54uPjmfPTlh6JiglzIduVTy+aohmb9WgHCshhTifHiIVdERC+ujwvmB1fuL0EsAy7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975796; c=relaxed/simple;
	bh=NwWl8mU0HxQEC8YMBI5HsXBh/o28QhklHXFvPV/UKEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZivGnkGD6IVYzRkSe9ahG2mOXdjNL7C6xgwAc0kEcq6/t8ILKlruR1gb652EG9tYcBIk6StTk+Wu1R9Y/M9xVxMTiIMu0IxKna115xsm/Cbt69Y7gAj16eANsFocYcNGlD+7s1JlHT6W6SFkHW00uCCshU2y7HNbtQFCHCDbHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dFhJNWtC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x1D9BfK0IoC7uOEOFWbMNRE+qBC8AXUexkwEA8RvXic=;
	t=1756975794; x=1758185394; b=dFhJNWtCz9a4ZhlZc87YyAC/UODzJpvOWLHx7fAm2REbsKw
	1x50yhrJUqnRIlut6q47jqG1xsYhyFoaNP3dxNaYGd4SDWF4Ju50X6S2GBcdso1gbLmyIf+fS0QVP
	8RWiMdsAV9x12KwSi6TRIxOU5qb2y3key2eh7dn3GS/7M54RdDnsa5X/0tAgv0P5dEL117i52kpeI
	vqbmXCZoR2sJtM+d4ni0F1xHzOkX6JWjr6BsgZhu+7OEnvCNZ0ShiGLjHdh6gqCCtuvypHXHwqMFU
	ZtCmgfIuhRN/z+tkER29z9ZSnLU7x6YjxvOGWco6++TGSjsHUTsBPNBUhIjhbsKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu5fC-0000000Drgo-3eT8;
	Thu, 04 Sep 2025 10:49:51 +0200
Message-ID: <b8cb48e6c6617a46d12d3ca92f14faded55caf50.camel@sipsolutions.net>
Subject: Re: [DESIGN RFC] Add debugfs support for multi-radio wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 04 Sep 2025 10:49:50 +0200
In-Reply-To: <20250903170042.3830067-1-quic_rdevanat@quicinc.com>
References: <20250903170042.3830067-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-09-03 at 22:30 +0530, Roopni Devanathan wrote:

> [quite a lot :-) ]


> To do this, maintain a dentry structure in wiphy_radio_cfg, a structure=
=20
> containing radio configurations of a wiphy. This struct is maintained to
> denote per-radio configurations of a wiphy.
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 406626ff6cc8..ebf1ab99766b 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -5584,6 +5584,7 @@ struct wiphy_iftype_akm_suites {
>   */
>  struct wiphy_radio_cfg {
>         u32 rts_threshold;
> +       struct dentry *radio_debugfsdir;
>  };

I'd probably just call it "debugfsdir" since it's already in the radio,
but yeah, I guess all that seems reasonable.

> This will create separate directories within phyX directory like:
> # ls /sys/kernel/debug/ieee80211/phy0/radio

ls ... radio*

I think would result in:

> radio0/ radio1/ radio2/

since you didn't add a subdir radio/? And I'd agree with that, doesn't
seem necessary to have a subdir with subdirs, the names won't clash.

Maybe in the debugfs there should be something already in cfg80211 that
identifies the radio, like the frequency range it was registered with.

> Whenever a wiphy configuration parameter is added as an entry to phyX
> directory, check if that applies on a per-radio basis and if it does,
> create its entry in radio directories too. This way radio-specific
> configuration parameters can be maintained along with global wiphy
> configuration parameters. Also, initialize the entries inside radio
> directories with value present in global wiphy configuration, because at
> the time of wiphy registration, all radios in wiphy will have the same'
> parameters configuration.

All that is kind of per parameter etc., so up to the users, I'd think?
But I guess this would indeed come with an additional implementation in
cfg80211 for some parameters.

johannes

