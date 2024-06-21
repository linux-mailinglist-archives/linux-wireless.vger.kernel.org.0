Return-Path: <linux-wireless+bounces-9443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A89F912D1F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 20:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1E11C22041
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756015F3E9;
	Fri, 21 Jun 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VNgmT2+N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA0B8C1E;
	Fri, 21 Jun 2024 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994017; cv=none; b=bhWstYpVxeeMgsQo+lmHeVXnxSBLKZpKx5AS9NwmE+wsHjNZM21lbWXxca0n1KiQcVzfZiI2aDzy9yMwmFNvqcnf2j+Bd6pLXvGlEW3V5x+vR5ugqWqsF1cyntGAkuUwZYYcrJtFpRYPI7fLKC6T750nLL079hO+aOX28rT2WOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994017; c=relaxed/simple;
	bh=pWNOYa3A8Axfk6v5p2GuB9JD/anJz4Y0Rm4H6P9Hk1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkBLH3T2T9A24PYPXuf0YoUicAXbV6pRV2SlTW/w+1k6EmICLeqh7/+3L/lfrxzXiMUNtsLPbz90GKbnsUIjMxcTg+xDkZGHKlQ7T06aOIXl9g5aCNoyOU+hlOyy8LfXi89bT0NDoF3x5zCmD+zxua4rpUxbr6oO4buGwYDZPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VNgmT2+N; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=v/oqZBS8M6pULcE3kdgAW1T68k5CRvVqyXLUiedQwc8=;
	t=1718994012; x=1720203612; b=VNgmT2+NqF1co/jNkBvGFcngoAtgWMZbi1ZUA9qBzI6rHvo
	AhQ04OGoq+Wep+2IEkb4dMZ4TBKUspOjKRLGMot1ZDhwxGAl9ITcrUX7tex55250+t/5+Z/V4NSGo
	jymrPRHkgnuU/N5M1cX7LfkVDUXIcSOe184E9tAgluDX7I5QJx8v/VWDQXe4AQfoLnbEh2YklhVTd
	h59F7jhYyQl5e9MuU9OuK9IhPC/lYkvisHpPGkGvSgHPpYECX3zQ4nEX/ZSKH+BHqfxwab7eHKnZD
	W+ymte44B3oEiSDxkHhfX7VT4k6gAiz12IHpl004OB0OMpAImWOCgopkugJfL4eQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sKirp-0000000C8cT-2luw;
	Fri, 21 Jun 2024 20:20:09 +0200
Message-ID: <5f5c42585e168e252a5fa3f43325aaa360f6d27a.camel@sipsolutions.net>
Subject: Re: [PATCH 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
From: Johannes Berg <johannes@sipsolutions.net>
To: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org,
 kvalo@kernel.org,  francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
Date: Fri, 21 Jun 2024 20:20:08 +0200
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
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

On Fri, 2024-06-21 at 15:51 +0800, David Lin wrote:
>=20
>   wifi: nxpwifi: add ioctl.h

even the name here sounds questionable :)

>  48 files changed, 34928 insertions(+)
>=20

This is ... huge. I don't know who could possibly review it at all.

A quick look suggests that it's got a bunch of things we probably really
don't want to do that way any more, like

using semaphores in a wifi driver:

> +#include <linux/semaphore.h>

having a bunch of (sometimes wrong!) element definitions in a driver:

> +struct ieee_types_aid {
...
> +	u16 aid;

embedding a (default?) wireless_dev when clearly the driver supports
more than one netdev/wdev:

> +	struct wireless_dev wdev;

Having multiple own workqueues is probably also unreasonable:

> +	struct workqueue_struct *dfs_cac_workqueue;
> +	struct workqueue_struct *dfs_chan_sw_workqueue;
> +	struct workqueue_struct *workqueue;
> +	struct workqueue_struct *rx_workqueue;
> +	struct workqueue_struct *host_mlme_workqueue;

as is a misnamed mutex, but really you could use wiphy work and likely
not have a mutex at all:

> +	/* mutex for scan */
> +	struct mutex async_mutex;

(even mac80211 only has one mutex left, and that's for a specific case
where otherwise we have some issues!)

questionable locking schemes, as evidenced simply by "is something
locked" variables existing:

> +	bool rx_locked;
> +	bool main_locked;

locking code, rather than data?

> +	/* spin lock for main process */
> +	spinlock_t main_proc_lock;

but also simple things like not wanting to use ERR_PTR()?

> +static int nxpwifi_register(void *card, struct device *dev,
> +			    struct nxpwifi_if_ops *if_ops, void **padapter)

(padapter is an out parameter)

Why random numbers for cookies instead of just assigning from a static
variable:

> +		*cookie =3D get_random_u32() | 1;

Open-coding -EPERM?

> +	if (nxpwifi_deinit_priv_params(priv))
> +		return -1;

Using -EFAULT for FW errors seems like a really bad idea:

> +	if (nxpwifi_drv_get_data_rate(priv, &rate)) {
> +		nxpwifi_dbg(priv->adapter, ERROR,
> +			    "getting data rate error\n");
> +		return -EFAULT;


But I really just scrolled through this briefly, this wasn't a real
review. I don't know who could do a real review, but as is, it looks
like someone _should_.

johannes

