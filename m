Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11882A8612
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 19:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgKESZX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 13:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbgKESZW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 13:25:22 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E28C0613CF
        for <linux-wireless@vger.kernel.org>; Thu,  5 Nov 2020 10:25:22 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so3705757lfc.4
        for <linux-wireless@vger.kernel.org>; Thu, 05 Nov 2020 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtdJiddFj/JVmqq84Ng6/IaGiQPTm1boOA18UOSGclA=;
        b=bg76QJYHQJ8Gvg0r3vdI/b36YOfUxywPva/A1XljHA9rBblUYTG55v84ZjqUd07RZ+
         r1EJqBgCDa+0EFSQVz7/wUMTYhoJFHhnqvzOnQ9dS5qjcODJdVUl0ns2kMqDDcwY8Huv
         oWfUles2q81ZFUpiTrMgkM3iDMWS63SCOpDVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtdJiddFj/JVmqq84Ng6/IaGiQPTm1boOA18UOSGclA=;
        b=mR1d2NTt9zUitpPEDF5cnl5y9NfFwVp2jkpjXtoOlyt7n3irmFFHeVzxNsCSRBBP6t
         gFhed3jn4Q5ZL8G/FfYYnKY5M1kKIB8VboaJu8kkrgX9uS02EnzzPQvmv4urKgbbESXy
         7HTIbo15V1f79YytQqR3E224cSiwdIuu+BiBVOWEZfubi1mG33zbo9NHgQD5Ecl3nEKR
         aIyA7Unk9wrvg4Bge0BEehj9fI29NY7GtTHYx9W7QllMV4oSWUABCNZ8auusyfzar3Jp
         A01uKWMIONfVi0sKlY3DgPOzj2fNmOUQYxo2Q1pkQR/ww04aPbAqaGh2Gr5sETpFNdws
         GcjA==
X-Gm-Message-State: AOAM532hAq9f6+/sSXYYMFxtcIOzUhn78EtVDYmxW0JOl1z2n3Ca6FhU
        SZTYTZwq28OdA/nThRTRDUx7wbjUO/yBsw==
X-Google-Smtp-Source: ABdhPJwwKCBfvSyCIPU30u98snJGCmILSlUQpuHNjT6hnQHHjnRbF3VPMF49Vm8lLb9xaTRuqxOypQ==
X-Received: by 2002:a19:7413:: with SMTP id v19mr1466158lfe.300.1604600720179;
        Thu, 05 Nov 2020 10:25:20 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 17sm257369lft.18.2020.11.05.10.25.18
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 10:25:19 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id v144so3657954lfa.13
        for <linux-wireless@vger.kernel.org>; Thu, 05 Nov 2020 10:25:18 -0800 (PST)
X-Received: by 2002:a19:c703:: with SMTP id x3mr1400737lff.105.1604600718451;
 Thu, 05 Nov 2020 10:25:18 -0800 (PST)
MIME-Version: 1.0
References: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
 <CA+ASDXM7TcF-zfbktbdSu-fDBuGe0LAgFq3Qt2zaq6efbWJ=sA@mail.gmail.com>
 <f3be456c4c748f21836279eb4dc16e5e@codeaurora.org> <CA+ASDXNaLvtJyY9_ds9RVL9VTkiYzChsGJS1czhVt-RKitCk5g@mail.gmail.com>
 <877dr0nqtv.fsf@codeaurora.org> <728196c17b4e70e18c99798a9945d1e6@codeaurora.org>
