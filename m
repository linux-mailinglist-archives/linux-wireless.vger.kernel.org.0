Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429DDA21BA
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfH2REd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 13:04:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34045 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfH2REd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 13:04:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id x18so3795086ljh.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2019 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrVM6OEXY+lQJU37bLVW76L9I/4YNumzd6/qo1VbAa4=;
        b=OfYO4phX3tNZz8QtbooMOsl4Yde66Uq0C1OyUB53YONzFcqLVQhfCOtuafJ4TNrP4Q
         r3KiNCLATGlL6cfQYwsj7y8uL1b2hagb6vMxOOZsFuyeYcsTozkCoyRElQXt4J6NrjtQ
         8dgsBuoeBsGDjGoYMDRW8sf0ku1ruZvn2SaOFqIxKPNtLi4pHVc/Tva20ce+eLuwqfCp
         zbc6vGQijauD7K5lxMF7ICNmwNdNi2YxVEpug4+wPTI+7zgmo+qtJrr1mtfD7Yg+k/1T
         JY6Kz05rtYn7B1bNwXCEwePdRMoXGAPSlYyqRqqGbGa96DZofGOQ4ksLV6YydhMYcUt2
         CtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrVM6OEXY+lQJU37bLVW76L9I/4YNumzd6/qo1VbAa4=;
        b=ejVqf6IfoA6J9+6e3GOiKXihnIVvoLUKfnhBVAiaOpi3AfmP0RnW4kDellPEKQfmdG
         iHGG8how28nsjRP7/Cs7nTOZnok5vej35RjxnAo7n+MLv1j91S3OZhy2KtuW6kurHuXr
         MgSXQnmhoxlVJtxFxDNc7kNjvOvUYJnqglECis5cAQ16+Ac1VN1IeHCUykQBoPZQD2+p
         n6o4at3FpBaGoEPlOJLWIHCyQRckzbakczAV6if69jjbioM+d42PRbkNsIVG0bWP7H1L
         rfM8WuV4KKvcTF80pwo9FeU2X3cjWdBaxD21KO6xtAnJCg/P0pjEaDD9LXNlFyQwny34
         67EQ==
X-Gm-Message-State: APjAAAUZ74wowKnZtfM4m7nG3HK78CohOu8Yyk63YYWfqDeS/cU5sMk0
        YSSqI2S6g+GcPWe338FS48MA9BCSTALZsDMa9Mj5Gs5FRT4=
X-Google-Smtp-Source: APXvYqwo9vOE1ZjP6QwjZCneg4sVIL+zCVcY0RFArtgwftGJmNxS8k4sSnpHbsHLMAtr95JfHBpCkhL3Ir0WhIvXTKE=
X-Received: by 2002:a2e:2bda:: with SMTP id r87mr153726ljr.3.1567098271030;
 Thu, 29 Aug 2019 10:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
 <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
In-Reply-To: <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
From:   Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Thu, 29 Aug 2019 14:04:19 -0300
Message-ID: <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yes, that's what I (we?) expect.

Yes, wmediumd has some log files, but they don't help me to identify
the reason of the problem. I also unsuccessfully tried to modified the
wmediumd code. Both wmediumd and mac80211_hwsim work fine up to kernel
version 4.17. The problem comes only from kernel 4.18. Since there are
some wmediumd related-codes in mac80211_hwsim, I was wondering whether
something wasn't missing in mac80211_hwsim (or even some needed
changes in wmediumd) that is causing such problem. Another weird thing
is the channel, since the channel is the same as defined in hostapd
and doesn't match 5Ghz channels.


On Thu, Aug 29, 2019 at 11:57 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Hi,
>
> > When I use 2.4Ghz band with -only one- AP (running on top of hostapd)
> > I get a (additional) list of frequencies at 5Ghz. When I do "iw dev ..
> > scan"
> >
> > BSS 02:00:00:00:04:00(on sta1-wlan0) -- associated
> > TSF: 1566905272877856 usec (18135d, 11:27:52)
> > freq: 2422
> > beacon interval: 100 TUs
> > capability: ESS ShortSlotTime (0x0401)
> > signal: -34.00 dBm
> > last seen: 0 ms ago
> > Information elements from Probe Response frame:
> > SSID: simplewifi
> > Supported rates: 1.0* 2.0* 5.5* 11.0* 6.0 9.0 12.0 18.0
> > DS Parameter set: channel 3
> > ERP: Barker_Preamble_Mode
> > Extended supported rates: 24.0 36.0 48.0 54.0
> > Extended capabilities:
> > * Extended Channel Switching
> > * Multiple BSSID
> > * SSID List
> > * Operating Mode Notification
>
> I guess this is the one you expect?
>
> > BSS 02:00:00:00:04:00(on sta1-wlan0)
> > TSF: 1566905274269230 usec (18135d, 11:27:54)
> > freq: 5180
> [...]
> > BSS 02:00:00:00:04:00(on sta1-wlan0)
> > TSF: 1566905274269230 usec (18135d, 11:27:54)
> > freq: 5200
>
> and these are garbage.
>
> > and so on (please notice that channel number and frequency)..
> > iw dev scan returns all the 5Ghz frequencies defined in
> > https://github.com/torvalds/linux/blob/master/drivers/net/wireless/mac80211_hwsim.c#L328
> > It happens only when wmediumd is being used.
>
> Since you cannot reproduce this without wmediumd (and neither can I) I
> assume it's a wmediumd bug, in the sense that it's reporting the frame
> on all the channels, or perhaps without any channel information, or so?
>
> Or possibly the hwsim code that handles this is broken, maybe you could
> see what wmediumd does (does it have any log files?)
>
> johannes
>
