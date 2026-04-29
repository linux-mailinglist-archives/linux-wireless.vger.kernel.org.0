Return-Path: <linux-wireless+bounces-35551-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bO1XAymN8WkaiAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35551-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:46:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D57D48F3BB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A8DF3038516
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 04:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BD83A14;
	Wed, 29 Apr 2026 04:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="iF8qxB40"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26A75809
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777437989; cv=none; b=A+kSPXOimkCbjRG68YVCzGdX8n/0NYYzhRKa1ucerj3agPSF1uEm6hdv8NWRjceLvoFT8/PF3aFtDRtAGvGzPHJUBcsljyyIs531YbHOKDhtgDw6S8F6XLKbFXAF6HmYTIPFSc510kHErHpy+/vCmIGsBEW2BkPwMB40tAN5hf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777437989; c=relaxed/simple;
	bh=krd39FekEVdd6tkBIxm/S9FL6O2L5Q31CUAOdlfCjvw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=uGYKtGoK5uyx7oEHVw573oDTkGpV/aWnVGe0/K4XUB0gn8CVeDkwakAARLjPAWVFusuAQr5B+WJgo42ITrvrxmoC5CLVKl+aksCaI4aaMS71wEMy4PT19mlu9Dn2YMu4QMSSzIpNGZwabuiMbsNHHL+UTmcrecOdqs6u4abcokY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=iF8qxB40; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 00B07240027
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1777437979; bh=AG6deMop200yH1vSXb1SOWdyULB9oSC34pEdZHdkkik=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version:
	 Autocrypt:OpenPGP:From;
	b=iF8qxB40+SgSEl/zgaR1e26BgUrd5BOgFa069DH8SzJy9YYMutbdv5OhlV/SLSXvS
	 xySG0a/eG0ipgWBSR48dz5fF4sulkzTiIFkHlYR+jEPOtsqB14zyY59RcZvH76oUso
	 pPYFH/iEjIlgFVofmKpkAuHItr6ihq03i4tTfKuW9BoC1zHmkhbueaOXdknxftnatQ
	 fXYPQlCr9Te0DU9Dnf0rAiX2d7mXPwals+JazBSXcuWaNsORx1Bb4wP8/9G8Z88t7O
	 WGv4ETm/eOlmQVRqMu6n+5ZesJpkFwcWJzYlImv0Qn+nyXo2I7dKrVeH4yyPdvKojc
	 TmaeLadn/uV3A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4g54WY4VDkz9rxD;
	Wed, 29 Apr 2026 06:46:17 +0200 (CEST)
Message-ID: <ef6ecd3a6bcc5314cb10b8e1586743438eff3231.camel@posteo.net>
Subject: Re: [PATCH 09/10] carl9170: fw: enable DFS radar detection
From: John Scott <jscott@posteo.net>
To: Masi Osmani <mas-i@hotmail.de>, Christian Lamparter
	 <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
In-Reply-To: <AM7PPF5613FA0B6E8DE143A385080A72F139444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
References: <cover.1773277728.git.mas-i@hotmail.de>
	 <AM7PPF5613FA0B6E8DE143A385080A72F139444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Jabber-ID: me@johnscott.me
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qjLkje25DXrvxr1/HKkz"
Date: Wed, 29 Apr 2026 04:46:18 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=jscott@posteo.net;
  keydata=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
  2Bms0A==
