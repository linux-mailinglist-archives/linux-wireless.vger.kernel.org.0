Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0C54E70
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfFYMKm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 08:10:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55069 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfFYMKm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 08:10:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so2558289wme.4
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2019 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KqvmENn8QFyqHBQaTDznFqIdL40op15u4F8C4hVZgf8=;
        b=iaDuB3ETIO/IyNAlFelBkozhuqeAztcKLHOGPllcEEeZnsTpIrJgm8eRGPZ2lg1GO5
         w6iLkzOo6BYyBNBRgHtBKfMUEPWIids5dHppX9SFQ0/A61DQAttNpaTMLGBzpVG490Y5
         i0Y/iuOkYEceY1aakilyX0vnVVEmoLZ69KqZyq4DZyRAdI7zH5/pf9wY/rRvBr2FkGUI
         ezIzCdzzZc79QGxXDbhzBEXWw/9EZ/QItPEo51bRxG191Am5QeYoLa3X/3joyYXfTDrh
         7PXzxEgbA1A9C/ixB6d16nm6M4I/t3FI044QOUEk+yrxGdMM6Poqs2Us7NeE6mh8v0rI
         PCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KqvmENn8QFyqHBQaTDznFqIdL40op15u4F8C4hVZgf8=;
        b=D639k9q3ZpmIxADtG+Dk/W9pqqTR5AIS095wOXWMaZRjncgI6mE6gtT4Ohtbet/X9Z
         K69gP9BqLFARUUFmHseSSF9AAm9vsgfL94vUuIyFa1ARdA79yxsZppiy1kHgxJOoJ5oA
         ZrjAtjWsZqkQ+lGMPN3iGTUSig8iWYhIudQia8+uZZu7YAxUiSB9n9gDZPNzzOHoY0eV
         MdMyELBjRIneFcSxLmTyzylCBr+lSU/WqfuxdMDqV1V0fyB97cLK1B5lfeJbZEFMiimb
         OAoMN6yk8c3l48apnAC+Z96NxSKUuhx77vhxJvfcjn1jE3e6ETcx5y0evg7s0yuRGPA9
         p//A==
X-Gm-Message-State: APjAAAWb8jTlirQndddopYZBY/tV0M3LvpGu3aVPXJ35sMIx7r+Hvqdq
        5I2ROpZQTlfW/L4zIQ45/wDSOAs99lmZKjAE6rA=
X-Google-Smtp-Source: APXvYqxdMQYspUn8+VCOvJlKmAl5CwIyoQXF418EAcZBOARIgJsR+7AE9nkn1MODYr1zjtvQAZxWrl58taF6t+ubOeg=
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr20953031wmc.151.1561464640948;
 Tue, 25 Jun 2019 05:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <946c86bf-7e90-a981-b9fc-757adb98adfa@hbuus.com>
 <20190610204927.2de21c9a@wiggum> <87v9wus164.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87v9wus164.fsf@kamboji.qca.qualcomm.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 25 Jun 2019 14:10:33 +0200
Message-ID: <CAOiHx=k_KPgXqJYjSeUFVS3pae1CGBGS9STnTuAfNyvak2k08w@mail.gmail.com>
Subject: Re: [PATCH] ssb/gpio: Remove unnecessary WARN_ON from driver_gpio
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        H Buus <ubuntu@hbuus.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 25 Jun 2019 at 12:06, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Michael B=C3=BCsch <m@bues.ch> writes:
>
> > The WARN_ON triggers on older BCM4401-B0 100Base-TX ethernet controller=
s.
> > The warning serves no purpose. So let's just remove it.
> >
> > Reported-by: H Buus <ubuntu@hbuus.com>
> > Signed-off-by: Michael B=C3=BCsch <m@bues.ch>
>
> For some reason patchwork (or pwcli script) didn't like this patch so
> manually applied to wireless-drivers-next:
>
> e73e43246da6 ssb/gpio: Remove unnecessary WARN_ON from driver_gpio
>
> I have a faint recollection that I had a similar problem with another
> patch from Michael, did we ever conclude what was the issue?

Yes [1], a bug in kernel.org's version of patchwork. The fix was
included in v2.1.1; latest is v2.1.3. kernel.org is (still) at v2.1.0.
Maybe it's time to poke helpdesk?

Regards
Jonas

[1] https://marc.info/?l=3Dlinux-wireless&m=3D153388992528252&w=3D2
