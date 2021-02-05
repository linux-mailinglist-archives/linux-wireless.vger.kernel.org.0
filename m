Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2531186A
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Feb 2021 03:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhBFChL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 21:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhBFCeu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 21:34:50 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08528C061788
        for <linux-wireless@vger.kernel.org>; Fri,  5 Feb 2021 14:00:49 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n14so8777695iog.3
        for <linux-wireless@vger.kernel.org>; Fri, 05 Feb 2021 14:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjFoIlWrQQ6SMzxidSIU20LEs4MBYZ8U+Hbs2kdSGcY=;
        b=E3xQASvh1UTu1+ew985C5nGgz+dZqjVwunktw31qnGEZjNfL0hXKiFy796OgliRWeF
         AM7eZB+peG0BOA6Q31/k/yQy/UlzzkcFDtqmmzlmkXNuDZ0nZexQkVABdzuVCWUFV6xA
         LSFXFaXdd9Fk9X9vhzetmL0b+meOsrs9iEGB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjFoIlWrQQ6SMzxidSIU20LEs4MBYZ8U+Hbs2kdSGcY=;
        b=kBOyKFmCIkx0dNQZ+lkq8vvqfGq+/+MmmrwWT0b6x4yXG0rrN20hUM4XN6TtzHMVIX
         v28uG4uubXMUv5gpAE8rR3cnls1QFg4GxX51VbIZciMEE4wf+yJrxDqbMICIg/+6RyDC
         gjKztn9SuXW+fl4wKfgJfC74EtZGZunAGe8VuzEwWbkNbqDXgnYpt3TJKA0AhlT3wNJZ
         qSW+2HiS4N75jLI1JfkkzbbJh29/BAiclBfYFIsZ7xx9Hyfp+VWU6/Fv1eF2/Xn44bqP
         PokQZsAt63Y/JqvhZJ5ewg/V/tUu6YbzGDzN+988OqNz0OORoXH6lhNM3FOSN2jkbXUR
         ewTA==
X-Gm-Message-State: AOAM533V32N/AivI53DJ8QYopHbJnjnxMhPT8Gc+SI2l6jxYRmw02KSj
        sUxv+OXrSa0Rn3qc0fqRQtethAg2AjDUlQPg5aDcZQ==
X-Google-Smtp-Source: ABdhPJzQUJC+nALEv8999zWpWOq1rvvD0E2d2qR4O0M77d01+4sHlR2oV3jrZwnpdiQYYzQs2xGAJc7nwLwmlRRo3rI=
X-Received: by 2002:a02:84e8:: with SMTP id f95mr7031738jai.4.1612562448532;
 Fri, 05 Feb 2021 14:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20201215172435.5388-1-youghand@codeaurora.org>
 <CACTWRwsM_RJnssBpxDpRSbex4_1T9QDv3+ZT7eLnYsgOgtGFQw@mail.gmail.com> <878s9o6aqa.fsf@codeaurora.org>
In-Reply-To: <878s9o6aqa.fsf@codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Fri, 5 Feb 2021 14:00:37 -0800
Message-ID: <CACTWRwuGj-kriu10aOix-McK3G_934E=UMa4KzL0yeqtsJRV3A@mail.gmail.com>
Subject: Re: [PATCH 3/3] ath10k: Set wiphy flag to trigger sta disconnect on
 hardware restart
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Youghandhar Chintala <youghand@codeaurora.org>,
        netdev <netdev@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> I'm not sure what you mean. But if you are saying that we should move
> ath10k_hw_params_list entirely to firmware then that is a huge task as
> we would need to make changes in every firmware branch, and there are so
> many different branches that I have lost count. And due to backwards
> compatibility we still need to have ath10k_hw_params_list in ath10k for
> few years.
>
 Apologies for late reply on this thread. Yes you got me right( to
move ath10k_hw_params_list entirely to firmware ). I wanted to trigger
an idea and know what other people's views are, or atleast what are
the challenges. As you said the task is much bigger with so many
firmware branches. As long as you feel it is scalable for coming
years, we should be good.

As far as the patch is concerned, it LGTM.

Reviewed-by: Abhishek Kumar <kuabhs@chromium.org>

Thanks
Abhishek
