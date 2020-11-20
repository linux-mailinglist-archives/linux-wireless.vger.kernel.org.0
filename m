Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69C12BB817
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 22:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgKTVEh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 16:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731250AbgKTVEg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 16:04:36 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52694C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 13:04:36 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id o25so11987475oie.5
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 13:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veXWdye4EPb1hf22k/yabOHMzQdWo29UrU9Jxr6Z+6g=;
        b=B2TUNk7NCv+2OSJErtonoLqm/CVdIxLlDhUNhg9hUAKvLxHavqwTBEfy7xbTEig+pi
         72h1LH2HQOEeZDXMsNSKayDVvWjo1Z96344pykxAqmngrq1s9duCmE4qUtu0oFjLWK8V
         yuTqiR6RmH00V5KgVczlVzF0pnOm6OWCCfFlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veXWdye4EPb1hf22k/yabOHMzQdWo29UrU9Jxr6Z+6g=;
        b=cTL7iXdyV9UtqcBdInQcYK+b+y2JsqA3yr8ksZ0638tfBMEpUSXjGBio9IrGMtwhh6
         Zg8rLKBkaZws9tpzUdV3Z2MGLqeN3feugLJqYCoiRLJH+ipa5Ho8hDOcwgJSpTKFu7Lc
         n9cjF+7nplv3z3fZc2+Usur8voQ6G1p58Rr46BGVUq5py8TWRy3PPJJjWdfSFdLeKCmY
         5Fl70eS2jgsAo80Zn4qdQVPc2YxMiB6NbnKR/RXUu689LfeuJyc/gAEDbGf9l72cliFw
         NcsOeWTgIcCjAd8U7COYMma2cUlhtY8DWPF2sYb9LAxuT/JKbQgLS2guEZ+Tr74bCQfq
         NHwg==
X-Gm-Message-State: AOAM5315Bzmoo2HKlcwo70ZCrAgUy09HMb46ZVqZnkGj1gtCJejag+FY
        FUHQyR5iMwaTYslomtH5QAOWqt6TuWvLkA==
X-Google-Smtp-Source: ABdhPJx+YKj1GQ2VBlaPPFHSnKDnXhLkZ+djafUlsHf00RqFUTmbuCFMJ+H3fXRoithta/D0Nn+x+Q==
X-Received: by 2002:aca:2209:: with SMTP id b9mr7127435oic.119.1605906273942;
        Fri, 20 Nov 2020 13:04:33 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id k10sm1877275otb.81.2020.11.20.13.04.31
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 13:04:32 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id j14so10061966ots.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 13:04:31 -0800 (PST)
X-Received: by 2002:a05:6830:2083:: with SMTP id y3mr16408151otq.203.1605906270889;
 Fri, 20 Nov 2020 13:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20201028142433.18501-1-kitakar@gmail.com> <20201028142433.18501-2-kitakar@gmail.com>
 <CA+ASDXMfuqy=kCECktP_mYm9cAapXukeLhe=1i3uPbTu9wS2Qw@mail.gmail.com> <8fa12bfff1cc30b655934e303cad78ae75b0fcde.camel@gmail.com>
In-Reply-To: <8fa12bfff1cc30b655934e303cad78ae75b0fcde.camel@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 20 Nov 2020 13:04:19 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMUdYHTKphxFwcAim79N_DJiQFHFN0gDZsPB4rMHyxxXw@mail.gmail.com>
Message-ID: <CA+ASDXMUdYHTKphxFwcAim79N_DJiQFHFN0gDZsPB4rMHyxxXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mwifiex: disable ps_mode explicitly by default instead
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>, verdre@v0yd.nl
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 30, 2020 at 1:04 AM Tsuchiya Yuto <kitakar@gmail.com> wrote:
> On Thu, 2020-10-29 at 11:25 -0700, Brian Norris wrote:
> > For the record, Chrome OS supports plenty of mwifiex systems with 8897
> > (SDIO only) and 8997 (PCIe), with PS enabled, and you're hurting
> > those. Your problem sounds to be exclusively a problem with the PCIe
> > 8897 firmware.
>
> Actually, I already know that some Chromebooks use these mwifiex cards
> (but not out PCIe-88W8897) because I personally like chromiumos. I'm
> always wondering what is the difference. If the difference is firmware,
> our PCIe-88W8897 firmware should really be fixed instead of this stupid
> series.

PCIe is a very different beast. (For one, it uses DMA and
memory-mapped registers, where SDIO has neither.) It was a very
difficult slog to get PCIe/8997 working reliably for the few
Chromebooks that shipped it, and lots of that work is in firmware. I
would not be surprised if the PCIe-related changes Marvell made for
8997 never fed back into their PCIe-8897 firmware. Or maybe they only
ever launched PCIe-8897 for Windows, and the Windows driver included
workarounds that were never published to their Linux driver. But now
I'm just speculating.

> Yes, I'm sorry that I know this series is just a stupid one but I have to
> send this anyway because this stability issue has not been fixed for a
> long time. I should have added this buglink to every commit as well:
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=109681
>
> If the firmware can't be fixed, I'm afraid I have to go this way. It makes
> no sense to keep enabling power_save for the affected devices if we know
> it's broken.

Condolences and sympathy, seriously. You likely have little chance of
getting the firmware fixed, so without new information (e.g,. other
workarounds?), this is the probably the right way to go.

Brian
