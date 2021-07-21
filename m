Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE73D125D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 17:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhGUOqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 10:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238948AbhGUOqt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 10:46:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 811A561019;
        Wed, 21 Jul 2021 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626881245;
        bh=FovSolxcVGt/fjQOdmy+qNXac3fTl6SVUqKqhibP1Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0UI4LFFgQr/oKV6fL/BhKMs18WximT6fBz178IZ1b2PXdvLSvmhqYXl9wGKcaBwK
         M3Yyh5bTwL0D9nBOi/UHbrb3/mlZMjrBDazNTvuCJya7UfWsD41o8Y5xYnwWeyALyq
         sEuR0lLpH3bdBKorU2QS0F52rnX/pACwOHjbGrjKbr2xBg23YimvqYTFAyIe/9/9zd
         tG5I0HPpugwiC1W+NvFOLzdbSesCvDXOPNpL5IJqFb5mVMzx/MmXOffjXbGGBJGMxi
         tIgnXZpphxj/9qlJRMtJAK48USiolNd/rmKQvdyHye1NckvCusgIZo8RiIwwr9QrXl
         NiJSNGVGVNxyQ==
Date:   Wed, 21 Jul 2021 10:27:24 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Timo Witte <timo.witte@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Germany (DE) on 6GHz
Message-ID: <YPg83HXFIXDAEFx1@ubuntu-x1>
References: <CANB4YXTf0DhJfL6kPa26ZCzj8FRwwdw_enGROzL-zXuWGyrwOQ@mail.gmail.com>
 <CANB4YXRtyvgu946rL=gxaRqhXja1qfBQ+DSYfiMvYcax7o45EQ@mail.gmail.com>
 <YPgvMph+3vRbrol3@ubuntu-x1>
 <CANB4YXSDuYndC26KPkV+XqPkowbN54MMceuj7MNaxh+EwLN4kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANB4YXSDuYndC26KPkV+XqPkowbN54MMceuj7MNaxh+EwLN4kw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 21, 2021 at 04:57:03PM +0200, Timo Witte wrote:
> From f9a99269b00f961e40024632c7b831c615bfa392 Mon Sep 17 00:00:00 2001
> From: Timo Witte <timo.witte@gmail.com>
> Date: Wed, 21 Jul 2021 16:51:40 +0200
> Subject: [PATCH] add wifi6e for germany
> 
> Signed-off-by: Timo Witte <timo.witte@gmail.com>
> ---
>  db.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/db.txt b/db.txt
> index 1e5ed03..411b7ac 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -448,6 +448,12 @@ country CZ: DFS-ETSI
>  # Bereich 57 GHz - 66 GHz für Funkanwendungen für weitbandige
>  # Datenübertragungssysteme; „Multiple Gigabit WAS/RLAN Systems (MGWS)“).
>  # https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/2011_08_MGWS_pdf.pdf
> +#
> +# Allocation for the WiFi 6E Band (Allgemeinzuteilung von Frequenzen im
> +# Bereich 5945 MHz - 6425 MHz für drahtlose Zugangssysteme,
> +# einschließlich lokaler Funknetze WAS/WLAN („Wireless Access Systems
> +# including Wireless Local Area Networks“))
> +# https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/MobilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf
>  country DE: DFS-ETSI
>         (2400 - 2483.5 @ 40), (100 mW)
>         (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> @@ -455,6 +461,10 @@ country DE: DFS-ETSI
>         (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
>         # short range devices (ETSI EN 300 440-1)
>         (5725 - 5875 @ 80), (25 mW)
> +       # WiFi 6E
> +       (5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> +       # WiFi 6E Short range (Outdoor allowed)
> +       (5945 - 6425 @ 160), (25 mW), AUTO-BW, wmmrule=ETSI

Unfortunately the kernel doesn't support multiple rules for a given
range with differing flags. Currently it is necessary to specify either
the indoor power limit with NO-OUTDOOR or the outdoor power limit, but
not both.

Thanks,
Seth
