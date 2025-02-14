Return-Path: <linux-wireless+bounces-18959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A597A365B6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 19:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873A41894A27
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7177268FF7;
	Fri, 14 Feb 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bS56Gh5h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5784268C45;
	Fri, 14 Feb 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557594; cv=none; b=FrF65JrpERZYA9G6b4q9Havlk820ng+Y9iMGmAVJNp6HmZ1bMFX5lRg/qyu9ySH+ELsKuNV6v9r9MgvdehCYnefx62xjAyyNPRajGzhh03Vu+GAFvX8mQpoIbRra0rRkpbkKf8wEv7urtthaIPaJedAfvNYRVFRKucj3v6m7+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557594; c=relaxed/simple;
	bh=5SAs9h/MeZMEpYhpzWt1QWZwTrgFYpqzNonzMoz6HHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IAmDFauc9spTNgyj8wKp2yXatmHav6WrIR+rnZmtzPYV3rw35PUZUoolWkF81KU9yUKyojDV0CcwSTnzLZg878o46wqL5/maSDSa3VdDNuvY2oYnK5ISJ1rs8e14zmhkXO10ZY5aZ9zW9Gn7b91qg1HaDdvZ68gFQRNIVIEgrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bS56Gh5h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lb8UeyUJ5kaiUORiZMt8CZIHBu6K6oUcJ1EMZFGDpe8=;
	t=1739557592; x=1740767192; b=bS56Gh5hC389PI5Uk4xmUKElr0BKCzeClnRMhbBMibKDI5W
	x/ufkAIoF6LRoXFee6shFktfI76s4b7F3j7YkAZsLnO8ZKfOa2ePVb+JwCoe5a8tymHHjXInHSm3j
	+n2UGzr6dd+P0ctXwljjx7xT8zcWTPQKI0tfum3qMdlzldwNR2HYXf+H3+jZuOjXnXQITjetEbWIM
	sde+hk3KK1RaS9FYQQQgcsnJaXQLWYgilKDSwYdSa3C2igxsOVFENrhsD2dFcSjgAjeWQYwWvD+tT
	xFHuJqUNfRi1FFjMZT74hr8cuAsfWBCa6KSTdrU2rbsaI1VqVOG2w054qCQ091Eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tj0OO-0000000EjAP-1yhk;
	Fri, 14 Feb 2025 19:26:24 +0100
Message-ID: <57ff2078632d8f14ca73c8307dc43585b3d09f50.camel@sipsolutions.net>
Subject: adding new drivers (was: Re: [PATCH 00/43] wifi: nxpwifi: create
 nxpwifi to support iw61x)
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "briannorris@chromium.org"	 <briannorris@chromium.org>,
 "francesco@dolcini.it" <francesco@dolcini.it>,  Pete Hsieh
 <tsung-hsien.hsieh@nxp.com>
Date: Fri, 14 Feb 2025 19:26:23 +0100
In-Reply-To: <PAWPR04MB991006F5D4C0D82A4153C0069CFE2@PAWPR04MB9910.eurprd04.prod.outlook.com>
References: 
	<PAWPR04MB9910AE0CBBFAE748D265EAE09CFE2@PAWPR04MB9910.eurprd04.prod.outlook.com>
	 <PAWPR04MB991006F5D4C0D82A4153C0069CFE2@PAWPR04MB9910.eurprd04.prod.outlook.com>
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

Hi Jeff, all,

> > This is ... huge. I don't know who could possibly review it at all.
>=20
> Since this is a new driver, any suggestions on how we can make it easier =
for review?

No, not really. Or, well, there was a suggestion to integrate it a bit
more with mwifiex, as to reduce the duplicated code. I don't find that
suggestion as entirely ill-founded as you seem to, given that large
sections of the code such are simply copy/pasted.

Now that doesn't mean you should necessarily _integrate_ the new device
into the old driver, but I don't see how doing some refactoring to share
some code really would be all that problematic, though we might have to
make some changes to the layout such as moving nxpwifi under the nxp/
dir now.

