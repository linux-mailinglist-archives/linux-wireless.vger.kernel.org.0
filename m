Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172FE50F159
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 08:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245690AbiDZGqG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 02:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243873AbiDZGp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 02:45:59 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDEB12C8D9
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 23:42:51 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b5so10831084ile.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZXWw+mQ5SzKYx4pfHPUdeVXw0Lw7Zqv4OHZg6/bECE=;
        b=OKJwseg1BeqVGbbzLWqwmGv8I2ybhlAXs0ZZiquP8s51TudFvCYmyB/NFxUejLaeFQ
         8YURQdOA78Loxv1i/wvBL8VaG+Sub/jxhqrSmKlyLsKQKgMupTsdUNHzVYeRVj81Ggg8
         1T3lKGQ0zuv/y700/wT44FGJuCuomHnhlUHA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZXWw+mQ5SzKYx4pfHPUdeVXw0Lw7Zqv4OHZg6/bECE=;
        b=HHHae+P2Vk3DTldOhjkLIQGayR3HYjNC+xHIcDIPbO47ERcABM5PGEzBCBgKNfVMxb
         XNKF3qeKDNl5j0bbHIfb8zNEmnFB3MYGganh+U2ZUC/JHNjrUe2ExwavuBj7MSJTTjFb
         OmQaxeyGTmpZvfVVSGf88QkZYZA62WFRVupTITh47G2fUnbsyeqhgJblzuW9O+VcNA5c
         7XJjoYimgLugHwGuarKqAjJZ6H4/E5kKoLxX86OD3PePymBbobLA9xWZ+Bd6tpQkiOU2
         apZqY8jqs9WavYZfsxxYTU3YEOVvDfnvHdmnZJPR+41cJ3FeP3WFrr535+2ByVDq/Yal
         nUqQ==
X-Gm-Message-State: AOAM531kOM08qbYZF4446kR4xc1CY49WIqgE6CSCDl/iJ+6UdeRHdEfz
        AnlRX6DfnxgXYAC9zFWBtLUWCrNYwqnobXJTZGT1cQ==
X-Google-Smtp-Source: ABdhPJxH9n+PwfsCKTqGm/BpdLMkKverpXfcsHBbklasMzhpv4vrvXWAKTyAnSm2FEo0e4Wj/1yceplZhDz1BC7+DfU=
X-Received: by 2002:a05:6e02:1c04:b0:2cc:183f:b8cc with SMTP id
 l4-20020a056e021c0400b002cc183fb8ccmr8436041ilh.51.1650955371082; Mon, 25 Apr
 2022 23:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220425021442.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid>
 <YmcqsFyCMqcWAEMM@google.com> <YmcrBFZ0CB/7abzW@google.com>
In-Reply-To: <YmcrBFZ0CB/7abzW@google.com>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Mon, 25 Apr 2022 23:42:39 -0700
Message-ID: <CACTWRwtXsAyudCvNJ1Cuo+Ow3tYN_uaes7QNWzOzHhTjOKzxVA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: skip ath10k_halt during suspend for driver state RESTARTING
To:     Brian Norris <briannorris@chromium.org>
Cc:     kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        netdev@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 25, 2022 at 4:13 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Mon, Apr 25, 2022 at 04:11:44PM -0700, Brian Norris wrote:
> > On Mon, Apr 25, 2022 at 02:15:20AM +0000, Abhishek Kumar wrote:
> > > --- a/drivers/net/wireless/ath/ath10k/mac.c
> > > +++ b/drivers/net/wireless/ath/ath10k/mac.c
> > > @@ -5345,8 +5345,22 @@ static void ath10k_stop(struct ieee80211_hw *hw)
> ...
> > > +                   /* If the current driver state is RESTARTING but not yet
> > > +                    * fully RESTARTED because of incoming suspend event,
> > > +                    * then ath11k_halt is already called via
> >
> > s/ath11k/ath10k/
> >
> > I know ath11k is the hot new thing, but this is ath10k ;)
> >
> > > +                    * ath10k_core_restart and should not be called here.
> >
> > s/ath10k/ath11k/
>
> Oh boy, I got *that* backwards! Should be this, obviously:
>
> s/ath11k/ath10k/
>
> > > +                    */
> > > +                   if (ar->state != ATH10K_STATE_RESTARTING)
> > > +                           ath10k_halt(ar);
> > > +                   else
> > > +                           /* Suspending here, because when in RESTARTING
> > > +                            * state, ath11k_core_stop skips
> >
> > s/ath10k/ath11k/
>
> Same.
Oh!, lately working on ath11k mostly and the muscle memory kicked in
... sorry about this, will fix in next revision. Kale whenever you get
time, let me know if the logic looks good to you and if ath11k/ath10k
typo fix is the only comment.

Thanks
Abhishek
>
> Brian
