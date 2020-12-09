Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7502D4C1E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 21:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgLIUmk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 15:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgLIUmk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 15:42:40 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0FC0613CF;
        Wed,  9 Dec 2020 12:42:00 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t7so1862304pfh.7;
        Wed, 09 Dec 2020 12:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r64nMNffbc5B15T93xiKUR2+gLdT98xxN7V6bmH5LGw=;
        b=YM3NcCVpSI/fEBtfTyUEZHDdiD1hFoe/acsAuOyyWlnhzrS2wk4j6TDOegBUth37rG
         xHbdXT83SwKCquE88ITb/sOnuxSpalLz/YbKs/48Asq3MjUsZfeu2rq4wyAYFL/n7sw9
         jyLY10OXSa5EfcQB1pUTSL9NXZC3QgeRkYL45s2pT68JyEqTzGUeyjD2uf5itLwcAwO5
         OlKK2Ug4baHvW5oCkGVQj3RcyZbOJZOnBaPmTEoqRfseMUDVp7g5ytWRgB/hlGZg6iJE
         XNKQuy/i0x+Xt2L3jKhEPAAp15+nzZkolT2r8lXwPTlmd8KLZt9L5eeVAPDxM9FxwIxT
         0q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r64nMNffbc5B15T93xiKUR2+gLdT98xxN7V6bmH5LGw=;
        b=s7LdCR5w+r43wTG5oGRCWbXwluf0orSGibvGgEH/8bUm9WET/j3VezAp2QtBK/YErq
         0MmOCQKQhTVW9wLJqfBe8mAMcmeT0gVUlsrQTblgVoxGhX5hYXKyJF9mgIIfGMZmfnqt
         CSeqh+XjJJIdhTI9Za0sycuYCsPldWIpRjfMG1FGFwL4h+js8cHgIpf11G74dLX4N0la
         mN/HCfKznPjIIN9nuv5WUCywGfQuxsxhBCveRzpLAdHWrev8MlO1EqozcU7nShgjqZe8
         pzP9NTG2xWMrxfvAQd6HPAM+G7M3tuAJcND7JinXjQzrjrjjfyO9+mf2gvFVrl5ck6Dd
         /0GQ==
X-Gm-Message-State: AOAM532a042KeSD/1bHNxlxlsaGY3eLhh87jXSFkr5HFees6PtmNzt+D
        KNZNrrQLSp2nT2bfjVZlCxwzFqqqHNUzLTvDBg==
X-Google-Smtp-Source: ABdhPJxRPHYF9Ret/7AplWyImCstV5BZJouSj8ruS1E55XfQJiiOjKyKVSYFGCzYqU0Jb5Od2Ul6Xhl1D52OrFbJfig=
X-Received: by 2002:a63:ce07:: with SMTP id y7mr3510530pgf.162.1607546519802;
 Wed, 09 Dec 2020 12:41:59 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
 <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com> <CANUX_P3S-Dt2homERtXgxQuh+q=xCTDvqx2ZwOXvZfjMrBY-9w@mail.gmail.com>
In-Reply-To: <CANUX_P3S-Dt2homERtXgxQuh+q=xCTDvqx2ZwOXvZfjMrBY-9w@mail.gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 9 Dec 2020 20:41:48 +0000
Message-ID: <CALjTZvYDsaAE8hX06vb98me4mrDTk3xjkCH+sUUqExSTTh1E4g@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Emmanuel Grumbach <egrumbach@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, again,

On Wed, 9 Dec 2020 at 20:40, Emmanuel Grumbach <egrumbach@gmail.com> wrote:
>
> Besides, don't you get a stack dump in the vicinity of this register
> dump? That's be helpful to see.

Nope. No stack trace at all. Only the register dump.

Thanks,
Rui
