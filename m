Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0882D19B2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 20:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgLGTgs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 14:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgLGTgr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 14:36:47 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4D4C061793
        for <linux-wireless@vger.kernel.org>; Mon,  7 Dec 2020 11:36:07 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id v85so6134060oia.6
        for <linux-wireless@vger.kernel.org>; Mon, 07 Dec 2020 11:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RceGSUFUjLEJW2/scx8HGaoDZct6NVCXjiTK9ixz94=;
        b=UqQDziRM06nUwkOqk9oocYn+WHozQc9sLlHnMvp+bs9W4+eRhAGuTj0f377FbXtgQ9
         saT0UGQRIFbZPDSy6ite4iDUkUbydVukCwhEYfzEWOCSgBjrGqvaYlSEbnE7F0DjqqR0
         q0eWqkt2F9y/LE+l9/PmIghjQstKsX5P9fSyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RceGSUFUjLEJW2/scx8HGaoDZct6NVCXjiTK9ixz94=;
        b=IDCjOIwaEogepkwmHWOSy6by+XU1+NgblZtrxlhTuJJh1LcqP3rL3tBo8G7Oexxs4r
         KUKiT7zBMUDIToc17qsqP+K0nqtNl3j6fvtbiN8r3lq32EcY+QG8wLMO88hpIprzRWZW
         kwcGmMJ0LKVDsl/fo+iMTN8mrVbnMLpR3K1rUcRvSyLpMi8sJiuaD9ToJbBtgde6kSdO
         sbIKTMG36/AQWT8QGb1ng90e6ZrymvyPsRxwL70b/93AEzKWkfOlDf526kjY6QnPZ1kx
         KQHn+HOqxyWGe3XNdCl6X82y6LiNbVm7idaTQXcZxcngmeSHl6fvw84dxRJry+DB8htB
         rLEw==
X-Gm-Message-State: AOAM5301Q3jqbOoKdFb0CPt35iPS0VYT/ZPSgdU5OXfkRAzyW/XyYels
        i/E4IYVeFaftcZgVqGwkItN4TTtJTZOb3g==
X-Google-Smtp-Source: ABdhPJxZCbW48SZXNcwj/3AV0+KRx63x5AIUZr5lqjbOlfHq5v6r0n/MS4qMEbsDgAOJ3O/CgJhwSA==
X-Received: by 2002:aca:418b:: with SMTP id o133mr282850oia.67.1607369766247;
        Mon, 07 Dec 2020 11:36:06 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id d62sm3118302oia.6.2020.12.07.11.36.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 11:36:05 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id 11so13600904oty.9
        for <linux-wireless@vger.kernel.org>; Mon, 07 Dec 2020 11:36:05 -0800 (PST)
X-Received: by 2002:a9d:744a:: with SMTP id p10mr3982059otk.203.1607369764576;
 Mon, 07 Dec 2020 11:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20201203185732.9CFA5C433ED@smtp.codeaurora.org>
 <20201204111715.04d5b198@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com> <87tusxgar5.fsf@codeaurora.org>
In-Reply-To: <87tusxgar5.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 7 Dec 2020 11:35:53 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNT+uKLLhTV0Nr-wxGkM16_OkedUyoEwx5FgV3ML9SMsQ@mail.gmail.com>
Message-ID: <CA+ASDXNT+uKLLhTV0Nr-wxGkM16_OkedUyoEwx5FgV3ML9SMsQ@mail.gmail.com>
Subject: Re: pull-request: wireless-drivers-next-2020-12-03
To:     Kalle Valo <kvalo@codeaurora.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 7, 2020 at 2:42 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > On Thu,  3 Dec 2020 18:57:32 +0000 (UTC) Kalle Valo wrote:
> > There's also a patch which looks like it renames a module parameter.
> > Module parameters are considered uAPI.
>
> Ah, I have been actually wondering that if they are part of user space
> API or not, good to know that they are. I'll keep an eye of this in the
> future so that we are not breaking the uAPI with module parameter
> changes.

Is there some reference for this rule (e.g., dictate from on high; or
some explanation of reasons)? Or limitations on it? Because as-is,
this sounds like one could never drop a module parameter, or remove
obsolete features. It also suggests that debug-related knobs (which
can benefit from some amount of flexibility over time) should go
exclusively in debugfs (where ABI guarantees are explicitly not made),
even at the expense of usability (dropping a line into
/etc/modprobe.d/ is hard to beat).

That's not to say I totally disagree with the original claim, but I'm
just interested in knowing precisely what it means.

And to put a precise spin on this: what would this rule say about the following?

http://git.kernel.org/linus/f06021a18fcf8d8a1e79c5e0a8ec4eb2b038e153
iwlwifi: remove lar_disable module parameter

Should that parameter have never been introduced in the first place,
never be removed, or something else? I think I've seen this sort of
pattern before, where features get phased in over time, with module
parameters as either escape hatches or as opt-in mechanisms.
Eventually, they stabilize, and there's no need (or sometimes, it's
actively harmful) to keep the knob around.

Or the one that might (?) be in question here:
fc3ac64a3a28 rtw88: decide lps deep mode from firmware feature.

The original module parameter was useful for enabling new power-saving
features, because the driver didn't yet know which chip(s)/firmware(s)
were stable with which power features. Now, the driver has learned how
to figure out the optimal power settings, so it's dropping the old
param and adding an "escape hatch", in case there are problems.

I'd say this one is a bit more subtle than the lar_disable example,
but I'm still not sure that really qualifies as a "user-visible"
change.

Brian
