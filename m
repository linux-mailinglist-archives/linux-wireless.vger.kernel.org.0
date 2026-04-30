Return-Path: <linux-wireless+bounces-35711-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPxtAHhV82mLzgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35711-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 15:13:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C284A33CD
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 15:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C73F30021F3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06673413225;
	Thu, 30 Apr 2026 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="FOu3yZCc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20A3E5EC1
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554800; cv=none; b=FT+H617c9FlFD2aksg+c0IqP4CZg/42MgiJwW2cY7dGzRw68muq5yJ/MLDHrcC3fZiv1enpcAw5yANH1q8gCgFo/sBXqLJnc1MmCAhLlTVK64dvk2OuicqDE7qGkagpnPpjQ3FOG7mlkJ5MndhGaPFCtijoonzJPP0F9sKqZgms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554800; c=relaxed/simple;
	bh=RE498i0yz6ZiBeXODxWPnDudcSJ72IIOpFS8OHOnbxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqW2m7GVKnQf11gzym11ZlEY8HWcK65DVSoKMmee+iSWQ9/IS3x03uk7a5Ms44Y7qljLBBK5Q2O0YEJ3+DFoNf5kgO+/6kFPIGAiwjJu/eeYwEdQfbK8wkr0YQT1gVbxhivf9bcYTkE6GDlP3RFCC93mpdD3fE6Pm943AE1ot78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=FOu3yZCc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso8197315e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777554796; x=1778159596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAU+laBnEtUtqsKtQVHrzB08mfX6f6gr6ykNiU5Tq5Q=;
        b=FOu3yZCcHrzK5P7pBQ0L6iq5/0AgbtI/jO9cZrMN9VmAKqVZu/qD2AdA7rWsomTwWf
         OvzU6324yeN0tAtqsOH6d7bKMoUmzBF6p4O8nNOtJ/HpDTAlrygdpA7/PLCRIchlz8hl
         PamU0Sm7DfPDu0n81FAQSty48whIi4LVFwM+UQmg5ibRTYewGBdkZh1MoxfC4TwQbM8x
         2V2o7RPGYj9WuwD8h2bwv/jCgn5PIZnxLz47vS+tGtr2uvOg4Lxjsn9gLMbBf7uYqQDg
         cgMq/+e+QFx9I2yKEdZprao4KcJ01PfC60J/+VeWzSiw5sQCYq1o5HLEzK8lCFoDYCoU
         cY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554796; x=1778159596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAU+laBnEtUtqsKtQVHrzB08mfX6f6gr6ykNiU5Tq5Q=;
        b=aCPt0DBTkLOjHNQ12+39PzFuPQoBDZAnRSQVsU6S9fJi7vGsWkD2gwXWuxzRkeJUJs
         b1M/gahIjLEgFqQBbP/PZ3n1b+UB4+0um9z1oQkXsrT2SyGK3FngV+AZ7BBV2O04zRWo
         OIzJmbTpSuJrEyrlR9xRJXdRC32FLTGJxHVO0FnbvihWDJ9b0HS4/GIUwil7B4ucw5sZ
         CM9ko+HSdZbIulG5ks9wbRkzBSWQnFLGHT6cXEbY8m++ftV3T3Vql4pJ/q23xs2ody20
         irILMuGsYD9+lol4U521QFpn8cZ+5HMmxdAhWNeiZI9QVb7R868c5/MC+6b/MTYFGMAD
         Lq3A==
X-Forwarded-Encrypted: i=1; AFNElJ+JfBAyMbchiREgrEqnuWZ3pJU2kRRPa+CxIgxMLunxcgS3EHqGwxk6p6AbQWkob8NtfUg2atR6qbsEmOfksg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOTqHm1E9S7gEo9K2PjQP+KzH/i02OQb2Aw7xQmvIDpDj6Mu7
	Cy+dc1uaoq8Iw7FsmerYmYEAxNOcgD0rF0+UQLYnoMpGEp9dhgm6x8OYt2LbEbnxJWs=
X-Gm-Gg: AeBDies0ifzfLn1wOGkOOpgnky2F6upE9+3kPxngkwP/QWSr7PBojJ/jsIQQYyJ0ljE
	68zkGPBWrB4u7yO/3bzm87RLa2042aT/L9CQZ0XeTV3iVDY7O66p3pHeV2HgqQ6vWAhC0P7NH/V
	uiEZDnGbnd6qMm5f8oOxTAfLSE06nPXAvhFmF5YElASBepDqoOkvgr7pa2UDYspVrLFgl6NsN7/
	NoQW7ZTrA7h6QrHFEtQt4fEJpMjCCtvL3OhvDsWhSUDKgspcTU5gxn6cniyf9WklCwaggqXqbB9
	l7Do9q4A7g7V/F09vU2WHbFO6XKXQldeBvbvV4gs3jkjQxuqTMuHCcKg5CHZK7YDaIDpVDWBgta
	/99qTFAiHT0YsVAJfVq9gjOkP2umIV1kwQ8dk4N/r1nfPjpvNKhuGsrUbmpn2xrTSYrzs0Ziguu
	uY0SerNgnkJk3I4uYKnm0eDydi6ts5iEamudpz38pdTRZZA2Og9Tir1gja/ZfPJf6yMhWA0xgkQ
	Kd1j09tmDZg28yBIPTQT04zeQ==
X-Received: by 2002:a05:600c:1382:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-48a84458db6mr47509015e9.19.1777554795369;
        Thu, 30 Apr 2026 06:13:15 -0700 (PDT)
