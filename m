Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44F788CB6
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2019 20:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfHJSN5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Aug 2019 14:13:57 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:41460 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHJSN5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Aug 2019 14:13:57 -0400
Received: by mail-qk1-f177.google.com with SMTP id g17so3505679qkk.8
        for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2019 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pv0dqEetZB0bD1FdjLpr6N7qnmgQqskETfgNLxlpg0U=;
        b=IQ208m4Mc76ImqTBBXdAq466sG7SLWN6AFY5TeUjKThMQO46914SMZBKwMmWxscpRa
         IsbIn/GMQ7D0H+3kL8IcaCZavZOWank6TvitZSnSqFL6ol8QwdBVO1c/B8xcYVJEihei
         MOLvta1dDNpvJcPOOKgfrUoZQoXkpIv9BYB9b8zLFYYSbBRlAjD8SkYkLS/D3bKgRkEH
         ZBWYhfpY+ntMG+fid8BYIxUktoslF43nMVCHpLMkV4m48jPcsJfc3DpTJVKJ0LR6hcGv
         f2CShLUbkKQUEJZxrdVmhJdlCFrL7cKeQtK5KUi05gQCXdQEUWYZIBC+qYS8/SIOcI7u
         Z42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pv0dqEetZB0bD1FdjLpr6N7qnmgQqskETfgNLxlpg0U=;
        b=tKZmdlPtd78AlMxTInyQjCqhNYDZsz6TdhqRRRHMjmUDc9kXANObAq5FsndO7OwfTP
         ir773T9zaRtxhO89Zrz2dJdDf3zW6yZzJgZ2hQTxWlhuYScRf7hqn8v31Hpq9sJ0J255
         XkWX1OvTjzI0HZerduAsOJY/Jq5FWBVZQApSD2jPunIEE50t8uXtKajo344kUy7gzcUm
         0QZjFLenZhSoGJ/n2A4kzVLswXBc/dPw/kbEvnf1AylEe308Ed4mnQUhlfQWF9uMzYT4
         LUTmS2dAJO0ZIberNbZ8Z/zyfqvelkXwr1B+pSTVwRdONUQaPEjPtewudWMgewqdHd5y
         uJxw==
X-Gm-Message-State: APjAAAWL3rTfrcLwBNL0zsVEqg+pa3Teo+UjkkvMGU5uIpGmjEvLsLq2
        MPI8KxFSvOEn2zxwjLAGIIhHGSfK70rb9yE6w+rIhiO5
X-Google-Smtp-Source: APXvYqwmSG27Zql63bEfwSvvRm2zV4mQ4z6oNSHnpUp0KdaaS5tdZrRjSaa/m/u6mrIKrOEILS8aQT+QfhjAGITmoO0=
X-Received: by 2002:a37:bcc:: with SMTP id 195mr11458242qkl.115.1565460836678;
 Sat, 10 Aug 2019 11:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
 <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net>
In-Reply-To: <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net>
From:   Sergey Kharitonov <haritonovsb@gmail.com>
Date:   Sat, 10 Aug 2019 22:13:45 +0400
Message-ID: <CAHmv74wNOM1QKUPp2Vax2Z+-JyoFC81WHVZ+XbYgiRMUGxCFUQ@mail.gmail.com>
Subject: Re: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Mr. Finger!
Thank you for paying attention to the problem. I've just posted an
updated information to that bug before receiving this message.

I get these results
~]$ ping 192.168.88.1
PING 192.168.88.1 (192.168.88.1) 56(84) bytes of data.
64 bytes from 192.168.88.1: icmp_seq=1 ttl=64 time=0.746 ms
64 bytes from 192.168.88.1: icmp_seq=2 ttl=64 time=0.868 ms
64 bytes from 192.168.88.1: icmp_seq=3 ttl=64 time=0.853 ms
64 bytes from 192.168.88.1: icmp_seq=4 ttl=64 time=0.868 ms
64 bytes from 192.168.88.1: icmp_seq=5 ttl=64 time=0.818 ms
64 bytes from 192.168.88.1: icmp_seq=6 ttl=64 time=0.844 ms
64 bytes from 192.168.88.1: icmp_seq=7 ttl=64 time=0.841 ms
64 bytes from 192.168.88.1: icmp_seq=8 ttl=64 time=0.913 ms
64 bytes from 192.168.88.1: icmp_seq=9 ttl=64 time=0.844 ms
64 bytes from 192.168.88.1: icmp_seq=10 ttl=64 time=0.886 ms
^C
--- 192.168.88.1 ping statistics ---
10 packets transmitted, 10 received, 0% packet loss, time 387ms
rtt min/avg/max/mdev = 0.746/0.848/0.913/0.044 ms

with a driver from rtl8192ee_revised.tar.bz2 file in
https://github.com/lwfinger/rtlwifi_new/tree/extended repository built
against Linux 4.19.65-1-lts ArchLinux current LTS kernel.

Connection speed and stability on a heavy load are also perfect.

Hope this info would help solving current rtl8192ee problem.

Please let me know if any additional info is needed.

Best regards,
Sergey Kharitonov

On Sat, Aug 10, 2019 at 9:16 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 8/9/19 12:25 AM, Sergey Kharitonov wrote:
> > Dear Linux-Wireless,
> > Some time ago a bug was reported
> > https://bugzilla.kernel.org/show_bug.cgi?id=202943 related to
> > rtl8192ee, the essence of which is high ping latency (even to the
> > access point) without downloading something. If you generate a network
> > load with a background download or just ping -i 0.001 -s 512.... the
> > latency stabilizes and stays low.
> > I tested my TP-Link TL-WN881ND v2 adapters (I got two of them in my
> > PCs plugged in different motherboards (ASUS and MSI)) and the problem
> > still persists in kernel 5.2.6 (archlinux current default). Just to
> > mention, I tested with different module options and also two available
> > firmwares I found (rtlwifi/rtl8192eefw.bin and
> > rtlwifi/rtl8192eefw_new.bin).
> > Would you please take some time to look at the bug? I can provide any
> > additional information needed.
> > Please let me know if we can make rtl8192ee driver better.
>
> Sergey,
>
> I have plans to make some improvements on the driver, and I will investigate
> your issue.
>
> I do handle the issues on the drivers I have posted at GitHub.com under the user
> lwfinger, and I follow this list, but I do not look at the kernel bugzilla for
> Realtek wifi issues.
>
> Larry
>
