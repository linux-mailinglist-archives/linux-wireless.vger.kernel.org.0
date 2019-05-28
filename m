Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF842C6EA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfE1MqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:46:24 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43203 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfE1MqY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:46:24 -0400
Received: by mail-vs1-f66.google.com with SMTP id d128so12670114vsc.10
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2019 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPMhKOX/2gDQVdTUPpeGGgiNX2GpsAfTBvJ6RzuLwtQ=;
        b=P9ikhGQsg6tKRQDqhMorBGKpTZgL3XDpoYbj+uXXtn1FsjfhbnAxrwR2EfkM9/DWTj
         Aj6f0SdmeAjDLrwbRpbugp8dp4FvGe2N+5EvmUt0O5Umk+2rg8/pmDgAhhs2Y0BdsSq/
         JpxeSqISDSBp4IySMpUtQOjAmJb29dE8uBw37hOJ/am0olsovqafHMQ5oxpKlPxRs6qY
         7RsZn012zz9sZiuzn8ToIj8HrPLINrPsk1oZUDZgNuYUogTRni2ZABJTFjzJIe0OxEMe
         lzpxZPVQ6ABUoqSeRS9wRBiwh/LnBR1hUQ/zDBMfPzo3JepeVSYYLz6wioYy8cHouf4t
         1B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPMhKOX/2gDQVdTUPpeGGgiNX2GpsAfTBvJ6RzuLwtQ=;
        b=NhyKXYvVBiN+ertn01jTliAkUXC26tITFFnrWXRrWjOqH7LlalWKFzep+PKzIGlF5t
         QNyye+S1snfzQ5vMhsIDD1krXgda0dQnFnYGMy5E3CDYLU9lJKSnngJU1g7oVOsqFARm
         +FqM6beOJMEOwv0FaE7YYPsi3Z8xfwYhShH9Q34DumXJ2HMVGZk53OAtEU2VxRij0XYr
         W3rAnAU9nfuZJNvnS1jd9PLzUV5AH2/xGGdMXxZpUHkncOQu0BFr2jEWQRHgbZrCXQBy
         lFCXrnD4wDoNxLXJm926vHRKyaDngNjDohF1NgbfpQ+g/RIxZ6W2La044qoJEYQsH3ij
         OlMA==
X-Gm-Message-State: APjAAAU6gxUrWQ+87J4eOC6ueorWAZQzQ/X5oaQ8zI5ky5YYbgMJkPZy
        3CAAd+MScCzJDfO61tgyistay/lqt+FZUC4W3LTrXQ==
X-Google-Smtp-Source: APXvYqwN3R4lENeMMTq+jxVugEfI89RxItVy4N2zPnBYc+/r6+aULWRh3QKl197OvGwTzHhtpH9GZ7f/zXhZ1GQiPfU=
X-Received: by 2002:a67:ebc5:: with SMTP id y5mr71977373vso.34.1559047583180;
 Tue, 28 May 2019 05:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <1556417825-13713-1-git-send-email-wgong@codeaurora.org>
 <CANEJEGug_YregN5vZq_R=ppUV5ptb4WUq_TB+JApzQ4DEO_AfQ@mail.gmail.com>
 <36950ff25c0747629e60ccb68819e93a@aptaiexm02f.ap.qualcomm.com> <87pnour4jg.fsf@codeaurora.org>
In-Reply-To: <87pnour4jg.fsf@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 14:45:46 +0200
Message-ID: <CAPDyKFrs1rO38yd-yQ50y2Oo1JE=R2hWM-5FWp=Ng_TM1df7ww@mail.gmail.com>
Subject: Re: [PATCH] ath10k: remove mmc_hw_reset while hif power down
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wen Gong <wgong@qti.qualcomm.com>,
        Grant Grundler <grundler@google.com>
Cc:     Wen Gong <wgong@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 7 May 2019 at 11:35, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> + Ulf to give comments from SDIO point of view

Apologize for the delay, it's been a busy period.

>
> Wen Gong <wgong@qti.qualcomm.com> writes:
>
> >> -----Original Message-----
> >> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Grant
> >> Grundler
> >> Sent: Saturday, May 4, 2019 2:01 AM
> >> To: Wen Gong <wgong@codeaurora.org>
> >> Cc: linux-wireless@vger.kernel.org; ath10k@lists.infradead.org
> >> Subject: [EXT] Re: [PATCH] ath10k: remove mmc_hw_reset while hif power
> >> down
> >>
> >> [repeating comments I made in the gerrit review for Chrome OS :
> >> https://chromium-
> >> review.googlesource.com/c/chromiumos/third_party/kernel/+/1585667
> >> ]
> >>
> >> On Sat, Apr 27, 2019 at 7:17 PM Wen Gong <wgong@codeaurora.org> wrote:
> >> >
> >> > For sdio 3.0 chip, the clock will drop from 200M Hz to 50M Hz after load
> >> > ath10k driver, it is because mmc_hw_reset will reset the sdio's power,
> >> > then mmc will consider it as sdio 2.0 and drop the clock.
> >>
> >> Wen,
> >> 5468e784c0600551ca03263f5255a375c05f88e7 commit message gives
> >> reasons
> >> for adding the mmc_hw_reset() call. The commit message for removing
> >> gives different reason for removal. Both are good but second one is
> >> incomplete.
> >>
> >> The commit message for removal should ALSO explain why adding this
> >> call wasn't necessary in the first place OR move the call to a
> >> different code path.
> >>
> >> > Remove mmc_hw_reset will avoid the drop of clock.
> >>
> >> This commit message makes it clear the original patch introduced a new
> >> problem. But the original patch fixed a different problem and that
> >> this proposed change seems likely to re-introduce and the commit
> >> message should explain why that isn't true (or how the original was
> >> fixed differently)
> >
> > The mmc_hw_reset's effect depends on the hardware layout/configure
> > software's behavior, recently it will effect the clock of sdio for the
> > platform I used. And it will still work well without mmc_hw_reset for
> > the platform I Used currently. If sdio cannot work on other platform,
> > I think it can add flag in ath10k_hw_params_list for the platform to
> > call the mmc_hw_reset depends on the flag.
>
> I don't see how you can use ath10k_hw_params_list to separate SDIO
> controller functionality, I assume that's the real reason for difference
> of functionality? Maybe this is a bug on the SDIO controller?

Ideally mmc_hw_reset() should not make the SDIO card to become
re-initialized differently than it was originally.

However, as that is the case here, it sounds like that there is a bug
somewhere. Perhaps the boot-loader have done some pre-initialization,
which isn't covered in the second case, or maybe a bug in the mmc host
driver.

>
> Ulf, what do you think? Any suggestions? Full discussion here:
>
> https://patchwork.kernel.org/patch/10920563/
>
> --
> Kalle Valo

In the end, it seems like this needs a more detailed debug study, to
figure out what exactly happens during the re-initialization of the
SDIO card, rather than just papering over the problem by removing the
call to mmc_hw_reset() in the SDIO func driver. Hope this helps.

Kind regards
Uffe