Received: from localhost (p200300f65f114e0859f76ff87a50eb14.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:59f7:6ff8:7a50:eb14])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a7b912ee3sm74461355e9.2.2026.04.30.06.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:13:14 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:13:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>, 
	Johannes Berg <johannes@sipsolutions.net>, Markus Schneider-Pargmann <msp@baylibre.com>, 
	Steffen Klassert <klassert@kernel.org>, David Dillow <dave@thedillows.org>, 
	Ion Badulescu <ionut@badula.org>, Mark Einon <mark.einon@gmail.com>, 
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Manish Chopra <manishc@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Denis Kirjanov <kirjanov@gmail.com>, Jian Shen <shenjian15@huawei.com>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Fan Gong <gongfan1@huawei.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Yibo Dong <dong100@mucse.com>, Simon Horman <horms@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>, 
	Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano <venza@brownhat.org>, 
	Samuel Chessman <chessman@tux.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Kevin Curtis <kevin.curtis@farsite.co.uk>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Thomas Fourier <fourier.thomas@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Kory Maincent <kory.maincent@bootlin.com>, Zilin Guan <zilin@seu.edu.cn>, 
	Marco Crivellari <marco.crivellari@suse.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Jacob Keller <jacob.e.keller@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Yeounsu Moon <yyyynoom@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Yicong Hui <yiconghui@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, MD Danish Anwar <danishanwar@ti.com>, 
	Nathan Chancellor <nathan@kernel.org>, Sai Krishna <saikrishnag@marvell.com>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Joe Damato <joe@dama.to>, Double Lo <double.lo@cypress.com>, 
	Colin Ian King <colin.i.king@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-parisc@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
Message-ID: <afNUNeIsN4MrjWN7@monoceros>
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
 <814632c8-070b-4b21-adbb-5a01a62d52f2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eswuwmcxtpmq7cnr"
Content-Disposition: inline
In-Reply-To: <814632c8-070b-4b21-adbb-5a01a62d52f2@huawei.com>
X-Rspamd-Queue-Id: B1C284A33CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35711-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pm.waw.pl,sipsolutions.net,baylibre.com,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_GT_50(0.00)[81];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,baylibre-com.20251104.gappssmtp.com:dkim]


--eswuwmcxtpmq7cnr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
MIME-Version: 1.0

Hello,

On Thu, Apr 30, 2026 at 02:53:29PM +0800, Jijie Shao wrote:
> on 2026/4/29 1:18, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > ... and PCI device helpers.
> >=20
> > The various struct pci_device_id arrays were initialized mostly by one
> > the PCI_DEVICE macros and then list expressions. The latter isn't easily
> > readable if you're not into PCI. Using named initializers is more
> > explicit and thus easier to parse.
> >=20
> > Also use PCI_DEVICE* helper macros to assign .vendor, .device,
> > .subvendor and .subdevice where appropriate and skip explicit
> > assignments of 0 (which the compiler takes care of).
> >=20
> > The secret plan is to make struct pci_device_id::driver_data an
> > anonymous union (similar to
> > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylib=
re.com/)
> > and that requires named initializers. But it's also a nice cleanup on
> > its own.
> >=20
> > This change doesn't introduce changes to the compiled pci_device_id
> > arrays. Tested on x86 and arm64.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/driver=
s/net/ethernet/hisilicon/hibmcge/hbg_main.c
> > index 068da2fd1fea..b3e01b2f8319 100644
> > --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> > +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
> > @@ -489,7 +489,7 @@ static void hbg_shutdown(struct pci_dev *pdev)
> >   }
> >   static const struct pci_device_id hbg_pci_tbl[] =3D {
> > -	{PCI_VDEVICE(HUAWEI, 0x3730), 0},
> > +	{ PCI_VDEVICE(HUAWEI, 0x3730) },
> >   	{ }
> >   };
>=20
> Reviewed-by: Jijie Shao <shaojijie@huawei.com>

Thanks.

> > +	{
> > +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_GE),
> > +		.driver_data =3D 0,
> > +	}, {
> > +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE),
> > +		.driver_data =3D 0,
>=20
> Thanks for your work.
>=20
> If .driver_data =3D 0, is it possible to delete it to be consistent with =
other parts, for example:
>=20
> { PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_GE) }
>=20
> > +	}, {
> > +		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA),
> > +		.driver_data =3D HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,

However keeping the explicit .driver_data =3D 0 to have a contrast to
other `pci_device_id`s having a non-zero .driver_data in the same driver
is also a good reason to keep the (technically redundant) assignment.
For other drivers I dropped these assignments if this is possible for
all array members.

Having said that I don't intend to rework the patch for this suggestion.

Best regards
Uwe

--eswuwmcxtpmq7cnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnzVWYACgkQj4D7WH0S
/k6Htwf7BvJ3rYQezsd5ccz+2MAtba8pHTB3I6pUsnO2mYagJg6HKmfMspgye4AX
BO1wngPAitkKYC0Y1QVjeL8mZpJnkiTKh5ZpywnJ5LC1/Y46vbJl1a7z45/l4MF2
zOsQls/uPpw8h/Dif+kH4laLc33EYUiN6uoPtEBvyJuZUfEXWMc6KHtzmIZnagla
mZcae0icKZUF5MyFeux8zVGWeLTcdBYGrtWUJ2x68bnP62MozIOSPUXTFkPxWruD
HFTrL81mQYbLfZ88SKlMyogAeA7UjBd5/MpVdnfzLm1viy3XHq/Y9eIDkr/WypiX
51YxF/Ol5KsTDi2naPCCB1uZE9k0xQ==
=gn92
-----END PGP SIGNATURE-----

--eswuwmcxtpmq7cnr--

