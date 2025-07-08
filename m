Return-Path: <linux-wireless+bounces-24937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E918FAFCA2E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DE97B11BA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90522DBF48;
	Tue,  8 Jul 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kksVd1Ai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E602DBF49
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976979; cv=none; b=qpeVbpLHvoicWImq0rNDMAktt8WP+1Hm7Vc60uHdhHtuIchow3a3h+eiRsjLSRvm0UpJsELYZYTWaA+29Wvnaa27wEptBl5+zAIys3Hoa+n+au8HnO6tESsuvRXgkFpH0tB0pSAgnr59xOwLXDhkImiY48wlcSuB2UEP7O1DSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976979; c=relaxed/simple;
	bh=3LduHcHnTyXj58JOxOykJ0qQQqbe0j30jOI5hG6UleY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=di5t5FbhOEaxK++Ggkih8GygoThCgntwxpFk1ehRK4oUbOLUqtB9uMYrht22fDExG++/B2Fqfs0zcqmTugD52yhhEpt/AUQ8iThq8Ts5Cf1zOwW8UQeAIg9qX6ojPtzVcG+rUI8c0aPO7cr4Ih+D19L6At+mcibw2vGTu+x3ebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kksVd1Ai; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pCE9Yh9ir5tJG3u69ORCXyulGIOdCRN/ZDdkRpY9ing=;
	t=1751976978; x=1753186578; b=kksVd1AiIR2ZfhSKb5cGQNBrVI2byKRrbL8hU2BYi+fUCoI
	TEd9jXaq7KS3014vlmMGmoSAyT8jZqccA9I2tG/9orS3nCaVSuNOEM1adKI7hp0dr0wExYyTxhEk4
	PdlphQ4ZfXw427Oh9uQjHAoZVKbk7PS2CJ3qilRF22oOeCN53IJFlBp1PGqcx/5blxtUzj/QzKX8P
	tcIePeomVKAsyzS0Ow+Xneb/w02vue2BSkrVL1hGY/Gdg1ek4ioMhGiQTUTzCqTk/WXNt44K1CVbj
	CUkKUvKpa85Riuc/SjoY3mcO9/wFTf3KM8g0Q+3fVQU8SnxNIcRp2qcvyYgkhBAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ7F8-0000000BsDr-05L9;
	Tue, 08 Jul 2025 14:16:14 +0200
Message-ID: <f0fc942c9a038e4dc78df7ac4c93f805f70046d3.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 0/2] wifi: cfg80211/mac80211/ath12k:
 Enable monitor creation in NO_VIRTUAL_MONITOR mode when AP is active
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Nithyanantham Paramasivam
	 <quic_nithp@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Date: Tue, 08 Jul 2025 14:16:11 +0200
In-Reply-To: <6ea8710e-7171-42ad-b1b1-5fe679dd19d6@oss.qualcomm.com>
References: <20250313020154.4066212-1-quic_nithp@quicinc.com>
	 <6ea8710e-7171-42ad-b1b1-5fe679dd19d6@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Sorry, I keep starting to look at this, and then confuse myself, and
couldn't seem to offer coherent thoughts so far. I'm still not sure I
can, so I'll just offer possibly incoherent ones instead now ;-)

> > Please share your thoughts on the following query
> >=20
> > In the virtual monitor mode design, only a single monitor interface
> > per radio was supported and subsquent monitor creation shares the same
> > vif. However, in NO_VIRTUAL_MONITOR mode(multi-wiphy scenario), there
> > is no limitation on the number of interfaces that can be created (due
> > to separate SDATA for each interface) and notified to the driver.
> > For example, the ath driver can handle up to 16 interfaces per radio.
> > Should we impose any limitations in cfg80211/mac80211 ?

I think that question really should be if you _want_ to? I already feld
that the NO_VIRTUAL_MONITOR is a hack that goes away from what this had
originally intended (which was allowing the creation of arbitrary
monitor interfaces that may or may not be related to the operation of
the HW), but I think we just didn't find a good way to handle it
otherwise in multi-radio scenarios.

With the benefit of hindsight, I'd say that to best match the original
behaviour,
 * we wouldn't have NO_VIRTUAL_MONITOR,
 * so you could create as many monitor interfaces as you'd like;
 * each one would report frames (perhaps according to the radio mask
   (3607798ad9bd ("wifi: cfg80211: add option for vif allowed radios")))
   rather than filtering by the _channel_ set on it;
 * you'd be able to set the channel on a monitor only within its radio
    mask and if the radio needed for the channel was actually free.

This would require tracking things more in mac80211, possibly creating a
virtual monitor interface per radio. I don't remember if I thought it
too complex, or Felix did? I briefly tried reading through the old RFC
and PATCH postings but not much answer there.

Do we want that? It seems no. All the "coordinate multiple monitor
interfaces in the kernel" seems to be a fringe use case nobody with a
voice really cared about, or they're not using the latest versions yet.
I still think it's somehow technically nicer since you don't have to
sync things in userspace, but if nobody cares why have it...


However, in some way this would seem to move us further away from such
an ideal state, so it seems almost like we should then cover monitor
interfaces by the (per-radio) interface combinations instead of
continuing to pretend they're virtual constructs? Even with the
NO_VIRTUAL_MONITOR we were already at a point where

        /* mac80211 always supports monitor */
        hw->wiphy->interface_modes |=3D BIT(NL80211_IFTYPE_MONITOR);
        hw->wiphy->software_iftypes |=3D BIT(NL80211_IFTYPE_MONITOR);

didn't _actually_ make sense.

So I think it's probably time to remove that if NO_VIRTUAL_MONITOR is
set, and then cover it by the interface combinations. That way, maybe
instead of adding WIPHY_FLAG_SUPPORTS_CONCUR_MONITOR_N_OTHER_VIF (and
that name ... super long) we can check in cfg80211 if monitor is a
software iftype, and if _not_ then just let it go through since we
assume that the lower layer will check the interface combinations?

Or actually improve mac80211 to the point where we can do what I
outlined above?

As it stands, this seems a bit half-cooked?

johannes

