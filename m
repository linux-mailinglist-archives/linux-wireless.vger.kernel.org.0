Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11A22C2CDA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 17:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390403AbgKXQ03 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 11:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390017AbgKXQ03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 11:26:29 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF9C0617A6
        for <linux-wireless@vger.kernel.org>; Tue, 24 Nov 2020 08:26:28 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id e127so2412800vkb.5
        for <linux-wireless@vger.kernel.org>; Tue, 24 Nov 2020 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e44wk8MkE5luS4VPP/tOiY6OXFFUDjOtoE11h9rO1rQ=;
        b=lg5QSCkmuSEcqU7ETiY5fcU2g7mMK28FXHVHIsk89BdwA6FH/G9weJb/h0Y1c0lroL
         HCJxIbgUiwFYvi73yMMUpfb6CYUya25UygMN/Tk9CNLjJbEvF86nu7hHFB3FOc5iVTtA
         lNmrZWaHZrpP1lUvJi4uJ5AR1+uDiypZBOMwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e44wk8MkE5luS4VPP/tOiY6OXFFUDjOtoE11h9rO1rQ=;
        b=idDvfarjMg7Wer1bVdqgOHQ9/voB1kmZXpu0OPlMisCwGYgcXgvjhErY09sGVZCLHD
         IOMlEk6fdxQfIqFtlG2IqgCWsO5UvNeq2+jZeuCw4/XNZ/w1RHEauYAaKmcCPdEXv6HJ
         16i44CalrvqtYiuiZXGOHHjwxztmDtPZXHZEG1o1QM91P0evZTDWNs8zAj5LCPTlJY6m
         ESt+Kdaj4e+DjpxTbUeGZ2bmros+vexm9oCoUeCZdTfdMp+lbF0du0nG1dIiOiKiOI9U
         CUeczz3dxU7Ier7eXric9E57jAe4CJ5Ucjl6IoVH68ySkTgGBSQ1m4QFsi6DTzBCSKB/
         cDiA==
X-Gm-Message-State: AOAM530GQUSvdrQhD1Zl+U5UqXWrLni49MHOdjYCiE+buoKb6Y6n3/AY
        X/4xfhpuFi2zPnVVakecFOYnVSWN7fWQxQ==
X-Google-Smtp-Source: ABdhPJzeqRnaFrkjk3xlilq1OkiyMpExOusjWm6GLIzFsdjNqBuAuhUf38GVy1ze65fE4zth9CNuQA==
X-Received: by 2002:a1f:e8c7:: with SMTP id f190mr4520948vkh.1.1606235187605;
        Tue, 24 Nov 2020 08:26:27 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id n16sm1407135vsj.9.2020.11.24.08.26.26
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 08:26:26 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id s123so10730798vsc.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Nov 2020 08:26:26 -0800 (PST)
X-Received: by 2002:a67:ef98:: with SMTP id r24mr4313446vsp.37.1606235186181;
 Tue, 24 Nov 2020 08:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20201112200906.991086-1-kuabhs@chromium.org> <20201112200856.v2.1.Ia526132a366886e3b5cf72433d0d58bb7bb1be0f@changeid>
 <CAD=FV=XKCLgL6Bt+3KfqKByyP5fpwXOh6TNHXAoXkaQJRzjKjQ@mail.gmail.com> <002401d6c242$d78f2140$86ad63c0$@codeaurora.org>
In-Reply-To: <002401d6c242$d78f2140$86ad63c0$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Nov 2020 08:26:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UnecON-M9eZVQePuNpdygN_E9OtLN495Xe1GL_PA94DQ@mail.gmail.com>
Message-ID: <CAD=FV=UnecON-M9eZVQePuNpdygN_E9OtLN495Xe1GL_PA94DQ@mail.gmail.com>
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

