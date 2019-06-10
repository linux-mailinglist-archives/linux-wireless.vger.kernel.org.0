Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90DE3AF28
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 08:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbfFJGu2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 02:50:28 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:34255 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387718AbfFJGu2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 02:50:28 -0400
Received: by mail-vs1-f45.google.com with SMTP id q64so4683539vsd.1
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jun 2019 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpJ8laeRMo44o7Xfh9K1uH3yYvR4RdIiGg456hvouTw=;
        b=XSe6WvK7p0WEAabV7k68XmK5ElwQhbgn18t6ZIoun5MUwvbXM1KLtcbCry/XUTLyS5
         1nu7cwxho+cyFXfnd2F7p3wNDrGJrxL9GVGJgplE7syMtWCAzNHw3lof3oy7JoudwtV3
         q4cUSEcNBghGYM7bu4ZCN7m0ERKWMU+qaNn+A7urbGzuxZrtc5RKLotKWHcag4ddEU+W
         XCkt8Z0E/xILRtGl8GN9Xt6gkIBEYsS1ntYslmjFCjTUV+kgIKC5p+fPZ75U2cQjHgpE
         Nt3ZFBQOy+KT5DcWuMPa/0wm+6JukPyVQ7rEiE9H5aglki/c87PMbt6ZvU4Pp1MH4PhN
         rwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpJ8laeRMo44o7Xfh9K1uH3yYvR4RdIiGg456hvouTw=;
        b=ps3T2A9srhDaNJWNF3EqURf4vCKVzFyalPa9kswbdcC1ZkLTjt9jAjP1+E9h36YTCk
         ZlOjhfrXCGa7JxTyCuxD22iTPe+05FGZmTwq0u3nfYwM899ey1B9OtzMDtYR0xn9oz5q
         ybONUUKEZCx/GcJ8LG94rPhG5YYPRqH/o+SuB5hHMPTNQDd4nS76/bgdhK0cyC1x5Coj
         XaiF04h+kTIVC9Zhp9SX/RmQPcm0vfROZGQ0Gzu2MKY7B1CFSDjaQnwOASZEP3X+sxKj
         iSfO3V71oMVoDi4wANHmi4MjXH/yrSwCjKQHP+KD+jpunChtuHZxF95XMMvXt9ukSWmh
         caEg==
X-Gm-Message-State: APjAAAVYXAq6pr/+r0aLcp8pKpCfOsO10NzCvqqWZ0SyaNtc4EP99+fV
        ZphvdWFWNmMMbDBSsR6xH41QB4mll9/bjf7iEids+0IxJ7Dckg==
X-Google-Smtp-Source: APXvYqyCaUU88aZcIqBjri8wNFL/kQtxWAMpweTPJMi7uWIeP2WZBHKXXMPgDioZHnnW6tUT6+Fge3gnJB/GVHSg13k=
X-Received: by 2002:a67:e244:: with SMTP id w4mr8965940vse.176.1560149427063;
 Sun, 09 Jun 2019 23:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <2455026.F8Aexx8IWb@zadesk> <CANUX_P0=F4-Q5Drhcpk6-y7F7Ub3omQk=Pg6wh3pv=pLc9YHWQ@mail.gmail.com>
 <2696773.yqXG4m880n@zadesk>
In-Reply-To: <2696773.yqXG4m880n@zadesk>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Mon, 10 Jun 2019 09:50:13 +0300
Message-ID: <CANUX_P3jUBREM=cwLHs8LE+ZbUVKGZNsBWGGepbS-mcHq0w9ow@mail.gmail.com>
Subject: Re: iwlwifi module crash
To:     Balakrishnan Balasubramanian <linux-wireless-list@balki.me>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 7, 2019 at 2:41 PM Balakrishnan Balasubramanian
<linux-wireless-list@balki.me> wrote:
>
> > This is because the device is removed from the PCI bus. Nothing from
> > iwlwifi side can be done.
>
> I am sure the device is not physically disturbed. If that was the case, should it not stay down when restarting the system?

Not necessarily. The disturbance may impact ASPM or something alike.

>
> > If that happens upon suspend / resume, I know there are been fixes in
> > PCI bus driver.
>
> To my knowledge I have disabled all power/suspend features and I don't see releated logs in journal except the below. Not sure if relevant.
>
>     Jun 03 21:33:14 zadesk kernel: wlan0: Limiting TX power to 14 (17 - 3) dBm as advertised by d4:5d:df:25:ee:90
>
> Is there a way to restart the module safely without restarting the system?

echo 1 > /sys/module/iwlwifi/devices/0000\:02\:00.0/remove
echo 1 > /sys/bus/pci/rescan

>
> Regards,
> Bala
>
>
> On Friday, June 7, 2019 5:25:41 AM EDT Emmanuel Grumbach wrote:
> > On Fri, Jun 7, 2019 at 5:22 AM Balakrishnan Balasubramanian
> >
> > <linux-wireless-list@balki.me> wrote:
> > > I am using iwd demon for wifi. Once a while I loose connectivity.
> > > Restarting the demon does not help. But once I restart the system, it
> > > starts working fine. Attaching stack trace from journal.
> >
> > This is because the device is removed from the PCI bus. Nothing from
> > iwlwifi side can be done.
> > If that happens upon suspend / resume, I know there are been fixes in
> > PCI bus driver. If not, check that the device sits correctly in its
> > socket.
> >
> > > Regards,
> > > Bala
> > >
> > >
> > > ---------- Forwarded message ----------
> > > From: Denis Kenzior <denkenz@gmail.com>
> > > To: Balakrishnan Balasubramanian <iwd-lists@balki.me>, iwd@lists.01.org
> > > Cc:
> > > Bcc:
> > > Date: Thu, 06 Jun 2019 18:07:40 -0500
> > > Subject: Re: iwd crashes randomly
> > > Hi Bala,
> > >
> > > On 06/06/2019 06:00 PM, Balakrishnan Balasubramanian wrote:
> > > > Sometimes after a week and sometimes after two days. Once crashed,
> > > > restarting the service does not help. Had to restart the computer.
> > > > Attaching stack trace from journal.
> > >
> > > That implies that your kernel is crashing, not iwd.  The attached log
> > > shows a kernel stack trace somewhere inside iwlwifi module.  I would
> > > post this trace to linux-wireless@vger.kernel.org.
> > >
> > > If you have an associated iwd backtrace, then certainly post this here,
> > > but if the kernel module is crashing, there isn't much we can do.
> > >
> > > Regards,
> > > -Denis
>
>
>
>
