Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE44748D4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhLNRFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 12:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhLNRFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 12:05:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230ACC06173E
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 09:05:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso17738881pji.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A6836gc0s76HSfL2ZiuDjKE+np84sI4oL8Iom/KwxZU=;
        b=Il8Xs0i7yKcGaPdWUSDd/OkT3CZc4f7Sh+8OtZOHt5cw/LrudBWuKIHPYCZV3FTrUk
         ZCxzlJ6YFhcdIDnKAZH3Iqz22CWaTY2lG178hVvPcNC1hDfdjqi6tv0VEcfafKKWKB8K
         dnyvY9pIEtiiYdtB0dnO0Lz00on3mBZZYm2BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A6836gc0s76HSfL2ZiuDjKE+np84sI4oL8Iom/KwxZU=;
        b=HQjZr5pNVSKApHgJKCjUbzOXTXSwMvBy5owldugRxjJuL1A8gR8UoY+r1clh71AObb
         LmBgy/7HaTxop0+iRtnVBO+KJTHtzkHbD/OOrUniLRJll+4jQ94sE2TmbwKrDcVIYd+u
         hinh2ALb8rnxEJQKwd4k3ax/nV6e0ujBlrEbeiIgqrrgmUVDlurHTTe/e7qAFbR/92mn
         HTQiIL0MZZtdNB6EnzCSjE60+DoRpMWOH/PcP5LsVBQHx4MHw2j8umllRQSoMgIuR0gw
         vg8xceu/Grn+VmaoGl0QBN82LmeCKh/lYsvnRCHbWciBUTo61xsypVUZflt0GtBqg9Kn
         CsTg==
X-Gm-Message-State: AOAM5332xOl3rQYDOK7KPkaDM9ZIQ3D0ACUYKoyyzbIcR2qe3s+5KBRb
        jLsl4p9KGSJF7hrCA71vhZ+zoKq/ntMg+w==
X-Google-Smtp-Source: ABdhPJyid4WvM6SF/FMb0ie7qooR8i+hL7xAAAtPkfmxyGyhk6umYMIjfNB8BB80oKo2BZX9lXr/IQ==
X-Received: by 2002:a17:90b:19d4:: with SMTP id nm20mr2745434pjb.106.1639501538563;
        Tue, 14 Dec 2021 09:05:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6sm436804pfc.30.2021.12.14.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:05:38 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:05:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] ath11k: Use memset_startat() for clearing queue
 descriptors
Message-ID: <202112140904.2D64E570@keescook>
References: <20211213223331.135412-1-keescook@chromium.org>
 <20211213223331.135412-9-keescook@chromium.org>
 <87v8zriv1c.fsf@codeaurora.org>
 <877dc7i3zc.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dc7i3zc.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Dec 14, 2021 at 05:46:31PM +0200, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
> > Kees Cook <keescook@chromium.org> writes:
> >
> >> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> >> field bounds checking for memset(), avoid intentionally writing across
> >> neighboring fields.
> >>
> >> Use memset_startat() so memset() doesn't get confused about writing
> >> beyond the destination member that is intended to be the starting point
> >> of zeroing through the end of the struct. Additionally split up a later
> >> field-spanning memset() so that memset() can reason about the size.
> >>
> >> Cc: Kalle Valo <kvalo@codeaurora.org>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: ath11k@lists.infradead.org
> >> Cc: linux-wireless@vger.kernel.org
> >> Cc: netdev@vger.kernel.org
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > What's the plan for this patch? I would like to take this via my ath
> > tree to avoid conflicts.
> 
> Actually this has been already applied:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=d5549e9a6b86
> 
> Why are you submitting the same patch twice?

These are all part of a topic branch, and the cover letter mentioned
that a set of them have already been taken but haven't appeared in -next
(which was delayed).

Sorry for the confusion!

-- 
Kees Cook
