Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8C2ADCBE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 18:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgKJRTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 12:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKJRTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 12:19:33 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2BBC0613CF
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 09:19:31 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id z2so12871039ilh.11
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m76wOL9hJIJoG0AO/e/uP7Uo91cnrGUskfUQcXSEJaw=;
        b=aUpZC7ktAb3pkvosG5hyA2UaagJt7W8t8r+Klze5728P06woK0Hop3/1nyOuBXNZMK
         y255tazkuEH7++moKa2Q01NtPlRzKa0QbEjbWF/KTGg5+ny4XajqUNJOdAoSRDEnjLKX
         EATzsf/HUdwPrLsULwfVG+iP7zQh6d28EH00g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m76wOL9hJIJoG0AO/e/uP7Uo91cnrGUskfUQcXSEJaw=;
        b=i4rpCWMWn5CFcCiUGIGeD7MgPw4Xdw718cmpyf8bb1PtioFghiw/oXvTD7h2gEZyUk
         TuP1+jIWeIgyxKCwwwHkMEBCQBYoJM6ATP2SOBwikVgE1aojnKz9Z5H3VQ9GEOtRU5e3
         2MZxJsbyYo+S8YPShwl4o/eAGFH8iXl1FQKEfZOug2kweR/PonQ7SEZ05lzD8rYD+y26
         79vpbJ7Du5jw5xmDP2YOJCvUqzt3DuARV/thZcI3E0Z/eN8peGMnZArMkgbAfWzsW0vQ
         VCH8Q4p2/Y33pvIACmHjDDdzX8HKndFVtfZjliEfM8PGvgCW8WLb4NBC4SvLJCFf9gk6
         hbAA==
X-Gm-Message-State: AOAM533cxZLQsDmdX2dpwqruMVvTc1ZjzLBnw1Y1oVK6i/gYdNXrJCWJ
        FPwtfGWXfSH93CdRvsQfTHEBhfFzHwJmhgTf1JLA3bZLRhM=
X-Google-Smtp-Source: ABdhPJyOZv4c/23PoTtO1kXkANOtS7NNt3q+8JYWMPUQzsFB4WGg2bwqjXqsXfBkXcGeHkODJ5NajYAYvE6PE8gBJ/c=
X-Received: by 2002:a92:d60f:: with SMTP id w15mr15072739ilm.235.1605028771245;
 Tue, 10 Nov 2020 09:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
 <20201106071107.D7CE3C433C6@smtp.codeaurora.org>
In-Reply-To: <20201106071107.D7CE3C433C6@smtp.codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Tue, 10 Nov 2020 09:19:20 -0800
Message-ID: <CACTWRwtjvQYUvbWHrajNRkK_sDZRv1hr0kp+o1=6504qv64qKQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
To:     Kalle Valo <kvalo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Apologies for the delay, was busy so could not work on V2 . I have
started working on V2 patch. Will upload by today/tomorrow.

Abhishek


On Thu, Nov 5, 2020 at 11:11 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> > In some devices difference in chip-id should be enough to pick
> > the right BDF. Add another support for chip-id based BDF selection.
> > With this new option, ath10k supports 2 fallback options.
> >
> > The board name with chip-id as option looks as follows
> > board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320'
> >
> > Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> > Tested-by: Abhishek Kumar <kuabhs@chromium.org>
>
> There were few checkpatch warnings which I fixed:
>
> $ ath10k-check
> drivers/net/wireless/ath/ath10k/core.c:1501: Alignment should match open parenthesis
> drivers/net/wireless/ath/ath10k/core.c:1512: line length of 92 exceeds 90 columns
> drivers/net/wireless/ath/ath10k/core.c:1521: line length of 92 exceeds 90 columns
>
> The first one was also what Doug commented. I also added Tested-on tags,
> thanks for those. The updated patch is in pending branch (soon).
>
> But is this patch ok to take now? I didn't quite get the conclusion of the
> discussion.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/patch/20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>
