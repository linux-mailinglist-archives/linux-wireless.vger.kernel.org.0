Return-Path: <linux-wireless+bounces-25332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D85AB02F11
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 09:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FF31895C30
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 07:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679491BE238;
	Sun, 13 Jul 2025 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="FRjGIAFt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCB19E96A
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752390938; cv=none; b=V3wuNMw35a92ecVBo9L9RRIMPIoZSHchwhlh0zV10mWJpQNd4putoix/Vn25tMP9ikmhhMSXekxQebNFY12SWD4fqgkJqk4ZUGYHT6i/dOg0EXx0RtNmrRmy7e9CYnPUCUxnksVYupE9q7i9avT319toM+1F5S5lvxi9YF5e3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752390938; c=relaxed/simple;
	bh=f0BZ1aEY6y4Cc1MStO+sICC9i1OV/GQNzAgioBiOqus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWAQyWzsp0YW+7JTQeJsYEb4kHgV4scP0EbAq1JEdNxD7saT8q5Hf6huVwDzavjc0F0SMiW3E/RvgInYfUmJWpTkwctv06YDuSZr0YkAm2grcPHrWjiI0P1rT80ufp7WCuTyUEPJZxHuAvUyKdPB0kfxtpTJKV6+nr9gMVgEloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=FRjGIAFt; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 19348 invoked from network); 13 Jul 2025 09:15:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752390932; bh=w6uk2vSSK6kqFUYuqq9wRIV5THBtnHlaQCSQ8TziC3o=;
          h=From:To:Cc:Subject;
          b=FRjGIAFts+ncFni3a1QtStmqoRjGSBbzbv+fu3CCrvg0POfGxtRWy1qe9BDOdMv05
           Jgufu28olMCo4lCy3gPEaC8Dtt0HTwAAUJti3zEEq+lbgP+qGGTjSgNVYY7tF6ECtG
           GLQpn2fay8FHGilvqOc+/+XeYVIBavvoXRz6I9Qpj68JowKrrd9YhnRQzI28eb+A9C
           8BtpVXwEBMRol9SJUvlvFF9aoE86vfLer19dJtVHzi99olSl7rMbQt7zuNt1FvEW+K
           Bh6ZGVr4iRyVqvJVOEwHWe9OvldV49IM5X77YFpIUJrZS0Tuj3is0zaL+EJ3N0s+aJ
           qbF6niVbKxudg==
Received: from 89-64-3-180.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.180])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 13 Jul 2025 09:15:32 +0200
Date: Sun, 13 Jul 2025 09:15:32 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCHv3 wireless-next 3/7] wifi: rt2800soc: allow loading from
 OF
Message-ID: <20250713071532.GA18469@wp.pl>
References: <20250710200820.262295-1-rosenp@gmail.com>
 <20250710200820.262295-4-rosenp@gmail.com>
 <20250712101418.GD9845@wp.pl>
 <CAKxU2N-RXgFKYPAqEu3iZDMAisj_K-b+ZZTGFsabWz7pMK+02A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-RXgFKYPAqEu3iZDMAisj_K-b+ZZTGFsabWz7pMK+02A@mail.gmail.com>
X-WP-MailID: a575d8a94d89fffda96a0f3af808d2f5
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kZMB]                               

On Sat, Jul 12, 2025 at 12:02:35PM -0700, Rosen Penev wrote:
> On Sat, Jul 12, 2025 at 3:14 AM Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> >
> > On Thu, Jul 10, 2025 at 01:08:16PM -0700, Rosen Penev wrote:
> > > Add a single binding to help the already present dts files load the
> > > driver. More are possible but there doesn't seem to be a significant
> > > difference between them to justify this.
> > >
> > > Use wifi name per dtschema requirements.
> > >
> > > The data field will be used to remove the custom non static probe
> > > function and use of_device_get_match_data.
> > >
> > > Added OF dependency to SOC CONFIG as adding of_match_table without OF
> > > being present makes no sense.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  drivers/net/wireless/ralink/rt2x00/Kconfig     | 2 +-
> > >  drivers/net/wireless/ralink/rt2x00/rt2800soc.c | 7 +++++++
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
> > > index 3a32ceead54f..a0dc9a751234 100644
> > > --- a/drivers/net/wireless/ralink/rt2x00/Kconfig
> > > +++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
> > > @@ -202,7 +202,7 @@ endif
> > >
> > >  config RT2800SOC
> > >       tristate "Ralink WiSoC support"
> > > -     depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
> > > +     depends on OF && (SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST)
> > >       select RT2X00_LIB_SOC
> > >       select RT2X00_LIB_MMIO
> > >       select RT2X00_LIB_CRYPTO
> > > diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> > > index e73394cf6ea6..db8d01f0cdc3 100644
> > > --- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> > > +++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> > > @@ -243,9 +243,16 @@ static int rt2800soc_probe(struct platform_device *pdev)
> > >       return rt2x00soc_probe(pdev, &rt2800soc_ops);
> > >  }
> > >
> > > +static const struct of_device_id rt2880_wmac_match[] = {
> > > +     { .compatible = "ralink,rt2880-wifi", .data = &rt2800soc_ops },
> >
> > Why do .data = rt2800soc_ops here and use it via of_device_get_match_data()
> > in patch 5, insead of just use rt2800soc_ops directly in rt2800soc_probe ?
> I see more of the former instead of the latter in drivers.

If there is no technical reason to use indirection, this can be
simplified as well. Can be done as separate patch since you already
posed v4.

Regards
Stanislaw


