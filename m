Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA66A3FDA
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 23:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfH3VpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 17:45:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43194 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfH3VpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 17:45:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so7467642qkd.10
        for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2019 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2eIGQI2Zi7oPP+PNtMVrWpZawQ7idVXN94BfbCutwc=;
        b=VxTUT+n4vCiGZVFjmWZebeMHVeqLJg5eHiW/p1wBhlteDBd10Eyfw5ugYFzJAlNTC9
         3LnW6LWwb2c/rPwMZjUi1kKeZBMy7gI/Cy62Gj4E0yt8ifu0wEiDUE+1/5zpNzKY+q/q
         t9/QDKoj/JAuUkvwx0ahRzFCnK7DN7umu7yRNpBCZMKwCSmidVSQnhM2m1MxmHwUFzmJ
         meBnfSJzwFlLi1h42YklR/zoWi2o0qs57g/yi0nPAWRCYm0EX6oBBwsTG/FxrxlRu0aV
         ZsUxVQnU6VtcZrF3ScY93IovYyizOjuNoDZwrXgq6vu2vuT2CJuLx22leMIpRIdTrF6p
         JAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2eIGQI2Zi7oPP+PNtMVrWpZawQ7idVXN94BfbCutwc=;
        b=g9ZBOpl+4sQCATfxpsbTDwgE1gNY1yFEkJUy4RIQYSfA6wjuAtt/uUKdZI9641ehHU
         RMTxVVWi7vXYVrLu4XrUUVs2m6otfYu6Z+nzsjO3q2gLGWJYyXnNh0WRS2u3kBcCoyVQ
         dnan4HIwtcVblVf4SPC9YREs4gXB1akKFXLUq6GVfM0GU6stiM9BLI64tea1DeDLHi6n
         xFP2szeI2++PozQBXjywUVbu4/AdPwbHGtUSVhgurP5qMJH2mV4YvBY7q1wN6HlSMvxW
         HccxR2xeKC3B15S3F5kaoprdjRLRdwk3YyqYEQQvjB91VgfCET2pZxukXb74aJ3KIbib
         M1kA==
X-Gm-Message-State: APjAAAVWX0+W+IiD6eVXBJzrlAcait+Owm8lLVc7fHXucOGJXnC5JEIY
        XjzJtU7+NIZePnB4K6QhJgnPWIu2UfhkXfst6GSsEMTD
X-Google-Smtp-Source: APXvYqzGZGbfNkWNSdcQikim4MuihQZFj438Z+bg9+DAUjqBnfXGAqChdpWa2zg9hazlM669i9IZx7c4Rx2IQfeym9k=
X-Received: by 2002:a37:a503:: with SMTP id o3mr994717qke.115.1567201518555;
 Fri, 30 Aug 2019 14:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
 <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net> <CAHmv74wNOM1QKUPp2Vax2Z+-JyoFC81WHVZ+XbYgiRMUGxCFUQ@mail.gmail.com>
 <9492be2d-abd1-0e1d-5d80-1a72b0250749@lwfinger.net>
In-Reply-To: <9492be2d-abd1-0e1d-5d80-1a72b0250749@lwfinger.net>
From:   Sergey Kharitonov <haritonovsb@gmail.com>
Date:   Sat, 31 Aug 2019 01:45:07 +0400
Message-ID: <CAHmv74x008FvhDztqOq-EC=d7fSXN7=kEOhQm3TPZn1PDZP=fQ@mail.gmail.com>
Subject: Re: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sounds good!
I made a little change to compile that old rtl8192ee_revised.tar.bz2
driver on Linux 5.2.X and I get <1ms overall ping to the router with
rare spikes to 1-2ms.
I'm excited to know the right driver can provide the same performance,
it's starting to look now like the hardware's achievable maximum.
Is there any chance an improved rtl8192ee would be included in Linux 5.3?

On Sat, Aug 31, 2019 at 12:36 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 8/10/19 1:13 PM, Sergey Kharitonov wrote:
> > Dear Mr. Finger!
> > Thank you for paying attention to the problem. I've just posted an
> > updated information to that bug before receiving this message.
> >
> > I get these results
> > ~]$ ping 192.168.88.1
> > PING 192.168.88.1 (192.168.88.1) 56(84) bytes of data.
> > 64 bytes from 192.168.88.1: icmp_seq=1 ttl=64 time=0.746 ms
> > 64 bytes from 192.168.88.1: icmp_seq=2 ttl=64 time=0.868 ms
> > 64 bytes from 192.168.88.1: icmp_seq=3 ttl=64 time=0.853 ms
> > 64 bytes from 192.168.88.1: icmp_seq=4 ttl=64 time=0.868 ms
> > 64 bytes from 192.168.88.1: icmp_seq=5 ttl=64 time=0.818 ms
> > 64 bytes from 192.168.88.1: icmp_seq=6 ttl=64 time=0.844 ms
> > 64 bytes from 192.168.88.1: icmp_seq=7 ttl=64 time=0.841 ms
> > 64 bytes from 192.168.88.1: icmp_seq=8 ttl=64 time=0.913 ms
> > 64 bytes from 192.168.88.1: icmp_seq=9 ttl=64 time=0.844 ms
> > 64 bytes from 192.168.88.1: icmp_seq=10 ttl=64 time=0.886 ms
> > ^C
> > --- 192.168.88.1 ping statistics ---
> > 10 packets transmitted, 10 received, 0% packet loss, time 387ms
> > rtt min/avg/max/mdev = 0.746/0.848/0.913/0.044 ms
> >
> > with a driver from rtl8192ee_revised.tar.bz2 file in
> > https://github.com/lwfinger/rtlwifi_new/tree/extended repository built
> > against Linux 4.19.65-1-lts ArchLinux current LTS kernel.
>
> I have completed but not yet sent some updates for rtl8192ee. Using them and
> kernel 5.3-rc6, I am getting the following:
>
> --- 192.168.1.1 ping statistics ---
> 100 packets transmitted, 100 received, 0% packet loss, time 99134ms
> rtt min/avg/max/mdev = 0.881/1.487/8.198/0.844 ms
>
> This is using the "old" firmware with the following md5sum:
>
> c8d25646cbc9efdcb818fc95ad5836a9  /lib/firmware/rtlwifi/rtl8192eefw.bin
>
> The new driver patches convert a set of macros to read and write the descriptors
> into inline routines. The calling sequences are also converted from u8 * to
> __le32 *, but I would not expect much improvement with the latter changes.
>
> Using a local speed test web site, I am getting 100 Mbps download and 80 Mbps
> upload rates.
>
> Larry
>
>
>
