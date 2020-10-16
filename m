Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B024228FC2F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Oct 2020 03:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbgJPBEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 21:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgJPBEd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 21:04:33 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B496C061755
        for <linux-wireless@vger.kernel.org>; Thu, 15 Oct 2020 18:04:33 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z2so864653lfr.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Oct 2020 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cWLcvgRHCQdlC5HKIAZhx48ho8BZ0djIP0nz2utcEXI=;
        b=d6gs8eEgXnPgKObab+mhRs0FJniuh/EvHC4kcPD8b51kCsBsPDF0nC+P89o3dFvioO
         iQRmkrwhbm/40lLcsfaQD9Z8Rz+KryRawmwrjekYpYzJdyqpTvpzVd0AtYEzugDSFEGr
         bERNGtkxeXFEx0n4vEBB5gPVkuYAjrbln87StxEAIlAwP6B3VWWUmtsMbjnmg2DwJgcK
         FE5LBkjzsKHM2v/B89JIRTxpc202F22HbNRHMh4DFpSo13sLME06Mp2egtJR3yupLFUe
         Dcd+JZggfMJvdaooE1Vvnd3Um/jPRfUGI4AzZk9Z1hnBBz01P+UN28LeSCnCpf92g8JG
         64UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cWLcvgRHCQdlC5HKIAZhx48ho8BZ0djIP0nz2utcEXI=;
        b=ZgY2YrBECn3d1EOdxU9EDbYa33THsB+mDd+fJOBhFUrWrhNm1z8L1wU/63K4uwtB2O
         am/nvquC6n18Jvohn1M/ryvErY2bzA6qUoWe6CtwALE1RfSLv4lonowqgt3c98OZHwUT
         Gk1Y5XY33DnIWKP14YJEwjGffV632kOVej8KuIrYWFSHYL8F8Bq+i5fq6j5LZtkAHvny
         j/ndEFNdHONZBPRj9aMbtqWInFEb6Rwm4pNBSq651WnlzAKHb85vkr7mnfYwoG7jUv3j
         ZK6IPb3zBQA1HiihkdBJud4QKzggMUDZzVQigQFmdSVLDzxBCi9ADrMKXQMvAhI/96Ww
         ntKQ==
X-Gm-Message-State: AOAM532Haqi2VuSP9wpj34JanRdL0iki5T1/p3RznwniwNPXrOxWyJy0
        raIkk2SCg3XQqwzlEKWl+xu7CeeqnpyhxKE8rrs=
X-Google-Smtp-Source: ABdhPJwBQsFkTYLlprwQbz6Jw0oLof/P3UXX53ZIdXXx96lqKYOe8dv6TLlKh+jH8237HWNEx2pQk8r8OB+0/3nEE4E=
X-Received: by 2002:ac2:5325:: with SMTP id f5mr428582lfh.86.1602810271223;
 Thu, 15 Oct 2020 18:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <3BFCA289-ADD8-4755-80C5-1889A9AFB41D@libreelec.tv>
In-Reply-To: <3BFCA289-ADD8-4755-80C5-1889A9AFB41D@libreelec.tv>
From:   Forest Crossman <cyrozap@gmail.com>
Date:   Thu, 15 Oct 2020 20:04:19 -0500
Message-ID: <CAO3ALPytXHdb6svA+_EbmV7+g9+FdyQhBKWHUJwOGQxyJgL=kQ@mail.gmail.com>
Subject: Re: mt76 support for MT7668 SDIO?
To:     Christian Hewitt <chewitt@libreelec.tv>
Cc:     Linux Wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

CC: linux-mediatek

On Sun, Jun 7, 2020 at 11:52 PM Christian Hewitt <chewitt@libreelec.tv> wro=
te:
>
> I=E2=80=99m a maintainer for a distro that runs Kodi mediacentre on many =
popular ARM SBCs and Android STBs (replacing Android).
>
> Similar to my request on RTL8822CS, I have a number of requests for WiFi =
support on Amlogic SoC devices using MT7668 chips. The BT side of the modul=
e is supported in mainline for sometime, but there is no mention of WiFi.
>
> Is there any plan or timeline for MT7668 SDIO support in mt76? .. I=E2=80=
=99m struggling to even find vendor drivers for this chip.

I realize it's been about four months since you sent this email, but
if you're still looking for sources for the downstream driver, I know
they're included in the source code releases for the Amazon Fire TV
Stick 4K[1] (latest one here[2]). Inside that tarball, there's a
"platform.tar" archive. Inside "platform.tar" you'll find the kernel
sources for the Fire TV Stick 4K, which includes the WiFi driver for
the MT7668 and several other devices. Specifically, you'll find the
MT7668 drivers under
"kernel/mediatek/mt8695/4.4/drivers/misc/mediatek/connectivity/wlan/gen4"
and "vendor/amazon/wlan/mediatek/driver/mt76x8" (not sure what the
difference is).

I, too, am interested in upstream support for the MT7668 since I have
several USB dongles (well, technically they use custom connectors and
are custom-made to be used inside specific TVs[3], but they enumerate
fine on a normal PC) with the USB variant of that chip, so if anyone
has any plans to add that support, I'd also like to know. And if
someone is interested in doing this and needs hardware, devices that
use the USB variant of the MT7668 are pretty widely available and can
easily be found with this eBay search URL[4]. The user manual[3] for
the devices listed in that search has the pinout for the custom
connector on the board, so it's relatively straightforward to solder
up a USB cable to it to get it working with a computer.

[1]: https://www.amazon.com/gp/help/customer/display.html?nodeId=3D20145268=
0
[2]: https://fireos-tv-src.s3.amazonaws.com/o5P7dfByxbBhcfQqI8IqUREyUc/Fire=
TVStick4K-6.2.7.3-20200724.tar.bz2
[3]: https://fccid.io/BEJLGSBWAC92/User-Manual/User-Manual-3945059.pdf
[4]: https://www.ebay.com/sch/i.html?_nkw=3D%28eat64454801%2Clgsbwac92%2Ctw=
cm-k505d%29
