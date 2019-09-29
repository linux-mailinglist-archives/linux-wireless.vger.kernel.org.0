Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9585FC145E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2019 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfI2Lfu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Sep 2019 07:35:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42314 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfI2Lfu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Sep 2019 07:35:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so5388303qkl.9
        for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2019 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSgR7q9G/7DADEC8hUlzruTvWUQTIjAUgwhjgevHy9w=;
        b=SmnxN5GEHmMZXZGRkyACjyKmKTNZGLb53kA5YSRSGNEhY0iN0tqZTX0D0T3wmd1GcJ
         z5HLHfBmdYwT3PaEhBb9VR9Gl34/xVhov2H4vSh0WuP2AMpEOJkzfH//QJlKNW4fGDd8
         +CcU8I872e23I3a0Pnt2G2ft1EGOxtFBWKhcbdG/3L9YpwQCE4FnlJLLVj6U8aB98Ei9
         tWkZ+QBTKoMuA3eTt7GAbJo9X9aA/JvOgch+5F17lqdzq3HC1LOeYcXgXLWO6Bf5vl4t
         1giLWchSIVaXXfuqHYn+FRA6lmkwwefCpdIK/k4TS1ynWnAKHL6D5SWeLHs03RGoNIb9
         USWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSgR7q9G/7DADEC8hUlzruTvWUQTIjAUgwhjgevHy9w=;
        b=hwmyouoxuVY/V62NLvNN+O34X2t/nEpgAeqWmFVBXwUDVELNMd0/Flb8epfYhTihdM
         6XEEsqztjXfIzrOTScFWiDG4w7JX+LyfSBCly4yPUM2wiLXj+rF0vGTC7Fv/7TRR845E
         sJDiXiFSu8y42YNAr9gv2vGHK3uH6zEpoVanoZGkiaoTxLVls51bscarMtVwnhjW+mBh
         HIDU3U3w5HkoSXBp9kRfoxQGPdGEo/xMaVVCDk2qUZDETqYDeg+fviqQ+RWJqHZd4F7k
         5PA9EGXO7CdpCuEJwA6ig7p2v1pB+lfo/5GYY0gmZlPvAMnwIQYzj2qts62l/nEP4bsm
         +Ykg==
X-Gm-Message-State: APjAAAVsCafqWGmyXvx7WAU9aPBgNj8eoPewfIW2BNboRs7oAIOD4Urw
        q5DQqJ5cW2QlVOoBg3/3WAVOFvoPgCt/7a2XkIVKEA==
X-Google-Smtp-Source: APXvYqyqVQZFiJKKu/GiUBHdIJnl2PaYmEEr3ECfF9Ez+gLCTeeYzfyReEVfvBnXv7Lv8qR4mGIOrxvIjXseKn6pPIU=
X-Received: by 2002:a37:5943:: with SMTP id n64mr13515138qkb.95.1569756949242;
 Sun, 29 Sep 2019 04:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmv74wK2NYuj2JuDUz-og5w+e=H1=ef9eCSMTbO6otaYQatKg@mail.gmail.com>
 <9172166a-eb77-a508-ba54-08fdf96912fc@lwfinger.net> <CAHmv74wNOM1QKUPp2Vax2Z+-JyoFC81WHVZ+XbYgiRMUGxCFUQ@mail.gmail.com>
 <9492be2d-abd1-0e1d-5d80-1a72b0250749@lwfinger.net> <CAHmv74x008FvhDztqOq-EC=d7fSXN7=kEOhQm3TPZn1PDZP=fQ@mail.gmail.com>
 <9b6f5c4c-2775-a5c2-0372-f8eb7ec18628@lwfinger.net> <CAHmv74x7VozPiC3D1c+hXbPPaiAQwaQ1Cpx7tqQFtpuWstj39Q@mail.gmail.com>
 <bef95201-9934-fc6c-416d-815ead3d2aa6@lwfinger.net>
In-Reply-To: <bef95201-9934-fc6c-416d-815ead3d2aa6@lwfinger.net>
From:   Sergey Kharitonov <haritonovsb@gmail.com>
Date:   Sun, 29 Sep 2019 15:35:38 +0400
Message-ID: <CAHmv74woqudQZy1cfiwUBO8XFP7J-zTU-RzE99QbQcW6DZekWQ@mail.gmail.com>
Subject: Re: [Linux Realtek Wi-Fi support] rtl8192ee related bug
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In-kernel version of 5.3.1 works, but provides the same poor latency:
if you're not downloading something in the background, ping gets
higher and higher from around 5ms to around 100ms, then back to ~5.

By saying 'unusable' out-of-the kernel driver I mean that changes that
I made to it (to work with 5.2.X) no longer help to use it with new
5.3.1.
It compiles without errors with several fall-thru warnings, but when I
modprobe it, dmesg says (as far as I could understand) that the module
was unable to load firmware. But modprobe ends with status code = 0.

As a result, there's no wireless device shown by ifconfig or iwconfig at all.

On Sat, Sep 28, 2019 at 8:31 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 9/28/19 6:51 AM, Sergey Kharitonov wrote:
> > Dear Mr. Finger!
> > Today's upgrade to linux 5.3.1 made the OEM Realtek driver (from
> > rtl8192ee_revised_5.x.tar.xz) unusable.
> > Current rtlwifi_new master and extended branches still contain old
> > code which results in a high ping.
> > Can you please somehow add your changes described above to git or wherever?
>
> Those patches were mostly cosmetic and will not affect performance, b ut I will
> apply them.
>
> This mailing list should be discussing the driver in the kernel, not an external
> one. Does the in-kernel version not work?
>
> In addition, "unusable" is not a very descriptive term for a failure.
>
> Larry
