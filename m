Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C840776780
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGZNbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 09:31:15 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:55392 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGZNbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 09:31:15 -0400
Received: from sven-edge.localnet (unknown [IPv6:2a00:1ca0:1480:f9fc:b107:d737:6945:7c05])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 85456201E6;
        Fri, 26 Jul 2019 13:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1564147871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmuVZ8PhNhaAu6sSvcWnefUtyY8ApcU1z9iN3OPbQYE=;
        b=mWosMJMS6FBnKuVvKQ2ovpkRFwQjH1fPKYfjNa6XPWdX21vQWk2iRFvKD0HT9mB5VL5Cew
        zsoM+AgZXgW7oBzwYDRNLj/JVVZG/dpMzTombnY+PT20pFmzIRVjIYHMoIkRp3ef5kQjTl
        X5qASqpLDuOoKZb36NuslCrEqbJzPj0=
From:   Sven Eckelmann <sven@narfation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Sven Eckelmann <seckelmann@datto.com>
Subject: Re: [PATCH 2/2] mac80211_hwsim: Register support for HE meshpoint
Date:   Fri, 26 Jul 2019 15:31:02 +0200
Message-ID: <3082836.hUm4yBdaKs@sven-edge>
In-Reply-To: <f2e16d10ce3eb3ff08c97c27424b824b8e012553.camel@sipsolutions.net>
References: <20190724163359.3507-1-sven@narfation.org> <20190724163359.3507-3-sven@narfation.org> <f2e16d10ce3eb3ff08c97c27424b824b8e012553.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17383225.By4h09HMEI"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1564147872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmuVZ8PhNhaAu6sSvcWnefUtyY8ApcU1z9iN3OPbQYE=;
        b=XFZrQmo5N8pzT53eM9N5usIOICSHX0qzLzUiEu4jd5OvtXIWNPPGiOgb2aDpL0Nx2oKvLI
        8k5viPHRtXlpvUHsY2IXK2GO/FNY1IyMMOAnS32rscujyaCeDB5/wmBCT57LCpNS2XMQwH
        d4uIrpKVDgxgbWx4vSsXXSO8XDvtuGI=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1564147872; a=rsa-sha256;
        cv=none;
        b=ychmm7k/uzpH+kbzmvesGsMKCKaDO2Gsvl4zFxe74b+TKH3K6kZLTev07yjaairK8u6xeq
        gSEMCf4Zmf7eHHb1//k9OsllPLPbZvfuEmQddH03M1I65LNoHrx/XU2IJd7TLNnGr3Qq8T
        cuStGXCpVn65TdLWtVApJ0WEvlJdpjo=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart17383225.By4h09HMEI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 26 July 2019 15:26:32 CEST Johannes Berg wrote:
> On Wed, 2019-07-24 at 18:33 +0200, Sven Eckelmann wrote:
> > From: Sven Eckelmann <seckelmann@datto.com>
> > 
> > Some features of 802.11ax without central organizing (AP) STA can also be
> > used in mesh mode. hwsim can be used to assist initial development of these
> > features without having access to HW.
> > 
> > Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
> 
> Even with the tshark workaround in place, this breaks 68 mesh-related
> tests in hwsim tests. Jouni says only 3 use tshark ...

As I already wrote:

> The first three things looks like wpa_supplicant problems. Seems to be 
> caused by the way HE forces VHT to be enabled and now the tests fail 
> which try to disable VHT. There was already a patch [0] for that but it
> wasn't considered a good solution.

> But beside these three things there are various other problems in 
> > wpa_supplicant regarding HE with pending patches. So I've used 
> wpa_supplicant 91b6eba7732354ed3dfe0aa9715dc4c0746e3336 with two 
> additional patches [1,2] and increased the VM memory to 1024 MB. Also 
> wireshark (tshark to be more precise) had to be updated to 
> v3.1.0rc0-1192-gf64990438c
[...]
> [0] https://patchwork.ozlabs.org/patch/1125305/
> [1] https://patchwork.ozlabs.org/patch/1125314/
> [2] https://patchwork.ozlabs.org/patch/1125322/

Kind regards,
        Sven
--nextPart17383225.By4h09HMEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl07AJYACgkQXYcKB8Em
e0Y0zhAAxIiho4RgmgU9uOKpUfa1P3m+O9tIrsmpjZMjS0ITvxsgH1ahDdnTzAoE
w5VEPvas/BUmh84AWG60UkkivZz1Vlwd0Ivr3nUazQhfj0cmv+Hwme/ttV7Z3Zwi
UWg3S8WogRO9wDtX/lepAPtPVxLLGQoyV+Z3E7MTqjQkiNo5LICguZiM5X8vVKxb
qZ8XqRz8xEdIaIF9tv9XmTJv3qsxC70MqO9Xlq6YTUXXIeQYKw7zRex+8DpGARjG
4WWdu3pUYErWln8vddixsTPH0nPHS9BPnYQqvEzTnF1X6ZcRVN17ev25OMv7ntx4
lvc4WDCD8mp70f3ITQXB/3yuUZO7CMaqKiJy1ruchu7Bw2KT5XDGN1MFg4r1KRan
3HtNqjT4bPNdeoeeyhxZ3hnerv5aQtxUY0Mus17fZ09z8D1cL49hJj3RN3LszwrH
UYmX66Efbrgpjo3z8lbqfaxa9aB3+agFhI1pq6pvdfxG3rp1oyJPGIk2pNY4ii9j
vxA269oZ7rwmn7iMaH20NVnK3GxLGRnvo2XzdE0RyYINS7MOfBNyG6P8n/lWJaXL
X6pNOinkkpc0J+OaFi6mxB7Ypq6n7NRvxjzj0zPdxCCG0wqyw0AxONnb6Ow9TXtC
qDs9LCGPpyBd5fEFoB3lMmWgsCuiA1abccd1ioUyZREKd/sjpAo=
=9JHr
-----END PGP SIGNATURE-----

--nextPart17383225.By4h09HMEI--



