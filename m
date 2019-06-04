Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51F734CE3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2019 18:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfFDQJi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jun 2019 12:09:38 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45334 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfFDQJi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jun 2019 12:09:38 -0400
Received: by mail-vs1-f65.google.com with SMTP id n21so8088880vsp.12
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2019 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JJnKTszq0LucT9tff8aVBNiTlpqFIuwICl/wZRuN/SM=;
        b=GQPGFwKdD+yYos6fP+5thtoEjgvr0MNDy0yHYc8fZz73MyW879mUUBZAhYk/YR5/zU
         9hIznQ03ADry6HE/yWZjoTrxElltsqKGduoZz2kRZMN1cCWbM/+RGRexzWI62NcqV19V
         CocEHM4nD9FB9MbHrma4vtmwngw3CVYG9b9VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JJnKTszq0LucT9tff8aVBNiTlpqFIuwICl/wZRuN/SM=;
        b=AKwGJT9sDNTd7TKGmXzPmc9bu+UsVVUDnLky+9TxC25xjSK76zjcB290rTcVG+Uhg3
         kv3lbYbMmT3doyQfeyBPYW2xCl6ST6Yu+gL6z2wEyF3+OyRfAk9hmcm2nZH1fTozDLZx
         HdpaQlUvHLp5B2rldoo5BkL86WCmaie63B8bEL3iotcK8dxNbym+e3PVsN7DOORUzd2n
         od4YTAJQyfo1B1BEE9tz5IcGCh/xFjyNqF6aYVsA5UBEHPjcpjcRyTiDflKFU+m4SyKb
         NYcsUM4zLdVQtwkv42zoRuvhuxwME5M3zOmHSCeKyfw2J+1IZOw5mixqu6dF97W+7yCG
         v7NA==
X-Gm-Message-State: APjAAAVEuEVy/YGrpijIU0vkfVpDP7HzloKdybJNTatBvW9P8W+lGX5H
        ejGli7yCoF2ZAMBaGClaQMc2oF8GcvU=
X-Google-Smtp-Source: APXvYqzcae/2qTRdKF27FOopa9QXCNG4oPlHCY2edh7sgzoY1eghczW5X3ve7hMvQZGhC975Hq9zBQ==
X-Received: by 2002:a67:e3c5:: with SMTP id k5mr17527158vsm.221.1559664576881;
        Tue, 04 Jun 2019 09:09:36 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id n68sm18333430vkd.0.2019.06.04.09.09.36
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 09:09:36 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id n2so8003576uad.8
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2019 09:09:36 -0700 (PDT)
X-Received: by 2002:ab0:5ad0:: with SMTP id x16mr15793093uae.124.1559664085104;
 Tue, 04 Jun 2019 09:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190517225420.176893-2-dianders@chromium.org>
 <20190528121833.7D3A460A00@smtp.codeaurora.org> <CAD=FV=VtxdEeFQsdF=U7-_7R+TXfVmA2_JMB_-WYidGHTLDgLw@mail.gmail.com>
 <16aff33f3e0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <16aff358a20.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <40587a64-490b-8b1e-8a11-1e1aebdab2f3@cypress.com>
In-Reply-To: <40587a64-490b-8b1e-8a11-1e1aebdab2f3@cypress.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Jun 2019 09:01:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wr4WsO7Xmei5GB4X91L_sDN331B1_oH+CPZOeFUkxyMg@mail.gmail.com>
Message-ID: <CAD=FV=Wr4WsO7Xmei5GB4X91L_sDN331B1_oH+CPZOeFUkxyMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] brcmfmac: re-enable command decode in sdio_aos for
 BRCM 4354
To:     Wright Feng <Wright.Feng@cypress.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Naveen Gupta <Naveen.Gupta@cypress.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Double Lo <Double.Lo@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Jun 3, 2019 at 8:20 PM Wright Feng <Wright.Feng@cypress.com> wrote:
>
> On 2019/5/29 =E4=B8=8A=E5=8D=88 12:11, Arend Van Spriel wrote:
> > On May 28, 2019 6:09:21 PM Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >
> >> On May 28, 2019 5:52:10 PM Doug Anderson <dianders@chromium.org> wrote=
:
> >>
> >>> Hi,
> >>>
> >>> On Tue, May 28, 2019 at 5:18 AM Kalle Valo <kvalo@codeaurora.org> wro=
te:
> >>>>
> >>>> Douglas Anderson <dianders@chromium.org> wrote:
> >>>>
> >>>> > In commit 29f6589140a1 ("brcmfmac: disable command decode in
> >>>> > sdio_aos") we disabled something called "command decode in sdio_ao=
s"
> >>>> > for a whole bunch of Broadcom SDIO WiFi parts.
> >>>> >
> >>>> > After that patch landed I find that my kernel log on
> >>>> > rk3288-veyron-minnie and rk3288-veyron-speedy is filled with:
> >>>> >   brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep
> >>>> state -110
> >>>> >
> >>>> > This seems to happen every time the Broadcom WiFi transitions out =
of
> >>>> > sleep mode.  Reverting the part of the commit that affects the
> >>>> WiFi on
> >>>> > my boards fixes the problem for me, so that's what this patch does=
.
> >>>> >
> >>>> > Note that, in general, the justification in the original commit
> >>>> seemed
> >>>> > a little weak.  It looked like someone was testing on a SD card
> >>>> > controller that would sometimes die if there were CRC errors on th=
e
> >>>> > bus.  This used to happen back in early days of dw_mmc (the
> >>>> controller
> >>>> > on my boards), but we fixed it.  Disabling a feature on all boards
> >>>> > just because one SD card controller is broken seems bad.  ...so
> >>>> > instead of just this patch possibly the right thing to do is to fu=
lly
> >>>> > revert the original commit.
> >>>> >
> Since the commit 29f6589140a1 ("brcmfmac: disable command decode in
> sdio_aos") causes the regression on other SD card controller, it is
> better to revert it as you mentioned.
> Actually, without the commit, we hit MMC timeout(-110) and hanged
> instead of CRC error in our test.

Any chance I can convince you to provide some official tags like
Reviewed-by or Tested-by on the revert?

> Would you please share the analysis of
> dw_mmc issue which you fixed? We'd like to compare whether we got the
> same issue.

I'm not sure there's any single magic commit I can point to.  When I
started working on dw_mmc it was terrible at handling error cases and
would often crash / hang / stop all future communication upon certain
classes or efforts.  There were dozens of problems we've had to fix
over the years.  These problems showed up when we started supporting
HS200 / UHS since the tuning phase really stress the error handling of
the host controller.

I searched and by the time we were supporting Broadcom SDIO cards the
error handling was already pretty good.  ...but if we hadn't already
made the error handling more robust for UHS tuning then we would have
definitely hit these types of problems.  The only problem I remember
having to solve in dw_mmc that was unique to Broadcom was commit
0bdbd0e88cf6 ("mmc: dw_mmc: Don't start commands while busy").  Any
chance that could be what you're hitting?

What host controller are you having problems with?

-Doug
