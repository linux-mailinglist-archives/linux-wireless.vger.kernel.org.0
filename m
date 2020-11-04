Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDC22A6BFA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 18:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbgKDRpO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 12:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbgKDRpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 12:45:13 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E194C0613D3
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 09:45:12 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v19so18955553lji.5
        for <linux-wireless@vger.kernel.org>; Wed, 04 Nov 2020 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JODQYpwDHSuwE4ajwKzEy9j5Cf4E10+Gnjki0JgNkHQ=;
        b=h+Ny9Xu0uFEnmEis6AkZ7QRTKqTo3D+woSrdCGtB6q0OtFZYmI0dUE6WCHo5/tjdGT
         6HarNeDvekcFrRN2o6eiF0Xt2GDktQxqVBv/r7x6hwcIMVRxEp0H/aO+sz6oC2PkMQM6
         kUcV3Tjzqb4UyPM3l0Eb8PChjP/FKOPufOAbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JODQYpwDHSuwE4ajwKzEy9j5Cf4E10+Gnjki0JgNkHQ=;
        b=i5KLLLupSu3T9VWQARnxfQvVVutJQmRzhw3HPv4Ud1L1QKlrkN3e+3vCXltYxuPjVN
         B3R+IA4DgiA2L0TeNAKmls1UeSi12wZ/2r73opL3ZAvcOkWSTMunGTHft7P6J2wrgNiz
         q2RhgKTg4ef5dwZzk6owVcEsrRo35LBydzzgo4q/xm19kmBCllBehdoMErRlJaU8uOc9
         Zf2DUzqyB5bk6apB+K7wAXIuchFFUi+I+XSIq91UyJJbw1NGfJo21K4L5PAxXY5K0INv
         3ljPjcvHqRrvroOl9SNzdZNuz0MMRG8i5MbZe7AY6KJ0DHG4RLi5VkXN8We8jpIsyojw
         LsDw==
X-Gm-Message-State: AOAM533C8myFMRcFvbd4AOlCMQXaqte5Co6EcFVZ/Pk66veBRRXFC2Y1
        GXs0vS2YGPK2ei9N0fbgbA+Pd7Acp09PmQ==
X-Google-Smtp-Source: ABdhPJzs6rnHBzBtzToZjHuiaGQoih8cJA5MwqX6Fnvatzb3EYnNMwN8ABZP+m24M3LLVDN1uEsfjw==
X-Received: by 2002:a2e:8143:: with SMTP id t3mr11739645ljg.29.1604511910290;
        Wed, 04 Nov 2020 09:45:10 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id l10sm19437lfk.199.2020.11.04.09.45.09
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 09:45:09 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id f9so28301313lfq.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Nov 2020 09:45:09 -0800 (PST)
X-Received: by 2002:a19:a40c:: with SMTP id q12mr9487946lfc.541.1604511908602;
 Wed, 04 Nov 2020 09:45:08 -0800 (PST)
MIME-Version: 1.0
References: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
 <CA+ASDXM7TcF-zfbktbdSu-fDBuGe0LAgFq3Qt2zaq6efbWJ=sA@mail.gmail.com> <f3be456c4c748f21836279eb4dc16e5e@codeaurora.org>
In-Reply-To: <f3be456c4c748f21836279eb4dc16e5e@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 4 Nov 2020 09:44:55 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNaLvtJyY9_ds9RVL9VTkiYzChsGJS1czhVt-RKitCk5g@mail.gmail.com>
Message-ID: <CA+ASDXNaLvtJyY9_ds9RVL9VTkiYzChsGJS1czhVt-RKitCk5g@mail.gmail.com>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power limitations.
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k@lists.infradead.org, Doug Anderson <dianders@chromium.org>,
        Abhishek Kumar <kuabhs@google.com>,
        ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ ath10k

[ I realize I replied to the "wrong" RFC v1; I fell trap to Kalle's note:

"When you submit a new version mark it as "v2". Otherwise people don't
know what's the latest version." ]

On Tue, Nov 3, 2020 at 11:32 PM Carl Huang <cjhuang@codeaurora.org> wrote:
> On 2020-11-04 10:00, Brian Norris wrote:
> > What are the ABI guarantees around a given driver/chip's 'sar_capa'?
> > Do we guarantee that if the driver supports N ranges of certain bands,
> > that it will always continue to support those bands?
...
> For a given chip(at least a QCOM chip), we don't see that the
> range will grow or change.

That's good to know. But that's not quite the same as an ABI guarantee.

> In addition, with current index-power SET method, it's hard for driver
> to know what the index mean given your example. Does the index mean
> [5,5 + x] or [5, 5 + x/2] ?  So it's required for user-space to specify
> all the ranges.

Well, we'd have to change the API (which is why I'm asking now) if we
wanted the kernel to handle this gracefully. We'd have to retain the
index (which, it sounds like you might be dropping if things go as
Johannes suggested), so user space can continue to request the old
range even if the driver also splits up a new range.

More explicitly, something like this:

Linux version A:
ath10k supports:
0: 2G band
1: 5G band

Linux version B:
ath10k supports:
0: 2G band
1: 5G band
2: 1st half of 5G band
3: 2nd half of 5G band

Indexes 2 and 3 would be overlapping with 1 of course, but it does
mean that the following SET request will work on both A and B:

SET
index 0 -> power X
index 1 -> power Y

Notably, that also requires nl80211 allow specifying only a subset of
bands in a SET request.

But spelling that out, the proposal sounds more complicated than it's
worth -- it's probably better to let user space handle the complexity.
So that goes back to making ABI requirements clear, so we don't have
kernel/user mixups/regressions down the line.

> The number of ranges is quite small, so the SET itself is not a
> problem to specify all.

Sure, but it does mean that if I (user space) don't trust that driver
support remains constant, I have to do some negotiation. I would
already do some verification via the get/dump API of course, but
negotiation is pretty complex if there is unbounded flexibility. It
would be nice to spell out what sort of negotiation is reasonable as
part of the ABI. For example, it might be reasonable to say that bands
should never be combined; only ever added or split.

BTW, considering the possibility of "added" bands, how about this
example: if ath10k were to add 6GHz support (and SAR to go with it),
user space would have to learn to specify limits for it too, due to
the "all or nothing" limitation? It'd be good to be up front about
this, similar to the previous paragraph.

> Brian, are you fine that we go with this proposal? I'll send
> V2 based on the comments from Johannes and Abhishek.

I think I'm fine with it; my main concerns around ambiguities, so
maybe it just needs more explicit mentions in the docs (commit
messages and/or comments). I'd be happy to see v2 and go from there.

Brian
