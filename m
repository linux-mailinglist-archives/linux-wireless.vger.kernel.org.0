Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E1D79BF27
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 02:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbjIKVsL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 17:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjIKKLr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 06:11:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2F6E69
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qM4AdokdjuImYUjVPIALg1u5+PANRAjIPasJwFe/akM=;
        t=1694427102; x=1695636702; b=Ex5ByyUw61BBoGsEFV1Zg9Hx3yjxWIwdtMVQ9wemiYIxFWy
        Um9gyPFfdzk6j3g3ODsk9wkjtL4FItVzv3esDFIinSCBpHLrIrtk7ecrGsAZmmgRPFCgEuBNWoAWb
        CxR0V4nOm88t4T8eAe2E7ghJ/Et0t7Ng9iGE/S0BSt92sHtNSWYwu4AbRV0iRlPDSitRU8gWM54Xd
        cl8Fe1kKpSCQ9vZd0b/IDfqLMA1Oze2Bt8lQ6As+yaDiYoZAuV+p/+Wlrm8BH0K7420fYaEuY+kww
        rnmm/bYy8oOkkmxVwGSEYAg7SjT5LuGF99HZi4ZtMp2Bucs4FRgXRYTsZZrq7Beg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qfdtL-00ALRC-2x;
        Mon, 11 Sep 2023 12:11:40 +0200
Message-ID: <3fe90164dc6fe7471523de1d3a234c88c0e43e46.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: cfg80211: avoid extra calls to strlen() in
 ieee80211_bss()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 11 Sep 2023 12:11:37 +0200
In-Reply-To: <20230830043346.28303-1-dmantipov@yandex.ru>
References: <20230830043346.28303-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-08-30 at 07:33 +0300, Dmitry Antipov wrote:
> Since 'sprintf()' returns the number of characters emitted, an
> extra calls to 'strlen()' in 'ieee80211_bss()' may be dropped.

This should probably mention wext/"wireless extensions" somewhere - I
got confused at first why we even had strlen() :-)

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/wireless/scan.c | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
>=20
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index 0cf1ce7b6934..4f4990ca7ba7 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -3422,59 +3422,58 @@ ieee80211_bss(struct wiphy *wiphy, struct iw_requ=
est_info *info,
>  			cfg =3D (u8 *)ie + 2;
>  			memset(&iwe, 0, sizeof(iwe));
>  			iwe.cmd =3D IWEVCUSTOM;
> -			sprintf(buf, "Mesh Network Path Selection Protocol ID: "
> -				"0x%02X", cfg[0]);
> -			iwe.u.data.length =3D strlen(buf);
> +			iwe.u.data.length =3D sprintf(buf, "Mesh Network Path "
> +						    "Selection Protocol ID: "
> +						    "0x%02X", cfg[0]);

I don't think we should make this worse and break the strings in _more_
places ... it's OK to go above 80 columns for strings.

So probably better written as

sprintf(buf,
        "....",
        ...);

here and in all the other places too.

johannes
