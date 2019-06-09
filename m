Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC03ABBD
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2019 22:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfFIUJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jun 2019 16:09:11 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34338 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfFIUJL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jun 2019 16:09:11 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ha47g-0001Qp-U1; Sun, 09 Jun 2019 22:09:01 +0200
Message-ID: <107dc7707e6c9d0110aa5535bd5baf4f6db7f6a5.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/7] net/mac80211: move WEP handling to ARC4 library
 interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        linux-wireless@vger.kernel.org,
        "John W. Linville" <linville@tuxdriver.com>
Date:   Sun, 09 Jun 2019 22:08:59 +0200
In-Reply-To: <20190609115509.26260-3-ard.biesheuvel@linaro.org> (sfid-20190609_135516_576568_101D14AC)
References: <20190609115509.26260-1-ard.biesheuvel@linaro.org>
         <20190609115509.26260-3-ard.biesheuvel@linaro.org>
         (sfid-20190609_135516_576568_101D14AC)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ard,

In general, I have no objections to this.

However, with this

> -	select CRYPTO_ARC4
> +	select CRYPTO_LIB_ARC4

and this

>  	case WLAN_CIPHER_SUITE_WEP40:
>  	case WLAN_CIPHER_SUITE_TKIP:
>  	case WLAN_CIPHER_SUITE_WEP104:
> -		if (IS_ERR(local->wep_tx_tfm))
> -			return -EINVAL;
> -		break;

there's one quirk that I worry about. Does this mean WEP is now *always*
available/enabled?

I had to dig in history a bit, but vaguely remembered this commit:

commit 3473187d2459a078e00e5fac8aafc30af69c57fa
Author: John W. Linville <linville@tuxdriver.com>
Date:   Wed Jul 7 15:07:49 2010 -0400

    mac80211: remove wep dependency


Since you create the new CRYPTO_LIB_ARC4 in patch 1, I wonder if
something is broken? I can't really seem to figure out how WEP is
disallowed in FIPS mode to start with though.


(This also is the reason for all the code that removes WEP/TKIP from the
list of permitted cipher suites when ARC4 isn't available...)

johannes

