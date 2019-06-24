Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D53A9517B2
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2019 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfFXPwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jun 2019 11:52:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35059 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbfFXPwj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jun 2019 11:52:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id f15so4588520wrp.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2019 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2SzhPdKiqQfA31m+tsox9YXy9SVhIUHXbrtgpGgp0go=;
        b=tJnRRv1APPc57OIwY8kRyYxNnxjqREtL58x6zvcP7mr4i679Uyn7lRCvsZ0ctfiFSr
         vWTgBJvcFj5GTtpGFdeyC3lRz+sLpyYQhXeU1BvYSJXAnFfiGbsI3QXwWBRJtquvEATC
         2M80wLzFCjq2bLtQLK6+7v/42tiz1PAYK9hjiJ5N4rNu43hxvm9k+82rCy59xWYVOo6Q
         O30AXnYkl9HG1hIZYIlzgK79Pp05STwygobCUeMExtgx2p9dDRLp7OXz+njonCnOejfG
         TW5SP4RFaPaOesGHGUhEGwdgUa6ndkoDzrElDAZeR8JWN3hBK8FAZT6Uv04Klq5dDzPK
         sxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2SzhPdKiqQfA31m+tsox9YXy9SVhIUHXbrtgpGgp0go=;
        b=Za9CyJqUMHOobci9bmhiX/I5e4sVfOftdWABEN1pip4t4VKjmTge12ayvR0VcOTM6Q
         8Jthvb2PbIaOBRF8Wrd2JByxAMhnS29+tPK6T7QTCiOKMkgdrmBoJXZAZTeFiKwb1jof
         rudD+dsEFev5OMyvWLnqyBu9+dqOy/SB+S+VAkgYVou3AdXDib/BXQPBZEMNj0oE5dDu
         bXnQD63b6oTwTRxRG86djmm8uJsYRwd0FRlMNqk5/jAQwmlFNElTcafRoDSSzS1cEzEP
         isxyt5+r+T0xI4VcTMvnHuYK9Ee6eUEoUliz2UQadB6eoWBPle8LfkTnPu5iuQuby1Cs
         10sw==
X-Gm-Message-State: APjAAAVdcCUSw9KSq1UhduDa4yy5dCtdsUJ1s1pVVJy0kYgK6qkw0LAy
        ZADWOObt50GOB5BllXPH4oHS/zM0szk=
X-Google-Smtp-Source: APXvYqyn6ht/xCNWMqSMLxVPMrorPpKFoXQi0lRY+V3cLmOabE1OEZYkwF/k9qpRRrzMfzwl1DHJJw==
X-Received: by 2002:adf:e705:: with SMTP id c5mr83128220wrm.270.1561391145877;
        Mon, 24 Jun 2019 08:45:45 -0700 (PDT)
Received: from [172.16.20.20] ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id y2sm9989929wrl.4.2019.06.24.08.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:45:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND] brcmfmac support for BCM4359 sdio on arm64 ??
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
Date:   Mon, 24 Jun 2019 19:45:41 +0400
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <30516339-BAD7-40F4-980B-D30CDF504A08@gmail.com>
References: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
 <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11 Jun 2019, at 1:45 pm, Arend Van Spriel =
<arend.vanspriel@broadcom.com> wrote:
>=20
> The splat could be relevant. Maybe try the patch below to get actual =
values that are checked in the WARN_ON.
>=20
>> BCMDHD is also reported working with commits here: =
https://gitlab.com/baylibre/amlogic/atv/linux/commits/narmstrong/v5.1/aml/=
integ-5.1-bcmdhd but LibreELEC needs to support many different boards =
(with many different SDIO modules) from a single OS image, so BCMDHD is =
not the solution we need.
>> One additional patch I spotted mentioning BCM4359 (also from Wright =
Feng) was =
https://github.com/RobertCNelson/ti-linux-kernel-dev/blob/65f17112e1c883d3=
c9f3fa68837e5f9b5eb7cfad/patches/cypress/v4.14.52-2018_0928/cypress-patch/=
0073-non-upstream-reset-two-D11-cores-if-chip-has-two-D11.patch but it =
makes no difference (the dmesg log above is with this patch applied).
>> I don=E2=80=99t write code but am happy to build test kernels with =
suggested patches or explicit instructions. I=E2=80=99ve also CC=E2=80=99d=
 LibreELEC colleague and linux-amlogic maintainer Neil Armstrong who can =
assist. NB: If direct access to hardware would help progress things I =
can easily organise remote access or get board samples shipped.
>> How can we resume the investigation?
>=20
> Let's try one step at a time ;-)
>=20
> Regards,
> Arend
> ---
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c =
b/driver
> index fc12598..e9b0986 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -772,7 +772,8 @@ void brcmf_sdiod_sgtable_alloc(struct =
brcmf_sdio_dev *sdiod
>                      sdiodev->settings->bus.sdio.txglomsz);
>        nents +=3D (nents >> 4) + 1;
>=20
> -       WARN_ON(nents > sdiodev->max_segment_count);
> +       WARN(nents > sdiodev->max_segment_count, "max_seg_cnt=3D%u, =
host_max_seg=3D
> +            sdiodev->max_segment_count, host->max_segs, nents);
>=20
>        brcmf_dbg(TRACE, "nents=3D%d\n", nents);
>        err =3D sg_alloc_table(&sdiodev->sgtable, nents, GFP_KERNEL);
> q

^ this patch is mangled - please send me the correct one so I can reply =
with information to move things forwards. Thanks.

Christian=
