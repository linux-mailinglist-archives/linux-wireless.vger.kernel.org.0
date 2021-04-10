Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E580935AB8B
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Apr 2021 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhDJHA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Apr 2021 03:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJHAZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Apr 2021 03:00:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4F0C061762;
        Sat, 10 Apr 2021 00:00:11 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id v26so8182968iox.11;
        Sat, 10 Apr 2021 00:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+qU2K2MTxemBysOAaAel00sT0k/PXV6IjQavtJSZP4=;
        b=XilqbwzTDmRoEmZ6zQy+MRJEIeYKyOHHAC16Zl3Us6SEoaR1anZ4fT5hvmEMIjIF+Z
         7LIT3HjQJH9SEKIBcYLK8qE26xt9DS9noGPt71wHnKgJ2IGqfvXIUv62ajy92+6SWLRH
         xaHkniLAV9eEnwhRwW8h9mFBzGA359itdV/k0EmtrxzOEJJHz+UR3X6uTgV9B4hLyPVG
         IeUSdS/D1plsFRtEZYytDk7bogOy4geia81tn3VpT/pp9X5buJB9yPoujgs9YcSXsy+O
         EUwPdbGdteAaXj4FW2PfHASjtFO25YqSIYNh6YiHE/BsM9C/LPbxg2dxpKI4QctbKYbB
         abWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+qU2K2MTxemBysOAaAel00sT0k/PXV6IjQavtJSZP4=;
        b=qfRB7CckvF+SY2/Q5sLsf7seQXZZcSY5JH5n2QbRjM7i6Ixek22mJ9xZG7vrj5h4Yy
         49CZOq9vmxP9dojJcLW67OiL4fFYsprCitaQntprQBs12CGr4wS+WzbtHzfpRHn7QOJE
         lbs/TCvspcrHkkozt1CJAa5WCOXxFis83AziMUlU+h0pjOVbfRLk/KqPXFplxXmYSofU
         WP1TdkQLoBLQaaFf4d0fKHh4g2C6E5yHS/kH8e5E7f6aR+l4AClVvLgSztg1fDcuxk7D
         V/KG3M58YV+8Z1I7SLQzIv6K79mp+S/TIHRQ3jbU8qvprBJC/U0xl9jVkc2NL3V6bqeu
         ZKsg==
X-Gm-Message-State: AOAM531VD6ZBliPTCUzcbi715Qd7Pxm88qY7UIN24Rjg6N5bYZbUUHEV
        6Dim7wdvAeGuL3OVVfSf5xToE6icl4gPGpIEvSI=
X-Google-Smtp-Source: ABdhPJzX7dnw0bl/nBvHDpveje13mmDlU01z0s3B+jkqD01lF3gYiWxJ/q00iPXHYNNN1kkhj+KhHq79RK4dgy72RNg=
X-Received: by 2002:a02:7410:: with SMTP id o16mr18527890jac.37.1618038011076;
 Sat, 10 Apr 2021 00:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <YD4enB/Er/5PWgUz@mwanda>
In-Reply-To: <YD4enB/Er/5PWgUz@mwanda>
From:   Stanislav Yakovlev <stas.yakovlev@gmail.com>
Date:   Sat, 10 Apr 2021 10:59:49 +0400
Message-ID: <CA++WF2PBo1Mok+bnnUCEZxbbEacX7FcU7PYAPTo=iqgOb2+f3Q@mail.gmail.com>
Subject: Re: [PATCH] ipw2x00: potential buffer overflow in libipw_wx_set_encodeext()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Jeff Garzik <jgarzik@pobox.com>,
        James Ketrenos <jketreno@linux.intel.com>,
        wireless <linux-wireless@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2 Mar 2021 at 15:16, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "ext->key_len" is a u16 that comes from the user.  If it's over
> SCM_KEY_LEN (32) that could lead to memory corruption.
>
> Fixes: e0d369d1d969 ("[PATCH] ieee82011: Added WE-18 support to default wireless extension handler")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/wireless/intel/ipw2x00/libipw_wx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Cc: stable@vger.kernel.org
Acked-by: Stanislav Yakovlev <stas.yakovlev@gmail.com>

Thanks, and sorry for the long review.

Stanislav.


> diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
> index a0cf78c418ac..27f15fa40528 100644
> --- a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
> +++ b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
> @@ -633,8 +633,10 @@ int libipw_wx_set_encodeext(struct libipw_device *ieee,
>         }
>
>         if (ext->alg != IW_ENCODE_ALG_NONE) {
> -               memcpy(sec.keys[idx], ext->key, ext->key_len);
> -               sec.key_sizes[idx] = ext->key_len;
> +               int len = min_t(int, ext->key_len, SCM_KEY_LEN);
> +
> +               memcpy(sec.keys[idx], ext->key, len);
> +               sec.key_sizes[idx] = len;
>                 sec.flags |= (1 << idx);
>                 if (ext->alg == IW_ENCODE_ALG_WEP) {
>                         sec.encode_alg[idx] = SEC_ALG_WEP;
> --
> 2.30.1
>