In-Reply-To: <728196c17b4e70e18c99798a9945d1e6@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 5 Nov 2020 10:25:05 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNESXqeW32Put_hDMF+16+KTqbd++iWk6DNTfsrEd+UbQ@mail.gmail.com>
Message-ID: <CA+ASDXNESXqeW32Put_hDMF+16+KTqbd++iWk6DNTfsrEd+UbQ@mail.gmail.com>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power limitations.
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Abhishek Kumar <kuabhs@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k@lists.infradead.org, ath10k <ath10k@lists.infradead.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 5, 2020 at 3:10 AM Carl Huang <cjhuang@codeaurora.org> wrote:
> On 2020-11-05 16:35, Kalle Valo wrote:
> > Brian Norris <briannorris@chromium.org> writes:
> >> On Tue, Nov 3, 2020 at 11:32 PM Carl Huang <cjhuang@codeaurora.org>
> >> wrote:
> >>> On 2020-11-04 10:00, Brian Norris wrote:
> >>> > What are the ABI guarantees around a given driver/chip's 'sar_capa'?
> >>> > Do we guarantee that if the driver supports N ranges of certain bands,
> >>> > that it will always continue to support those bands?

To be clear: the answer here is "no." So we have to map out what the
user/kernel interaction looks like when they change.

> >> ...
> >>> For a given chip(at least a QCOM chip), we don't see that the
> >>> range will grow or change.
> >>
> >> That's good to know. But that's not quite the same as an ABI
> >> guarantee.
> >
> > I'm not sure if I understood Brian's question correctly, but I have
> > concerns on the assumption that frequency ranges never change. For
> > example, in ath10k we have a patch[1] under discussion which adds more
> > channels and in ath11k we added 6 GHz band after initial ath11k support
> > landed. And I would not be surprised if in some boards/platforms a
> > certain band is disabled due to cotting costs (no antenna etc).

Right, I certainly was not taking the "never change bands" claim from
Carl at face value ;) This is exactly why I was asking.

> > My
> > preference is to have a robust interface which would be designed to
> > handle these kind of changes.

Sure.

> > [1] [PATCH] ath10k: enable advertising support for channels 32, 68 and
> > 98
>
> So the trick here is even if more channels are supported, it doesn't
> mean
> that it can support different SAR setting on these new channels. In this
> case,
> it likely falls into 5G range. It's safe for driver to extend the 5G
> range and
> doesn't break userspace. (68 and 98 are already in the 5G range, so
> driver just
> extends the start edge freq to 32 here.).

You can't just wave your hands and say it "doesn't break userspace" --
you have to think about how user space can use this API.

Specifically, consider that user space is not going to memorize
indeces, as those are per-driver implementation details; it's going to
memorize frequency bands. It wants to cross reference those with the
results of the GET/DUMP API before it translates those into indeces
for SET. As you're describing it, user space will have to have some
kind of "fuzziness" to its logic -- today, it thinks the 5G band is
[X,Y], but tomorrow it might expand to [X-N, Y+M]. So user space
should just ensure that it configures any band that intersects with
[X,Y], even though it didn't know about [X-N,X] or [Y,Y+M]? That logic
covers splits too, I suppose.

There's still the question of ranges that user space has no knowledge
of (i.e., no intersection with any known [X,Y]). I think there's two
approaches that are roughly equivalent:
1) require SET operations to specify all bands, and designate a NULL
or MAX value that user space should use for unknown/unconfigured bands
[or, user space uses some kind of "extension" from the nearest known
band, just to be safe?]
2) allow SET operations to specify a subset of supported bands [gray
area: what happens with the unconfigured band(s)? left as-is? use
max?]

We're approximately in #1 right now. If we're explicit about how
that's supposed to work, then I think we can stay with that. Although
it sounds like Carl is moving toward #2 (allow subsets).

> But for flexibility, given 6 GHz as example here, let's keep the
> explicit
> index for SET command. For sar_capa advertisement, the explicit index is
> dropped as Johannes suggested. New ranges can only be appended to
> existing
> ones. Like Brian said, only add or split is allowed.

> The complexity to
> handle
> splitted range Vs whole range is left to WLAN driver itself.

Hmm? I thought we're keeping the driver simple. I'm OK with that (and
moving a little more complexity into user space) as long as we're
clear about it.

Brian

> Userspace can SET any ranges which are advertised by WLAN driver. It's
> not required to set all ranges and userspace can skip any ranges.
