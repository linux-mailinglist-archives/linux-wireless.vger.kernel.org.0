Return-Path: <linux-wireless+bounces-26706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294AB387DC
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA384632DD
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5852D5C89;
	Wed, 27 Aug 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kM3dwbtq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8D26A095
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312812; cv=none; b=dM5h02rOsim3JwOx1pP3i96J1r+xiYpH4qxOUedhPscVcF4yf7wXtyW0yUZmL4Z47d/+AfrKYWQ1o9byRVh8BlGXyYVc88T1TmH8WA8kkSJHET4HWgFOjyF0noiNxDngAyo4qu+CaDoUwtJ+QUcONVgB4zXD64lyM/hjgQRLwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312812; c=relaxed/simple;
	bh=GFO9IgTAK+O7G/VSxtzxZebQJUgzwX4U2IYb2z7YTW4=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=BJRQL5pG1Uw7PSliAZT7VNffY9XR72ZzP5Urif4GybKAnUmaZmRlQ8tXQ2vuM7q0JavPSDCg95CHIb7KIipvqzLvcdI6TtczncWMyJt395g5Z7QLwqpRi2/+gNN6OFSyiCMMrT7FA8YEjOA80QYi7pnkKzv8p71Kau4uIjv/PrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kM3dwbtq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=fJOh5Jrw7XLK22JMtsuDSAHmFbvrzPOnZ/Uw0xUIbeI=; t=1756312810; x=1757522410; 
	b=kM3dwbtqENz6D3XAl/fZixgltzJdQuMUOC+QFCfw9D21+nvOPymck8lMmQqInCQfahdrA6VEuh5
	+wfnKbPBAmcyozmyDM+01m+BA9E1V6yPOZjG94s0Fx6IEq7bwP1eWlwCbKUmG2GF63LfubT/o1R4d
	E1sD3aPm1xocWcBU33EdPrfrpFVSF69ydC1uq7BrFyy1txsaFJScoHaiyLnsjyRoy4IeBWckDEcvF
	8MUcPrt1EMyLe4Ceqra96h/Vd0jTPEeBDQvT8FPu0yINZUI7/rQdhYfbdIogbJ29XQ3hGwr4Lz/cH
	rO8CwZCHtax3pR3wxDSojjgFEGKLK8wAy8IA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1urJBq-00000005ngl-1idu
	for linux-wireless@vger.kernel.org;
	Wed, 27 Aug 2025 18:40:02 +0200
Message-ID: <f071f05beba11fe51f5517f3cc9890dc379273f5.camel@sipsolutions.net>
Subject: NPCA/DSO configuration
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Wed, 27 Aug 2025 18:40:01 +0200
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

So I'm looking at UHR NPCA and DSO, mostly wrt. the configuration in
mac80211 (and perhaps to some extent cfg80211, for sniffer.)

Let me look at NPCA first. For NPCA with a device that's capable of
supporting the full channel width (e.g. 320 MHz with non-primary 160 MHz
being used in that case, or non-primary 80 MHz out of overall 160 MHz)
this seems fairly straight-forward:
 - the chandef or chanreq can simply contain a value/pointer for the
   non-primary control channel location, if any
 - the channel context in mac80211 cannot be shared any more, since
   transmissions on the other vif would be seen as OBSS for NCPA
   purposes, and the AP might try to use NPCA with the station that's
   actually doing the OBSS transmission on the other vif

That's about it for the simple case? Not sure if it should be in the
chandef like puncturing or in the chanreq like the full AP channel for
EHT triggering, what does the AP side for NPCA look like in terms of
configuration? Seems like probably it would be configured via hostapd
and then it should be in the chandef?

However, there's another case, say you have a device that only supports
160 MHz, but then connects to an AP with 320 MHz. In this case, it's
meant to still support NPCA. This is not relevant for an AP, I believe.
But this case is more tricky:
 - Should we set the chandef to 320 MHz, but indicate somehow separately
   that only the two 160 MHz channels are really used, since the HW is
   incapable of 320 MHz? That seems ... strange.
 - Should instead the chandef be for 160 MHz, and the non-primary
   control channel is actually outside the 160 MHz channel? That's
   somewhat plausible, but hard to decode?
 - Intel firmware is going to require two PHY contexts, but should that
   really be reflected in mac80211 as two channel contexts? Right now my
   gut feeling is no, and the second channel context also couldn't be
   shared with other vifs since the device really isn't active there.

Or maybe in this case we only put the non-primary control channel into
the *AP* chandef inside the chanreq (struct ieee80211_chan_req::ap) and
not into struct ieee80211_chan_req::oper, since that actually reflects
the full 320 MHz, and let the driver figure out the rest? I think right
now I'd probably consider this option most sane, since this case doesn't
apply to AP mode? And in the "easy" case above obviously the non-primary
control channel would be in both then in the channel request.

As for DSO, that's only relevant for the second kind of device (which
connects to an AP with a higher bandwidth than it can support), so maybe
if the struct ieee80211_chan_req::ap gives the information, the driver
can sort it out just like I was outlining in the previous paragraph for
NPCA?


For sniffer also I guess it's just part of the chandef, which might also
require configuring/tracking the BSS color. Even if the sniffer could
listen on both control channels it'd still have to decide which to
decode, unless it's actually fully dual-channel.

Anyone have any other thoughts?

johannes

