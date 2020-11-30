Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5AA2C8DE6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Nov 2020 20:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgK3TUB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Nov 2020 14:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbgK3TTy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Nov 2020 14:19:54 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08367C061A47
        for <linux-wireless@vger.kernel.org>; Mon, 30 Nov 2020 11:19:10 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k17so6925839vsp.13
        for <linux-wireless@vger.kernel.org>; Mon, 30 Nov 2020 11:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMGjnal/Aq/KlLIqIqqw22222Z1xI0jO/CQiNQfVjOU=;
        b=MVIWvWU2KEd1oVwr7wCYKt5eVbkImM44ifQyNFO6UawNRcaNv57nGaTuem9Gs4L023
         gRwl98CmuhNEQJZ/VVF829iCXS4mFnBKkfgTh9GIkFtIvHJSta4dlEQ6HY7R6dga94ZF
         hKJ1pvxqlbsVz4qW1W+Ml2DlmFeRaYGGfmvGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMGjnal/Aq/KlLIqIqqw22222Z1xI0jO/CQiNQfVjOU=;
        b=Ll5Wwg3tSTP5WjW79jWVbEuYj28xqmYAAetiYTGixh8S4AnsnHKGr60G72kNwI3vNt
         f7QvgW9CtSSsAKA9YB4EbIMEghBjQN3mcDAo09i5MsvpB7ZZWjkdLjhlp8ZPW3CcCYvs
         EQEwmAYOlqWV0wCUUyIYpG2fSAoEORrShG7NmKBLEjjKeGIi43yrv/9TJj2BIE6UtjiD
         Zc8lmlIDYP9UR50GwspXnyNXj7urwa23/kAam6t65050YVqbSnP4cieXciKwy0aVWeA7
         jd/urdAQMNgi9qkaPafuHpkX3nkVEZEl1l+w4lchbonJLI4tTKzZR8C3169oyTu+p2FA
         zRug==
X-Gm-Message-State: AOAM530llVR1WwLF6pIiZ3aMg0wIszPi40+b9Q/FsBvKS7SePGDqLUDA
        m/fgK+qhVKo5qp276j7lWDlJYTrfuHGaaA==
X-Google-Smtp-Source: ABdhPJzAWJ7Qx2CsDRMfGrQKC82USTaNxZmF5dKrfqfTiHPN411TDfRG7z5z7jYIglc/HcJTZZjb2g==
X-Received: by 2002:a67:2d58:: with SMTP id t85mr15653238vst.33.1606763940057;
        Mon, 30 Nov 2020 11:19:00 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id s20sm5400373vsn.14.2020.11.30.11.18.59
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 11:18:59 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id x4so2856297uac.11
        for <linux-wireless@vger.kernel.org>; Mon, 30 Nov 2020 11:18:59 -0800 (PST)
X-Received: by 2002:a9f:3dcc:: with SMTP id e12mr19070983uaj.121.1606763937949;
 Mon, 30 Nov 2020 11:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20201112200906.991086-1-kuabhs@chromium.org> <20201112200856.v2.1.Ia526132a366886e3b5cf72433d0d58bb7bb1be0f@changeid>
 <CAD=FV=XKCLgL6Bt+3KfqKByyP5fpwXOh6TNHXAoXkaQJRzjKjQ@mail.gmail.com>
 <002401d6c242$d78f2140$86ad63c0$@codeaurora.org> <CAD=FV=UnecON-M9eZVQePuNpdygN_E9OtLN495Xe1GL_PA94DQ@mail.gmail.com>
 <002d01d6c2dd$4386d880$ca948980$@codeaurora.org>
In-Reply-To: <002d01d6c2dd$4386d880$ca948980$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 30 Nov 2020 11:18:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WQPMnor3oTefDHd6JP6UmpyBo7UsOJ1Sg4Ly1otxr6hw@mail.gmail.com>
Message-ID: <CAD=FV=WQPMnor3oTefDHd6JP6UmpyBo7UsOJ1Sg4Ly1otxr6hw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ath10k: add option for chip-id based BDF selection
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Nov 24, 2020 at 7:44 PM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> > > I missed on reviewing this change. Also I agree with Doug that this is not
> > the change I was looking for.
> > >
> > > The argument "with_variant" can be renamed to "with_extra_params".
> > There is no need for any new argument to this function.
> > > Case 1: with_extra_params=0,  ar->id.bdf_ext[0] = 0             ->   The default
> > name will be used (bus=snoc,qmi_board_id=0xab)
> > > Case 2: with_extra_params=1,  ar->id.bdf_ext[0] = 0             ->
> > bus=snoc,qmi_board_id=0xab,qmi_chip_id=0xcd
> > > Case 3: with_extra_params=1,  ar->id.bdf_ext[0] = "xyz"      ->
> > bus=snoc,qmi_board_id=0xab,qmi_chip_id=0xcd,variant=xyz
> > >
> > > ar->id.bdf_ext[0] depends on the DT entry for variant field.
> >
> > I'm confused about your suggestion.  Maybe you can help clarify.  Are
> > you suggesting:
> >
> > a) Only two calls to ath10k_core_create_board_name()
> >
> > I'm pretty sure this will fail in some cases.  Specifically consider
> > the case where the device tree has a "variant" defined but the BRD
> > file only has one entry for (board-id) and one for (board-id +
> > chip-id) but no entry for (board-id + chip-id + variant).  If you are
> > only making two calls then I don't think you'll pick the right one.
> >
> > Said another way...
> >
> > If the device tree has a variant:
> > 1. We should prefer a BRD entry that has board-id + chip-id + variant
> > 2. If #1 isn't there, we should prefer a BRD entry that has board-id + chip-id
> > 3. If #1 and #2 aren't there we fall back to a BRD entry that has board-id.
> >
> > ...without 3 calls to ath10k_core_create_board_name() we can't handle
> > all 3 cases.
>
> This can be handled by two calls to ath10k_core_create_board_name
> 1) ath10k_core_create_board_name(ar, boardname, sizeof(boardname), true)   :  As per my suggestions, this can result in two possible board names
>     a) If DT have the "variant" node, it outputs the #1 from your suggestion  (1. We should prefer a BRD entry that has board-id + chip-id + variant)
>     b) If DT does not have the "variant" node, it outputs the #2 from your suggestion (2. If #1 isn't there, we should prefer a BRD entry that has board-id + chip-id)
>
> 2) ath10k_core_create_board_name(ar, boardname, sizeof(boardname), false)    :  This is the second call to this function and outputs the #3 from your suggestion (3. If #1 and #2 aren't there we fall back to a BRD entry that has board-id)

What I'm trying to say is this.  Imagine that:

a) the device tree has the "variant" property.

b) the BRD file has two entries, one for "board-id" (1) and one for
"board-id + chip-id" (2).  It doesn't have one for "board-id + chip-id
+ variant" (3).

With your suggestion we'll see the "variant" property in the device
tree.  That means we'll search for (1) and (3).  (3) isn't there, so
we'll pick (1).  ...but we really should have picked (2), right?

-Doug
