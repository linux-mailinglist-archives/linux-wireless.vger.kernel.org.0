Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2563B19355B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 02:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCZBpf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 21:45:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33099 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZBpf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 21:45:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id c20so3506242lfb.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2020 18:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVbIGUZzmVzjAjzBPYKxAday7rRrd8gW10hEb8uhH6A=;
        b=iInKPqb+jCE9iBp+FzkJKX23ycUfM+n/4DJSZn3jJ1nRr/JCDdnEAM4mYohQrNVW5I
         lf7KF5+GfY1o0ATKLFORsCk0SJqmg4tChgm24sHFuJLzShl+X5h5Ksvi1H6uM6kLg5jF
         CJU020u9izZJiXK40Bxz76UNbC8uNdCpS9yIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVbIGUZzmVzjAjzBPYKxAday7rRrd8gW10hEb8uhH6A=;
        b=UFaew+owP5kB86EGZ504ay33it/mQSaFZFQdFzTfG1IFcBBqihscOW82+zzqP9t9oQ
         +oEUgI6YWT0ph4GOScMom8Dgdx6RxfxSUXUsvvTge4pVhfgMU9B8tXa1Y6SO2ZVmRrxK
         WheFjn9ILPSOim9i43Iv8GV0utTbG6291PoK/4kyp8YsoGB+IoWcqHdG7SsulhtiS/Ho
         HrBToeXi8+GG2GTR8c1ywa6gikQ9++GqEeUSoivSTUToI7PGNmyYhKmlz7rSITTYxomq
         KyjKz35tiM8NlP2wNb38HL5P/KrdqajTOPNq1/60UJfKEjGzqslRSM/l5BpswT6TqBY+
         Wo8Q==
X-Gm-Message-State: AGi0PuZVVvve3+4SEFQwM7poSwVCOYLx7+Dr52j51x+sVchXxRnjkvS1
        vqBtqr0AiM1sgZfjHjGw4k/dki8CjG8=
X-Google-Smtp-Source: APiQypLnPM7tEDHQRuT3ggASeX6uSP9O+ru/PLaDh0r7uhNgZbYUoev7TVOGV1bnLp/kUJyHuUwzZg==
X-Received: by 2002:ac2:50cf:: with SMTP id h15mr429723lfm.127.1585187131677;
        Wed, 25 Mar 2020 18:45:31 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id s10sm493185ljp.87.2020.03.25.18.45.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 18:45:30 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id v16so4670099ljk.13
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2020 18:45:30 -0700 (PDT)
X-Received: by 2002:a2e:b559:: with SMTP id a25mr3465429ljn.280.1585187130419;
 Wed, 25 Mar 2020 18:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200324075216.22553-1-yhchuang@realtek.com> <20200324075216.22553-2-yhchuang@realtek.com>
 <20200324165105.GA99185@google.com> <c17c6e7243e642679a38854e6e6cda96@realtek.com>
In-Reply-To: <c17c6e7243e642679a38854e6e6cda96@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 25 Mar 2020 18:45:19 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM49NW1atMoGgEgU0R7siCnhLf6eRawReGiD=PNe-hMrA@mail.gmail.com>
Message-ID: <CA+ASDXM49NW1atMoGgEgU0R7siCnhLf6eRawReGiD=PNe-hMrA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rtw88: add regulatory process strategy for
 different chipset
To:     Andy Huang <tehuang@realtek.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[ I'll preface this by saying that the more I look at the regulatory
core, the more I realize I'm confused or wrong at times. So forgive me
if I've made errors along the way, and please do correct me. ]

On Tue, Mar 24, 2020 at 8:11 PM Andy Huang <tehuang@realtek.com> wrote:
> > On Tue, Mar 24, 2020 at 03:52:15PM +0800, yhchuang@realtek.com wrote:
> > > --- a/drivers/net/wireless/realtek/rtw88/Kconfig
> > > +++ b/drivers/net/wireless/realtek/rtw88/Kconfig

> > I'm still not sure why rtw88 needs this, and nobody else does. I read
>
> I think in Atheros driver, ATH_REG_DYNAMIC_USER_REG_HINTS config serves
> the same purpose.

Ah, I forgot about that one, sorry.

> > your commit message, but that doesn't sound like something that belongs
> > in a single driver still.
> >
>
> As our previous commit message claims, it is due to FCC [...]

Yes, I saw that: my point was that effectively all drivers are subject
to this FCC rule, and so this could be a common CONFIG_*. But if we
already have the ATH_* one (I missed that, above), I guess we can have
an rtw88 one too. It might be less confusing (and more
straightforwardly-implemented) if we moved this stuff to the core
someday, though.

> > > +   ret = regulatory_hint(hw->wiphy, rtwdev->efuse.country_code);
> > > +   if (ret)
> > > +           rtw_warn(rtwdev, "failed to hint regulatory: %d\n", ret);
> >
> > I don't think this is what you want; you had it right in previous
> > revisions:
> >
> >       if (!rtwdev->efuse.country_worldwide) {
> >               if (regulatory_hint(hw->wiphy, rtwdev->efuse.country_code))
> >                       rtw_err( ... );
> >       }
> >
> > Without the 'country_worlwide' check, you start "hinting" (even on
> > worldwide chips) that you really wanted "country" 00 only, and so we
> > *never* adapt to more strict country settings. That's not how world-wide
> > settings are supposed to work.
>
> It doesn't mean that we want country 00 only, we will get country notifies
> from stack, and we will apply it if we accept it. We don't want stack to change
> the channel plan for us.

I noted this to you privately, but I don't believe it's expected to
call regulatory_hint() with "00". See the kerneldoc:

 * @alpha2: the ISO/IEC 3166 alpha2 the driver claims its regulatory domain
 *      should be in. If @rd is set this should be NULL. Note that if you
 *      set this to NULL you should still set rd->alpha2 to some accepted
 *      alpha2.

Note that "00" is *not* actually an ISO 3166 alpha2 code.

The key problem I'm seeing: once you do this, you establish a
wiphy-specific regd, and this regd never updates its country code or
DFS region according to IE updates. So attributes like
NL80211_ATTR_DFS_REGION and NL80211_ATTR_REG_ALPHA2 remain unset.

Your previous revision -- which for WW settings used
wiphy_apply_custom_regulatory() and *not* regulatory_hint() -- did not
have that problem.

> > Why are you ignoring SET_BY_DRIVER?
>
> Since the notification with NL80211_REGDOM_SET_BY_DRIVER flag might
> comes from an another chipset's regulatory_hint().

Ack.

Brian
