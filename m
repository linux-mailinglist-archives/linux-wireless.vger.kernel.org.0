Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7990976
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfHPU37 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 16:29:59 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:34493 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfHPU37 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 16:29:59 -0400
Received: by mail-lj1-f179.google.com with SMTP id x18so6417169ljh.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2019 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Z4kcycmk7cP+X6ruCeRZgpDdYRmawH/3B5+atDz6nM=;
        b=kdMfWNYxRBQt7UqSOZP8fc4rSV24B34+D4K+MTmLYp/5pNhZ3FjFSfJEluohR8ERfc
         fdvmWrJ3c8GBAEUPzosu3IRGmB1JR0dW5wlm2O9N0wqL49F9YKQHwyLsL815FLJ3aIo9
         RJoOVkaTschZpJNaIJMVQQd1uYjg20OBbuyOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Z4kcycmk7cP+X6ruCeRZgpDdYRmawH/3B5+atDz6nM=;
        b=Lg5WDphGbleIkvVnJ4EsifJEMyFTPE6hbTMats/aSreg9ILhz30CxAjQ9S9W3M+i/z
         gzSuP+RLoydUZF1mVa1uYWHt5KZaJaPIZSEpG8Z78eeAWn17e+om7VBg/j33c+DPWy+T
         AT5CiBBQ2Tkkej+COna4jGo0/1JRxTCwY0zX2vVWsWnw8d5j7nkTfesknRa/6tdsMbX3
         c7KhYrpeyrws9DfHEXaNH0Yf9iTTLUACwjdio95p6nmbjgfFp6Amx5LUQfcTeoDw3N8a
         1+gbECFxDqLlkhEQ2ZOVNdsZCsTgHNQ4IOml9p5AVO+SuBXMbCi21Qg1CtN3iv4ztJj7
         zrRg==
X-Gm-Message-State: APjAAAUcUTG+0Xy/f8/COx/iAxJwOLmd9BJnOtSFl3OPZRI8pmuStIYj
        4d2ELmkd9wBInke7M0JOM43OxgNs984=
X-Google-Smtp-Source: APXvYqxFyostv4oxV8f3n3akhaXoJ4iwz5FsCbT4GsYtv/5qXUFEILXARWf8XkhI/OP/D0Xbr5Jo4Q==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr6604675ljc.105.1565987396528;
        Fri, 16 Aug 2019 13:29:56 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id h15sm1111714ljl.64.2019.08.16.13.29.54
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 13:29:55 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id j17so4917964lfp.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2019 13:29:54 -0700 (PDT)
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr5998456lfq.44.1565987394528;
 Fri, 16 Aug 2019 13:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAAooHFeLWrY_wmCp-HWqygh8gnKsfpoPCky7SykOBKZgXkb8OQ@mail.gmail.com>
 <20190403210200.GA93453@google.com> <211816ff03cf188d834a21b1fbc98b4f8c5b81f4.camel@sipsolutions.net>
 <CA+ASDXOyXb0dPGOrjQR7C-b6dyftiZhkta3cwG28B9sC5wxHxQ@mail.gmail.com> <7687225C-D965-479E-BAE8-769B0AEADD76@holtmann.org>
In-Reply-To: <7687225C-D965-479E-BAE8-769B0AEADD76@holtmann.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 16 Aug 2019 13:29:43 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNC0hwFzSTvZmUq-B7r_H+pZ3N=p_kjfMqKb1gftsmDKw@mail.gmail.com>
Message-ID: <CA+ASDXNC0hwFzSTvZmUq-B7r_H+pZ3N=p_kjfMqKb1gftsmDKw@mail.gmail.com>
Subject: Re: Flag for detecting 802.11r Fast BSS Transition support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Matthew Wang <matthewmwang@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kirtika Ruchandani <kirtika@google.com>,
        Jouni Malinen <j@w1.fi>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Marcel,

On Fri, Aug 16, 2019 at 11:54 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> > Well, I guess we could just run the command and look for EOPNOTSUPP...
>
> this kind of API design and usage is bad. Try-and-error approach is just not sustainable.

Sure. That "suggestion" was quite literally an afterthought. Not
really a proper suggestion.

> Even while it is late to add a proper flag that indicates support, we need to do this to make nl80211 better for the future.

I suppose. I'm not quite sure how I would make use of that properly
though, given the corpus of kernels out there where the flag doesn't
exist (but the feature does). Some other heurestic for determining
kernel recency? Compile-time flags for the relevant user space, such
that one builds it for "new kernel API (w/ flag)" vs. "old kernel API"
(with the latter not even trying to look for the flag)?

Or I guess a more proactive approach: implement both a "supported" and
an "unsupported" flag, so user space can figure out a tristate: flag
not available (old kernel -- user space is left to guess) vs. command
supported flag vs. command not supported flag.

That seems a bit awkward though.

Brian
