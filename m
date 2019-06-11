Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831B33C508
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 09:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404174AbfFKH2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 03:28:53 -0400
Received: from durin.narfation.org ([79.140.41.39]:51930 "EHLO
        durin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404116AbfFKH2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 03:28:53 -0400
Received: from bentobox.localnet (p200300C5970379EE63D29F25F26A7ADB.dip0.t-ipconnect.de [IPv6:2003:c5:9703:79ee:63d2:9f25:f26a:7adb])
        by durin.narfation.org (Postfix) with ESMTPSA id 5FF061100D3;
        Tue, 11 Jun 2019 09:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560238130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxINlGTTVUm4XF9ICyey9Lawgcbb29Z7d0RixPHFerM=;
        b=uawrMKDecqdMTXI3lSDPlLlp0t7jW2GrC68lm54J/X4yHORL7ojajaiycloNj5RzQYAPH/
        3vHjIStiXRvc6PShThIoATr/CaiJWtAofRXPqlSexT3CAyQbbpUP3Nph0htixH8bWkZlwk
        z5JDElLtrlgJu6ffTGaI3tlgOUi8iKI=
From:   Sven Eckelmann <sven@narfation.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        royluo@google.com
Subject: Re: [PATCH 1/2] mt76: mt7615: init per-channel target power
Date:   Tue, 11 Jun 2019 09:28:43 +0200
Message-ID: <3556594.76tU91ddA5@bentobox>
In-Reply-To: <ade300b855949dcbe0a278e363415bd56b2e1299.1560234877.git.lorenzo@kernel.org>
References: <cover.1560234876.git.lorenzo@kernel.org> <ade300b855949dcbe0a278e363415bd56b2e1299.1560234877.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4288889.7eYuho7uyT"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560238130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxINlGTTVUm4XF9ICyey9Lawgcbb29Z7d0RixPHFerM=;
        b=ACKjvV2AiQOOy0NuikmM76nO4hXLX7kXZoTBYbD+YuC4DPxy+UtMvS9ezYhwhAdHp2JDI0
        rMEkVl0teCJ/O3adnYR/1sQ/Rsi93DoVTGKrWelJmmuLKZ2nFFNQJmXLhHHVIzGP3/qSL8
        aO07olZN8im9J7Qqkxx/JN2gyd4JBg4=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1560238130; a=rsa-sha256;
        cv=none;
        b=CXGkS/Xmy1gAc72BUhURq7UHfEqQUs+WyChrJ7/GHzg4vuXibFo7SDSS9xLxlZsmd5jk9b
        4xjlFj9cypFewQO/HBh5Gp0XYbJGowAXEOwKkgt6SvXdBkoRk22m7kVkMP7k1FEQncC1PM
        jRZnDGoZH6ZKr2Os6pXWtQbP6BLgf5k=
ARC-Authentication-Results: i=1;
        durin.narfation.org;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4288889.7eYuho7uyT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 11 June 2019 08:38:52 CEST Lorenzo Bianconi wrote:
> +               switch (n_chains) {
> +               case 4:
> +                       target_power += 6;
> +                       break;
> +               case 3:
> +                       target_power += 4;
> +                       break;
> +               case 2:
> +                       target_power += 3;
> +                       break;
> +               default:
> +                       break;
> +               }

Any reason why you use different value for 3 chains than ath9k? Following 
values are used in ath9k:

* 1 chain: 0 dB
* 2 chains: 3 dB (max combined gain ~3.010299956639812 dB)
* 3 chains: 5 dB (max combined gain ~4.771212547196624 dB)
* 4 chains: not supported (max combined gain 6.020599913279624 dB)

Here are the definitions from ath9k (values are saved in .5 dB steps)

    drivers/net/wireless/ath/ath9k/eeprom.h:#define POWER_CORRECTION_FOR_TWO_CHAIN          6  /* 10*log10(2)*2 */
    drivers/net/wireless/ath/ath9k/eeprom.h:#define POWER_CORRECTION_FOR_THREE_CHAIN        10 /* 10*log10(3)*2 */

Kind regards,
	Sven

--nextPart4288889.7eYuho7uyT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlz/WCsACgkQXYcKB8Em
e0b5uRAA2YW58CTMI33MJsZp2S3xzAn+ZSEYJYG31MWAhTviWR0Lrz6+7HGhB2Fk
6WVtBQvbHHTqfy376ipgFZJAHtnR48YefVdpVMEQvjNLAoxQiltLzN9Q3OD5Kh7l
MqAgCbG5lZmLbQwAmzF+OKYPdjHu1wzBn8V189YVjC1zyPOqt4t6xSir5ox4DEVZ
Iu1KP87Ae8Cy6GWlsP9yJSp9Ny2kgjwyWQHodHX5YnPmjWamW+4w7F1cVJsfrAOJ
gEqDXwdIvUxSiwUVMXb12TRKy8V+C6svh4zBCfQUY08CjECwCuR/9r9mouys/60u
XUeqsh6pxcBkxgz8UntpWbUD1GdyZwWa7F+U9N9uHGeIhypNI0hgX3dvXmMHk8zV
nFn8s086DtG4QUxFbsQH6qyRdau4fD/cgFA1LvO2oaxIJR3gfjmDBew4gaEO2sij
O2SWd/jbSVp3f+F6nWbML+pc+QyACUYua2B70zX5hGDGjpsvOjs3lWNA6jAPmU/7
I5a8oBeqhwn7zPIzgdA2Tg54T93HemTz1ZAguh59Y3Z8wQVPArAo8NVeNaZDmj1A
pdJ+WyFuJwdjjAv5yHsz9B4qM6pyEIJJjZ9xvKeQRmBoOE6ABpsgv3BOS5uBnBYf
R7t0hxA8gf1yAoeTJmDx6Q8FiCQqjdBGE3inKp9sct8OaAjlDRU=
=9asb
-----END PGP SIGNATURE-----

--nextPart4288889.7eYuho7uyT--



