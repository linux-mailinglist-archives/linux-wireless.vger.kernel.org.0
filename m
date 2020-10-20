Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4318F293FA3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436464AbgJTPf0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 11:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408780AbgJTPf0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 11:35:26 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F37C061755
        for <linux-wireless@vger.kernel.org>; Tue, 20 Oct 2020 08:35:26 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id q20so798130uar.7
        for <linux-wireless@vger.kernel.org>; Tue, 20 Oct 2020 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuCZolafHZzGv7L0g1xs2ngJmZLSjocL9l2jZ9YQQZI=;
        b=A0ENwZq/6mfKnjmjxNEBvXaAe6DPK0j4XKogC5WTc6UrGjnE2MltBIY29px2H2As6a
         e7r6Os675b1+iKB3mvt1ZGM3olxLJEPFsrr4V7ehu6da2s/wdOWWq4KgT8bGSGERs6+K
         yky7dLX8Tmjjwlj6wE6S6dEHm3Fk7EozpHDpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuCZolafHZzGv7L0g1xs2ngJmZLSjocL9l2jZ9YQQZI=;
        b=d+7wLNoHpi+OfPbinMI7kEs97JLPf5Z8k6S7AKAPdgCRLHOShZaXRsk0RfNR5UkNu/
         Kd92iea24l7up5OYe5JeyLjyTib5qkUorqjM2A0lqcac3NPcgWrVMjCkAfGOcdd/qKty
         Rym3/eS68cmiEhgtPEtP1ZZehWj1YJeugcPNoPJ8IvyIFY5KVq2RGNY4wFdI7nFBu9X2
         Jo1TxnsMTmLm70DJlSMCQBE3N0Wr9QuzU2NDFutG8/snzr5c5eIR8mOXaa+iHOyEeZxj
         mZ8Uj3rwdPXCeeo4pqGCTgg/3NYN52LQzq291LK3Il37PRSf6LIlhsrjt7wqcyaAnc9F
         trfg==
X-Gm-Message-State: AOAM532Y1t/R7lOP1koSM9+5AKi8Di1VylPhbFeRGE0jjSC1t1nwxt5w
        i2AgmkD34DzA7vEEPI+FuyeEHu2lMwYd7A==
X-Google-Smtp-Source: ABdhPJwiQmWNvrvyLTA5CorjhWTWk/ZYhg5QNuJt12xaV2+2SXppqofrqXOahPVxModbx1mdwaeJdw==
X-Received: by 2002:ab0:6f0c:: with SMTP id r12mr1855460uah.55.1603208124554;
        Tue, 20 Oct 2020 08:35:24 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id c125sm275720vkc.43.2020.10.20.08.35.23
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 08:35:23 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id u74so1378031vsc.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Oct 2020 08:35:23 -0700 (PDT)
X-Received: by 2002:a67:b405:: with SMTP id x5mr2327462vsl.4.1603208122578;
 Tue, 20 Oct 2020 08:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
In-Reply-To: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Oct 2020 08:35:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xv7Usev=S_ViWPPsa0xL42KDymjEkqJF7S4CzDiuxP3g@mail.gmail.com>
Message-ID: <CAD=FV=Xv7Usev=S_ViWPPsa0xL42KDymjEkqJF7S4CzDiuxP3g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Oct 19, 2020 at 5:51 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> In some devices difference in chip-id should be enough to pick
> the right BDF. Add another support for chip-id based BDF selection.
> With this new option, ath10k supports 2 fallback options.
>
> The board name with chip-id as option looks as follows
> board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320'
>
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> ---
>
>  drivers/net/wireless/ath/ath10k/core.c | 45 +++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 11 deletions(-)

You might want to think a little more about who you're CCing when you
post a patch.  I would have imagined that Rakesh should have been
CCed.  Probably Brian and I, too?  Luckily I knew to look for it.


>  int ath10k_core_fetch_board_file(struct ath10k *ar, int bd_ie_type)
>  {
> -       char boardname[100], fallback_boardname[100];
> +       char boardname[100], fallback_boardname1[100], fallback_boardname2[100];
>         int ret;
>
>         if (bd_ie_type == ATH10K_BD_IE_BOARD) {
> +               /* With variant and chip id */
>                 ret = ath10k_core_create_board_name(ar, boardname,
> -                                                   sizeof(boardname), true);
> +                                               sizeof(boardname), true, true);

I don't know if it's worth spinning the patch just for this, but it's
weird that the indentation of the 2nd line above doesn't match the
indentation of the similar calls below.

Other than the tiny nit, this seems sane to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I've also confirmed that the patch is behaving properly on two boards
I have with slightly different chip-ids.  I tried poking with various
combinations of specifying a variant in dts and not specifying one.

Board 1:
qmi chip_id 0x320 chip_family 0x4001 board_id 0xff soc_id 0x400c0000

Board 2:
qmi chip_id 0x4320 chip_family 0x4001 board_id 0xff soc_id 0x400c0000

Both boards report "WCN3990 hw1.0 SNOC", so I guess the "Tested-on"
tag should be:

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00696-QCAHLSWMTPL-1

Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
