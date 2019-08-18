Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5605916A7
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfHRMpR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 08:45:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41769 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRMpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 08:45:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so5889041wrr.8
        for <linux-wireless@vger.kernel.org>; Sun, 18 Aug 2019 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2axUqO7BW/8JGo+TtC7MH/Mt1ZFiLk2XRc0w1LrBFA=;
        b=mGdfTPmmiXtRRsVK5clC/hcrfnL+/X7oI8OfBgNhBOk3gIaCEau8gEB9S3/eAg9Eg5
         rt0TGuF4v5QGCXz3gPFs6yW5RwTn1ee32h/Mlved/1Uos2LxvDmwN52uJW+jdpZ4EAex
         yjENM1Tt29kRC6UE1t8jl7zbSjMuLvR1kIxg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2axUqO7BW/8JGo+TtC7MH/Mt1ZFiLk2XRc0w1LrBFA=;
        b=tZ79PcoluAgoI4OnAeyJuXWlDxtxW9H2SIdfFsxdAfUtZJPjCctW+n0vHxmmC6R0dV
         b603my5OaZiIZN2ckin6sBEi65scAAR5PPIPYr26fCtxXVw24fVeWNMKsRPzTE6mHfk5
         trqhxKAlTWrj/jhJwnBpOFNKUhVStas0/tn0s0M/2WOol4NCQ+5RSBpE7ZA2UxhsaZV8
         NezDmWGV2a5PTXHoGuVQb/lyr2Q4zDY92oHlTMNCuhwzXtHo3m1XBUoAKXxWpxk4+N6J
         WT+XuJXFqlRUQxhUbE4B56gB+lRsDBDJ0VcB7YSVloZ7gWELLKKmkX0FsuZiPCXHvgsg
         Pn5w==
X-Gm-Message-State: APjAAAVTNwcZ0e8dn+WbP/6gJMPmbZoiqJKafLs2upo0cdEQuUBbqclg
        QiChHesWMLZoFzIBw1Xw80QU6fpb0EO+jXf55AWhQA==
X-Google-Smtp-Source: APXvYqwPdJ5cn3hOeRS8SiLPSklEPlywvHiHvnoysw18xv8yvEqS8q2aUJepTQJ6Lrc+rN5hEFFrJNcoq488n8vaojI=
X-Received: by 2002:adf:facc:: with SMTP id a12mr19969296wrs.205.1566132314527;
 Sun, 18 Aug 2019 05:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190818104629.GA27360@amd>
In-Reply-To: <20190818104629.GA27360@amd>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sun, 18 Aug 2019 14:45:03 +0200
Message-ID: <CAOf5uwmprKDNd-6C0xigdV5ZdkGOquwoXcMVbteK9XNE+sKqSA@mail.gmail.com>
Subject: Re: wifi on Motorola Droid 4 in 5.3-rc2
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Pavel

For the second part

On Sun, Aug 18, 2019 at 12:46 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> First, I guess I should mention that this is first time I'm attempting
> to get wifi going on D4.
>
> I'm getting this:
>
> user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
> user@devuan:~/g/ofono$ sudo ifconfig wlan0 up
> user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
> wlan0     Interface doesn't support scanning.
>
> user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
> user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
> wlan0     Interface doesn't support scanning.
>
> user@devuan:~/g/ofono$
>
> I'm getting this warning during bootup:
>
> [   13.733703] asoc-audio-graph-card soundcard: No GPIO consumer pa
> found
> [   14.279724] wlcore: WARNING Detected unconfigured mac address in
> nvs, derive from fuse instead.

This is ok. It means that your nvs file is not the original one taken
from android

> [   14.293273] wlcore: WARNING Your device performance is not
> optimized.

you can use plt command with calibrate

Michael

> [   14.304443] wlcore: WARNING Please use the calibrator tool to
> configure your device.
> [   14.317474] wlcore: loaded
> [   16.977325] motmdm serial0-0: motmdm_dlci_send_command: AT+VERSION=
> got MASERATIBP_N_05.25.00R,026.0R,XSAMASR01VRZNA026.0R,???
>
> Any ideas?
>
> Best regards,
>                                                                         Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
