Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637D22EAAF0
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbhAEMbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 07:31:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55626 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbhAEMbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 07:31:09 -0500
Received: from mail-oi1-f200.google.com ([209.85.167.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kwlTm-0003RL-2r
        for linux-wireless@vger.kernel.org; Tue, 05 Jan 2021 12:30:26 +0000
Received: by mail-oi1-f200.google.com with SMTP id i9so22579574oih.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 Jan 2021 04:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XlJoWhqGMZAQjE12c0+/TNt+/+7FA6D1RlAXwPrU4E=;
        b=LB4d3Kui7p48SuJM8G/IPBGIyibz0vOCGzDfceNgPTDJCKECgHxbTy4p3PQl9nrFo2
         9Nu4OiSCys+r+fdDcKh3NiCyoD5bzv/m2ATGI40UpeNWiYHtx099BORvGQcKQ7JvG804
         4rHVqC4JghHcLwkp+O3urpEG2ptGoZ3PwRzT1Y5Z5dHYoZ6iUDu4rVmCowMtDxRdA3SW
         b4ixNT0DJOn0JdT7jkeMt/AyIsqlFbcqYqp7cj2DeQMp5NN6uLBvM0TCNV1VOcXDA3QO
         aNSknkbHt2nvRq5TmDG14SNPRko5904sjTAMVdVZc3SErG7MzMlCybfM5QIb+uib2N0H
         m0Vg==
X-Gm-Message-State: AOAM530zkaE46PUP1kpMzDodYdf/xQu6184nI4QhipylZV3A2YZsOaXm
        wNJ9coQ7axO/G4v2zhqwkBqvPOd8ZS8GYUiDg+r6jG2I7Cve2v6rVn9jZVdtyMk1Z9b7akM/686
        AbosfKbeEdVrtJ55yPsejvrFiNecv6fMK67Vkedqz749PTEmK0jfFB9kCUrsL
X-Received: by 2002:a54:4d83:: with SMTP id y3mr2481724oix.0.1609849824871;
        Tue, 05 Jan 2021 04:30:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzElxkce3p8H5nMVBTtrrEhXBhjjQVjSyr1LrrB32oXEfiqmDVIlDXS6FwWRg3b5XXc2i5zTOtQnWDr4WagPa8=
X-Received: by 2002:a54:4d83:: with SMTP id y3mr2481712oix.0.1609849824520;
 Tue, 05 Jan 2021 04:30:24 -0800 (PST)
MIME-Version: 1.0
References: <CAAd53p7oymvge7DZ1_+7aA45EpNjG=FZ3PNJDv=_UT0ghv+rqQ@mail.gmail.com>
 <e90f1953-cda0-baf7-1b5c-56c649df6b90@lwfinger.net> <CAAd53p4=tAmyCE3QhFP8N9We3T_CGvnLWYgZAH8naWc_njtrOQ@mail.gmail.com>
 <1609294366.3846.3.camel@realtek.com> <CAAd53p7xy8CBg=Hf7_hRJYPtunGMy=vK8a2OkseOfKX6LC=SPg@mail.gmail.com>
 <c429df24468b413b885acc14cc196dac@realtek.com>
In-Reply-To: <c429df24468b413b885acc14cc196dac@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 5 Jan 2021 20:30:12 +0800
Message-ID: <CAAd53p4uVotbsXijpdE456bgQ52DuaPpZPYTz1=xDom1bPNGSw@mail.gmail.com>
Subject: Re: 802.11ac AP mode support on Realtek 8821AE?
To:     Pkshih <pkshih@realtek.com>
Cc:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "hugh.chao@canonical.com" <hugh.chao@canonical.com>,
        "ethan.hsieh@canonical.com" <ethan.hsieh@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jan 5, 2021 at 10:07 AM Pkshih <pkshih@realtek.com> wrote:
>
>
> > -----Original Message-----
> > From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> > Sent: Wednesday, December 30, 2020 11:53 AM
> > To: Pkshih
> > Cc: Larry.Finger@lwfinger.net; linux-wireless@vger.kernel.org; hugh.chao@canonical.com;
> > ethan.hsieh@canonical.com
> > Subject: Re: 802.11ac AP mode support on Realtek 8821AE?
> >
> > On Wed, Dec 30, 2020 at 10:13 AM Pkshih <pkshih@realtek.com> wrote:
> > >
> > > On Fri, 2020-12-25 at 12:16 +0800, Kai-Heng Feng wrote:
> > > > On Fri, Dec 25, 2020 at 2:18 AM Larry Finger <Larry.Finger@lwfinger.net>
> > > > wrote:
> > > > >
> > > > > On 12/24/20 7:26 AM, Kai-Heng Feng wrote:
> > > > > > Hi Ping-Ke,
> > > > > >
> > > > > > We've found that when creating 5G AP on 8821AE, it's not on other
> > > > > > devices' wifi list.
> > > > > >
> > > > > > Here's the steps I used to create an AP:
> > > > > > $ nmcli c add type wifi ifname wlp3s0 con-name hello autoconnect no ssid
> > > > hello
> > > > > > $ nmcli c modify hello 802-11-wireless.mode ap ipv4.method shared
> > > > > > 802-11-wireless.band a
> > > > > > $ nmcli connection up hello
> > > > > >
> > > > > > If we change "802-11-wireless.band" to "bg", then the AP can be
> > > > > > scanned by other devices.
> > > > > > Does 8821AE have hardware capability to support 5G AP?
> > >
> > > Yes, it has hardware capability of 5G AP.
> > >
> > > I want to make sure which chip you use. 8821AE with rtlwifi, or 8821CE with
> > > rtw88?
> >
> > 8821AE with rtlwifi here.
> >
>
> I'm not an expert in network-manager, so I try to bring up 5G softap with hostapd,
> and then my cellphone can connect to it and ping ok.
> Could you try it with attached hostapd configuration file?
>
> I use default configuration but change below
> interface=wlan0
> ssid=test-8821ae
> hw_mode=a
> channel=149
>
> The driver I use is built-in in kernel 5.9.10.
> The hostap is hostap_2_9-1731-g56a1df71e (just list the version I use; I believe other version also work)

Using hostapd directly can make AP in 5G work. So apparently the issue
lies between NetworkManager and WPA supplicant.
However, though it works with hostapd, the signal strength is
extremely weak. Is this expected?

Kai-Heng

>
> ---
> Ping-Ke
>
>
