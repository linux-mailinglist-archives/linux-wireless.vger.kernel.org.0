Return-Path: <linux-wireless+bounces-9078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751E90AF53
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989A628B10A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6AB1A38F2;
	Mon, 17 Jun 2024 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i5qQH4pU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8831A38C7;
	Mon, 17 Jun 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630482; cv=none; b=MqHa1+LiUssARmedy5SeY7zNGNeGd4OoI3VQS9cRrHJAFPiXHFfbH4tOtMN4OUgzSLrGvFXNzBIAb6R+Vpy5zLsNE5biui8ymuR6+4GnH2ErUR2Hmg5cNdb4EblO23WPoeiquRq2GXk/hj2HhXB/VSt1TOG2hyiRCxy3cRx2SKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630482; c=relaxed/simple;
	bh=aizDZvnCDX/j0pRij/wrhNU+Zaq/hXsUCMLAW5X7shE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFIh2S8tjYT1y7pc7z98oyPpLxq5W8A/KgBiEOP7ewfNSXQrMhtajy+FeXaQ8UGWZ8R65kOiafrqRr08aQjcnJS7kqjFCjsV8An4maOOhgm9k96jgU9WCwOJ7zWv0ps7DSijDNFIGRKYrZCrdyop0ims9Hod9CVdfqZwaLjieak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i5qQH4pU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dgzLUyLL44aNtNUZ4cik5aVlKeZ3MyaadjRq+pbLGk0=; b=i5qQH4pUO+Y/XOIW4KPvJ3rbY2
	Rxqu80nP7jKjm1a+NyjJYN0Th7nVtE4d/P0uyJNd9RRHvi4oUyVvq8H6eUsAcCHDKJwknelnVwpKq
	jt+bwUn1P3zDRc6CcLIzJmeyPHr7gGtsjc6seHNb+5uwF1gtyb9RpG8Ydvf0YVjwzy6iFaSs0/BQg
	jsN0KEGloIhShKT1DDil4mKTWBZzu9Lhyiu3WsBV5ZakUj8/ZACVFO8wxOZmmYIvw4DQz0juNTGFf
	zbj5eySUNdQ+6eXieJLh9vUg3qgHIgpTtFUHKyHPzeEP+qztohMIuGrNWuSjv8DfRpp1V1Ir6YWrY
	J7RTak/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57690)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sJCID-0005Ic-0O;
	Mon, 17 Jun 2024 14:21:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sJCIE-0004w5-Ft; Mon, 17 Jun 2024 14:21:06 +0100
Date: Mon, 17 Jun 2024 14:21:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Michael Nemanov <michael.nemanov@ti.com>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless v2] wifi: wlcore: fix wlcore AP mode
Message-ID: <ZnA4QpyOdcYxg8LE@shell.armlinux.org.uk>
References: <E1sClp4-00Evu7-8v@rmk-PC.armlinux.org.uk>
 <Zm1CKAKCnuc94oIi@shell.armlinux.org.uk>
 <87tthrn8gf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tthrn8gf.fsf@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 17, 2024 at 01:56:48PM +0300, Kalle Valo wrote:
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> 
> > I see all my TI Wilink patches have been marked as "deferred" in the
> > wireless patchwork. Please could you explain what the plan is with
> > these patches, especially this one which fixes a serious frustrating
> > failing that makes AP mode on this hardware very unreliable and thus
> > useless.
> 
> I'm just swamped with patches, I'll try to look at these soon.
> 
> I wish that TI would take a more active role in upstream, for example
> reviewing and testing patches would help a lot.

I believe the problem has been that TI have had an attitude of "we
only support people using 4.19.38, if you can't reproduce the problem
there we aren't interested". To see the versions they support:

https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches?h=r8.9&id=a2ee50aa5190ed3b334373d6cd09b1bff56ffcf7

basically, all are ancient.

They also appear take the attitude that all the kernel code is ripe
for them to hack about with - whcih is why this fix has had to be
reworked so it isn't removing NL80211_FEATURE_FULL_AP_CLIENT_STATE
for _all_ kernel wireless drivers!

Also, I think they also require one to use their hostapd and
wpa_supplicant, probably for a similar reason. I know that in some
of the patches they've hacked in API changes...

Then one can see the attitude of lock-step firmware and driver
upgrade - you can't use 8.9.1.x.x firmware with their older driver,
and you can't use 8.9.0.x.x with their newer driver. That, of course,
is not acceptable to mainline.

So, given all this, IMHO it's probably a good thing TI aren't trying
to submit their stuff upstream... that is, unless they are willing
to learn how to "do things correctly".

Maybe I'm being too hard on TI's wireless division, but that seems to
be what has been going on.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

