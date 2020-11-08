Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A32AADA4
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Nov 2020 22:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKHVTO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Nov 2020 16:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKHVTO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Nov 2020 16:19:14 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7AC0613CF
        for <linux-wireless@vger.kernel.org>; Sun,  8 Nov 2020 13:19:13 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id j12so7852726iow.0
        for <linux-wireless@vger.kernel.org>; Sun, 08 Nov 2020 13:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FTL4K2uKfmFgt0YIt6t+8iwXHzzz1n2qDDlir52Ho3g=;
        b=hnSpZfanvgERva3UeA7uxRDxGNep4FF2I5fgM1Rbb79vUxsaLmkuRKQEMs7o2WQgK0
         dxtxK9i0xAQsoG7Xq5LdYc0p2KLb2jXx8AX5A/Kgu5XUSUFxJ65S9vnmw1E0KSlRlKjg
         Ay4ju4N3NzYMtLCrTOcZ8spp0Vy30BzncdYaXb+E1ZfXTTlCI2HmULXX1WSSVqJUIDas
         0Y+q0VbpOlBswJXbiuPouVE4ZCVfp7ED6YDv7bc6EYLKvogUBAb/cu+R7nkzm2Fn44yJ
         SeJjZKfZio9C7Sa8ea7NXcdR5KMorbnsbmLL8Ny2VAQoWE36KU+c6zppq4uu2AvtyIFg
         vZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FTL4K2uKfmFgt0YIt6t+8iwXHzzz1n2qDDlir52Ho3g=;
        b=KHG0RQBg9tyg1Snv/4uXvXoHR8+Wzbe45eEaZ1j3Ro2ysmeA7U+WMXjcpJmXTSfUtE
         LPbnsccNNkByqRPxfpvObxh4TdQo6j2PLrZ4V+yN+QDjF8FxBsVhlThOEs+eVwdEt1W8
         ypB3a+7AdXq27vHVmHSqr1ksPjyLWuCKbQR+1Zc5Y5dStCZN/Gp0Mh2tAmtULuUFwftI
         mcjLthLTZ2pgZGK0mWy7ZX6GnipXSkLBd4b2YGaYZ0/dPvOulyqd6ml84YRpkIPjTg8k
         23Lf+kjw46WM3AYqrat6TPTObsp6BfuNI/od2+5vY3cso7oerUoIGFX8cO+TtH/yg2Jk
         rM0g==
X-Gm-Message-State: AOAM53178/l6vXfgNl1U2V4qb5KTTxSSFshJq87PR49lUpIB+Jy9HNsC
        0RIC3c/DNq6894xya8o+ySHejymWW0kkPh5TGWE=
X-Google-Smtp-Source: ABdhPJw8j13qoWNw37H8wz9pxwepzOVgaogj5MoC005X73oj3yMR12Z/wx9C20YyB9JHE3gL4aZVU1kVsAQvHHD4mPw=
X-Received: by 2002:a6b:5809:: with SMTP id m9mr7803044iob.186.1604870352484;
 Sun, 08 Nov 2020 13:19:12 -0800 (PST)
MIME-Version: 1.0
References: <CAPgWZqzskMUOnmdBwh6TEh5yfrbdzg+4bZOUMQPkJffWizZweg@mail.gmail.com>
In-Reply-To: <CAPgWZqzskMUOnmdBwh6TEh5yfrbdzg+4bZOUMQPkJffWizZweg@mail.gmail.com>
From:   Pavel Starosek <starosekpd@gmail.com>
Date:   Mon, 9 Nov 2020 03:19:01 +0600
Message-ID: <CAPgWZqx-bHc5iEn-fWbzarrUNB5kbMnay_Pr5BKROznOAO0nWQ@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Kazakhstan (KZ)
To:     seth.forshee@canonical.com
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Updates, based on [1] (search for word "RLAN" to jump to the desired
part on the page):

* Extended range 2400-2483.5
* 5150=E2=80=935250 MHz range may be up to 200 mW
* The same is about 5250 - 5350 MHz according to our local
regulations, but looks like this is incorrect because of TPC?
Therefore, I didn't change this value
* Add 5725-5850 MHz range for indoor usage
* Add 57-66 GHz range. It must be outdoors only, so we don't specify
NO-OUTDOOR at all, right?
* In 5470-5725 changed the bandwidth from 80 to 160 (typo?)
As I understand it, there is no DFS requirement for the 5725-5850
range anywhere in the [2] document.

I can suggest this change. Please check if everything is correct?
---
# [1] http://adilet.zan.kz/rus/docs/V1500010730
# [2] http://adilet.zan.kz/rus/docs/V1500010375
country KZ: DFS-ETSI
    (2400 - 2483.5 @ 40), (20)
    (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
    (5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
    (5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
    (5725 - 5850 @ 80), (20), NO-OUTDOOR
    (57000 - 66000 @ 2160), (40)

---
Thanks,
Pavel


On Mon, Nov 9, 2020 at 3:16 AM Pavel Starosek <starosekpd@gmail.com> wrote:
>
> Updates, based on [1] (search for word "RLAN" to jump to the desired part=
 on the page):
>
> * Extended range 2400-2483.5
> * 5150=E2=80=935250 MHz range may be up to 200 mW
> * The same is about 5250 - 5350 MHz according to our local regulations, b=
ut looks like this is incorrect because of TPC? Therefore, I didn't change =
this value
> * Add 5725-5850 MHz range for indoor usage
> * Add 57-66 GHz range. It must be outdoors only, so we don't specify NO-O=
UTDOOR at all, right?
> * In 5470-5725 changed the bandwidth from 80 to 160 (typo?)
> As I understand it, there is no DFS requirement for the 5725-5850 range a=
nywhere in the [2] document.
>
> I can suggest this change. Please check if everything is correct?
> ---
> # [1] http://adilet.zan.kz/rus/docs/V1500010730
> # [2] http://adilet.zan.kz/rus/docs/V1500010375
> country KZ: DFS-ETSI
>     (2400 - 2483.5 @ 40), (20)
>     (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
>     (5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
>     (5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
>     (5725 - 5850 @ 80), (20), NO-OUTDOOR
>     (57000 - 66000 @ 2160), (40)
>
> ---
> Thanks,
> Pavel
>
