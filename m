Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB594D56B9
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 01:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbiCKA3b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 19:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345277AbiCKA3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 19:29:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8452A1A363A
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 16:28:14 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qt6so15705038ejb.11
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 16:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJotzhJGvWm+YufqU6PpQz3ArjHus4r0EIp+aEcC2NQ=;
        b=oU2DYJ9ubZ08kyUFNEx64k2K9ZSCSnvY0QqZ0Ba5UuSoVuPchLbVNNS2cdlTIFV6Q9
         7DYZEpM/tvSuXQlWZw3A7X9peM2zKTIBtbvLMzymLGZoBym4VM9RwpYhC11Ameeb7HAK
         YApwdT56YOWvIUz5M040GJaZ0RzQa2zxjqWzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJotzhJGvWm+YufqU6PpQz3ArjHus4r0EIp+aEcC2NQ=;
        b=0+3bRuXzvQu82eQSeQUb5sZfGxfJj4keyLTPWPUJokpTL9JR4Qu/QuI1dgs/QLwYMI
         +V948NjKjuZu9zNpAVmenM6uQbtC5UfIkNmpD0CQl5qUOZEoZ9/Jtv0W5UihxFNcrDGX
         Vh+/yzwat3U8PoxVcP7HQ9f7y/d/omCGbqfl6+H6RybcMX8RzS0WReEGXEbgvjJswh19
         GGf2eIWyS07jxsT376aRmxO2NTDtu/Ccybx/i1hbuCQXO6K6Nlbc4q0JRnEJhXwGVycB
         ktr4IJsV/d1dgHDz/pUdKb98DTpk/4E0bJrKeGj/BsjQUITH7Pzo4gzzWn1jV2Uo6+N6
         oWpA==
X-Gm-Message-State: AOAM532GoedQCrYNPvNzx+nD7B3el3lzP11ENkBqp31puPUme7qL2q2V
        22mnnH6e/WVaVSiIx2O0cBATo+wPC777v+WvF9E=
X-Google-Smtp-Source: ABdhPJy4zzyLCfIS/u9NUVYAn2kAlPVI8cj9jR9U2RJlSH9O5sE+eHcC8spCRrSEhrBK88gg8xNpPQ==
X-Received: by 2002:a17:907:980a:b0:6db:799c:cb44 with SMTP id ji10-20020a170907980a00b006db799ccb44mr6228574ejc.485.1646958492297;
        Thu, 10 Mar 2022 16:28:12 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id qt22-20020a170906ecf600b006da6ef9b820sm2322254ejb.112.2022.03.10.16.28.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 16:28:11 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id r6so10178920wrr.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 16:28:10 -0800 (PST)
X-Received: by 2002:a5d:490f:0:b0:1f0:6791:a215 with SMTP id
 x15-20020a5d490f000000b001f06791a215mr5446099wrq.422.1646958490250; Thu, 10
 Mar 2022 16:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20220107200417.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
 <CAD=FV=W5fHP8K-PcoYWxYHiDWnPUVQQzOzw=REbuJSSqGeVVfg@mail.gmail.com> <87sfrqqfzy.fsf@kernel.org>
In-Reply-To: <87sfrqqfzy.fsf@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Mar 2022 16:27:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0Qw-OnKJg8SWk9=e=B0qgqnaTHpuR0cRA0WCmSHSJYQ@mail.gmail.com>
Message-ID: <CAD=FV=U0Qw-OnKJg8SWk9=e=B0qgqnaTHpuR0cRA0WCmSHSJYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ath10k: search for default BDF name provided in DT
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Mar 10, 2022 at 2:06 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
>
> > Hi,
> >
> > On Fri, Jan 7, 2022 at 12:05 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
> >>
> >> There can be cases where the board-2.bin does not contain
> >> any BDF matching the chip-id+board-id+variant combination.
> >> This causes the wlan probe to fail and renders wifi unusable.
> >> For e.g. if the board-2.bin has default BDF as:
> >> bus=snoc,qmi-board-id=67 but for some reason the board-id
> >> on the wlan chip is not programmed and read 0xff as the
> >> default value. In such cases there won't be any matching BDF
> >> because the board-2.bin will be searched with following:
> >> bus=snoc,qmi-board-id=ff
>
> I just checked, in ath10k-firmware WCN3990/hw1.0/board-2.bin we have
> that entry:
>
> BoardNames[1]: 'bus=snoc,qmi-board-id=ff'
>
> >> To address these scenarios, there can be an option to provide
> >> fallback default BDF name in the device tree. If none of the
> >> BDF names match then the board-2.bin file can be searched with
> >> default BDF names assigned in the device tree.
> >>
> >> The default BDF name can be set as:
> >> wifi@a000000 {
> >>         status = "okay";
> >>         qcom,ath10k-default-bdf = "bus=snoc,qmi-board-id=67";
> >
> > Rather than add a new device tree property, wouldn't it be good enough
> > to leverage the existing variant?
>
> I'm not thrilled either adding this to Device Tree, we should keep the
> bindings as simple as possible.
>
> > Right now I think that the board file contains:
> >
> > 'bus=snoc,qmi-board-id=67.bin'
> > 'bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=GO_LAZOR.bin'
> > 'bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=GO_POMPOM.bin'
> > 'bus=snoc,qmi-board-id=67,qmi-chip-id=4320,variant=GO_LAZOR.bin'
> > 'bus=snoc,qmi-board-id=67,qmi-chip-id=4320,variant=GO_POMPOM.bin'
> >
> > ...and, on lazor for instance, we have:
> >
> > qcom,ath10k-calibration-variant = "GO_LAZOR";
> >
> > The problem you're trying to solve is that on some early lazor
> > prototype hardware we didn't have the "board-id" programmed we could
> > get back 0xff from the hardware. As I understand it 0xff always means
> > "unprogrammed".
> >
> > It feels like you could just have a special case such that if the
> > hardware reports board ID of 0xff and you don't get a "match" that you
> > could just treat 0xff as a wildcard. That means that you'd see the
> > "variant" in the device tree and pick one of the "GO_LAZOR" entries.
> >
> > Anyway, I guess it's up to the people who spend more time in this file
> > which they'd prefer, but that seems like it'd be simple and wouldn't
> > require a bindings addition...
>
> In ath11k we need something similar for that I have been thinking like
> this:
>
> 'bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=GO_LAZOR'
>
> 'bus=snoc,qmi-board-id=67,qmi-chip-id=320'
>
> 'bus=snoc,qmi-board-id=67'
>
> 'bus=snoc'
>
> Ie. we drop one attribute at a time and try to find a suitable board
> file. Though I'm not sure if it's possible to find a board file which
> works with many different hardware, but the principle would be at least
> that. Would something like that work in your case?

I'll leave it for Abhishek to comment for sure since he's been the one
actively involved in keeping track of our board-2.bin file. As far as
I know:

* Mostly we need this for pre-production hardware that developers
inside Google and Qualcomm still have sitting around on their desks. I
guess some people are even still using this pre-production hardware to
surf the web?

* In the ideal world, we think that the best calibration would be to
use the board-specific one in these cases. AKA if board_id is 0xff
(unprogrammed) and variant is "GO_LAZOR" then the best solution would
be to use the settings for board id 0x67 and variant "GO_LAZOR". This
_ought_ to be better settings than the default 0xff settings without
the "GO_LAZOR".

* In reality, we're probably OK as long as _some_ reasonable settings
get picked. WiFi might not be super range optimized but at least it
will still come up and work.

-Doug
