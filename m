Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296BB1F84E8
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2020 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgFMT0Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jun 2020 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMT0X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jun 2020 15:26:23 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBE4C03E96F
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2020 12:26:23 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v13so10025995otp.4
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2020 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aJ1kTeHe29tkewf0gw/5ptnJgon/X9T3RuE5AhokiHI=;
        b=nUYyy8kpvioc0uzwrDWbcTCoVu7aiDrgclQUGZMnEn5PL/qG+7OrY8nMBDEj042zl5
         cLjgMG1BFuNrfrqzJjzVoa24KwPKgCSTVdnNiyqh8ZDgPNkPLC9i5GzI0gbZY8jVxnj0
         Y0mPQBVtMwngIcoTAEg02K5mTbwIHyzD6M3OHQnyEBKxyZLmh2To07dvM+Rprhoytafd
         n9WZbUxOLc6PdLGtfzsLLK2lh6RUPdXmua04qnxGdOC6abW+ufOJdpyzJvePjGBTOn4w
         6/5yvonP/7ZFoBXHgPT/TniK3BJUl/BcSywrUzmIzAauQbWAkZjZ4Xy/Ile9jtXuLgXj
         C4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=aJ1kTeHe29tkewf0gw/5ptnJgon/X9T3RuE5AhokiHI=;
        b=jTISH1QOHfiVscxeS4d43mdKTBDMd4Us2ampzNg6IhUVSn5JfL1mp4UvmaPFlr0WW0
         R72KobCQr2OdtcjXbFEZXG+P+hGJe6vfMlk/IwrZqm+E1tNUkUCHCF4uDFYVVfXaGNbY
         +NdEumYkCU7HhU696N5/ECTIbaeZGGUWdGKeL4JGCIGGL0+yYEo5aqKBnc5VHAYaBKy/
         bcCjpqvBhXIHpPoGROFKKd8gZoaEuBtzWfYT6SmR85P6goA+aXVL9M8TeawDU/yXPCy/
         M5OC36rz/CZ9y8GQqR2hqU+bacSdG2eUZCwA8XQ95zUlaJfy0IN1YrYQLfUj5fAJtV2A
         mazQ==
X-Gm-Message-State: AOAM5326jb1Qd6i2FBas5GQvRVao1n+u21xnJbU5l3ledh+fVftxHQra
        Eetgp5ugL/qeZjH9F7gOR0BJDPOVNL8YQNC498Quq6N2
X-Google-Smtp-Source: ABdhPJyvCBGtzUPqLgx744Xkt7NwKGFxfH3XpXuFlloDZwAMp3344/V6JbaiYg8FggKbSSqQjbr1W732C1LShGzj7Kg=
X-Received: by 2002:a9d:730c:: with SMTP id e12mr15564852otk.8.1592076380734;
 Sat, 13 Jun 2020 12:26:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:940e:0:0:0:0 with HTTP; Sat, 13 Jun 2020 12:26:20
 -0700 (PDT)
In-Reply-To: <CALqii0=iXM_5pQFZU4sinB5soDkNzVLG45W=HJ6=NxaytHiybQ@mail.gmail.com>
References: <CALqii0=iXM_5pQFZU4sinB5soDkNzVLG45W=HJ6=NxaytHiybQ@mail.gmail.com>
From:   My Nigga <anomalousanonymousarmadillo@gmail.com>
Date:   Sun, 14 Jun 2020 00:56:20 +0530
Message-ID: <CALqii0k9ARHW0530VgMybxT_6+xPdp_Owzvuk42cZw9CgWjt9w@mail.gmail.com>
Subject: Re: [BUG] rtw88: WiFi speed drops randomly, timed out to flush queue 1
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

also I have Windows installed on this same laptop, it has no issues
with this WiFI adapter, so I do not think it is a hardware issue.

On 6/14/20, My Nigga <anomalousanonymousarmadillo@gmail.com> wrote:
> Info about my system:
> I have an=C2=A0ASUS TUF Gaming FX505DD=C2=A0laptop with the RTL8822BE WiF=
i
> adapter. I use Arch Linux (Linux 5.7.2-arch1-1 #1 SMP PREEMPT Wed, 10
> Jun 2020 20:36:24 +0000) with the rtw88 driver. I have NetworkManager
> installed.
>
> When it happens:
> When I do not have a really strong WiFi signal, my WiFi speed just
> drops by a lot, sometimes to zero, randomly. It doesn't happen (at
> all, as far as I know) when I am right next to my WiFi modem.This
> issue has been there since day 1 of me installing arch, I've seen
> "failed to send h2c command" pop up in the live boot environment too.
>
> Logs:
> Whenever this happens, this=C2=A0message is spammed when I run dmesg (it
> prints like 2-3 times per second):
> [Sun Jun 14 00:10:47 2020] rtw_pci 0000:03:00.0: timed out to flush queue=
 1
>
> sometimes it shows
> [Sun Jun 14 00:01:05 2020] rtw_pci 0000:03:00.0: firmware failed to
> restore hardware setting
>
> and rarely it shows
> [Sat Jun 13 23:38:08 2020] rtw_pci 0000:03:00.0: failed to send h2c comma=
nd
>
> There's also a stack trace sometimes, like
> this=C2=A0https://pastebin.com/SDhKpBdd=C2=A0.
> NetworkManager logs don't show anything when this happens.
>
> I'm sorry if this does not have enough info or if I mailed this to the
> wrong place, this is the first bug report I've made.
>
