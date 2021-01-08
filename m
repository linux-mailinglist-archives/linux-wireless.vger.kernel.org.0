Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6A2EEE6B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jan 2021 09:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbhAHIQ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jan 2021 03:16:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39183 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbhAHIQ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jan 2021 03:16:58 -0500
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kxmwR-0004Hm-7i
        for linux-wireless@vger.kernel.org; Fri, 08 Jan 2021 08:16:15 +0000
Received: by mail-lf1-f72.google.com with SMTP id w11so7763970lff.22
        for <linux-wireless@vger.kernel.org>; Fri, 08 Jan 2021 00:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REesL7QBmEQnhMhvGq3VomUrVVNbzxhY+pMBcaqPvVE=;
        b=jmHQRsIBfZGyoe3foTo0lOPh3PxNWkPBKbrUzw1Ne4v5wyc4SDKffvWHJy89H7tX+z
         g/D9i0HGZe2ql08kw4VUJcOw/8RWNxm1yLjXq6XUw1hQXJ16L27pc35J8O06GtBFu6O0
         hrCbd9hiDRUWDTfBQfz51838JdBNnDcHfbiYUFGgTT5/76N3drb3cteovruk4m3Aq1Q+
         svSf1wgb+aoOO7Ro2mOxVv4GWf68oRiOBGQrjsnNuCGdrb/n7H50kVEgl9UojXqO7BDQ
         hu00PD09MVrAklLn1sLGz5LZIBQpKmJKRBMRaIj5Y/aQtDy2Ah/bU8vvdfPlpOxj2kVP
         Js6Q==
X-Gm-Message-State: AOAM532QvC9LyNTizUAMrTuYaw/jMcet4ldTs1qd+nXd+0dqadOdzMlH
        2HmRTnGbVYbnKGx1vkpfYNSBepP/HN4bmJVjyDu6UAocBBRIUQZQEfMgNRt73HC79q32lEnF+Si
        nEbvj2AGyx0WTO8m2zyjexyJFiUZ7Q04TtGrfcTEgGH+X9+HBAKYtql2qOM95
X-Received: by 2002:a19:dc5:: with SMTP id 188mr1236002lfn.513.1610093774679;
        Fri, 08 Jan 2021 00:16:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxo7NtVJMWhTlbC504E2Ei/r6u6gbEf6EjORs7Q4Tv+o1d/U8SFTzgp5prHG9cZn7A24YDeaX6qqGOi5SP2ZY0=
X-Received: by 2002:a19:dc5:: with SMTP id 188mr1235992lfn.513.1610093774439;
 Fri, 08 Jan 2021 00:16:14 -0800 (PST)
MIME-Version: 1.0
References: <CAAd53p7oymvge7DZ1_+7aA45EpNjG=FZ3PNJDv=_UT0ghv+rqQ@mail.gmail.com>
 <e90f1953-cda0-baf7-1b5c-56c649df6b90@lwfinger.net> <CAAd53p4=tAmyCE3QhFP8N9We3T_CGvnLWYgZAH8naWc_njtrOQ@mail.gmail.com>
 <1609294366.3846.3.camel@realtek.com> <CAAd53p7xy8CBg=Hf7_hRJYPtunGMy=vK8a2OkseOfKX6LC=SPg@mail.gmail.com>
 <c429df24468b413b885acc14cc196dac@realtek.com> <CAAd53p4uVotbsXijpdE456bgQ52DuaPpZPYTz1=xDom1bPNGSw@mail.gmail.com>
 <1610085185.5799.10.camel@realtek.com>
In-Reply-To: <1610085185.5799.10.camel@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 8 Jan 2021 16:16:03 +0800
Message-ID: <CAAd53p4Q7UQ_HjvqgN46AT0NOhr3r1Gmgnq4hgrS+0s7kbNuOQ@mail.gmail.com>
Subject: Re: 802.11ac AP mode support on Realtek 8821AE?
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "hugh.chao@canonical.com" <hugh.chao@canonical.com>,
        "ethan.hsieh@canonical.com" <ethan.hsieh@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 8, 2021 at 1:53 PM Pkshih <pkshih@realtek.com> wrote:
>
> On Tue, 2021-01-05 at 12:30 +0000, Kai-Heng Feng wrote:
> > On Tue, Jan 5, 2021 at 10:07 AM Pkshih <pkshih@realtek.com> wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> > > > Sent: Wednesday, December 30, 2020 11:53 AM
> > > > To: Pkshih
> > > > Cc: Larry.Finger@lwfinger.net; linux-wireless@vger.kernel.org; hugh.chao@c
> > anonical.com;
> > > > ethan.hsieh@canonical.com
> > > > Subject: Re: 802.11ac AP mode support on Realtek 8821AE?
> > > >
> > > > On Wed, Dec 30, 2020 at 10:13 AM Pkshih <pkshih@realtek.com> wrote:
> > > > >
> > > > > On Fri, 2020-12-25 at 12:16 +0800, Kai-Heng Feng wrote:
> > > > > > On Fri, Dec 25, 2020 at 2:18 AM Larry Finger <Larry.Finger@lwfinger.ne
> > t>
> > > > > > wrote:
> > > > > > >
> > > > > > > On 12/24/20 7:26 AM, Kai-Heng Feng wrote:
> > > > > > > > Hi Ping-Ke,
> > > > > > > >
> > > > > > > > We've found that when creating 5G AP on 8821AE, it's not on other
> > > > > > > > devices' wifi list.
> > > > > > > >
> > > > > > > > Here's the steps I used to create an AP:
> > > > > > > > $ nmcli c add type wifi ifname wlp3s0 con-name hello autoconnect
> > no ssid
> > > > > > hello
> > > > > > > > $ nmcli c modify hello 802-11-wireless.mode ap ipv4.method shared
> > > > > > > > 802-11-wireless.band a
> > > > > > > > $ nmcli connection up hello
> > > > > > > >
> > > > > > > > If we change "802-11-wireless.band" to "bg", then the AP can be
> > > > > > > > scanned by other devices.
> > > > > > > > Does 8821AE have hardware capability to support 5G AP?
> > > > >
> > > > > Yes, it has hardware capability of 5G AP.
> > > > >
> > > > > I want to make sure which chip you use. 8821AE with rtlwifi, or 8821CE
> > with
> > > > > rtw88?
> > > >
> > > > 8821AE with rtlwifi here.
> > > >
> > >
> > > I'm not an expert in network-manager, so I try to bring up 5G softap with
> > hostapd,
> > > and then my cellphone can connect to it and ping ok.
> > > Could you try it with attached hostapd configuration file?
> > >
> > > I use default configuration but change below
> > > interface=wlan0
> > > ssid=test-8821ae
> > > hw_mode=a
> > > channel=149
> > >
> > > The driver I use is built-in in kernel 5.9.10.
> > > The hostap is hostap_2_9-1731-g56a1df71e (just list the version I use; I
> > believe other version also work)
> >
> > Using hostapd directly can make AP in 5G work. So apparently the issue
> > lies between NetworkManager and WPA supplicant.
> > However, though it works with hostapd, the signal strength is
> > extremely weak. Is this expected?
> >
>
> I found PHY and RF parameters are not updated properly years ago.
> It would be much better if attached patch is applied. Please help to
> try if it also works for you.

Thanks, the signal strength still isn't super strong but much better
than the previous state.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
> side note: I don't submit this patch immediately, because I need
> time to verify this patch before submitting.
>
> ---
> Ping-Ke
>
