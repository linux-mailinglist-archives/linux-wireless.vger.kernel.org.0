Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBAA2CAAC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfE1PwJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 11:52:09 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33253 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1PwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 11:52:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id y6so506858vsb.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wS8hoqDHHdUU+aVRiUjUMRbeoVex4X+b9To5bYeyjZ8=;
        b=JQnCETd2IGwTVEqh1W9deTB9fYhcQJX6SMUGhSDGjkZYZLhB0pKmx6lNWyqBBg4T3k
         YnYqFvYU1x9cmheUMM9BwRitTXwwaV9CqogdqQxH/UUbtvQx/7yZoICE1RcfqiQFYjjc
         SM3QyVkgaOPA7sDG30y2oiu2Ruha/g0sxwzKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wS8hoqDHHdUU+aVRiUjUMRbeoVex4X+b9To5bYeyjZ8=;
        b=mZ2skPkG+pWxr2/SGfpa0lfvPNeOiw5cDBsiC+I8UPlmg7UwnCJuq0TjXQntEgW7H4
         uVIO+coho4Bc3v5Bv/3Yw2IT2OfJs4FIpy/yeWLesvMQd/KaBy5ngK+ZzFRvMzm/bz92
         yOYZODzN/guR1e/sbP2EmDf/F3l3RRSiKStY5SPPV5jXF0t9m2AbQtmf0lY1t3clgYF9
         M2+Pe5BBwp1vu8VcQEO5FJiRuGoVegtZjQGUgkJekP+WZAHlnvSVZ40dw57uGbm11nsc
         NePQMCL97Ud2+VBkpQYwyQVBORKVgWSgOPi/KYP8ZJqveucm7MGxAxvrxFaES7PVpsVL
         I+mQ==
X-Gm-Message-State: APjAAAX2DZGIYvzMjUZwY1JfRiltmIaHdkXpOLH85vkJGxg5o4YZccek
        fS3oPTERMEhAdLKHUNfg7WUC36SL12Y=
X-Google-Smtp-Source: APXvYqyQE5W4helsPwzPF75FA1f/fUUV2A0fW5UIOl804plpvVe7kb/7alSxIxlUVya1ZgiPlBUXyQ==
X-Received: by 2002:a67:ce10:: with SMTP id s16mr27716359vsl.74.1559058727805;
        Tue, 28 May 2019 08:52:07 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id l132sm1646573vkd.39.2019.05.28.08.52.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 08:52:06 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id y6so506746vsb.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 08:52:05 -0700 (PDT)
X-Received: by 2002:a67:ebd6:: with SMTP id y22mr57926194vso.87.1559058725303;
 Tue, 28 May 2019 08:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190517225420.176893-2-dianders@chromium.org> <20190528121833.7D3A460A00@smtp.codeaurora.org>
In-Reply-To: <20190528121833.7D3A460A00@smtp.codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 May 2019 08:51:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VtxdEeFQsdF=U7-_7R+TXfVmA2_JMB_-WYidGHTLDgLw@mail.gmail.com>
Message-ID: <CAD=FV=VtxdEeFQsdF=U7-_7R+TXfVmA2_JMB_-WYidGHTLDgLw@mail.gmail.com>
Subject: Re: [PATCH 1/3] brcmfmac: re-enable command decode in sdio_aos for
 BRCM 4354
To:     Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        Matthias Kaehlcke <mka@chromium.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list@cypress.com, Double Lo <double.lo@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, May 28, 2019 at 5:18 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Douglas Anderson <dianders@chromium.org> wrote:
>
> > In commit 29f6589140a1 ("brcmfmac: disable command decode in
> > sdio_aos") we disabled something called "command decode in sdio_aos"
> > for a whole bunch of Broadcom SDIO WiFi parts.
> >
> > After that patch landed I find that my kernel log on
> > rk3288-veyron-minnie and rk3288-veyron-speedy is filled with:
> >   brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
> >
> > This seems to happen every time the Broadcom WiFi transitions out of
> > sleep mode.  Reverting the part of the commit that affects the WiFi on
> > my boards fixes the problem for me, so that's what this patch does.
> >
> > Note that, in general, the justification in the original commit seemed
> > a little weak.  It looked like someone was testing on a SD card
> > controller that would sometimes die if there were CRC errors on the
> > bus.  This used to happen back in early days of dw_mmc (the controller
> > on my boards), but we fixed it.  Disabling a feature on all boards
> > just because one SD card controller is broken seems bad.  ...so
> > instead of just this patch possibly the right thing to do is to fully
> > revert the original commit.
> >
> > Fixes: 29f6589140a1 ("brcmfmac: disable command decode in sdio_aos")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I don't see patch 2 in patchwork and I assume discussion continues.

Apologies.  I made sure to CC you individually on all the patches but
didn't think about the fact that you use patchwork to manage and so
didn't ensure all patches made it to all lists (by default each patch
gets recipients individually from get_maintainer).  I'll make sure to
fix for patch set #2.  If you want to see all the patches, you can at
least find them on lore.kernel.org linked from the cover:

https://lore.kernel.org/patchwork/cover/1075373/


> Please resend if/when I need to apply something.
>
> 2 patches set to Changes Requested.
>
> 10948785 [1/3] brcmfmac: re-enable command decode in sdio_aos for BRCM 4354

As per Arend I'll change patch #1 to a full revert instead of a
partial revert.  Arend: please yell if you want otherwise.

-Doug
