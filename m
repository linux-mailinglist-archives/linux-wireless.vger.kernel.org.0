Return-Path: <linux-wireless+bounces-14971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5183B9BE38A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 11:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015F81F21C92
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC76E1DD0E1;
	Wed,  6 Nov 2024 10:06:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1E1DD0C9
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887561; cv=none; b=txPyvBXG74PW+agp4K8P0/e3rUlHjKnXrsqR+5hIl0iGUGtWtBrpzumCGfHtgI1Vy318VlpgOnRR8uxxPGVT46ztIHLsyAcBkeluZmt27X9oKmDK8IOtPobLwKzEV0p8aBS39ryvKgy4dE1wN6WQP6nim3ft4PQkhwbt3DobGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887561; c=relaxed/simple;
	bh=IxdoOAb5WQ9naKf5vugHcySsg869Zl/VjRdb63NSN7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJnzJJETVFPfH3BmuaYOyXH04+PoF6PizQVPKkH2AUb4uDLPlI3400+xJHgj+6kOrsqQT1YlI+lqnvqNwiifoLp7B7TOKmECVQZ1uWTT19frLw+Ja6FKoXvnpUnCMLo0c7auZsOpftKu86xffZAxQ4qN6AyKH87rXP5dzuYIoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from ripper.localnet (p200300c5970b92e00000000000000c00.dip0.t-ipconnect.de [IPv6:2003:c5:970b:92e0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 7D196FA132;
	Wed,  6 Nov 2024 11:05:57 +0100 (CET)
From: Sven Eckelmann <se@simonwunderlich.de>
To: ih@simonwunderlich.de, Issam Hamdi <ih@simonwunderlich.de>,
 sw@simonwunderlich.de
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 mathias.kretschmer@fit.fraunhofer.de
Subject: Re: [PATCH v2 2/2] wifi: ath9k: Reset chip on potential deaf state
Date: Wed, 06 Nov 2024 11:05:57 +0100
Message-ID: <865447434.0ifERbkFSE@ripper>
In-Reply-To: <20241106090439.3487958-2-ih@simonwunderlich.de>
References:
 <20241104171627.3789199-1-ih@simonwunderlich.de>
 <20241106090439.3487958-1-ih@simonwunderlich.de>
 <20241106090439.3487958-2-ih@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 6 November 2024 10:04:39 CET Issam Hamdi wrote:
[...]
> This patch originally developed by "Simon Wunderlich <simon.wunderlich@open-mesh.com>"
> and "Sven Eckelmann <sven.eckelmann@open-mesh.com>"

Am I the only person which finds this style of adding information about "Co-
authors" weird?

[...]
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Sven Eckelmann <se@simonwunderlich.de>
> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
> ---
> v2: change the "Co-developed-by" to "Signed-off-by", remove the dependency

I think Kalle meant that "Co-developed-by" should be followed by a 
"Signed-off-by" - not that "Co-developed-by" should be removed.

I was not part of the delivery path for this version of the patch. But
current Signed-off-by seem to suggest this.

> on CONFIG_ATH9K_DEBUGFS and add more information in the commit description

And please don't reply to the old thread when sending a new patchset - this 
becomes really unreadable after a while. You can simply use the method which 
b4 uses and just reference the old thread in your mail. Something like:

Changes in v2:
- change the "Co-developed-by" to "Signed-off-by"
- remove the dependency on CONFIG_ATH9K_DEBUGFS
- add more information in the commit description
- Link to v1: https://lore.kernel.org/r/20241104171627.3789199-1-ih@simonwunderlich.de

[...]
> +static bool ath_hw_hang_deaf(struct ath_softc *sc)
> +{
> +#ifdef CONFIG_ATH9K_TX99
> +	return false;
> +#else
> +	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
> +	u32 interrupts, interrupt_per_s;
> +	unsigned int interval;
> +
> +	/* get historic data */
> +	interval = jiffies_to_msecs(jiffies - sc->last_check_time);
> +	if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA)
> +		interrupts = sc->debug.stats.istats.rxlp;
> +	else
> +		interrupts = sc->debug.stats.istats.rxok;

You can't simply access sc->debug.stats.istats. sc->debug is only available 
when building with CONFIG_ATH9K_DEBUGFS. See ath9k.c

struct ath_softc {
[...]
#ifdef CONFIG_ATH9K_DEBUGFS
	struct ath9k_debug debug;
#endif
[...]
}

> +       /* sanity check, should be 4 seconds */
> +       if (interval > 10000 || interval < 1000)

Here you have hardcoded values but the actual interval is hidden behind 
ATH_HANG_WORK_INTERVAL. Two things which now are rather disconnected and might 
cause problems in the future (when somebody fiddles around with 
ATH_HANG_WORK_INTERVAL).

Overall, the proposal from Toke seems to be a lot better integrated in the HW 
check style which was introduced by Felix in the beginning of 2017 [1].

At the same time there was a proposal by Felix [2] - which diverged too much 
from our original patch (and as a result caused too many resets) [3]. I would 
therefore propose to check Toke's version and test handles the problem 
correctly.

Kind regards,
	Sven

[1] https://github.com/openwrt/openwrt/commit/b94177e10fc72f9309eae7459c3570e5c080e960
[2] https://patchwork.kernel.org/project/linux-wireless/patch/20170125163654.66431-3-nbd@nbd.name/
[3] https://lore.kernel.org/all/2081606.z26xgMiW1A@prime/



