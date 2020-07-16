Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA353222B50
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgGPS44 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgGPS4y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 14:56:54 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE39C061755
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 11:56:54 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u12so5712112qth.12
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70SE/U7pRGV79kJ52GTmDFWL8W6o97ZcCDMKg7avm4c=;
        b=KWqnBRPYfekE/fy7fjl1AHbUl8C9KN5J4Ar/Fiwc2ZokexyC/XcVbExlAXpkIqlmfV
         Nn43zMKV/YCcV3sh0N8o7ngVle9H84Cgp3+sReU8HmPQY3t9mAwoN+E7fV5YCtEMSWNE
         JIDIZLEsmQfy5n2uP6coxEu8SBF3A6u17djQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70SE/U7pRGV79kJ52GTmDFWL8W6o97ZcCDMKg7avm4c=;
        b=twK2puoZK/PBd0BoX1A7j9pNxREWlMG2KQwc/CbAEUtDVaB9nJOzox3s9EMT0LQpIi
         ixkFt+2spqDukOnTD06jd+d2PrNU9xI8vZu3cL6rUvhByy8VsHW7W1GJvmSOFj4NSPG9
         PPB5ZDJpeu96CXbPc/fmVIttABSP+KzicNy0FnMUdLA37nDyL1tjMvikCFIDi11kfvJ+
         hcbSapiilohh+5snkI94HmwKIiJJLijdLCdPjpkl0U3KGuuXMNTSi0Gxrb/4xLYKaSwa
         QoWH8Dglpiy6XtzP4ikLUAYn9YEAuLV+Fm6vlS1l9ElcGENaCHqvHBps5c5lBHga77ZT
         kHaQ==
X-Gm-Message-State: AOAM532cTh6VRwKtBINEFfgE/wDBy5ves7RE0zto90LwnlKjh8ekg+BS
        KqmG7mxGEC8AdPOB+KG4tqU0gFaBjpo=
X-Google-Smtp-Source: ABdhPJxrybNFuaoKg47xgKJ0NV/bQtoDwzYl/QV8d4i4bMyTCdIFw6wxhrh0IRiyBRjnygUVdE0qng==
X-Received: by 2002:aed:2462:: with SMTP id s31mr6958421qtc.188.1594925813144;
        Thu, 16 Jul 2020 11:56:53 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id o15sm8004386qko.67.2020.07.16.11.56.51
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 11:56:51 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d27so5758591qtg.4
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 11:56:51 -0700 (PDT)
X-Received: by 2002:ac8:7a9a:: with SMTP id x26mr6609783qtr.161.1594925810582;
 Thu, 16 Jul 2020 11:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
 <1576684108-30177-2-git-send-email-kvalo@codeaurora.org> <1576748692.7758.17.camel@realtek.com>
 <20191219154828.GA12287@w1.fi> <CA+ASDXMTYLGbEkBPHSqtyitMEvY5o_MjU0s+NoWdnN_ORy1gDw@mail.gmail.com>
 <20191219185522.GA16010@w1.fi> <CA+ASDXNOxkrZTxL0Jo4ONR2YtL83BVc_w-rBXc6ggBLdwUpDZw@mail.gmail.com>
 <871rpqly6a.fsf@kamboji.qca.qualcomm.com> <e8908eafd8e6050eef8782c6a7019e318d14f65f.camel@sipsolutions.net>
 <CA+ASDXMf7iXuE9hQ-XitPPfvXP0EK5FchJLCu2+5Ag=ZC=0H0w@mail.gmail.com> <87lfjjx0o7.fsf@codeaurora.org>
In-Reply-To: <87lfjjx0o7.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 16 Jul 2020 11:56:39 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOAzPuOn_rMsRj4t56kC-TgoG0p5WhSTPJjB8xTTq5kfg@mail.gmail.com>
Message-ID: <CA+ASDXOAzPuOn_rMsRj4t56kC-TgoG0p5WhSTPJjB8xTTq5kfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power limits
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>, Jouni Malinen <j@w1.fi>,
        Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jul 16, 2020 at 2:35 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Brian Norris <briannorris@chromium.org> writes:
> > Really, I could live with per-vendor APIs. My primary goal is to get
> > these upstream in some form, so vendors can stop using things like
> > this as a reason for shipping us non-upstream code, and so we can
> > reduce the delta between upstream and Chrome OS kernels.
> >
> > I also think that, for the cases that warrant it (i.e., the option 2
> > -- Realtek and Qualcomm cases, so far), it would be good to have a
> > common API, but that's a somewhat secondary concern for me.
>
> So to me it feels like the best solution forward is to go with the
> vendor API, do you agree? We can, of course, later switch to the common
> API if we manage to create one which is usable for everyone.

That's fine with me. That's pretty much what I said in my first email:

"Anyway, I don't really object with starting out with a
Qualcomm-specific and a Realtek-specific vendor command to implement
nearly the same feature, but I'd prefer if people did engage in some
healthy discussion about why they can't share an API, with the hopes
that maybe they can converge someday."

I think we've had some healthy (though very protracted) discussion,
and I don't think I've seen anyone bring up anything I wasn't already
aware of that would prevent eventual consolidation. As long as we
acknowledge those things (item 2 at
https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api),
I'm happy.

> > Also, Kalle had some concerns about stable ABI questions: shouldn't we
> > bake in some kind of "check for support" feature to these kinds of
> > APIs [3]? That would help ease transition, if we do start with a
> > vendor API and move to a common one in the future.
>
> Yeah, that sounds like a good idea but I don't think that should block
> these patches.

OK, well it was your concern first, IIRC :)

So what's next? A v2 that only needs a bit of updated description
about "why a vendor API"? And Realtek can feel free to submit this [1]
shortly?

Thanks,
Brian

[1] Series: rtw88: Add SAR implementation
https://patchwork.kernel.org/project/linux-wireless/list/?series=238219&state=*
