Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278362DDBD3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 00:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgLQXTB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 18:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbgLQXTB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 18:19:01 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1532C061794
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 15:18:20 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id i6so278869otr.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 15:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bz2IW955KN1kBMML3+o9Rok8vGvt7BDvNsrsFguY/2k=;
        b=V3ch4Q5Jvb7jrGD/wLFLLaLNoGCKNaFt2CkOj1sJE/RvSa66LeG7kudveh8uXYqPO4
         koJwcyXMIN1V+HzOaR9TmhmRfURoeVxrvugXQRsvAOZ9zqZSf92LL/XU+pRn0Hx/bvPD
         idx6f4fUnIGiqbf7HkUhucvt6RjxggQFDgLxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bz2IW955KN1kBMML3+o9Rok8vGvt7BDvNsrsFguY/2k=;
        b=mFnIMHE3yhL6Svb6qySAoTxgQZkO+N3AAF3tj8LTr7yNp0C2GU2ik2u8+Dqf9TvQaW
         QjhDhs0/laKbclUoQHlRBafGC/TwESVpNigrDK3EGXPrlSC4hGwtzqeyHJOuPxla+OG9
         ncNdIT8Witzq3Nj58zQFjQH5oEHYXEL/PwOWNr/v3L+Gg2veCEafu7HcMEd/BO1j6t09
         WZcHpG2hpfO0BixrXBiYKtWTr/iMefgMR/WFa1HllDLQwf6Xn2dgyPQnR8oIOUet8fRS
         7VVSyfnql8jDZpbB61fy/lBS5RB/GbU3eZf4c12fRVUYqdSJmv/7Zw31b58S0n//l/dj
         n1kA==
X-Gm-Message-State: AOAM532BsgknPEy4Y5POWOC8ZnuduRUQSQCYoeNnTcdBbrUpC+uGkIms
        upseH6qZafb2SfNjq8nT0ovDsTFPmrVFtA==
X-Google-Smtp-Source: ABdhPJyqzv0L0y6qA5GOqWoqPii4EEkDBohANUpZDNrzmuGZymmJ8o/sZLTIxbWQM2RZWw8EIVqVOw==
X-Received: by 2002:a9d:3be3:: with SMTP id k90mr1005915otc.50.1608247098793;
        Thu, 17 Dec 2020 15:18:18 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id x31sm1521544otb.4.2020.12.17.15.18.17
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 15:18:17 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id x13so884817oic.5
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 15:18:17 -0800 (PST)
X-Received: by 2002:aca:af4d:: with SMTP id y74mr1029540oie.105.1608247096801;
 Thu, 17 Dec 2020 15:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20201215172113.5038-1-youghand@codeaurora.org>
 <18dfa52b-5edd-f737-49c9-f532c1c10ba2@candelatech.com> <X9vaqxub2F/8YPT8@google.com>
 <6cec8a4c-620f-093d-2739-7eafe89cd79a@candelatech.com>
In-Reply-To: <6cec8a4c-620f-093d-2739-7eafe89cd79a@candelatech.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 17 Dec 2020 15:18:04 -0800
X-Gmail-Original-Message-ID: <CA+ASDXP+b8bik767LxcN9jV+ETpJ+_4HKH7rvsGgXbAHidFAng@mail.gmail.com>
Message-ID: <CA+ASDXP+b8bik767LxcN9jV+ETpJ+_4HKH7rvsGgXbAHidFAng@mail.gmail.com>
Subject: Re: [PATCH 0/3] mac80211: Trigger disconnect for STA during recovery
To:     Ben Greear <greearb@candelatech.com>
Cc:     Youghandhar Chintala <youghand@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        ath10k <ath10k@lists.infradead.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kuabhs@chromium.org, Doug Anderson <dianders@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 17, 2020 at 2:57 PM Ben Greear <greearb@candelatech.com> wrote:
> On 12/17/20 2:24 PM, Brian Norris wrote:
> > I'd also note that we don't operate in AP mode -- only STA -- and IIRC
> > Ben, you've complained about AP mode in the past.
>
> I complain about all sorts of things, but I'm usually running
> station mode :)

Hehe, fair :) Maybe I'm mixed up.

But I do get the feeling that specifically within the ath10k family,
there are wildly different use cases (mobile, PC, AP) and chips (and
firmware) that tend to go along with them, and that those use cases
get a fairly different population of {developers, testers, reporters}.
So claiming "feature X works" pretty much always has to be couched in
which chips, firmware, and use case. And there's certainly some wisdom
in these sections:

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#hardware_families
https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#tested-on_tag

> Do you actually see iwlwifi stations stay associated through
> firmware crashes?

Yes.

> Anyway, happy to hear some have seamless recovery, and in that case,
> I have no objections to the patch.

OK! I hope I'm not the only one with such results, because then I
still might question my sanity (and test coverage), but that's still
my understanding.

BTW, I haven't yet closely reviewed the patch series myself, but I ACK
the concept.

Brian
