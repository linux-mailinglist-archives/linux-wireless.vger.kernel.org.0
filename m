Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507A079E35C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 11:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjIMJSB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjIMJSA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 05:18:00 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9713173E
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:17:56 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 452533F66E
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694596674;
        bh=YOII/3O27Az9SG2nD11VPnmQx6Ck7v8vZGr+bu9t/Fo=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=pNXz/L978JBalcwDhhGPEvmdAWqU0CDdr75fVxopHtH/wOaOE4D+GzlBVMLpBIujJ
         nf6BNc4+WN77RHT5f5Wfopszx1Iiuqga8K32zf4bGpaE59NTrSnc6HaxlEijlUGhdz
         SZq9n3aTZ8M4ZMbWUGE75ba2pZHwU8eCorauFiZKr+kNZJQc0h1SIfuoCCum8mtdHR
         NXv95din96jo/1QVnms1DXB7zlTy/18bZm7v5CS/M/B48/rQ+4CVGPpsZ7yqXcdmxC
         88cl4aOjNZkpw8LCPM4OEXAtXxUiCaa2+OlGzaV/tamAIKoGlv7IcyfWr/2wKSKvFl
         BuFdaKwcDntCg==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31facb07f53so292046f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 02:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694596673; x=1695201473;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOII/3O27Az9SG2nD11VPnmQx6Ck7v8vZGr+bu9t/Fo=;
        b=Lz8NdWrzlpUpw52BeqQ8uMmk09C1ZDGHvpaZfw4f6RQZxFTnvm/DuXF95gPr8hQOZF
         FqMoI7lOq/6Ug+t6CooVhoDom1QYDVFQYkosoGv5u7z7MmCjGpx3Gril+kEqFChQ1Cdf
         UDNbxGikCUCprx79hephWuNYQq43PkeUpZ9qKUFpBElRPUSFTqQ4i1gNIkcv5k5uGW0l
         shW6QKiKgvWnBNgDxemv6h5fXNTyp4fGDg9t2N8NPOar3KBZ4w1VeRGqmrRgecwfOZ5p
         l05z8nkJONRslpf2gMqAjYyPlxcuWbykIjsZLvD7ZItUGANFdCbLWj9DPimdBLNKAs+J
         Ay+A==
X-Gm-Message-State: AOJu0Yx/Mt+ml70PuOsHw2FCqAQdZcpuQa9xDvovMrh4tZ4DANs/xDte
        LSl7vMsdAnC5w0i5dwG9O9TFueYo8loX1101zFSpCP+z2EAri6erHwXkv3YRXPqfK2qlRj4kuuh
        STaWZGSUcIl+7k9h+/bu5tA8tmw983GHgnG0wJzmshJkDo0cUR5ldECU=
X-Received: by 2002:a5d:526f:0:b0:314:1096:6437 with SMTP id l15-20020a5d526f000000b0031410966437mr1551483wrc.19.1694596673126;
        Wed, 13 Sep 2023 02:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzZpbc5eKZXXiI/rQ4cz9Po8Dhm8unDuLJ1pm1qT0dvDqRwRkliciQI48iSOie4UN/NJ49IQ==
X-Received: by 2002:a5d:526f:0:b0:314:1096:6437 with SMTP id l15-20020a5d526f000000b0031410966437mr1551467wrc.19.1694596672814;
        Wed, 13 Sep 2023 02:17:52 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b003179b3fd837sm14942590wrs.33.2023.09.13.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:17:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 11:17:47 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, marcan@marcan.st, keescook@chromium.org,
        gustavoars@kernel.org, hdegoede@redhat.com,
        ryohei.kondo@cypress.com
Subject: Re: [PATCH] wifi: brcmfmac: Replace 1-element arrays with flexible
 arrays
Message-ID: <20230913111747.35839fd8@gollum>
In-Reply-To: <87msxqlaao.fsf@kernel.org>
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
        <87msxqlaao.fsf@kernel.org>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Cu_SgLCiae9uFjwQIJE6=+Z";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/Cu_SgLCiae9uFjwQIJE6=+Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sep 2023 11:58:07 +0300
Kalle Valo <kvalo@kernel.org> wrote:

> Juerg Haefliger <juerg.haefliger@canonical.com> writes:
>=20
> > Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
> > UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> > 'element' and 'channel_list' will trigger warnings, so make them proper
> > flexible arrays.
> >
> > False positive warnings were:
> >
> >   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brc=
m80211/brcmfmac/cfg80211.c:6984:20
> >   index 1 is out of range for type '__le32 [1]'
> >
> >   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brc=
m80211/brcmfmac/cfg80211.c:1126:27
> >   index 1 is out of range for type '__le16 [1]'
> >
> > for these lines of code:
> >
> >   6884  ch.chspec =3D (u16)le32_to_cpu(list->element[i]);
> >
> >   1126  params_le->channel_list[i] =3D cpu_to_le16(chanspec);
> >
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com> =20
>=20
> Should this be queued for v6.6?

I would think so. It's a problem since 6.5. Which reminds me that I should
have added:

Cc: stable@vger.kernel.org # 6.5+

...Juerg



--Sig_/Cu_SgLCiae9uFjwQIJE6=+Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmUBfjsACgkQD9OLCQum
Qrcu2g//VfE5J5Fsa8NX7kn7uJX0G9v1OLJIRJ/A9HYWNJ9CWWp0coKnWy0rdrWm
kJYut2/zOC/sjvKaXLIfSIRvmpL/4jl6/9Uesacah+7bfBszcYbNGStwa5sGx1zf
ntzc9RM0vRoYZYHfYyEootuzqQZ9ZSr2OZkCBnHe1KnAKz1NkoUOag+l6l76HMI+
XjtpXC5EHOmGCyWebWBUOv3SQl8g81bKKu+DwtW2zsKYpuJcYcQv9Y0GZgl0Bu6u
rrKXTGyZpyrQ4H9lqI0LP1GAwpbuinYgW0Xft6MUkVgQUS3qDhOBJCa1Nfb5xS0v
wMNH8KNZNT4vREH3LKOlRP/SdtP4lPH4udoONveHfGLXt+VXlgq02jRr/Jxj6ICM
dkIpY54ND8+I+psaH5Oi8s3qhcSzY8xuwJeZzQRh+wh7X8h8aj67N9hv6tQZkDEe
3WQmb3slanRnMGSgJhCkp3M1IrR38nNBgQe6nb9UagiWXW6l1kar5sQ+uQkPAgZz
Z3AE0rQt0SV2EHfyWGkwUSSTVKAP7mSb3jsVr+3UExOTLnNq1GsPr+dJ8oG3baHL
UDe3xw2TrXv+cSOUKuWqef3/C6xeqM7Jjz2fyYwKP+hjr5smf5QMzfdGif4Nv9x5
cmID/ABkY+GOGkFNE+68Qr+DOy/3CglizPfsB7ESqVdJFgLa1rU=
=Yn1Y
-----END PGP SIGNATURE-----

--Sig_/Cu_SgLCiae9uFjwQIJE6=+Z--
