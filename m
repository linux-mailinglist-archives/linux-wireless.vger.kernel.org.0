Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0623E2AFC3A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 02:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgKLBdy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 20:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgKLAYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 19:24:18 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1877AC0613D6
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 16:24:18 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so4224582edt.9
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 16:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZOp5Jr6cZlC4xp3NAg+PB14J3dIwu9WQfGFtPcdmaE=;
        b=ZznHLKx5zl8gWvTEtPap5Z/+v2jU8+Y6YeirYmGlw06CX1hWrL5Or9l90VwmfesrPo
         Zxk8M597reWTuKTSZ8cZ64lVXkEimnbwXciSSMFEoaTizuk+hJ0enV4ux6hIz0WU/MFX
         3OpedyssEnGkVd9VeqIOfrbbNPGoZBR7+2SePKYtb/WiwXwqMoD30NGukdVBJNgy9taF
         nYEDGjYObMla73UuuCqaTFcCkHN+EVr2ELBW7+IQFvDLwtIpQb4KbRTnbsn/EueFRrEW
         qgOuJJDmQkAfKMUnKS0R35BwztOukv1ovbfqDvqlcxTkWhqEhUCXjKFEcD48MFb2+tzu
         HvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZOp5Jr6cZlC4xp3NAg+PB14J3dIwu9WQfGFtPcdmaE=;
        b=q4AZau6ddpQmcvRHJaDgI3YHu5wT/MV/doKBb/WWEZjiOSq1RvOvm+UEMlj7jMbq5g
         ioVEVgUkVJBHOgSSAGDxnna7h8qKNnzONv4QaPHUPCYUk6/6dRlybiPd3SuOP5hFWfvl
         s/m2/KoCLEHembezew3MlEAybuahD7JUHyBNurfBUjar2Zo1dAbbUTCpMDjWXqupfD1P
         weZddkgYDTHy1mEUsiB+CbaZ3bCjM2q+pzHpJbDu70OnYkiHuBHXDSOSN/7lhK3Md3O1
         /TbDZLQ3y2sxuSpjYlYZdiNWi331dx55+YWO/N8qCbhgZsYtyGo/gonJkS5yJZ7zAS4p
         ofpw==
X-Gm-Message-State: AOAM5311wOqh/r8PcU73TVZMQ5VRRri4P8yss4tUy8YFS3qYS0d5+w9e
        Dch/bH9TUFmD0eEfsfJ5Ga6R7w9jB4X0DI1QpV7Xig==
X-Google-Smtp-Source: ABdhPJw4AX4Vribc9BcKKKAgkcFqB1CeXwp3aMfylykGNsxg2kCJuNkCa91ymrxGstvOGz+MdDpnoIl3GB5ubqvvy9I=
X-Received: by 2002:a50:8245:: with SMTP id 63mr2343561edf.133.1605140656767;
 Wed, 11 Nov 2020 16:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de> <87mtzxkus5.fsf@nanos.tec.linutronix.de>
 <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de> <87v9ec9rk3.fsf@codeaurora.org>
 <87imab4slq.fsf@codeaurora.org> <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
In-Reply-To: <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
From:   wi nk <wink@technolu.st>
Date:   Thu, 12 Nov 2020 01:24:05 +0100
Message-ID: <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Stefani Seibold <stefani@seibold.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Thomas Krause <thomaskrause@posteo.de>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        Devin Bayer <dev@doubly.so>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 11, 2020 at 11:02 PM Stefani Seibold <stefani@seibold.net> wrote:
>
> On Wed, 2020-11-11 at 21:10 +0200, Kalle Valo wrote:
> >
> > The proof of concept patch for v5.10-rc2 is here:
> >
> > https://patchwork.kernel.org/project/linux-wireless/patch/1605121102-14352-1-git-send-email-kvalo@codeaurora.org/
> >
> > Hopefully it makes it possible to boot the firmware now. But this is
> > a
> > quick hack and most likely buggy, so keep your expectations low :)
> >
> > In case there are these warnings during firmware initialisation:
> >
> > ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> > ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> >
> > Try reverting this commit:
> >
> > 7fef431be9c9 mm/page_alloc: place pages to tail in
> > __free_pages_core()
> >
> > That's another issue which is debugged here:
> >
> > http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html
> >
>
> Applying the patch and revert patch 7fef431be9c9 worked on the first
> glance.
>
> After a couple of minutes the connection get broken. The kernel log
> shows the following error:
>
> ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
> ath11k_pc
> i 0000:55:00.0: failed to enable PMF QOS: (-11
>
> It is also not possible to unload the ath11k_pci, rmmod will hang.
>
>

I can confirm the same behavior as Stefani so far.  After applying the
patch, and reverting commit 7fef431be9c9, I am able to connect to a
network.  It hasn't disconnected yet (I'm sending this email via that
connection).  I'll report what I find next.

Thanks again for the help!
