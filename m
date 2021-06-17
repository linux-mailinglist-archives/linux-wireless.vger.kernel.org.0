Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF173ABCBE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 21:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhFQTcN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhFQTcL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 15:32:11 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B383C06175F
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 12:30:02 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso7272468otj.4
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96aOqFV+Msept1aExEkb8x6Rqhfeyqwt0lWHBevMNvo=;
        b=oIB+8RnNPZyuKWRqD2bU8tkh/BghW1F0ppi6t9hKA1zF5buiMYjTkXkIhwTvmKhdxm
         IGq5N8xt3LwhgoEG6ydIYCuY/1sQwkMdTD8fQsrz0Be+jZIMtY+Vsq78m4XdWHmKznN1
         1c/XxoKiFU7kyNBAhN8hjv+3S0KhkfFo5cNok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96aOqFV+Msept1aExEkb8x6Rqhfeyqwt0lWHBevMNvo=;
        b=JMJG+mZns42Mpvu65dDr00KdDRD+P1E46af/JyvLQOCJ0IjAOqvOkXXcQ58OhJakYA
         25Np32C6t7TYnysanEP/oS8PNDd5DMXjlReNodnHKhRd96VGWn4BKKd4DnN80mtaN6hs
         KYuefFJKCOBIKyK7rjsvmfwjYv6UwgA7edzRbFB0I1S+6D2T9fZcCjYZzV7GIMmveOPV
         xpzjtWMg9SOBDFumBXL78CuJPwg+DOUGKZfR8ATzl8q3bmdFNGicSZg5ykZU8eG4UD5b
         yIOlnn8nVEoJ/aOluPZsZ3YSy1i8Mm80YYZApNUAJyXMY2epLzouLpkjQQ1V1Kqn61iu
         SBIg==
X-Gm-Message-State: AOAM531hLqa6FBx9lqgHU/gL+IettTac8GRkHcld0IKHxKLKTXxHFAJr
        RZUcc5p5/L8FwtVk2AQfzFKOml1iNToDJg==
X-Google-Smtp-Source: ABdhPJyR8DoXQGw58FtDmYaY6OoLO9ese3iYZa50JI/fTxiLK52xvs7I2ihTihQ50doaFRtykJSjRw==
X-Received: by 2002:a9d:3f0:: with SMTP id f103mr5725287otf.182.1623958201130;
        Thu, 17 Jun 2021 12:30:01 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id 3sm1508352otu.52.2021.06.17.12.30.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 12:30:00 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id s23so7712501oiw.9
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 12:30:00 -0700 (PDT)
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr11266904oih.105.1623958199878;
 Thu, 17 Jun 2021 12:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210617171522.3410951-1-keescook@chromium.org>
In-Reply-To: <20210617171522.3410951-1-keescook@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 17 Jun 2021 12:29:47 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOE2EgkiqyqkiXrUCMas+aVU1hJy4uDwafhWv6REjsefg@mail.gmail.com>
Message-ID: <CA+ASDXOE2EgkiqyqkiXrUCMas+aVU1hJy4uDwafhWv6REjsefg@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: Avoid memset() over-write of WEP key_material
To:     Kees Cook <keescook@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 17, 2021 at 10:15 AM Kees Cook <keescook@chromium.org> wrote:
>
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring array fields.
>
> When preparing to call mwifiex_set_keyparamset_wep(), key_material is
> treated very differently from its structure layout (which has only a
> single struct mwifiex_ie_type_key_param_set). Instead, add a new type to
> the union so memset() can correctly reason about the size of the
> structure.
>
> Note that the union ("params", 196 bytes) containing key_material was
> not large enough to hold the target of this memset(): sizeof(struct
> mwifiex_ie_type_key_param_set) == 60, NUM_WEP_KEYS = 4, so 240
> bytes, or 44 bytes past the end of "params". The good news is that
> it appears that the command buffer, as allocated, is 2048 bytes
> (MWIFIEX_SIZE_OF_CMD_BUFFER), so no neighboring memory appears to be
> getting clobbered.

Yeah, this union vs. the underlying buffer size always throws me for a
loop on figuring out whether there's truly a buffer overflow on some
of this stuff...

> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks like a valid refactor to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
