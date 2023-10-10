Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3D7BFF12
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjJJOWg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 10:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjJJOWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 10:22:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D936191
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=plapjsWfysEH6LuEfPgV0TG2DznUyd7rnTYhfAMa0+M=;
        t=1696947751; x=1698157351; b=TrtplLSBs6aFoa9iLlg8tqa3RwocISoy5bJw8EzQOCcUH3r
        doKqULmsjdjpfR62+A6mZ+foxrjhI7Q9qusSaWco1zgEiYRGaY/fiZsuTwE94HoQCZaxVYqNHWhCV
        z83xl1R/5oibG5QQwbtDsjA+pk3/DztuTV6XhadpKbSfPgQ0DyygTi4B80v+EeUkEwtiNI40zHGwh
        jputpckDmAYMFbMsT2dhzfAii3Y5EOixQr2uOzRbdPHr0ymSy/MKBxe7rO4dOIwx9VNX2eTvlu/e9
        xPg63AuOPGyf6jNVDzJhOZGFyd7Ybsf6ppzvZOLgTgrd9aBEgGXIPMcsqkJmbfMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qqDcx-00000000RQ2-3yEp;
        Tue, 10 Oct 2023 16:22:28 +0200
Message-ID: <acdb4315780bde3481c44ba90fe341fea75a2929.camel@sipsolutions.net>
Subject: Re: mac80211 bugs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Dutton <james.dutton@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 10 Oct 2023 16:22:26 +0200
In-Reply-To: <CAAMvbhHo8wo924YVZqFrLKQko59iSiLMhVAzb=tdSvf_-v1CCQ@mail.gmail.com>
References: <CAAMvbhGsA4A9qHrYdXcNXLzv7a7xZZq98f90Q-Btb-9vs9ayCw@mail.gmail.com>
         <CAAMvbhHo8wo924YVZqFrLKQko59iSiLMhVAzb=tdSvf_-v1CCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-10-09 at 16:56 +0100, James Dutton wrote:
> /usr/src/linux/net/mac80211/sta_info.c:2424
>        case STA_STATS_RATE_TYPE_LEGACY: {
>                 struct ieee80211_supported_band *sband;
>                 u16 brate;
>                 unsigned int shift;
>                 int band =3D STA_STATS_GET(LEGACY_BAND, rate);
>                 int rate_idx =3D STA_STATS_GET(LEGACY_IDX, rate);
>=20
>                 sband =3D local->hw.wiphy->bands[band];
>=20
>                 if (WARN_ON_ONCE(!sband->bitrates))      <------It_crashe=
s_here
>                         break;
>=20
>                 brate =3D sband->bitrates[rate_idx].bitrate;
>                 if (rinfo->bw =3D=3D RATE_INFO_BW_5)
>                         shift =3D 2;
>                 else if (rinfo->bw =3D=3D RATE_INFO_BW_10)
>                         shift =3D 1;
>                 else
>                         shift =3D 0;
>                 rinfo->legacy =3D DIV_ROUND_UP(brate, 1 << shift);
>                 break;
>                 }
>=20
> Looking at this, it can be one of two things:
> 1) local->hw.wiphy->bands[band];    is NULL

Yes, I think that's it.

> 2) bands is an array of 6 items, making band valid for values 0-5.
> If band >=3D 6, it would cause problems.

Highly unlikely.

> So maybe something along these lines might help:
>=20
> Signed-off-by: James Courtier-Dutton <james.dutton@gmail.com>
> --- sta_info.c.org      2023-10-08 19:52:13.578270007 +0100
> +++ sta_info.c.new2     2023-10-08 19:52:09.450214070 +0100
> @@ -2420,7 +2420,26 @@
>                 int band =3D STA_STATS_GET(LEGACY_BAND, rate);
>                 int rate_idx =3D STA_STATS_GET(LEGACY_IDX, rate);
>=20
> +               if (band >=3D NUM_NL80211_BANDS) {
> +                       printk("ERROR: band=3D%d is too large.
> Returning\n", band);
> +                       break;
> +               }
> +
>                 sband =3D local->hw.wiphy->bands[band];
> +               if (!sband) {
> +                       printk("ERROR: sband NULL. Returning\n");
> +                       break;
> +               }


You'd really never want a plain printk, and anyway, that printk is
malformed (no severity string macro).


_Maybe_ change it to WARN_ON_ONCE(!sband || !sband->bitrates) there, but
really I think we should prevent this in the first place.


Is this, by any chance, a device without 2.4 GHz?

johannes
