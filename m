Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5388A47969F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 22:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhLQVz4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 16:55:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47766 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhLQVzz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 16:55:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FDD2623E4
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 21:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF24C36AE2;
        Fri, 17 Dec 2021 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639778154;
        bh=xFeaR4Z8JC4QbeF8c9KoYlJuosUC8HPnNr7oqXGBPDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEbCs+KnkOufGoWDLJiCcvMycV+bv71+XDm/WAOqf0/Lgr5yRmzla/grs20wOjMti
         QSeIEO+H+flWj/Vw/r190BIQ7wjAnw7mp/wxBZo5/rGpAyDXVwpqENswMJOSNUilit
         ecnMq+pRxAjFhrND/sByp0MRovQruo0mf0VoPxEExKL8CSDf22F6T1XfuKR8FrJnxK
         03wu0MUiMOQuaBcMQTQ+MKyALMXMVxKCDUGyzozQR/+GGBPHn2170JmYcjLpIiqAaf
         v9VHQ60tPe+DhyXGZTYIptABUomYrEYL2EBrbZCLjA/DIKSC7f8M9M24W3kdt5mcUw
         4/ss9p9oDW5kA==
Date:   Fri, 17 Dec 2021 15:55:53 -0600
From:   "sforshee@kernel.org" <sforshee@kernel.org>
To:     "Asura Liu (asuliu)" <asuliu@cisco.com>
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: wireless-regdb: Update regulatory rules for the US on 6 GHz band
Message-ID: <Yb0HabN+Js2iWnOH@ubuntu-x1>
References: <DM6PR11MB3116340921B7E66B0E4176A1D7749@DM6PR11MB3116.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB3116340921B7E66B0E4176A1D7749@DM6PR11MB3116.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 13, 2021 at 09:19:50AM +0000, Asura Liu (asuliu) wrote:
> From 3db25ea674232fea6a5efca292f6ed3fd8eba7a2 Mon Sep 17 00:00:00 2001
> From: Asura Liu <asuliu@cisco.com>
> Date: Mon, 13 Dec 2021 16:46:28 +0800
> Subject: [PATCH] wireless-regdb: Update regulatory rules for the US on 6 GHz
> band
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> According to FCC 20-51, FCC adopts rules to unlicensed use of the 6 GHz band:
> "59. Third, the Commission limits the low-power indoor access points to lower power levels than the standard-power access points that operate under the control of an AFC. Consistent with the Commission's approach for the existing U-NII bands, the Commission specifies both a maximum power spectral density and an absolute maximum transmit power, both in terms of EIRP. Specifically, the Commission allows a maximum radiated power spectral density of 5 dBm per 1 megahertz and an absolute maximum radiated channel power of 30 dBm for the maximum permitted 320-megahertz channel (or 27 dBm for a 160-megahertz channel). In addition, to ensure that client devices remain in close proximity to the indoor access points, the Commission limits their PSD and maximum transmit power to 6 dB below the power permitted for the access points."
> See https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-use-of-the-6-ghz-band
> 
> And 47 CFR § 15.407 describe this as following:
> (a) (5) For an indoor access point operating in the 5.925-7.125 GHz band, the maximum power spectral density must not exceed 5 dBm e.i.r.p. in any 1-megahertz band. In addition, the maximum e.i.r.p. over the frequency band of operation must not exceed 30 dBm.
> (a) (8) For client devices operating under the control of an indoor access point in the 5.925-7.125 GHz bands, the maximum power spectral density must not exceed −1 dBm e.i.r.p. in any 1-megahertz band, and the maximum e.i.r.p. over the frequency band of operation must not exceed 24 dBm.

Thanks for the patch. A couple of quick notes about the patch
description. It's preferred to wrap lines in the body at around 75
characters, and it's required that you include a Signed-off-by tag
indicating your agreement to the DCO for your contribution (see
CONTRIBUTING).

Additional comments below.

> ---
> db.txt | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/db.txt b/db.txt
> index b898799..c6ef9b6 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1606,6 +1606,12 @@ country US: DFS-FCC
> 	# https://www.federalregister.gov/documents/2021/05/03/2021-08802/use-of-the-5850-5925-ghz-band
> 	# max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
> 	(5850 - 5895 @ 40), (27), NO-OUTDOOR, AUTO-BW, NO-IR
> +	# 6ghz band
> +	# https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicensed-use-of-the-6-ghz-band
> +	# https://docs.fcc.gov/public/attachments/FCC-20-51A1_Rcd.pdf
> +	# max. 30 dBm AP @ 320MHz, 27 dBm AP @ 160MHz, 6 dB less for clients
> +	(5925 - 7125 @ 320), (30), NO-OUTDOOR, AUTO-BW
> +	(5925 - 7125 @ 320), (24), NO-OUTDOOR, AUTO-BW, NO-IR

The kernel doesn't currently support multiple rules with different flags
for the same range. This is an issue that's come up several times, but
so far nothing has been done about it.

Even ingoring that, I don't think these rules accomplish the intended
purpose. There's nothing that would require a client device to use the
NO-IR rule, so they could end up using the higher power limit and
transmitting before detecting transmission from an AP.

I also suspect that we should be able to express the AFC requirement in
the database before permitting AP operation in this range.

Currently I think the best we're able to do is to use the lowest common
denominator, which is the 24 dBm rule with NO-IR.

Thanks,
Seth