OpenPGP: url=https://posteo.de/keys/jscott@posteo.net.asc
X-Rspamd-Queue-Id: 3D57D48F3BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[posteo.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35551-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.de,googlemail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jscott@posteo.net,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--=-qjLkje25DXrvxr1/HKkz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
I have a question about how this fits into the wireless regulatory status q=
uo, as someone who doesn't understand the code too well but is interested.
Currently it appears ath9k guards radar detection behind a Kconfig option, =
and the details look important:
> config ATH9K_DFS_CERTIFIED
> 	bool "Atheros DFS support for certified platforms"
> 	depends on ATH9K && CFG80211_CERTIFICATION_ONUS
> 	default n
> 	help
> 	  This option enables DFS support for initiating radiation on
> 	  ath9k. There is no way to dynamically detect if a card was DFS
> 	  certified and as such this is left as a build time option. This
> 	  option should only be enabled by system integrators that can
> 	  guarantee that all the platforms that their kernel will run on
> 	  have obtained appropriate regulatory body certification for a
> 	  respective Atheros card by using ath9k on the target shipping
> 	  platforms.
>=20
> 	  This is currently only a placeholder for future DFS support,
> 	  as DFS support requires more components that still need to be
> 	  developed. At this point enabling this option won't do anything
> 	  except increase code size.
(I think that last paragraph is out of date=E2=80=94my understanding is ath=
9k has supported DFS for a while, at least when used in tandem with wpa_sup=
plicant, but I've not had the pleasure to try that yet.)
I see this option depends on CFG80211_CERTIFICATION_ONUS, which, indeed, is=
 an affirmation from the kernel configurator that this will be used in such=
 a conforming environment. Does carl9170 need to do something similar befor=
e turning this on? From the several AR9170 NICs I have in my collection, no=
ne of them have FCC approval for radar detection as far as I know. (Does an=
yone know of any?)
Perhaps the sentiment of Linux Wireless folks is different now=E2=80=94I th=
ink ath9k was the original prototype for radar detection, anyway=E2=80=94bu=
t could this be a problem?

On Thu, 2026-03-12, Masi Osmani wrote:
> Enable DFS (Dynamic Frequency Selection) radar detection on the
> AR9170.  The hardware has radar detection registers (RADAR_0,
> RADAR_1, RADAR_EXT) and the firmware already sends
> CARL9170_RSP_RADAR events, but the driver never programmed the
> detection parameters and only logged a "please report" message.
>=20
> Changes:
> - Program radar detection pulse parameters in phy.c when the
>   current channel has IEEE80211_CHAN_RADAR set.  Values are
>   based on ath9k defaults for FCC/ETSI compliance.
I see cfg80211.h says
> @IEEE80211_CHAN_RADAR: Radar detection is required on this channel.
so this *appears* to affirm my mild concern that this patch is intended to =
permit initiating radiation on such channels. Is that right?

> - Advertise radar_detect_widths in the interface combination
>   (fw.c) for 20 MHz noHT, 20 MHz HT, and 40 MHz HT.
> - Replace the old "please report" message with a call to
>   ieee80211_radar_detected() so mac80211 can trigger the
>   proper DFS state machine (channel switch / CAC).
>=20
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>  drivers/net/wireless/ath/carl9170/fw.c  |  3 ++
>  drivers/net/wireless/ath/carl9170/phy.c | 45 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/carl9170/rx.c  |  7 ++--
>  3 files changed, 50 insertions(+), 5 deletions(-)
Thus it appears no Kconfig changes were made and your changes don't guard r=
adar detection behind a suitable preprocessor directive.

By the way, I notice in include/net/mac80211.h
/**
 * struct ieee80211_conf - configuration of the device
 *
 * This struct indicates how the driver shall configure the hardware.
 * ...
 * [bool] @radar_enabled: whether radar detection is enabled
 */
Is this .radar_enabled member something that should be checked or used as p=
art of these changes? I don't know anymore about this code than the plain m=
eaning of the words, but I thought I'd ask: a patch to enable radar detecti=
on seems like it ought to access such an object named "radar_enabled" at so=
me point, right?

P.S. Although I don't have access to formal industrial testing equipment, I=
'm in Central Indiana, USA and I already have a couple creative ideas to pu=
t radar detection to the test, at least to assess effectiveness of the impl=
ementation. Perhaps comrades from my local Linux Users Group could join me =
(field trip!), if I do some more research to ascertain the frequency bands =
used. "It doesn't hurt to ask" =F0=9F=99=82
There are legitimate circumstances where DFS/radar detection can be enabled=
 even if the FCC Part 15 certification wasn't performed for the hardware=E2=
=80=94such as when operating under rules other than conventional FCC Part 1=
5 (some amateur radio licensees, limited non-commercial usage and experimen=
tation). So even putting this behind something like a "CARL9170_DFS_CERTIFI=
ED" would still be neat if we could show its usefulness

--=-qjLkje25DXrvxr1/HKkz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iPsEABYKAKMWIQSiPzylvTnZ6xisfzWz9N0oYfTNugUCafGNEXIYaHR0cHM6Ly9q
b2huc2NvdHQubWUvLndlbGwta25vd24vbmkvc2hhLTI1Ni9zWUF3OTN6QUVrRkIy
RDREM1hOemRSeHEyMFBjNnByZGdtbEVWeXo0QUZRP2N0PWFwcGxpY2F0aW9uJTJG
cGdwLWtleXMSHGpzY290dEBwb3N0ZW8ubmV0AAoJELP03Shh9M26UjgBAIAHS82d
Mq5dulCM2oFCbWyI8jS1t8XP+w/qQ2lvzGHyAPwNTPjkCrgZA8OYAN0nepK3oJkN
dJUcEbzriAKkKaFVCA==
=pj/n
-----END PGP SIGNATURE-----

--=-qjLkje25DXrvxr1/HKkz--

