Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302AB3BA488
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 22:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhGBUDO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 16:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhGBUDN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 16:03:13 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7443DC061762
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jul 2021 13:00:41 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id g13-20020a4ac4cd0000b029024c717ed8aeso2754697ooq.13
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jul 2021 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aH3w41EwdMyT/8s30UWWDd82Dspwb91q3dRXX79Zl34=;
        b=TrGvzdo2YheAg05MejpJSoFabJW9/gXflvRFaR+XsCNtRJMtMKdnE1UxxXd9NUqdr2
         Fqwr6rcwK434vR7W2XQuifomg8dg4ewPVzDRj8CcyV5HO2oL393Dyh3K5wzQH2Ng0mfH
         MSkru+Y6owiwE+f93cUP2s9gdNOfcaNnlQ+lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aH3w41EwdMyT/8s30UWWDd82Dspwb91q3dRXX79Zl34=;
        b=HX6lv3ZkeXQaEsoI4fNXqqJiocuaovo7TSZF8v5n4Obkan0TgYKrBkdctKgOaJN/gl
         IZsWK5S7WvUyEFScZ28mSCTOib+ggU0SpZyiIi7cS1Vq/lKCJVzIsvra/JONujOYxQzo
         y2f1shVqxyeguI3goOFdE/FnFqUpu8z00FTBYUCCUsL+4q/nC+MHxB2/WU4vHIPbMW0o
         F85unt6SgTCWCnItefduRVlVLFEJ6bqjyI0zTU6oQneI9FwEo0VpL7Wgh0c4Ipkv97Mj
         vy96kvnf0rFCMN8SLzH//rA1zNMFE0eY/0hgxa7OmSqIrt9LhvGYu5M6itCzDFMcQkRj
         wl+A==
X-Gm-Message-State: AOAM531rnF9Tce/LbmYotgXjAZ7samsR8/g3yLmEtvB8i/RffVr8Z1k+
        Yt5bC9jLSkxVnQKUTEPAK26aieXR/iNuTg==
X-Google-Smtp-Source: ABdhPJy0LV74E1qHwbHNKcB8b3pAT4uduH4KXbpwfjz3QFSG2sWkbswe8aXiuRLTwVKsZ+M9+PrSIg==
X-Received: by 2002:a4a:b481:: with SMTP id b1mr1058375ooo.79.1625256040485;
        Fri, 02 Jul 2021 13:00:40 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id c12sm810326oob.23.2021.07.02.13.00.39
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 13:00:39 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id h9so12639281oih.4
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jul 2021 13:00:39 -0700 (PDT)
X-Received: by 2002:aca:a8d6:: with SMTP id r205mr1121595oie.77.1625256039095;
 Fri, 02 Jul 2021 13:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210618064625.14131-1-pkshih@realtek.com> <20210618064625.14131-5-pkshih@realtek.com>
 <20210702072308.GA4184@pengutronix.de> <CA+ASDXNjHJoXgRAM4E7TcLuz9zBmQkaBMuhK2DEVy3dnE-3XcA@mail.gmail.com>
 <20210702175740.5cdhmfp4ldiv6tn7@pengutronix.de> <CA+ASDXP0_Y1x_1OixJFWDCeZX3txV+xbwXcXfTbw1ZiGjSFiCQ@mail.gmail.com>
 <20210702193253.sjj75qp7kainvxza@pengutronix.de>
In-Reply-To: <20210702193253.sjj75qp7kainvxza@pengutronix.de>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 2 Jul 2021 13:00:27 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP8JU+VXQV1ZHLsV88y_Ejr4YbS3YwDmWiKjhYsQ-F2Yw@mail.gmail.com>
Message-ID: <CA+ASDXP8JU+VXQV1ZHLsV88y_Ejr4YbS3YwDmWiKjhYsQ-F2Yw@mail.gmail.com>
Subject: Re: [PATCH 04/24] rtw89: add debug files
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 2, 2021 at 12:32 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> On Fri, Jul 02, 2021 at 11:38:26AM -0700, Brian Norris wrote:
> > Well mainly, I don't really like people dreaming up arbitrary rules
> > and enforcing them only on new submissions.
>
> It is technical discussion. There is no reason to get personal.

I'm not really intending to make this personal, so apologies if it
appeared that way.

What I'm trying to get at is that
(a) no other wireless driver does this, so why should this one? and
(b) the feature you claim this driver can use does not appear suited
to the task.

It's easier to make suggestions than to make them a reality.

> > If such a change was
> > Recommended, it seems like a better first step would be to prove that
> > existing drivers (where there are numerous examples) can be converted
> > nicely, instead of pushing the work to new contributors arbitrarily.
>
> Hm, my experience as patch submitter is rather different, but who knows,
> every subsystem has diffent rules. Good to know, wireless is different.

I'm not an arbiter for "wireless" -- so my thoughts are purely my own
opinion. But I have noted some technical reasons why wireless drivers
may be different than ethernet drivers, and the suggested (again,
purely my own opinion) exercise might show you that your suggestion
won't really work out in practice.

Brian
