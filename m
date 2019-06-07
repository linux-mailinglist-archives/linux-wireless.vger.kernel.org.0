Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21E393D3
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 20:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfFGSAR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 14:00:17 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53283 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbfFGSAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 14:00:16 -0400
Received: by mail-it1-f196.google.com with SMTP id m187so4035309ite.3
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpEKImARlNSrR2CnDXXq0hDAys3pJayRssH3rrFbf2w=;
        b=B/6hqqM0rL+x3KFCsh7CUaMSPWa9JWojv6AjMWoMhrS0wrU1xTYxzwXiUvpjHpkUQw
         SNx2W7ZoTf+ySa7oHh505uHwWR+M3fqOEIJUN0a63wixYrtcrvUANb5EgLcalI+np2RJ
         HiB74IYHz905zihBSHU9WNQVreYfYBXw2lEW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpEKImARlNSrR2CnDXXq0hDAys3pJayRssH3rrFbf2w=;
        b=MTM1pl6c2p+tE/gH4sGZDkp/nfqkoK7B0LdBIkaiDIAMMr9SPwGKSgg3z+WQKIsqbd
         K2/M2SmnYsVVQZ3XMgV3+Fba7qkzbFSjcL6thjE8eZC9ZKBjgw8BLPQUSWeey/ucpUnQ
         i+d+SD9ms0OOvdRGCwT3ST6zG4aI1yTgoH0VkLiYhjWIgF1hilaXIu4w3LmIgDnwsTcC
         zOTIascGL1hLg/uFcJLWCD5VBQ8qJ2J3T83rJRtiLUBr/naeH1s3DTJ3sAwkTlm8Chq5
         ah1KbxxmXG0qlZTiSGED8zHPfDZ6cxvSMlx1+4NEqA1t5gGIrDHiPztBwZJfHi4MXBPh
         3KLQ==
X-Gm-Message-State: APjAAAXtUH5MHGWWGoL7t+tHXnUSaPm/LsFM/B6FHIy/tT1jsyr61HMo
        ypq5VFBG6bdSDHV13NwglhNJtbUX7/U=
X-Google-Smtp-Source: APXvYqyfLh7Za9qpruhzCPkiGRL9uyaRdNnxeNzD5dYAb3hwh0hYr9D//gS9rj+79QUi/BSDkV04Mg==
X-Received: by 2002:a02:6307:: with SMTP id j7mr36603435jac.65.1559930415740;
        Fri, 07 Jun 2019 11:00:15 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id e3sm1111205ith.18.2019.06.07.11.00.14
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:00:14 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id w25so2080027ioc.8
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 11:00:14 -0700 (PDT)
X-Received: by 2002:a6b:b642:: with SMTP id g63mr18948289iof.142.1559930414169;
 Fri, 07 Jun 2019 11:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190603183740.239031-1-dianders@chromium.org>
 <20190603183740.239031-4-dianders@chromium.org> <42fc30b1-adab-7fa8-104c-cbb7855f2032@intel.com>
 <CAD=FV=UPfCOr-syAbVZ-FjHQy7bgQf5BS5pdV-Bwd3hquRqEGg@mail.gmail.com> <2e9f80af-aa26-5590-9ff0-9889400068d6@intel.com>
In-Reply-To: <2e9f80af-aa26-5590-9ff0-9889400068d6@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Jun 2019 11:00:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGxXvcCuuspAkHY=m+vhQ+R96i4HCBZNCO1-jQ5U9+3Q@mail.gmail.com>
Message-ID: <CAD=FV=WGxXvcCuuspAkHY=m+vhQ+R96i4HCBZNCO1-jQ5U9+3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] brcmfmac: sdio: Disable auto-tuning around
 commands expected to fail
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Franky Lin <franky.lin@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Jun 7, 2019 at 5:29 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> >> @@ -711,8 +720,16 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
> >>                         err_cnt = 0;
> >>                 }
> >>                 /* bail out upon subsequent access errors */
> >> -               if (err && (err_cnt++ > BRCMF_SDIO_MAX_ACCESS_ERRORS))
> >> -                       break;
> >> +               if (err && (err_cnt++ > BRCMF_SDIO_MAX_ACCESS_ERRORS)) {
> >> +                       if (!retune_release)
> >> +                               break;
> >> +                       /*
> >> +                        * Allow one more retry with re-tuning released in case
> >> +                        * it helps.
> >> +                        */
> >> +                       sdio_retune_release(bus->sdiodev->func1);
> >> +                       retune_release = false;
> >
> > I would be tempted to wait before adding this logic until we actually
> > see that it's needed.  Sure, doing one more transfer probably won't
> > really hurt, but until we know that it actually helps it seems like
> > we're just adding extra complexity?
>
> Depends, what is the downside of unnecessarily returning an error from
> brcmf_sdio_kso_control() in that case?

I'm not aware of any downside, but without any example of it being
needed it's just untested code that might or might not fix a problem.
For now I'm going to leave it out of my patch and if someone later
finds it needed or if you're convinced that we really need it we can
add it as a patch atop.

-Doug
