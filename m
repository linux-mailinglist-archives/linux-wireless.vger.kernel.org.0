Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1B46CFD3
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhLHJQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 04:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhLHJQk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 04:16:40 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC2C061746
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 01:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1638954786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0njKFutL1mNnPmBb/c5W3lzOUqpWwin7MxzB9u0Mo4=;
        b=11pFjxvB/S54mDbTxMZoK7IyGKWIESWX+sWs9W7oZCc8b0E5sUql+/KV+vtI66FFY9UPPm
        6jU5zu+/WV6xskbK+l3ymNeETehWB7VE/2bSJKvl46YQI/B/T9w7nVrC8ZbMtMlBhuL1XM
        NTkHnY4ICRd2zUF02pew1Hbxcxsfyi4=
From:   Sven Eckelmann <sven@narfation.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Wen Gong <quic_wgong@quicinc.com>
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
Date:   Wed, 08 Dec 2021 10:12:59 +0100
Message-ID: <2239044.ZpX2dJDJjJ@ripper>
In-Reply-To: <463b4075-e98f-d51a-d305-a7adadc8a585@quicinc.com>
References: <20211129101309.2931-1-quic_wgong@quicinc.com> <163895135713.29041.4980786229647025244.kvalo@kernel.org> <463b4075-e98f-d51a-d305-a7adadc8a585@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3702762.AusovfAdrM"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3702762.AusovfAdrM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
Date: Wed, 08 Dec 2021 10:12:59 +0100
Message-ID: <2239044.ZpX2dJDJjJ@ripper>
In-Reply-To: <463b4075-e98f-d51a-d305-a7adadc8a585@quicinc.com>
References: <20211129101309.2931-1-quic_wgong@quicinc.com> <163895135713.29041.4980786229647025244.kvalo@kernel.org> <463b4075-e98f-d51a-d305-a7adadc8a585@quicinc.com>

On Wednesday, 8 December 2021 09:19:28 CET Wen Gong wrote:
> On 12/8/2021 4:16 PM, Kalle Valo wrote:
> > Wen Gong <quic_wgong@quicinc.com> wrote:
> ...
> > Sven, after your memory corruption fix is this good to take?
> 
> After Sven's fix "ath11k: Fix buffer overflow when scanning with 
> extraie", it will not happen kernel crash.
> 
> But it need Sven's confirm.

Correct, it is not causing any problems anymore when the other fix was applied 
before this change.

Tested-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart3702762.AusovfAdrM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGwdxwACgkQXYcKB8Em
e0YiDhAAxzkugENCxrewJCQBwH31n1fvJArR1vppfDspDwd04c/ag9YHYpsklBaA
9EAXyiEstysVer85Arvulolk881OFUf3yd7LY2tSYswmTMdyYEHUt7K+FsnuduVp
ddEb6POPaZZzK0eB86gR4WyorN14i8MPmZdb/swM2foI7h9TbCzcmjpvnSGIXAbH
jWpbq6GC4yhc2uJSH2zyiDjhOw+9pFP2G++RumWEnenqgFmrNsDrYBncNfmn/Tnh
nVNLhmo8XotWrsAUdwri2Me8Ch7+lCawHFCr4NY48juvKCY2ZbxjRGvGTMHiAo+e
flBEhHokiabT6HZoIIAKvlnnIt2JHTg2XfBYf/h4sHiWnr/4Ow4SF/xfSia3UHyM
LF/6KzIaMF6RbbsFRjy0GTBLFSruth0glp2yoFaHN4S3pLI9EraJJMcgLf9M1zFm
PE2dJlnfUyGoCnh9t2z/Adh51PnJI6RRo8IFtauGqkaZkReYr58KB7WwCYM8Qle3
0GTkl0MbS8La71l7O1Aad8NaM3qsNZNwAbCg2uhedeIrgZchZfq9WFZeXOcNncFs
dzUTRGk9Znv12piiA/hv0qNxEadOOVyOR4SVipfhbypL+Ut1jODY5FdZOB4Tx5Ac
Eev6DA2urQlSbk3Z/DOcbVEfM5cq3oCIiy/rqK1AEweMY/XPmL0=
=RIgu
-----END PGP SIGNATURE-----

--nextPart3702762.AusovfAdrM--



