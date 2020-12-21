Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1752E0179
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 21:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgLUUVF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 15:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUUVF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 15:21:05 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6505C0613D6
        for <linux-wireless@vger.kernel.org>; Mon, 21 Dec 2020 12:20:24 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id i6so9998120otr.2
        for <linux-wireless@vger.kernel.org>; Mon, 21 Dec 2020 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3Dnzn17f9m0v155oO/9OuYuDJ7bDZTltdNjWrzci5E=;
        b=AkxDwDnuYm53VqC4xV8e11XhP6gdcoAxI4s8RxA+JJO5ImqnyTmaRhj1T/8XCf751u
         E8s/AHSvjZmFYhJEc1BTk5K/QUdbtx2kFGebwnnw20fny2nRTBNTB634tr4opKqqDrIp
         RLXtLVTRQ1iOly5RVUhpyM9JPkOdBgGCuvZak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3Dnzn17f9m0v155oO/9OuYuDJ7bDZTltdNjWrzci5E=;
        b=kLyUdrfmTvKs9AseUQpMrf7igQvz7tAbswEswsUwukrDelE6ISnASxA+CXrZUShrZg
         frWZaMmjSbZC21EMe1R2sb+K0bZQ1jebpd0hbCObSxxTAGyTiZZqsdkbqhFJyZcw7Rl3
         juRam1l5kEgBXv5L+vxUmnc8kgUi3HMZXL0g2OM8J/l+feldw3ks+jHRYixvySAL/NWk
         3sdb8fJttvZZc0j2P/UpdacNgaMvLfSEm1tKOR8BVdnHxWY0lF6BVuKDbH6dPPnh/V90
         zB3cejH7A+qYjd9/GEjo45HeicXateXBXU9gY4vEzA5l+kf48WzY4XkLrxafIJp5Ke8s
         1gLA==
X-Gm-Message-State: AOAM530Cg5zRNI93cRqzAIFA9Urqcb5G2t/LXNREMOJ3NUsLplSdepTb
        oaRLPqepZDGlooDQ77nsbF3248E1K7LhZw==
X-Google-Smtp-Source: ABdhPJw+lT3xIgSz1hQX5n1ugiuG1OgbzuGaQcx/QynUf1COpobpLX4Hzedln0OZu5L6IgN/XfzPLg==
X-Received: by 2002:a05:6830:1253:: with SMTP id s19mr13056137otp.270.1608582023939;
        Mon, 21 Dec 2020 12:20:23 -0800 (PST)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id h26sm4163104ots.9.2020.12.21.12.20.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 12:20:23 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id k9so2483778oop.6
        for <linux-wireless@vger.kernel.org>; Mon, 21 Dec 2020 12:20:22 -0800 (PST)
X-Received: by 2002:a05:6820:3d8:: with SMTP id s24mr12808980ooj.52.1608582022154;
 Mon, 21 Dec 2020 12:20:22 -0800 (PST)
MIME-Version: 1.0
References: <1608515579-1066-1-git-send-email-miaoqing@codeaurora.org>
 <CA+ASDXP8LotnQZNvXYZqfYH8za6rx1DaZmnH21TsO2NmzX+OZA@mail.gmail.com> <87ft3zndfr.fsf@codeaurora.org>
In-Reply-To: <87ft3zndfr.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 21 Dec 2020 12:20:09 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMK+8aOvtp-QgkXYXw=BZcFdo9H3ZFSXDsee0PFzUO97Q@mail.gmail.com>
Message-ID: <CA+ASDXMK+8aOvtp-QgkXYXw=BZcFdo9H3ZFSXDsee0PFzUO97Q@mail.gmail.com>
Subject: Re: [PATCH] ath10k: fix wmi mgmt tx queue full due to race condition
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Miaoqing Pan <miaoqing@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 21, 2020 at 11:53 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Brian Norris <briannorris@chromium.org> writes:
> > On Sun, Dec 20, 2020 at 5:53 PM Miaoqing Pan <miaoqing@codeaurora.org> wrote:
> >>         if (skb_queue_len(q) == ATH10K_MAX_NUM_MGMT_PENDING) {
> >
> > I believe you should be switching this to use skb_queue_len_lockless()
> > too.
>
> Why lockless? (reads documentation) Ah, is it due to memory
> synchronisation now that we don't take the data_lock anymore?

As the original post notes, there was no valid locking in the first
place anyway, but now that we're fully relying on the queue lock, we
either need to grab that lock, or else otherwise use lock-free-denoted
methods.

One could say it's about data synchronization, but it's really about
the lack of memory model -- C didn't have a formal one until
relatively recently, and the kernel has always blazed its own way
anyway. You need to annotate *something* about a bare read, otherwise
it's not safe to do concurrently; either compiler or hardware can do
nasty things to you. (In practice, it's unlikely this particular case
will cause a problem for this reason; it's already a somewhat
imprecise check anyway.)

Brian
