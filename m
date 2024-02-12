Return-Path: <linux-wireless+bounces-3486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78916851E9A
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 21:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B66B2608D
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 20:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332BA481BE;
	Mon, 12 Feb 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="IrIYKNC+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1AE4644F
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769448; cv=none; b=G0J80HQcIxdse+PlQaEA/dc49lojn/yEHKNMvqvr9rLXFBTEyxdghwrmI+DMDCGn4snKO5M+Xqc7jFvB+XS+KNnl3j9okZD9UsyeEKxgaDbWOI0kNayt8lTyX1rtmCou+VF8z6rsqkj+/tjMlRLarqdkjfOJqbbCHsTYZoJzsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769448; c=relaxed/simple;
	bh=XdPe/McfvbOzoZj4Y9pxpt6aLEiUK/q4NE6mbfHaF5k=;
	h=Message-ID:Subject:From:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:To:Cc; b=bXM6Az8EF4GcVKb6J2+Y1j4CY2zQaL8f10O7o0V4kFF4cxws09irBI9LE/nPLhvvWbjSIWTILN2A/1HhmETd/W+Xv0LDcpWYlsaDzYR91YZgc2wSac7hXD4OlcE4WJWw4VnWCFvVHD9aZbqC6OFqJXMwwZgUVrs0nUtxY8gffiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=IrIYKNC+; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:in-reply-to:references:content-type:
	content-transfer-encoding:mime-version:to:cc:cc:content-type:from:subject:to;
	s=sgd; bh=B3Uh0d709N2lJFKr/VVpT5KQBbKWYhgv1XgvtWGxuy0=;
	b=IrIYKNC+vZICrlh25OiNNg9oXgj7jgrwlWv1dphdk2yQ1o22RF5Y7EJ6DmfFVECsCuZB
	TYhPRCHKH0d+oi8udYtb6kpYzcZ4xoEITO6+oPd2rdPsFIjgFBpf/8Ji4Gq8Olg5DYKUus
	LAsOTeJzwPyZtgE6uflEMZtklE1OCaAdltJ+UNn3Vt9B1EynsueHfTMblYFgWIapDuz3an
	Km0XjyIT3eD9T8ef9BK7QkwdSDzjXIHnm4+RYBh2/VBFWXfG6jE3mKlZMbZWOqwoUwE9Cw
	2ojl/NgUKjQabHLGbLHZ+cHsYlbAVunKeGbOh0vyUclv/HbteMwbfOClZwpJRQ9A==
Received: by filterdrecv-656b5b4c75-pnrz8 with SMTP id filterdrecv-656b5b4c75-pnrz8-1-65CA7E65-1B
        2024-02-12 20:24:05.590489661 +0000 UTC m=+508979.687330859
Received: from bixby.lan (unknown)
	by geopod-ismtpd-4 (SG) with ESMTP
	id Xu5KXj1pTrqUdR7yCsZD6w
	Mon, 12 Feb 2024 20:24:05.398 +0000 (UTC)
Message-ID: <7a401e5ba069f58d2319ade6a7216f234440fe4b.camel@egauge.net>
Subject: Re: [PATCH v5] wifi: wilc1000: validate chip id during bus probe
From: David Mosberger-Tang <davidm@egauge.net>
Date: Mon, 12 Feb 2024 20:24:05 +0000 (UTC)
In-Reply-To: <87h6idpvd5.fsf@kernel.org>
References: <20240207044559.2717200-1-davidm@egauge.net>
	 <87h6idpvd5.fsf@kernel.org>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvH35Kmn6+8YzmOofN?=
 =?us-ascii?Q?vl+3FFLTNwbCK8OekMOWiLA82LAb3oOcr3BhYAO?=
 =?us-ascii?Q?ktBRVnqLY6UesH3nZ9ch3pc8DVAM6dAP02kwGFY?=
 =?us-ascii?Q?C0YPV8hyZjBs3CJgVpFVHIzwH4SAc8Ra6Wfv23p?=
 =?us-ascii?Q?v1Szlj+1nLN4L3dWC6EpkkzGFHEIHXX6vPBSrm+?=
 =?us-ascii?Q?So88h=2FZYib38B0ZN+PjUQ=3D=3D?=
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay.Kathat@microchip.com,
	alexis.lothore@bootlin.com
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

On Mon, 2024-02-12 at 17:15 +0200, Kalle Valo wrote:
> David Mosberger-Tang <davidm@egauge.net> writes:
>=20
> > Previously, the driver created a net device (typically wlan0) as soon
> > as the module was loaded.  This commit changes the driver to follow
> > normal Linux convention of creating the net device only when bus
> > probing detects a supported chip.
> >=20
> > Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> > ---
> >  drivers/net/wireless/microchip/wilc1000/spi.c | 69 +++++++++++++++----
> >  .../net/wireless/microchip/wilc1000/wlan.c    |  3 +-
> >  .../net/wireless/microchip/wilc1000/wlan.h    |  1 +
> >  3 files changed, 57 insertions(+), 16 deletions(-)
>=20
> [...]
>=20
> > --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> > +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> > @@ -12,10 +12,11 @@
> > =20
> >  #define WAKE_UP_TRIAL_RETRY		10000
> > =20
> > -static inline bool is_wilc1000(u32 id)
> > +bool is_wilc1000(u32 id)
> >  {
> >  	return (id & (~WILC_CHIP_REV_FIELD)) =3D=3D WILC_1000_BASE_ID;
> >  }
> > +EXPORT_SYMBOL_GPL(is_wilc1000);
> > =20
> >  static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acq=
uire)
> >  {
> > diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/n=
et/wireless/microchip/wilc1000/wlan.h
> > index f02775f7e41f..ebdfb0afaf71 100644
> > --- a/drivers/net/wireless/microchip/wilc1000/wlan.h
> > +++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
> > @@ -409,6 +409,7 @@ struct wilc_cfg_rsp {
> > =20
> >  struct wilc_vif;
> > =20
> > +bool is_wilc1000(u32 id);
>=20
> I was about to apply this but then noticed the new EXPORT_SYMBOL_GPL().
> The overhead for such tiny function sounds too much, much better to move
> the static inline function to wlan.h.

Good point.  I just sent V6 which has the inline function moved to wlan.h.

Thanks,

  --david