On Tue, Nov 24, 2020 at 1:19 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> > -----Original Message-----
> > From: Doug Anderson <dianders@chromium.org>
> > Sent: Tuesday, November 24, 2020 6:27 AM
> > To: Abhishek Kumar <kuabhs@chromium.org>
> > Cc: Kalle Valo <kvalo@codeaurora.org>; Rakesh Pillai
> > <pillair@codeaurora.org>; LKML <linux-kernel@vger.kernel.org>; ath10k
> > <ath10k@lists.infradead.org>; Brian Norris <briannorris@chromium.org>;
> > linux-wireless <linux-wireless@vger.kernel.org>; David S. Miller
> > <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; netdev
> > <netdev@vger.kernel.org>
> > Subject: Re: [PATCH v2 1/1] ath10k: add option for chip-id based BDF
> > selection
> >
> > Hi,
> >
> > On Thu, Nov 12, 2020 at 12:09 PM Abhishek Kumar <kuabhs@chromium.org>
> > wrote:
> > >
> > > In some devices difference in chip-id should be enough to pick
> > > the right BDF. Add another support for chip-id based BDF selection.
> > > With this new option, ath10k supports 2 fallback options.
> > >
> > > The board name with chip-id as option looks as follows
> > > board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320'
> > >
> > > Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00696-QCAHLSWMTPL-1
> > > Tested-on: QCA6174 HW3.2 WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> > > Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> >
> > I think you need to work on the method you're using to generate your
> > patches.  There are most definitely changes since v1.  You described
> > them in your cover letter (which you don't really need for a singleton
> > patch) instead of here.
> >
> >
> > > @@ -1438,12 +1439,17 @@ static int
> > ath10k_core_create_board_name(struct ath10k *ar, char *name,
> > >         }
> > >
> > >         if (ar->id.qmi_ids_valid) {
> > > -               if (with_variant && ar->id.bdf_ext[0] != '\0')
> > > +               if (with_additional_params && ar->id.bdf_ext[0] != '\0')
> > >                         scnprintf(name, name_len,
> > >                                   "bus=%s,qmi-board-id=%x,qmi-chip-id=%x%s",
> > >                                   ath10k_bus_str(ar->hif.bus),
> > >                                   ar->id.qmi_board_id, ar->id.qmi_chip_id,
> > >                                   variant);
> > > +               else if (with_additional_params)
> > > +                       scnprintf(name, name_len,
> > > +                                 "bus=%s,qmi-board-id=%x,qmi-chip-id=%x",
> > > +                                 ath10k_bus_str(ar->hif.bus),
> > > +                                 ar->id.qmi_board_id, ar->id.qmi_chip_id);
> >
> > I believe this is exactly opposite of what Rakesh was requesting.
> > Specifically, he was trying to eliminate the extra scnprintf() but I
> > think he still agreed that it was a good idea to generate 3 different
> > strings.  I believe the proper diff to apply to v1 is:
> >
> > https://crrev.com/c/255643

Wow, I seem to have deleted the last digit from my URL.  Should have been:

https://crrev.com/c/2556437

> >
> > -Doug
>
> Hi Abhishek/Doug,
>
> I missed on reviewing this change. Also I agree with Doug that this is not the change I was looking for.
>
> The argument "with_variant" can be renamed to "with_extra_params". There is no need for any new argument to this function.
> Case 1: with_extra_params=0,  ar->id.bdf_ext[0] = 0             ->   The default name will be used (bus=snoc,qmi_board_id=0xab)
> Case 2: with_extra_params=1,  ar->id.bdf_ext[0] = 0             ->   bus=snoc,qmi_board_id=0xab,qmi_chip_id=0xcd
> Case 3: with_extra_params=1,  ar->id.bdf_ext[0] = "xyz"      ->   bus=snoc,qmi_board_id=0xab,qmi_chip_id=0xcd,variant=xyz
>
> ar->id.bdf_ext[0] depends on the DT entry for variant field.

I'm confused about your suggestion.  Maybe you can help clarify.  Are
you suggesting:

a) Only two calls to ath10k_core_create_board_name()

I'm pretty sure this will fail in some cases.  Specifically consider
the case where the device tree has a "variant" defined but the BRD
file only has one entry for (board-id) and one for (board-id +
chip-id) but no entry for (board-id + chip-id + variant).  If you are
only making two calls then I don't think you'll pick the right one.

Said another way...

If the device tree has a variant:
1. We should prefer a BRD entry that has board-id + chip-id + variant
2. If #1 isn't there, we should prefer a BRD entry that has board-id + chip-id
3. If #1 and #2 aren't there we fall back to a BRD entry that has board-id.

...without 3 calls to ath10k_core_create_board_name() we can't handle
all 3 cases.


b) Three calls to ath10k_core_create_board_name() but the caller
manually whacks "ar->id.bdf_ext[0]" for one of the calls

This doesn't look like it's a clean solution, but maybe I'm missing something.


-Doug
