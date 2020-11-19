Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB042B9BF5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 21:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgKSUZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 15:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgKSUZl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 15:25:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87FDC0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 12:25:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a186so5591177wme.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 12:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlNFBi00xJwXkGhFryMKTDVLKYxBMURfpqPBFsFBPCg=;
        b=NmrUVz8qRYS1aIeSdDaZwVIF+AboENSdJkVMZmb0DLm9fr6XMoAeT0ysvuOytoynjj
         Y+U6eOMgeKixLiKHWicpPnWMvfqZ/wGYbal5GuKUqXuRA/rAaxRnp/5FgLk1BX3pNSRf
         til67E/8vVoMXxxNxR782LHn/nECnrjcTSFGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlNFBi00xJwXkGhFryMKTDVLKYxBMURfpqPBFsFBPCg=;
        b=fE+/KtxIws8kzUEa7gzKv/LmrysVaWVfgtppviR58Hny8RBKsmzRKG+jAYe9fPT73o
         VYDBlgzhjpvFa4A5QufoCONoqf6HokgyebdEGGy3u2dvSiwEqEFDAvXst69utZu0kIFT
         HK2mv6lUtO7jkEd+HZjgJgbndZM9wIWj9yB1Q1wbugltadquBi6gchcGhyn+Of3kL7NH
         3GgmmpxpaHDi2cSSxUAvB3TA1yGhcq6DYqCve38MzjUxZYUUwI7kKjh1PAFImX2kCefW
         teiCy59FSGFDyiSWg9MUEr0+Ilo7q+EvokT2a16W/sNPV0hCMEPkRKqSamsoc7YTRuVS
         1y5A==
X-Gm-Message-State: AOAM531OHa6N8dEI+1ql3T/H5Oi2DUL9p0dephmz14b3fXNEkEjNXIAy
        8oWJyYmFLGmdzcU98zcq6K0zqnL7km2Sv2sQcrbYgQ==
X-Google-Smtp-Source: ABdhPJwHVUiDjIZdEL3zLzFl+shlaEX73xGLSrnJJDmGw2OH6rJz2ftNorcs25BEsAw2ydJHPFQzWH7RAyBqU0+bVb4=
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr6326747wmb.54.1605817538470;
 Thu, 19 Nov 2020 12:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20201106100708.4609-1-cjhuang@codeaurora.org> <20201106100708.4609-2-cjhuang@codeaurora.org>
 <64e072a168c12f58847a5ee16bfdb7e47576284f.camel@sipsolutions.net> <00c810b30b91397e562ca54475940afc@codeaurora.org>
In-Reply-To: <00c810b30b91397e562ca54475940afc@codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Thu, 19 Nov 2020 12:25:28 -0800
Message-ID: <CACTWRwtcd2rdE-JQTh0t=Xwu9Vv-2He2M4wVDXbbiV1FOyNq7g@mail.gmail.com>
Subject: Re: [PATCH 1/3] nl80211: add common API to configure SAR power limitations.
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>, kuabhs@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Johannes has some good comments, apart for that I have some nits.
> > And wait, I thought we agreed to remove the index? Now I'm confused.
> >
> Using index in SET operation doesn't add burden to userspace and kernel,
> but it provides some flexibility so userspace can skip some certain
> ranges.

I agree with Carl's comment, we do need the frequency index. If the
frequency index is provided, then the order is not important which
makes the data more clear or the set_sar_spec function needs to parse
the frequency ranges (and ofcourse userspace has to populate that as
well). If the frequency index is not provided, then the driver has to
assume that the userspace is not making any error in mapping of the
power and desired frequency.
Other reason is, might be a bit unlikely, but if in future there are
new subbands, then it gives a flexibility to the userspace to
explicitly provide the band for which it needs to set the power for.

> + *     used with %NL80211_CMD_SET_SAR_SPECS. The message contains fileds
> + *     of %nl80211_sar_attrs which specifies the sar type and related

typo: fileds .. you mean fields

-Abhishek
