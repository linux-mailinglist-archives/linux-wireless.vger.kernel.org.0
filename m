Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C207398159
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jun 2021 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFBGpM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 02:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhFBGpK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 02:45:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65907C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 23:43:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c13so622758plz.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 23:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNCMYsORB2O0j+rBwqWrKCHuWb02Rwsv7Zd/jYnQBrk=;
        b=rkYL51hNyBUVvfeo/Ts/JWjairp3sLaw8Wab8dcs76zfYyT09yCrHcNLwOWMR806h8
         gn9b6kUEb0NBHt9jqHV2MwecHtMN2l3CYF+JnSspfE4WxvKI+8zqnXDBcYwfBcH8Ozgi
         hNeDHnCkCrI4A+hR9EsFwBT5eah0PQrS/raMOFwqM0UdlxJAUbrdIlYJDLzwHp4C4JND
         5/LTOKTnzpihFIQ/xyLwdax2EMVril6A3WFFhg+tef3TUmazybvPKERhfxiMSBfG7bjE
         /UHGyfKmaVkggFvqEH/mPGFYqCfnCH6YeqrC5/KnySr+OPLl6e+8hMraL+ekWOYrC7md
         sbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNCMYsORB2O0j+rBwqWrKCHuWb02Rwsv7Zd/jYnQBrk=;
        b=l8EGBvz4ynU5phRAzuCTWPQsYtI6HS61Kf3bmI70KWMxt3M79FZrg3MlWC7HhyLRvJ
         1Jkt4wX7R1IqBasrU2y4/DgpUjeYJX2/CRb5chK0a5Jtu0mbkEcAHCwGJxRR9Quz+Q0b
         ifRlz3YtqwISp1fpXBrH8c/ocm069hxvwTyffzOBCS4EFhvHccAbEGJxwN5JC+NTomdf
         qDeXdyYhARE0A8oA5WeSi8nAf4YPO1dROv/YNxJ8onbdvMpoq9JCMX/Fn47ip+/2X6nZ
         hhj7PYeGif0PRjCsEAYqqleiJAGWlvMS8AV0KH8600FHFiOiGI/N+IMp0PJZrm5Flvna
         gTvw==
X-Gm-Message-State: AOAM531us1QzP099MKNcuZ2+025AJtaq7nf+lySVr0rijQYFgU9NeL2B
        sSbi7HLB959PIhQsXrBhJfVkbdbiQBXDRFIpusx8Kw==
X-Google-Smtp-Source: ABdhPJyZZUSH0rWkcmogDw1e5BiGDx0GJaN5/8zaj5DMGQU+UY2y+F3XsOlz/Io/znrXPSF4Jc2ce+AJf1LBq2YjMss=
X-Received: by 2002:a17:902:d64e:b029:ef:8b85:d299 with SMTP id
 y14-20020a170902d64eb02900ef8b85d299mr29459130plh.27.1622616207614; Tue, 01
 Jun 2021 23:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210601080538.71036-1-johannes@sipsolutions.net>
 <20210601100320.7d39e9c33a18.I0474861dad426152ac7e7afddfd7fe3ce70870e4@changeid>
 <CAMZdPi-ZaH8WWKfhfKzy0OKpUtNAiCUfekh9R1de5awFP-ed=A@mail.gmail.com> <0555025c6d7a88f4f3dcdd6704612ed8ba33b175.camel@sipsolutions.net>
In-Reply-To: <0555025c6d7a88f4f3dcdd6704612ed8ba33b175.camel@sipsolutions.net>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 2 Jun 2021 08:52:45 +0200
Message-ID: <CAMZdPi8Ca3YRaVWGL6Fjd7yfowQcX2V2RYNDNm-2kQdEZ-Z1Bw@mail.gmail.com>
Subject: Re: [RFC 3/4] wwan: add interface creation support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        M Chetan Kumar <m.chetan.kumar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 1 Jun 2021 at 12:35, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi,
>
> > > +int wwan_register_ops(struct device *parent, const struct wwan_ops *ops,
> > > +                     void *ctxt)
> > > +{
> > > +       struct wwan_dev_reg *reg;
> > > +       int ret;
> > > +
> > > +       if (WARN_ON(!parent || !ops))
> > > +               return -EINVAL;
> > > +
> > > +       mutex_lock(&wwan_mtx);
> > > +       list_for_each_entry(reg, &wwan_devs, list) {
> > > +               if (WARN_ON(reg->dev == parent)) {
> > > +                       ret = -EBUSY;
> > > +                       goto out;
> > > +               }
> > > +       }
> >
> > Thanks for this, overall it looks good to me, but just checking why
> > you're not using the wwan_dev internally to create-or-pick wwan_dev
> > (wwan_dev_create) and register ops to it, instead of having a global
> > new wwan_devs list.
>
> Uh, no good reason. I just missed that all that infrastructure is
> already there, oops.

OK no prob ;-), are you going to resubmit something or do you want I
take care of this?

Regards,
Loic
