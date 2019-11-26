Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE151099EB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 09:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKZIEY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 03:04:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41885 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725372AbfKZIEY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 03:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574755463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0QjVXdu4Y2AOINMSIfcze5ED2P1CMqFasZGrM6CNSw=;
        b=AP3k+6NLkDL9G4rGedrJnCL7yiPNqprOccmxdyTfQyDX1WEmIa7HnZ+VfOsuCc4rbZRPJG
        QWdKa1LZ+lyTIPpn0sUS5X51MfGsKxJZWit4Oxn6wM2ww8AoEoBQzPWld5+EuOBYikJTDt
        RTvm+FPiC7/VKiZyZJB+9/vbHyQNV50=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-BuhvMGeON8apeqH4PfA9pQ-1; Tue, 26 Nov 2019 03:04:19 -0500
Received: by mail-lj1-f199.google.com with SMTP id u6so3505184ljg.8
        for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2019 00:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xAdyr+rwPBLDYub0Hn/ky8FJbrCeMk6nQjNxbDanCII=;
        b=Ti7fLH7NN7IneAaS1vmK5voMUdPtXdwKFWTb0U+g+I/BHRa8GCYZO2PphdjGZaKB3O
         rahIiM+tPru1jxONa0ymlev6NlG1hVOgyKl0rTRlHn8wggLwXU7Oz+KskCCaADuIM2Z2
         1Eu41ND5xu2i6mUIbKmY2IUGowHEIEsRda1nn2WQMOd97+Ykx5GXjRFugSHyQa6lv/ED
         S8yxImnV3G1n8zGSNd1HmwfNfxquYKj3xRxQ7FEX32GHCTTOYYS2ElxIYO4vfNSFzwuV
         xbgz5UFWGW7lMWT3MCzoyXB405JH/718lfuPf0Fb1Zx370ex2+DMMVwyAxAs+oXPeBsc
         TZWg==
X-Gm-Message-State: APjAAAXVUuhXDSQ0df2JERS6UMINanunykicl/8z6QqIMG16JEr/J1Ey
        5yZ3QrxcsHTK57ax03fFnjBWwuBivBl6og32tjXz6KtV5vseQZRQWxH1xNelHBkQllvzQNVp0lY
        FTL0JIgCsLh3qTfghqX+TVLJsT2Y=
X-Received: by 2002:ac2:4553:: with SMTP id j19mr24471009lfm.142.1574755458173;
        Tue, 26 Nov 2019 00:04:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqw32eL/XdPUwR/CzkaxG5SqjRG2kkpXaZKBrJPo2BO5WZZmA6tdOKC/JAyRfetBu+oBmdQytA==
X-Received: by 2002:ac2:4553:: with SMTP id j19mr24470996lfm.142.1574755458008;
        Tue, 26 Nov 2019 00:04:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n14sm4744577lfe.40.2019.11.26.00.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 00:04:17 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5460B1818BF; Tue, 26 Nov 2019 09:04:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mt76: Off by one in mt76_calc_rx_airtime()
In-Reply-To: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain>
References: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Nov 2019 09:04:15 +0100
Message-ID: <87v9r7ysg0.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: BuhvMGeON8apeqH4PfA9pQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> The sband->bitrates[] array has "sband->n_bitrates" elements so this
> check needs to be >=3D instead of > or we could read beyond the end of th=
e
> array.
>
> These values come from when we call mt76_register_device():
>
> =09ret =3D mt76_register_device(&dev->mt76, true, mt7603_rates,
> =09=09=09=09   ARRAY_SIZE(mt7603_rates));
>
> Here sband->bitrates[] is mt7603_rates[] and ->n_bitrates is the
> ARRAY_SIZE()
>
> Fixes: 5ce09c1a7907 ("mt76: track rx airtime for airtime fairness and sur=
vey")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/wireless/mediatek/mt76/airtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/airtime.c b/drivers/net/w=
ireless/mediatek/mt76/airtime.c
> index 55116f395f9a..a4a785467748 100644
> --- a/drivers/net/wireless/mediatek/mt76/airtime.c
> +++ b/drivers/net/wireless/mediatek/mt76/airtime.c
> @@ -242,7 +242,7 @@ u32 mt76_calc_rx_airtime(struct mt76_dev *dev, struct=
 mt76_rx_status *status,
>  =09=09=09return 0;
> =20
>  =09=09sband =3D dev->hw->wiphy->bands[status->band];
> -=09=09if (!sband || status->rate_idx > sband->n_bitrates)
> +=09=09if (!sband || status->rate_idx >=3D sband->n_bitrates)
>  =09=09=09return 0;
> =20
>  =09=09rate =3D &sband->bitrates[status->rate_idx];

This code has recently been ported to mac80211 (net/mac80211/airtime.c).
It seems that the bug is also present there; care to send a patch for
that as well? :)

-Toke

