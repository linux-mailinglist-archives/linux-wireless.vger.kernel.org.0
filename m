Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6219D24E2A8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 23:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgHUV0U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 17:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgHUV0N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 17:26:13 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A080EC061755
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 14:26:13 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j188so1545451vsd.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=078+CiH7lVt29oWJpgwXIBkmUDbeJffsaSjW+OIcOZA=;
        b=AHpmjfdLdmfBLldw9lQ0tRe+lGasQ3Wz8M5iSX7ICT4hyybMHrjbo14GoGAXCLge29
         aPxUpd++RRLoFxUzIY78Eusp1qdRdl2Se5TWUd+g1AN0pnChMXZnr4l+HTAVpXkoFRJQ
         TZ2wFZ04ad9De40QwE3vqDUkVLDJrHFPIrSAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=078+CiH7lVt29oWJpgwXIBkmUDbeJffsaSjW+OIcOZA=;
        b=SAASh0XZdXn3mfGRTg5EUDoShSt7DYp0mYZRaf5lafCJkMtLZEdlVWVw2wmf4OGM2Y
         0Y54qh0o4Ol1Lyi8nZIR0gqm65/P49OvGe9HWdbInL/soLsYp3Eio0hdGTGQ9pCUlpFR
         URt6eqhLM65PelLdcyYsPxCvgLSgPkycBm23ktH94Ve0ZwlHHJ1yaj9e9rvlXH8KDCnX
         OAPdvcba0DvZGdpKjqis05NPFWX5WOOB/DUL6uNTaSHagBSgf2REhV7vovTdGdrj6kHC
         jokPZpfNWzjG6uTrw4GMXxcigrT8VAEsrs8eU3yPepinnZ6qBtgJzl84SJFtmZJMuPve
         ptvQ==
X-Gm-Message-State: AOAM531ziEsSoSBlgmCCAhmK0hRbjebPguFEiHBifZ0KmSckcFFDCYdo
        afcnfgXLA14VwFnrAVwFIaShIvQ6cmgbYA==
X-Google-Smtp-Source: ABdhPJywyhmXpLScYdpZdD+G6b8YKh3oZzyJbN4282Uk+pydbrfu3f+l84b2zMjyaGwbhshHF0m1bQ==
X-Received: by 2002:a67:c294:: with SMTP id k20mr3637064vsj.166.1598045172436;
        Fri, 21 Aug 2020 14:26:12 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a82sm383463vke.39.2020.08.21.14.26.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 14:26:11 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id x17so943569uao.5
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 14:26:10 -0700 (PDT)
X-Received: by 2002:a9f:2b89:: with SMTP id y9mr3066484uai.0.1598045170522;
 Fri, 21 Aug 2020 14:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
In-Reply-To: <20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 21 Aug 2020 14:25:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1WGrDDspTLJJk1jTSY-Raizm55+8szVADNLTa+tvekw@mail.gmail.com>
Message-ID: <CAD=FV=U1WGrDDspTLJJk1jTSY-Raizm55+8szVADNLTa+tvekw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ath10k: Keep track of which interrupts fired,
 don't poll them
To:     Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Abhishek Kumar <kuabhs@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle,

On Thu, Jul 9, 2020 at 8:22 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> If we have a per CE (Copy Engine) IRQ then we have no summary
> register.  Right now the code generates a summary register by
> iterating over all copy engines and seeing if they have an interrupt
> pending.
>
> This has a problem.  Specifically if _none_ if the Copy Engines have
> an interrupt pending then they might go into low power mode and
> reading from their address space will cause a full system crash.  This
> was seen to happen when two interrupts went off at nearly the same
> time.  Both were handled by a single call of ath10k_snoc_napi_poll()
> but, because there were two interrupts handled and thus two calls to
> napi_schedule() there was still a second call to
> ath10k_snoc_napi_poll() which ran with no interrupts pending.
>
> Instead of iterating over all the copy engines, let's just keep track
> of the IRQs that fire.  Then we can effectively generate our own
> summary without ever needing to read the Copy Engines.
>
> Tested-on: WCN3990 SNOC WLAN.HL.3.2.2-00490-QCAHLSWMTPL-1
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Rakesh Pillai <pillair@codeaurora.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> This patch continues work to try to squash all instances of the crash
> we've been seeing while reading CE registers and hopefully this patch
> addresses the true root of the issue.
>
> The first patch that attempted to address these problems landed as
> commit 8f9ed93d09a9 ("ath10k: Wait until copy complete is actually
> done before completing").  After that Rakesh Pillai posted ("ath10k:
> Add interrupt summary based CE processing") [1] and this patch is
> based atop that one.  Both of those patches significantly reduced the
> instances of problems but didn't fully eliminate them.  Crossing my
> fingers that they're all gone now.
>
> [1] https://lore.kernel.org/r/1593193967-29897-1-git-send-email-pillair@codeaurora.org
>
> Changes in v2:
> - Add bitmap_clear() in ath10k_snoc_hif_start().
>
>  drivers/net/wireless/ath/ath10k/ce.c   | 84 ++++++++++----------------
>  drivers/net/wireless/ath/ath10k/ce.h   | 14 ++---
>  drivers/net/wireless/ath/ath10k/snoc.c | 19 ++++--
>  drivers/net/wireless/ath/ath10k/snoc.h |  1 +
>  4 files changed, 52 insertions(+), 66 deletions(-)

I'm wondering if there's anything else you're looking for here.  If I
just need to sit tight that's fine, but I want to make sure this patch
isn't lost and you're not waiting for any actions on my part.  The
patch it depends on from Rakesh (see above or patchwork ID 11628289)
is also still marked as "Under Review".

We have been using this patch for the last few months and we haven't
hit a single crash like we were getting before.  At the same time, we
haven't found any regressions that have been attributed to this patch.

Anyway, just figured I'd check in.  Thanks!

-Doug
