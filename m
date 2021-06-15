Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3493D3A8766
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFORUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhFORUH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 13:20:07 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7F8C061574
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jun 2021 10:18:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id h9so18945539oih.4
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jun 2021 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwNx+DWFt6NNdGSxWQzHJjFVZVQ/XJYkZRUEXCZIYHk=;
        b=RUZvQpey2LpbHYX4a5zfm5XX9WX7G4+MwqUTOgxNJY7fHoY+kPL4EGAaupGCJZM/M2
         vJ7j3+a0kBJUhvhbwm30UR/YYRyZNblFjqZAnSDDCZLIUDYWp4M0cnQ76tuMiizIzc4d
         JjfykEYKErjeE9KQChscveDKf6mhNXHy4hu0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwNx+DWFt6NNdGSxWQzHJjFVZVQ/XJYkZRUEXCZIYHk=;
        b=BFxtMvnVA7UpIzhbKQaTXBNX8Np0kk3nRKbPNePCvFWdSwrUdmfXNey623jrCc+oAT
         78d19kov+oPZU8F90OwoOVl+aadi9GLMRpzPyqymQClv9zBlo4NxAz0hOPBtT1iGZ6Ut
         SSYIS7gaINbumv+idr7h3sLgsEHieIvPLaXkJECJMShLvCMC1WvmGUeejywirgtgMiaS
         hpnhNaHbAYOP0PXNk35rThflg5+7XfADOPx8JWoWsyNy3W6v2KD8dWKsPa8OkemEYoXq
         99neDbTvUh+s8PFVp1IREy4gFT3K2FjNDFN1Zl7/GD6XR5ByrwgPXHQy1Ws9WmXe2ByE
         idaA==
X-Gm-Message-State: AOAM530xZothrK3s5aTDUQQrAiB476iYC6Zvio2WgZZE33p+I7GhE437
        BYn/df1zWPDTxORdiKeymU91Oe+nf2wfUw==
X-Google-Smtp-Source: ABdhPJyZo5Ybxo14UV/iOeDqrkz40N9YhB+dNx0RP+x9SD3qP01po2YVHchZFtDVILqm3y2qEIIlcQ==
X-Received: by 2002:a05:6808:6d1:: with SMTP id m17mr3879498oih.34.1623777481287;
        Tue, 15 Jun 2021 10:18:01 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id n7sm3879268oom.37.2021.06.15.10.18.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 10:18:00 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso15011379otu.10
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jun 2021 10:18:00 -0700 (PDT)
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr240707oti.229.1623777479566;
 Tue, 15 Jun 2021 10:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024834.8354-1-yguoaz@cse.ust.hk> <20210615133102.7E774C43145@smtp.codeaurora.org>
In-Reply-To: <20210615133102.7E774C43145@smtp.codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 15 Jun 2021 10:17:47 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNQkZvnCezWS6Y7e7SPO-u+9fY23g4VVpHC-Z5HC55Nig@mail.gmail.com>
Message-ID: <CA+ASDXNQkZvnCezWS6Y7e7SPO-u+9fY23g4VVpHC-Z5HC55Nig@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: protect against divide by zero in mwifiex_set_ibss_params
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Yiyuan GUO <yguoaz@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Yiyuan GUO <yguoaz@cse.ust.hk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 15, 2021 at 6:31 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Yiyuan GUO <yguoaz@gmail.com> wrote:
>
> > In function mwifiex_set_ibss_params, the variable index may remain
> > zero if it is never altered inside the loop, leading to a potential
> > divide by zero problem.
> >
> > Signed-off-by: Yiyuan GUO <yguoaz@cse.ust.hk>
>
> Brian explains in the report why the code is ok:
> https://bugzilla.kernel.org/show_bug.cgi?id=212993#c1

Ah, forgot there was a patch for this too. FWIW, it's probably ok to
submit such a patch, if just for safety's sake (future refactoring?).
I just didn't figure it deserved an open "bug" entry, when it's
clearly not one.

> Patch set to Rejected.

That's fine with me.

Thanks,
Brian
