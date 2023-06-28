Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2F740B60
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjF1I1I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 04:27:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:23422 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234027AbjF1IZA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 04:25:00 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-128-vlZ0-3KkNdaZvqYiTvu37Q-1; Wed, 28 Jun 2023 09:24:56 +0100
X-MC-Unique: vlZ0-3KkNdaZvqYiTvu37Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 28 Jun
 2023 09:24:55 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 28 Jun 2023 09:24:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dmitry Antipov' <dmantipov@yandex.ru>,
        Larry Finger <Larry.Finger@lwfinger.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle Valo" <kvalo@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] [v2] wifi: b43: fix cordic arithmetic
Thread-Topic: [PATCH] [v2] wifi: b43: fix cordic arithmetic
Thread-Index: AQHZqQsGGmQjvdKBv0W33H1tLjOZ1K+f3QLw
Date:   Wed, 28 Jun 2023 08:24:55 +0000
Message-ID: <d0825edd2a3c4bbba72685340f547c9e@AcuMS.aculab.com>
References: <ef4750f8-8de5-dbfc-2c0b-3400d30d83e5@lwfinger.net>
 <20230627151411.92749-1-dmantipov@yandex.ru>
In-Reply-To: <20230627151411.92749-1-dmantipov@yandex.ru>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dmitry Antipov
> Sent: 27 June 2023 16:14
> 
> In 'lpphy_start_tx_tone()', 'CORDIC_FLOAT((sample.i * max) & 0xFF)'
> is invalid because it is (<32-bit> & 0xff) shifted right by 15 bits
> and so always evaluates to zero. Looking through brcmsmac's
> 'wlc_lcnphy_start_tx_tone()', the result should be masked instead,
> i. e. 'CORDIC_FLOAT(sample[i].max) & 0xFF'.
> 
> Fixes: 6f98e62a9f1b ("b43: update cordic code to match current specs")
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: add Cc: stable and Fixes: (Larry Finger)
> ---
>  drivers/net/wireless/broadcom/b43/phy_lp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/b43/phy_lp.c b/drivers/net/wireless/broadcom/b43/phy_lp.c
> index 0e5c076e7544..e8ef04e509aa 100644
> --- a/drivers/net/wireless/broadcom/b43/phy_lp.c
> +++ b/drivers/net/wireless/broadcom/b43/phy_lp.c
> @@ -1788,8 +1788,8 @@ static void lpphy_start_tx_tone(struct b43_wldev *dev, s32 freq, u16 max)
>  	for (i = 0; i < samples; i++) {
>  		sample = cordic_calc_iq(CORDIC_FIXED(theta));
>  		theta += rotation;
> -		buf[i] = CORDIC_FLOAT((sample.i * max) & 0xFF) << 8;
> -		buf[i] |= CORDIC_FLOAT((sample.q * max) & 0xFF);
> +		buf[i] = (u16)((CORDIC_FLOAT(sample.i * max) & 0xFF) << 8);
> +		buf[i] |= (u16)(CORDIC_FLOAT(sample.q * max) & 0xFF);

What are the (u16) casts for?
This code is actually called exactly once with max == 100.
The .i and .q are the sine and cosine << 16 (signed).
The CORDIC_FLOAT() is basically >> 16 (not 15) so the result should
be between -100 and +100.
The & 0xFF is there to strip the sign.
The sin+cos are then packed into a short[] then unpacked to be
written to the hardware later.

>  	}
> 
>  	b43_lptab_write_bulk(dev, B43_LPTAB16(5, 0), samples, buf);

Don't open the bag of worms that contains the above :-)

	David

> --
> 2.41.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

