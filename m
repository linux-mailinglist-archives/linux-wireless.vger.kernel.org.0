Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24803735F8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 10:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhEEIDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 04:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhEEIDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 04:03:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B020C061761
        for <linux-wireless@vger.kernel.org>; Wed,  5 May 2021 01:02:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u3so1321985eja.12
        for <linux-wireless@vger.kernel.org>; Wed, 05 May 2021 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C4I0Hmhs1ODCxPUUbdwePVfov5ZkDPrfhT7eYoClVx4=;
        b=oywzvdNQpGYwe0jf6BpZTmdRGgJ8Pr/tZc2R6lVI3/5/vXLossSoyCJeABScm1ZRaE
         N9Y7qxmO5F/fJrV+1JVrVnpYnI1bwKj9YbzosfG4J9ZJugwa/04IgFlECqUhh0TMqqQ+
         k6O0pSQ/G3oE50liYxHfw79Rp2kOPB95G8yTu9iFbj1Q4FzEJneOdnUTvkUgu/VdgUG1
         9Psvc2k8rf5KtFZG0rENUPGBZ34r1hSGNodRKx/Sl5nbFcYOI+btFMFNFUIMFreY+55/
         9DJp7WwOgCCntoQ1Vkkbm/RzDeoTxAjF4ptzZjjUGTuEPZf8CM0Rv9N7o46Llwhu7+ug
         x5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C4I0Hmhs1ODCxPUUbdwePVfov5ZkDPrfhT7eYoClVx4=;
        b=lCJI8JQenz3i8DoVowFVJRNxlnrtrBsZLvYfeFU4+q0Avp+7VtaXqr7e4/GNJOQy71
         jEK5JDyZku+rdsqS71AgjB98oTXI/kxt5gKCuq1seaxgdkYu9r8K7BFgAYXtGxjXTGdJ
         zKLEkdN9duyzuXJ6joXQm0dHJAubSGxg3NyA6AKTEgl2pxZ8fxiuldvP4MIjRUgeUQS9
         vj/nDUTnWkeXG3qoV73E5eSLdI3v+ha5953zXfNi6hVlvplzKJzHg0HtQ8tqm6g9xU2H
         sCz7TskaHdMXSZK0iNppXawtuWDTzXrJDuZwQkwC6F+DlyhiXKd1a/tUSEMpkN9ZImUC
         r3Bg==
X-Gm-Message-State: AOAM532e+GoruD0OE/Lf8UUn28cy5qjKO6KxEEc1TYbfGhm7/Sd5Tnwr
        1TAujFA3bUNHWyFaPx+Lc84W9CVJZc7pctH7bgTZ0sL2Cw==
X-Google-Smtp-Source: ABdhPJyC82yEUIsdB0T713s7KyMk0nNVxHHUEg98xZO5RMbuFfPe0sHKBrMPwAbVNjQqSoEJJEXQamC0nFFuIfFyssk=
X-Received: by 2002:a17:906:4f91:: with SMTP id o17mr25835787eju.503.1620201723995;
 Wed, 05 May 2021 01:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210504212828.815-1-rsalvaterra@gmail.com> <20210505045044.GA735251@wp.pl>
In-Reply-To: <20210505045044.GA735251@wp.pl>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 5 May 2021 09:01:52 +0100
Message-ID: <CALjTZvYZ8Rr-UFyqFststt+vG+Ei1avUvPVxQwHe72QU0NEeKA@mail.gmail.com>
Subject: Re: [RFC PATCH] mt7601u: make the driver work again
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     lorenzo@kernel.org, kuba@kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Stanislaw,

On Wed, 5 May 2021 at 05:50, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
>
> I'm not sure if DPD calibration is needed. Maybe is ok to disable it for
> all MT7601U devices. However safer fix would be doing it only for
> devices that know to need it for work. For example: add dev->no_dpd_cal
> variable, set it based on USB ID (using usb_device_id->driver_info) and
> do not perfrom calibration when it's set.

Hm=E2=80=A6 the struct usb_device already contains a u32 quirks. Shouldn't =
it
be used instead, or is it used for an entirely different set of
quirks?

> Also please clarify "work again" in the topic. Have your device ever
> worked with mt7601u driver in some older kernel version?

Personally, my devices never worked. I ordered a bunch of them
dirt-cheap from AliExpress, in early 2019. I needed one for my RPi,
running OpenWrt 19.07 (Linux 4.19), but it failed the same way. I
thought it might be a problem with the driver on ARM, I replaced it
with a Ralink adapter and it worked fine. I hadn't used the devices
until a couple of days ago, when I needed to connect a x86 machine and
saw the exact same error I had seen on the Pi.

Thanks
Rui
