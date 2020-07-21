Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5273D2273F6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 02:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgGUAkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jul 2020 20:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgGUAkR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jul 2020 20:40:17 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF4C061794
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jul 2020 17:40:17 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id c11so4136929vkn.11
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jul 2020 17:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUpZU63I2MCt+5BOqBJ02njfQEvWd4lvpWLlUaHC6oM=;
        b=Je5GRTngISqvkNcRVRnSxEc/NHnORLZ9Whhu5UnqKBL1gzWAbPHubryeggAL9Fst5h
         Tsc0XoyxZpZ/Kg7n19zdROeh98yk3ZMi+lMhzXGLunb7wjETZaPln3PCaDYsI1F9k617
         S9ghiVLdL2R9PI5AmhvAlpjlRyJi+Ex0BmD6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUpZU63I2MCt+5BOqBJ02njfQEvWd4lvpWLlUaHC6oM=;
        b=Ng6SqHfQKVOARfvAwYye1yQH0Ij9ahBzsMQd3lEb4+mP0U6GWKYbTNoOggjPL3lr3N
         cartmzbF4cdSsp8XHapvJCAaRCBE3Fnn3ni1wYgdyui75eVbspzO0oJNzkbwwX9xzdF2
         G9ZWHyD2zwFcwD1ECMZ1GZoZBB3Si0StDCqh0WwrSw7wEba3umbRkdu2FQUhqxV73C4s
         f6wmtsdP/dZLYzUOHLHvqqnyDpIQl76l6TlfHVpK7SLxhsgXXqzZZv5vqBZID8JVH6zc
         s3tfIT/CVG0m+FO1760OjLD0tfdQyZqB+CXS0+0brWuG4tkOILTc7R1m5Cky4OcD02Kb
         cStA==
X-Gm-Message-State: AOAM530daOFmQmDqWSEDPMxh3Y1uKzzO0soUiCZRqfGNsijM4G2MlbtH
        XJtY4z6ZrQ3vfvLMAWKno8OrMAjqe9Y=
X-Google-Smtp-Source: ABdhPJwZlDbHsQrqPfVM4yekqzHzHLJSFx+JnU8O2lwTb7lhIQU5sUhlXSXhXxfQrcFU77uBWoR4jg==
X-Received: by 2002:a1f:788c:: with SMTP id t134mr18633806vkc.30.1595292015864;
        Mon, 20 Jul 2020 17:40:15 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 185sm2998299vkr.15.2020.07.20.17.40.15
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 17:40:15 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id i24so48899uak.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jul 2020 17:40:15 -0700 (PDT)
X-Received: by 2002:a9f:3dc6:: with SMTP id e6mr18950969uaj.104.1595292014631;
 Mon, 20 Jul 2020 17:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
 <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
 <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
 <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
 <871rlcx8uv.fsf@codeaurora.org> <CALhWmc1PbTKhrkaPn9yfpx3gZHAMuR-bPY=4_o4wQHv_H5D9dA@mail.gmail.com>
In-Reply-To: <CALhWmc1PbTKhrkaPn9yfpx3gZHAMuR-bPY=4_o4wQHv_H5D9dA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 Jul 2020 17:40:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUpwVoxNPELFfWnKRYFornTFMvtgFaOgD7ij-fQNEvmQ@mail.gmail.com>
Message-ID: <CAD=FV=XUpwVoxNPELFfWnKRYFornTFMvtgFaOgD7ij-fQNEvmQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
To:     Peter Oh <peter.oh@eero.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Jul 20, 2020 at 5:33 PM Peter Oh <peter.oh@eero.com> wrote:
>
> I'm getting this panic on IPQ4019 system after cherry-picked this
> single patch on top of working system.
>
> [   14.226184] ath10k_ahb a000000.wifi: failed to receive initialized
> event from target: 80000000

A bit of a shot in the dark, but any chance you could try this atop it
and see if it helps?

https://lore.kernel.org/r/20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid/

...most of this patch is gutted by that one.

-Doug
