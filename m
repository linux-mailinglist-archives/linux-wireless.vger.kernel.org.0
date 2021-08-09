Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268E03E4E62
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 23:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhHIVYm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 17:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbhHIVYl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 17:24:41 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046DC06179A
        for <linux-wireless@vger.kernel.org>; Mon,  9 Aug 2021 14:24:20 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id y23-20020a4a62570000b029028727ffa408so2781724oog.5
        for <linux-wireless@vger.kernel.org>; Mon, 09 Aug 2021 14:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x7djV8cU9LbMV7kajT88pgm0cyo38YSmnH16cnh0+6c=;
        b=IQnIucvNHK0pfJNN2pnmEFU/wNLWyA3Qq2owDANrdlt2wnUmmlqmJ0h0UzI5GV53Xj
         SmkwwalgbcnonkWR2ftVHdWq6N5PvSo8LlW2U2q4z6uZbJefgvN7lGVojUr4edep6OW1
         P7RW6Su7ZYx3s8DWXw1RQRIJYFZu4e7KY9qfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x7djV8cU9LbMV7kajT88pgm0cyo38YSmnH16cnh0+6c=;
        b=fShKRV95WTjJhvPvLZDRSCkR+T1FnHuTpDzpWjcilLZKrxmByXnf4xu33tXCJRRebn
         ipMnoHYTzQXLPIJ1I3k8jgx+Icg2gkcweOAQyDQyh2Ui5iKRHI7bSxqm2Pp4SVLQW5/q
         qIW8uJYbE3ZlE4zNfrsYyzFeG7tMn6psPYB0YADR863YsAtVt57hLhNLNXmsGFwW7fsG
         9UfGu9RrMKTEowGfisLYBSgpdsZVYo7a15kKFmkSDbAMoxBuUk2ZGNGYw/1/iV5EYYOy
         tuA+gNJX1L313V2/rDvxnpE/6HdyzUKBh2ztYnCT0HE6NpM/zNS1ZEEkjGmG9we9vqgv
         9N3w==
X-Gm-Message-State: AOAM533SsEQ1VDrETWcMcOuTUs1vrpMh4cl5dff9X6n+pFgMV1YWYeGr
        A4jJTFOovgFRb4cM/KjufMKxs4CjzYnH5g==
X-Google-Smtp-Source: ABdhPJzeytFrL2glheaAZQCgQtC5yMiN6yg0zK5yAi3s+L+6SSSiToeHRoXXMsMJEg5tIr1GAMT1sg==
X-Received: by 2002:a4a:2c96:: with SMTP id o144mr13276221ooo.50.1628544259463;
        Mon, 09 Aug 2021 14:24:19 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id s10sm2421711oog.14.2021.08.09.14.24.18
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 14:24:18 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so4770412ooc.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Aug 2021 14:24:18 -0700 (PDT)
X-Received: by 2002:a4a:4c55:: with SMTP id a82mr16548740oob.66.1628544258286;
 Mon, 09 Aug 2021 14:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210809211134.GA22488@embeddedor>
In-Reply-To: <20210809211134.GA22488@embeddedor>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 9 Aug 2021 14:24:07 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO+GbP_WWVdO0=Uavh036ZhZiziE8DwGRKP-ooofd2QVw@mail.gmail.com>
Message-ID: <CA+ASDXO+GbP_WWVdO0=Uavh036ZhZiziE8DwGRKP-ooofd2QVw@mail.gmail.com>
Subject: Re: [PATCH][next] mwifiex: usb: Replace one-element array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 9, 2021 at 2:08 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these c=
ases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
>
> This issue was found with the help of Coccinelle and audited and fixed,
> manually.
>
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-le=
ngth-and-one-element-arrays
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

An important part of your patch rationale should include determining
that the 1-length wasn't actually important anywhere. I double checked
for you, and nobody seemed to be relying on 'sizeof struct fw_data' at
all, so this should be OK:

Reviewed-by: Brian Norris <briannorris@chromium.org>
