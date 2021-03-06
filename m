Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C620732FD23
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Mar 2021 21:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhCFUdr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Mar 2021 15:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhCFUdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Mar 2021 15:33:18 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA044C06174A;
        Sat,  6 Mar 2021 12:33:17 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id k2so5830551ioh.5;
        Sat, 06 Mar 2021 12:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=7sC/tFvb23jll3GtWYTTybk52/nCqyT0CiONRP5YWZ0=;
        b=T2XURi0z3603AGh0plUV+gAY2C4jFansqvW2rmZAPDK9+2KinZMygcTro8Ocrnvwuz
         KBuilClva5F/3gDwVyXd2xJG/zVJei3DdL6+pfBqVjK/rRQ7VJYqO/mg7sWJlMrCx4Go
         ctOCP/aoURLRSdC6ya7+y8qYASX9ualBt2O4alO/qj6qxmixxoF5V63IM61EqkqQFhjB
         UhEi4qp9VK9TTTAQtZjz+HhoSqYL4qc/JYRryuk+yx+1RMJcJkLIxK7YNnzCCNFKm43C
         wSF/plvbNZ5cRjekjTn1ewsUxZrBkorfTT486DiaMRVMUEYSaahFsD6jThRCT6oEy+zE
         ZrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7sC/tFvb23jll3GtWYTTybk52/nCqyT0CiONRP5YWZ0=;
        b=M+0ZcZ88js/jn0fZddVx5M+2myv5uIRwUzGuaW2a7Tktetsoy4jbB7/N2/Mqg8rpor
         0+MUcNOuv2LQULXM0ah0/P8RnkKC0xwcuCAgXln1PlG58YGTDxosCCQoJnLNhAAk/87d
         OMLL0if72PA/n/3/aYzCSZTHiYDTaslyg97wd/DyYyArsLLGzpW3fwJ9xW1UPXgCtx4n
         0VWS9NHNNBOSnIOdmAtIFAY41h3V3mXXmSZwH2WHSgYFX/La7gF6/+6xlAeW0xDMrniU
         AJ1Ous6WXZsGo5wIYvr6kCD2kJkCbmj0S/K5BLxj82L+H8EXYDrGbtbvcM1QuEB8nC7M
         J2sA==
X-Gm-Message-State: AOAM531Fsx3Q6RC6b+ge6GLwdKDqYO3xbEqQW3rDbOQ1AHFHTbWWY0Hh
        ajBxb4tKSH7CVgKw9KzvOYF4NE/sVEz3dffQ9Cw=
X-Google-Smtp-Source: ABdhPJzBECciT2r5H0BLAW6TVzZUgVb3JVteLt1pIlMQnrDaI5iVweScEFF76yDGh+siGI1DPJvFkElC4SezF18FyMs=
X-Received: by 2002:a5e:8c16:: with SMTP id n22mr13101622ioj.156.1615062797373;
 Sat, 06 Mar 2021 12:33:17 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils>
 <CA+icZUVedsZzJ7qk4fgSZV37M6YUjnP=sfWFK9V9f0y0KpQ4tA@mail.gmail.com> <alpine.LSU.2.11.2103061224040.1637@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2103061224040.1637@eggly.anvils>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Mar 2021 21:32:41 +0100
Message-ID: <CA+icZUXhv+FWxvt4Fp9GdcXothC5qamzgksMBqn334Re06GAfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iwlwifi: fix DVM build regression in 5.12-rc
To:     Hugh Dickins <hughd@google.com>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 6, 2021 at 9:27 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Sat, 6 Mar 2021, Sedat Dilek wrote:
> > On Sat, Mar 6, 2021 at 8:48 PM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > There is no iwl_so_trans_cfg if CONFIG_IWLDVM but not CONFIG_IWLMVM:
> > > move the CONFIG_IWLMVM guard up before the problematic SnJ workaround
> > > to fix the build breakage.
> > >
> > > Fixes: 930be4e76f26 ("iwlwifi: add support for SnJ with Jf devices")
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> >
> > See "iwlwifi: pcie: fix iwl_so_trans_cfg link error when CONFIG_IWLMVM
> > is disabled" in [1].
> >
> > - Sedat -
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=62541e266703549550e77fd46138422dbdc881f1
>
> Thanks for looking out that and the other one, Sedat: I swear I checked
> linux-next before sending, but my check seems to have been... defective.
>

No problem, Hugh.

Here, I have also an iwldwm device aka Intel(R) Centrino(R) Advanced-N
6230 AGN (REV=0xB0) and needed both patches.
The opmode commit fixed a call-trace.

It is always good to check wireless-drivers Git and/or linux-wireless ML.

- Sedat -
