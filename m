Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A49E1EC42B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2020 23:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgFBVJQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jun 2020 17:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBVJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jun 2020 17:09:15 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56932C08C5C0
        for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2020 14:09:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so14212667eju.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2020 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGf11SbLkxX4fJOwT9kGUgWEGfA4VGBgNO6kWFPFsRk=;
        b=XM3q8pho/PiowJ76NeZ46OC8b/u0qzNDKNLp7cEGV3nGiBc2PGReStjvx1Vz8tUMND
         4apoBJ3u14oElCS0buaQvzQDvSszTwAsZ6Yhd5EN54LStE+ICJI6tZsQZF7P75x4vh38
         Hlaj5tBKyfVXGXv4gKJiwm0zV3L6emG1YczkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGf11SbLkxX4fJOwT9kGUgWEGfA4VGBgNO6kWFPFsRk=;
        b=dKq7yfx5dUzETVQcDbs8MAOTUVuy7CyFRfoysqwwRff3cQXRhDVPdtgyULyW78RJwO
         N97vS6x9peonXb0sM0uaCDdlgr1YWdNJm6Ez3Vqg0U7a6SGm57E2aCCPj81IO59FD3K8
         2a9HP9AjvSnBUHSO4vi0G4tEh8p3eCSxqM+l7REfOw0/4V8dLrqgFG/ICmT7CUFPEcBs
         UJtyEz4w4H+guiZR22TdqW+xV2/f5jPZFrWNzEd4dBMLZ1vY0aLyFmALXzk0ktHxrHIb
         f73OEUR5QOGGndcZ5Zd2es61wycr9hdOPvfJtOiBzJr6XUgJbGwKkQgK9sdwa6zdWalM
         IxDA==
X-Gm-Message-State: AOAM533ibcsxyuEyGt7aUqtkTVh1e4KqAOMVUcrBXJv20Fyzg0IVBIv2
        cijAuwhNdFunpEqsvmHow3Kzcb8Njx5o+w==
X-Google-Smtp-Source: ABdhPJytolXA7MBc5D+NN3ywHGTVa/YD8loeO8FIykozvz58ayGt2zKQyJScsfEHOVB5aGA94WIQOA==
X-Received: by 2002:a17:907:4096:: with SMTP id nm6mr11186723ejb.4.1591132153737;
        Tue, 02 Jun 2020 14:09:13 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id dc8sm2108348edb.10.2020.06.02.14.09.13
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:09:13 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id p18so11212863eds.7
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2020 14:09:13 -0700 (PDT)
X-Received: by 2002:a2e:7f02:: with SMTP id a2mr429268ljd.138.1591131684280;
 Tue, 02 Jun 2020 14:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200526145815.6415-1-mcgrof@kernel.org> <20200526145815.6415-6-mcgrof@kernel.org>
In-Reply-To: <20200526145815.6415-6-mcgrof@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 2 Jun 2020 14:01:12 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMR-Aa9322QjUTxiD2zwXDUig1eyG7GAAJJDvuUg1AXdA@mail.gmail.com>
Message-ID: <CA+ASDXMR-Aa9322QjUTxiD2zwXDUig1eyG7GAAJJDvuUg1AXdA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] ath10k: use new taint_firmware_crashed()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     jeyu@kernel.org, "David S. Miller" <davem@davemloft.net>,
        kuba@kernel.org, linux-wireless <linux-wireless@vger.kernel.org>,
        aquini@redhat.com, linux-doc@vger.kernel.org, peterz@infradead.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux@dominikbrodowski.net,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        glider@google.com, GR-everest-linux-l2@marvell.com,
        mchehab+samsung@kernel.org, will@kernel.org,
        michael.chan@broadcom.com, Rob Herring <robh@kernel.org>,
        paulmck@kernel.org, bhe@redhat.com, corbet@lwn.net,
        mchehab+huawei@kernel.org, ath10k <ath10k@lists.infradead.org>,
        derosier@gmail.com, Takashi Iwai <tiwai@suse.de>, mingo@redhat.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sami Tolvanen <samitolvanen@google.com>, yzaikin@google.com,
        dyoung@redhat.com, pmladek@suse.com, elver@google.com,
        sburla@marvell.com, aelior@marvell.com,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, sfr@canb.auug.org.au,
        gpiccoli@canonical.com, Steven Rostedt <rostedt@goodmis.org>,
        fmanlunas@marvell.com, cai@lca.pw, tglx@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        rdunlap@infradead.org, schlad@suse.de,
        Doug Anderson <dianders@chromium.org>, vkoul@kernel.org,
        mhiramat@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        dchickles@marvell.com, bauerman@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 26, 2020 at 7:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> This makes use of the new taint_firmware_crashed() to help
> annotate when firmware for device drivers crash. When firmware
> crashes devices can sometimes become unresponsive, and recovery
> sometimes requires a driver unload / reload and in the worst cases
> a reboot.

Just for the record, the underlying problem you seem to be complaining
about does not appear to be a firmware crash at all. It does happen to
result in a firmware crash report much later on (because when the PCIe
endpoint is this hosed, sooner or later the driver thinks the firmware
is dead), but it's not likely the root cause. More below.

> Using a taint flag allows us to annotate when this happens clearly.
>
> I have run into this situation with this driver with the latest
> firmware as of today, May 21, 2020 using v5.6.0, leaving me at
> a state at which my only option is to reboot. Driver removal and
> addition does not fix the situation. This is reported on kernel.org
> bugzilla korg#207851 [0].

I took a look, and replied there:
https://bugzilla.kernel.org/show_bug.cgi?id=207851#c2

Per the above, it seems more likely you have a PCI or power management
problem, not an ath10k or ath10k-firmware problem.

> But this isn't the first firmware crash reported,
> others have been filed before and none of these bugs have yet been
> addressed [1] [2] [3].  Including my own I see these firmware crash
> reports:

Yes, firmware does crash. Sometimes repeatedly. It also happens to be
closed source, so it's nearly impossible for the average Linux dev to
debug. But FWIW, those 3 all appear to be recoverable -- and then they
crash again a few minutes later. So just as claimed on prior
iterations of this patchset, ath10k is doing fine at recovery [*] --
it's "only" the firmware that's a problem. (And, if a WiFi firmware
doesn't like something in the RF environment...it's totally
understandable that the crash will happen more than once. Of course
that sucks, but it's not unexpected.) Crucially, rebooting won't
really do anything to help these people, AIUI.

Maybe what you really want is to taint the kernel every time a
non-free firmware is loaded ;)

I'd also note that those 3 reports are 3 years old. There have been
many ath10k-firmware updates since then, so it's not necessarily fair
to dig those back up. Also, bugzilla.kernel.org is totally ignored by
many linux-wireless@ folks. But I digress...

All in all, I have no interest in this proposal, for many of the
reasons already mentioned on previous iterations. It's way too coarse
and won't be useful in understanding what's going on in a system, IMO,
at least for ath10k. But it's also easy enough to ignore, so if it
makes somebody happy to claim a taint, then so be it.

Regards,
Brian

[*] Although, at least one of those doesn't appear to be as "clean" of
a recovery attempt as typical. Maybe there are some lurking driver
bugs in there too.


>   * korg#207851 [0]
>   * korg#197013 [1]
>   * korg#201237 [2]
>   * korg#195987 [3]
>
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=207851
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=197013
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=201237
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=195987
