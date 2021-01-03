Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA542E89DB
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 02:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbhACBcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jan 2021 20:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbhACBcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jan 2021 20:32:12 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F0EC061573
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jan 2021 17:31:31 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id p7so12659793vsf.8
        for <linux-wireless@vger.kernel.org>; Sat, 02 Jan 2021 17:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGN25pyBFFn5jg2H18A+uS9Z8SjOOJtPGOyj6yaT+no=;
        b=iS7luekN3733Jlg6HBHKHoCmhqK8NpYy/oYmMsgc615UkQ9LMb7yXY6GSkMZQJaDL/
         b3HOjH33G5b1FGmRTeJiAujj24SADxPerAC2617kxonQ3Ene+sVNYqO2D3V9kmHT1YZ0
         m8Ykuvsa2pyf3VmUJOUAkB4eOHJGu+8mz9K+nMNGY1bvR2ry4zK0JbIsEFpt/oBfzUG7
         PZ+N74wusMI3qx9shkAcYA9H/kLw1Zj/XCHriJa0vwvxfHP21/Boiu8sKTwsNPZe91/E
         xXinNhBU2iV3Wfh2DNv0JAqxaawc7ANBdjvEKg02jBub+XU3DMEAd1XgJ4KOgD9RmAm1
         HtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGN25pyBFFn5jg2H18A+uS9Z8SjOOJtPGOyj6yaT+no=;
        b=bfwdgFTF0L9j553I1kCxOr2JMh2t34Z5/A7PlYr5yMC0UGU32PLvHNWmMO172ceU9f
         hg2KjF6KXtiWLvwm1vxQT0j1slrUqr73dLLReCkjFNSFTQQcU/XmzV55mGYvXmHxRsIs
         hj+G3BydU/Lcl96rLvWx/ZPRa3O+ycFrluy2JyGSJLr/5rB/2veiYs8NcNWrcpyngdoZ
         fd4BACHe+gOgpXvALaj8lRebrl4X/RcdYgiphiT/VKSoparmUCsY5+bNYuHLB3eUgfgL
         99/j0XXIaE/9q+ri0P91eacZaLL+MJDZpyDlwo0Qmk3Vl1ZVqgMC+rueyZUhLcinJ+be
         ICqg==
X-Gm-Message-State: AOAM531aYjLX2fVcn2gm46PgMS36hGXmib05JXttIslVxYg0NnXDldIx
        xofyT6iWUUZ12t0wnGMCx2k2QXjW86+7WlPNRgA=
X-Google-Smtp-Source: ABdhPJxq8aBjipKPgu9bpDpiTw/HLHMg92HmpF2B8V/+2DFKBr7f3UcQPAzrewDCVJSDDVhIzOq1ujQtaZiQd0vt9kA=
X-Received: by 2002:a67:32c5:: with SMTP id y188mr38982565vsy.4.1609637490848;
 Sat, 02 Jan 2021 17:31:30 -0800 (PST)
MIME-Version: 1.0
References: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
 <CA+icZUWcuka-6j139+89pSV5Z-r1fYVriz+wJE0gma4RO_PL9Q@mail.gmail.com>
 <CAM+r-Rj3y6DGonMPQ_V7qCwWH7v1bgh5x7YmAzMh5-cY68jJiw@mail.gmail.com> <CA+icZUXkwN=WT+hOop2WjwdVOp8UB93XKd07KB_EdCP5U_znsg@mail.gmail.com>
In-Reply-To: <CA+icZUXkwN=WT+hOop2WjwdVOp8UB93XKd07KB_EdCP5U_znsg@mail.gmail.com>
From:   Luca Versari <veluca93@gmail.com>
Date:   Sun, 3 Jan 2021 02:31:04 +0100
Message-ID: <CAM+r-RgHsVSOjH8+2jaw6xJAm=ykcJa8Mw65jOma=w_yDyt5hA@mail.gmail.com>
Subject: Re: [BUG] Stacktrace in ath11k_pci
To:     sedat.dilek@gmail.com
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I can confirm I have the latest firmware installed (same sha256sum).

On Sun, 3 Jan 2021 at 01:34, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Jan 3, 2021 at 1:18 AM Luca Versari <veluca93@gmail.com> wrote:
> >
> > Thanks for the quick reply!
> > Unfortunately, this didn't seem to work - I'm still getting the same
> > stack trace:
> >
>
> Latest ath11k firmware?
>
> - Sedat -
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/ath11k
