Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A2C10B3
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2019 13:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfI1Lv5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Sep 2019 07:51:57 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:43373 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfI1Lv4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Sep 2019 07:51:56 -0400
Received: by mail-qt1-f174.google.com with SMTP id c3so10746759qtv.10
        for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2019 04:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLZ3xBhcfmmsVQg+eojJbQrfSTPdru40FIJuhphzrzM=;
        b=Pp4BkoqUXG8UDhLa92tNzSgYyVbHntmoM6Qq2ORijx0XjtBBvHo9Q6OQoOEudbRUhY
         V2lo4NJ7TPJFroWtylyXUtr1idDaDkvbOPAAQi1dBn7gGgH8CR9vgJVrfBp/vu+kX59b
         grkpeJCq6YmzTaUHdXlqpC5nPlZyyYJ5BtIsTYQOD6PEhvbXU3mtLbnK7X+58XM3viWN
         cAgLLplPKIHKRw3u/KZ8eDpi/wVKQAd2tuWFO9JZmWn5hj88WrAWvQGCjBMATD5BRrKh
         zgLsmNb3KP0YC3r37cl5JR2dw/hDzI+TR5Kl3nrFofpd/6ZdXl3GmVvIOpdWnCmpUYJg
         q1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLZ3xBhcfmmsVQg+eojJbQrfSTPdru40FIJuhphzrzM=;
        b=AZzVoizj1NnaplrDQ1BLvN6iTThM9NtMfb96mNo1QZOJlLGojxp/383Wgk9ouyYS+p
         gX+Wx+i3jFiHNSIEWiI80o7GhN9tkyIiCK1afSWQke4t8LY81Wey2Tyvkex1W8HJHrF0
         bDjIkPGX+vgfaJHsL9lbFZo83ExXGJKgaI1bo7MEEWzUwu7cCeeqHE0OGiGQBt++EMWt
         js5FPSWXtEvW0cHmPPAuvGSvU6OJS3+9mafldYxz/iS6EIDjRIzJUOJMKAMC0QLjeOcB
         4d7gWuAhkhoJkElmtONgiea1Oqlg7oq4HMZcDXq9j/GTzYZPoEsxxUXm29YY6sVGXU+J
         cLxQ==
X-Gm-Message-State: APjAAAVvfKJUWPK9kODC+h14LJA/otj9qr+8t5GVw/fASMrfC9sIqE7T
        VmwVoLYk4lFllW8gxXeyuuAq1DfG6+AaCx3fhzA=
X-Google-Smtp-Source: APXvYqw9KOKEoopD5pcv15UfYZvwtsVbClo5oCMfRfngEMGchobwgpHL2O9ysj417+wPMFjHfkWa9zXskwJGNt3mhc0=
X-Received: by 2002:a05:6214:12ad:: with SMTP id w13mr12227983qvu.124.1569671513500;
 Sat, 28 Sep 2019 04:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
 <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net> <CAHmv74wNOM1QKUPp2Vax2Z+-JyoFC81WHVZ+XbYgiRMUGxCFUQ@mail.gmail.com>
 <9492be2d-abd1-0e1d-5d80-1a72b0250749@lwfinger.net> <CAHmv74x008FvhDztqOq-EC=d7fSXN7=kEOhQm3TPZn1PDZP=fQ@mail.gmail.com>
 <9b6f5c4c-2775-a5c2-0372-f8eb7ec18628@lwfinger.net>
In-Reply-To: <9b6f5c4c-2775-a5c2-0372-f8eb7ec18628@lwfinger.net>
From:   Sergey Kharitonov <haritonovsb@gmail.com>
Date:   Sat, 28 Sep 2019 15:51:42 +0400
Message-ID: <CAHmv74x7VozPiC3D1c+hXbPPaiAQwaQ1Cpx7tqQFtpuWstj39Q@mail.gmail.com>
Subject: Re: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Mr. Finger!
Today's upgrade to linux 5.3.1 made the OEM Realtek driver (from
rtl8192ee_revised_5.x.tar.xz) unusable.
Current rtlwifi_new master and extended branches still contain old
code which results in a high ping.
Can you please somehow add your changes described above to git or wherever?

Best regards,
Sergey Kharitonov

On Sat, Aug 31, 2019 at 4:27 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 8/30/19 4:45 PM, Sergey Kharitonov wrote:
> > Sounds good!
> > I made a little change to compile that old rtl8192ee_revised.tar.bz2
> > driver on Linux 5.2.X and I get <1ms overall ping to the router with
> > rare spikes to 1-2ms.
> > I'm excited to know the right driver can provide the same performance,
> > it's starting to look now like the hardware's achievable maximum.
> > Is there any chance an improved rtl8192ee would be included in Linux 5.3?
>
> It won't be in 5.3, and it is getting late for 5.4. I'll send the patches along
> and see what happens.
>
> Larry
>
>
