Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D33D7D43
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 20:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhG0SQa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 14:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhG0SQa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 14:16:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2914C061757
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 11:16:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a19so344166oiw.6
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vco8IpmvI6e4OgtXcayTW8PQqRayAHHPZ/9BbWzucA4=;
        b=KN7/6VIjU3/F+4L3/EZyEx+FP90Tprwrv0m8vVXi0CnormS05ojsXWgodoDjclStRp
         v/rpN6F23Yvjn1GdoYiP+07pe7wyKSbASEi3wA4Yjn12db1j57L2AK/nB9edsXDJ0oph
         c2q6vRz4lc9woO8aP3+5WrZpsIHK5vJY5GbXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vco8IpmvI6e4OgtXcayTW8PQqRayAHHPZ/9BbWzucA4=;
        b=Y1xAVA+2BK/z2Yjfuq27RSvksxqSNAs4yOkKjqDIq9NUe5ZTVGeQUfVZakA41kYdiP
         8YwxrzcBbfckilQ5gn5o57BE+OSK+ALti3kfoLPAUIw8tCFPeCFJTUI1N+1J7W/PI2XY
         fZWSi1zhZ4QonNkiS50FXBBPt953j1mnyU2uG1uZjfpWCVVkLBBaqtvar2fdMiqIUlEo
         pNOOcerEwekmqzrU2/Q6DmpMx3ZwU90PWzlYWUl3FRyCT/nVSJPf2E/cvNEB6wv4FQ/W
         HfXwJU9F76jxhDWls+ZVWF/jbykccY3qlcTtIT9178xJ+ALIdOvHJB2xCW7WGpJxuvVB
         flEw==
X-Gm-Message-State: AOAM533pBitUwExrbt9gH8WCRolPA9X+NKDiy9KKGIWHb9QWfdqkt/O5
        zXEdYJ8eJDS41puVyQeaCEkPrlIJH6087g==
X-Google-Smtp-Source: ABdhPJxll0h7rILm8+Gj9u4fSP4WyA3M2+6/110Mhc3WU5BpsK2JQLZC2RdaK9D3rQzqBQ5G00te6A==
X-Received: by 2002:aca:d406:: with SMTP id l6mr3698762oig.7.1627409784585;
        Tue, 27 Jul 2021 11:16:24 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id i16sm666814oie.5.2021.07.27.11.16.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 11:16:23 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id o20so304946oiw.12
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jul 2021 11:16:22 -0700 (PDT)
X-Received: by 2002:aca:304f:: with SMTP id w76mr3634238oiw.77.1627409782401;
 Tue, 27 Jul 2021 11:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210718084202.5118-1-len.baker@gmx.com> <87eebkgt8t.fsf@codeaurora.org>
In-Reply-To: <87eebkgt8t.fsf@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 27 Jul 2021 11:16:11 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNm_aKAJcJVCx45VqAXTgXjfOju7xZPa_3MAvBzn2r7_w@mail.gmail.com>
Message-ID: <CA+ASDXNm_aKAJcJVCx45VqAXTgXjfOju7xZPa_3MAvBzn2r7_w@mail.gmail.com>
Subject: Re: [PATCH v3] rtw88: Remove unnecessary check code
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 26, 2021 at 11:34 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Len Baker <len.baker@gmx.com> writes:
>
> > The rtw_pci_init_rx_ring function is only ever called with a fixed
> > constant or RTK_MAX_RX_DESC_NUM for the "len" argument. Since this
> > constant is defined as 512, the "if (len > TRX_BD_IDX_MASK)" check
> > can never happen (TRX_BD_IDX_MASK is defined as GENMASK(11, 0) or in
> > other words as 4095).
> >
> > So, remove this check.
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
>
> Are everyone ok with this version?

I suppose? I'm not really sure where the line should be drawn on
excessive bounds checking, false warnings from otherwise quite useful
static analysis tools, etc., but I suppose it doesn't make much sense
to add additional excess bounds checks just to quiet Coverity.

It might be nice to include the true motivation in the patch
description though, which is: "this also quiets a false warning from
Coverity".

Anyway, feel free to pick one of these:

Shrug-by: Brian Norris <briannorris@chromium.org>

or

Reviewed-by: Brian Norris <briannorris@chromium.org>
