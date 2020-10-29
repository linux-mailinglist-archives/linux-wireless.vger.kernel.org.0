Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB22C29F451
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 19:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgJ2S5Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 14:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2S5P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 14:57:15 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71872C0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 11:57:15 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m16so4267607ljo.6
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XcpjY/kPuA4EUV38Vs/YpJREclicBfcPi/8OJvF6Zp0=;
        b=B6yphniAqXI/GkxR8wlQNDbHRgM5TshKPwVtKrK8jOos7zF9eY3gzOl2cccs+yWfDX
         AjJg7HxGwBrveb2dUENJQqABKBREdFP7zrT9Bgrqunm0xBWw65IuEcQ0CgFpmW2Rz8hN
         7fCmzEcale9NOmacj68mTfmCccOjFRMQzUMwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcpjY/kPuA4EUV38Vs/YpJREclicBfcPi/8OJvF6Zp0=;
        b=rcDxD925XW4ao0PKDYiZSOMj1Jn4yaRB8/aQuctK20MctD0hKiqMATfMRdAReszfOx
         fiZcMzpCdZGjWZ6LG7n/nNAubT/rnKQyuE3gVFIyUyHHTZuhsTjpBBvO6F/b1452eJM3
         54xRTD0GTSWt9W1v9BECdzQlqNhQYciozJEXBkVpvVhiPU5co8ijaoBzlkD2kpWjeGse
         uW65+zcp1nPXVHSCxyxxrBNffndF8bLyI6H2tFGHn9E0iHdi7qLvK+NiMwdkXVSnvzqS
         eIgEDlpZCas/60SwxFLo/8F3xtqHMxjXsAe9QyoZAD8OpL/8o2o+ek6+YmGSD05VrQWL
         v5Dw==
X-Gm-Message-State: AOAM5318j+1q3c5GWgimobRHjwyAdwlvg4QfF2m4LjRiqmWNc04Afg/x
        GQKcfyoCfcETbXZLsDBfqkJdn9U+zozbww==
X-Google-Smtp-Source: ABdhPJwBkkJHkHOavz3D1koIAraxHpMM+q5J0SU6xMCxu/XoNGmjs3dQsStMHBM11wZR70i9NzW8Zw==
X-Received: by 2002:a2e:8296:: with SMTP id y22mr2351584ljg.174.1603997833389;
        Thu, 29 Oct 2020 11:57:13 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id d7sm419442ljg.140.2020.10.29.11.57.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 11:57:11 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 23so4262875ljv.7
        for <linux-wireless@vger.kernel.org>; Thu, 29 Oct 2020 11:57:10 -0700 (PDT)
X-Received: by 2002:a2e:8942:: with SMTP id b2mr2536155ljk.441.1603997830537;
 Thu, 29 Oct 2020 11:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201028142433.18501-1-kitakar@gmail.com> <20201028142433.18501-2-kitakar@gmail.com>
 <CA+ASDXMfuqy=kCECktP_mYm9cAapXukeLhe=1i3uPbTu9wS2Qw@mail.gmail.com> <CAHp75VfUv6cD8BKxircd7dU-5p7Q6JL1dVz5X=0SC-Y4pqYhjA@mail.gmail.com>
In-Reply-To: <CAHp75VfUv6cD8BKxircd7dU-5p7Q6JL1dVz5X=0SC-Y4pqYhjA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 29 Oct 2020 11:56:57 -0700
X-Gmail-Original-Message-ID: <CA+ASDXONuRUZ_2+-7PtWigp=ZQsS2_guCbmNP30yL2qQZXHThg@mail.gmail.com>
Message-ID: <CA+ASDXONuRUZ_2+-7PtWigp=ZQsS2_guCbmNP30yL2qQZXHThg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mwifiex: disable ps_mode explicitly by default instead
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Tsuchiya Yuto <kitakar@gmail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
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

On Thu, Oct 29, 2020 at 11:37 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> And this feeling (that it's a FW issue) what I have. But the problem
> here, that Marvell didn't fix and probably won't fix their FW...

Sure, I wouldn't hold your breath. So some of these tactics (disabling
PS, etc.) may be valid, but you have to do them smartly, acknowledging
that there are other (more stable) firmwares and chips in use for this
same driver.

> Just wondering if Google (and MS in their turn) use different
> firmwares to what we have available in Linux.

No clue about MS. But Chrom{e,ium} OS generally publishes all this
stuff where possible. You can see what we use here:

https://chromium.googlesource.com/chromiumos/third_party/linux-firmware/+/HEAD/mrvl/
https://chromium.googlesource.com/chromiumos/third_party/marvell/+/HEAD/

We try to stay somewhat in sync / parallel with "upstream"
linux-firmware, and strongly encourage vendors to send the same
binaries upstream when they hand them to us, but there are exceptions
and oversights (e.g., old products might have used a different
firmware branch).

Notably, I'll repeat: we (Chrome OS) don't actually support the PCIe
variant of 8897, so the report in question ("PCIe-88W8897") has no
equivalent in a supported Chrome OS system (even if there are binaries
in the links above, we don't use them). I would not be surprised if
there are an enormous number of firmware bugs there, as there were
initially for PCIe-88W8997 (which we do support).

Brian
