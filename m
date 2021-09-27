Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB5141A022
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 22:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbhI0Ub4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 16:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbhI0Ubz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 16:31:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B89C061604
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 13:30:17 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso26035039otb.11
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TRuVFJezgwN1Idjgpz4O0hFQqZueH291tcl1IF5+cgc=;
        b=iQNtNnFwObQlhz+wFxru4JWkG2kphRipmJodEdulqbsoyzNSwj+/FPb9Fu0EAj97v3
         zoyagzdQm58H9623FC/TQC8mcz3eZqf+afXSavGJ7R4+S/BaahJhN5eS5XPVOB85fKtz
         MZ14aHWwuOvvSgPITXXi+b7NKe90aAkaOcbXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TRuVFJezgwN1Idjgpz4O0hFQqZueH291tcl1IF5+cgc=;
        b=uoPGC4piKxql6M/BDCavZnIKiPXC1PRsyy38boHY2DnZelaPLHolhhBg+QWv9pbSli
         mZ5XfVVEsK1448ZhHAPHJ6lp/C0Mfa/WF3YsnDNDYTADkYB0gSPJINIpLY12rbhqhguq
         az1AWSkkyBK4gPQDJYxSKDxnOjl0Ni7ExmoIi5/+LOd0aaAnE0KvXn0dLgwTpXwOvK6x
         MRnCZfpahQQf+3/aDcsoVov8aXsaJr0ZtuoEmSfJCe7gFD9Qlc/iplQfA0lxU/oicnN+
         +3quYOrs9BXPSeNmoIDE13AHArY4YtPYy2O6Fe1DRErPUxTJ/ON915uDjxCnWj0mrjM+
         5PKA==
X-Gm-Message-State: AOAM531B4UkVR2bLooZgXEy75IJVrIg9ynjz1NmCGcyXsfUlRV7VQjmW
        ilJApe2jGe24hyONn0HPXs8pNz8+L9BZ7g==
X-Google-Smtp-Source: ABdhPJxzkZtFl0nSGj5k+TNkfPvm7gV423Iqa6iCwCG7XlLm7nhZfwuxXWJgIAxJ9jOeFs4EFlidhg==
X-Received: by 2002:a9d:4f1a:: with SMTP id d26mr1688771otl.65.1632774616237;
        Mon, 27 Sep 2021 13:30:16 -0700 (PDT)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id m26sm4289527otr.27.2021.09.27.13.30.15
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 13:30:15 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id a17-20020a4a6851000000b002b59bfbf669so2400555oof.9
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 13:30:15 -0700 (PDT)
X-Received: by 2002:a4a:c18d:: with SMTP id w13mr1560416oop.15.1632774614785;
 Mon, 27 Sep 2021 13:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210914114813.15404-1-verdre@v0yd.nl>
In-Reply-To: <20210914114813.15404-1-verdre@v0yd.nl>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 27 Sep 2021 13:30:03 -0700
X-Gmail-Original-Message-ID: <CA+ASDXN34u8mAVdhbfSK14pG_9qUcPvK4tFEywN4s2grqyu9=g@mail.gmail.com>
Message-ID: <CA+ASDXN34u8mAVdhbfSK14pG_9qUcPvK4tFEywN4s2grqyu9=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mwifiex: Work around firmware bugs on 88W8897 chip
To:     =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 14, 2021 at 4:48 AM Jonas Dre=C3=9Fler <verdre@v0yd.nl> wrote:
>
> This is the second revision of the patch, the first one is here:
> https://lore.kernel.org/linux-wireless/20210830123704.221494-1-verdre@v0y=
d.nl/
>
> Changes between v1 and v2:
>  - Only read-back the register write to the TX ring write pointer, not al=
l writes
>  - Mention firmware version in commit message+code comment for future ref=
erence
>  - Use -EIO return value in second patch
>  - Use definitions for waiting intervals in second patch

I tested this version, and it doesn't have the same issues v1 had
(regarding long-blocking reads, causing audio dropouts, etc.), so:

Tested-by: Brian Norris <briannorris@chromium.org>

As suggested elsewhere, this polling loop approach is a little slower
than just waiting for an interrupt instead (and that proves out; the
wakeup latency seems to increase by ~1 "short" polling interval; so
about half a millisecond). It seems like that could be optimized if
needed, because you *are* still waiting for an interrupt anyway. But I
haven't tried benchmarking anything that would really matter for this;
when we're already waiting 6+ ms, another 0.5ms isn't the end of the
world.

This doesn't really count as Reviewed-by. There are probably better
improvements to the poling loop (e.g., Andy's existing suggestions);
and frankly, I'd rather see if the dropped writes can be fixed
somehow. But I'm not holding my breath for the latter, and don't have
any good suggestions. So if this is the best we can do, so be it.

Regards,
Brian
