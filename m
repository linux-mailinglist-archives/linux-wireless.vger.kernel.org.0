Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304A83E4C8D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 21:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhHITCT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 15:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhHITCT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 15:02:19 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B063C0613D3
        for <linux-wireless@vger.kernel.org>; Mon,  9 Aug 2021 12:01:58 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t128so25037904oig.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Aug 2021 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8f3q3KSUzSCoA+ilO+x9/xXUDy5ChKZccg3SbF0FPc=;
        b=akAKuokMuV6Ptre8t6P5fnkXdykHsE6PdZVLYHUj+m6KulfjgNbPR+kxid2wlcSuqr
         +AbbhHiuHD8FkvS4iMprOGUlspFHGPFlp/GvIVzbTVLbkLaj77877rY/1RJFzfhHGA3u
         Bl+eZBOIpbPrgpF2mxB5XtkCtEK3HVsOobGE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8f3q3KSUzSCoA+ilO+x9/xXUDy5ChKZccg3SbF0FPc=;
        b=ovS/jY7oPGLEXqxp+Xzd3uk1YZYI45/dLkt02PDNrwkt/CFVki9fu/kW75mng+yef/
         GtuIEbWItgJTl72UTwV9zktj0QSBCXqLaylSj+6aZ+73zqMWmHpCA9UFpuhfzVfozxg6
         HI1ziaAHnucd5fffbcFn9952d+DiLxODQm83paPjobH1c6ap7LYMY8eBiy2OEDT8F4lR
         VMCHU7NhlszTxf2HKyOyDITlLbVoIdDB5ZEniZEdZxerHYmMDfTtWyoWwv4ff7sB6u7J
         PIW0FVNDgvh0iNr5OrDBnB5dbCQ+l87B8gE6jhhS97HoxiGU5+MW+xyzACNcX+bawBeP
         Hr8Q==
X-Gm-Message-State: AOAM532XwiVIMMYgsBdj+zQJ1aAmzr0ZSBERKtInFKQueevhw/30HJ+B
        /5kiDmZAjt5FcPBy+IiB27REJ7pau/F1gw==
X-Google-Smtp-Source: ABdhPJxD88ZdcGrxTBIJzPO3YOJhgeCa48OZOUScHZb7a3q1xMGNwPUYUzRd+DpxkGrfJnubDy9vEw==
X-Received: by 2002:a05:6808:641:: with SMTP id z1mr519099oih.108.1628535717534;
        Mon, 09 Aug 2021 12:01:57 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id s35sm3416174otv.44.2021.08.09.12.01.56
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 12:01:56 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id bi32so1174019oib.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Aug 2021 12:01:56 -0700 (PDT)
X-Received: by 2002:aca:5344:: with SMTP id h65mr477047oib.117.1628535716232;
 Mon, 09 Aug 2021 12:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <3PGKXQ.OUNHZGPTI7091@ixit.cz>
In-Reply-To: <3PGKXQ.OUNHZGPTI7091@ixit.cz>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 9 Aug 2021 12:01:45 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOHFijzJeRFEFy6okgNYNZKdc6HZtzZ9-6mdkYEfzL-2g@mail.gmail.com>
Message-ID: <CA+ASDXOHFijzJeRFEFy6okgNYNZKdc6HZtzZ9-6mdkYEfzL-2g@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: fix wmi mgmt tx queue full due to race condition
To:     David Heidelberg <david@ixit.cz>
Cc:     Miaoqing Pan <miaoqing@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(NB: I think your Reply-To header was wrong, so I've chosen to modify
that in hopes of actually reaching you.)

On Mon, Aug 9, 2021 at 2:52 AM David Heidelberg <david@ixit.cz> wrote:
> since I noticed this issue is very common (at least for me and some
> others) on 4.14 kernels [1] [2] would you think that backporting this
> patch into stable would make sense? I assume that at some point it
> could help some OpenWRT/LEDE and other devices (since for Turris it'll
> be most likely backported anyway).
>
> Thank you for the working on this!
> David
>
> [1]
> https://forum.turris.cz/t/5-2-4-patch-wifi-fails-after-while-wmi-mgmt-tx-queue-is-full/15510
> [2] https://forum.turris.cz/t/unstable-wifi-on-mox-b/11065/

Seems reasonable to me. The right way to submit such a request is
documented here:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Because this wasn't identified as a -stable candidate when first
submitted, you'll need either Option 2 or Option 3.

Regards,
Brian