If I ask git about it (after s/nxpwifi/mwifiex/ and some other trivial
renames) then it says a lot of files are effectively the same:
...
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/11ac.c            =
    |  104 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/11ac.h            =
    |    7 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/11h.c             =
    |  190 +++-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/11n.c             =
    |  190 ++--
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/11n.h             =
    |   58 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/11n_aggr.c        =
    |   51 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/11n_aggr.h        =
    |    2 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/11n_rxreorder.c   =
    |  173 +---
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/11n_rxreorder.h   =
    |   12 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/cfp.c             =
    |  143 +--
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/ethtool.c         =
    |    2 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/ie.c              =
    |  100 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/sta_rx.c          =
    |   76 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/sta_tx.c          =
    |   62 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/txrx.c            =
    |   62 +-
 drivers/net/wireless/{marvell/mwifiex =3D> nxp/nxpwifi}/uap_txrx.c        =
    |   74 +-
...

and in many cases here the diff looks larger than it really is because
nxpwifi appears to be missing features (TDLS, IBSS?) removed USB
support, and did some (minor) code cleanups (and anti-cleanups.)

I'm glad you now use 'struct element' instead of having your own 'struct
ieee_types_header', but that's an obvious trivial transformation even
for mwifiex, you can do that with spatch?

For a total of:
 66 files changed, 10945 insertions(+), 21952 deletions(-)
so your driver actually shrinks to about 30%, i.e. 70% of the code are
simply copied from mwifiex (and that's a conservative estimate, since it
contains a lot of the trivial cleanups you made in those lines that are
still different.)

Side note: integrating it would probably also somewhat hide issues in
your code, such as open-coding "Bubble sort" when we have a perfectly
fine implementation of sorting in the sort() function? Or using
ktime_get_ns() in an odd way for deriving random numbers, what's up with
that?? But I wonder how much you even care if you just copied such code
into the new driver without thinking about it at all.
Another example is the obvious inconsistency wrt. endian annotations, I
cannot believe that the firmware adjusts to host endian for some
commands, so I guess you must simply not care I guess. But then why do
it partially? I suppose because copy/paste is easier?


I also get it though - you don't want to maintain code that's well over
decade old, however by having 70% of the old code copied into the new
driver it seems like you're now painting yourself into that same corner
again.


> We have addressed the comments you sent on June 22, 2024 in patches V3.
> Please review and let us know if you have any additional feedback or sugg=
estions.

If you've been reading the list (have you?) you should know that Kalle
just left a little while ago, and I'm definitely not going to be able to
really review everything at this time.


Also! Another important thing to me right now is that it doesn't seem
like you're interacting much with this community other than dumping this
code and asking for it to get reviewed and merged. I literally just
asked for everyone to start reviewing each other's patches [1] because I
will not be able to review everything (and I don't even think I (as
maintainer) _should_ necessarily be reviewing everything, I see it more
as keeping an eye on the overall wifi-specific architecture, APIs etc. I
don't see why I should point out obviously odd things like using
ktime_get_ns() for random numbers.)

[1] https://lore.kernel.org/linux-wireless/21896d2788b8bc6c7fcb534cd43e7567=
1a57f494.camel@sipsolutions.net/


Now I'll admit that nobody else has taking that up so far either as far
as reviewing goes, but I really still hope they will... You could even
set a good example here I guess, and have developers learn something in
the process; getting folks exposed to the mailing list and thereby
current ideas, trends and how other drivers work is almost certainly a
really good thing for your own driver/development too. See, for example,
how Kalle said it simplified the locking etc. much to use the wiphy
mutex with wiphy_lock() throughout the ath12k driver now.


Anyway ... I should stop. If this feels like a bit of a rant, I guess
that's because it is. I'm not sure everyone else is doing better (*looks
over at Broadcom*), and the cc33xx folks would probably do well to pay
attention here too. At least here I am trying to help people out, but
like I see here - I offer a bit of review and then I'm asked to do "the
review" that makes the driver get accepted.

Maybe I care too much? But drivers/staging/ is supposed to be the free-
for-all thing, not drivers/net/wireless/.

Anyway, I think there are issues to address here and I'm not going to
merge a driver that's 70% copy/pasted, we have that with the older
realtek drivers and it's awful. You can submit it to the net-next tree
or staging if you like, I'm not going to block it on the grounds of
something here being bad wrt. WiFi, even if Linux support feels like a
bit of a second thought for the firmware (e.g. the lack of probe_client,
this ought to be a trivial feature to actually support if you cared
about the integration with the Linux wifi stack? Or
nxpwifi_cfg80211_change_station() being a no-op? How does that even
_work_ at all?)

johannes

