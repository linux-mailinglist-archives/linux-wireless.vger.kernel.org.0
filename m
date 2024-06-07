Return-Path: <linux-wireless+bounces-8680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FA690006A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 12:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75D7288256
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3681CA85;
	Fri,  7 Jun 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QEDDetRT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5C2B2CF
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755139; cv=none; b=Gu/KK3Vavxe3h+e8JXPRkgX8zZQTdm3FZFeyWBtWlkMZsWoFdqAajv3nspPOBMlCshenjwVpKif3uSfmaJ3faNyDCpfjLT/9st8OFy1RkgSKwTo7GCd5R9WK4d2v+aAek51y4AKE6TX3LPSEN+nZ24p4QVrmwFItF3uj18C1vLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755139; c=relaxed/simple;
	bh=gA7Yvz4W2CU+o6LkwH/meh/GPnD59forO1AGmVpA3/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0yJEbEWdpFLdwqcB1SBIekH2LsSymCfEfKTr8V09EIOxqWWIEsIkCHjA3zNY8jrcyBr6/UlfLgGVod9+yYtdKvUZejpsg1q3D0NMQZs6tjo6lxH6P85oq6I9LmqAyFFFiYO79feOHPqPHInv3/oazojH2EN5tphblINUb0phqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QEDDetRT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A06AZBW0nm0OZzaXM0gGaBoJK04KsApDfsDkp6veoHo=;
	t=1717755137; x=1718964737; b=QEDDetRTuqkO4Dc2lxygSEX2C5wUApw/P9EB2OpsMOJsws6
	IitS1mowWDojdGk8JvtPCzcFsD/wxZBV6UxrFrnlEF972r2ZMTngC1c3FKku6GtyUcCrnmoi5s7TQ
	ejwfmal4bHLw8tpWkVLLIu0Ry1GSXrsvWKD5IqEqoZQl3zJ03e6EepsYJYoiXX3FUwSXt+TZy5bgc
	GwRSRLy9R9zQRZB533eLWUv+HD/E1r64ARm/bjJ1QTBXVl2Kp/JHiwmo3xmJEbRA35+NljOQjNbwh
	H5bRdxASE/tz68Rr+73wY6CFNV1xZwC/LqYRe2LRXfUtxXKsIo3q8VbkZwzoaKAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFWZy-00000000v1a-1uSu;
	Fri, 07 Jun 2024 12:12:14 +0200
Message-ID: <8cac5465a87e2829d4c617995a19d3f4deba2ed8.camel@sipsolutions.net>
Subject: Re: [RFC v3 8/8] wifi: mac80211: add wiphy radio assignment and
 validation
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Fri, 07 Jun 2024 12:12:13 +0200
In-Reply-To: <c5abf1ae-bdda-42b2-95c0-9b1c39659bbd@nbd.name>
References: 
	<cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
	 <9b331a61b8d53284b044bc594cf9952c60164e5f.1717696995.git-series.nbd@nbd.name>
	 <a1cff51f789c21b2b307c58ee4d743a62874cec6.camel@sipsolutions.net>
	 <c5abf1ae-bdda-42b2-95c0-9b1c39659bbd@nbd.name>
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

On Fri, 2024-06-07 at 11:53 +0200, Felix Fietkau wrote:

> > struct wiphy_radio *wiphy_get_radio(struct wiphy *wiphy, ... *chandef);
>=20
> I didn't add such a helper, in case we get hardware where multiple=20
> radios support the same band. That's why ieee80211_find_available_radio=
=20
> loops over all radios until it finds one that matches both the freq=20
> range and the ifcomb constraints.

Ah, fair.

Thinking more about the "whole chandef" thing, I think I want to have a
check in cfg80211 somewhere that ensures you don't split up ranges that
could be used for a wider channel?

Say (for a stupid example) you have a device that (only) supports
channels 36-40:

 * 5180
 * 5200

but now you say it has two radios:

 * radio 1 ranges: 5170-5190
 * radio 2 ranges: 5190-5210

Now you can't use 40 MHz... but nothing will actually really prevent it.

Obviously this is a totally useless case, so I'd argue we should just
check during wiphy registration that you don't split the channel list in
this way with multiple radios?

Even on the potential Qualcomm 5 GHz low/mid/high split radios you'd
have gaps between the channels (e.g. no channel 80, no channel 148), so
it feels like you should always be able to split it in a way that the
radio range boundaries don't land between two adjacent channels in the
channel array.

Not sure how to implement such a check best, probably easiest to find
all non-adjacent channels first:

=20
 - go over bands
   - ensure channels are sorted by increasing frequency
     (not sure we do that today? but every driver probably does)
   - find adjacent channels:
     - while more channels:
       - start_freq =3D current channel's freq - 10
       - end_freq =3D current channel's freq + 10
       - while current channel's freq =3D=3D end_freq - 10:
         - go to next channel
       - check all radio's ranges cover this full or not at all
         (neither start nor end of a range falls into the calculated
          [start_freq, end_freq) interval)

or something like that?

(Also some docs on this I guess!)

johannes

