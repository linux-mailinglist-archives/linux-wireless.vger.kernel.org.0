Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79775396FC5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhFAJEU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 05:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbhFAJEO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 05:04:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71160C061760
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 02:02:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h3so7667386wmq.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S426NvUwnGOCjzkrl5jzsuxo4jUDZnsm79SUS445wp0=;
        b=DU98Ta12dnp3+1qJmCY1HvAVFlbkeVV9lznzFZ5seG9KbpALYJyNts5R6Ya3CXwjVT
         3k2mTY+FwtFZs7sIWNxWDc/g4mZy3t6guXx58N0uK2cyrw/fQpbI6+8PdYMRFb2JRDPo
         GYpW15HA0grtmTqz1XMU5JQicc6w+nAtsqMxaVcsAH9vA6Ku0I+Ziz26GIAKcfsbRjNn
         czKcoWe9zXEkNXoeqW1mDv6YxAMMfhtRvQMNIrhGMOnCTqN6zNi00gfvozGpCwwj047v
         CKwBarpoXK5sryLioEkHdgRQaozXVNY75+JxNTXrbIDXcQ6FjF7MJbJei5eKREP2SFBA
         oJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S426NvUwnGOCjzkrl5jzsuxo4jUDZnsm79SUS445wp0=;
        b=Ojot+cbvX1+2XZXj27i9NEldCQwKLDz1xn0WoUZsCfBY4xZ587T+h327k9Zg4+/B9B
         O4VrEOA1T1VoptAzmAxvtytkGAydHWHP5XuUm0jQxFeSI2GIHIIVxQPoPqoJFEMkPMfT
         pizWeP0tkACi3Z++a8RuG35X9u1YmyucjaoRWFiYzvQoruHoZuzetGZcDzgsH8AcZWDY
         5RY0/pAzwLE/D1FfkGxcW7o/6GjYIHr0UwtT9f2+RPnhDxCajTzj4G5prCMz67Ji68/Q
         GjVJEhL1E6rm8eiR8Zrdw5kMGkMn3K7WoN9AgF8ZhP5SgKqCk/nj/TFpBuJXxBCVa4BJ
         vggA==
X-Gm-Message-State: AOAM531kPxId2srZ4v5Axd+Fjimu3QgX1uOoXCZuUrv0qXAAf3Z9gWde
        0OS7LxE/xqSFbTXt85qimaX3T2caHJaN43heTqK7jw==
X-Google-Smtp-Source: ABdhPJw1e/ioLQZZ/KX8dvjW/dXgB5kdgooECoGWrKzmNX+n/HM9CTBJ+yzkDmkzm7IiH5i1mP4dLwaVIayjpJ+AgSs=
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr592402wmj.63.1622538149944;
 Tue, 01 Jun 2021 02:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622222314-17192-1-git-send-email-martin.fuzzey@flowbird.group> <6f1d3952-c30e-4a6d-9857-5a6d68e962b2@denx.de>
In-Reply-To: <6f1d3952-c30e-4a6d-9857-5a6d68e962b2@denx.de>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Tue, 1 Jun 2021 11:02:19 +0200
Message-ID: <CANh8QzykdFSvmEgY=iTyZdbzg5Uv785zVZdAoYbrx2--sDyiCQ@mail.gmail.com>
Subject: Re: [PATCH] rsi: fix broken AP mode due to unwanted encryption
To:     Marek Vasut <marex@denx.de>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Marek,
thanks for the review.

On Fri, 28 May 2021 at 20:11, Marek Vasut <marex@denx.de> wrote:
>
> > Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
> > CC: stable@vger.kernel.org
>
> This likely needs a Fixes: tag ?
>

I'm not quite sure what that should be.
The test involved here has been present since the very first version
of the driver back in 2014 but at that time AP mode wasn't supported.

AP mode was added in 2017 by the patch series "rsi: support for AP mode" [1]
In particular 38ef62353acb ("rsi: security enhancements for AP mode")
does some stuff relating to AP key configuration but it doesn't
actually change the behaviour concerning the encryption condition.

In fact I don't understand how it ever worked in AP WPA2 mode given
that secinfo->security_enable (which is tested in the encryption
condition) has always been unconditionally set in set_key (when
setting not deleting).
Yet the series cover letter [1] says "Tests are performed to confirm
aggregation, connections in WEP and WPA/WPA2 security."

The problem is that in AP mode with WPA2 there is a set_key done at AP
startup time to set the GTK (but not yet the pairwise key which is
only done after the 4 way handshake) so this sets security_enable to
true which later causes the EAPOL messages to be sent encrypted.

Maybe there have been userspace changes to hostapd that have changed
the time at which the GTK is set?
I had a quick look at the hostapd history but didn't see anything obvious.

I'm going to send a V2 completely removing the security_enable flag in
addition to adding the new test (which is what downstream has too).
Keeping security_enable doesn't actually break anything but is
redundant and confusing.

Unfortunately I cannot find any downstream history, I just have 2
downstream tarballs, a "2.0 RC2" which has the same problem as
mainline and a "2.0 RC4" which does not


[1] https://www.spinics.net/lists/linux-wireless/msg165302.html

> >       if ((!(info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT)) &&
> > +         (info->control.hw_key) &&
>
> The () are not needed.
>

Ok, will fix for V2

> Reviewed-by: Marek Vasut <marex@denx.de>

Seeing as the V2 will be a bit different I won't add that yet.

Martin
