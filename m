Return-Path: <linux-wireless+bounces-18300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A9A25774
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1033F1883288
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09B202C43;
	Mon,  3 Feb 2025 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B7QQ9n5R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1588201034;
	Mon,  3 Feb 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580111; cv=none; b=CZF05MZxe1lRIvSU4gqDNBzPBRkYl9/a2tzKTiOLP3A2YFzz8D6WTwxm6n5d4/R70oS+Q23redkH9QDl1Nob4qZzk3X6Cq6bVxfajUidLzQ1o9KLKJSv6kiice51NTnbN/iW177noweq9Jq6bl4K/Zpz88lb/R2CZC7udexGSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580111; c=relaxed/simple;
	bh=qx0e2ScqgLO+UyhGLqw7MXfPJMGcJrgWaJZ+rwnz42Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2SUVVbHn1p1SaUFFnFVscEH6UMCAuvUIKSy6yhVDZRLYXTmXhNjhyf+tfcNgceOYVrkKWdfuf02UO6vomNnyaKp7cZll2LeeBZMLfLRGwMbWntxw/jRJ7qEOOuSDyXwOyjPXolrJMu0QZPPnKIsf/OqJ8oNIcmniRhaIpaJ/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=B7QQ9n5R; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qx0e2ScqgLO+UyhGLqw7MXfPJMGcJrgWaJZ+rwnz42Y=;
	t=1738580109; x=1739789709; b=B7QQ9n5RFlttX5cEgS8bmmV7M1R82VrJMa5CnXAjrmi8ELJ
	Tgn2fZkbKeie0ZMl5QMIaWVaDBrU/kUKNG/Oc2lnM90QBrdSpkUndLWODAcZP9rATh1CuTM79VojP
	vlTqRmUn5Wljc0JtOqjzStOrEeREWR78o7/HqasUagPbK96/j3n21KYX5YG+7GQiBjM9WKFSYiOW+
	x5uwq9+UbeOrLxjrTx0CqA0KLOIip6oS6VLcBtnN0GIMMQ6FgoNE76IwPJ8MLrsVQEEbZKdL2V5Yk
	h32+7vY/2ob7zNi0wo6tVWH/Usi6qP1Kr+csUWmPYvGQsYE2MI063PCPmNB2O+mQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1teu6Z-00000001YLN-01MB;
	Mon, 03 Feb 2025 11:55:03 +0100
Message-ID: <a4364fa59f65392d06bf6cd59d23d05feed624ca.camel@sipsolutions.net>
Subject: Re: [lvc-project] [PATCH] wifi: nl80211: override all other flags
 if MONITOR_FLAG_COOK_FRAMES is set
From: Johannes Berg <johannes@sipsolutions.net>
To: Jouni Malinen <j@w1.fi>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, Vitaliy Shevtsov	
 <v.shevtsov@mt-integration.ru>, lvc-project@linuxtesting.org, Michael Wu	
 <flamingice@sourmilk.net>, linux-wireless@vger.kernel.org, "John W.
 Linville"	 <linville@tuxdriver.com>, linux-kernel@vger.kernel.org, 
	syzbot+2e5c1e55b9e5c28a3da7@syzkaller.appspotmail.com
Date: Mon, 03 Feb 2025 11:55:01 +0100
In-Reply-To: <Z6CdGnGnFJ8OuWyT@w1.fi>
References: <20250130123432.4534-1-v.shevtsov@mt-integration.ru>
	 <14c5edc71a74049c49d51960249b0aefc77208be.camel@sipsolutions.net>
	 <fhgill32gd3ugmd23oxnyvvqqfd3feu4zv3ecrkubeyqhwnb2h@pkflwiezmsp2>
	 <49fe46c6a158873cdc6593b0d5630b62a59ed059.camel@sipsolutions.net>
	 <Z6CdGnGnFJ8OuWyT@w1.fi>
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

On Mon, 2025-02-03 at 12:40 +0200, Jouni Malinen wrote:
> On Thu, Jan 30, 2025 at 10:13:14PM +0100, Johannes Berg wrote:
> > On Thu, 2025-01-30 at 22:23 +0300, Fedor Pchelkin wrote:
> > > Wouldn't it break existing userspace, especially in context of system=
s
> > > running old stable kernels where the patch is also needed?
> > >=20
> > > There is still some usage of this flag in hostap [1].
> >=20
> > Theoretically, but I just commented on that here:
> >=20
> > https://lore.kernel.org/r/a49e58998553c45953a30243ad1957c06ce6db8c.came=
l@sipsolutions.net
> >=20
> > tl;dr: only ancient hostapd versions will actually _use_ it, and they
> > have to fall into a relatively narrow range (April 2009 - Dec 2011.)
>=20
> How did you determine that commit a11241fa1149 ("nl80211: Use nl80211
> for mgmt TX/RX in AP mode") ends this use? Support for monitor mode
> interface is still in hostap.git and it is even tested as part of the
> hwsim test cases.. Both hostapd and wpa_supplicant can still be
> configured to use the monitor interface.

Well, fair, there are perhaps certain explicit configurations where you
get monitor support, but by default as of that commit it should be
selecting the nl80211 path.

Though looking further, I suppose that in practice commit 73a3c6ffca0c
("nl80211: Use the monitor interface if socket tx status is not
supported") moves the date out a bit, albeit not related to upstream
kernels but only wifi backports to earlier upstream kernels.

> It would be another question to ask whether there is any good reason to
> use this anymore now that a better approach has been available for 13
> years and the answer to that is likely "no". Anyway, this is a kernel
> interface that has a user even in the current snapshot of user space
> programs. If we are about to break that use, it would make sense to
> first remove such users. I don't think I would really care about this
> anymore and it would be nice to get rid of all that unlikely to be used
> much, if at all, code.

Right.

> Though, this seems to imply that the case used by hostapd/wpa_supplicant
> would not be broken.

Not for this patch, no, but I did float the idea of removing it all
entirely.

johannes

