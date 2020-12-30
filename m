Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD83E2E75E4
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Dec 2020 04:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgL3Dxn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 22:53:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51835 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL3Dxm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 22:53:42 -0500
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kuSXk-0003pj-Ti
        for linux-wireless@vger.kernel.org; Wed, 30 Dec 2020 03:53:01 +0000
Received: by mail-lf1-f70.google.com with SMTP id 7so9756520lfz.12
        for <linux-wireless@vger.kernel.org>; Tue, 29 Dec 2020 19:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYdIlPGGc7PVtxMFBX411dg4CHeinpfUfkSyc9utqLs=;
        b=FHVwXFvfSDA9SkHce7yNB3JfixAmV/uXBuEVcbsX6CEy1H6G+px3OPF8a6S/eAN/TQ
         jmuiumcRWm+Up492U2N29eKqCJYLDkRPFjMGNd6LKkp6xT0hwwU6nrEAU1i/ZBvYjUBy
         c6s837/QAHNJjC04mFppu2mRTlU6S2f67QZiT42UvCToNBCEPjboO8jyZtZn0+U2RmM3
         YEjBvwDhT5CjmRxQIURX7Tl7Vy/AZPxkmuk15mO3QqpLgF68bkMy1Cv+ZeU9GlBqX6D6
         UTywHB8pVa4qoZ1alKDW0d3X51eOp4KXw+V1JkOHMcViZsTllDGqYdEZJlEPICCJACvw
         jJOw==
X-Gm-Message-State: AOAM531RAv3CZApTE1NyfOybg00pnCKwdEYuCf4eabHx8pzE5cIx2qnn
        2pG0wdcS7U6NlXRtcxGSZWiibqBqNSfcegUVvUbOtf04QG2PTl/l3zhKnxcQkpAqIFX7g71Svpe
        9KAloWufZxspj5kPvlxGUhhCWh9q4z1jLA5PlvavxNslOZco8Ws5f2SGZjfTJ
X-Received: by 2002:ac2:561b:: with SMTP id v27mr21493078lfd.425.1609300380143;
        Tue, 29 Dec 2020 19:53:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuLDCRUXuGk3mY0vcmjKxnFEMS5/w4MugRd5wcnZ8BkbOREuo1f8XWdH8GDSjHvoK08Ze10SMKxqwWkxn++qU=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr21493070lfd.425.1609300379915;
 Tue, 29 Dec 2020 19:52:59 -0800 (PST)
MIME-Version: 1.0
References: <CAAd53p7oymvge7DZ1_+7aA45EpNjG=FZ3PNJDv=_UT0ghv+rqQ@mail.gmail.com>
 <e90f1953-cda0-baf7-1b5c-56c649df6b90@lwfinger.net> <CAAd53p4=tAmyCE3QhFP8N9We3T_CGvnLWYgZAH8naWc_njtrOQ@mail.gmail.com>
 <1609294366.3846.3.camel@realtek.com>
In-Reply-To: <1609294366.3846.3.camel@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 30 Dec 2020 11:52:48 +0800
Message-ID: <CAAd53p7xy8CBg=Hf7_hRJYPtunGMy=vK8a2OkseOfKX6LC=SPg@mail.gmail.com>
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

On Wed, Dec 30, 2020 at 10:13 AM Pkshih <pkshih@realtek.com> wrote:
>
> On Fri, 2020-12-25 at 12:16 +0800, Kai-Heng Feng wrote:
> > On Fri, Dec 25, 2020 at 2:18 AM Larry Finger <Larry.Finger@lwfinger.net>
> > wrote:
> > >
> > > On 12/24/20 7:26 AM, Kai-Heng Feng wrote:
> > > > Hi Ping-Ke,
> > > >
> > > > We've found that when creating 5G AP on 8821AE, it's not on other
> > > > devices' wifi list.
> > > >
> > > > Here's the steps I used to create an AP:
> > > > $ nmcli c add type wifi ifname wlp3s0 con-name hello autoconnect no ssid
> > hello
> > > > $ nmcli c modify hello 802-11-wireless.mode ap ipv4.method shared
> > > > 802-11-wireless.band a
> > > > $ nmcli connection up hello
> > > >
> > > > If we change "802-11-wireless.band" to "bg", then the AP can be
> > > > scanned by other devices.
> > > > Does 8821AE have hardware capability to support 5G AP?
>
> Yes, it has hardware capability of 5G AP.
>
> I want to make sure which chip you use. 8821AE with rtlwifi, or 8821CE with
> rtw88?

8821AE with rtlwifi here.

Kai-Heng

>
> ---
> Ping-Ke
>
